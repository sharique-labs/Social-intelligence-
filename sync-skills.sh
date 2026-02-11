#!/bin/bash
# sync-skills.sh
# Generates plugins/ from shared-skills/ + skills-map.json
# Output follows the official Claude Code plugin architecture:
#   plugins/{plugin}/.claude-plugin/plugin.json  — clean manifest
#   plugins/{plugin}/.mcp.json                   — separate MCP server config
#   plugins/{plugin}/skills/                     — auto-discovered skill folders
#   plugins/{plugin}/commands/                   — slash commands

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_MAP="$SCRIPT_DIR/.claude-plugin/skills-map.json"
MARKETPLACE="$SCRIPT_DIR/.claude-plugin/marketplace.json"
SHARED_SKILLS="$SCRIPT_DIR/shared-skills"
COMMANDS="$SCRIPT_DIR/commands"
PLUGINS="$SCRIPT_DIR/plugins"

echo "=== Social Intelligence Plugin Sync ==="
echo ""

# Check dependencies
if ! command -v python3 &> /dev/null; then
    echo "Error: python3 is required but not installed."
    exit 1
fi

# Clean plugins directory
echo "Cleaning plugins/ directory..."
rm -rf "$PLUGINS"
mkdir -p "$PLUGINS"

# Run the sync
python3 << 'PYTHON_SCRIPT'
import json
import os
import shutil

script_dir = os.environ.get('SCRIPT_DIR', os.path.dirname(os.path.abspath(__file__)))
skills_map_path = os.path.join(script_dir, '.claude-plugin', 'skills-map.json')
marketplace_path = os.path.join(script_dir, '.claude-plugin', 'marketplace.json')
shared_skills_dir = os.path.join(script_dir, 'shared-skills')
commands_dir = os.path.join(script_dir, 'commands')
plugins_dir = os.path.join(script_dir, 'plugins')

# Load configs
with open(skills_map_path, 'r') as f:
    skills_map = json.load(f)

with open(marketplace_path, 'r') as f:
    marketplace = json.load(f)

plugins = skills_map.get('plugins', {})

# Build a lookup for marketplace plugin metadata
marketplace_plugins = {}
for plugin in marketplace.get('plugins', []):
    marketplace_plugins[plugin['name']] = plugin

print(f"Found {len(plugins)} plugin(s) to process")
print("")

for plugin_name, plugin_config in plugins.items():
    print(f"Processing: {plugin_name}")

    plugin_dir = os.path.join(plugins_dir, plugin_name)

    # Create plugin directory structure (official Claude Code layout)
    os.makedirs(os.path.join(plugin_dir, '.claude-plugin'), exist_ok=True)
    os.makedirs(os.path.join(plugin_dir, 'commands'), exist_ok=True)
    os.makedirs(os.path.join(plugin_dir, 'skills'), exist_ok=True)

    # --- Generate clean plugin.json (no mcpServers, no skills metadata) ---
    plugin_meta = marketplace_plugins.get(plugin_name, {})
    plugin_json = {
        "name": plugin_name,
        "version": plugin_meta.get("version", "1.0.0"),
        "description": plugin_meta.get("description", f"Social intelligence plugin: {plugin_name}"),
        "author": plugin_meta.get("author", {"name": "BenAI"}),
        "keywords": plugin_meta.get("keywords", []),
        "license": "MIT"
    }

    plugin_json_path = os.path.join(plugin_dir, '.claude-plugin', 'plugin.json')
    with open(plugin_json_path, 'w') as f:
        json.dump(plugin_json, f, indent=2)
    print(f"  Created: .claude-plugin/plugin.json")

    # --- Generate separate .mcp.json at plugin root ---
    mcp_servers = plugin_config.get('mcpServers', {})
    if mcp_servers:
        mcp_json = {"mcpServers": mcp_servers}
        mcp_json_path = os.path.join(plugin_dir, '.mcp.json')
        with open(mcp_json_path, 'w') as f:
            json.dump(mcp_json, f, indent=2)
        print(f"  Created: .mcp.json")

    # --- Copy command files ---
    command_names = plugin_config.get('commands', [])
    for cmd_name in command_names:
        src = os.path.join(commands_dir, f"{cmd_name}.md")
        dst = os.path.join(plugin_dir, 'commands', f"{cmd_name}.md")
        if os.path.exists(src):
            shutil.copy2(src, dst)
            print(f"  Copied command: {cmd_name}.md")
        else:
            print(f"  Warning: Command file not found: {cmd_name}.md")

    # --- Copy skill directories ---
    skill_names = plugin_config.get('skills', {}).keys()
    for skill_name in skill_names:
        src = os.path.join(shared_skills_dir, skill_name)
        dst = os.path.join(plugin_dir, 'skills', skill_name)
        if os.path.exists(src):
            shutil.copytree(src, dst)
            print(f"  Copied skill: {skill_name}/")
        else:
            print(f"  Warning: Skill directory not found: {skill_name}/")

    print(f"  Done: {plugin_name} ({len(list(skill_names))} skills)")
    print("")

print("=== Sync complete ===")
print(f"Generated {len(plugins)} plugin(s) in plugins/")
print("")
print("Plugin follows the official Claude Code plugin architecture:")
print("  .claude-plugin/plugin.json  — clean manifest (name, version, description, author, keywords)")
print("  .mcp.json                   — separate MCP server configuration")
print("  skills/                     — auto-discovered skill folders with SKILL.md")
print("  commands/                   — slash command files")
PYTHON_SCRIPT

echo ""
echo "Done! Run build-zips.sh to create distributable packages."
