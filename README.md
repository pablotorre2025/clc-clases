# clc-clases

## Actualizacion semanal de preview (iPhone/iMessage)

1. Reemplaza la imagen en assets/f1.jpeg con el nuevo flyer semanal.
2. Ejecuta el script para actualizar el parametro de cache de Open Graph:

	./scripts/update-og-image-version.sh

	Opcionalmente, puedes pasar una version manual:

	./scripts/update-og-image-version.sh 20260706

3. Publica cambios:

	git add assets/f1.jpeg preview.html flyer.html
	git commit -m "Update weekly flyer image"
	git push origin main

4. Comparte este enlace por mensaje de texto:

	https://pablotorre2025.github.io/clc-clases/preview.html
