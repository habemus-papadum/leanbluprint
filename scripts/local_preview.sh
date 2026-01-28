#!/usr/bin/env bash
set -euo pipefail

# Load rbenv if available (non-login shells don't source ~/.zshrc)
if command -v rbenv &>/dev/null; then
  eval "$(rbenv init - bash)"
fi

# 1. Build blueprint HTML from LaTeX source
echo "Building blueprint..."
uvx leanblueprint web

# 2. Copy compiled blueprint into home_page for Jekyll to serve
echo "Copying blueprint to home_page..."
rm -rf home_page/blueprint
cp -r blueprint/web home_page/blueprint

# 3. Optionally build PDF
if command -v latexmk &>/dev/null; then
  echo "Building PDF..."
  uvx leanblueprint pdf
  cp blueprint/print.pdf home_page/blueprint.pdf 2>/dev/null || true
fi

# 4. Serve with Jekyll
# 4. Build a local Jekyll config that strips remote_theme
#    (The github-pages gem force-loads jekyll-remote-theme whenever
#     the remote_theme key exists, and Jekyll config merge can't delete keys.
#     So we generate a clean config without that key.)
LOCAL_CONFIG="$(mktemp "${TMPDIR:-/tmp}/jekyll_local_XXXXXX.yml")"
trap 'rm -f "$LOCAL_CONFIG"' EXIT
grep -v '^remote_theme:' home_page/_config.yml > "$LOCAL_CONFIG"
cat >> "$LOCAL_CONFIG" <<'EOF'
# Local overrides
plugins: []
url: "http://localhost:4000"
EOF

echo "Starting Jekyll server..."
cd home_page
bundle config set --local path vendor/bundle
bundle install --quiet
bundle exec jekyll serve --livereload --config "$LOCAL_CONFIG"
