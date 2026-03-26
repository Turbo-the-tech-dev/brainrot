## 2025-05-14 - ARIA Enhancements for Terminal-Style UIs
**Learning:** Terminal-style UIs that rely heavily on ASCII art and `<pre>` blocks require specific ARIA landmarks (`role="main"`, `role="navigation"`) and decorative hiding (`aria-hidden="true"`) to ensure they are navigable by screen readers without cluttering the experience with repetitive characters.
**Action:** Always wrap decorative ASCII separators in `<span aria-hidden="true">` and provide semantic context for visually distinct regions within a `<pre>` block using appropriate ARIA roles.
