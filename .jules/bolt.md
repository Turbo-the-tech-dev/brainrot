## 2026-03-08 - [Optimizing recursive grep]
**Learning:** Recursive grep calls in the root of a large repository can be extremely slow if they don't exclude large non-source directories like `.git`, `node_modules`, `media`, and `archives`. In this repository, adding `--exclude-dir` reduced execution time by 40-50x.
**Action:** Always use `--exclude-dir={.git,node_modules,media,archives}` for recursive grep operations in project automation scripts.
