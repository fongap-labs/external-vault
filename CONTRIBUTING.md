# 贡献指南 —— external-vault

本仓库是组织的公共分发面：对外发布的应用 release、tag 与分发的第三方工具都汇集在这里。它不承载应用逻辑；贡献以"发布产物与分发清单"为主。

所有变更一律通过 Pull Request 进入 `main`（Squash merge）。组织级治理合同见 `fongap-labs/action-worker` 的 `docs/01_SHARED_GOVERNANCE.md`；本文只列贡献者立即需要的内容。

## 提交信息（Conventional Commits）

- 提交（即 Squash merge 后的 PR 标题）使用 `type(scope): summary` 格式，类型限定 11 种：`build`、`chore`、`ci`、`docs`、`feat`、`fix`、`perf`、`refactor`、`revert`、`style`、`test`。
- 破坏性变更用 `!` 或正文中的 `BREAKING CHANGE` 脚注声明；安全、迁移等以属性标注（`feat [security]:`）。
- 摘要使用英文工程文本；非 ASCII、`Merge`/`Revert` 以外的裸消息会被拒绝。
- 权威定义见 `fongap-labs/action-worker` 的 `docs/04_CHANGELOG_CONVENTIONS.md`；中央 PR 门禁执行同一套规则，本地的 `.githooks/commit-msg` 只是提前反馈。

本仓库的分发布局对顶层目录有严格清单，本地 git hooks 目录会被当作分发残留拒绝，因此提交格式的执行方是中央 PR 门禁；写错时门禁会给出应写的格式与示例。

## CHANGELOG

每个 PR 在 `CHANGELOG.md` 的 `[Unreleased]` 下新增一条中文条目：`- 类别: 中文摘要`，类别取自新增、变更、弃用、移除、修复、安全六类。

## 分发约定

- 各产品的 tag 遵循 `<release_key>-v<版本>` 前缀，`follow` 型产品按该前缀匹配上游发布。
- 发布产物进入 `releases/` 下的对应目录；第三方工具的镜像资产、校验和与元数据以既有目录结构为准。
- 分发清单变更（新增 / 移除资产、改 `release_key`）需要说明对下游跟随者的影响。
