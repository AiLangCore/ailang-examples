# AiLang Examples Agents

This repository contains public AiLangCore examples for demos and tutorials.

## Scope

Examples here should be understandable to humans and AI agents reviewing the
project for the first time.

Do not move regression fixtures, golden files, or contract tests here. Those
belong in the owning source repository.

## Rules

- Keep examples small, polished, and runnable from an installed SDK.
- Do not commit generated artifacts such as `.aibc1`, `dist`, `.tmp`, `.local`,
  or `.ailang`.
- Prefer package-based examples over sibling-checkout imports.
- Keep README instructions current with the public install flow.
- If an example demonstrates an alpha limitation, state that limitation clearly.

## Verification

```bash
./scripts/validate-examples.sh
```

## Current Examples

- `examples/hello-cli`
- `examples/hello-aivectra`
- `examples/package-demo`
- `examples/aivectra/hello-world`
- `examples/aivectra/hello-name`
- `examples/aivectra/interactive-svg-mvp`
- `examples/aivectra/worker-demo`
- `examples/aivectra/weather-app`
