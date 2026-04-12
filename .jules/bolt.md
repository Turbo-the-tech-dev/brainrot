## 2025-01-24 - Optimizing Repository-Wide Searches
**Learning:** Recursive `grep` and `find` operations are major bottlenecks in repositories with large non-source directories like `.git`, `media/`, or `archives/`. Excluding these directories using `--exclude-dir` for `grep` and `-prune` for `find` can lead to massive performance gains (e.g., 40x speedup).
**Action:** Always check for large metadata or asset directories and proactively exclude them from recursive searches in maintenance and audit scripts.
