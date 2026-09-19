# Documentation

Repository-wide engineering and distribution guidance for `external-vault`.

Agents must first follow the root [CLAUDE.md](../CLAUDE.md).

| Document | Purpose |
| --- | --- |
| [ARCHITECTURE_GOVERNANCE.md](ARCHITECTURE_GOVERNANCE.md) | Long-term repository ownership and boundaries |
| [DISTRIBUTION_GOVERNANCE.md](DISTRIBUTION_GOVERNANCE.md) | Source-to-Release publication model |
| [ARCHITECTURE.md](ARCHITECTURE.md) | Current repository structure |
| [NAMING_CONVENTIONS.md](NAMING_CONVENTIONS.md) | Naming rules for files, releases, workflows, and metadata |
| [CHANGELOG_CONVENTIONS.md](CHANGELOG_CONVENTIONS.md) | Shared change classification |
| [DEVELOPMENT_GUIDE.md](DEVELOPMENT_GUIDE.md) | Change, verification, and publication workflow |

Authority order:

```text
ARCHITECTURE_GOVERNANCE
        ↓
DISTRIBUTION_GOVERNANCE
        ↓
ARCHITECTURE
        ↓
NAMING_CONVENTIONS
        ↓
DEVELOPMENT_GUIDE
        ↓
README
```

Cross-repository governance contracts remain authoritative in `fongap/action-worker`.
