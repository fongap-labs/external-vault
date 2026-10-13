# external-vault

[![Release](https://img.shields.io/github/v/release/fongap-labs/external-vault?label=Release&display_name=tag&sort=semver)](https://github.com/fongap-labs/external-vault/releases)

**公开发布、可复用资产与分发元数据，不承载程序源码。**

程序源码、测试与构建逻辑保留在各自的源仓库中。本仓库只保留公开分发元数据、可复用资料、生成型非程序资产，以及通过 GitHub Releases 发布的版本化程序产物。

## 分发入口

| 位置 | 用途 |
| --- | --- |
| [Releases](https://github.com/fongap-labs/external-vault/releases) | 版本化可执行文件、安装包、压缩包、校验文件与发布说明 |
| [`tools/`](tools/) | 公开工具目录与分发元数据 |
| [`output/`](output/) | 自动生成、可直接使用的非程序资产 |

## 仓库内容

仓库根目录包含以下五个目录：

| 路径 | 用途 |
| --- | --- |
| [`tools/`](tools/) | 工具索引与小型文本分发元数据 |
| [`skills/`](skills/) | 可复用的分发型规范与参考资料；组织级 Agent 行为由 Action Worker 管理 |
| [`output/`](output/) | 报告、Feed、规则数据、简报等公开生成物 |
| [`docs/`](docs/) | 仓库级工程与分发规范 |
| [`.github/`](.github/) | 源仓库执行清单（manifest）与中央 CI 脚本 |

## 发布约定

GitHub Releases 是版本化程序产物的规范位置（canonical location）。Release 标签按产品划分，格式如下：

```text
<release-key>-v<semver>
```

示例：`agentdock-v0.1.0`。

程序源码、构建逻辑与二进制产物不进入 Git 树。

## 治理

仓库级规范维护在 [`docs/`](docs/) 中。跨仓库的 PR 治理、AI 评审（AI Review）、门禁（Gate）、源码策略（Source Policy）、Release 策略与组织级 Agent Skills 由 [Action Worker](https://github.com/fongap-labs/action-worker) 统一管理。本仓库的 `skills/` 目录仅包含分发资产。

## 授权

本仓库采用混合授权。除非另有说明，本仓库原创内容按 MIT 条款授权；第三方、衍生与生成型资产继续遵循各自上游的许可条款。

由 Action Worker 管理的跨仓库 App Release，若源仓库 manifest 未声明其他许可证，则默认采用 `Apache-2.0`。每个 App / Release 均可显式覆盖该默认值，实际生效的许可证随对应 Release 记录。根目录的 [LICENSE](LICENSE) 不覆盖 App Release 的许可证。

第三方归属与许可信息见 [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)。
