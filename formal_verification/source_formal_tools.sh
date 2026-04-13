#!/usr/bin/env bash
# Source this file to put OSS CAD Suite (yosys, sby, …) on PATH for the current shell.
# Does not activate vista_env. Usage:
#   source /path/to/fyp_draft/formal_verification/source_formal_tools.sh

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ENV="${ROOT}/oss-cad-suite/environment"
if [[ ! -f "${ENV}" ]]; then
  echo "OSS CAD Suite not found. Run: bash ${ROOT}/install_oss_cad_suite.sh" >&2
  return 1 2>/dev/null || exit 1
fi
# shellcheck disable=SC1090
source "${ENV}"
