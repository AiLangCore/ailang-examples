#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

if [[ "${1:-}" == "--selfhost" ]]; then
  AILANG_SELFHOST=1
  shift
fi
if [[ $# -ne 0 ]]; then
  echo "usage: ./scripts/validate-examples.sh [--selfhost]" >&2
  exit 1
fi

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
AILANG_SELFHOST_AIBC1="${AILANG_SELFHOST_AIBC1:-${ROOT_DIR}/../AiLang/.artifacts/ailang-selfhost/bin/ailang.aibc1}"
AILANG_SELFHOST_RUNTIME="${AILANG_SELFHOST_RUNTIME:-${ROOT_DIR}/../AiLang/tools/aivm-runtime}"
AILANG_SELFHOST_SDK_ROOT="${AILANG_SELFHOST_SDK_ROOT:-${ROOT_DIR}/../AiLang/.artifacts/ailang-selfhost}"
if [[ "${AILANG_SELFHOST:-0}" != "1" && -z "${AILANG_BIN}" && -x "${ROOT_DIR}/../AiLang/tools/ailang" ]]; then
  AILANG_BIN="${ROOT_DIR}/../AiLang/tools/ailang"
fi
AILANG_BIN="${AILANG_BIN:-ailang}"

run_ailang() {
  if [[ "${AILANG_SELFHOST:-0}" == "1" ]]; then
    AILANG_SDK_ROOT="${AILANG_SELFHOST_SDK_ROOT}" \
      "${AILANG_SELFHOST_RUNTIME}" run "${AILANG_SELFHOST_AIBC1}" -- "$@"
  else
    "${AILANG_BIN}" "$@"
  fi
}

run_example() {
  local path="$1"
  echo "== ${path} =="
  (
    cd "${path}"
    if grep -Eq 'Include#|Include\(' project.aiproj; then
      run_ailang package restore
    fi
    run_ailang build .
    run_ailang run .
  )
}

build_example() {
  local path="$1"
  echo "== ${path} =="
  (
    cd "${path}"
    if grep -Eq 'Include#|Include\(' project.aiproj; then
      run_ailang package restore
    fi
    run_ailang build .
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
      run_ailang package restore
    fi
    run_ailang build .
    out="$(run_ailang run . "${mode}")"
    printf "%s\n" "$out"
    if [[ -n "$expected" ]] && ! printf "%s\n" "$out" | grep -Fq "$expected"; then
      echo "expected output fragment not found: $expected" >&2
      exit 1
    fi
  )
}

if [[ "${AILANG_SELFHOST:-0}" == "1" ]]; then
  test -x "${AILANG_SELFHOST_RUNTIME}"
  test -s "${AILANG_SELFHOST_AIBC1}"
elif [[ "${AILANG_BIN}" == "ailang" ]]; then
  require_tool ailang
fi
require_tool aivm
require_tool aivectra

run_ailang version
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
