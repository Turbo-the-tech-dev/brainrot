from playwright.sync_api import sync_playwright
import os

def run_verification(page, url, name):
    print(f"Verifying {url}...")
    page.goto(url)
    page.wait_for_timeout(1000)

    # Check for the link to telemetry.json
    telemetry_link = page.get_by_role("link", name="LIVE_METRICS.JSON")
    if telemetry_link.is_visible():
        print(f"Found LIVE_METRICS.JSON link on {name}")
        href = telemetry_link.get_attribute("href")
        if href == "telemetry.json":
            print(f"SUCCESS: Link points to telemetry.json on {name}")
        else:
            print(f"FAILURE: Link points to {href} instead of telemetry.json on {name}")
    else:
        print(f"FAILURE: LIVE_METRICS.JSON link NOT found on {name}")

    page.screenshot(path=f"/home/jules/verification/screenshots/verification_{name}.png")
    page.wait_for_timeout(1000)

if __name__ == "__main__":
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=True)
        context = browser.new_context(
            record_video_dir="/home/jules/verification/videos"
        )
        page = context.new_page()

        root_path = "file://" + os.path.abspath("index.html")
        brainrot_path = "file://" + os.path.abspath("brainrot/index.html")

        try:
            run_verification(page, root_path, "root")
            run_verification(page, brainrot_path, "brainrot")
        finally:
            context.close()
            browser.close()
