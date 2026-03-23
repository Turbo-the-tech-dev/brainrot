## 2026-03-10 - [Terminal UI Accessibility]
**Learning:** For text-only/terminal UIs implemented in `<pre>` tags, adding `aria-hidden="true"` to decorative ASCII separators and using semantic ARIA `role="region"` or `role="navigation"` on content sections significantly improves the screen reader experience without breaking the visual layout.
**Action:** Use `<span>` tags within `<pre>` blocks to apply ARIA roles and labels to specific terminal output components (e.g., progress bars, status indicators, section headers).
