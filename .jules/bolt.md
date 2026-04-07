## 2026-04-07 - Recursive Search Optimization in Asset-Heavy Repos
**Learning:** Recursive `grep` operations that don't exclude large binary asset directories (like `media/`, `archives/`) or metadata (like `.git/`) suffer from significant latency. In this repository, excluding these reduced execution time from ~1.1s to ~0.03s.
**Action:** Always use `--exclude-dir={.git,node_modules,media,archives}` (or equivalent for other tools) when performing recursive searches in repositories known to contain large non-text assets.
