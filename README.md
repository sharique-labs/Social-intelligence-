# Social Intelligence Plugin (Trigify-Powered)

Give your AI agent access to the entire social web. Monitor competitors, track your brand, analyze content gaps, and surface buying signals — all powered by [Trigify's](https://trigify.io) social listening MCP server.

## What This Does

This is a Claude Code plugin that connects Trigify's social intelligence data to AI-powered skills across every department in your organization.

```
Your AI Agent
     │
     ▼
Trigify MCP Server ──► X · Reddit · YouTube · LinkedIn · Podcasts
     │                  (+ Substack · Threads · Instagram · TikTok · GitHub · HN coming soon)
     │
     ├── Marketing ──► Content gaps, trending topics, ad opportunities
     ├── Sales ──────► Buying signals, prospect intel, competitive positioning
     ├── Product ────► Feature requests, launch sentiment, user pain points
     ├── Operations ─► Automated monitoring, daily reports, data pipelines
     └── Creative ───► Trending formats, engagement patterns, content inspiration
```

## Skills

### Social Listening (`/social-listening`)
Create social listening searches, fetch and analyze posts across platforms. Monitor keywords, competitors, or your brand.

**Use cases:**
- Set up keyword monitoring across X, Reddit, YouTube, LinkedIn, Podcasts
- Fetch and analyze posts for gap analysis, sentiment tracking, or competitive intel
- Build automated daily monitoring and reporting workflows
- Identify content gaps, ad opportunities, and trending topics

### Competitive Intelligence (`/competitive-intel`)
Monitor competitors across social platforms. Track product launches, positioning shifts, content strategy, and market movements.

**Use cases:**
- Multi-platform competitor content analysis
- Product launch and feature tracking
- Share of voice measurement
- Battle card generation for sales teams
- Competitive landscape reports for leadership

### Brand Monitor (`/brand-monitor`)
Track brand mentions, sentiment, and post performance. Get data-driven iteration suggestions.

**Use cases:**
- Brand mention tracking and sentiment analysis
- Post performance review with iteration recommendations
- Reputation monitoring and crisis detection
- Audience perception mapping
- Content performance loop (post → measure → learn → iterate)

## Department Distribution

| Department | Skills | Focus |
|-----------|--------|-------|
| **Marketing** | All 3 skills | Content strategy, competitive positioning, brand health |
| **Sales** | social-listening, competitive-intel | Prospect signals, battle cards, competitive ammo |
| **Product** | All 3 skills | Feature intel, launch sentiment, market gaps |
| **Operations** | social-listening | Automated monitoring, scheduled reports |
| **Creative** | social-listening, brand-monitor | Trend-inspired content, performance patterns |

## Setup

### 1. Connect Trigify MCP

```bash
claude mcp add trigify -- npx -y mcp-remote https://api.trigify.io/mcp
```

Set your API key:
```bash
export TRIGIFY_API_KEY=your_api_key_here
```

Get your API key from [Trigify Settings](https://app.trigify.io/settings).

### 2. Install the Plugin

Install the marketing plugin (or any department):
```bash
claude plugin install ./plugins/marketing
```

Or build and install from source:
```bash
./sync-skills.sh    # Generate department plugins from shared skills
./build-zips.sh     # Create distributable ZIP packages
```

### 3. Use It

```
You: /social-intelligence
Agent: Shows available skills and quick-start examples

You: Monitor my competitors on Twitter
Agent: Walks you through setting up searches, fetches results, analyzes gaps

You: How did my recent posts perform?
Agent: Pulls performance data, analyzes patterns, recommends iterations
```

## Architecture

```
social-intelligence/
├── .claude-plugin/
│   ├── marketplace.json          # Plugin metadata for all departments
│   └── skills-map.json           # Maps skills → departments + MCP config
├── shared-skills/                # Single source of truth
│   ├── social-listening/
│   │   ├── SKILL.md              # 5-phase interactive workflow
│   │   └── references/           # Search setup, platform guide, frameworks, automation
│   ├── competitive-intel/
│   │   ├── SKILL.md
│   │   └── references/           # Competitor frameworks, templates, reporting
│   └── brand-monitor/
│       ├── SKILL.md
│       └── references/           # Sentiment analysis, metrics, iteration playbook
├── commands/
│   └── social-intelligence.md    # Entry point command listing all skills
├── sync-skills.sh                # Generates plugins/ from shared-skills + skills-map
└── build-zips.sh                 # Packages into distributable ZIPs
```

**Key design decisions:**
- **Shared skills** — Skills are defined once and distributed to multiple departments
- **Department-aware** — Same skill adapts its analysis and output based on who's asking
- **MCP-powered** — Trigify MCP server provides real-time social data access
- **Phase-based workflows** — Every skill follows an interactive, phase-based approach
- **Setup verification** — Skills silently check MCP connection and guide setup if missing
- **Automation-ready** — Includes patterns for daily briefings, weekly reports, and cron-based monitoring

## Supported Platforms

| Platform | Status |
|----------|--------|
| X (Twitter) | Live |
| Reddit | Live |
| YouTube | Live |
| LinkedIn | Live |
| Podcasts | Live |
| Substack | Coming Soon |
| Threads | Coming Soon |
| Instagram | Coming Soon |
| TikTok | Coming Soon |
| GitHub | Coming Soon |
| Hacker News | Coming Soon |

## Merging into benai-skills

This plugin is designed to drop into the [benai-skills](https://github.com/naveedharri/benai-skills) ecosystem:

1. Copy `shared-skills/*` → `benai-skills/shared-skills/`
2. Add Trigify MCP + skill entries to `benai-skills/.claude-plugin/skills-map.json`
3. Add `social-intelligence.md` to `benai-skills/commands/`
4. Run `sync-skills.sh` → `build-zips.sh`

## Built With

- [Trigify](https://trigify.io) — Social intelligence engine
- [Claude Code](https://claude.ai) — AI-powered development
- [Model Context Protocol (MCP)](https://modelcontextprotocol.io) — AI tool integration standard
