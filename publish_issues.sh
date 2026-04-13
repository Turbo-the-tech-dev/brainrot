#!/bin/bash

# Repository Health & Scaling Audit Script
# Publishes up to 50 issues to GitHub for missing documentation, security, and DX.

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

publish_issue() {
  local title=$1
  local body=$2
  local condition=$3

  if [ "$condition" = "true" ]; then
    echo -ne "${YELLOW}[CHECKING]${NC} $title..."
    # Check if issue with same title already exists
    if gh issue list --search "in:title \"$title\"" --state open | grep -q "$title"; then
      echo -e "${BLUE}ALREADY EXISTS${NC}"
    else
      gh issue create --title "$title" --body "$body" >/dev/null 2>&1
      if [ $? -eq 0 ]; then
        echo -e "${GREEN}PUBLISHED${NC}"
      else
        echo -e "${RED}FAILED${NC}"
      fi
    fi
  else
    echo -e "${GREEN}[OK]${NC} $title"
  fi
}

echo -e "\n${BLUE}--- Group 1: Security & Compliance ---${NC}"

# 1. Hardcoded Secrets
# (Skipped in automation for safety - manually audit this)
echo -e "${BLUE}[SKIP]${NC} Security: Potential Secrets in Code (Requires manual grep)"

# 2. Missing security.txt
[ ! -f .well-known/security.txt ] && missing=true || missing=false
publish_issue "Security: Missing /.well-known/security.txt" "Standardize vulnerability reporting for web assets." "$missing"

# 3. Missing dependabot.yml
[ ! -f .github/dependabot.yml ] && missing=true || missing=false
publish_issue "Security: Enable Dependabot" "Automate dependency security updates." "$missing"

# 4. Unsigned Commits Policy
publish_issue "Security: Require Signed Commits" "Enforce GPG signing to verify contributor identity." "true"

# 5. Missing CODEOWNERS
[ ! -f .github/CODEOWNERS ] && missing=true || missing=false
publish_issue "Security: Define Code Owners" "Ensure sensitive directories require specific reviewer approval." "$missing"

# 6. npm audit (only if package.json exists)
if [ -f package.json ]; then
  npm audit --audit-level=high | grep -q "high" && missing=true || missing=false
  publish_issue "Security: High Vulnerabilities in Dependencies" "Run npm audit to fix high-risk dependency issues." "$missing"
fi

# 7. Missing SBOM
publish_issue "Compliance: Generate SBOM" "Add a CycloneDX or SPDX manifest for supply chain transparency." "true"

# 8. Missing CSP Headers (if web files exist)
ls *.html >/dev/null 2>&1 && (grep -rq --exclude-dir={.git,node_modules,media,archives} "Content-Security-Policy" . || missing=true) || missing=false
publish_issue "Security: Missing CSP Headers" "Implement CSP to prevent XSS attacks." "$missing"

# 9. Branch Protection
publish_issue "Maintenance: Missing Branch Protection" "Require PRs and status checks before merging to main." "true"

# 10. Publicly Exposed .env
[ -f .env ] && missing=true || missing=false
publish_issue "Security: .env file is tracked" "Sensitive environment variables are being tracked in git. Move to .gitignore immediately." "$missing"

echo -e "\n${BLUE}--- Group 2: Advanced Documentation ---${NC}"

# 11. Missing ARCHITECTURE.md
[ ! -f ARCHITECTURE.md ] && missing=true || missing=false
publish_issue "Docs: Add ARCHITECTURE.md" "Explain the high-level technical design and data flow." "$missing"

# 12. Missing CHANGELOG.md
[ ! -f CHANGELOG.md ] && missing=true || missing=false
publish_issue "Docs: Missing CHANGELOG.md" "Track version history and notable changes." "$missing"

# 13. Missing API Examples
[ ! -d examples ] && missing=true || missing=false
publish_issue "Docs: Add /examples directory" "Provide runnable code snippets for common use cases." "$missing"

# 14. Good First Issue Labels
gh label list | grep -q "good first issue" && missing=false || missing=true
publish_issue "Community: Define Good First Issues" "Label simple tasks to encourage new contributors." "$missing"

# 15. Visual Assets
publish_issue "Docs: Add Screenshots/Diagrams" "Visuals in the README significantly improve user onboarding." "true"

# 16. Local Setup Guide
grep -qi "install" README.md && missing=false || missing=true
publish_issue "Docs: Missing Installation Guide" "The README lacks clear local environment setup instructions." "$missing"

# 17. Badges
publish_issue "Docs: Add Status Badges" "Add CI/CD, License, and Version badges to the README top." "true"

# 18. Troubleshooting FAQ
grep -qi "troubleshooting" README.md || [ -f TROUBLESHOOTING.md ] && missing=false || missing=true
publish_issue "Docs: Add Troubleshooting Section" "Document common errors and their solutions." "$missing"

# 19. Acknowledgments
grep -qi "acknowledgments" README.md && missing=false || missing=true
publish_issue "Docs: Add Credits/Acknowledgements" "Recognize contributors and third-party libraries used." "$missing"

# 20. Broken Links Check
publish_issue "Docs: Fix Broken Links" "Perform a sweep of all markdown files for 404 links." "true"

echo -e "\n${BLUE}--- Group 3: DevOps & Automation ---${NC}"

# 21. Linting Workflow
[ ! -f .github/workflows/lint.yml ] && missing=true || missing=false
publish_issue "DevOps: Add Linting Workflow" "Automate code style enforcement on every PR." "$missing"

# 22. Testing Workflow
[ ! -f .github/workflows/test.yml ] && missing=true || missing=false
publish_issue "DevOps: Add Unit Test Workflow" "Run the test suite automatically via GitHub Actions." "$missing"

# 23. Stale Bot
[ ! -f .github/workflows/stale.yml ] && missing=true || missing=false
publish_issue "Maintenance: Add Stale Bot" "Automatically close inactive issues to keep the backlog clean." "$missing"

# 24. Dockerfile
[ ! -f Dockerfile ] && missing=true || missing=false
publish_issue "DevOps: Add Dockerfile" "Allow for consistent environment replication." "$missing"

# 25. EditorConfig (Should be OK now)
[ ! -f .editorconfig ] && missing=true || missing=false
publish_issue "DX: Add .editorconfig" "Standardize IDE settings across the team." "$missing"

# 26. Gitattributes (Should be OK now)
[ ! -f .gitattributes ] && missing=true || missing=false
publish_issue "DX: Add .gitattributes" "Ensure consistent line endings (LF) across OS types." "$missing"

# 27. Release Automation
publish_issue "DevOps: Add Semantic Release" "Automate versioning and GitHub Release creation." "true"

# 28. Coverage Reports
publish_issue "Quality: Add Code Coverage Reporting" "Integrate Codecov or similar to track test coverage." "true"

# 29. DevContainer
[ ! -d .devcontainer ] && missing=true || missing=false
publish_issue "DX: Add VS Code DevContainer" "Enable one-click development environments." "$missing"

# 30. Deployment Preview
publish_issue "DevOps: Add PR Previews" "Automatically deploy a staging version for every Pull Request." "true"

echo -e "\n${BLUE}--- Group 4: Code Quality & Architecture ---${NC}"

# 31. .nvmrc
[ -f package.json ] && [ ! -f .nvmrc ] && missing=true || missing=false
publish_issue "DX: Add .nvmrc" "Lock the Node.js version for all contributors." "$missing"

# 32. Pre-commit Hooks
publish_issue "Quality: Add Husky/Pre-commit Hooks" "Run tests and linting locally before allowing a commit." "true"

# 33. Absolute Imports
publish_issue "Refactor: Use Absolute Imports" "Replace relative imports with absolute paths." "true"

# 34. Large File Bloat
find . -name .git -prune -o -name node_modules -prune -o -name media -prune -o -name archives -prune -o -type f -size +1M -print | grep -q "." && missing=true || missing=false
publish_issue "Performance: Large Files in Repo" "Identify and move large binary files to LFS or external storage." "$missing"

# 35. Circular Dependencies
publish_issue "Refactor: Check for Circular Dependencies" "Audit the module structure to prevent circular imports." "true"

# 36. Error Boundaries (if web)
ls *.tsx *.jsx >/dev/null 2>&1 && missing=true || missing=false
publish_issue "Quality: Implement Error Boundaries" "Prevent the whole app from crashing on UI errors." "$missing"

# 37. Naming Conventions
publish_issue "Refactor: Standardize Naming" "Ensure consistent camelCase or snake_case across the codebase." "true"

# 38. Dead Code Cleanup
publish_issue "Refactor: Remove Unused Dependencies" "Audit package.json for libraries that are no longer imported." "true"

# 39. TypeScript Migration
[ ! -f tsconfig.json ] && missing=true || missing=false
publish_issue "Quality: Migrate to TypeScript" "Add type safety to prevent runtime errors." "$missing"

# 40. Hardcoded URLs
grep -r --exclude-dir={.git,node_modules,media,archives} "http://" . | grep -q "." && missing=true || missing=false
publish_issue "Refactor: Remove Hardcoded URLs" "Move API endpoints and URLs to a config file or environment variables." "$missing"

echo -e "\n${BLUE}--- Group 5: Community & Metadata ---${NC}"

# 41. Repository Topics
gh repo view --json repositoryTopics --template '{{if not .repositoryTopics}}No Topics Found{{end}}' | grep -q "No Topics" && missing=true || missing=false
publish_issue "Meta: Add Repository Topics" "Add tags like 'javascript' or 'automation' to improve discovery." "$missing"

# 42. Social Preview Image
gh repo view --json openGraphImageUrl --template '{{if not .openGraphImageUrl}}No Image{{end}}' | grep -q "No Image" && missing=true || missing=false
publish_issue "Meta: Add Social Preview" "Upload a custom Open Graph image in repository settings." "$missing"

# 43. CITATION.cff
[ ! -f CITATION.cff ] && missing=true || missing=false
publish_issue "Community: Add CITATION.cff" "Help researchers cite this software correctly." "$missing"

# 44. Discussion Tab
publish_issue "Community: Enable GitHub Discussions" "Move Q&A out of the issue tracker to a dedicated forum." "true"

# 45. GitHub Profile README
publish_issue "Meta: Create Org/User Profile README" "Improve the branding of the project owner." "true"

# 46. Internationalization
publish_issue "i18n: Add Internationalization Support" "Prepare the codebase for multi-language support." "true"

# 47. Public Roadmap
publish_issue "Vision: Create Public Roadmap" "Use a GitHub Project board to show planned features." "true"

# 48. Help Wanted Strategy
publish_issue "Community: Curate Help Wanted Issues" "Actively flag issues that need external contributors." "true"

# 49. CONTRIBUTORS file (Should be OK now)
[ ! -f CONTRIBUTORS ] && missing=true || missing=false
publish_issue "Community: Add CONTRIBUTORS file" "Explicitly list and thank everyone who has merged a PR." "$missing"

# 50. Funding Options
[ ! -f .github/FUNDING.yml ] && missing=true || missing=false
publish_issue "Community: Add Funding Options" "Enable GitHub Sponsors to support project development." "$missing"

echo -e "\n${GREEN}Process Complete.${NC}"
