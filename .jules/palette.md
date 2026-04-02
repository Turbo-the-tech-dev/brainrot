## 2026-03-08 - [Improving Terminal UI Accessibility]
**Learning:** Terminal-style UIs that use `<pre>` tags and ASCII art are often inaccessible to screen readers because they read out every character of the decorators (e.g., "equals equals equals").
**Action:** Wrap decorative ASCII in `<span aria-hidden="true">` to skip them for screen readers, and use semantic ARIA roles like `role="main"` and `role="progressbar"` within the `<pre>` block to provide structure and meaning to the text. Use `aria-label` on links to provide context for cryptic filenames.
