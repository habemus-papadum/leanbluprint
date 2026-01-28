#!/bin/bash
set -e

echo "=== Step 1: Build Lean project ==="
lake build

echo ""
echo "=== Step 2: Build blueprint ==="
uv run leanblueprint web

echo ""
echo "=== Step 3: Check declarations ==="
lake exe checkdecls blueprint/lean_decls

echo ""
echo "=== Step 4: Serve locally (optional) ==="
echo "Blueprint built at: blueprint/web/"
echo "To view: uv run leanblueprint serve"
echo ""
echo "All steps passed!"
