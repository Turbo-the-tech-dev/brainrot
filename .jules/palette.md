## 2025-03-31 - Terminal UI Accessibility Pattern
**Learning:** Text-only, terminal-style interfaces are often just a single `<pre>` tag which is completely opaque to screen readers. By using `role="main"`, `role="progressbar"`, and `aria-hidden` on ASCII-only decorations, we can make these nostalgic interfaces fully accessible without changing their visual charm.
**Action:** Always wrap ASCII-only UI elements (separators, status bars) in `<span aria-hidden="true">` and provide semantic equivalents using ARIA roles and labels within the `<pre>` container.
