## 2026-04-15 - Command Injection in shell scripts via external files
**Vulnerability:** The `speak.sh` script extracted the last line of a markdown file and passed it into a shell command using double quotes. This allowed for command substitution (`$(...)`) and other shell metacharacters to be executed.
**Learning:** Double quotes in shell protect against word splitting and globbing but still allow command substitution, variable expansion, and arithmetic expansion.
**Prevention:** Validate input derived from external or untrusted sources against a whitelist of allowed characters or a blacklist of shell metacharacters (e.g., using `grep -qE '[\\`$;&|"]'`) before passing it to any shell-executed command.
