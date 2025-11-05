-- 1) Insertar un documento XML
INSERT INTO facturas_xml (cliente, datos)
VALUES ('Marty McFly', xmlparse(document
'<factura id="F001">
   <fecha>2025-11-01</fecha>
   <total>3232.50</total>
   <lineas>
     <linea><desc>Condensador de Flujo</desc><cant>1</cant><precio>3232.50</precio></linea>
   </lineas>
 </factura>'));

-- 2) Consultar con xpath() (devuelve xml[])
SELECT id,
       xpath('/factura/total/text()', datos) AS total_nodes
FROM facturas_xml;

-- 3) Convertir el resultado a texto (tomar primer nodo)
SELECT id,
       (xpath('/factura/total/text()', datos))[1]::text AS total_text
FROM facturas_xml;

-- 4) Filtro con xmlexists
SELECT id, cliente
FROM facturas_xml
WHERE xmlexists('/factura[lineas/linea/cant>1]' PASSING BY REF datos);