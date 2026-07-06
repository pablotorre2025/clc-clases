#!/usr/bin/env bash
set -euo pipefail

VERSION="${1:-$(date +%Y%m%d)}"
SOURCE_IMAGE="assets/f1.jpeg"
TARGET_IMAGE="assets/f1-${VERSION}.jpeg"
FILES=("preview.html" "flyer.html" "index.html" "index-en.html")

if [[ ! "$VERSION" =~ ^[0-9]{8}$ ]]; then
  echo "Error: la version debe tener formato YYYYMMDD (ejemplo: 20260706)."
  exit 1
fi

if [[ ! -f "$SOURCE_IMAGE" ]]; then
  echo "Error: no existe $SOURCE_IMAGE"
  exit 1
fi

cp "$SOURCE_IMAGE" "$TARGET_IMAGE"
echo "Imagen versionada creada: $TARGET_IMAGE"

for file in "${FILES[@]}"; do
  if [[ ! -f "$file" ]]; then
    echo "Aviso: no existe $file, se omite."
    continue
  fi

  # Reemplaza cualquier referencia previa a f1.jpeg, f1-YYYYMMDD.jpeg y variantes con ?v=YYYYMMDD.
  sed -E -i '' "s|(assets/f1(-[0-9]{8})?\.jpeg)(\?v=[0-9]{8})?|assets/f1-${VERSION}.jpeg|g" "$file"
  sed -E -i '' "s|(https://pablotorre2025\.github\.io/clc-clases/assets/f1(-[0-9]{8})?\.jpeg)(\?v=[0-9]{8})?|https://pablotorre2025.github.io/clc-clases/assets/f1-${VERSION}.jpeg|g" "$file"
  echo "Actualizado: $file -> f1-${VERSION}.jpeg"
done

echo "Listo. El link compartido puede seguir igual (flyer.html/preview.html)."
echo "Siguiente paso: git add assets/f1-${VERSION}.jpeg ${FILES[*]} && git commit -m 'Update flyer image to f1-${VERSION}.jpeg' && git push origin main"
