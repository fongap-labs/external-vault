# external-vault

[English](README.md) · [简体中文](README.zh-CN.md)

[![Release](https://img.shields.io/github/v/release/fongap-labs/external-vault?label=Release&display_name=tag&sort=semver)](https://github.com/fongap-labs/external-vault/releases)

**Public releases, reusable assets, and distribution metadata — without source-code clutter.**

Program source, tests, and build logic stay in their owning source repositories. This repository keeps only public distribution metadata, reusable material, generated non-program artifacts, and versioned program payloads published through GitHub Releases.

## Distribution

| Destination | Purpose |
| --- | --- |
| [Releases](https://github.com/fongap-labs/external-vault/releases) | Versioned executables, installers, archives, checksums, and release notes |
| [`tools/`](tools/) | Public tool catalog and distribution metadata |
| [`output/`](output/) | Generated, directly consumable non-program assets |

## Repository contents

| Path | Purpose |
| --- | --- |
| [`tools/`](tools/) | Tool catalog and small text-based distribution metadata |
| [`skills/`](skills/) | Reusable distributable specifications and reference material; shared Agent behavior belongs to Action Worker |
| [`output/`](output/) | Reports, feeds, rule data, briefs, and other generated public artifacts |
| [`docs/`](docs/) | Repository-wide engineering and distribution guidance |
| [`.github/`](.github/) | Source-owned execution manifest and central CI scripts |

## Release convention

GitHub Releases are the canonical location for versioned program payloads. Release tags are product-scoped:

```text
<release-key>-v<semver>
```

Example: `agentdock-v0.1.0`.

Program source, build logic, and binary payloads do not belong in the Git tree.

## Repository layout

```text
external-vault/
├─ tools/      Public tool catalog and distribution metadata
├─ skills/     Reusable distributable specifications and references
├─ output/     Generated non-program public artifacts
├─ docs/       Repository-wide engineering and distribution guidance
└─ .github/    Source-owned execution manifest and central CI scripts
```

## Governance

Repository-wide rules are maintained in [`docs/`](docs/). Cross-repository PR governance, AI review, Gate, source policy, release policy, and organization-wide Agent Skills are owned by [Action Worker](https://github.com/fongap-labs/action-worker). The local `skills/` directory contains distribution assets only.

## Licensing

This repository uses mixed licensing. Original repository-authored material is licensed under the MIT terms unless stated otherwise. Third-party, derived, and generated assets retain their applicable upstream licenses.

For cross-repository App Releases governed by Action Worker, the default license is `Apache-2.0` when the source manifest does not declare another license. Each App / Release may explicitly override that default, and the effective license is recorded with that Release. The root repository [LICENSE](LICENSE) does not override an App Release license.

See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) for third-party attribution.
