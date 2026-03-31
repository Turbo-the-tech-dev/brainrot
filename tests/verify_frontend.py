import os
from playwright.sync_api import sync_playwright

def verify_file(page, file_path):
    absolute_path = os.path.abspath(file_path)
    url = f"file://{absolute_path}"
    print(f"Verifying {url}")
    page.goto(url)

    # Check for main landmark
    main_pre = page.get_by_role("main")
    if main_pre.count() == 0:
        raise Exception(f"Missing role='main' on <pre> in {file_path}")
    print(f"  [OK] role='main' found")

    # Check for progressbar
    progress = page.get_by_role("progressbar", name="Ohio Risk Level")
    if progress.count() == 0:
        raise Exception(f"Missing role='progressbar' with aria-label='Ohio Risk Level' in {file_path}")

    # Verify progressbar attributes
    if progress.get_attribute("aria-valuenow") != "84":
        raise Exception(f"Incorrect aria-valuenow in {file_path}")
    if progress.get_attribute("aria-valuemin") != "0":
        raise Exception(f"Incorrect aria-valuemin in {file_path}")
    if progress.get_attribute("aria-valuemax") != "100":
        raise Exception(f"Incorrect aria-valuemax in {file_path}")
    print(f"  [OK] Progressbar attributes verified")

    # Check for links with aria-labels
    links = [
        ("absolute_velocity.json", "Deployment Scenarios (JSON)"),
        ("deadpan-brainrot.json", "Live Metrics (JSON)"),
        ("GEMINI_BRAINROT.md", "Manifesto (Markdown)"),
        ("BRAINROT_CONFIG.yml", "System Config (YAML)")
    ]
    for href, label in links:
        link = page.get_by_label(label)
        if link.count() == 0:
            raise Exception(f"Missing link with aria-label='{label}' in {file_path}")
        if link.get_attribute("href") != href:
             raise Exception(f"Link with label '{label}' has wrong href in {file_path}")
    print(f"  [OK] Directory links verified")

    # Check for hidden separators (at least one)
    hidden_separators = page.locator("span[aria-hidden='true']")
    if hidden_separators.count() == 0:
        raise Exception(f"No aria-hidden separators found in {file_path}")
    print(f"  [OK] aria-hidden separators found")

def run_verification():
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        # Record video for the root index.html
        context = browser.new_context(record_video_dir="/home/jules/verification/videos")
        page = context.new_page()

        try:
            os.makedirs("/home/jules/verification/screenshots", exist_ok=True)

            verify_file(page, "index.html")
            page.screenshot(path="/home/jules/verification/screenshots/index_verify.png")

            verify_file(page, "brainrot/index.html")
            page.screenshot(path="/home/jules/verification/screenshots/brainrot_index_verify.png")

            print("\nVerification successful!")
        finally:
            context.close()
            browser.close()

if __name__ == "__main__":
    run_verification()
