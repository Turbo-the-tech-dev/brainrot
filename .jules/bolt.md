## 2025-04-19 - [Directory Exclusion for Recursive Searches]
**Learning:** In repositories with large non-source directories (like .git, media, and archives), recursive grep and find calls can be up to 40x slower if these directories are not explicitly excluded.
**Action:** Always use --exclude-dir for grep and -prune for find to skip .git, node_modules, media, and archives in maintenance scripts.
