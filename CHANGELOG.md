# Changelog

## [Unreleased]

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
