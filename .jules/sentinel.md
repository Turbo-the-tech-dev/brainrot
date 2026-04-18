# Sentinel Security Journal

## 2026-04-18 - Shell Command Injection in speak.sh
**Vulnerability:** Command substitution and command chaining via double-quoted variables in `speak.sh`.
**Learning:** While double quotes prevent word splitting and globbing, if the variable content is ever passed to an insecure sink (like `eval`, or a script that uses it), command injection can occur. In this repository, the `speak.sh` script takes input from `GEMINI_BRAINROT.md`, which could be community-contributed. Sanitizing this input to reject shell metacharacters is a critical defense-in-depth measure to prevent arbitrary command execution.
**Prevention:** Always validate or sanitize inputs derived from external files before passing them to shell commands. Use a regex to reject shell metacharacters. Use `set -euo pipefail` for better script robustness.
