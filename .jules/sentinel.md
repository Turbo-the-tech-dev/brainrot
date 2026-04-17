## 2026-03-10 - Content Security Policy Implementation via Meta Tags
**Vulnerability:** Potential Cross-Site Scripting (XSS) due to lack of resource loading restrictions.
**Learning:** Some CSP directives, specifically \`frame-ancestors\` and \`form-action\`, are ignored when delivered via a \`<meta http-equiv="Content-Security-Policy">\` tag and must be delivered via HTTP headers.
**Prevention:** Only use meta-tag compatible CSP directives in static HTML files and rely on server-side headers for comprehensive protection when available.
