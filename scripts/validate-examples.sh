#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

if [[ -z "${AILANG_PACKAGE_REGISTRY:-}" && -d "${ROOT_DIR}/../ailang-packages/packages" ]]; then
  export AILANG_PACKAGE_REGISTRY="${ROOT_DIR}/../ailang-packages"
fi

require_tool() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "missing required tool: $1" >&2
    echo "install the AiLangCore SDK, then add ~/.ailang/bin to PATH" >&2
    exit 1
  fi
}

AILANG_BIN="${AILANG_BIN:-}"
if [[ -z "${AILANG_BIN}" && -x "${ROOT_DIR}/../AiLang/tools/ailang" ]]; then
  AILANG_BIN="${ROOT_DIR}/../AiLang/tools/ailang"
fi
AILANG_BIN="${AILANG_BIN:-ailang}"

run_example() {
  local path="$1"
  echo "== ${path} =="
  (
    cd "${path}"
    if grep -Eq 'Include#|Include\(' project.aiproj; then
      "${AILANG_BIN}" package restore
    fi
    "${AILANG_BIN}" build .
    "${AILANG_BIN}" run .
  )
}

build_example() {
  local path="$1"
  echo "== ${path} =="
  (
    cd "${path}"
    if grep -Eq 'Include#|Include\(' project.aiproj; then
      "${AILANG_BIN}" package restore
    fi
    "${AILANG_BIN}" build .
  )
}

build_and_run_mode() {
  local path="$1"
  local mode="$2"
  local expected="$3"
  echo "== ${path} ${mode} =="
  (
    cd "${path}"
    if grep -Eq 'Include#|Include\(' project.aiproj; then
      "${AILANG_BIN}" package restore
    fi
    "${AILANG_BIN}" build .
    out="$("${AILANG_BIN}" run . "${mode}")"
    printf "%s\n" "$out"
    if [[ -n "$expected" ]] && ! printf "%s\n" "$out" | grep -Fq "$expected"; then
      echo "expected output fragment not found: $expected" >&2
      exit 1
    fi
  )
}

if [[ "${AILANG_BIN}" == "ailang" ]]; then
  require_tool ailang
fi
require_tool aivm
require_tool aivectra

"${AILANG_BIN}" --version
aivm --version
aivectra --version

run_example examples/hello-cli
run_example examples/package-demo
build_example examples/hello-aivectra
echo "built examples/hello-aivectra; run it manually with: cd examples/hello-aivectra && ailang run ."

build_and_run_mode examples/aivectra/hello-world snapshot "Ok#ok1(type=int value=0)"
build_and_run_mode examples/aivectra/hello-name snapshot "[aivectra] snapshot size=976x614"
build_and_run_mode examples/aivectra/hello-name replay "[aivectra] replay greeting=Greeting: Hello, todd!"
build_and_run_mode examples/aivectra/interactive-svg-mvp snapshot "[aivectra] layout shapes="
build_and_run_mode examples/aivectra/interactive-svg-mvp replay "[aivectra] replay greeting=Greeting: Hello, Joe!"
build_and_run_mode examples/aivectra/worker-demo snapshot "Ok#ok1(type=int value=0)"
build_and_run_mode examples/aivectra/weather-app snapshot "Ok#ok1(type=int value=0)"
echo "validated AiVectra UI examples with deterministic non-windowed modes; run them manually from examples/aivectra/<name> with: ailang run ."
