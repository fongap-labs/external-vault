# Changelog

## [Unreleased]

- fix [security]: stop exempting the whole of `output/adfilter/adfilter.txt` from gitleaks; the file is scanned again and only lines made of lowercase CSS selector fragments such as `sk-cookie-message` (the known false positive) are allowed, so a real credential injected into the list is still reported.

- chore: add `SECURITY.md` with the reporting channel and the scope of this distribution repository, and remove the unused `CNAME` left from GitHub Pages (Pages is disabled; the domain resolves elsewhere).

- ci: when the runner has no gitleaks, the secret-scan step downloads the pinned gitleaks 8.30.1 release and verifies its SHA-256 (a mismatch fails the run) instead of silently falling back to the smaller built-in pattern list; `EXTERNAL_VAULT_OUTPUT_RETENTION_PERIODS` overrides the 14-period output retention limit (default unchanged).

- ci: add the approved thin PR dispatcher so pull request events reach central governance within about a minute; it runs no PR code and skips Dependabot.

- feat: enforce published manifest field allowlist, value blacklist, trailing newline and the 14-period output retention window in Central CI.
- feat: add gitleaks configuration and a fail-closed secret scanning step to Central CI.
- fix: strip residual gateway URLs and embedded source URLs from published brief manifests.
- docs: declare the published manifest contract and output retention window; correct layout listings.

- chore: refresh main write provenance after the billing outage recovery.

- fix: redact internal infrastructure details (gateway endpoint, request ids, tracebacks, memory addresses, internal source paths) from all published brief manifests.

- refactor [breaking]: centralize final merge governance through Action Worker.
- fix: exclude generated output artifacts from GitHub language statistics.
- refactor [breaking, migration]: hard cut central governance and release dispatch configuration names.

- feat: distribute verified OpenCodeReview stable releases through GitHub Releases.
