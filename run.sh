#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# run.sh — sobe o Pitada no PC com hot reload (preview, sem backend).
# Uso:  ./run.sh            (Chrome, o mais rápido)
#       ./run.sh linux      (janela nativa Linux)
#       ./run.sh analyze     (só checa erros de compilação, sem rodar)
#       ./run.sh fix         (auto-corrige os lints de estilo: dart fix + format)
# ─────────────────────────────────────────────────────────────────────────────
set -e
cd "$(dirname "$0")"

echo "==> flutter pub get"
flutter pub get

case "${1:-chrome}" in
  fix)
    echo "==> dart fix --apply (const, imports, vírgulas...)"
    dart fix --apply
    echo "==> dart format ."
    dart format .
    echo "==> flutter analyze (conferindo)"
    flutter analyze
    ;;
  analyze)
    echo "==> flutter analyze"
    flutter analyze
    ;;
  linux)
    echo "==> flutter run -d linux  (r=hot reload, R=restart, q=sair)"
    flutter run -d linux
    ;;
  *)
    echo "==> flutter run -d chrome  (r=hot reload, R=restart, q=sair)"
    flutter run -d chrome
    ;;
esac
