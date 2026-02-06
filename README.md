# litpp.com

CTO 的 AI 实验场官网。基于 Astro 构建的纯静态站点。

## 项目定位

这不是个人简历，也不是工具导航站。

这是一个 CTO 把 AI、产品、工程串起来的实验场，用于：

- AI 工程化实践记录
- 产品与系统构建展示
- 实验性项目与小游戏入口
- 长期技术博客输出

## 技术栈

- [Astro](https://astro.build/) — 静态站点生成
- Markdown / Content Collections — 博客内容管理
- GitHub Pages — 部署

## 页面结构

| 路径 | 说明 |
|------|------|
| `/` | 首页，实验场定位 + 入口 |
| `/blog` | 博客列表，支持分类 |
| `/products` | 产品与系统展示 |
| `/lab` | 实验场聚合页 |
| `/contact` | 联系方式 |

子域名：
- `game.litpp.com` — 数学工具 / 小游戏（独立仓库）

## 如何写博客

在 `src/content/blog/` 下新建 `.md` 文件，frontmatter 格式：

```yaml
---
title: "文章标题"
description: "一句话描述"
date: 2025-03-01
category: "分类名"
tags: ["标签1", "标签2"]
draft: false
---
```

文章内容使用标准 Markdown 语法。设置 `draft: true` 可隐藏未完成的文章。

## 本地开发

```bash
# 安装依赖
npm install

# 启动开发服务器
npm run dev

# 构建生产版本
npm run build

# 预览构建结果
npm run preview
```

## 部署到 GitHub Pages

1. 构建：`npm run build`
2. 产物在 `dist/` 目录
3. 配置 GitHub Pages 使用 GitHub Actions 或直接部署 `dist/` 目录

推荐使用 GitHub Actions 自动部署，在 `.github/workflows/` 中配置即可。

## 项目结构

```
src/
├── components/     # 组件（Header, Footer, SEO）
├── content/
│   └── blog/       # 博客 Markdown 文件
├── layouts/        # 页面布局（Base, Post）
├── pages/          # 页面路由
├── styles/         # 全局样式
├── consts.ts       # 站点常量
└── content.config.ts # 内容集合配置
```

## 维护说明

- 日常更新只需编辑 `src/content/blog/` 下的 Markdown 文件
- 产品信息在 `src/pages/products.astro` 中维护
- 实验场项目在 `src/pages/lab.astro` 中维护
- 站点全局信息在 `src/consts.ts` 中配置
