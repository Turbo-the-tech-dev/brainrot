## 2026-04-13 - Recursive search optimization in audit scripts
**Learning:** In repositories with large non-source directories (e.g., .git, media, archives), recursive `grep` and `find` commands are significantly slowed down by scanning irrelevant files. In this repository, `.git` (259MB) and `media` (191MB) dominate the filesystem.
**Action:** Always use `--exclude-dir={.git,node_modules,media,archives}` for recursive `grep` and `-prune` for recursive `find` to skip large, non-essential directories. This reduced `audit.sh` execution time from 1.17s to 0.03s (~40x speedup).
