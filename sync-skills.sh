#!/bin/bash
# sync-skills.sh
# Generates plugins/ from shared-skills/ + skills-map.json
# This script is the build pipeline that distributes shared skills to department plugins

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
import sys

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

departments = skills_map.get('departments', {})

# Build a lookup for marketplace plugin metadata
marketplace_plugins = {}
for plugin in marketplace.get('plugins', []):
    marketplace_plugins[plugin['name']] = plugin

print(f"Found {len(departments)} departments to process")
print("")

for dept_name, dept_config in departments.items():
    print(f"Processing: {dept_name}")

    dept_dir = os.path.join(plugins_dir, dept_name)

    # Create plugin directory structure
    os.makedirs(os.path.join(dept_dir, '.claude-plugin'), exist_ok=True)
    os.makedirs(os.path.join(dept_dir, 'commands'), exist_ok=True)
    os.makedirs(os.path.join(dept_dir, 'skills'), exist_ok=True)

    # Generate plugin.json
    plugin_meta = marketplace_plugins.get(dept_name, {})
    plugin_json = {
        "name": dept_name,
        "version": plugin_meta.get("version", "1.0.0"),
        "description": plugin_meta.get("description", f"Social intelligence skills for {dept_name}"),
        "author": plugin_meta.get("author", {"name": "BenAI"})
    }

    # Add MCP servers if defined
    mcp_servers = dept_config.get('mcpServers', {})
    if mcp_servers:
        plugin_json['mcpServers'] = mcp_servers

    # Add skills metadata
    skills_meta = dept_config.get('skills', {})
    if skills_meta:
        plugin_json['skills'] = {}
        for skill_id, skill_info in skills_meta.items():
            plugin_json['skills'][skill_id] = {
                "displayName": skill_info.get("displayName", skill_id),
                "summary": skill_info.get("summary", "")
            }

    # Write plugin.json
    plugin_json_path = os.path.join(dept_dir, '.claude-plugin', 'plugin.json')
    with open(plugin_json_path, 'w') as f:
        json.dump(plugin_json, f, indent=2)
    print(f"  Created: .claude-plugin/plugin.json")

    # Copy command files
    command_names = dept_config.get('commands', [])
    for cmd_name in command_names:
        src = os.path.join(commands_dir, f"{cmd_name}.md")
        dst = os.path.join(dept_dir, 'commands', f"{cmd_name}.md")
        if os.path.exists(src):
            shutil.copy2(src, dst)
            print(f"  Copied command: {cmd_name}.md")
        else:
            print(f"  Warning: Command file not found: {cmd_name}.md")

    # Copy skill directories
    skill_names = dept_config.get('skills', {}).keys()
    for skill_name in skill_names:
        src = os.path.join(shared_skills_dir, skill_name)
        dst = os.path.join(dept_dir, 'skills', skill_name)
        if os.path.exists(src):
            shutil.copytree(src, dst)
            print(f"  Copied skill: {skill_name}/")
        else:
            print(f"  Warning: Skill directory not found: {skill_name}/")

    print(f"  Done: {dept_name} ({len(list(skill_names))} skills)")
    print("")

print("=== Sync complete ===")
print(f"Generated {len(departments)} department plugins in plugins/")
PYTHON_SCRIPT

echo ""
echo "Done! Run build-zips.sh to create distributable packages."
