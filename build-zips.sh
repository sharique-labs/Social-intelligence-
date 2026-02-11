#!/bin/bash
# build-zips.sh
# Builds distributable ZIP files for the social intelligence plugin
# Runs sync-skills.sh first, then packages the plugin

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGINS="$SCRIPT_DIR/plugins"
DIST="$SCRIPT_DIR/dist"

echo "=== Building Social Intelligence Plugin Package ==="
echo ""

# Step 1: Sync skills first
echo "Step 1: Syncing skills..."
bash "$SCRIPT_DIR/sync-skills.sh"
echo ""

# Step 2: Create dist directories
echo "Step 2: Creating distribution directories..."
rm -rf "$DIST"
mkdir -p "$DIST/extension"
mkdir -p "$DIST/claude"

# Step 3: Build extension ZIP (for Claude Code / Cursor / VS Code)
echo "Step 3: Building extension package..."
for plugin_dir in "$PLUGINS"/*/; do
    plugin_name=$(basename "$plugin_dir")

    echo "  Packaging: $plugin_name (extension format)"

    # Create temp directory with marketplace structure
    temp_dir=$(mktemp -d)
    mkdir -p "$temp_dir/.claude-plugin"

    # Copy marketplace.json
    cp "$SCRIPT_DIR/.claude-plugin/marketplace.json" "$temp_dir/.claude-plugin/"

    # Copy the plugin
    mkdir -p "$temp_dir/plugins"
    cp -r "$plugin_dir" "$temp_dir/plugins/$plugin_name/"

    # Create ZIP
    (cd "$temp_dir" && zip -r "$DIST/extension/$plugin_name.zip" . -x "*.DS_Store" > /dev/null 2>&1)

    # Cleanup
    rm -rf "$temp_dir"

    echo "    Created: dist/extension/$plugin_name.zip"
done

# Step 4: Build Claude Console ZIP (flat structure, skills only)
echo ""
echo "Step 4: Building Claude Console package..."
for plugin_dir in "$PLUGINS"/*/; do
    plugin_name=$(basename "$plugin_dir")

    echo "  Packaging: $plugin_name (claude format)"

    # Create temp directory with flat skill structure
    temp_dir=$(mktemp -d)

    # Copy each skill as top-level folder
    if [ -d "$plugin_dir/skills" ]; then
        for skill_dir in "$plugin_dir/skills"/*/; do
            skill_name=$(basename "$skill_dir")
            cp -r "$skill_dir" "$temp_dir/$skill_name/"
        done
    fi

    # Create ZIP
    (cd "$temp_dir" && zip -r "$DIST/claude/$plugin_name.zip" . -x "*.DS_Store" > /dev/null 2>&1)

    # Cleanup
    rm -rf "$temp_dir"

    echo "    Created: dist/claude/$plugin_name.zip"
done

echo ""
echo "=== Build complete ==="
echo ""
echo "Extension package (Claude Code / Cursor / VS Code):"
ls -lh "$DIST/extension/"
echo ""
echo "Claude Console package (platform.claude.com):"
ls -lh "$DIST/claude/"
