## 2026-03-11 - Fixed Command Injection in speak.sh
**Vulnerability:** Input derived from an external file (`GEMINI_BRAINROT.md`) was passed directly to a command within double quotes in `speak.sh`, allowing for command substitution via backticks (`` ` ``) and `$()`.
**Learning:** Even within double quotes, shell metacharacters can be evaluated, leading to critical command injection vulnerabilities when input is sourced from files that can be modified by other processes or users.
**Prevention:** Implement a strict validation gate for inputs before they are used in any command. In shell scripts, use `grep` or similar tools to reject inputs containing characters that trigger command evaluation (`` ` ``, `$()`).
