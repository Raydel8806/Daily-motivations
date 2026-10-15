# Revisión lingüística del catálogo

Revisión realizada con asistencia de IA el 14 de octubre de 2026.

Se leyeron y compararon las 366 entradas completas en español, inglés y francés:
1.098 textos, incluido el 29 de febrero. También se revisaron los textos de la
interfaz, las fechas y los nombres mostrados junto a las frases.

## Resultado

| Idioma | Entradas revisadas | Entradas con ajustes de redacción | Entradas modificadas, incluida la puntuación |
|---|---:|---:|---:|
| Español | 366 | 133 | 366 |
| Inglés | 366 | 147 | 276 |
| Francés | 366 | 170 | 293 |

222 fechas recibieron algún ajuste de redacción en al menos un idioma. Se
limpiaron o corrigieron los nombres de autor en 45 entradas, incluidos espacios
sobrantes, puntuación ajena al nombre y errores ortográficos.

Las modificaciones puramente tipográficas —punto final, espacios, mayúsculas
y apóstrofos— se contabilizan aparte de los ajustes de redacción. No todas
las frases necesitaban ser reescritas.

## Criterios aplicados

- Conservar el sentido del catálogo español y sus metáforas, con redacción
  idiomática en inglés y francés.
- Corregir traducciones que confundían el sujeto, el tiempo verbal, una
  cantidad o el significado de una palabra.
- Corregir concordancias, tildes, construcciones incompletas y calcos en español.
- Usar «vous» de forma consistente cuando la frase francesa se dirige al lector,
  manteniendo la primera persona en las declaraciones del autor.
- Uniformar puntos finales y tipografía. En francés, separar los signos dobles
  de puntuación y los porcentajes; en español, separar los porcentajes.
- Eliminar la entidad HTML visible en la frase del 7 de agosto.
- Mostrar las fechas españolas en la forma «29 de febrero» sin cambiar los
  identificadores que relacionan las frases con sus días.
- Localizar los nombres con formas convencionales en otros idiomas, como
  «Confucio», «Confucius» y «Aristote», y las etiquetas de los proverbios.

## Ejemplos de correcciones

| Fecha | Problema detectado | Resolución |
|---|---|---|
| 4 de febrero | Las traducciones describían a las personas como vestidas de manera corriente, en vez de a las oportunidades. | Se corrigió el sujeto en los tres idiomas. |
| 26 de febrero | «Seduce» se interpretó como una orden al lector. | Se restituyó «el éxito» como sujeto de la segunda oración. |
| 3 de junio | El francés ordenaba a los demás que desafiaran al autor. | Se recuperó la idea de que el autor se desafía a sí mismo. |
| 22 de junio | El francés podía indicar que los dirigentes, en vez de los empleados, trataban a los clientes. | Se explicitó «les employés». |
| 31 de julio | «Cuánto» se confundía con «cuándo», produciendo traducciones incoherentes. | Se distinguieron cantidad ahorrada, rendimiento y duración entre generaciones. |
| 12 de octubre | «Fundar Google» se traducía como «encontrar Google», y abandonar el doctorado aparecía como un hecho ya ocurrido. | Se corrigieron el verbo y la idea de preocupación por abandonar los estudios. |
| 16 de octubre | Pertenecer al segundo tipo de empresa se convertía en ser una empresa «de segunda clase». | Se restituyó la referencia al segundo grupo. |

## Registro y comprobaciones

[El registro completo](linguistic_review.json) contiene las 366 fechas, los
idiomas revisados y los textos anteriores y posteriores de cada entrada
modificada. Los identificadores de fecha y el orden del catálogo se conservan.

Las comprobaciones de software verifican la cobertura de las 366 fechas,
catálogos sin textos vacíos, ausencia de entidades HTML y puntos duplicados,
etiquetas de proverbios, cambio de idioma, texto para compartir y localización
del calendario. Estas pruebas comprueban la integridad del contenido y su
funcionamiento; no certifican por sí mismas la calidad lingüística.

## Alcance y límites

Esta es una revisión completa del texto por IA, no una certificación de un
traductor humano ni una auditoría histórica de las 366 atribuciones. Las
frases son versiones editoriales del catálogo existente, no transcripciones
verificadas de las palabras originales de cada autor.

La frase del 9 de junio contenía una formulación ambigua sobre posibilidad y
probabilidad. Se hizo legible conservando esa distinción; no se comprobó su
redacción original. Algunas expresiones absolutas o discutibles del catálogo
se conservan como parte de las frases y no como afirmaciones verificadas.

Para nombres y una etiqueta de procedencia se consultaron fuentes puntuales:

- [ACM: Alan Kay y su conferencia sobre predecir e inventar el futuro](https://chi1998.acm.org/press/kay.html).
- [UNAM: uso del nombre Epicteto](https://filosoficas.unam.mx/sitio/xxxiii-coloquio-tesistas-filosofia-antigua). La corrección de la grafía no certifica la atribución de la frase del catálogo.
- [Japan Foundation: «nana korobi ya oki» es un proverbio japonés](https://www.la.jpf.go.jp/pub-breeze65-sd). Se sustituyó su presentación errónea como nombre de una persona por «Proverbio japonés».
- [Biografía oficial de Tim Ferriss](https://tim.blog/about/).
- [Museo Picasso Málaga](https://www.museopicassomalaga.org/).
