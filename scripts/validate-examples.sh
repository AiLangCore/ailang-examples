#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

require_tool() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "missing required tool: $1" >&2
    echo "install the AiLangCore SDK, then add ~/.ailang/bin to PATH" >&2
    exit 1
  fi
}

run_example() {
  local path="$1"
  echo "== ${path} =="
  (
    cd "${path}"
    if grep -Eq 'Include#|Include\(' project.aiproj; then
      ailang package restore
    fi
    ailang build .
    ailang run .
  )
}

require_tool ailang
require_tool aivm
require_tool aivectra

ailang --version
aivm --version
aivectra --version

run_example examples/hello-cli
run_example examples/package-demo

if [[ "${AILANG_EXAMPLES_RUN_UI:-0}" == "1" ]]; then
  run_example examples/hello-aivectra
else
  echo "skipping examples/hello-aivectra; set AILANG_EXAMPLES_RUN_UI=1 to run UI demo"
fi
