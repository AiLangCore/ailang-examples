# AiLang Examples Agents

This repository contains public AiLangCore examples for demos and tutorials.

## Scope

Examples here should be understandable to humans and AI agents reviewing the
project for the first time.

Do not move regression fixtures, golden files, or contract tests here. Those
belong in the owning source repository.

## Rules

- Treat every public example as a gold-standard reference for AiLang style,
  architecture, and maintainability. Examples should model the code quality we
  want contributors and AI agents to copy.
- Keep examples small, polished, and runnable from an installed SDK.
- Anything that is part of an example application belongs under that example's
  `src` directory, including views, app-owned assets, target/platform metadata,
  code-behind files, app-local modules, and app-owned templates.
- Split production-style examples into focused modules. Keep entry files thin,
  and separate UI rendering, state transitions, parsing, network/host
  boundaries, and reusable library behavior.
- Agents must prefer creating focused semantic `.aos` modules over expanding
  large entry, facade, SDK, runtime, or sample files. Do not create or continue
  "blob" files.
- Host/runtime changes must remain mechanical and must not introduce language,
  library, UI, package, parsing, validation, formatting, or application
  semantics. If an example exposes a missing SDK capability, improve the owning
  SDK/package instead of hacking the example.
- Do not commit generated artifacts such as `.aibc1`, `dist`, `.tmp`, `.local`,
  or `.ailang`.
- Prefer package-based examples over sibling-checkout imports.
- Do not add app-local debug, profiler, test-fixture, or compatibility
  frameworks to examples. Shared tooling belongs in AiLang, AiVM, AiVectra, or
  an appropriate package.
- Production-style examples should use real runtime behavior and real external
  data when that is the feature being demonstrated. Deterministic fixtures
  belong in tests or validation tooling, not in the application source.
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
