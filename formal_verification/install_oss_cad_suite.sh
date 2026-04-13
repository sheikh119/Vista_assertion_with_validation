#!/usr/bin/env bash
# Install OSS CAD Suite (Yosys, SymbiYosys/sby, solvers) into ./oss-cad-suite/
# Does NOT touch Python or vista_env — see:
# https://yosyshq.readthedocs.io/projects/sby/en/latest/install.html

set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="${ROOT}/oss-cad-suite"
TAG="2026-04-13"
ARCHIVE="oss-cad-suite-linux-x64-20260413.tgz"
URL="https://github.com/YosysHQ/oss-cad-suite-build/releases/download/${TAG}/${ARCHIVE}"

if [[ -x "${DEST}/environment" ]]; then
  echo "Already present: ${DEST}"
  echo "To refresh, remove the folder and run this script again."
  exit 0
fi

echo "Downloading OSS CAD Suite (~711 MB)..."
echo "URL: ${URL}"
mkdir -p "${ROOT}/downloads"
curl -fL --retry 3 -o "${ROOT}/downloads/${ARCHIVE}" "${URL}"

echo "Extracting ..."
TMP="$(mktemp -d)"
trap 'rm -rf "${TMP}"' EXIT
tar -xzf "${ROOT}/downloads/${ARCHIVE}" -C "${TMP}"
# Archive usually has a single top-level directory containing ./environment
ENVFILE="$(find "${TMP}" -type f -name environment 2>/dev/null | head -n 1)"
INNER="$(dirname "${ENVFILE}")"
if [[ -z "${ENVFILE}" || ! -d "${INNER}" ]]; then
  echo "Could not locate extracted suite (expected .../environment)." >&2
  find "${TMP}" -maxdepth 3 -type f | head -20
  exit 1
fi
rm -rf "${DEST}"
mv "${INNER}" "${DEST}"

if [[ -f "${DEST}/environment" ]]; then
  echo "Done. Activate with:"
  echo "  source \"${DEST}/environment\""
  echo "or:"
  echo "  source \"${ROOT}/source_formal_tools.sh\""
else
  echo "environment not found under ${DEST}" >&2
  ls -la "${DEST}"
  exit 1
fi
