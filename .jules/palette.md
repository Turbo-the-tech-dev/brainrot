## 2025-03-24 - [Terminal UI Accessibility]
**Learning:** Wrapping decorative ASCII in `<span aria-hidden="true">` inside `<pre>` blocks prevents screen readers from announcing long strings of symbols, improving UX for assistive technology without breaking fixed-width terminal layouts.
**Action:** Always use `aria-hidden` for ASCII borders and ARIA roles/labels for semantic regions in text-only/terminal-style web interfaces.
