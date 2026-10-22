# 工具

`tools/` 是已发布程序与实用工具的公开目录层与分发元数据层。

它不存放应用源码，也不存放版本化的二进制产物。

## 目录内容

- [catalog.json](catalog.json)：机器可读的目录入口。

当前分发的工具：

- `open-code-review`：已验证的 Linux amd64 镜像，同步上游 OpenCodeReview 的稳定版本。本仓库负责校验与打包上游输入；GitHub Releases 仅由 `fongap-labs/action-worker` 唯一发布。
- `r-base`（R Base Package）：CRAN R 4.6.0 源码压缩包，以 URL 方式分发，SHA-256 固定于 [`r-base/tool.json`](r-base/tool.json)。仅当 Action Worker 的 URL 分发模式在 `main` 上启用后，工具同步才会将该文件镜像到 `r-base-v4.6.0` Release。许可证文本（上游 `COPYING`）随本目录一并分发于 [`r-base/LICENSE`](r-base/LICENSE)。
- `secure-pigeon`（SecurePigeon）：Windows x64 专有发行版，来源仓库 `fongap-labs/app-source`；资产名、校验和资产与许可证元数据见 [`secure-pigeon/tool.json`](secure-pigeon/tool.json)。
- `workbuddy-cleaner`（WorkBuddyCleaner）：Windows x64 便携工具包，来源仓库 `fongap-labs/app-source`；资产名、校验和资产与许可证元数据见 [`workbuddy-cleaner/tool.json`](workbuddy-cleaner/tool.json)。

后续的工具元数据应保持小巧、基于文本。

可执行文件的版本化载荷属于 GitHub Releases。

生成的报告、Feed 与数据集属于 `output/`。
