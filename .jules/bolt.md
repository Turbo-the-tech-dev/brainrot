## 2026-03-28 - Optimize Recursive Grep in Audit Scripts
**Learning:** In repositories with large media directories or deep version control history, recursive `grep` can become a significant bottleneck. Excluding `.git`, `node_modules`, and large asset directories like `media/` or `archives/` can reduce execution time of audit scripts by orders of magnitude (e.g., from ~1.2s to ~0.02s).
**Action:** Always use `--exclude-dir={.git,node_modules,media,archives}` when performing recursive searches in scripts to ensure they remain fast as the repository grows.
