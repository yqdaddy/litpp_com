# litpp.com 项目配置

> CTO 的 AI 实验场官网，基于 Astro 构建的纯静态站点

---

## 技术栈

| 类别 | 技术 |
|------|------|
| 框架 | Astro |
| 语言 | TypeScript |
| 内容 | Markdown |
| 部署 | GitHub Pages |

---

## 项目结构

```
src/
├── pages/        # 页面路由
├── components/   # UI 组件
├── layouts/      # 布局模板
└── styles/       # 样式文件
public/           # 静态资源
```

---

## Agent 团队

| Agent | 职责 | 调用方式 |
|-------|------|---------|
| @dev-lp-frontend-developer | 前端开发 | `@dev-lp-frontend-developer 任务描述` |
| @dev-lp-ui-designer | UI 设计 | `@dev-lp-ui-designer 任务描述` |
| @dev-lp-code-reviewer | 代码审查 | `@dev-lp-code-reviewer 审查目标` |
| @dev-lp-reality-checker | 独立验证 | `@dev-lp-reality-checker 验证目标` |

---

## 使用指南

### 开始开发任务
```
/dev-lp "实现 XXX 功能"
```

### 协调工作流
主 agent 会自动协调团队成员：
1. 分析任务 → 选择合适的 agent
2. 执行任务 → 独立验证
3. 汇报结果 → 提供证据

### 核心原则
- **专业分工**：主 agent 只协调，专业 agent 执行
- **独立验证**：执行者不能验证自己的产出
- **证据驱动**：不接受"应该可以"，必须有验证证据

---

## 协调 Skill

使用 `/dev-lp` 触发项目协调工作流。

---

## 注意事项

1. 这是一个纯静态站点，无后端 API
2. 部署到 GitHub Pages，注意路径配置
3. 内容以 Markdown 为主，支持 MDX