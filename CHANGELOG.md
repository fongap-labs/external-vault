# Changelog

## [Unreleased]

## [2.3.5](https://github.com/fongap-labs/external-vault/releases/tag/frf2-v2.3.5) - 2026-10-26

### 新增

- 发行目录补充 `secure-pigeon` 与 `workbuddy-cleaner`；发布缺少目录元数据时，中央 CI 失败。
- 注册 `r-base` 工具（CRAN R 4.6.0 源码包，SHA-256 固定）。镜像到 `r-base-v4.6.0` Release 前，须等 Action Worker 的 URL 分发模式在 main 上开启；上游文件与固定值不符则不发布。发行标题统一为 `R Base Package 4.6.0`。
- 工具同步改用已验证的 OpenCodeReview 稳定版 Release 分发。
- 中央 CI 强制校验已发布清单的字段白名单、值黑名单、末尾换行与 14 期输出保留窗口，并增加失败即关闭的 gitleaks 密钥扫描。
- 增加 `.github/CODEOWNERS`（整个仓库、`.github/` 与 `tools/` 的维护者）与 `SECURITY.md`（漏洞报告渠道与本仓库范围），删除已停用 GitHub Pages 遗留的 `CNAME`。

### 变更

- 许可证与第三方声明补齐 GPL-3.0、LGPL-3.0、CC BY 3.0、CC BY-SA 3.0 与 R 基础 GPL-2.0 原文；修正各列表的实际来源与许可证，删除失效链接，新增 `output/adfilter/NOTICE`。许可证问题仍标注为需法务审查。
- 中央 CI 改用通知桥接，main 推送后立即唤醒中央 Intake；加入薄 PR 分发器，PR 事件约一分钟内进入中央治理。
- 缺少 gitleaks 时下载固定版本 8.30.1 并校验 SHA-256，校验失败即终止运行；输出保留期可由 `EXTERNAL_VAULT_OUTPUT_RETENTION_PERIODS` 覆盖，默认值不变。
- `DISTRIBUTION_GOVERNANCE.md` 说明发布标签指向已验证的提交，默认分支 HEAD 未签名时工具同步延后发布；`CONTRIBUTING.md` 补充提交规范，发行布局不使用本地钩子，由中央 PR 门禁执行。
- 账单故障恢复后刷新 main 写入来源证明。
- [breaking] 最终合并治理集中到 Action Worker。
- [breaking, migration] 中央治理与发布分发的配置名称一次性切换，旧名称不再生效。

### 修复

- 脱敏所有已发布简报清单中的内部基础设施细节（网关端点、请求 ID、堆栈、内存地址、内部源路径），并去除网关地址与内嵌源地址。
- GitHub 语言统计排除生成的输出产物。

### 安全

- [security] 恢复对 `output/adfilter/adfilter.txt` 的密钥扫描，只放行已知误报（CSS 选择器片段与 cookie 同意 token），注入的真实凭据仍会被报告。

