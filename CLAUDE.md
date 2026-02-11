# Social Intelligence Plugin — Trigify-Powered

## Overview

This plugin gives AI agents access to the entire social web through Trigify's MCP server. It provides social listening, competitive intelligence, and brand monitoring capabilities across X, Reddit, YouTube, LinkedIn, Podcasts, and more.

## Architecture

Follows the official Claude Code plugin architecture. Single plugin (`social-listening`) with all skills bundled together.

### Source (edit these)

- `shared-skills/` — Single source of truth for all skill definitions (`SKILL.md` + `references/`)
- `.claude-plugin/skills-map.json` — Maps skills to the plugin + MCP server config
- `.claude-plugin/marketplace.json` — Marketplace catalog with plugin metadata
- `commands/` — Entry point command files (slash commands)
- `.mcp.json` — Root MCP server config (Trigify)

### Generated (by `sync-skills.sh`, do not edit directly)

- `plugins/` — Generated plugin directory, tracked in git
- `dist/` — Build artifacts from `build-zips.sh`

### Generated Plugin Structure

```
plugins/social-listening/
├── .claude-plugin/
│   └── plugin.json      ← Clean manifest (name, description, version, author)
├── .mcp.json             ← MCP server configuration (Trigify)
├── skills/
│   ├── social-listening/
│   │   ├── SKILL.md      ← Auto-discovered by Claude Code
│   │   └── references/
│   ├── competitive-intel/
│   │   ├── SKILL.md
│   │   └── references/
│   └── brand-monitor/
│       ├── SKILL.md
│       └── references/
└── commands/
    └── social-intelligence.md
```

Key points:
- `plugin.json` is a clean manifest (no mcpServers)
- `.mcp.json` at plugin root holds MCP server configuration
- Skills are auto-discovered from `skills/*/SKILL.md`
- `plugins/` is tracked in git (not gitignored)

## Skills

### social-listening
Core skill for creating social listening searches, fetching posts, and analyzing results across platforms. Supports keyword monitoring, competitor tracking, brand mentions, and industry trend detection.

### competitive-intel
Competitive intelligence skill for monitoring competitors, tracking product launches, analyzing positioning, and generating battle cards and reports.

### brand-monitor
Brand monitoring skill for tracking mentions, sentiment analysis, post performance tracking, and content iteration recommendations.

## MCP Server

All skills connect to Trigify's MCP server at `https://api.trigify.io/mcp`.

Setup: `claude mcp add trigify -- npx -y mcp-remote https://api.trigify.io/mcp`

Requires `TRIGIFY_API_KEY` environment variable.

## Build Commands

```bash
# Sync shared skills to the plugin
./sync-skills.sh

# Build distributable ZIP packages
./build-zips.sh
```

## Merging into benai-skills

To integrate into the main benai-skills repo:

1. Copy `shared-skills/*` → `benai-skills/shared-skills/`
2. Add Trigify MCP server + skills entries to `benai-skills/.claude-plugin/skills-map.json`
3. Add `social-intelligence` command to `benai-skills/commands/`
4. Run `benai-skills/sync-skills.sh` to regenerate plugins
5. Run `benai-skills/build-zips.sh` to rebuild distribution packages
