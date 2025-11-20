# Tema 4 — Bases de Datos Paralelas

## 🧠 Resumen general

El tema introduce los fundamentos de las **bases de datos paralelas**, sistemas capaces de utilizar múltiples procesadores, memorias o discos para acelerar la ejecución de consultas y aumentar la productividad en entornos con grandes volúmenes de datos.

## 1. Sistemas paralelos

Los sistemas paralelos permiten ejecutar tareas simultáneamente usando múltiples CPUs o nodos.

### Tipos de máquinas

- **Grano grueso**: pocos procesadores muy potentes.  
- **Grano fino**: muchos procesadores más simples.

### Métricas clave

- **Productividad**: tareas procesadas por unidad de tiempo.  
- **Tiempo de respuesta**: duración de una única tarea.

## 2. Ganancia de velocidad y ampliabilidad

### ✔️ Ganancia de velocidad (speedup)

Se refiere al incremento en el rendimiento en comparación con la ejecución secuencial.

- **Lineal**: ideal pero infrecuente.
- **Sublineal**: lo habitual debido a sobrecostes de coordinación.

### ✔️ Escalabilidad (scalability)

Capacidad del sistema para mantener rendimiento al aumentar la carga.

- **Por lotes**: crece BD y tamaño de tareas.
- **De transacciones**: crece la llegada de operaciones.

## 3. Desventajas y retos del paralelismo

- **Coste de inicio**: arrancar varios procesos puede ser más lento que ejecutar secuencialmente.
- **Interferencias**: disputa por memoria o recursos compartidos.
- **Sesgo**: particiones de trabajo no siempre equilibradas.

## 4. Arquitecturas paralelas de bases de datos

1. **Memoria compartida**  
   - Comunicación directa  
   − Congestión del bus de memoria  

2. **Disco compartido**  
   - Mayor tolerancia a fallos  
   − Accesos más lentos a disco  

3. **Sin compartimiento (shared-nothing)**  
   - Máxima escalabilidad  
   − Mayor coste de comunicación entre nodos  

4. **Jerárquica**  
   Combinación de los modelos anteriores.

## 5. Paralelismo en consultas (intra-query)

Consiste en dividir una **misma consulta** en suboperaciones que se ejecutan en paralelo.

Tipos:

- **Paralelismo en operaciones** (ej.: selección, ordenación).  
- **Paralelismo entre operaciones** (ej.: pipelines de operadores).

➡ Beneficio principal: **reduce el tiempo de respuesta**.

## 6. Paralelismo entre consultas (inter-query)

Varias consultas diferentes se ejecutan en paralelo.

- Aumenta la **productividad total**.  
- No siempre reduce el tiempo de respuesta individual.  
- Requiere gestionar **coherencia de cachés**.

## 7. Diseño de sistemas paralelos

Un sistema paralelo debe garantizar:

- **Alta disponibilidad**.  
- Capacidad de **recuperación ante fallos**.  
- Redistribución eficiente de datos y cargas.

## 🔹 8. Procesamiento paralelo en Oracle y SQL Server

### ✔️ Oracle

Permite paralelizar:

- Table scans, joins, creación de índices.  
- DML masivo (INSERT AS SELECT, MERGE).  
- SQL*Loader para grandes cargas de datos.  

Implementa colas para gestionar consultas paralelas en función de recursos.

### ✔️ SQL Server

Evalúa automáticamente si una operación debe ejecutarse en paralelo:

- Consultas complejas  
- Índices  
- Inserciones en paralelo  
- Estadísticas  

Se controla mediante **MAXDOP** (Maximum Degree of Parallelism).

## 🧩 Conclusión

Las bases de datos paralelas buscan:

- **Ejecutar consultas más rápido**.  
- **Procesar más volumen de trabajo simultáneamente**.  
- Escalar horizontal o verticalmente según la arquitectura.

Dominar estos conceptos ayuda a comprender cómo funcionan los grandes sistemas analíticos y OLAP modernos.
