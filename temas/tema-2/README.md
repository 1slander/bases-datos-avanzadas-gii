# Tema 2: Lenguaje XML

## Breve introducción al Lenguaje XML

XML (eXtensible Markup Language) es un lenguaje de marcas diseñado para almacenar y transportar datos de forma legible tanto para humanos como para máquinas. XML define una sintaxis simple basada en elementos y atributos que permite describir estructuras de datos jerárquicas y extensibles.

Características principales:

* Texto plano y legible.
* Extensible: el usuario define etiquetas propias.
* Separación entre contenido y presentación.
* Validación mediante DTD o XML Schema (XSD).
* Soporta espacios de nombres (namespaces) para evitar colisiones de etiquetas.

Usos comunes:

* Intercambio de datos entre aplicaciones y servicios.
* Configuración de aplicaciones.
* Formatos de documentos (ej. Office Open XML).
* Base para tecnologías relacionadas: XPath, XQuery, XSLT.

Ejemplo mínimo:

```xml
<persona id="1">
  <nombre>Ana</nombre>
  <edad>30</edad>
</persona>
```

Conceptos importantes a recordar: documento bien formado (well-formed), documento válido (valid) y esquemas para validar estructura y tipos de datos.

## Enlaces presentados en clase

* [World Wide Web Consortium (W3C)](https://www.w3.org/)
* [A brief SGML tutorial](https://www.w3.org/TR/WD-html40-970708/intro/sgmltut.html)
* [Extensible Markup Language (XML) en W3C](https://www.w3.org/XML/)
* [XML: Extensible Markup Language en Mozilla Developer Network (MDN)](https://developer.mozilla.org/en-US/docs/Web/XML)
* [Tutorial de XML en W3Schools](https://www.w3schools.com/XML/default.asp)

## Código de ejemplo

Lista de ficheros en el directorio `code` y descripción breve de su contenido:

* [code/correo.xml](code/correo.xml) — Documento XML de ejemplo que representa mensajes de correo con elementos como remitente, destinatario, asunto, cuerpo y fecha.
* [code/correo_xsd.xml](code/correo_xsd.xml) — Ejemplo de instancia XML que referencia el esquema XSD (muestra uso de xsi:schemaLocation para validación).
* [code/correo.xsd](code/correo.xsd) — Esquema XML Schema (XSD) que define la estructura y tipos para los documentos de correo.
* [code/correo.dtd](code/correo.dtd) — DTD de ejemplo que describe una versión alternativa de la estructura del documento de correo.
* [code/ticket.xml](code/ticket.xml) — Documento XML de ejemplo que representa un ticket de compra.
* [code/ticket.xsd](code/ticket.xsd) — Esquema XML Schema (XSD) para validar la estructura y tipos del ticket.xml.
