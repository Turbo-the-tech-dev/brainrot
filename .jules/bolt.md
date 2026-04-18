# ⚡ Bolt Performance Journal

## 2025-05-14 - Maintenance Script Optimization
**Learning:** Recursive operations in repositories with large binary assets or deep history (`.git`, `media`, `archives`) suffer significantly if these directories aren't explicitly pruned. GNU Grep's `--exclude-dir` is much faster than piping to `grep -v`. Portable `find` pruning is more efficient than filtering results after they are generated.
**Action:** Always exclude `.git`, `node_modules`, and known large asset/archive directories in maintenance and audit scripts to maintain high velocity.
