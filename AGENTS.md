# AGENTS.md

## Purpose

This repository is for the Canonical Ubuntu Basic training site.

`ubuntu_basic_lab.md` is authoritative for technical content. Keep it unchanged.

## Source Of Truth

- Treat `ubuntu_basic_lab.md` as read-only.
- Preserve the technical meaning of the source material.
- Improve wording, structure, and consistency where useful.
- Keep the tone professional and minimal.
- Do not correct lab assumptions, commands, paths, configuration files, or expected output until validation confirms the required change.
- Record validated current lab-environment details and confirmed requirements in `docs/prerequisites.md`.

## Agent Routing

### Required Routing Rules

- For discovery tasks, the main agent must delegate the first pass to `explore`.
- For analysis tasks, the main agent must gather evidence with `explore` first and then delegate reasoning to `general`.
- For active-change tasks, the main agent must delegate edit and implementation work to `general` when the context is clear and the instructions are not risky. Direct main-agent edits are allowed only for trivial, urgent, or unsafe-to-delegate cases. The main agent must not do broad discovery directly when `explore` fits the task.
- Direct main-agent inspection is allowed only for narrow follow-up reads tied to a known file/path, an edit already in progress, or a verification step.

### Agent Roles and Selection

- **Read-Only Tasks (`explore`):** Use the `explore` agent for discovery work: searching the repository, reading files, inspecting documentation, understanding existing patterns, summarizing findings, and running read-only commands. This includes exploratory diagnostics against lab machines or other environments when the intent is observation rather than change.
- **Active Tasks (`general`):** Use the `general` agent for edit and implementation work when the context is clear and instructions are not risky, for actions that interact with systems in a non-read-only way, execute commands with side effects, or perform external operations with side effects. The main agent may still perform direct local file edits for trivial, urgent, or unsafe-to-delegate cases, and narrowly scoped supporting reads as allowed by the routing rules above.
- **Keep Context Small:** Use the smallest relevant files, snippets, or command outputs needed to answer the question. Avoid loading large files or broad documentation into the main context unless necessary.

### Delegation Rules

- Every sub-agent prompt must explicitly restrict filesystem access to the repository root (`/home/radu/Dev/cb-canonical-ubuntu-basic`). Sub-agents must not inspect, read, write, or otherwise access paths outside it.
- Sub-agent prompts must prohibit remote-system and network access by default. Permit such access only when the user explicitly requests it, and name the exact target and allowed scope.
- Do not ask sub-agents to guess missing targets, credentials, command syntax, deployment details, or environment assumptions.
- When delegating, provide the exact target, task objective, known constraints, commands or files involved, safety limits, and expected behavior.
- Ask sub-agents to return concise factual results: what was inspected or changed, commands run, files touched, important output, errors, and current state.
- Delegate the smallest safe unit of work. Avoid broad or open-ended instructions when a precise task can be given.
- When tasks are independent and do not rely on each other, prefer parallel delegation. Keep dependent work sequential.

### Main-Agent Restrictions

- The main agent must not perform broad repository discovery directly when `explore` fits the task.
- The main agent must not perform direct edit or implementation work when it can be safely delegated to `general` with clear context and non-risky instructions.
- The main agent must not perform active external-system work directly when `general` is the appropriate isolation boundary.
- The main agent remains responsible for orchestration, deciding whether evidence is sufficient, choosing follow-up actions, and producing the final user-facing answer.

## Site Structure

- Use `docs/` as the MkDocs documentation source directory.
- Split numbered chapter content into one file per numbered top-level chapter; required reference pages are permitted.
- Include all 10 numbered top-level chapters from `ubuntu_basic_lab.md`.
- Do not create separate files for subsections unless explicitly requested.
- Use the source introduction to form `docs/index.md`, the site home page.
- Keep a separate reference page for the source appendix "Networking".
- Keep `docs/prerequisites.md` as the reference page, located immediately after Home in navigation, for validated current lab-environment details and confirmed requirements.
- Keep `docs/assets/` for training diagrams and other documentation assets.
- Keep `migration.md` at the repository root as the internal migration tracker.
- Keep `playground.md` at the repository root as the authoritative current lab-assignment source to use before lab execution. It must remain a compact, few-lines-per-student Markdown equivalent of `students_bofa_ubuntu_basic.json` and contain nothing beyond those student fields and values. `students_bofa_ubuntu_basic.json` is the synchronization/reference input and cannot override a synchronized `playground.md` except when deliberately resynchronizing it.
- The SSH username for lab VMs is always `ubuntu`; never derive it from a student name, email, or other student identity field.
- Keep `commands.md` at the repository root as internal historical reference only. It must never provide current connection targets, credentials, machine state, assignment information, or validation evidence.
- Treat `lab_commands/` as read-only supporting command-reference material. Its commands are not successful training commands and must not be recorded in `commands.md` unless they also appear in the source training material and are successfully executed.

## Navigation Status Markers

Use these status markers consistently in `mkdocs.yml` navigation labels:

- `📋` for completed or currently validated pages.
- `⏳` for pages still in progress.
- `📄` for reference pages.

## Writing Rules

- Keep explanations concise.
- Do not over-explain unless explicitly asked.
- Prefer direct, task-focused wording.
- Normalize inconsistent formatting from the source.
- Keep command examples close to the original intent, but rewrite for clarity when needed.
- All second-level headings must use the prefix `:material-book-open-page-variant-outline:`, for example `## :material-book-open-page-variant-outline: Second level header`.
- All third-level headings must use the prefix `:material-application-edit-outline:`, for example `### :material-application-edit-outline: Third level header`.

## Admonitions

Use Material admonitions when they improve clarity:

- Use `!!! abstract` for page goals and short page-purpose callouts.
- Use `!!! note` for context.
- Use `!!! tip` for helpful shortcuts or best practices.
- Use `!!! warning` for risky actions.
- Use `!!! danger` for actions that can break the lab or destroy data.
- Use expandable admonitions such as `??? example` for bulky "Current result in this lab" snapshots so the default reading path stays compact.

## Command Formatting

- Start every fenced shell-command block with a short shell comment immediately before the command; an outside prose sentence alone does not satisfy this rule.
- When presenting a provided lab file, use a student-useful inspection command such as `cat <path>` with an in-block shell comment and paired expected-result block instead of rendering the file directly in prose.
- Use one command block per command.
- Do not group multiple commands under one shared comment or one shared expected-result block.
- Exception: A student-useful shell-variable assignment and its immediately following `echo "$VARIABLE"` verification may share a command block and expected-result pair; the expected result contains only the echo output.
- Each command must be followed by an admonition in this form:

```md
??? example "Expected result"
    Expected output or verification notes.
```

- Commands and expected results must remain in pairs.
- Each command must have its own paired expected-result admonition.
- **Command-result lifecycle:** Before validation, every expected-result block must contain exactly `Validation pending; no captured output is available.` This is a temporary pre-validation notice, not output.
- Hide source-provided fixtures until successful execution validates them.
- Only successful execution may replace the pending notice with captured literal output or a faithful literal excerpt. Do not use representative, descriptive, inferred, synthetic, assumed, or unverified output; do not use placeholders, invented values, or redaction placeholders in student-facing results.
- Use `No output.` only when successful execution proves the command produces no output.
- For variable output, include safe captured values and a concise variability note only after validation. Do not commit active bearer tokens, certificate contents, SSH credentials, or connection values.

## Lab Flow

- Default to an interactive workflow only when the user explicitly asks for an interactive session during live training.
- Present one instruction at a time when running the lab with the user.
- Before every lab command in interactive mode, state the exact command you recommend next and explain its intent in one short sentence.
- Show the student-facing command exactly as the student should see and run it, even if the actual executed command uses SSH wrappers or other environment-specific prefixes.
- Do not skip the intent explanation, even for obvious or repetitive commands.
- In an interactive session, run one command at a time only.
- In an interactive session, wait for explicit user approval before running each command.
- In an interactive session, after the user runs a non-interactive command, double-check the result before moving on.
- In an interactive session, do not update `commands.md` for commands executed by the user or student.
- After each command, report the result and explain what it means before moving on.
- In an interactive session, if the user says `go`, treat that as approval to proceed with the recommended next step.

## Editing Rules

- Prefer the smallest correct change.
- Keep existing deployment artifacts such as `helm/` and `Dockerfile` unless explicitly asked to change them.
- Do not remove source material that belongs to the training.
- Do not run `mkdocs build` or otherwise attempt to build the MkDocs site unless the user explicitly asks for it.

## Git

- When the user asks for a Git commit, run `git add`, `git commit`, `git pull --rebase`, and then `git push`, each with appropriate arguments and only after the preceding command succeeds.
- Delegate Git commit execution to a `general` sub-agent.

## CI and Release Versioning

- CI owns Helm chart versioning, application versioning, and container image tags.
- Do not manually change `helm/Chart.yaml` `version` or `appVersion`, or `helm/values.yaml` `image.tag`, unless the user explicitly requests a version change.
- Do not infer, select, or increment release versions for deployment fixes.

## Tracking Files

- Update `migration.md` after each material change to record the current phase, active page, next action, status by chapter and subsection, open findings, blockers, and a dated session log.
- Track subsections for all 10 Ubuntu Basic chapters in `migration.md`, not just top-level chapters.
- Use these migration statuses: `Not started`, `Structured`, `Formatting`, `Ready for validation`, `Validating`, `Blocked`, and `Complete`.
- Mark a chapter as `Complete` only after all commands in that chapter have been run and their results have been documented.
- Keep unvalidated pages marked `⏳` in `mkdocs.yml`; use `📋` only for completed or currently validated pages.
- Deliberately resynchronize `playground.md` from `students_bofa_ubuntu_basic.json` whenever a lab assignment is added, changed, or reassigned. Use the synchronized `playground.md` as the current execution context; it is not part of the training content.
- Update `commands.md` for successful training commands executed by the agent locally or remotely, including during live interactive training sessions.
- Record only commands from the training material that actually succeeded.
- Record the exact command string that was actually executed successfully, except redact external SSH connection wrappers and credentials as `Connection wrapper: [redacted; executed against the assigned lab VM]` while retaining the exact student/source command. This internal-record redaction does not apply to student-facing expected results.
- Do not replace the executed command with a simplified or student-facing form in `commands.md`.
- Do not record failed commands, exploratory commands, or commands that were corrected before a successful run.
