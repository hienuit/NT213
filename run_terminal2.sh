#!/bin/bash
# Helper script to replicate the original "Terminal 2" workflow
# Usage:
#   ./run_terminal2.sh [target_app] [base_url]
#     target_app – directory name under FUGIO/ (default: vulnerable_app)
#     base_url   – URL to send the PoC to (default: http://127.0.0.1/vulnerable_app/)

set -euo pipefail

TARGET_APP=${1:-vulnerable_app}
BASE_URL=${2:-"http://127.0.0.1/${TARGET_APP}/"}

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FUGIO_DIR="${REPO_ROOT}/FUGIO"
LOG_DIR="${REPO_ROOT}/logs"
POC_LOG="${LOG_DIR}/poc.log"

mkdir -p "${LOG_DIR}"

if [ ! -d "${FUGIO_DIR}" ]; then
  echo "[!] Không tìm thấy thư mục FUGIO tại ${FUGIO_DIR}" | tee -a "${POC_LOG}"
  exit 1
fi

PocScript="${FUGIO_DIR}/${TARGET_APP}/trigger_poc.py"
if [ ! -f "${PocScript}" ]; then
  echo "[!] Không tìm thấy trigger_poc.py tại ${PocScript}" | tee -a "${POC_LOG}"
  exit 1
fi

echo "[*] Chuyển vào thư mục FUGIO" | tee "${POC_LOG}"
cd "${FUGIO_DIR}"

echo "[*] Cấp quyền thực thi trigger_poc.py" | tee -a "${POC_LOG}"
chmod +x "${TARGET_APP}/trigger_poc.py" 2>&1 | tee -a "${POC_LOG}"

echo "[*] Chạy PoC tới ${BASE_URL}" | tee -a "${POC_LOG}"
python3 "${TARGET_APP}/trigger_poc.py" "${BASE_URL}" 2>&1 | tee -a "${POC_LOG}"


