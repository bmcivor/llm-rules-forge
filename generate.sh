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
    echo "Usage: llm-forge <tool> [extras...]"
    echo ""
    echo "Concatenate rule Markdown files for pasting into Cursor (or other) user rules."
    echo "Order: root base.md → <tool>/base.md → each extra you name, in order."
    echo ""
    echo "Arguments (after tool):"
    echo "  • Extras under the tool dir  — e.g. cursor: python, javascript, composer"
    echo "    (composer = Cursor Composer / agent-mode hardening; not a language.)"
    echo "  • Top-level modules          — ansible, git, ticketing, code-review"
    echo "    (each has <name>/base.md at repo root)"
    echo ""
    echo "Options:"
    echo "  --list, -l   List tools, per-tool extras, and top-level modules"
    echo "  --help, -h   Show this help"
    echo ""
    echo "  all          Same as: cursor + every cursor extra + every top-level module"
    echo "               (order: base chain, then extras sorted, then modules sorted)"
    echo ""
    echo "Examples:"
    echo "  llm-forge all > my-rules.md"
    echo "  llm-forge cursor composer python git ticketing"
    echo "  llm-forge cursor python git ticketing > my-rules.md"
    echo "  llm-forge --list"
}

list_available() {
    echo "Tools (each has <tool>/base.md):"
    for dir in "$SCRIPT_DIR"/*/; do
        dir_name=$(basename "$dir")
        [[ -f "$dir/base.md" ]] && [[ "$dir_name" != "docs" ]] && echo "  - $dir_name"
    done
    echo ""
    echo "Per-tool extras (optional files: <tool>/<name>.md, omit base.md):"
    for tool_dir in "$SCRIPT_DIR"/*/; do
        tool=$(basename "$tool_dir")
        [[ "$tool" == "docs" ]] && continue
        extras=$(find "$tool_dir" -maxdepth 1 -name "*.md" ! -name "base.md" -exec basename {} .md \; 2>/dev/null | sort | tr '\n' ' ')
        [[ -n "$extras" ]] && echo "  $tool → $extras"
    done
    echo ""
    echo "Top-level modules (optional: <name>/base.md):"
    for dir in "$SCRIPT_DIR"/*/; do
        dir_name=$(basename "$dir")
        [[ "$dir_name" == "cursor" ]] && continue
        [[ "$dir_name" == "docs" ]] && continue
        [[ -f "$dir/base.md" ]] && echo "  - $dir_name"
    done
    echo ""
    echo "Full bundle:            llm-forge all"
}

# cursor + all cursor/*.md (except base) + all */base.md modules (except cursor, docs); names sorted per group.
collect_all_argv() {
    local argv=(cursor)
    local f d n
    while IFS= read -r f; do
        argv+=("$(basename "$f" .md)")
    done < <(find "$SCRIPT_DIR/cursor" -maxdepth 1 -name "*.md" ! -name "base.md" | LC_ALL=C sort)
    while IFS= read -r d; do
        argv+=("$d")
    done < <(
        for dir in "$SCRIPT_DIR"/*/; do
            n=$(basename "$dir")
            [[ "$n" == "cursor" || "$n" == "docs" ]] && continue
            [[ -f "$dir/base.md" ]] && echo "$n"
        done | LC_ALL=C sort
    )
    printf '%s\0' "${argv[@]}"
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
    all)
        shift
        if [[ $# -gt 0 ]]; then
            echo "Error: 'all' does not take extra arguments (got: $*)." >&2
            exit 1
        fi
        mapfile -d '' -t _all_argv < <(collect_all_argv)
        concatenate "${_all_argv[@]}"
        ;;
    *)
        concatenate "$@"
        ;;
esac
