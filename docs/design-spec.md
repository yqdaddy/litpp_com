# 码孖 litpp.com 重设计方案

> 本文档面向前端开发者，无需再做设计决策，照此执行即可。

---

## 0. Design Read（一句话判读）

把本站读作：面向中文技术读者与潜在合作方的 CTO 个人品牌站（作品集 + 编辑部混合体），以**纸墨编辑语言**呈现，原生 CSS 实现，克制动效。

**设计方向命名**：「纸墨编辑部」——像一本持续出版的工程期刊，而非暗色科技模板。

---

## 1. 现状问题清单（Audit）

| 问题 | 来源 | taste-skill 规则 |
|------|------|------------------|
| 三等分等宽卡片布局 | index / contact | NO 3-column equal feature cards |
| mono 字体滥用 | 全站按钮、标签、section-title | Typography discipline：mono 仅用于代码/数字 |
| `//` 前缀的伪代码感 | section-title::before | AI Tell：代码风格装饰 |
| 单一青绿 accent + 深黑底 | global.css | Dark tech 套路痕迹 |
| 所有 section 结构同质化 | 各页 | Section-Layout-Repetition Ban |
| 无字体对比，无编辑感 | 全站 | Typography 层级缺失 |
| Em-dash 在文案中 | 多处 | 完全禁止 |
| 中间点（·）过量 | Footer | rationed，最多每行 1 个 |
| 中文斜体 | products 高亮 | 中文字体无真正的 italic，禁止 font-style: italic |

---

## 2. Dials（设计参数）

| Dial | 值 | 推理 |
|------|---|------|
| `DESIGN_VARIANCE` | 6 | 开发者作品集 6 + Editorial 6，重设计 overhaul 不再叠加，保持克制的不对称 |
| `MOTION_INTENSITY` | 3 | 纯静态站 + 内容优先，仅 CSS 过渡 + Hero 入场动画，无 scroll JS |
| `VISUAL_DENSITY` | 3 | 编辑部风格：大方留白，section 间距 96px |

---

## 3. 设计方向：纸墨编辑部

### 3.A 核心概念

- **纸**：暖调米白/灰白底，模拟出版物纸张质感
- **墨**：暖黑正文色，模拟墨迹
- **朱砂**：单 accent，模拟传统印章红，文化辨识度
- **思源宋体**：标题专用，营造编辑感；正文保持系统无衬线

### 3.B 为什么不做暗色科技风

- 当前「暗黑 + mono + 青绿 accent」正是 taste-skill 点名的 dark tech 套路
- 内容属性是「思考 / 方法论 / 写作」，更适合编辑出版语言
- 朱砂 + 纸墨在中文技术站中高度区分，不与 AI 紫渐变同质

### 3.C 主题策略

- **默认浅色**：品牌核心表达
- **支持 `prefers-color-scheme: dark`**：遵循系统偏好，暗色变体通过媒体查询切换 token，不反色

---

## 4. Design Tokens（CSS 变量）

以下 CSS 可直接粘贴到 `src/styles/global.css` 头部。

```css
:root {
  /* === 色彩：纸与墨（浅色默认主题） === */
  --color-bg: #FAF9F6;
  --color-bg-alt: #F1EFE8;
  --color-surface: #FFFFFF;
  --color-ink: #1C1B18;
  --color-ink-2: #57544C;
  --color-ink-3: #6E6A60;
  --color-border: #E4E1D7;          /* 装饰分隔线 */
  --color-border-strong: #8F8A7C;   /* 交互边框（满足 3:1） */
  --color-accent: #BC3F2C;          /* 朱砂红 */
  --color-accent-hover: #9A3323;
  --color-accent-soft: rgba(188, 63, 44, 0.08);
  --color-accent-contrast: #FFFFFF; /* 按钮文字色 */
  --color-ok: #2E7D4F;              /* 运行中 */
  --color-ok-soft: rgba(46, 125, 79, 0.10);
  --color-warn: #8A5A0A;            /* 实验中 / 即将上线 */
  --color-warn-soft: rgba(138, 90, 10, 0.10);
  --color-glass: rgba(250, 249, 246, 0.88);

  /* === 字体 === */
  --font-serif: "Noto Serif SC", "Songti SC", "STSong", "SimSun", serif;
  --font-sans: system-ui, -apple-system, "Segoe UI", Roboto, "PingFang SC", "Hiragino Sans GB", "Microsoft YaHei", sans-serif;
  --font-mono: ui-monospace, "SF Mono", "Cascadia Mono", Menlo, Consolas, monospace;

  /* === 字号（editorial scale） === */
  --text-display: clamp(2.5rem, 1.2rem + 4.5vw, 3.75rem);
  --text-h1: clamp(2rem, 1.1rem + 3vw, 2.75rem);
  --text-h2: clamp(1.5rem, 1.2rem + 1.2vw, 1.875rem);
  --text-h3: 1.25rem;
  --text-md: 1.0625rem;
  --text-base: 1rem;
  --text-sm: 0.875rem;
  --text-meta: 0.8125rem;
  --text-tag: 0.75rem;
  --leading-body: 1.85;
  --leading-tight: 1.35;
  --leading-display: 1.2;

  /* === 间距（4px 网格） === */
  --space-1: 4px;
  --space-2: 8px;
  --space-3: 12px;
  --space-4: 16px;
  --space-5: 24px;
  --space-6: 32px;
  --space-7: 48px;
  --space-8: 64px;
  --space-9: 96px;
  --section-y: var(--space-9);
  --gutter: clamp(20px, 4vw, 32px);

  /* === 结构 === */
  --container: 1120px;
  --header-h: 64px;
  --radius-sm: 2px;
  --radius-md: 4px;

  /* === 动效 === */
  --ease-out-quiet: cubic-bezier(0.22, 1, 0.36, 1);
  --dur-1: 150ms;
  --dur-2: 240ms;
  --dur-3: 420ms;

  /* === 层级 === */
  --z-header: 100;
}

/* === 暗色主题（遵循系统偏好） === */
@media (prefers-color-scheme: dark) {
  :root {
    --color-bg: #171613;
    --color-bg-alt: #1D1B17;
    --color-surface: #201E19;
    --color-ink: #E9E6DE;
    --color-ink-2: #A29D92;
    --color-ink-3: #8A8578;
    --color-border: #322F28;
    --color-border-strong: #6E6858;
    --color-accent: #DC6B4F;
    --color-accent-hover: #E57B5F;
    --color-accent-soft: rgba(220, 107, 79, 0.12);
    --color-accent-contrast: #171613;
    --color-ok: #5CB47E;
    --color-ok-soft: rgba(92, 180, 126, 0.12);
    --color-warn: #D9A441;
    --color-warn-soft: rgba(217, 164, 65, 0.12);
    --color-glass: rgba(23, 22, 19, 0.88);
  }
}
```

### 4.A Token 迁移对照表

| 旧变量 | 新变量 | 说明 |
|--------|--------|------|
| `--color-bg` | `--color-bg` | 重定义色值 |
| `--color-bg-secondary` | `--color-bg-alt` | 命名统一 |
| `--color-bg-card` | `--color-surface` | 语义化 |
| `--color-text` | `--color-ink` | 编辑部隐喻 |
| `--color-text-secondary` | `--color-ink-2` | |
| `--color-text-muted` | `--color-ink-3` | |
| `--color-accent` | `--color-accent` | 重定义色值 |
| `--color-accent-dim` | `--color-accent-soft` | 命名统一 |
| `--font-sans` | `--font-sans` | 扩展 CJK 入口 |
| `--font-mono` | `--font-mono` | 保持，但**严格限制使用** |
| `--max-width` | `--container` | 重命名 |
| `--transition` | 删除 | 用 dur/ease 组合替代 |

---

## 5. 排版体系

### 5.A 字体栈

| 用途 | 字体 | 使用规则 |
|------|------|----------|
| **标题（H1-H3）** | Noto Serif SC 700/900 | 仅用于 display、页面主标题、section 标题、文章标题、品牌名 |
| **正文 / UI 文字** | 系统无衬线 | 全站默认，包含按钮、导航、描述文字、标签 |
| **代码 / 数字** | 系统等宽 | `<code>`、`<pre>`、日期、状态标签中的数字 |
| **禁用** | Inter | 铁律 |

### 5.B Noto Serif SC 加载策略

**推荐：自托管子集化**

主域名在中国大陆有 ICP 备案，Google Fonts 在大陆不可靠。采用 `cn-font-split` 自托管：

1. 下载 Noto Serif SC（仅 600、900 两个字重）from Google Fonts GitHub
2. 运行：
   ```bash
   npx cn-font-split -i NotoSerifSC-SemiBold.otf -o public/fonts/serif-600 --family "Noto Serif SC"
   npx cn-font-split -i NotoSerifSC-Black.otf    -o public/fonts/serif-900 --family "Noto Serif SC"
   ```
3. 生成的 CSS 在 `Base.astro` head 引入：
   ```html
   <link rel="stylesheet" href="/fonts/serif-600/result.css">
   <link rel="stylesheet" href="/fonts/serif-900/result.css">
   ```
4. 确认生成的 CSS 含 `font-display: swap;`

**备选：Google Fonts（接受大陆不可达风险）**

```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+SC:wght@600;900&display=swap" rel="stylesheet">
```

### 5.C 字号阶梯与使用规则

| Token | 尺寸 | 用途 | 行高 | 字重 |
|-------|------|------|------|------|
| `--text-display` | 40-60px | Hero 主标题 | 1.2 | 900 |
| `--text-h1` | 32-44px | 页面主标题 | 1.25 | 700 |
| `--text-h2` | 24-30px | Section 标题 | 1.3 | 700 |
| `--text-h3` | 20px | 卡片/条目标题 | 1.35 | 700 |
| `--text-md` | 17px | Hero 描述文字 | 1.85 | 400 |
| `--text-base` | 16px | 正文 | 1.85 | 400 |
| `--text-sm` | 14px | 次级正文 | 1.7 | 400 |
| `--text-meta` | 13px | 日期、标签、辅助信息 | 1.5 | 500 |
| `--text-tag` | 12px | 标签 | 1.4 | 500 |

### 5.D 中文排版细节

- **禁止中文斜体**：`font-style: italic` 对中文无效且难看，全站禁用
- **标题避免行首标点**：通过 `<br>` 控制换行位置，不让逗号/句号出现在行首
- **中英文间距**：渐进增强 `text-autospace: normal;`（Chrome 120+ 支持），不阻塞
- **数字等宽**：日期、数量使用 `font-variant-numeric: tabular-nums;`

---

## 6. 布局体系

### 6.A 全局结构

```css
.container {
  max-width: var(--container);
  margin: 0 auto;
  padding-left: var(--gutter);
  padding-right: var(--gutter);
}

.section {
  padding-top: var(--section-y);
  padding-bottom: var(--section-y);
}

.section-head {
  display: flex;
  align-items: baseline;
  justify-content: space-between;
  gap: var(--space-4);
  padding-bottom: var(--space-5);
  border-bottom: 1px solid var(--color-border-strong);
}

.section-head h2 {
  font-family: var(--font-serif);
  font-size: var(--text-h2);
  font-weight: 700;
  color: var(--color-ink);
  margin: 0;
}
```

### 6.B 网格变体（按需使用）

```css
/* 不对称 7:5 分栏 */
.grid-7-5 {
  display: grid;
  grid-template-columns: 7fr 5fr;
  gap: var(--space-5);
}

/* 不对称 5:7 分栏 */
.grid-5-7 {
  display: grid;
  grid-template-columns: 5fr 7fr;
  gap: var(--space-5);
}

/* Bento 1+2（主页正在做的事） */
.pillars {
  display: grid;
  grid-template-columns: 7fr 5fr;
  grid-template-rows: auto auto;
  gap: var(--space-4);
}
.pillar-main {
  grid-row: 1 / 3;
}

/* 2 列声明式网格 */
.creed-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: var(--space-7);
}

/* 响应式统一规则 */
@media (max-width: 768px) {
  .grid-7-5, .grid-5-7, .pillars, .creed-grid {
    grid-template-columns: 1fr;
  }
  .pillar-main {
    grid-row: auto;
  }
}
```

### 6.C Section 节奏规则

- **视觉密度 3** → section 垂直间距 96px（`--space-9`）
- **最多 1 个 eyebrow per 3 sections** → 本站**完全不用 eyebrow**，section 标题即 H2
- **Section-Layout-Repetition Ban** → 每页至少 4 种布局族（见各页面蓝图）

---

## 7. 组件规范

### 7.A 按钮

```css
.btn {
  display: inline-flex;
  align-items: center;
  gap: var(--space-2);
  padding: var(--space-3) var(--space-5);
  font-family: var(--font-sans);
  font-size: var(--text-sm);
  font-weight: 500;
  border-radius: var(--radius-sm);
  border: 1px solid transparent;
  background: transparent;
  color: var(--color-ink);
  cursor: pointer;
  text-decoration: none;
  transition: all var(--dur-1) var(--ease-out-quiet);
}

.btn:hover {
  color: var(--color-accent);
}

.btn:active {
  transform: translateY(1px);
}

.btn:focus-visible {
  outline: 2px solid var(--color-accent);
  outline-offset: 3px;
}

.btn-primary {
  background: var(--color-accent);
  color: var(--color-accent-contrast);
  border-color: var(--color-accent);
  font-weight: 600;
}

.btn-primary:hover {
  background: var(--color-accent-hover);
  border-color: var(--color-accent-hover);
  color: var(--color-accent-contrast);
}

.btn-ghost {
  border-color: var(--color-border-strong);
  color: var(--color-ink);
}

.btn-ghost:hover {
  border-color: var(--color-accent);
  color: var(--color-accent);
}
```

### 7.B 标签

```css
.tag {
  display: inline-block;
  padding: 2px var(--space-2);
  font-family: var(--font-sans);
  font-size: var(--text-tag);
  font-weight: 500;
  color: var(--color-ink-3);
  border: 1px solid var(--color-border);
  border-radius: var(--radius-sm);
}
```

### 7.C 状态徽章

```css
.status {
  display: inline-block;
  padding: 2px var(--space-2);
  font-family: var(--font-sans);
  font-size: var(--text-tag);
  font-weight: 500;
  border-radius: var(--radius-sm);
  border: 1px solid currentColor;
}

.status-live {
  color: var(--color-ok);
  background: var(--color-ok-soft);
}

.status-iter {
  color: var(--color-ink-3);
  background: transparent;
}

.status-exp, .status-soon {
  color: var(--color-warn);
  background: var(--color-warn-soft);
}
```

### 7.D 链接箭头

```css
.link-arrow {
  display: inline-flex;
  align-items: center;
  gap: var(--space-2);
  font-family: var(--font-sans);
  font-size: var(--text-sm);
  font-weight: 500;
  color: var(--color-ink);
  text-decoration: none;
  transition: color var(--dur-1) var(--ease-out-quiet);
}

.link-arrow::after {
  content: "→";
  transition: transform var(--dur-1) var(--ease-out-quiet);
}

.link-arrow:hover {
  color: var(--color-accent);
}

.link-arrow:hover::after {
  transform: translateX(4px);
}
```

### 7.E 卡片规则（Editorial 极简）

- **不使用卡片作为默认容器**
- 仅在需要明确层级区分时使用 `--color-surface` + `1px solid var(--color-border)`
- **圆角统一为 0**，特殊小元素用 `--radius-sm`（2px）

---

## 8. 页面蓝图

### 8.A Header

**布局**：64px 吸顶，纸底 + 模糊

**ASCII**：

```
┌────────────────────────────────────────────────────────────────┐
│ ⟨码孖⟩                              首页  博客  产品  实验场  联系  │
└────────────────────────────────────────────────────────────────┘
```

**结构**：

```html
<header class="header">
  <div class="container header-inner">
    <a href="/" class="logo">
      <span class="logo-bracket">⟨</span>码孖<span class="logo-bracket">⟩</span>
    </a>
    <button class="menu-toggle" aria-label="打开菜单" id="menu-toggle">...</button>
    <nav class="nav" id="nav">
      <a href="/" class="nav-link active">首页</a>
      <a href="https://blog.litpp.com" class="nav-link">博客<span class="ext">↗</span></a>
      <a href="/products" class="nav-link">产品</a>
      <a href="/lab" class="nav-link">实验场</a>
      <a href="/contact" class="nav-link">联系</a>
    </nav>
  </div>
</header>
```

**样式要点**：

```css
.header {
  position: sticky;
  top: 0;
  z-index: var(--z-header);
  background: var(--color-glass);
  backdrop-filter: blur(10px);
  border-bottom: 1px solid var(--color-border);
}

.header-inner {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: var(--header-h);
}

.logo {
  font-family: var(--font-serif);
  font-size: 1.125rem;
  font-weight: 700;
  color: var(--color-ink);
  text-decoration: none;
}

.logo-bracket {
  color: var(--color-accent);
}

.nav {
  display: flex;
  gap: var(--space-6);
}

.nav-link {
  font-size: var(--text-sm);
  color: var(--color-ink-2);
  text-decoration: none;
  position: relative;
  transition: color var(--dur-1) var(--ease-out-quiet);
}

.nav-link:hover,
.nav-link.active {
  color: var(--color-ink);
}

.nav-link.active::after {
  content: "";
  position: absolute;
  bottom: -6px;
  left: 0;
  right: 0;
  height: 2px;
  background: var(--color-accent);
}

.ext {
  margin-left: 2px;
  font-size: 0.75em;
  color: var(--color-ink-3);
}

/* 移动端 */
@media (max-width: 768px) {
  .menu-toggle {
    display: flex;
    width: 44px;
    height: 44px;
    ...
  }
  .nav {
    display: none;
    position: absolute;
    top: var(--header-h);
    left: 0;
    right: 0;
    flex-direction: column;
    background: var(--color-bg);
    border-bottom: 1px solid var(--color-border);
    padding: var(--space-5) var(--gutter);
    gap: var(--space-4);
  }
  .nav.open { display: flex; }
  .nav-link.active::after { display: none; }
}
```

---

### 8.B index.astro

**结构**：Hero → 正在做的三件事（Bento 1+2） → 游戏与工具 Band → 最近文章（左轨 + 列表）

**ASCII**：

```
┌─────────────────────────────────────────────────────────────────────┐
│                                                                     │
│  把 AI、产品、工程，                                    (右留白)    │
│  真正串起来的实验场                                    (无 eyebrow) │
│                                                                     │
│  不是个人简历，也不是工具导航站。这里记录一个 CTO                 │
│  在 AI 时代的系统思考、工程实践与产品实验。                         │
│                                                                     │
│  [进入实验场]  [阅读博客 ↗]                                         │
│                                                                     │
├─────────────────────────────────────────────────────────────────────┤
│  正在做的事                                                          │
│ ┌─────────────────────────────────┐ ┌───────────────────────────────┐│
│ │ ⚙ AI 工程化                     │ │ 🧪 实验与原型                  ││
│ │ 探索 LLM 落地路径：不只是 demo， │ │ 快速验证想法的 Playground。…… ││
│ │ 而是可交付、可迭代的系统。       │ ├───────────────────────────────┤│
│ │ 查看产品 →                       │ │ ✎ 技术写作                    ││
│ └─────────────────────────────────┘ │ ……                            ││
│  ↑ 朱砂底（accent-soft）            └───────────────────────────────┘│
│                                     ↑ 白底 + 强线框                  │
├─────────────────────────────────────────────────────────────────────┤
│  ┌─────────────────────────────────────────────────────────────────┐│
│  │  游戏与工具实验场                                    [↗]        ││
│  │  数学小游戏、思维训练、AI 交互实验，都在 game.litpp.com。      ││
│  └─────────────────────────────────────────────────────────────────┘│
│  ↑ 强线框（border-strong），无背景色                                 │
├─────────────────────────────────────────────────────────────────────┤
│  最近文章          │ 9月12日   文章标题                              ││
│  （sticky）        │ 8月30日   文章标题                              ││
│  全部文章 ↗        │ 8月12日   文章标题                              ││
└─────────────────────────────────────────────────────────────────────┘
```

**关键 CSS**：

```css
/* Hero */
.hero {
  padding-top: var(--space-9);
  padding-bottom: var(--space-7);
  border-bottom: 1px solid var(--color-border);
}

.hero-title {
  font-family: var(--font-serif);
  font-size: var(--text-display);
  font-weight: 900;
  line-height: var(--leading-display);
  letter-spacing: 0.02em;
  color: var(--color-ink);
  margin-bottom: var(--space-5);
  max-width: 60%;
}

.hero-title em {
  font-style: normal;
  color: var(--color-accent);
}

.hero-desc {
  font-size: var(--text-md);
  color: var(--color-ink-2);
  max-width: 36em;
  margin-bottom: var(--space-5);
}

.hero-actions {
  display: flex;
  gap: var(--space-3);
}

/* Pillars Bento */
.pillar {
  display: flex;
  flex-direction: column;
  padding: var(--space-6);
  border: 1px solid var(--color-border);
  background: var(--color-surface);
  text-decoration: none;
  transition: border-color var(--dur-2) var(--ease-out-quiet);
}

.pillar-main {
  background: var(--color-accent-soft);
  border-color: var(--color-accent-soft);
  padding: var(--space-7);
}

.pillar:hover {
  border-color: var(--color-accent);
}

.pillar-icon {
  margin-bottom: var(--space-3);
  color: var(--color-ink-2);
}

.pillar-title {
  font-family: var(--font-serif);
  font-size: var(--text-h3);
  font-weight: 700;
  color: var(--color-ink);
  margin-bottom: var(--space-2);
}

.pillar p {
  font-size: var(--text-sm);
  color: var(--color-ink-2);
  margin-bottom: var(--space-4);
  flex: 1;
}

/* Band */
.band {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: var(--space-6) var(--space-7);
  border: 1px solid var(--color-border-strong);
  text-decoration: none;
  transition: border-color var(--dur-2) var(--ease-out-quiet);
}

.band:hover {
  border-color: var(--color-accent);
}

.band-title {
  font-family: var(--font-serif);
  font-size: var(--text-h2);
  font-weight: 700;
  color: var(--color-ink);
  margin-bottom: var(--space-2);
}

.band-desc {
  font-size: var(--text-sm);
  color: var(--color-ink-2);
  margin: 0;
}

.band-arrow {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 48px;
  height: 48px;
  border: 1px solid var(--color-border-strong);
  border-radius: var(--radius-sm);
  font-size: var(--text-md);
  color: var(--color-ink-2);
  transition: all var(--dur-2) var(--ease-out-quiet);
}

.band:hover .band-arrow {
  background: var(--color-accent);
  border-color: var(--color-accent);
  color: var(--color-accent-contrast);
}

/* Posts */
.posts-grid {
  display: grid;
  grid-template-columns: 4fr 8fr;
  gap: var(--space-7);
}

.posts-rail {
  position: sticky;
  top: calc(var(--header-h) + var(--space-7));
  align-self: start;
}

.posts-rail h2 {
  font-family: var(--font-serif);
  font-size: var(--text-h2);
  font-weight: 700;
  color: var(--color-ink);
  margin-bottom: var(--space-4);
}

.post-row {
  display: flex;
  gap: var(--space-5);
  padding: var(--space-5) 0;
  border-top: 1px solid var(--color-border);
  text-decoration: none;
}

.post-row:first-child {
  border-top: 1px solid var(--color-border-strong);
}

.post-row time {
  flex-shrink: 0;
  width: 88px;
  font-family: var(--font-sans);
  font-size: var(--text-meta);
  font-weight: 500;
  font-variant-numeric: tabular-nums;
  color: var(--color-ink-3);
}

.post-row h3 {
  font-family: var(--font-serif);
  font-size: var(--text-h3);
  font-weight: 700;
  color: var(--color-ink);
  margin-bottom: var(--space-1);
  transition: color var(--dur-1) var(--ease-out-quiet);
}

.post-row:hover h3 {
  color: var(--color-accent);
}

.post-row p {
  font-size: var(--text-sm);
  color: var(--color-ink-2);
  margin: 0;
}

@media (max-width: 768px) {
  .hero-title { max-width: 100%; }
  .hero-actions { flex-direction: column; align-items: flex-start; }
  .posts-grid { grid-template-columns: 1fr; }
  .posts-rail { position: static; margin-bottom: var(--space-5); }
}
```

**Hero 入场动画**：

```css
@media (prefers-reduced-motion: no-preference) {
  .hero-title  { animation: rise var(--dur-3) var(--ease-out-quiet) backwards; }
  .hero-desc   { animation: rise var(--dur-3) var(--ease-out-quiet) 80ms backwards; }
  .hero-actions{ animation: rise var(--dur-3) var(--ease-out-quiet) 160ms backwards; }
}

@keyframes rise {
  from { opacity: 0; transform: translateY(14px); }
  to   { opacity: 1; transform: translateY(0); }
}
```

---

### 8.C products.astro

**结构**：页面头 → 产品 Ledger（行式） → 构建哲学（2 列声明式）

**ASCII**：

```
┌─────────────────────────────────────────────────────────────────────┐
│  产品与系统                                                          │
│  不只是做产品，更是构建系统。每一个项目背后，是对"如何用工程方法   │
│  解决真实问题"的持续回答。                                           │
├─────────────────────────────────────────────────────────────────────┤
│  AI 内容生成系统                             [运行中]                │
│  基于 LLM 的结构化内容生产管线。从 Prompt 工程到输出质量控制……    │
│  不是 ChatGPT wrapper，是真正的内容工程化。                          │
│  [LLM] [Prompt Engineering] [内容管线]                               │
│ ─────────────────────────────────────────────────────────────────── │
│  数据驱动决策平台                            [运行中]                │
│  ...                                                                 │
├─────────────────────────────────────────────────────────────────────┤
│  构建哲学                                                            │
│  ┌───────────────────────────┐ ┌───────────────────────────┐       │
│  │ 系统思维优先              │ │ AI 是工具，不是目的       │       │
│  │ 不做孤立的功能点……        │ │ AI 的价值在于解决……      │       │
│  └───────────────────────────┘ └───────────────────────────┘       │
│  ┌───────────────────────────┐ ┌───────────────────────────┐       │
│  │ 工程质量即产品质量        │ │ 小团队，大杠杆           │       │
│  │ ...                       │ │ ...                       │       │
│  └───────────────────────────┘ └───────────────────────────┘       │
└─────────────────────────────────────────────────────────────────────┘
```

**结构**：

```html
<section class="section">
  <div class="container">
    <header class="page-head">
      <h1 class="page-title">产品与系统</h1>
      <p class="page-desc">...</p>
    </header>

    <div class="ledger">
      <article class="ledger-row">
        <div class="ledger-head">
          <h2 class="ledger-name">AI 内容生成系统</h2>
          <span class="status status-live">运行中</span>
        </div>
        <div class="ledger-body">
          <p class="ledger-desc">...</p>
          <p class="ledger-note">不是 ChatGPT wrapper，是真正的内容工程化。</p>
          <div class="tag-row">...</div>
        </div>
      </article>
      ...
    </div>

    <div class="philosophy">
      <div class="section-head"><h2>构建哲学</h2></div>
      <div class="creed-grid">
        <div class="creed">
          <h3>系统思维优先</h3>
          <p>...</p>
        </div>
        ...
      </div>
    </div>
  </div>
</section>
```

**样式要点**：

```css
.page-head {
  margin-bottom: var(--space-7);
}

.page-title {
  font-family: var(--font-serif);
  font-size: var(--text-h1);
  font-weight: 700;
  color: var(--color-ink);
  margin-bottom: var(--space-3);
}

.page-desc {
  font-size: var(--text-md);
  color: var(--color-ink-2);
  max-width: 40em;
}

/* Ledger */
.ledger-row {
  display: grid;
  grid-template-columns: 5fr 7fr;
  gap: var(--space-5);
  padding: var(--space-6) 0;
  border-top: 1px solid var(--color-border);
}

.ledger-row:first-child {
  border-top: 1px solid var(--color-border-strong);
}

.ledger-name {
  font-family: var(--font-serif);
  font-size: var(--text-h2);
  font-weight: 700;
  color: var(--color-ink);
  margin: 0;
}

.ledger-head {
  display: flex;
  align-items: center;
  gap: var(--space-3);
  flex-wrap: wrap;
}

.ledger-desc {
  font-size: var(--text-sm);
  color: var(--color-ink-2);
  margin-bottom: var(--space-3);
}

.ledger-note {
  font-size: var(--text-sm);
  font-weight: 500;
  color: var(--color-ink-3);
  margin-bottom: var(--space-3);
}

/* Creed */
.creed {
  padding-top: var(--space-5);
  border-top: 1px solid var(--color-border);
}

.creed h3 {
  font-family: var(--font-serif);
  font-size: var(--text-h3);
  font-weight: 700;
  color: var(--color-ink);
  margin-bottom: var(--space-2);
}

.creed p {
  font-size: var(--text-sm);
  color: var(--color-ink-2);
}
```

---

### 8.D lab.astro

**结构**：页面头 → 实验格子（1 大 + 2 小） → 关于实验场

**ASCII**：

```
┌─────────────────────────────────────────────────────────────────────┐
│  实验场                                                              │
│  这里是 Playground。快速验证想法、试错、迭代。                      │
├─────────────────────────────────────────────────────────────────────┤
│ ┌─────────────────────────────────┐ ┌─────────────────────────────┐ │
│ │ 数学小游戏                      │ │ Prompt Playground           │ │
│ │ 面向数学思维训练的交互式……      │ │ [即将上线]                  │ │
│ │ [游戏] [数学] [教育]            │ │ Prompt 工程实验台……         │ │
│ │ 进入 game.litpp.com ↗           │ ├─────────────────────────────┤ │
│ └─────────────────────────────────┘ │ AI 写作助手                  │ │
│  ↑ 朱砂底，可点击                  │ [即将上线] ……               │ │
│                                     └─────────────────────────────┘ │
│                                      ↑ 静音样式，不可点击           │
├─────────────────────────────────────────────────────────────────────┤
│  关于实验场                                                          │
│  实验场的核心理念是"低成本试错"。这里的项目可能不完善……           │
└─────────────────────────────────────────────────────────────────────┘
```

**结构**：

```html
<section class="section">
  <div class="container">
    <header class="page-head">...</header>

    <div class="lab-grid">
      <a class="lab-feature" href="https://game.litpp.com" target="_blank" rel="noopener">
        <h2>数学小游戏</h2>
        <p>面向数学思维训练的交互式小游戏集合……</p>
        <div class="tag-row">...</div>
        <span class="link-arrow">进入 game.litpp.com ↗</span>
      </a>
      <div class="lab-queue">
        <div class="lab-queue-item">
          <h3>Prompt Playground</h3>
          <span class="status status-soon">即将上线</span>
          <p>...</p>
        </div>
        <div class="lab-queue-item">...</div>
      </div>
    </div>

    <div class="lab-note">
      <div class="section-head"><h2>关于实验场</h2></div>
      <p>...</p>
    </div>
  </div>
</section>
```

**样式要点**：

```css
.lab-grid {
  display: grid;
  grid-template-columns: 7fr 5fr;
  gap: var(--space-5);
  margin-bottom: var(--space-9);
}

.lab-feature {
  padding: var(--space-7);
  background: var(--color-accent-soft);
  text-decoration: none;
}

.lab-feature h2 {
  font-family: var(--font-serif);
  font-size: var(--text-h2);
  font-weight: 700;
  color: var(--color-ink);
  margin-bottom: var(--space-3);
}

.lab-queue-item {
  padding: var(--space-5) 0;
  border-top: 1px solid var(--color-border);
}

.lab-queue-item h3 {
  font-family: var(--font-serif);
  font-size: var(--text-h3);
  font-weight: 700;
  color: var(--color-ink-2);
  margin-bottom: var(--space-2);
}
```

---

### 8.E contact.astro

**结构**：页面头 → 左：话题列表 / 右：联系卡片（邮箱 + 链接）

**ASCII**：

```
┌─────────────────────────────────────────────────────────────────────┐
│  联系我                                                              │
│  欢迎就以下话题交流。不卖课、不接广告，只聊值得聊的事。            │
├─────────────────────────────────────────────────────────────────────┤
│  ┌─────────────────────────────┐ ┌───────────────────────────────┐ │
│  │ 技术合作                    │ │ hi@litpp.com                  │ │
│  │ AI 工程化落地……             │ │                               │ │
│  │ ─────────────────────────── │ │ GitHub  github.com/litpp ↗   │ │
│  │ 产品交流                    │ │ 网站    litpp.com            │ │
│  │ 对已有产品的反馈……          │ │                               │ │
│  │ ─────────────────────────── │ │ 建议优先使用 Email。请简要   │ │
│  │ 开源 & 社区                 │ │ 说明来意，我会尽快回复。     │ │
│  │ 对实验场项目感兴趣……        │ └───────────────────────────────┘ │
│  └─────────────────────────────┘
└─────────────────────────────────────────────────────────────────────┘
```

**结构**：

```html
<section class="section">
  <div class="container">
    <header class="page-head">...</header>

    <div class="contact-grid">
      <div class="topics">
        <article class="topic">
          <h3>技术合作</h3>
          <p>AI 工程化落地、系统架构设计……</p>
        </article>
        ...
      </div>
      <aside class="contact-card">
        <h2 class="contact-email">
          <a href="mailto:hi@litpp.com">hi@litpp.com</a>
        </h2>
        <ul class="contact-links">
          <li><span>GitHub</span><a href="...">github.com/litpp ↗</a></li>
          <li><span>网站</span><a href="...">litpp.com</a></li>
        </ul>
        <p class="contact-hint">建议优先使用 Email……</p>
      </aside>
    </div>
  </div>
</section>
```

**样式要点**：

```css
.contact-grid {
  display: grid;
  grid-template-columns: 7fr 5fr;
  gap: var(--space-7);
}

.topic {
  padding: var(--space-5) 0;
  border-top: 1px solid var(--color-border);
}

.topic h3 {
  font-family: var(--font-serif);
  font-size: var(--text-h3);
  font-weight: 700;
  color: var(--color-ink);
  margin-bottom: var(--space-2);
}

.contact-card {
  padding: var(--space-6);
  border: 1px solid var(--color-border);
  background: var(--color-surface);
}

.contact-email {
  font-family: var(--font-serif);
  font-size: clamp(1.5rem, 1rem + 2vw, 2rem);
  font-weight: 700;
  margin-bottom: var(--space-5);
}

.contact-email a {
  color: var(--color-ink);
  text-decoration: none;
  text-decoration-color: var(--color-accent);
  text-underline-offset: 4px;
  transition: color var(--dur-1) var(--ease-out-quiet);
}

.contact-email a:hover {
  color: var(--color-accent);
}
```

---

### 8.F Footer

**布局**：Colophon 风格，三列：品牌 / 站内链接 / 外部链接 + 法律行

**ASCII**：

```
┌─────────────────────────────────────────────────────────────────────┐
│ ─────────────────────────────────────────────────────────────────── │
│  ⟨码孖⟩                  首页            博客 ↗                     │
│  CTO 的 AI 实验场       产品            game.litpp.com ↗            │
│                         实验场          GitHub ↗                    │
│                         联系                                        │
│                                                                     │
│  © 2026 码孖                                 粤ICP备18152027号       │
└─────────────────────────────────────────────────────────────────────┘
```

**结构**：

```html
<footer class="footer">
  <div class="container">
    <div class="footer-grid">
      <div class="footer-brand">
        <span class="footer-logo">⟨码孖⟩</span>
        <p>CTO 的 AI 实验场</p>
      </div>
      <nav class="footer-nav" aria-label="站内">
        <a href="/">首页</a>
        <a href="/products">产品</a>
        <a href="/lab">实验场</a>
        <a href="/contact">联系</a>
      </nav>
      <nav class="footer-nav" aria-label="外部">
        <a href="https://blog.litpp.com" target="_blank">博客 ↗</a>
        <a href="https://game.litpp.com" target="_blank">game.litpp.com ↗</a>
        <a href="https://github.com/litpp" target="_blank">GitHub ↗</a>
      </nav>
    </div>
    <div class="footer-legal">
      <span>© 2026 码孖</span>
      <a href="https://beian.miit.gov.cn/" target="_blank">粤ICP备18152027号</a>
    </div>
  </div>
</footer>
```

**样式要点**：

```css
.footer {
  border-top: 1px solid var(--color-border);
  padding: var(--space-7) 0;
  margin-top: var(--space-9);
}

.footer-grid {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr;
  gap: var(--space-7);
  margin-bottom: var(--space-6);
}

.footer-logo {
  font-family: var(--font-serif);
  font-size: var(--text-md);
  font-weight: 700;
  color: var(--color-ink);
}

.footer-brand p {
  font-size: var(--text-sm);
  color: var(--color-ink-2);
  margin-top: var(--space-2);
}

.footer-nav {
  display: flex;
  flex-direction: column;
  gap: var(--space-2);
}

.footer-nav a {
  font-size: var(--text-sm);
  color: var(--color-ink-2);
  text-decoration: none;
  transition: color var(--dur-1) var(--ease-out-quiet);
}

.footer-nav a:hover {
  color: var(--color-ink);
}

.footer-legal {
  display: flex;
  justify-content: space-between;
  font-size: var(--text-meta);
  color: var(--color-ink-3);
}

.footer-legal a {
  color: var(--color-ink-3);
}

@media (max-width: 768px) {
  .footer-grid {
    grid-template-columns: 1fr;
    gap: var(--space-5);
  }
  .footer-legal {
    flex-direction: column;
    gap: var(--space-2);
  }
}
```

---

## 9. 交互与动效

### 9.A 动效原则

- `MOTION_INTENSITY: 3` → 仅 CSS 过渡，无 JS 驱动的 scroll 动画
- 入场：Hero 标题/描述/按钮 fade-up 交错入场（已给出 CSS）
- 悬停：链接/按钮色值过渡 150ms，箭头位移 4px，band 边框变色
- 按下：`transform: translateY(1px)` 模拟物理反馈
- **遵守 `prefers-reduced-motion`**：全局禁用动画

### 9.B 焦点状态

```css
:focus-visible {
  outline: 2px solid var(--color-accent);
  outline-offset: 3px;
}
```

### 9.C Reduced Motion

```css
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
}
```

---

## 10. 响应式断点

| 断点 | 宽度 | 行为 |
|------|------|------|
| `sm` | 640px | 字号微调，容器 padding 收紧 |
| `md` | 768px | 所有多列布局塌为单列，导航收起为汉堡菜单 |
| `lg` | 1024px | 无特殊处理（容器 max-width 已约束） |

**统一塌陷规则**：

```css
@media (max-width: 768px) {
  .grid-7-5, .grid-5-7, .pillars, .creed-grid, .contact-grid, .footer-grid {
    grid-template-columns: 1fr;
  }
}
```

---

## 11. 对比度核查表

| 配对 | 浅色主题 | 暗色主题 | WCAG |
|------|----------|----------|------|
| ink on bg | 16.3:1 | 14.4:1 | AAA |
| ink-2 on bg | 7.2:1 | 6.6:1 | AAA |
| ink-3 on bg | 5.1:1 | 4.9:1 | AA |
| accent on bg | 5.1:1 | 5.3:1 | AA |
| accent-contrast on accent | 5.4:1 | 5.3:1 | AA |
| ok on bg | 4.8:1 | 7.1:1 | AA/AAA |
| warn on bg | 5.6:1 | 8.0:1 | AA/AAA |
| border-strong on bg | 3.3:1 | 3.2:1 | 3:1 UI 边框达标 |

---

## 12. 文案修正清单（Em-dash 清除）

| 文件 | 原文 | 修正为 |
|------|------|--------|
| `src/consts.ts` | `码孖 — CTO 的 AI 实验场` | `码孖：CTO 的 AI 实验场` |
| `src/pages/index.astro` | `落地路径——不只是 demo，而是……` | `落地路径：不只是 demo，而是……` |
| `src/pages/products.astro` | `系统思维的具体落地——让数据说话` | `系统思维的具体落地：让数据说话` |
| `src/pages/products.astro` | `工程能力的底座——让团队……` | `工程能力的底座：让团队……` |
| `src/pages/products.astro` | `清晰的监控——这些不是……` | `清晰的监控，这些不是……` |
| `src/pages/lab.astro` | `可能会大改——但每一个实验` | `可能会大改，但每一个实验` |

**统一规则**：中文破折号（——）替换为冒号（：）或逗号（，），根据语境选择。

---

## 13. 图标策略

- **继续使用现有 Icon.astro 组件**
- 现有图标：`mdi-cog`, `mdi-flask`, `mdi-pencil`, `mdi-gamepad`, `lucide-arrow-right`, `lucide-external-link`
- **禁止手写 SVG 路径**；如需新图标，使用 `iconify-local` skill 本地化到 `public/icons/`
- **外部链接标记**：文字形式的 `↗` 允许使用（属于排版，非图标组件）

---

## 14. 实施清单

### 14.A 文件修改列表

| 文件 | 操作 | 说明 |
|------|------|------|
| `src/styles/global.css` | 重写 | 新 token、base、utilities、components |
| `src/components/Header.astro` | 重样式 | 新颜色、间距、active 状态、glass bg |
| `src/components/Footer.astro` | 重结构+样式 | Colophon 布局，无 middle dot 过载 |
| `src/pages/index.astro` | 重结构 | Bento 1+2、Band、Posts Rail |
| `src/pages/products.astro` | 重结构+样式 | Ledger 行式、Creed 2 列、清除斜体 |
| `src/pages/lab.astro` | 重结构 | 1 大 2 小格子、静音队列 |
| `src/pages/contact.astro` | 重结构 | Split 布局、联系卡片 |
| `src/layouts/Base.astro` | 微调 | 添加 `<meta name="theme-color">`、字体 CSS 引入 |
| `src/consts.ts` | 文案修正 | Em-dash → 冒号 |
| `public/fonts/` | 新增 | 自托管 Noto Serif SC 子集 |

### 14.B Pre-Flight 自检

- [ ] `DESIGN_VARIANCE / MOTION / DENSITY` 已声明
- [ ] **零 em-dash**（全文搜索 `—` 和 `——`）
- [ ] 页面单一主题（light 默认 + dark media query）
- [ ] accent 一致锁定（朱砂，无第二 accent）
- [ ] 圆角系统一致（surface 0，小元素 2px）
- [ ] 按钮对比度达标
- [ ] 表单：无表单，跳过
- [ ] Serif 规范：使用 Noto Serif SC，非 Fraunces/Instrument_Serif
- [ **中文斜体禁用**：全文搜索 `font-style: italic` 并移除
- [ ] Hero：标题 ≤ 2 行，描述 ≤ 20 字/2 行，CTA 可见
- [ ] Hero top padding ≤ 96px
- [ ] Hero 元素 ≤ 4（已去除 eyebrow）
- [ ] Eyebrow 计数：0（全站无 eyebrow）
- [ ] Section-Layout 不重复（index 4 种、products 2 种、lab 2 种、contact 2 种）
- [ ] Zigzag ≤ 2：无 zigzag，跳过
- [ ] Bento 有节奏 + 精确 cell 数（3 项目 → 3 cells）
- [ ] 长列表用合适组件（posts 用行式列表，非 default ul）
- [ ] 图片策略：无 hero 图片，跳过；图标来自库，无手写 SVG
- [ ] Logo wall：无，跳过
- [ ] Motion 有动机（Hero 入场 = 层级引导；hover = 反馈）
- [ ] Marquee ≤ 1：无 marquee
- [ ] 导航单行、高度 64px
- [ ] Reduced motion 已适配
- [ ] Dark mode token 已定义
- [ ] Mobile 塌陷已显式定义
- [ ] 无 `window.addEventListener('scroll')`
- [ ] 无 AI Tell（Inter、AI-purple、three-equal-cards、Acme、"Elevate" 等）

---

## 15. 附录：中文排版细节

1. **标题换行控制**：使用 `<br>` 避免标点出现在行首，例如：
   ```html
   <h1>把 AI、产品、工程，<br>真正串起来的实验场</h1>
   ```
2. **数字等宽**：日期、计数使用 `font-variant-numeric: tabular-nums;`
3. **中英文间距**：渐进增强 `text-autospace: normal;`（不阻塞）
4. **禁止中文斜体**：全站 `font-style: italic` 仅用于 `<code>` 等拉丁元素，中文元素一律 `font-style: normal`

---

**文档结束。照此执行即可。**