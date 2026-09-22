---
name: iconify-local
description: 图标搜索与本地化技能，将 SVG 图标下载到项目 assets/icons/ 目录，避免运行时 CDN 依赖。
---

# iconify-local: 图标本地化技能

## 用途

从 Iconify 搜索图标并下载 SVG 到本地，确保项目 UI 不依赖运行时图标 CDN。

## 使用方式

1. 搜索图标：访问 https://icon-sets.iconify.design/ 查找需要的图标
2. 下载脚本：运行 `./scripts/fetch-icons.sh` 下载 SVG 文件
3. 输出目录：`assets/icons/`
4. 索引文件：`assets/icons/index.json`

## 目录结构

```
assets/icons/
├── lucide-home.svg
├── lucide-user.svg
├── ...
└── index.json
```

## 设计铁律

- ❌ 禁止手撸 SVG 图标
- ❌ 禁止运行时依赖图标 CDN
- ✅ 使用 fetch-icons.sh 批量下载