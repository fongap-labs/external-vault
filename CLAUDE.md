# Agent Guide

`external-vault` is a public distribution and asset repository.

## Required reading

1. `CLAUDE.md`
2. `docs/README.md`
3. `docs/ARCHITECTURE_GOVERNANCE.md`
4. `docs/DISTRIBUTION_GOVERNANCE.md`
5. `docs/NAMING_CONVENTIONS.md`
6. `docs/DEVELOPMENT_GUIDE.md`

## Repository boundary

- `tools/` contains public tool catalog and distribution metadata.
- `skills/` contains reusable rules, specifications, prompts, and references.
- `output/` contains generated or directly consumable non-program artifacts.
- `docs/` contains repository-wide engineering and distribution guidance.
- GitHub Releases contain versioned executable payloads.

Program source, tests, build logic, packaging logic, and private configuration belong to their owning source repositories.

Do not add a `projects/` source tree back to this repository.

## Distribution boundary

Do not commit versioned executables, installers, or program packages to the Git tree. Publish them through GitHub Releases.

Source repositories produce a release artifact plus `release-manifest.json`, then send `run-release` to Action Worker. Target-repository write credentials stay in Action Worker and must not be copied into source repositories.

`tools/` is metadata, not a binary archive.

`output/` is for generated non-program artifacts, not executable packages.

## Governance

Cross-repository PR governance, AI review, Gate, source policy, and release policy belong to `fongap/action-worker`. Keep only thin governance entry points here.

## Engineering language

New or modified engineering-facing content uses English for identifiers, comments, workflows, logs, errors, tests, configuration keys, and engineering documentation.

Localized end-user documentation may use other languages.

## Completion

A change is complete only when:

- repository ownership boundaries remain intact;
- repository CI is known;
- documentation matches the actual layout;
- no stale source/build path remains;
- no release binary has been added to the Git tree.
