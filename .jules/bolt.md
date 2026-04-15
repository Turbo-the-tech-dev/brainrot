## 2026-04-15 - Directory Exclusions in Audit Scripts
**Learning:** Recursive `grep` and `find` calls in this repository are significantly slowed down by large non-source directories like `.git` (259MB), `media` (191MB), and `archives` (70MB).
**Action:** Always use `--exclude-dir={.git,node_modules,media,archives}` for recursive `grep` and `-prune` for `find` to maintain high performance in audit and maintenance scripts.
