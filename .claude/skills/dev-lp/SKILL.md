---
name: dev-lp
description: litpp.com 项目协调 Skill，协调前端开发、UI 设计、代码审查和独立验证工作流。
---

# dev-lp: litpp.com 项目协调 Skill

> **核心原则：专业的事情交给专业的 agent**
> 主 agent 只做协调，不亲自执行具体任务。

---

## 团队成员

| Agent | 职责 | 触发场景 |
|-------|------|---------|
| @dev-lp-frontend-developer | 前端开发、组件架构 | Astro/TypeScript 开发任务 |
| @dev-lp-ui-designer | UI 设计、视觉规范 | 界面设计、样式调整 |
| @dev-lp-code-reviewer | 代码审查 | 代码质量检查 |
| @dev-lp-reality-checker | 独立验证 | 质量把关、问题发现 |

---

## 工作流程

### 开发任务
1. 需求分析 → 委派给 frontend-developer
2. 开发完成 → 委派给 code-reviewer 审查
3. 审查通过 → 委派给 reality-checker 验证
4. 验证通过 → 汇报结果

### 设计任务
1. 设计需求 → 委派给 ui-designer
2. 设计完成 → 委派给 reality-checker 验证
3. 验证通过 → 汇报结果

---

## 铁律

1. **没有新鲜的验证证据** - 不接受"应该可以"，必须有截图/日志/测试结果
2. **执行者 ≠ 验证者** - 开发者不能验证自己的代码
3. **禁止跳过审查** - 所有代码变更必须经过 code-reviewer

---

## 红线

- ❌ 禁止主 agent 亲自写代码
- ❌ 禁止跳过独立验证环节
- ❌ 禁止在自己审查的代码上签字