## 2026-03-10 - Shell Command Injection in Lore Aggregator
**Vulnerability:** Command injection and command chaining in `speak.sh` via the `GEMINI_BRAINROT.md` file.
**Learning:** Even when variables are wrapped in double quotes in a shell script, they are still vulnerable to command substitution (`$(...)` or `` `...` ``) and command chaining if not properly validated.
**Prevention:** Implement a strict validation gate using regex (`grep -qE '[\`$;&|\\"]'`) for any variable derived from external files before it is used in a shell command. Use `printf` instead of `echo` for safer handling of variable content.
