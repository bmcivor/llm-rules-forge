# Code Review Base Rules

Rules for conducting code reviews with LLM assistance.

**Inherits from:** `../base.md`

## Output Format

- Place code review output in a markdown file at the top level of the repository
- Name the file descriptively (e.g., `code-review-YYYY-MM-DD.md` or `code-review-feature-name.md`)

## Review Process

- Ask follow-up questions first if there is any doubt about context, requirements, or intent
- Only generate the review file after clarifying any uncertainties
- Conduct reviews in depth, examining logic, patterns, and potential issues thoroughly

## Issue Reporting

- Describe each issue succinctly while maintaining clarity
- Number all issues sequentially for easy reference
- Order issues by priority: critical first, then high, medium, low
- Use consistent priority labels throughout the review
- Ensure critical issues are visually distinct from low-priority ones - don't let volume of minor issues dilute the critical ones
- Every issue must earn its place - if it's not worth the user reading it, don't include it

## Issue Format

Each issue should include:
1. **Priority level** (Critical, High, Medium, Low)
2. **Clear description** of the problem
3. **Location** (file path and line numbers if applicable)
4. **Suggested fix** or direction for resolution

## Example Structure

```markdown
# Code Review - [Feature/PR Name]

## Critical Issues

1. [Description of critical issue]
   - Location: `path/to/file.py:123-145`
   - Suggestion: [How to fix]

## High Priority Issues

2. [Description of high priority issue]
   ...

## Medium Priority Issues

...

## Low Priority Issues

...
```

---

*This file contains code review rules for LLM assistance.*
