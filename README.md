# NT213 – FUGIO-based Web Security Lab & Project

## 📌 Giới thiệu chung

Repository này là **mã nguồn mở** phục vụ cho **môn học NT213 – An toàn và Bảo mật Web**, được xây dựng với mục đích **học tập, nghiên cứu và thực hành bảo mật** trong môi trường phòng thí nghiệm (lab environment).

Dự án **tham khảo và kế thừa ý tưởng từ FUGIO** – một framework mã nguồn mở hỗ trợ mô phỏng, triển khai và khai thác các lỗ hổng bảo mật web trong môi trường có kiểm soát.

> ⚠️ **Lưu ý quan trọng**:  
> Repository này **KHÔNG phải là repository chính thức của FUGIO**, cũng **không nhằm mục đích khai thác trái phép hệ thống thực tế**.

---

## 🔍 FUGIO là gì?

**FUGIO (Framework for Understanding, Generating, and Investigating Offensive techniques)** là một framework mã nguồn mở được thiết kế nhằm:

- Mô phỏng các **lỗ hổng bảo mật web phổ biến**
- Hỗ trợ **thực hành khai thác (exploitation)** trong môi trường an toàn
- Giúp người học hiểu rõ:
  - Cách lỗ hổng hình thành
  - Kỹ thuật tấn công
  - Phương pháp phòng thủ và phát hiện

FUGIO thường được sử dụng trong:
- Đào tạo an toàn thông tin
- Phòng thí nghiệm học thuật
- Nghiên cứu offensive security / defensive security

---

## 🎯 Mục tiêu của repository này

Repository này được xây dựng nhằm:

- 🔹 Triển khai **môi trường lab web dễ bị tấn công**
- 🔹 Thực hành các kỹ thuật:
  - SQL Injection
  - XSS
  - File Inclusion
  - Command Injection
  - Authentication / Authorization flaws
- 🔹 Phân tích hành vi tấn công và rủi ro bảo mật
- 🔹 Hiểu mối liên hệ giữa **tấn công – phát hiện – phòng thủ**

Toàn bộ nội dung đều phục vụ **mục đích học tập và nghiên cứu hợp pháp**.

---

## 🧪 Phạm vi sử dụng

✔️ Được phép:
- Học tập, nghiên cứu
- Thực hành trong môi trường lab cá nhân
- Tham khảo mã nguồn cho mục đích giáo dục

❌ Không được phép:
- Tấn công hệ thống thực tế khi chưa được cho phép
- Sử dụng cho mục đích phá hoại hoặc trái pháp luật

Người sử dụng **tự chịu trách nhiệm** cho mọi hành vi sử dụng mã nguồn.

---

## 🛠️ Công nghệ & thành phần chính

(Tùy bạn chỉnh lại cho đúng với repo thực tế)

- Backend: PHP / Python / Node.js
- Web Server: Apache / Nginx
- Database: MySQL / SQLite
- Môi trường triển khai: Docker / VM / Localhost
- Công cụ hỗ trợ:
  - Burp Suite
  - OWASP ZAP
  - Browser DevTools

---

## 📂 Cấu trúc repository 
.
├── vulnerable_app/ # Ứng dụng web dễ bị tấn công
├── exploit_notes/ # Ghi chú phân tích & khai thác
├── scripts/ # Script hỗ trợ test
├── docs/ # Tài liệu mô tả & báo cáo
└── README.md


---

## 📖 Giấy phép (License)

Repository này được phát hành dưới giấy phép **MIT License**.

Bạn được phép:
- Sử dụng
- Sao chép
- Chỉnh sửa
- Phân phối

Miễn là giữ nguyên thông tin bản quyền và giấy phép.

---

## ⚠️ Tuyên bố miễn trừ trách nhiệm

Mã nguồn trong repository này **chỉ dùng cho mục đích giáo dục**.  
Tác giả **không chịu trách nhiệm** cho bất kỳ hành vi lạm dụng nào.

---

