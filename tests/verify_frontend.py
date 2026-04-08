import os
from playwright.sync_api import sync_playwright, expect

def verify_page(page, url, name):
    print(f"Verifying {name} at {url}...")
    page.goto(url)

    # 1. Verify <main> landmark
    main_landmark = page.get_by_role("main")
    expect(main_landmark).to_be_visible()
    print(f"  [PASS] <main> landmark found in {name}")

    # 2. Verify progressbar
    progressbar = page.get_by_role("progressbar", name="Ohio Risk Level")
    expect(progressbar).to_be_visible()
    expect(progressbar).to_have_attribute("aria-valuenow", "84")
    expect(progressbar).to_have_attribute("aria-valuemin", "0")
    expect(progressbar).to_have_attribute("aria-valuemax", "100")
    print(f"  [PASS] Progressbar 'Ohio Risk Level' verified in {name}")

    # 3. Verify links with aria-labels
    expect(page.get_by_role("link", name="Deployment Scenarios (JSON)")).to_be_visible()
    expect(page.get_by_role("link", name="Live Metrics (JSON)")).to_be_visible()
    expect(page.get_by_role("link", name="Manifesto (Markdown)")).to_be_visible()
    expect(page.get_by_role("link", name="System Config (YAML)")).to_be_visible()
    print(f"  [PASS] Directory links with aria-labels verified in {name}")

    # 4. Verify hidden separators (making sure they aren't in the accessibility tree)
    # This is trickier to test purely with Playwright roles, but we can check the attribute
    separators = page.locator('span[aria-hidden="true"]')
    count = separators.count()
    if count >= 4:
        print(f"  [PASS] Found {count} hidden separators in {name}")
    else:
        print(f"  [FAIL] Expected at least 4 hidden separators, found {count} in {name}")
        exit(1)

    # Take screenshot
    screenshot_path = f"/home/jules/verification/{name}_verification.png"
    page.screenshot(path=screenshot_path)
    print(f"  [INFO] Screenshot saved to {screenshot_path}")

def run_verification():
    os.makedirs("/home/jules/verification", exist_ok=True)
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        context = browser.new_context()
        page = context.new_page()

        # Verify root index.html
        verify_page(page, "file:///app/index.html", "root_index")

        # Verify brainrot index.html
        verify_page(page, "file:///app/brainrot/index.html", "brainrot_index")

        browser.close()

if __name__ == "__main__":
    run_verification()
