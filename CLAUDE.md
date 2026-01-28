# Project Overview

This is a Lean 4 project demonstrating how to use Lean Blueprint for documenting and tracking formalization progress.

## Lean Setup

- **Lean version**: 4.27.0 (see `lean-toolchain`)
- **Build system**: Lake
- **Project name**: BluePrintDemo
- **Dependencies**: Mathlib v4.27.0

### Project Structure

```
BluePrintDemo.lean       # Main entry point
BluePrintDemo/
  Basic.lean             # Core definitions and theorems
lakefile.toml            # Lake build configuration
lean-toolchain           # Lean version specification
```

### Building the Project

```bash
lake build
```

## Python Environment (for Lean Blueprint)

Use **UV** for managing Python packages:

```bash
# Install leanblueprint
uv pip install leanblueprint

# Or add to a project with uv
uv add leanblueprint
```

## Lean Blueprint

Lean Blueprint is used to create mathematical documentation that tracks formalization progress. Key commands:

```bash
leanblueprint new        # Initialize blueprint in project
leanblueprint web        # Build HTML documentation
leanblueprint pdf        # Build PDF documentation
leanblueprint checkdecls # Verify Lean declarations exist
leanblueprint serve      # Local server on port 8000
```

### Key LaTeX Macros for Blueprint

- `\lean{Namespace.name}` - Links to a Lean declaration
- `\leanok` - Marks the environment as fully formalized
- `\uses{label1, label2}` - Declares dependencies on other items
