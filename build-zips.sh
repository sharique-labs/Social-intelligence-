#!/bin/bash
# build-zips.sh
# Builds distributable ZIP files for social intelligence plugins
# Runs sync-skills.sh first, then packages each department

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGINS="$SCRIPT_DIR/plugins"
DIST="$SCRIPT_DIR/dist"

echo "=== Building Social Intelligence Plugin Packages ==="
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

# Step 3: Build extension ZIPs (for Claude Code / Cursor / VS Code)
echo "Step 3: Building extension packages..."
for dept_dir in "$PLUGINS"/*/; do
    dept_name=$(basename "$dept_dir")

    echo "  Packaging: $dept_name (extension format)"

    # Create temp directory with marketplace structure
    temp_dir=$(mktemp -d)
    mkdir -p "$temp_dir/.claude-plugin"

    # Copy marketplace.json
    cp "$SCRIPT_DIR/.claude-plugin/marketplace.json" "$temp_dir/.claude-plugin/"

    # Copy the department plugin
    mkdir -p "$temp_dir/plugins"
    cp -r "$dept_dir" "$temp_dir/plugins/$dept_name/"

    # Create ZIP
    (cd "$temp_dir" && zip -r "$DIST/extension/$dept_name.zip" . -x "*.DS_Store" > /dev/null 2>&1)

    # Cleanup
    rm -rf "$temp_dir"

    echo "    Created: dist/extension/$dept_name.zip"
done

# Step 4: Build Claude Console ZIPs (flat structure, skills only)
echo ""
echo "Step 4: Building Claude Console packages..."
for dept_dir in "$PLUGINS"/*/; do
    dept_name=$(basename "$dept_dir")

    echo "  Packaging: $dept_name (claude format)"

    # Create temp directory with flat skill structure
    temp_dir=$(mktemp -d)

    # Copy each skill as top-level folder
    if [ -d "$dept_dir/skills" ]; then
        for skill_dir in "$dept_dir/skills"/*/; do
            skill_name=$(basename "$skill_dir")
            cp -r "$skill_dir" "$temp_dir/$skill_name/"
        done
    fi

    # Create ZIP
    (cd "$temp_dir" && zip -r "$DIST/claude/$dept_name.zip" . -x "*.DS_Store" > /dev/null 2>&1)

    # Cleanup
    rm -rf "$temp_dir"

    echo "    Created: dist/claude/$dept_name.zip"
done

# Step 5: Build full marketplace ZIP
echo ""
echo "Step 5: Building full marketplace package..."
temp_dir=$(mktemp -d)
cp -r "$SCRIPT_DIR/.claude-plugin" "$temp_dir/"
cp -r "$PLUGINS" "$temp_dir/plugins"
(cd "$temp_dir" && zip -r "$DIST/extension/social-intelligence-marketplace.zip" . -x "*.DS_Store" > /dev/null 2>&1)
rm -rf "$temp_dir"
echo "    Created: dist/extension/social-intelligence-marketplace.zip"

echo ""
echo "=== Build complete ==="
echo ""
echo "Extension packages (Claude Code / Cursor / VS Code):"
ls -lh "$DIST/extension/"
echo ""
echo "Claude Console packages (platform.claude.com):"
ls -lh "$DIST/claude/"
