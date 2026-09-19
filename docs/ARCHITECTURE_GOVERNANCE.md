# Architecture Governance

`external-vault` is a public distribution and asset repository, not a program source repository.

## Ownership boundary

```text
source repositories
= program source
+ tests
+ build and packaging logic
+ private project configuration

external-vault
= public distribution metadata
+ reusable public material
+ generated non-program public artifacts
+ GitHub Release payloads
+ thin governance entry points

action-worker
= cross-repository PR governance
+ AI review
+ source and release policy
+ Gate
+ shared governance contracts
```

Do not duplicate source-project implementation or Action Worker policy here.

## Domains

### tools/

Small text-based catalog and distribution metadata for publicly consumable programs and utilities.

It must not become a source-code mirror or binary archive.

### skills/

Reusable public rules, specifications, prompts, and references.

### output/

Generated or directly consumable non-program artifacts such as reports, feeds, rule data, and briefs.

### docs/

Repository-wide engineering and distribution rules.

### GitHub Releases

Canonical storage for versioned executables, installers, program archives, checksum files, and release notes.

## Security

- Keep credentials in platform secret stores.
- Do not commit tokens, private keys, OAuth state, or generated credential files.
- Public Release assets must not expose private source, logs, configuration, or secrets.
- Third-party content retains its original licensing and attribution requirements.

## Stability

`main` is the supported public baseline.

Repository structure should change rarely. Public metadata and generated artifacts may evolve independently as long as the source/distribution boundary remains intact.
