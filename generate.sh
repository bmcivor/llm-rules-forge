#!/bin/bash
set -euo pipefail

SOURCE="${BASH_SOURCE[0]}"
while [[ -L "$SOURCE" ]]; do
    SCRIPT_DIR="$(cd "$(dirname "$SOURCE")" && pwd)"
    SOURCE="$(readlink "$SOURCE")"
    [[ "$SOURCE" != /* ]] && SOURCE="$SCRIPT_DIR/$SOURCE"
done
SCRIPT_DIR="$(cd "$(dirname "$SOURCE")" && pwd)"

show_help() {
    cat <<'EOF'
Usage: llm-forge <tool> [extras...]

Concatenate rule Markdown files for pasting into your LLM tool's user rules.

Tool: a directory at the repo root containing one or more .md files (e.g. agent).
All .md files in the tool's directory are included, with base.md first if present,
then the rest alphabetically.

Extras (after tool):
  - Language names   - looked up in languages/ (e.g. python, javascript)
  - Module names     - directories with base.md at repo root (git, ticketing, ansible, code-review)

Options:
  --list, -l   List tools, languages, and modules
  --help, -h   Show this help

  all          Bundle everything: root base + all tool dirs + all languages + all modules

Examples:
  llm-forge agent > my-rules.md
  llm-forge agent python git ticketing
  llm-forge all > my-rules.md
EOF
}

# Tool dirs: any directory at repo root that contains at least one .md file,
# excluding docs/ and languages/ (the latter is handled separately).
list_tool_dirs() {
    for dir in "$SCRIPT_DIR"/*/; do
        n=$(basename "$dir")
        [[ "$n" == "docs" || "$n" == "languages" ]] && continue
        [[ "$n" == .* ]] && continue
        if find "$dir" -maxdepth 1 -name "*.md" -print -quit 2>/dev/null | grep -q .; then
            echo "$n"
        fi
    done | LC_ALL=C sort
}

list_available() {
    echo "Tools (directories with one or more .md files):"
    for tool in $(list_tool_dirs); do
        files=$(find "$SCRIPT_DIR/$tool" -maxdepth 1 -name "*.md" -exec basename {} .md \; 2>/dev/null | LC_ALL=C sort | tr '\n' ' ')
        echo "  - $tool -> $files"
    done
    echo ""
    echo "Languages (use as extras):"
    if [[ -d "$SCRIPT_DIR/languages" ]]; then
        find "$SCRIPT_DIR/languages" -maxdepth 1 -name "*.md" -exec basename {} .md \; 2>/dev/null | LC_ALL=C sort | while read -r l; do
            echo "  - $l"
        done
    fi
    echo ""
    echo "Full bundle: llm-forge all"
}

# List of file paths for a tool dir: base.md first if present, then the rest alphabetically.
files_in_tool_dir() {
    local tool="$1"
    local tool_dir="$SCRIPT_DIR/$tool"
    [[ -f "$tool_dir/base.md" ]] && echo "$tool_dir/base.md"
    find "$tool_dir" -maxdepth 1 -name "*.md" ! -name "base.md" 2>/dev/null | LC_ALL=C sort
}

# Resolve an extra argument to a file path, or empty if not found.
resolve_extra() {
    local arg="$1"
    if [[ -f "$SCRIPT_DIR/languages/$arg.md" ]]; then
        echo "$SCRIPT_DIR/languages/$arg.md"
    elif [[ -f "$SCRIPT_DIR/$arg/base.md" ]]; then
        echo "$SCRIPT_DIR/$arg/base.md"
    fi
}

emit_files() {
    for f in "$@"; do
        if [[ -f "$f" ]]; then
            cat "$f"
            echo ""
        fi
    done
}

if [[ $# -eq 0 ]]; then
    show_help
    exit 0
fi

case "$1" in
    --help|-h)
        show_help
        exit 0
        ;;
    --list|-l)
        list_available
        exit 0
        ;;
    all)
        shift
        if [[ $# -gt 0 ]]; then
            echo "Error: 'all' does not take extra arguments (got: $*)." >&2
            exit 1
        fi
        files=("$SCRIPT_DIR/base.md")
        for tool in $(list_tool_dirs); do
            while IFS= read -r f; do
                files+=("$f")
            done < <(files_in_tool_dir "$tool")
        done
        if [[ -d "$SCRIPT_DIR/languages" ]]; then
            while IFS= read -r f; do
                files+=("$f")
            done < <(find "$SCRIPT_DIR/languages" -maxdepth 1 -name "*.md" 2>/dev/null | LC_ALL=C sort)
        fi
        emit_files "${files[@]}"
        ;;
    *)
        tool="$1"
        shift
        if [[ ! -d "$SCRIPT_DIR/$tool" ]]; then
            echo "Error: Unknown tool '$tool'. Use --list to see available options." >&2
            exit 1
        fi
        files=("$SCRIPT_DIR/base.md")
        while IFS= read -r f; do
            files+=("$f")
        done < <(files_in_tool_dir "$tool")
        for arg in "$@"; do
            extra=$(resolve_extra "$arg")
            if [[ -n "$extra" ]]; then
                files+=("$extra")
            else
                echo "Warning: Unknown extra '$arg', skipping." >&2
            fi
        done
        emit_files "${files[@]}"
        ;;
esac
