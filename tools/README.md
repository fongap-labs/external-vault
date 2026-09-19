# Tools

`tools/` is the public catalog and distribution-metadata layer for released programs and utilities.

It does not store application source code or versioned binary payloads.

## Contents

- [catalog.json](catalog.json): machine-readable catalog entry point.

Current distributions:

- `open-code-review`: verified Linux amd64 mirror of stable OpenCodeReview releases. This repository verifies and packages upstream inputs; `fongap/action-worker` exclusively publishes the resulting GitHub Releases.

Future tool metadata should stay small and text-based.

Versioned executable payloads belong in GitHub Releases.

Generated reports, feeds, and datasets belong under `output/`.
