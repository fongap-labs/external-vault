# 架构

`external-vault` 是公开分发与资产仓库，不是程序源码仓库。

## 归属边界

```text
source repositories
= program source
+ tests
+ build / package implementation
+ private project configuration

external-vault
= public distribution metadata
+ reusable public material
+ generated non-program public artifacts
+ GitHub Release payloads
+ thin governance entry points

action-worker
= shared governance
+ PR / Release / Deploy governance
+ cross-repository machine contracts
```

## 仓库结构

```text
external-vault/
├─ .github/            Execution manifest, central CI scripts and manifest allowlist
├─ docs/                Distribution-specific documentation
├─ tools/               Public tool catalog and distribution metadata
├─ skills/              Reusable public guidance and references
├─ output/              Generated non-program public artifacts
├─ AGENTS.md             Agent redirect
├─ CLAUDE.md             Repository Agent entry point
└─ README.md             Repository index
```

本仓库有意不包含程序源码目录。

## 分发流程

```text
source repository
      ↓
build / test / package
      ↓
release artifact + manifest
      ↓
run-release
      ↓
Action Worker
      ↓
external-vault GitHub Release
      ↓
tools/ catalog metadata
      ↓
public consumer
```

源仓库永远不需要目标仓库的写入凭据。

## 资产域

- `tools/`：已分发程序的小型文本元数据。
- `skills/`：可复用的规则、规范、提示词与参考资料。
- `output/`：生成的报告、Feed、规则数据、简报及其他非程序公开资产。
- GitHub Releases：可执行文件、安装包、程序压缩包、校验和与发布说明。

## 安全与稳定性

凭据保存在平台密钥存储中。公开资产不得暴露私有源码、日志、配置或密钥。第三方内容须保留其上游的许可与署名义务。

中央 CI 以失败即关闭（fail-closed）的方式执行本契约：已发布的 manifest 必须通过 `.github/manifest-allowlist.json` 中的字段允许列表与值黑名单，`.gitleaks.toml` 驱动密钥扫描，并放行脱敏占位符。

`main` 是受支持的公开基线。仓库结构应极少变动；生成的公开内容可以独立演进，同时保持源码与分发边界不变。
