# AiLang Examples

Curated examples for AiLangCore demos, tutorials, and conference walkthroughs.

This repository is intentionally separate from the core source repositories.
Regression fixtures, golden tests, and tiny contract examples stay in the repos
that own the behavior. This repo contains human-facing examples that should be
easy to browse, run, and critique.

This repository uses `main` as its public default branch. Examples should use
the public SDK flow unless they explicitly document local workspace
development.

Public roadmap:

- https://ailang.codes/docs/roadmap.html

## Examples

- `examples/hello-cli` - minimal command-line AiLang project.
- `examples/hello-aivectra` - minimal AiVectra package-based UI project.
- `examples/package-demo` - package restore workflow demo.
- `examples/aivectra/hello-world` - minimal AiVectra app structure and rendering.
- `examples/aivectra/hello-name` - AiVectra text input, keyboard, click, and replay behavior.
- `examples/aivectra/interactive-svg-mvp` - deterministic SVG/debug artifact behavior.
- `examples/aivectra/worker-demo` - experimental worker-driven UI update flow.
- `examples/aivectra/weather-app` - experimental network-backed AiVectra app.

## Requirements

Install the AiLangCore SDK:

```bash
curl -fsSL https://ailang.codes/install.sh | sh
export PATH="$HOME/.ailang/bin:$PATH"
```

Verify the installed tools:

```bash
ailang --version
aivm --version
aivectra help
```

## Validate Examples

```bash
./scripts/validate-examples.sh
```

The validation script builds every example, runs command-line examples, and
runs deterministic non-windowed modes for AiVectra UI examples. Windowed UI
launch remains a manual demo step.

When validating from a local multi-repo checkout before the SDK installer has
seeded the package registry, point the package manager at the sibling registry:

```bash
AILANG_PACKAGE_REGISTRY=/path/to/ailang-packages ./scripts/validate-examples.sh
```

## Demo Flow

For a conference or meetup demo:

```bash
cd examples/hello-cli
ailang build .
ailang run .

cd ../hello-aivectra
ailang package restore
ailang build .
ailang run .

cd ../aivectra/hello-name
ailang package restore
ailang build .
ailang run .

cd ../weather-app
ailang package restore
ailang build .
ailang run .

cd ../package-demo
ailang package restore
ailang package list
ailang build .
ailang run .
```

## Repository Policy

Keep this repo focused on public demos:

- no golden regression fixtures
- no generated build artifacts
- no local SDK files
- no copied core source trees
- examples must use the public SDK flow unless explicitly documenting local
  development

Core behavior belongs in:

- [AiLang](https://github.com/AiLangCore/AiLang)
- [AiVM](https://github.com/AiLangCore/AiVM)
- [AiVectra](https://github.com/AiLangCore/AiVectra)

Package records belong in:

- [ailang-packages](https://github.com/AiLangCore/ailang-packages)
