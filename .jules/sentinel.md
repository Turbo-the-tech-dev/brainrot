## 2026-03-10 - Command Injection in lore aggregator
**Vulnerability:** The `speak.sh` script used double quotes around a variable derived from `GEMINI_BRAINROT.md` when calling `termux-tts-speak`. This allowed command substitution (e.g., `$(...)` or `` ` ``) within the manifesto to execute arbitrary commands.
**Learning:** Shell scripts using double quotes are still vulnerable to command substitution. Inputs from external files must be validated or sanitized before being passed to a shell command, even when quoted.
**Prevention:** Use a validation gate (e.g., `grep -qE '[\\`$;&|"]'`) to reject inputs containing shell metacharacters when passing them to an external command. Always use `printf "%s"` when piping to validation tools to avoid interpretation of flags.
