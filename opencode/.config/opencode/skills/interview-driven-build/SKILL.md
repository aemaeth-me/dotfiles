---
name: interview-driven-build
description: Use this skill when the user wants to produce a non-trivial artifact — plan, config file, code module, schema, API spec, deployment manifest — through iterative dialogue rather than one-shot generation. Triggers include explicit asks like "interview me about X", "let's spec this out together", "walk me through writing this config", "help me design this carefully", or when the user rejects a unilaterally drafted artifact and asks to work through it together. Also use when a request has many interdependent decisions a competent agent cannot resolve from context alone (e.g., writing a config touching auth, networking, and storage at once). Do NOT use for small targeted edits, single-question clarifications, or artifacts where the user has already specified all material decisions.
---

# Interview-Driven Build

Drive a structured interview that converges on a written artifact (plan, config, code, schema, or other spec). The goal is shared understanding of every decision that ends up in the artifact, not a checklist of answered questions.

## What counts as a "decision"

Anything that goes into the artifact and could reasonably be otherwise. For a plan: architectural forks. For a config: a field's value, presence, or default. For code: API shape, error handling, module boundaries. For a schema: field types, nullability, indexes.

Decisions split into three buckets, and they're handled differently:

- **Determined** — the answer is fixed by existing code, conventions, dependencies, or earlier decisions in this interview. Don't ask. State what you found and proceed.
- **Low-stakes** — multiple reasonable answers exist, but the difference doesn't matter much. Pick one, note it in the artifact, move on. Batch these into a single "I'm assuming X, Y, Z — flag if any is wrong" message rather than asking each one.
- **Genuine forks** — the answer materially changes downstream decisions or the user's outcome. Ask, one at a time, with a recommendation.

The discipline of the skill is correctly classifying decisions into these three buckets. Asking too much annoys; asking too little produces wrong artifacts.

## Core loop

1. **Explore first.** Before any questions, read what's available — codebase, existing configs, docs, vault notes, dependency manifests. For configs and code this phase is often substantial: read the whole module or the entire existing config before opening your mouth. Reading is cheap; the user's attention isn't.

2. **Identify the next genuine fork.** Walk the decision tree depth-first: when a decision opens sub-decisions, resolve those before backing out to siblings. Skip determined and low-stakes decisions silently (or batch-announce them).

3. **Ask one question with a recommended answer.** Format:
   - The decision in plain terms
   - Your recommendation, with 1–3 sentences of reasoning grounded in what you read
   - What downstream decisions depend on the answer
   
   Then stop. Wait. Do not stack questions.

4. **Record the decision** in a running list visible to the user.

5. **Surface dependency conflicts explicitly.** If a later answer invalidates an earlier one, name the conflict and ask which to revise. Never silently paper over inconsistencies.

6. **Stop when the artifact is writable.** The interview ends when remaining unknowns are details a competent agent would handle without further input. Do not pad with low-value questions to feel thorough.

## What "one at a time" means

- Exactly one open question per turn.
- Sub-bullets clarifying the *same* decision count as one question.
- Two decisions in one turn is two questions — split them.
- The "I'm assuming X, Y, Z" batch announcement is not a question; it's a notification. Continue to the next genuine fork in the same turn if there is one.

## What a recommended answer looks like

**Bad:** "What should the connection timeout be?"

**Good (for a config):** "I'd set `connect_timeout: 5s`. The existing HTTP client in `src/http/client.hs` uses 5s and your upstream Hysteria2 config has a 3s handshake budget, so anything tighter risks false negatives on slow networks. Higher (10s+) only if you expect frequent cold starts. Stick with 5s?"

The recommendation must be specific enough that a bare "yes" lets you proceed.

## "Relentlessly" — what it means and doesn't

- **Means:** don't accept vague answers. "Make it secure" → secure against what threat model, with what assumptions about the network?
- **Means:** don't drop forks the user hasn't thought about. Surface them.
- **Does not mean:** asking about every config field, every variable name, every error message. Those are determined or low-stakes — handle them yourself and note them.

## Artifact-specific notes

- **Plans:** decisions are coarse (architectural). Most are genuine forks. Output is a plan document.
- **Configs:** decisions are numerous and mostly determined-or-low-stakes. Heavy exploration phase, light questioning. Output is the config file plus a short "decisions made" summary.
- **Code:** style and conventions are determined by the existing codebase (read it). API shape and error handling are usually genuine forks. Naming is low-stakes. Output is the code plus inline comments at non-obvious decision points.
- **Schemas / API specs:** field-level decisions are often determined by the domain; cross-field invariants and evolution strategy are genuine forks.

## Output

When the interview ends, produce both:

1. **The artifact itself** in its native form (file, code, document).
2. **A decisions log** — short, scannable — listing each genuine fork resolved, each batched assumption, and any items deliberately deferred. The artifact must be standalone, but the log lets the user audit what got decided without them.
