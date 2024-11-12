USE DBProducoes
GO

-- Altera��o do tamanho da coluna nom_pessoa
ALTER TABLE pessoa ALTER COLUMN nom_pessoa varchar(1000) NOT NULL;

--Inclus�o do campo ind_status na coluna titulo
ALTER TABLE titulo ADD ind_status char(1) NOT NULL;

-- In�cio dos comandos DML

-- Total de t�tulos ativos

-- 1� Op��o utilizando CASE
SELECT nom_titulo AS "Nome Do T�tulo", ind_status,
"Status T�tulo" =
	CASE
		WHEN ind_status = 'A' THEN 'ATIVO'
		WHEN ind_status <> 'A' THEN 'INATIVO'
	END
FROM titulo
ORDER BY nom_titulo ASC
GO

-- 2� Op��o utilizando o WHERE
SELECT nom_titulo, ind_status
FROM titulo
WHERE ind_status = 'A' 
ORDER BY nom_titulo ASC;

-- Total de T�tulos Ativos
SELECT COUNT(*) AS "Total T�tulos Ativos"
FROM titulo
WHERE ind_status = 'A';

-- Rela��o de t�tulos com seus detalhes em ordem alfab�tica
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

-- Rela��o de t�tulos em ordem alfab�tica com seus autores e diretores(quando existirem)
SELECT titulo.nom_titulo, elenco.dsc_funcao, pessoa.nom_pessoa
FROM titulo
JOIN elenco ON titulo.cod_titulo = elenco.cod_titulo
JOIN pessoa ON elenco.cod_pessoa = pessoa.cod_pessoa
WHERE dsc_funcao = 'director' OR dsc_funcao = 'author'
ORDER BY titulo.nom_titulo ASC, elenco.dsc_funcao ASC;

-- Rela��o dos 100 t�tulos mais bem avaliados, com suas avalia��es e total de votos.
SELECT TOP(100)titulo.nom_titulo, classificacao_media, qtd_votos 
FROM titulo
JOIN avaliacao ON titulo.cod_titulo = avaliacao.cod_titulo
ORDER BY classificacao_media DESC

-- A Empresa solicitou que fa�a uma esp�cie de "auditoria de qualidade dos dados". Para isso crie as seguintes querys

-- T�tulos sem avalia��o
SELECT * 
FROM titulo LEFT JOIN avaliacao
ON titulo.cod_titulo = avaliacao.cod_titulo
WHERE avaliacao.cod_titulo IS NULL


--T�tulos sem o detalhe da dura��o ou informa��o do g�nero
SELECT *
FROM titulo LEFT JOIN titulo_detalhe
ON titulo.cod_titulo = titulo_detalhe.cod_titulo
WHERE titulo_detalhe.qtd_minutos IS NULL OR titulo_detalhe.dsc_genero IS NULL

-- T�tulos sem autor
SELECT *
FROM titulo LEFT JOIN avaliacao
ON titulo.cod_titulo = avaliacao.cod_titulo
WHERE avaliacao.cod_titulo IS NULL

-- T�tulo sem diretor
SELECT *
FROM titulo 
LEFT JOIN direcao
ON titulo.cod_titulo = direcao.cod_titulo
WHERE direcao.cod_titulo IS NULL

-- T�tulo sem elenco
SELECT *
FROM titulo 
LEFT JOIN elenco
ON titulo.cod_titulo = elenco.cod_titulo
WHERE elenco.cod_titulo IS NULL

-- Por fim, a empresa solicitou que seja desenvolvido em apenas uma query o retorno das seguintes
-- colunas acerca dos t�tulos ativos, ordenados alfabeticamente pelo nome do t�tulo
-- Nome do t�tulo, Tipo do t�tulo(em mai�sculo), ano de lan�amento, dura��o, g�nero, nota, autor e diretor
-- Todos se existirem ou n�o

SELECT titulo.nom_titulo AS "Nome do T�tulo",
       UPPER(titulo_detalhe.tip_titulo) AS "Tipo do T�tulo",
       titulo_detalhe.ano_lancamento AS "Ano de Lan�amento",
       titulo_detalhe.qtd_minutos AS "Dura��o",
       titulo_detalhe.dsc_genero AS "G�nero",
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

-- Foi necess�rio o uso de Aliases diferentes para distinguir o autor do diretor j� que ambos 
-- est�o na tabela Pessoa.