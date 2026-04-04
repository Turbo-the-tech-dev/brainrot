## 2026-03-11 - Input Validation & Command Injection Prevention
**Vulnerability:** Shell command injection in `speak.sh` via malicious markdown content; missing input range validation in `processor.py`.
**Learning:** External inputs (files, CLI arguments) must be treated as untrusted, even in "autonomous" or internal-only contexts.
**Prevention:** Implement strict validation gates using `grep` or regex for shell scripts and range/type checks for numeric calculations. Always exclude environment-specific artifacts like `__pycache__` via `.gitignore`.
