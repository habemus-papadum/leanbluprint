#!/bin/bash
# Local test script for blueprint + docs + Jekyll
# Assumes: lake build is complete, UV is installed
set -e

echo "=== Step 1: Build blueprint ==="
uv run leanblueprint pdf || echo "PDF build failed (needs LaTeX), continuing..."
uv run leanblueprint web

echo ""
echo "=== Step 2: Check declarations ==="
lake exe checkdecls blueprint/lean_decls

echo ""
echo "=== Step 3: Build API docs ==="
lake build BluePrintDemo:docs

echo ""
echo "=== Step 4: Assemble site ==="
mkdir -p home_page/blueprint
mkdir -p home_page/docs
cp -r blueprint/web/* home_page/blueprint/
[ -f blueprint/print/print.pdf ] && cp blueprint/print/print.pdf home_page/blueprint.pdf || true
cp -r .lake/build/doc/* home_page/docs/

echo ""
echo "=== Step 5: Build Jekyll site ==="
cd home_page
bundle install
JEKYLL_ENV=production bundle exec jekyll build
cd ..

echo ""
echo "=== Done! ==="
echo "Site built at: home_page/_site/"
echo ""
echo "To serve locally:"
echo "  cd home_page && bundle exec jekyll serve"
echo "  Then visit http://localhost:4000"
