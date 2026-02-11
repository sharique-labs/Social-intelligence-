#!/bin/bash
#
# Generates the entire plugins/ directory from shared-skills/ and .claude-plugin/skills-map.json.
# Everything under plugins/ is disposable — this script recreates it from scratch.
#
# Usage: ./sync-skills.sh

set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
SHARED="$ROOT/shared-skills"
SKILLS_MAP="$ROOT/.claude-plugin/skills-map.json"
MARKETPLACE="$ROOT/.claude-plugin/marketplace.json"
COMMANDS="$ROOT/commands"

if [ ! -d "$SHARED" ]; then
  echo "Error: shared-skills/ directory not found" >&2
  exit 1
fi

if [ ! -f "$SKILLS_MAP" ]; then
  echo "Error: .claude-plugin/skills-map.json not found" >&2
  exit 1
fi

if [ ! -f "$MARKETPLACE" ]; then
  echo "Error: .claude-plugin/marketplace.json not found" >&2
  exit 1
fi

# Wipe and regenerate plugins/
rm -rf "$ROOT/plugins"
mkdir -p "$ROOT/plugins"

export ROOT SHARED SKILLS_MAP MARKETPLACE COMMANDS

python3 << 'PYEOF'
import json, os, shutil

root = os.environ.get("ROOT", "")
shared = os.environ.get("SHARED", "")
skills_map_path = os.environ.get("SKILLS_MAP", "")
marketplace_path = os.environ.get("MARKETPLACE", "")
commands_src = os.environ.get("COMMANDS", "")

with open(skills_map_path) as f:
    skills_map = json.load(f)

with open(marketplace_path) as f:
    marketplace = json.load(f)

# Index marketplace plugins by name
marketplace_plugins = {p["name"]: p for p in marketplace["plugins"]}
plugins = skills_map["plugins"]

for plugin_name, plugin_config in plugins.items():
    plugin_dir = os.path.join(root, "plugins", plugin_name)
    skills = plugin_config["skills"]

    # --- .claude-plugin/plugin.json (clean manifest, no mcpServers) ---
    plugin_json_dir = os.path.join(plugin_dir, ".claude-plugin")
    os.makedirs(plugin_json_dir, exist_ok=True)

    mp = marketplace_plugins.get(plugin_name, {})
    plugin_data = {
        "name": plugin_name,
        "description": mp.get("description", ""),
        "version": mp.get("version", "1.0.0"),
        "author": mp.get("author", {"name": "BenAI"}),
    }

    with open(os.path.join(plugin_json_dir, "plugin.json"), "w") as f:
        json.dump(plugin_data, f, indent=2)
        f.write("\n")

    # --- .mcp.json at plugin root (separate MCP server config) ---
    if "mcpServers" in plugin_config:
        mcp_data = {"mcpServers": plugin_config["mcpServers"]}
        with open(os.path.join(plugin_dir, ".mcp.json"), "w") as f:
            json.dump(mcp_data, f, indent=2)
            f.write("\n")

    # --- commands/ ---
    commands_dir = os.path.join(plugin_dir, "commands")
    os.makedirs(commands_dir, exist_ok=True)

    cmd_list = plugin_config.get("commands", [])
    for cmd_name in cmd_list:
        src = os.path.join(commands_src, f"{cmd_name}.md")
        if os.path.isfile(src):
            shutil.copy2(src, os.path.join(commands_dir, f"{cmd_name}.md"))
        else:
            print(f"  Warning: commands/{cmd_name}.md not found, skipping")

    # --- skills/ ---
    skills_dir = os.path.join(plugin_dir, "skills")
    os.makedirs(skills_dir, exist_ok=True)

    count = 0
    for skill_id in skills:
        src = os.path.join(shared, skill_id)
        dst = os.path.join(skills_dir, skill_id)
        if os.path.isdir(src):
            shutil.copytree(src, dst)
            count += 1
        else:
            print(f"  Warning: shared-skills/{skill_id} not found, skipping")

    print(f"  {plugin_name}: {count} skills synced")

PYEOF

echo "Done. Plugin generated from shared-skills/ and skills-map.json."
