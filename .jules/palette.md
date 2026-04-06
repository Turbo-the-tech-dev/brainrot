# Palette's Journal - CRITICAL UX & Accessibility Learnings

## 2026-04-06 - Terminal UI Accessibility
**Learning:** In text-only terminal simulations, simple ASCII progress bars and separators are extremely noisy for screen reader users. Wrapping them in semantic ARIA roles like `role="progressbar"` and using `aria-hidden="true"` for decorative elements provides a much cleaner experience.
**Action:** Use `<main>` landmarks and ARIA roles (`progressbar`, `aria-label`, `aria-hidden`) to map cryptic terminal outputs to accessible components.
