USE DBProducoes
GO

-- Alteração do tamanho da coluna nom_pessoa
ALTER TABLE pessoa ALTER COLUMN nom_pessoa varchar(1000) NOT NULL;

--Inclusão do campo ind_status na coluna titulo após o schema físico ter sido criado
ALTER TABLE titulo ADD ind_status char(1) NOT NULL;

-- Início dos comandos DML

-- Total de títulos ativos
-- Irei demostrar com 2º opções diferentes.

-- 1º Opção utilizando CASE
SELECT nom_titulo AS "Nome Do Título", ind_status,
"Status Título" =
	CASE
		WHEN ind_status = 'A' THEN 'ATIVO'
		WHEN ind_status <> 'A' THEN 'INATIVO'
	END
FROM titulo
ORDER BY nom_titulo ASC
GO

-- 2º Opção utilizando o WHERE
SELECT nom_titulo, ind_status
FROM titulo
WHERE ind_status = 'A' 
ORDER BY nom_titulo ASC;

-- Total de Títulos Ativos
SELECT COUNT(*) AS "Total Títulos Ativos"
FROM titulo
WHERE ind_status = 'A';

-- Relação de títulos com seus detalhes em ordem alfabética
SELECT titulo.nom_titulo,
	   titulo_detalhe.nom_principal_titulo,
	   titulo_detalhe.nom_original_titulo,
	   titulo_detalhe.ind_adulto,
	   titulo_detalhe.ano_lancamento,
	   titulo_detalhe.qtd_minutos,
	   titulo_detalhe.dsc_genero
FROM titulo
JOIN titulo_detalhe ON titulo.cod_titulo = titulo_detalhe.cod_titulo
ORDER BY titulo.nom_titulo ASC;

-- Relação de títulos em ordem alfabética com seus autores e diretores(quando existirem)
SELECT titulo.nom_titulo, elenco.dsc_funcao, pessoa.nom_pessoa
FROM titulo
JOIN elenco ON titulo.cod_titulo = elenco.cod_titulo
JOIN pessoa ON elenco.cod_pessoa = pessoa.cod_pessoa
WHERE dsc_funcao = 'director' OR dsc_funcao = 'author'
ORDER BY titulo.nom_titulo ASC, elenco.dsc_funcao ASC;

-- Relação dos 100 títulos mais bem avaliados, com suas avaliações e total de votos.
SELECT TOP(100)titulo.nom_titulo, classificacao_media, qtd_votos 
FROM titulo
JOIN avaliacao ON titulo.cod_titulo = avaliacao.cod_titulo
ORDER BY classificacao_media DESC

-- Foi solicitado pela empresa que faça uma espécie de "auditoria de qualidade dos dados"
-- Com isso foi feito as seguintes querys

-- Títulos sem avaliação
SELECT * 
FROM titulo LEFT JOIN avaliacao
ON titulo.cod_titulo = avaliacao.cod_titulo
WHERE avaliacao.cod_titulo IS NULL


--Títulos sem o detalhe da duração ou informação do gênero
SELECT *
FROM titulo LEFT JOIN titulo_detalhe
ON titulo.cod_titulo = titulo_detalhe.cod_titulo
WHERE titulo_detalhe.qtd_minutos IS NULL OR titulo_detalhe.dsc_genero IS NULL

-- Títulos sem autor
SELECT *
FROM titulo LEFT JOIN avaliacao
ON titulo.cod_titulo = avaliacao.cod_titulo
WHERE avaliacao.cod_titulo IS NULL

-- Título sem diretor
SELECT *
FROM titulo 
LEFT JOIN direcao
ON titulo.cod_titulo = direcao.cod_titulo
WHERE direcao.cod_titulo IS NULL

-- Título sem elenco
SELECT *
FROM titulo 
LEFT JOIN elenco
ON titulo.cod_titulo = elenco.cod_titulo
WHERE elenco.cod_titulo IS NULL

-- Por fim, a empresa solicitou que fosse desenvolvido em apenas uma query o retorno das seguintes
-- colunas acerca dos títulos ativos, ordenados alfabeticamente pelo nome do título.
-- Nome do título, Tipo do título(em maiúsculo), Ano de Lançamento, Duração, Gênero, Nota, Autor e Diretor
-- Todos se existirem ou não

SELECT titulo.nom_titulo AS "Nome do Título",
       UPPER(titulo_detalhe.tip_titulo) AS "Tipo do Título",
       titulo_detalhe.ano_lancamento AS "Ano de Lançamento",
       titulo_detalhe.qtd_minutos AS "Duração",
       titulo_detalhe.dsc_genero AS "Gênero",
       avaliacao.classificacao_media AS "Nota",
       autor.nom_pessoa AS "Autor",
       diretor.nom_pessoa AS "Diretor"
FROM titulo
LEFT JOIN titulo_detalhe ON titulo.cod_titulo = titulo_detalhe.cod_titulo
LEFT JOIN avaliacao ON titulo.cod_titulo = avaliacao.cod_titulo
LEFT JOIN autoria ON titulo.cod_titulo = autoria.cod_titulo
LEFT JOIN pessoa AS autor ON autoria.cod_pessoa = autor.cod_pessoa
LEFT JOIN direcao ON titulo.cod_titulo = direcao.cod_titulo
LEFT JOIN pessoa AS diretor ON direcao.cod_pessoa = diretor.cod_pessoa
WHERE titulo.ind_status = 'A'
ORDER BY titulo.nom_titulo ASC;

-- Foi necessário o uso de aliases diferentes para distinguir o autor do diretor já que ambos estão na tabela Pessoa.
