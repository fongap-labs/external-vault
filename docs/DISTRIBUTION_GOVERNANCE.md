# 分发治理

本文定义从源仓库到 `external-vault` GitHub Release 的发布流程，以及分发专属的不变量。

## 发布模型

```text
source repository + release manifest
        ↓
Action Worker source / CI admission
        ↓
central build + test + package
        ↓
release artifact + release provenance
        ↓
Action Worker Release Governance
        ↓
external-vault GitHub Release
        ↓
tools/ metadata
        ↓
public download
```

程序源码不属于 `external-vault`。

## GitHub Releases

GitHub Releases 是以下内容的规范位置：

- 可执行文件；
- 安装包；
- ZIP/TAR 程序包；
- 平台专属包；
- 校验和文件；
- 发布说明。

不要将版本化的程序产物提交到 Git 树中。

## Release 标签与验证

Release 标签指向一个提交。只有该提交带有有效签名时，GitHub 才会在 Release 上显示已验证（verified）徽章，因此流水线生成的 Release 必须指向已签名的提交。工具同步（tool sync，参见 Action Worker 的工具同步）在默认分支 HEAD 没有有效签名时会推迟发布。此规则生效前创建的 Release 可能指向未签名的提交；未经 owner 批准，不得移动这些标签。

## tools/

`tools/` 是目录与元数据层。

工具条目可以描述：

- release key；
- 显示名称；
- 稳定版本；
- 预发布版本；
- 支持的平台与架构；
- Release 资产名；
- 校验和元数据；
- 许可证与上游归属信息。

保持元数据小巧、确定、基于文本。

## 已发布 manifest

`output/**/manifest.json` 是已发布的简报输出。发布路径与中央 CI 以失败即关闭（fail-closed）的方式执行 `.github/manifest-allowlist.json`：

- 字段允许列表：任何不在 `allowed_keys` 中的字段都会使门禁失败；
- 对所有字符串值执行黑名单检查：traceback 模式、`0x` 十六进制地址与 Windows 路径；
- 对除 `url_fields`（`url`、`fetch_url`、`body_markdown`）以外的所有字段执行 URL 与用户路径黑名单；
- `url` 与 `fetch_url` 的值必须以 `http(s)://` 开头；
- 文件末尾必须有换行符。

`model`、`total_tokens`、`quality_score` 与 `elapsed_sec` 等流水线遥测字段已被显式加入允许列表，可以发布。扩展 `allowed_keys`、`url_fields` 或黑名单，需要经过分发治理评审。

## 输出保留

Git 树中每个项目在 `output/` 下最多保留最新的 14 个周期。默认值为 14，可通过中央 CI 的环境变量 `EXTERNAL_VAULT_OUTPUT_RETENTION_PERIODS` 覆盖。发布流水线会清理更早的周期；长期历史应保存在 GitHub Releases 或归档中，而非 Git 树。超出保留窗口时，中央 CI 会失败。

## Release 命名

共享分发仓库使用按产品划分的标签：

```text
<release-key>-v<semver>
```

示例：

```text
agentdock-v0.1.0
open-code-review-v0.4.2
```

推荐的资产命名模式：

```text
<release-key>-<platform>-<arch>.<ext>
<release-key>-<platform>-<arch>.<ext>.sha256
```

## 跨仓库发布

源仓库负责产品源码、项目专属构建脚本、测试，以及受版本控制的 `.github/release.manifest.json`（该文件不含版本号）。源仓库不上传受治理的发布产物本身。

发布主流程由 Action Worker 负责：

1. 源仓库能力与不可变的默认分支源码校验；
2. 可信的中央 CI 证据（CI Evidence）与主分支写入保护（Main Write Guard）校验；
3. 源仓库自有的 release manifest 校验；
4. 中央解析的构建 Runner，以及源仓库自有构建脚本的执行；
5. 产物打包、可选的签名 / attestation / SBOM 步骤、release manifest 物化，以及 Release 来源证明（provenance）；
6. 目标仓库能力校验；
7. 限定于目标仓库的 Tag 与 Release 冲突检查；
8. 使用中央持有的目标仓库凭据执行发布；
9. 重新下载 Release 资产进行验证，并支持回滚。

源仓库不得持有 `external-vault` 的写入凭据。

Release 标签在目标仓库中创建。源来源证明（provenance）需单独记录，不得与目标仓库 Tag 指向的提交相混淆。

## 原则

公开仓库只存放公众消费者用于发现、下载、验证和理解已发布资产所需的内容。


## Self-distribution

A product may declare its own repository as the `target_repository` in its `release.manifest.json` and self-distribute its releases there. The tag convention `<release_key>-v<version>` applies to both this repository and a self-distributing repository. The `tools/` catalogue in this repository is the discovery layer for releases distributed here; a self-distributing product does not need a `tools/<key>/tool.json` entry here, but should state its distribution point in its own README.
