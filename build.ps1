<#
.SYNOPSIS
    Build (and optionally install) the addon locally.

.DESCRIPTION
    Releases are built on GitHub by the BigWigs packager when a vX.Y.Z tag is
    pushed (.github/workflows/release.yml). This script is the local equivalent
    for testing in game.

    The addon name is the name of the .toc file in this folder. The version is
    "## Version:"; the packager token @project-version@ is replaced with
    `git describe` (or "dev" outside git). Only files the TOC loads plus the TOC,
    Bindings.xml, README.md, LICENSE and CHANGELOG.md are packaged, so tests and
    tooling never ship.

    1. Lua syntax check (needs Node.js + npm package luaparse)   -SkipChecks to skip
    2. Scenario tests against a mocked WoW API (needs Python + lupa)  -SkipChecks to skip
    3. dist\<Name>-<version>.zip (staged in %TEMP%\build-<Name>)
    4. -Install: mirror the staged folder into <WowPath>\Interface\AddOns\<Name>
       (replaces that one addon folder only, removing files the TOC no longer lists)

.EXAMPLE
    .\build.ps1
    .\build.ps1 -Install
    .\build.ps1 -Install -WowPath "D:\Games\World of Warcraft\_forever_"
#>
param(
    [switch]$Install,
    [string]$WowPath = "C:\Program Files (x86)\World of Warcraft\_forever_",
    [switch]$SkipChecks
)
$ErrorActionPreference = "Stop"
$root = $PSScriptRoot

$toc = Get-ChildItem -Path $root -Filter *.toc | Select-Object -First 1
if (-not $toc) { throw "No .toc file in $root" }
$name = $toc.BaseName
$version = (Select-String -Path $toc.FullName -Pattern '^## Version:\s*(.+)$').Matches[0].Groups[1].Value.Trim()
if ($version -eq "@project-version@") {
    $version = "dev"
    if (Test-Path (Join-Path $root ".git")) {
        $d = git -C $root describe --tags --always --dirty 2>$null
        if ($LASTEXITCODE -eq 0 -and $d) { $version = $d.Trim() }
        $global:LASTEXITCODE = 0
    }
}
Write-Host "Building $name $version"

# files the game loads, in TOC order, plus the docs that ship with it
$files = @($toc.Name)
# Bindings.xml is loaded by the game on its own; listing it in the TOC causes XML warnings
foreach ($extra in "Bindings.xml", "README.md", "LICENSE", "CHANGELOG.md") {
    if (Test-Path (Join-Path $root $extra)) { $files += $extra }
}
foreach ($line in Get-Content $toc.FullName) {
    $l = $line.Trim()
    if ($l -eq "" -or $l.StartsWith("#")) { continue }
    $files += $l
}
$missing = $files | Where-Object { -not (Test-Path (Join-Path $root $_)) }
if ($missing) { throw "Listed in the TOC but missing: $($missing -join ', ')" }

if (-not $SkipChecks) {
    Write-Host "Lua syntax check..."
    node (Join-Path $root "tests\syntax_check.js") $root | Where-Object { $_ -notmatch '^ok' }
    if ($LASTEXITCODE -ne 0) { throw "Syntax check failed" }
    Write-Host "Scenario tests..."
    python (Join-Path $root "tests\run.py") --quiet
    if ($LASTEXITCODE -ne 0) { throw "Tests failed" }
}

# stage in the temp folder (short paths: deep repo locations can exceed 260 characters)
$dist = Join-Path $root "dist"
New-Item -ItemType Directory -Force -Path $dist | Out-Null
$stageRoot = Join-Path ([IO.Path]::GetTempPath()) "build-$name"
$stage = Join-Path $stageRoot $name
if (Test-Path $stageRoot) { Remove-Item $stageRoot -Recurse -Force }
foreach ($f in $files) {
    $dest = Join-Path $stage $f
    New-Item -ItemType Directory -Force -Path (Split-Path $dest) | Out-Null
    Copy-Item (Join-Path $root $f) $dest
}
$stagedToc = Join-Path $stage $toc.Name
[IO.File]::WriteAllText($stagedToc, ([IO.File]::ReadAllText($stagedToc) -replace '@project-version@', $version))

$zip = Join-Path $dist "$name-$version.zip"
if (Test-Path $zip) { Remove-Item $zip -Force }
Compress-Archive -Path $stage -DestinationPath $zip
Write-Host "Packaged $($files.Count) files -> $zip"

if ($Install) {
    $addons = Join-Path $WowPath "Interface\AddOns"
    if (-not (Test-Path $addons)) { throw "AddOns folder not found: $addons" }
    $target = Join-Path $addons $name
    robocopy $stage $target /MIR /NFL /NDL /NJH /NJS /NP | Out-Null
    if ($LASTEXITCODE -ge 8) { throw "Install copy failed (robocopy $LASTEXITCODE)" }
    $global:LASTEXITCODE = 0
    Write-Host "Installed to $target - type /reload in game (restart the game for a new addon folder)."
}
