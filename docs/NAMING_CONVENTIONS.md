# Naming Conventions

> One concept, one standard term.

These rules follow the shared conventions used by `fongap/action-worker`.

## Directories

Top-level public domains:

```text
docs/
tools/
skills/
output/
```

Do not create vague long-lived directories such as `common/`, `misc/`, `shared/`, `temp/`, `new/`, `final/`, or `latest/`.

Do not create `projects/` for program source.

## Files

Workflow, Shell, and test files use kebab-case.

Repository governance documents use uppercase snake case.

## Release keys

Every distributed program uses a stable lowercase kebab-case release key.

Example:

```text
agentdock
open-code-review
```

## Release tags

```text
<release-key>-v<semver>
```

Do not use bare `v<semver>` tags when multiple programs share this repository.

## Release assets

```text
<release-key>-<platform>-<arch>.<ext>
<release-key>-<platform>-<arch>.<ext>.sha256
```

## Engineering language

New or modified engineering-facing content uses English. Localized end-user documentation is exempt.
