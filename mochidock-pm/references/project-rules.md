# MochiDock Project Rules

Read this reference when planning a stage, changing scope, reviewing project structure, generating a handoff, or verifying takeover.

## Product direction

- Build MochiDock first as a natural, playful, low-interruption macOS desktop pet.
- Let later tool capabilities emerge from real use.
- Keep AI as a future possibility until there is a specific, testable use case.
- Use small experiments and actual experience instead of requiring a complete PRD upfront.

## Roles and decisions

- The user is project manager, product owner, and final decision-maker.
- Codex analyzes, organizes, implements within authorization, verifies, and surfaces risks.
- Require user confirmation for product direction, core feature category, privacy, recurring paid services, important dependencies, data persistence, release, and large-scale rewrites.

## Product stages

### Stage 1: Minimum experiential desktop pet

Validate stable desktop display, dragging, clicking, basic pointer response, simple animation/state changes, understandable menu/settings/quit behavior, low interruption, and willingness to keep the pet present.

Exclude a full chat system, knowledge base, complex agent, tool platform, and unvalidated large AI features.

### Later stages

- Refine interaction and settings from Stage 1 evidence.
- Test one small tool scenario selected from real use.
- Test one explicit AI scenario only after privacy, cost, data flow, and fallback are understood and the user confirms the direction.

## Lightweight scope model

Maintain only:

1. Current work.
2. Possible next work.
3. Idea pool, not committed.

Before each stage, state what is included and excluded.

## Code structure

- Use 500–600 lines as a warning range rather than a hard limit.
- Check for mixed responsibilities around 400 lines.
- Prefer responsibility-based splitting above 600 lines.
- Explain and obtain confirmation for exceptions above 1000 lines.
- Separate entry and assembly code from implementation.
- Extract shared code only after genuine reuse.
- Avoid universal utility containers and mechanical splitting.

## Project memory

- Code and tests are facts.
- Project documents are confirmed agreements.
- Skills are reusable methods.
- Handoffs are task-local operational state.
- Chat is a temporary analysis surface, not the only project memory.

## Output experience

- Deliver a requested copyable artifact as one continuous item.
- Keep explanation outside the artifact.
- Prefer creating a file and linking it for long content.
- Check that Markdown fences are balanced before delivery.
