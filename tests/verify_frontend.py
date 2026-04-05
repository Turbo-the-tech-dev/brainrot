import os
import asyncio
from playwright.async_api import async_playwright

async def verify_file(file_path):
    print(f"Verifying {file_path}...")
    abs_path = os.path.abspath(file_path)
    url = f"file://{abs_path}"

    async with async_playwright() as p:
        browser = await p.chromium.launch()
        page = await browser.new_page()
        await page.goto(url)

        # Verify <main> landmark
        main_landmark = await page.query_selector("main")
        assert main_landmark is not None, f"Missing <main> landmark in {file_path}"

        # Verify aria-hidden spans
        hidden_spans = await page.query_selector_all("span[aria-hidden='true']")
        assert len(hidden_spans) >= 5, f"Expected at least 5 aria-hidden spans, found {len(hidden_spans)} in {file_path}"

        # Verify progressbar
        progressbar = page.get_by_role("progressbar")
        assert await progressbar.is_visible(), f"Progressbar not visible in {file_path}"
        assert await progressbar.get_attribute("aria-valuenow") == "84", f"Wrong aria-valuenow in {file_path}"
        assert await progressbar.get_attribute("aria-label") == "Ohio Risk Level", f"Wrong aria-label for progressbar in {file_path}"

        # Verify directory links with aria-labels
        links = [
            ("absolute_velocity.json", "Deployment Scenarios (JSON)"),
            ("deadpan-brainrot.json", "Live Metrics (JSON)"),
            ("GEMINI_BRAINROT.md", "Manifesto (Markdown)"),
            ("BRAINROT_CONFIG.yml", "System Config (YAML)")
        ]

        for href, label in links:
            link = page.get_by_role("link", name=label)
            assert await link.is_visible(), f"Link for {href} with label '{label}' not found in {file_path}"
            assert await link.get_attribute("href") == href, f"Wrong href for {label} in {file_path}"

        await browser.close()
    print(f"Successfully verified {file_path}")

async def main():
    await verify_file("index.html")
    await verify_file("brainrot/index.html")

if __name__ == "__main__":
    asyncio.run(main())
