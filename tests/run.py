"""Run the mocked-WoW scenario tests (tests/test.lua) with a Lua 5.1 runtime.

Usage:  python tests/run.py [--quiet]
Needs:  pip install lupa
The addon is loaded file by file in TOC order against tests/mock.lua, then the
scenarios in tests/test.lua run. Every scenario prints END<n> when it finished;
the run fails if one is missing or a Lua error was raised.
"""
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
EXPECTED = 22  # scenarios END2 .. END23

try:
    import lupa.lua51 as L
except ImportError:
    import lupa as L


def main():
    quiet = "--quiet" in sys.argv
    lua = L.LuaRuntime()
    lua.globals().TOOLS = HERE.replace("\\", "/")
    run = lua.eval('function(root) local fn = assert(loadfile(TOOLS .. "/test.lua")); fn(root) end')
    lines = []
    def lua_print(*args):
        lines.append("\t".join(str(a) for a in args))
    lua.globals().print = lua_print
    error = None
    try:
        run(ROOT.replace("\\", "/"))
    except Exception as e:  # LuaError
        error = e
    out = "\n".join(lines)
    if not quiet:
        print(out)
    ends = re.findall(r"^END(\d+)$", out, re.M)
    print("scenarios finished: %d/%d" % (len(ends), EXPECTED))
    if error:
        print("LUA ERROR:", error)
    ok = error is None and len(ends) >= EXPECTED
    print("OK" if ok else "FAILED")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
