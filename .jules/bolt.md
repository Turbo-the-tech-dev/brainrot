## 2025-05-14 - Optimize Recursive Searches by Excluding Non-Source Directories

**Learning:** Recursive `grep` and `find` operations in repositories with large binary assets (`media/`, `archives/`), metadata (`.git/`), or dependencies (`node_modules/`) suffer significant performance degradation. Excluding these directories leads to dramatic speedups (e.g., ~40x for `audit.sh`) and prevents irrelevant matches from third-party code. Avoiding brace expansion `{...}` ensures portability.

**Action:** Always use multiple `--exclude-dir` flags for `grep -r` and the `-prune` action for `find` to skip `.git`, `media`, `archives`, and `node_modules` when performing source-level audits.
