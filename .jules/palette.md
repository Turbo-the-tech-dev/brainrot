## 2026-05-21 - Accessible Terminal Patterns

**Learning:** Terminal-style UIs often lack semantic meaning. ASCII art and separators should be hidden from screen readers to reduce noise. Key landmarks like `<main>` are essential for navigation. Cryptic filenames in links require `aria-label` for clarity, and visual progress bars need `role="progressbar"` with appropriate ARIA attributes.

**Action:** Always wrap terminal content in `<main>`, hide decorative ASCII with `aria-hidden="true"`, and provide descriptive `aria-label` for cryptic links or data visualizations.
