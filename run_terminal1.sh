#!/bin/bash
# Helper script to replicate the original "Terminal 1" workflow
# Usage:
#   ./run_terminal1.sh [target_app] [doc_root]
#     target_app – directory name under FUGIO/ (default: vulnerable_app)
#     doc_root   – Apache doc root (default: /var/www/html)

set -euo pipefail

TARGET_APP=${1:-vulnerable_app}
DOC_ROOT=${2:-/var/www/html}

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FUGIO_DIR="${REPO_ROOT}/FUGIO"
LOG_DIR="${REPO_ROOT}/logs"
FUGIO_LOG="${LOG_DIR}/fugio.log"

mkdir -p "${LOG_DIR}"

if [ ! -d "${FUGIO_DIR}" ]; then
  echo "[!] Không tìm thấy thư mục FUGIO tại ${FUGIO_DIR}" | tee -a "${FUGIO_LOG}"
  exit 1
fi

echo "[*] Chuyển vào thư mục FUGIO" | tee "${FUGIO_LOG}"
cd "${FUGIO_DIR}"

echo "[*] Restart Apache" | tee -a "${FUGIO_LOG}"
sudo systemctl restart apache2 2>&1 | tee -a "${FUGIO_LOG}"

echo "[*] Cấp quyền thực thi cho run_FUGIO_72.sh và run.py" | tee -a "${FUGIO_LOG}"
sudo chmod +x run_FUGIO_72.sh run.py 2>&1 | tee -a "${FUGIO_LOG}"

echo "[*] Chạy run_FUGIO_72.sh với target: ${TARGET_APP}, doc_root: ${DOC_ROOT}" | tee -a "${FUGIO_LOG}"
sudo ./run_FUGIO_72.sh "${TARGET_APP}" --doc_root="${DOC_ROOT}" 2>&1 | tee -a "${FUGIO_LOG}"


