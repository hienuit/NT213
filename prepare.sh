#!/bin/bash
# Script chuẩn bị môi trường cho FUGIO
# Tự động cấp quyền cho tất cả scripts cần thiết

echo "=========================================="
echo "  FUGIO - Chuẩn bị môi trường"
echo "=========================================="
echo ""

# Lấy đường dẫn thư mục hiện tại
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

echo "[1] Cấp quyền cho install_fugio.sh và các script điều khiển..."
chmod +x install_fugio.sh
if [ $? -eq 0 ]; then
    echo "    ✅ install_fugio.sh"
else
    echo "    ❌ Lỗi khi cấp quyền install_fugio.sh"
fi


chmod +x run_terminal1.sh
chmod +x run_terminal2.sh
chmod +x web_gui.py

echo "    ✅ run_terminal1.sh"
echo "    ✅ run_terminal2.sh"
echo "    ✅ web_gui.py"

echo ""
echo "[2] Cấp quyền cho các scripts trong FUGIO..."
cd FUGIO

# Cấp quyền cho tất cả .sh files
for file in *.sh; do
    if [ -f "$file" ]; then
        chmod +x "$file"
        echo "    ✅ $file"
    fi
done

# Cấp quyền cho các .py files quan trọng
chmod +x htaccess.py
chmod +x run.py
chmod +x fugio_gui.py

echo "    ✅ htaccess.py"
echo "    ✅ run.py"
echo "    ✅ fugio_gui.py"

cd ..

echo ""
echo "[3] Kiểm tra các file quan trọng..."

# Kiểm tra install_fugio.sh
if [ -f "install_fugio.sh" ]; then
    echo "    ✅ install_fugio.sh tồn tại"
else
    echo "    ❌ install_fugio.sh KHÔNG TỒN TẠI!"
fi

# Kiểm tra FUGIO directory
if [ -d "FUGIO" ]; then
    echo "    ✅ Thư mục FUGIO tồn tại"
    
    # Kiểm tra các file quan trọng trong FUGIO
    cd FUGIO
    
    files_to_check=("run_FUGIO_72.sh" "run_rabbitmq.sh" "install_72.sh" "fugio_gui.py" "run.py" "htaccess.py")
    for file in "${files_to_check[@]}"; do
        if [ -f "$file" ]; then
            echo "    ✅ FUGIO/$file"
        else
            echo "    ⚠️  FUGIO/$file KHÔNG TỒN TẠI"
        fi
    done
    
    cd ..
else
    echo "    ❌ Thư mục FUGIO KHÔNG TỒN TẠI!"
fi

echo ""
echo "=========================================="
echo "  Hoàn tất!"
echo "=========================================="
echo ""
echo "Bước tiếp theo:"
echo "  1. Chạy: sudo bash install_fugio.sh"
echo "  2. Sau khi cài đặt xong, chạy Web GUI e-learning:"
echo "     python3 web_gui.py"
echo "  3. Mở trình duyệt tới: http://127.0.0.1:5000/"
echo "     - Tab Control Panel dùng các nút Start FUGIO / Trigger PoC (sử dụng run_terminal1.sh & run_terminal2.sh)."
echo ""

