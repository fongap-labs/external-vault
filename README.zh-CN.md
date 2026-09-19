# external-vault

[English](README.md) · [简体中文](README.zh-CN.md)

[![Repository CI](https://github.com/fongap/external-vault/actions/workflows/ci.yml/badge.svg)](https://github.com/fongap/external-vault/actions/workflows/ci.yml)
[![Dispatch PR Governance](https://github.com/fongap/external-vault/actions/workflows/dispatch-pr-governance.yml/badge.svg)](https://github.com/fongap/external-vault/actions/workflows/dispatch-pr-governance.yml)
[![Release](https://img.shields.io/github/v/release/fongap/external-vault?label=Release&display_name=tag&sort=semver)](https://github.com/fongap/external-vault/releases)

**公开发布、可复用资产与分发元数据，不承载程序源码。**

程序源码、测试与构建逻辑保留在各自源仓库。本仓库只保留公开分发元数据、可复用资料、生成型非程序资产，以及通过 GitHub Releases 发布的版本化程序产物。

## 分发入口

| 位置 | 用途 |
| --- | --- |
| [Releases](https://github.com/fongap/external-vault/releases) | 版本化可执行文件、安装包、压缩包、校验文件与发布说明 |
| [`tools/`](tools/) | 公开工具目录与分发元数据 |
| [`output/`](output/) | 自动生成、可直接使用的非程序资产 |

## 仓库内容

| 路径 | 用途 |
| --- | --- |
| [`tools/`](tools/) | 工具索引与小型文本分发元数据 |
| [`skills/`](skills/) | 可复用规则、规范、提示词与参考资料 |
| [`output/`](output/) | 报告、Feed、规则数据、简报等公开生成物 |
| [`docs/`](docs/) | 仓库级工程与分发规范 |
| [`.github/`](.github/) | CI 与治理入口 |

## 发布约定

GitHub Releases 是版本化程序产物的唯一正式分发位置。Release Tag 按产品隔离：

```text
<release-key>-v<semver>
```

例如：`agentdock-v0.1.0`。

程序源码、构建逻辑和二进制产物不进入 Git 树。

## 目录结构

```text
external-vault/
├─ tools/      工具目录与分发元数据
├─ skills/     可复用规则、规范与参考资料
├─ output/     生成型非程序公开资产
├─ docs/       仓库级工程与分发规范
└─ .github/    CI 与治理入口
```

## 治理

仓库级规范位于 [`docs/`](docs/)。跨仓 PR Governance、AI Review、Gate、Source Policy 与 Release Policy 统一交由 [Action Worker](https://github.com/fongap/action-worker)。

## 授权

本仓库采用混合授权。除非另有说明，本仓库原创内容按 MIT 条款授权；第三方、衍生与生成型资产继续遵循各自上游许可。

由 Action Worker 管理的跨仓 App Release，在源 manifest 未声明其他许可证时默认采用 `Apache-2.0`。每个 App / Release 都可以显式覆盖该默认值，实际许可证随对应 Release 记录；本仓库根目录 [LICENSE](LICENSE) 不覆盖各 App 的 Release 许可证。

第三方归属与许可见 [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)。
