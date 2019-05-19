--1. Extraia a listagem dos estados agrupados por quantidade de centralidades vinculadas. 
--Retorne esta informação ordenada do maior para o menor.

SELECT UF, COUNT(UF) QTD_CENTRALIDADE FROM MUNICIPIO
GROUP BY UF
ORDER BY QTD_CENTRALIDADE DESC;

--2. Crie uma nova tabela consolidando todos os dados das diferentes tabelas.

SELECT	ID, 
		CODMUN_ORIGEM,
		CODMUN_DESTINO,
		VOLUME_KG,
		CAST('0' AS varchar) AS NIVEL,
		CAST('0' AS varchar) AS DENOMINACAO,
		CAST(NULL AS varchar) AS UF,
		CAST(NULL AS varchar) AS NOMEMUN,
		CAST(NULL AS varchar) AS ID_CENTRALIDADE,
		CAST(NULL AS varchar) AS QTDE
		
FROM	CARGA
UNION 
SELECT  id,
		CAST(NULL AS varchar) AS CODMUN_ORIGEM,
		CAST(NULL AS varchar) AS CODMUN_DESTINO,
		CAST(NULL AS varchar) AS VOLUME_KG, 
		NIVEL,
		DENOMINACAO,
		CAST(NULL AS varchar) AS UF,
		CAST(NULL AS varchar) AS NOMEMUN,
		CAST(NULL AS varchar) AS ID_CENTRALIDADE,
		CAST(NULL AS varchar) AS QTDE
		
FROM	CENTRALIDADE
UNION
SELECT	COD_UF, 
		CAST(NULL AS varchar) AS CODMUN_ORIGEM,
		CAST(NULL AS varchar) AS CODMUN_DESTINO,
		CAST(NULL AS varchar) AS VOLUME_KG,
		CAST(NULL AS varchar) AS NIVEL,
		CAST(NULL AS varchar) AS DENOMINACAO,
		UF,
		CAST(NULL AS varchar) AS NOMEMUN,
		CAST(NULL AS varchar) AS ID_CENTRALIDADE,
		CAST(NULL AS varchar) AS QTDE
FROM	ESTADO
UNION
SELECT  CODMUN, 
		CAST(NULL AS varchar) AS CODMUN_ORIGEM,
		CAST(NULL AS varchar) AS CODMUN_DESTINO,
		CAST(NULL AS varchar) AS VOLUME_KG,
		CAST(NULL AS varchar) AS NIVEL,
		CAST(NULL AS varchar) AS DENOMINACAO,
		UF,
		NOMEMUN, 
		ID_CENTRALIDADE,
		CAST(NULL AS varchar) AS QTDE
		
FROM	MUNICIPIO
UNION
SELECT	ID, 
		CODMUN_ORIGEM, 
		CODMUN_DESTINO, 
		CAST(NULL AS varchar) AS VOLUME_KG,
		CAST(NULL AS varchar) AS NIVEL,
		CAST(NULL AS varchar) AS DENOMINACAO,
		CAST(NULL AS varchar) AS UF,
		CAST(NULL AS varchar) AS NOMEMUN,
		CAST(NULL AS varchar) AS ID_CENTRALIDADE,
		QTDE
FROM	PASSAGEIROS

--3. Consolide os dados de TODAS as tabelas (respeitando suas referencias)
--para esta nova tabela com uma única query

SELECT	ID, 
		CODMUN_ORIGEM,
		CODMUN_DESTINO,
		VOLUME_KG,
		CAST('0' AS varchar) AS NIVEL,
		CAST('0' AS varchar) AS DENOMINACAO,
		CAST(NULL AS varchar) AS UF,
		CAST(NULL AS varchar) AS NOMEMUN,
		CAST(NULL AS varchar) AS ID_CENTRALIDADE,
		CAST(NULL AS varchar) AS QTDE
		
FROM	CARGA
UNION 
SELECT  id,
		CAST(NULL AS varchar) AS CODMUN_ORIGEM,
		CAST(NULL AS varchar) AS CODMUN_DESTINO,
		CAST(NULL AS varchar) AS VOLUME_KG, 
		NIVEL,
		DENOMINACAO,
		CAST(NULL AS varchar) AS UF,
		CAST(NULL AS varchar) AS NOMEMUN,
		CAST(NULL AS varchar) AS ID_CENTRALIDADE,
		CAST(NULL AS varchar) AS QTDE
		
FROM	CENTRALIDADE
UNION
SELECT	COD_UF, 
		CAST(NULL AS varchar) AS CODMUN_ORIGEM,
		CAST(NULL AS varchar) AS CODMUN_DESTINO,
		CAST(NULL AS varchar) AS VOLUME_KG,
		CAST(NULL AS varchar) AS NIVEL,
		CAST(NULL AS varchar) AS DENOMINACAO,
		UF,
		CAST(NULL AS varchar) AS NOMEMUN,
		CAST(NULL AS varchar) AS ID_CENTRALIDADE,
		CAST(NULL AS varchar) AS QTDE
FROM	ESTADO
UNION
SELECT  CODMUN, 
		CAST(NULL AS varchar) AS CODMUN_ORIGEM,
		CAST(NULL AS varchar) AS CODMUN_DESTINO,
		CAST(NULL AS varchar) AS VOLUME_KG,
		CAST(NULL AS varchar) AS NIVEL,
		CAST(NULL AS varchar) AS DENOMINACAO,
		UF,
		NOMEMUN, 
		ID_CENTRALIDADE,
		CAST(NULL AS varchar) AS QTDE
		
FROM	MUNICIPIO
UNION
SELECT	ID, 
		CODMUN_ORIGEM, 
		CODMUN_DESTINO, 
		CAST(NULL AS varchar) AS VOLUME_KG,
		CAST(NULL AS varchar) AS NIVEL,
		CAST(NULL AS varchar) AS DENOMINACAO,
		CAST(NULL AS varchar) AS UF,
		CAST(NULL AS varchar) AS NOMEMUN,
		CAST(NULL AS varchar) AS ID_CENTRALIDADE,
		QTDE
FROM	PASSAGEIROS

--4. Crie um relatório com o volume total de carga por município destino, trazendo:
--UF, coduf, codmun, nomemun, total_carga_kg



SELECT	E.UF, E.COD_UF,
		M.CODMUN, M.NOMEMUN,
		SUM(C.VOLUME_KG) AS total_carga_kg

FROM ESTADO E

INNER JOIN MUNICIPIO M ON E.UF = M.UF

INNER JOIN CARGA C ON M.CODMUN = C.CODMUN_DESTINO

GROUP BY E.UF, E.COD_UF, M.CODMUN, M.NOMEMUN;


--5. Crie um relatório com a média de carga por município destino, trazendo:
--UF, coduf, codmun, nomemun, media_carga_kg

SELECT	E.UF, E.COD_UF,
		M.CODMUN, M.NOMEMUN,
		AVG(C.VOLUME_KG) AS total_carga_kg

FROM ESTADO E

INNER JOIN MUNICIPIO M ON E.UF = M.UF

INNER JOIN CARGA C ON M.CODMUN = C.CODMUN_DESTINO

GROUP BY E.UF, E.COD_UF, M.CODMUN, M.NOMEMUN;

--6. Crie um relatório com a média do volume das maiores 10 cargas transportadas
--por estado, ordenando de forma decrescente

SELECT AVG(TOTAL_CARGA_KG) AS MEDIA_TOTAL_CARGA_KG

FROM
(
SELECT	TOP (10) E.UF, E.COD_UF,
		M.CODMUN, M.NOMEMUN,
		SUM(C.VOLUME_KG) AS TOTAL_CARGA_KG		

FROM ESTADO E

INNER JOIN MUNICIPIO M ON E.UF = M.UF

INNER JOIN CARGA C ON M.CODMUN = C.CODMUN_DESTINO



GROUP BY E.UF, E.COD_UF, M.CODMUN, M.NOMEMUN
ORDER BY TOTAL_CARGA_KG  DESC
) AS MEDIA_TOTAL_CARGA_KG	




--7. Crie um relatório com a média do volume das menores 10 cargas transportadas
--por estado, ordenando de forma crescente

SELECT AVG(TOTAL_CARGA_KG) AS MEDIA_TOTAL_CARGA_KG

FROM
(
SELECT	TOP (10) E.UF, E.COD_UF,
		M.CODMUN, M.NOMEMUN,
		SUM(C.VOLUME_KG) AS TOTAL_CARGA_KG		

FROM ESTADO E

INNER JOIN MUNICIPIO M ON E.UF = M.UF

INNER JOIN CARGA C ON M.CODMUN = C.CODMUN_DESTINO



GROUP BY E.UF, E.COD_UF, M.CODMUN, M.NOMEMUN
ORDER BY TOTAL_CARGA_KG ASC 
) AS MEDIA_TOTAL_CARGA_KG	
--8. Crie um relatório com a quantidade de municípios por estado ordenando
--de forma decrescente

SELECT	E.COD_UF, E.UF,
		
		COUNT(M.CODMUN) AS QTD_MUNICIPIOS

FROM ESTADO E

INNER JOIN MUNICIPIO M ON E.UF = M.UF

GROUP BY E.COD_UF, E.UF

ORDER BY QTD_MUNICIPIOS DESC;

--9. Crie um relatório com a total de carga de transportes por centralidade (como origem), 
--ordenado de forma crescente

SELECT	M.ID_CENTRALIDADE,
		SUM(C.VOLUME_KG) AS TOTAL_CARGA
FROM MUNICIPIO M
INNER JOIN CARGA C ON C.CODMUN_ORIGEM = M.CODMUN 

GROUP BY M.ID_CENTRALIDADE
ORDER BY TOTAL_CARGA ASC;

--10. Crie um relatório com a total de carga de transportes por centralidade (como destino), 
--ordenado de forma crescente

SELECT	M.ID_CENTRALIDADE,
		SUM(C.VOLUME_KG) AS TOTAL_CARGA
FROM MUNICIPIO M
INNER JOIN CARGA C ON C.CODMUN_DESTINO = M.CODMUN 

GROUP BY M.ID_CENTRALIDADE
ORDER BY TOTAL_CARGA ASC;






select row_number() over (order by nomemun desc)AS LINHA, *
from MUNICIPIO
order by nomemun desc
offset 0 rows fetch next 15 rows only;