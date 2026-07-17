#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# run.sh — sobe o Pitada no PC com hot reload.
# Conecta no Supabase local automaticamente quando ele está no ar (pitada-db);
# sem ele, roda em preview com dados de exemplo.
# Uso:  ./run.sh            (Chrome, o mais rápido)
#       ./run.sh linux      (janela nativa Linux)
#       ./run.sh analyze     (só checa erros de compilação, sem rodar)
#       ./run.sh fix         (auto-corrige os lints de estilo: dart fix + format)
# ─────────────────────────────────────────────────────────────────────────────
set -e
cd "$(dirname "$0")"

# Lê as chaves do Supabase local do próprio CLI; vazio quando o stack está parado.
supabase_defines() {
  local status url key
  status=$(supabase status -o env 2>/dev/null) || return 0
  url=$(printf '%s\n' "$status" | sed -n 's/^API_URL="\(.*\)"$/\1/p')
  key=$(printf '%s\n' "$status" | sed -n 's/^ANON_KEY="\(.*\)"$/\1/p')
  [ -n "$url" ] && [ -n "$key" ] || return 0
  printf -- '--dart-define=SUPABASE_URL=%s --dart-define=SUPABASE_ANON_KEY=%s' "$url" "$key"
}

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
