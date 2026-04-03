# SENTINEL'S JOURNAL - CRITICAL LEARNINGS ONLY

This journal is for recording critical security learnings, vulnerability patterns, and surprising gaps discovered in the Brainrot architecture.

Format:
## YYYY-MM-DD - [Title]
**Vulnerability:** [What you found]
**Learning:** [Why it existed]
**Prevention:** [How to avoid next time]

## 2026-03-11 - Shell Command Substitution in speak.sh
**Vulnerability:** Command injection via $(...) and backticks in GEMINI_BRAINROT.md input.
**Learning:** Even with double-quoted variables, shell metacharacters can cause execution of code from external files if not properly validated before usage.
**Prevention:** Always validate external inputs for shell metacharacters (`, $(, etc.) before using them in shell scripts, even if the usage appears safe behind quotes.
