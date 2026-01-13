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
    echo "Usage: llm-forge <tool> [language] [modules...]"
    echo ""
    echo "Concatenates rule files for LLM configuration."
    echo ""
    echo "Arguments:"
    echo "  tool       The IDE/tool (e.g., cursor)"
    echo "  language   Optional language under the tool (e.g., python, javascript)"
    echo "  modules    Additional modules to include (e.g., git, ticketing)"
    echo ""
    echo "Options:"
    echo "  --list     Show available tools, languages, and modules"
    echo "  --help     Show this help"
    echo ""
    echo "Examples:"
    echo "  llm-forge cursor python git ticketing"
    echo "  llm-forge cursor python git ticketing > my-rules.md"
    echo "  llm-forge --list"
}

list_available() {
    echo "Tools:"
    for dir in "$SCRIPT_DIR"/*/; do
        dir_name=$(basename "$dir")
        [[ -f "$dir/base.md" ]] && [[ "$dir_name" != "docs" ]] && echo "  - $dir_name"
    done
    echo ""
    echo "Languages (per tool):"
    for tool_dir in "$SCRIPT_DIR"/*/; do
        tool=$(basename "$tool_dir")
        [[ "$tool" == "docs" ]] && continue
        langs=$(find "$tool_dir" -maxdepth 1 -name "*.md" ! -name "base.md" -exec basename {} .md \; 2>/dev/null | tr '\n' ' ')
        [[ -n "$langs" ]] && echo "  $tool: $langs"
    done
    echo ""
    echo "Modules (top-level):"
    for dir in "$SCRIPT_DIR"/*/; do
        dir_name=$(basename "$dir")
        [[ "$dir_name" == "cursor" ]] && continue
        [[ "$dir_name" == "docs" ]] && continue
        [[ -f "$dir/base.md" ]] && echo "  - $dir_name"
    done
}

concatenate() {
    local tool="$1"
    shift
    local parts=()

    if [[ ! -d "$SCRIPT_DIR/$tool" ]]; then
        echo "Error: Unknown tool '$tool'. Use --list to see available options." >&2
        exit 1
    fi

    parts+=("$SCRIPT_DIR/base.md")
    parts+=("$SCRIPT_DIR/$tool/base.md")

    for arg in "$@"; do
        if [[ -f "$SCRIPT_DIR/$tool/$arg.md" ]]; then
            parts+=("$SCRIPT_DIR/$tool/$arg.md")
        elif [[ -f "$SCRIPT_DIR/$arg/base.md" ]]; then
            parts+=("$SCRIPT_DIR/$arg/base.md")
        else
            echo "Warning: Unknown module or language '$arg', skipping." >&2
        fi
    done

    for file in "${parts[@]}"; do
        if [[ -f "$file" ]]; then
            cat "$file"
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
    *)
        concatenate "$@"
        ;;
esac
