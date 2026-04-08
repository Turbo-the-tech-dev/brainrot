## 2025-05-15 - Accessible ASCII Terminal Interfaces
**Learning:** In terminal-style UIs where content is wrapped in `<pre>` tags, screen readers often struggle with decorative ASCII art and text-based progress bars. Using `aria-hidden="true"` on separators and `role="progressbar"` with semantic ARIA attributes on text indicators allows the UI to remain visually "retro" while being fully accessible.
**Action:** Always wrap decorative ASCII borders in `<span aria-hidden="true">` and provide descriptive `aria-label` attributes for links that use technical filenames as their text content.
