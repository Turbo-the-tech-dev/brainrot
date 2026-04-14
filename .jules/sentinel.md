## 2026-03-08 - Command Injection Prevention in speak.sh
**Vulnerability:** Potential command injection in `speak.sh` via unsanitized neural thoughts extracted from `GEMINI_BRAINROT.md`.
**Learning:** Even when variables are double-quoted in shell scripts, inputs derived from external files should be validated to prevent command substitution or chaining, especially when passed to external commands or utilities that might interpret them.
**Prevention:** Implement a security validation gate using `grep` to reject shell metacharacters (`\`, `` ` ``, `$`, `;`, `&`, `|`, `"`) from external inputs before processing. Use `set -euo pipefail` and `printf` for more robust and safer script execution.
