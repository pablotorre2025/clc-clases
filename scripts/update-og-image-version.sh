#!/usr/bin/env bash
set -euo pipefail

VERSION="${1:-$(date +%Y%m%d)}"
FILES=("preview.html" "flyer.html")

if [[ ! "$VERSION" =~ ^[0-9]{8}$ ]]; then
  echo "Error: la version debe tener formato YYYYMMDD (ejemplo: 20260706)."
  exit 1
fi

for file in "${FILES[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo "Aviso: no existe $file, se omite."
    continue
  fi

  sed -E -i '' "s|(assets/f1\.jpeg\?v=)[0-9]{8}|\\1${VERSION}|g" "$file"
  echo "Actualizado: $file -> v=${VERSION}"
done

echo "Listo. Siguiente paso: git add preview.html flyer.html && git commit -m 'Update weekly OG image version' && git push origin main"
