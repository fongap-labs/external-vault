# Distribution Governance

## Publication model

```text
source repository + release manifest
        ↓
Action Worker source / CI admission
        ↓
central build + test + package
        ↓
release artifact + release provenance
        ↓
Action Worker Release Governance
        ↓
external-vault GitHub Release
        ↓
tools/ metadata
        ↓
public download
```

Program source code does not belong in `external-vault`.

## GitHub Releases

GitHub Releases are the canonical location for:

- executables;
- installers;
- ZIP/TAR program packages;
- platform-specific packages;
- checksum files;
- release notes.

Do not commit versioned program payloads into the Git tree.

## tools/

`tools/` is the catalog and metadata layer.

A tool entry may describe:

- release key;
- display name;
- stable version;
- prerelease version;
- supported platforms and architectures;
- Release asset names;
- checksum metadata;
- license and upstream attribution.

Keep metadata small, deterministic, and text-based.

## Release naming

A shared distribution repository uses product-scoped tags:

```text
<release-key>-v<semver>
```

Examples:

```text
agentdock-v0.1.0
open-code-review-v0.4.2
```

Preferred asset pattern:

```text
<release-key>-<platform>-<arch>.<ext>
<release-key>-<platform>-<arch>.<ext>.sha256
```

## Cross-repository publication

The source repository owns product source, project-specific build scripts, tests, and the versioned `.github/release.manifest.json`. It does not upload the governed release artifact itself.

Action Worker owns the heavy release path:

1. source repository capability and immutable default-branch source validation;
2. trusted Central CI Evidence and Main Write Guard validation;
3. source-owned release manifest validation;
4. centrally resolved build runners and source-owned build script execution;
5. artifact packaging, optional signing/attestation/SBOM steps, release manifest materialization, and release provenance;
6. target repository capability validation;
7. target-scoped Tag and Release collision checks;
8. publication with centrally held target credentials;
9. Release asset re-download verification and rollback.

The source repository must not hold write credentials for `external-vault`.

The Release tag is created in the target repository. Source provenance is recorded separately and must not be confused with the target repository Tag commit.

## Principle

The public repository stores only what public consumers need to discover, download, verify, and understand published assets.
