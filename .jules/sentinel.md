# Sentinel Security Journal

## 2025-05-14 - Command Injection Risk in Shell Sinks
**Vulnerability:** Shell scripts like `speak.sh` reading from external files (e.g., `GEMINI_BRAINROT.md`) and passing variables to commands within double quotes are vulnerable to command injection via command substitution (e.g., `$(command)`).
**Learning:** While double quotes prevent word splitting, they still allow expansion and substitution. Relying on the format of external files without validation is a fragile security pattern.
**Prevention:** Always validate external inputs for shell metacharacters (`\`, `` ` ``, `$`, `;`, `&`, `|`, `"`) before passing them to sensitive sinks, and use `set -euo pipefail` for safer script execution.
