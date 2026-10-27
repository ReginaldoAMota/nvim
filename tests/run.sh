#!/usr/bin/env bash
# Roda todos os specs em tests/ com a config real carregada e falha se algum quebrar.
# Uso: tests/run.sh [spec...]
set -u
cd "$(dirname "$0")/.."
specs=("$@")
[ ${#specs[@]} -eq 0 ] && specs=(tests/*_spec.lua)
status=0
for spec in "${specs[@]}"; do
  echo "== $spec"
  if ! nvim --headless -c "luafile $spec" 2>&1; then
    status=1
  fi
done
exit $status
