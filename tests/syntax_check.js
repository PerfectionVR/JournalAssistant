// Lua 5.1 syntax check of every .lua file in the addon (skips node_modules / dist / .git).
// Usage: node tests/syntax_check.js [root]      (needs: npm install --prefix tests)
const fs = require('fs'), path = require('path'), lp = require('luaparse');
const root = process.argv[2] || path.join(__dirname, '..');
const SKIP = new Set(['node_modules', 'dist', '.git']);
let bad = 0, n = 0;
function walk(d) {
  for (const f of fs.readdirSync(d)) {
    if (SKIP.has(f)) continue;
    const p = path.join(d, f);
    if (fs.statSync(p).isDirectory()) walk(p);
    else if (p.endsWith('.lua')) {
      n++;
      try { lp.parse(fs.readFileSync(p, 'utf8'), { luaVersion: '5.1' }); console.log('ok  ', path.relative(root, p)); }
      catch (e) { bad++; console.log('FAIL', path.relative(root, p), e.message); }
    }
  }
}
walk(root);
console.log(`${n - bad}/${n} files ok`);
process.exit(bad ? 1 : 0);
