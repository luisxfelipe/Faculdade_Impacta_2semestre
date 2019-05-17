--1. Extraia a listagem dos estados agrupados por quantidade de centralidades vinculadas. 
--Retorne esta informação ordenada do maior para o menor.

SELECT UF, COUNT(UF) QTD_CENTRALIDADE FROM MUNICIPIO
GROUP BY UF
ORDER BY QTD_CENTRALIDADE DESC

--2. Crie uma nova tabela consolidando todos os dados das diferentes tabelas.

--3. Consolide os dados de TODAS as tabelas (respeitando suas referencias)
--para esta nova tabela com uma única query
--4. Crie um relatório com o volume total de carga por município destino, trazendo:
--UF, coduf, codmun, nomemun, total_carga_kg



SELECT	E.UF, E.COD_UF,
		M.CODMUN, M.NOMEMUN,
		SUM(C.VOLUME_KG) AS total_carga_kg

FROM ESTADO E

INNER JOIN MUNICIPIO M ON E.UF = M.UF

INNER JOIN CARGA C ON M.CODMUN = C.CODMUN_DESTINO

GROUP BY E.UF, E.COD_UF, M.CODMUN, M.NOMEMUN


--5. Crie um relatório com a média de carga por município destino, trazendo:
--UF, coduf, codmun, nomemun, media_carga_kg

SELECT	E.UF, E.COD_UF,
		M.CODMUN, M.NOMEMUN,
		AVG(C.VOLUME_KG) AS total_carga_kg

FROM ESTADO E

INNER JOIN MUNICIPIO M ON E.UF = M.UF

INNER JOIN CARGA C ON M.CODMUN = C.CODMUN_DESTINO

GROUP BY E.UF, E.COD_UF, M.CODMUN, M.NOMEMUN

--6. Crie um relatório com a média do volume das maiores 10 cargas transportadas
--por estado, ordenando de forma decrescente







--7. Crie um relatório com a média do volume das menores 10 cargas transportadas
--por estado, ordenando de forma crescente
--8. Crie um relatório com a quantidade de municípios por estado ordenando
--de forma decrescente

SELECT	E.COD_UF, E.UF,
		
		COUNT(M.CODMUN) AS QTD_MUNICIPIOS

FROM ESTADO E

INNER JOIN MUNICIPIO M ON E.UF = M.UF

GROUP BY E.COD_UF, E.UF

ORDER BY QTD_MUNICIPIOS DESC

--9. Crie um relatório com a total de carga de transportes por centralidade (como origem), 
--ordenado de forma crescente

SELECT	M.ID_CENTRALIDADE,
		SUM(C.VOLUME_KG) AS TOTAL_CARGA
FROM MUNICIPIO M
INNER JOIN CARGA C ON C.CODMUN_ORIGEM = M.CODMUN 

GROUP BY M.ID_CENTRALIDADE
ORDER BY TOTAL_CARGA ASC

--10. Crie um relatório com a total de carga de transportes por centralidade (como destino), 
--ordenado de forma crescente

SELECT	M.ID_CENTRALIDADE,
		SUM(C.VOLUME_KG) AS TOTAL_CARGA
FROM MUNICIPIO M
INNER JOIN CARGA C ON C.CODMUN_DESTINO = M.CODMUN 

GROUP BY M.ID_CENTRALIDADE
ORDER BY TOTAL_CARGA ASC