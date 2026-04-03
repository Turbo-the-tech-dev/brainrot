# Security Policy

## Reporting a Vulnerability

The Brainrot project takes security seriously. If you discover a security vulnerability, please report it immediately.

### Reporting Channels

Please report vulnerabilities via one of the following methods:

1.  **Private Vulnerability Reporting**: Use the GitHub "Report a vulnerability" button on the main repository page if available.
2.  **Direct Contact**: Reach out to @Turbo-the-tech-dev directly.

Do **not** open a public issue for security vulnerabilities.

## Disclosure Policy

When a vulnerability is reported, we will:

1.  Acknowledge receipt of the report within 48 hours.
2.  Work with the reporter to understand and validate the issue.
3.  Provide a timeline for a fix.
4.  Publicly disclose the vulnerability once a fix is available, crediting the reporter if desired.

## Security Hardening

This repository follows several security patterns:
-   **Input Validation**: All external inputs (e.g., `GEMINI_BRAINROT.md` for TTS) are validated against shell metacharacters.
-   **Data Integrity**: Telemetry output is decoupled from generation to ensure consistent schema and auditability.
-   **Defensive Coding**: Numeric inputs are range-checked to prevent calculation errors or DoS.
