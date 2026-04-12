## 2026-04-12 - Command Injection in TTS Script
**Vulnerability:** The `speak.sh` script read the last line of `GEMINI_BRAINROT.md` and passed it directly to a shell command (`termux-tts-speak`) inside double quotes. This allowed arbitrary command execution if the input contained shell metacharacters like `$()` or `` ` ``.
**Learning:** Even when variables are double-quoted, they are still subject to command substitution and variable expansion. Input from external files must be strictly validated before being used in shell commands.
**Prevention:** Implement a validation gate using `grep` to reject shell metacharacters (`\`, `` ` ``, `$`, `;`, `&`, `|`, `"`) from untrusted input. Use `printf` instead of `echo` for safer output handling.
