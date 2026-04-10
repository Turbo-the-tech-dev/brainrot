## 2026-03-10 - Command Injection Hardening in speak.sh
**Vulnerability:** Command injection in `speak.sh` through unsanitized input from `GEMINI_BRAINROT.md`.
**Learning:** Double-quoting variables in shell scripts is a baseline for safety against word splitting, but it does not protect against command substitution (`$(...)` or `` `...` ``) or arithmetic expansion.
**Prevention:** Implement a robust validation gate using `grep` to reject shell metacharacters (`$` `` ` `` `;` `&` `|` `\` `"`) from variables derived from external files before they are used in sensitive contexts. Prefer `printf` over `echo` to avoid interpreting variable content as shell flags.
