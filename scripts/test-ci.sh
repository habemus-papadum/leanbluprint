#!/bin/bash
# Local test script for blueprint + Jekyll
# Assumes: lake build is complete, UV is installed
set -e

echo "=== Step 1: Build blueprint ==="
uv run leanblueprint pdf || echo "PDF build failed (needs LaTeX), continuing..."
uv run leanblueprint web

echo ""
echo "=== Step 2: Check declarations ==="
lake exe checkdecls blueprint/lean_decls

echo ""
echo "=== Step 3: Assemble site ==="
mkdir -p home_page/blueprint
cp -r blueprint/web/* home_page/blueprint/
[ -f blueprint/print/print.pdf ] && cp blueprint/print/print.pdf home_page/blueprint.pdf || true

echo ""
echo "=== Done! ==="
echo ""
echo "Blueprint available at: home_page/blueprint/index.html"
echo ""
echo "To view locally:"
echo "  open home_page/blueprint/index.html"
echo ""
echo "Note: Jekyll build skipped locally (requires older Ruby)."
echo "      CI will build the full Jekyll site."
