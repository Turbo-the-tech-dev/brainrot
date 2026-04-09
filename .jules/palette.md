## 2025-04-09 - Terminal UI Accessibility Patterns
**Learning:** Terminal-style UIs using `<pre>` tags often create a "wall of sound" for screen readers due to decorative ASCII art and cryptic filenames.
**Action:** Wrap terminal content in a `<main>` landmark, hide decorative ASCII separators with `aria-hidden="true"`, and use `aria-label` to provide human-readable context for system-style filenames and progress indicators.
