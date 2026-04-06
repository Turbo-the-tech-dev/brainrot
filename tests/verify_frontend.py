import asyncio
from playwright.async_api import async_playwright
import os

async def verify_html(page, filepath):
    abs_path = os.path.abspath(filepath)
    url = f"file://{abs_path}"
    print(f"Verifying {filepath} at {url}...")
    await page.goto(url)

    # Check for <main> landmark
    main_landmark = await page.query_selector("main")
    if main_landmark is None:
        raise Exception(f"Missing <main> landmark in {filepath}")
    print(f"  [OK] Found <main> landmark")

    # Check for progressbar role
    progressbar = page.get_by_role("progressbar").first
    if not await progressbar.is_visible():
        raise Exception(f"Missing progressbar in {filepath}")
    aria_label = await progressbar.get_attribute("aria-label")
    if aria_label != "Ohio Risk Level":
        raise Exception(f"Incorrect aria-label for progressbar in {filepath}: {aria_label}")
    print(f"  [OK] Found progressbar with correct aria-label")

    # Check for aria-hidden elements
    hidden_elements = await page.query_selector_all("[aria-hidden='true']")
    if len(hidden_elements) == 0:
        raise Exception(f"No aria-hidden elements found in {filepath}")
    print(f"  [OK] Found {len(hidden_elements)} aria-hidden elements")

    # Check for aria-labels on links
    links = await page.query_selector_all("a[aria-label]")
    if len(links) < 4:
        raise Exception(f"Expected at least 4 links with aria-labels in {filepath}, found {len(links)}")
    print(f"  [OK] Found {len(links)} links with aria-labels")

async def main():
    async with async_playwright() as p:
        browser = await p.chromium.launch()
        page = await browser.new_page()

        try:
            await verify_html(page, "index.html")
            await verify_html(page, "brainrot/index.html")
            print("\nVerification successful!")
        finally:
            await browser.close()

if __name__ == "__main__":
    asyncio.run(main())
