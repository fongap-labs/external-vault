# Architecture

`external-vault` is a public distribution and asset repository, not a program source repository.

## Ownership boundary

```text
source repositories
= program source
+ tests
+ build / package implementation
+ private project configuration

external-vault
= public distribution metadata
+ reusable public material
+ generated non-program public artifacts
+ GitHub Release payloads
+ thin governance entry points

action-worker
= shared governance
+ PR / Release / Deploy governance
+ cross-repository machine contracts
```

## Repository structure

```text
external-vault/
├─ .github/workflows/   CI and thin governance dispatch
├─ docs/                Distribution-specific documentation
├─ tools/               Public tool catalog and distribution metadata
├─ skills/              Reusable public guidance and references
├─ output/              Generated non-program public artifacts
├─ AGENTS.md             Agent redirect
├─ CLAUDE.md             Repository Agent entry point
├─ README.md             Default English index
└─ README.zh-CN.md       Simplified Chinese index
```

There is intentionally no program source tree.

## Distribution flow

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

The source repository never needs target-repository write credentials.

## Asset domains

- `tools/`: small text metadata for distributed programs.
- `skills/`: reusable rules, specifications, prompts and references.
- `output/`: generated reports, feeds, rule data, briefs and other non-program public assets.
- GitHub Releases: executables, installers, program archives, checksums and release notes.

## Security and stability

Credentials stay in platform secret stores. Public assets must not expose private source, logs, configuration or secrets. Third-party content keeps its upstream licensing and attribution obligations.

`main` is the supported public baseline. Repository structure should change rarely; generated public content may evolve independently while the source/distribution boundary remains intact.
