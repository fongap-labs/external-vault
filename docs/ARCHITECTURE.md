# Architecture

## Repository structure

```text
external-vault/
├─ .github/workflows/     CI and thin governance dispatch
├─ docs/                  Repository-wide engineering and distribution guidance
├─ tools/                 Public tool catalog and distribution metadata
├─ skills/                Reusable public guidance and references
├─ output/                Generated non-program public artifacts
├─ AGENTS.md              Agent redirect
├─ CLAUDE.md              Repository Agent entry point
├─ README.md              Default English index
└─ README.zh-CN.md        Simplified Chinese index
```

There is intentionally no program source tree.

## Distribution model

```text
source repository
      ↓
build / test / package
      ↓
release artifact + manifest
      ↓
run-release
      ↓
Action Worker
      ↓
external-vault GitHub Release
      ↓
tools/ catalog metadata
      ↓
public consumer
```

The source repository never needs target-repository write credentials. Action Worker separately verifies source evidence and publishes to an allowed target repository.

## Asset domains

- `tools/`: small text metadata for distributed programs.
- `skills/`: reusable rules, specifications, prompts, and references.
- `output/`: generated reports, feeds, rules, briefs, and other non-program public assets.
- GitHub Releases: executables, installers, program archives, checksums, and release notes.

## Repository governance

```text
metadata / docs / public asset change
      ↓
Repository CI
      ↓
validate-merge
      ↓
Action Worker PR Governance
      ↓
merge
```
