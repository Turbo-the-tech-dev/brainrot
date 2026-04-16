
## 2026-04-16 - Recursive Search Bottlenecks
**Learning:** In repositories with large non-source directories (like .git, media, or archives), recursive searches (grep -r, find) can be orders of magnitude slower if they aren't explicitly excluded.
**Action:** Always use --exclude-dir for grep and -prune for find to skip large non-essential directories. Prefer multiple --exclude-dir flags over brace expansion for portability across shells.
