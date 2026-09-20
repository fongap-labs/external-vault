# Distribution Governance

## Publication model

```text
private or dedicated source repository
        ↓
build + test + package
        ↓
release artifact + release-manifest.json
        ↓
repository_dispatch: run-release
        ↓
Action Worker release governance
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

The source repository owns build, test, package, signing, SBOM, and installer validation. It uploads a release artifact whose root contains:

```text
release-manifest.json
<declared release assets>
```

After the source build run completes successfully, the source repository sends only a minimal `run-release` task to Action Worker.

The source repository must not hold write credentials for `external-vault`.

Action Worker owns:

1. source repository allowlist validation;
2. source default-branch HEAD and successful `ci.yml` verification;
3. source build-run and artifact identity verification;
4. `release-manifest.json` and SHA256 validation;
5. target repository allowlist validation;
6. target-scoped Tag and Release collision checks;
7. publication with the centrally held `RELEASE_TOKEN`;
8. Release asset re-download verification and rollback.

The Release tag is created in the target repository. Source provenance is recorded separately and must not be confused with the target repository Tag commit.

## Principle

The public repository stores only what public consumers need to discover, download, verify, and understand published assets.
