## 2026-03-10 - Shell Input Validation Gate
**Vulnerability:** Potential command injection in `speak.sh` via unsanitized input from `GEMINI_BRAINROT.md`.
**Learning:** While double-quoting variables is a baseline, it doesn't prevent all forms of manipulation if the underlying command (like `termux-tts-speak`) might have its own parsing quirks or if the script is ever refactored to use `eval` or similar.
**Prevention:** Implement a proactive validation gate using a regex (`grep -qE '[`$;&|\\"]'`) to reject common shell metacharacters in strings derived from untrusted external files.
