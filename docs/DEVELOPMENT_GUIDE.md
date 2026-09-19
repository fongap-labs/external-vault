# Development Guide

## Before changing this repository

Confirm:

1. the change is distribution metadata, reusable public material, generated output, or repository governance;
2. program implementation does not belong in another source repository;
3. Action Worker does not already own the requested governance behavior;
4. GitHub Releases are used for versioned program payloads;
5. third-party licensing and attribution remain correct.

## Repository flow

```text
Inspect
→ Define ownership
→ Change metadata / docs / public assets
→ Run focused checks
→ Repository CI
→ Action Worker governance
→ Merge
```

## Source-project flow

```text
Implement in source repository
→ Test
→ Package
→ Build release artifact
→ Include release-manifest.json
→ Dispatch run-release
→ Action Worker verification
→ Publish to external-vault Release
→ Update tools/ metadata when required
```

The source repository owns its build and validation logic. It does not receive `external-vault` write credentials.

## Release assets

Use deterministic asset names. The source release manifest declares every asset and its SHA256. Action Worker generates matching `.sha256` Release assets and verifies them after publication.

Do not commit program release binaries to the Git tree.

## Workflow changes

Check minimal permissions, secret exposure, trigger trust boundaries, concurrency, target repository ownership, and whether the behavior belongs in Action Worker.

## Completion

- repository checks pass or failures are classified;
- `validate-merge` status is known;
- documentation matches the actual layout;
- stale source/build paths are removed;
- generated, Release, and third-party asset boundaries remain correct.
