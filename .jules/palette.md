# Palette Journal

## 2025-05-14 - Terminal UI Accessibility Landmarks
**Learning:** Terminal-style UIs that rely heavily on `<pre>` blocks are often seen as a single block of text by screen readers. Without semantic roles, the internal structure (like progress bars or status indicators) is lost. Decorative ASCII (like `=======`) creates significant noise.
**Action:** Always wrap the main terminal content in `role="main"`. Use `aria-hidden="true"` on ASCII separators. Map cryptic filenames to descriptive `aria-label` attributes on links.
