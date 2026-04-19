#!/bin/bash

# Repository Health & Infrastructure Audit Script
# Bundles 30 checks for documentation, DX, security, and architecture.

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

REPORT_ONLY=true
if [[ "$1" == "--apply" ]]; then
  REPORT_ONLY=false
  echo -e "${BLUE}Running in APPLY mode. Issues will be created on GitHub.${NC}"
else
  echo -e "${BLUE}Running in REPORT mode. No issues will be created.${NC}"
fi

check_issue() {
  local title=$1
  local body=$2
  local condition=$3

  if [ "$condition" = "true" ]; then
    echo -e "${RED}[MISSING]${NC} $title"
    if [ "$REPORT_ONLY" = false ]; then
      gh issue create --title "$title" --body "$body"
    fi
  else
    echo -e "${GREEN}[OK]${NC} $title"
  fi
}

echo -e "\n${YELLOW}--- Phase 1: Essential Documentation ---${NC}"

# 1. Missing Security Policy
[ ! -f SECURITY.md ] && missing=true || missing=false
check_issue "Security: Missing SECURITY.md" "Please add a SECURITY.md file to outline the process for reporting vulnerabilities." "$missing"

# 2. Missing Issue Templates
[ ! -d .github/ISSUE_TEMPLATE ] && missing=true || missing=false
check_issue "UX: Missing Issue Templates" "Standardized issue templates (Bug report, Feature request) help process feedback." "$missing"

# 3. Missing Pull Request Template
[ ! -f .github/PULL_REQUEST_TEMPLATE.md ] && missing=true || missing=false
check_issue "Workflow: Missing PR Template" "Ensures contributors provide context for their changes." "$missing"

# 4. Missing CI/CD Workflow
[ ! -d .github/workflows ] && missing=true || missing=false
check_issue "DevOps: Missing GitHub Actions" "The repository lacks CI/CD workflows." "$missing"

# 5. Missing Code of Conduct
[ ! -f CODE_OF_CONDUCT.md ] && missing=true || missing=false
check_issue "Community: Missing CODE_OF_CONDUCT.md" "Defines expectations for behavior and helps protect the community." "$missing"

# 6. Missing EditorConfig
[ ! -f .editorconfig ] && missing=true || missing=false
check_issue "Styling: Missing .editorconfig" "Helps keep indentation and formatting consistent." "$missing"

# 7. Missing CHANGELOG.md
[ ! -f CHANGELOG.md ] && missing=true || missing=false
check_issue "Transparency: Missing CHANGELOG.md" "Helps users track features, fixes, and breaking changes." "$missing"

# 8. Missing SUPPORT.md
[ ! -f SUPPORT.md ] && missing=true || missing=false
check_issue "Docs: Missing SUPPORT.md" "Define where users should go for help (outside of the issue tracker)." "$missing"

# 9. Missing RoadMap
grep -riq "roadmap" --exclude-dir=.git --exclude-dir=media --exclude-dir=archives --exclude-dir=node_modules README.md . >/dev/null 2>&1 && missing=false || missing=true
check_issue "Vision: Missing Roadmap" "Adding a roadmap helps contributors align with future goals." "$missing"

echo -e "\n${YELLOW}--- Phase 2: Development Experience (DX) ---${NC}"

# 10. Missing .nvmrc
[ -f package.json ] && [ ! -f .nvmrc ] && missing=true || missing=false
check_issue "DX: Missing .nvmrc" "Specify the recommended Node.js version for consistency." "$missing"

# 11. Missing Code Owners
[ ! -f .github/CODEOWNERS ] && missing=true || missing=false
check_issue "Maintenance: Missing CODEOWNERS" "Ensures the right people are automatically tagged for PR reviews." "$missing"

# 12. Missing .env.example
grep -r "process.env" --exclude-dir=.git --exclude-dir=media --exclude-dir=archives --exclude-dir=node_modules . >/dev/null 2>&1 && [ ! -f .env.example ] && missing=true || missing=false
check_issue "DX: Missing .env.example" "Provide an example file for environment variables." "$missing"

# 13. Missing .vscode settings
[ ! -d .vscode ] && missing=true || missing=false
check_issue "DX: Missing .vscode settings" "Share recommended extensions and settings." "$missing"

# 14. Missing Bug Report Reproduction
grep -riq "reproduce" .github/ISSUE_TEMPLATE/*.md >/dev/null 2>&1 && missing=false || missing=true
check_issue "DX: Improve Bug Report Template" "Explicitly ask for a minimal reproduction script." "$missing"

# 15. Missing .gitattributes
[ ! -f .gitattributes ] && missing=true || missing=false
check_issue "Maintenance: Missing .gitattributes" "Prevents diff issues caused by different OS line endings." "$missing"

echo -e "\n${YELLOW}--- Phase 3: Quality & Architecture ---${NC}"

# 16. Missing Linter/Formatter Config
[ ! -f .prettierrc ] && [ ! -f .eslintrc.json ] && missing=true || missing=false
check_issue "Quality: Missing Linter/Formatter Config" "Add Prettier or ESLint configurations." "$missing"

# 17. Missing Test Suite
[ ! -d test ] && [ ! -d tests ] && missing=true || missing=false
check_issue "Quality: Missing Test Suite" "Implementing unit tests is highly recommended." "$missing"

# 18. Missing API Specification
grep -riq "app.get" --exclude-dir=.git --exclude-dir=media --exclude-dir=archives --exclude-dir=node_modules . >/dev/null 2>&1 && [ ! -f openapi.yaml ] && missing=true || missing=false
check_issue "Docs: Missing API Specification" "Detected route definitions but no OpenAPI/Swagger documentation." "$missing"

# 19. Missing Dependency Lockfile
[ -f package.json ] && [ ! -f package-lock.json ] && [ ! -f yarn.lock ] && missing=true || missing=false
check_issue "Security: Missing Lockfile" "Commit your lockfile for reproducible builds." "$missing"

# 20. Asset Organization
ls *.png *.jpg *.svg >/dev/null 2>&1 && missing=true || missing=false
check_issue "Structure: Asset Organization" "Move images and icons to an /assets or /public/images folder." "$missing"

echo -e "\n${YELLOW}--- Phase 4: Community & Security ---${NC}"

# 21. Missing CONTRIBUTORS file
[ ! -f CONTRIBUTORS ] && missing=true || missing=false
check_issue "Community: Missing CONTRIBUTORS file" "Recognize everyone who has helped the project grow." "$missing"

# 22. Missing Funding Metadata
[ ! -f .github/FUNDING.yml ] && missing=true || missing=false
check_issue "Community: Missing FUNDING.yml" "Allow users to support the project." "$missing"

# 23. Missing Dependabot
[ ! -f .github/dependabot.yml ] && missing=true || missing=false
check_issue "Security: Dependabot Not Configured" "Enable Dependabot for automated security updates." "$missing"

# 24. Missing security.txt
[ ! -f .well-known/security.txt ] && missing=true || missing=false
check_issue "Security: Missing security.txt" "Consider adding a /.well-known/security.txt for web deployments." "$missing"

# 25. Missing Dockerfile
[ ! -f Dockerfile ] && missing=true || missing=false
check_issue "Deployment: Missing Dockerfile" "Allow for easier containerized deployment." "$missing"

echo -e "\n${BLUE}Audit Complete.${NC}"
