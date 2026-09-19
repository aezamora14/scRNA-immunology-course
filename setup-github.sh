#!/usr/bin/env bash
# One-time helper: initialise git, create the gh-pages branch that Quarto
# publishes to, create the GitHub repository and push. Requires the GitHub
# CLI (https://cli.github.com) to be installed and authenticated (gh auth login).
#
# Usage:  bash setup-github.sh YOUR_GITHUB_USERNAME [repo-name]

set -euo pipefail

USER_NAME="${1:?Usage: bash setup-github.sh YOUR_GITHUB_USERNAME [repo-name]}"
REPO_NAME="${2:-scRNA-immunology-course}"

# Put your username into the book config so "Edit this page" links work.
sed -i.bak "s#YOUR_USERNAME#${USER_NAME}#g" _quarto.yml README.md && rm -f _quarto.yml.bak README.md.bak

git init -b main
git add -A
git commit -m "Initial commit: scRNA-seq + scTCR-seq course"

# Quarto needs an existing (empty) gh-pages branch to publish into.
git checkout --orphan gh-pages
git rm -rf --quiet .
git commit --allow-empty -m "Initialise gh-pages branch"
git checkout main

gh repo create "${USER_NAME}/${REPO_NAME}" --public --source=. --remote=origin --push
git push origin gh-pages

# Configure Pages to serve the gh-pages branch and allow Actions to write.
gh api -X POST "repos/${USER_NAME}/${REPO_NAME}/pages" \
  -f "source[branch]=gh-pages" -f "source[path]=/" >/dev/null 2>&1 || true
gh api -X PUT "repos/${USER_NAME}/${REPO_NAME}/actions/permissions/workflow" \
  -f default_workflow_permissions=write -F can_approve_pull_request_reviews=false >/dev/null 2>&1 || true

echo
echo "Done. The first build is running under the Actions tab."
echo "In a few minutes the site will be live at:"
echo "  https://${USER_NAME}.github.io/${REPO_NAME}/"
