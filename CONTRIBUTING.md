# 贡献指南

## 1. 提交类型

提交和合并请求标题只允许三种类型。

### ❌ 错误做法 / 反面教材

使用旧类型或图标前缀。

```text
docs: update release index
build: publish mirror
```

### ✅ 正确做法 / 规范范例

使用英文摘要和统一类型。

```text
feat: add distribution metadata
fix: correct artifact checksum
chore: update release index
```

破坏性变更以 `!` 标明，不设其他类型。

## 2. 中文变更记录

变更日志只能从单一文件读取。

### ❌ 错误做法 / 反面教材

使用片段或旧类别。

```text
changelog.d/release-update.md
- 变更: 更新镜像。
```

### ✅ 正确做法 / 规范范例

直接维护中文待发布记录。

```markdown
## [Unreleased]

- 修复: 修复发布资产校验和不一致的问题。
```

类别只允许新增、修复、维护；摘要不超过八十字。

## 3. 分发边界

只接受验证通过的分发资产。

### ❌ 错误做法 / 反面教材

直接上传未经校验的构建产物。

```text
本地文件 → releases/ → 对外分发
```

### ✅ 正确做法 / 规范范例

由中央核对来源与校验信息。

```text
受管源提交 → 中央构建 → 签名与校验 → releases/
```

产品标签采用 `<release_key>-v<版本>`。新增、移除资产或修改 `release_key` 时，必须评估跟随型产品的兼容影响。

## 4. 合并权限

所有变更必须通过中央门禁。

### ❌ 错误做法 / 反面教材

直接修改公开分发主分支。

```bash
git push origin HEAD:main
```

### ✅ 正确做法 / 规范范例

使用合并请求和中央来源证明。

```text
合并请求 → 中央门禁 → 主分支来源验证 → 分发
```

本仓库不维护本地提交钩子目录；共用规则只引用 [Action Worker](https://github.com/fongap-labs/action-worker/tree/main/docs)。
