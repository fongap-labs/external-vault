# Changelog Conventions

Use one shared change classification across PR titles, changelogs, and releases:

```text
feat
fix
docs
style
refactor
perf
test
build
ci
chore
revert
```

Optional attributes such as `breaking`, `security`, and `migration` describe impact; they do not replace the change type.

Repository-only documentation or governance changes normally use `docs`, `ci`, or `chore`.

Program changelogs remain in their owning source repositories. Release notes published here may summarize source changelogs but must not become a second implementation history.

Generated output does not require changelog entries unless the generation contract or published behavior changes.
