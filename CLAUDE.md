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

## Local Preview

Preview the full documentation site (homepage + blueprint) locally, matching what CI assembles.

### Prerequisites

**Python / leanblueprint** — the script uses `uvx` (from [uv](https://docs.astral.sh/uv/)) to run `leanblueprint` without a persistent install. Install uv if you don't have it:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

No `pip install` needed — `uvx leanblueprint web` fetches and runs it in an isolated environment automatically.

**Ruby / Jekyll** — the Gemfile uses the `github-pages` gem, which pins an older Jekyll and has strict Ruby version requirements. **Do not use system Ruby or Ruby 4.x** — they are incompatible. Use a version manager to install Ruby 3.1.x:

1. Install [rbenv](https://github.com/rbenv/rbenv) (or [mise](https://mise.jdx.dev/)): `brew install rbenv` or your platform's equivalent.
2. Add rbenv to your shell: run `rbenv init` and follow the instructions (adds a line to `~/.zshrc` or `~/.bashrc`).
3. Restart your shell, then install Ruby: `rbenv install 3.1.6`
4. Set it for this project: `rbenv local 3.1.6` (creates `.ruby-version` in the repo root).
5. Verify: `ruby --version` should show 3.1.x, and `which ruby` should point through `~/.rbenv/shims/`.

The script loads rbenv automatically for non-login shells. Gems are installed locally inside `home_page/vendor/` — the Gemfile and Gemfile.lock are never modified.

### Running

```bash
bash scripts/local_preview.sh
```

Open `http://localhost:4000`. The "Documentation" link will 404 locally (doc-gen4 only runs in CI).

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
