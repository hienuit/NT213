#!/usr/bin/env python3
# Simple Web GUI for FUGIO using Flask
#
# This replaces the old Tkinter GUI and controls FUGIO via:
#   - run_terminal1.sh  (start FUGIO)
#   - run_terminal2.sh  (trigger PoC)

import os
import subprocess
from flask import Flask, request, render_template, redirect, url_for

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
LOG_DIR = os.path.join(BASE_DIR, "logs")

# Sử dụng thư mục "template" làm nơi chứa Jinja templates
app = Flask(__name__, template_folder="template", static_folder="static")


def script_path(name: str) -> str:
  return os.path.join(BASE_DIR, name)


def read_log_tail(name: str, limit: int = 500) -> str:
  """
  Đọc log từ logs/<name>.log và trả về tối đa `limit` dòng cuối.
  Nếu file không tồn tại, trả về chuỗi rỗng.
  """
  log_file = os.path.join(LOG_DIR, f"{name}.log")
  if not os.path.exists(log_file):
    return ""
  try:
    with open(log_file, "r", encoding="utf-8", errors="replace") as f:
      lines = f.read().splitlines()
    if len(lines) > limit:
      lines = lines[-limit:]
    return "\n".join(lines)
  except Exception as e:
    return f"[Loi khi doc log {name}: {e}]"


@app.route("/panel", methods=["GET", "POST"])
def panel():
  target_default = "vulnerable_app"
  doc_root_default = "/var/www/html"

  target = request.form.get("target", target_default)
  doc_root = request.form.get("doc_root", doc_root_default)
  base_url = request.form.get("base_url", f"http://127.0.0.1/{target}/")

  message = ""

  if request.method == "POST":
    action = request.form.get("action")

    if action == "start_fugio":
      cmd = ["bash", script_path("run_terminal1.sh"), target, doc_root]
      try:
        subprocess.Popen(cmd, cwd=BASE_DIR)
        message = f"Da chay FUGIO cho '{target}' (doc_root={doc_root})."
      except Exception as e:
        message = f"Loi khi chay run_terminal1.sh: {e}"

    elif action == "trigger_poc":
      cmd = ["bash", script_path("run_terminal2.sh"), target, base_url]
      try:
        subprocess.Popen(cmd, cwd=BASE_DIR)
        message = f"Da trigger POC cho '{target}' voi URL {base_url}."
      except Exception as e:
        message = f"Loi khi chay run_terminal2.sh: {e}"

    elif action == "stop_all":
      # Very simple stop: kill processes containing run_FUGIO_72.sh or trigger_poc.py
      try:
        subprocess.call(["pkill", "-f", "run_FUGIO_72.sh"])
        subprocess.call(["pkill", "-f", "trigger_poc.py"])
        message = "Da co gang dung cac tien trinh FUGIO va PoC (pkill)."
      except Exception as e:
        message = f"Loi khi dung tien trinh: {e}"

  return render_template(
    "panel.html",
    target=target,
    doc_root=doc_root,
    base_url=base_url,
    message=message,
  )


@app.route("/")
def index():
  """
  Trang landing / e-learning giới thiệu FUGIO và nhóm DHH.
  """
  return render_template("index.html")


@app.route("/intro")
def intro():
  """
  Trang giới thiệu kiến trúc và luồng hoạt động.
  """
  return render_template("intro.html")


@app.route("/docs")
def docs():
  """
  Trang tài liệu cài đặt và hướng dẫn nhanh.
  """
  return render_template("docs.html")


@app.route("/chains")
def chains():
  """
  Trang e-learning mô tả một số exploit chain tiêu biểu (Drupal, WordPress, Monolog,...).
  Chỉ mang tính chất học thuật / minh hoạ.
  """
  return render_template("chains.html")


@app.route("/logs/<name>")
def get_log(name: str):
  if name not in ("fugio", "poc"):
    return "", 404
  return read_log_tail(name), 200, {"Content-Type": "text/plain; charset=utf-8"}


if __name__ == "__main__":
  os.makedirs(LOG_DIR, exist_ok=True)
  app.run(host="0.0.0.0", port=5000, debug=True)


