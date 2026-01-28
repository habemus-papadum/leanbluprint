# Project Overview

This is a Lean 4 project demonstrating how to use Lean Blueprint for documenting and tracking formalization progress.

## Lean Setup

- **Lean version**: 4.27.0-rc1 (see `lean-toolchain`)
- **Build system**: Lake
- **Project name**: BluePrintDemo
- **Dependencies**: Mathlib (latest), checkdecls

### Project Structure

```
BluePrintDemo.lean       # Main entry point
BluePrintDemo/
  Basic.lean             # Core definitions and theorems
lakefile.toml            # Lake build configuration
lean-toolchain           # Lean version specification
blueprint/               # LaTeX blueprint source
home_page/               # Jekyll site for GitHub Pages
```

### Building the Project

```bash
lake update
lake exe cache get   # Fetch Mathlib cache
lake build
```

## CI / Documentation

CI uses `leanprover/lean-action@v1` to build Lean and `leanprover-community/docgen-action@main` to compile the blueprint, doc-gen4 docs, and Jekyll homepage. No local Python/UV setup is needed — docgen-action handles leanblueprint internally.

## Lean Blueprint

Lean Blueprint is used to create mathematical documentation that tracks formalization progress. Key commands (if running locally):

```bash
leanblueprint web        # Build HTML documentation
leanblueprint pdf        # Build PDF documentation
leanblueprint checkdecls # Verify Lean declarations exist
leanblueprint serve      # Local server on port 8000
```

### Key LaTeX Macros for Blueprint

- `\lean{Namespace.name}` - Links to a Lean declaration
- `\leanok` - Marks the environment as fully formalized
- `\uses{label1, label2}` - Declares dependencies on other items
