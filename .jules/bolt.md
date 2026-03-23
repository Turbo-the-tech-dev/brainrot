## 2026-03-23 - [Optimized Recursive Grep in Audit Scripts]
**Learning:** In repositories with large binary assets (media) or deep metadata (.git), recursive `grep` operations become a major bottleneck. Using `--exclude-dir` at the `grep` level is significantly faster than piping to `grep -v` because it prevents the tool from entering and reading the contents of those directories entirely.
**Action:** Always use `--exclude-dir={.git,node_modules,archives,media,...}` for recursive searches in scripts to ensure high-velocity execution as the repository scales.
