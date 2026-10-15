# Daily Motivations

Aplicación Flutter con una frase motivacional para cada día del año.

## Idiomas

La interfaz, el calendario, las fechas y las 366 frases están disponibles en
español, inglés y francés. Al iniciar se utiliza el idioma del dispositivo;
para idiomas no compatibles se utiliza español. El icono de idioma en la
barra superior permite cambiar el idioma durante la sesión conservando la
frase seleccionada. La selección manual se restablece al reiniciar la app.

Las traducciones de las frases se incluyen en `assets/quotes_en.json` y
`assets/quotes_fr.json`; leer y compartir frases no requiere conexión.
Estas traducciones se generaron inicialmente de forma automática y después se
revisaron las 366 entradas completas en español, inglés y francés con asistencia
de IA: significado, concordancia, naturalidad, tratamiento y puntuación. Se
corrigieron también errores ortográficos en nombres y se añadieron sus formas
convencionales en cada idioma cuando corresponde.

El registro completo de cambios está en `docs/linguistic_review.json`, y el
informe de criterios y alcance, en `docs/revision_linguistica.md`. Esta revisión
no es una certificación de un traductor humano ni una verificación histórica
de todas las citas y sus atribuciones.

`lib/app_strings.dart` contiene los textos de la interfaz. Los catálogos usan
la fecha española original como identificador estable para no cambiar la
relación entre cada frase y su día, incluido el 29 de febrero.

## Desarrollo

```sh
flutter pub get
flutter analyze
flutter test
flutter run
```

Las pruebas verifican la cobertura de las 366 fechas en ambos catálogos,
el texto para compartir, el cambio de idioma y la localización del calendario.

`dart run tool/translate_quotes.dart` es un importador de desarrollo que requiere
conexión y consulta un servicio externo de traducción. Conserva las entradas
existentes, incluidas las correcciones manuales; la aplicación no utiliza este
servicio durante su ejecución.

`dart run tool/translate_quotes.dart --check` comprueba la correspondencia de
las 366 fechas en ambos catálogos sin conexión ni modificaciones.
