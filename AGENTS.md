# Agents

This file is the repository-wide instruction source for coding and automation Agents.

## Required reading

1. Action Worker `docs/SHARED_GOVERNANCE.md`
2. Action Worker `docs/NAMING_CONVENTIONS.md`
3. Action Worker `docs/CHANGELOG_CONVENTIONS.md`
4. Action Worker `docs/DEVELOPMENT_GUIDE.md`
5. `docs/ARCHITECTURE.md`
6. `docs/DISTRIBUTION_GOVERNANCE.md`

## Repository boundary

- `tools/` contains public catalog and distribution metadata.
- `skills/` contains reusable public rules, specifications, prompts and references.
- `output/` contains generated or directly consumable non-program artifacts.
- GitHub Releases contain versioned executable payloads.

Program source, tests, build/package implementation and private configuration belong to their owning source repositories.

## Distribution boundary

Source repositories build and validate release artifacts, then dispatch `run-release` to Action Worker. Target-repository write credentials remain in Action Worker.

Do not commit versioned executables, installers or program packages into the Git tree.

## Governance

Shared naming, changelog, development, PR Gate and release-governance rules are inherited from `fongap-labs/action-worker`. This repository keeps only distribution-specific architecture and rules.
