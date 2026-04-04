## 2025-05-15 - [Terminal UI Progress Bar Accessibility]
**Learning:** Text-only progress bars (e.g., `[|||||..] 84%`) in terminal-style interfaces are opaque to screen readers. Wrapping them in a `<span>` with `role="progressbar"` and appropriate `aria-valuenow`, `aria-valuemin`, and `aria-valuemax` attributes provides a semantic way to communicate the state without breaking the visual ASCII aesthetic.
**Action:** Always identify visual-only indicators in `<pre>` blocks and wrap them in semantic ARIA spans to ensure accessibility for assistive technologies.
