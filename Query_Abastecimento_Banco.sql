USE DBProducoes
GO

-- Inserção dos dados nas tabelas do banco respeitando a sua ordem de precedência.
BULK INSERT dbo.titulo
FROM 'C:\Dados do Trabalho Prático SQL\Titulo.txt'
WITH (
	FIELDTERMINATOR = '\t',
	ROWTERMINATOR = '\n',
	KEEPIDENTITY
	);

BULK INSERT dbo.pessoa
FROM 'C:\Dados do Trabalho Prático SQL\Pessoa.txt'
WITH (
	FIELDTERMINATOR = '\t',
	ROWTERMINATOR = '\n',
	KEEPIDENTITY
	);

USE DBProducoes
GO

BULK INSERT dbo.direcao
FROM 'C:\Dados do Trabalho Prático SQL\Direcao.txt'
WITH (
	FIELDTERMINATOR = '\t',
	ROWTERMINATOR = '\n',
	KEEPIDENTITY
	);

BULK INSERT dbo.autoria
FROM 'C:\Dados do Trabalho Prático SQL\Autoria.txt'
WITH (
	FIELDTERMINATOR = '\t',
	ROWTERMINATOR = '\n',
	KEEPIDENTITY
	);

BULK INSERT dbo.elenco
FROM 'C:\Dados do Trabalho Prático SQL\Elenco.txt'
WITH (
	FIELDTERMINATOR = '\t',
	ROWTERMINATOR = '\n',
	KEEPIDENTITY
	);

BULK INSERT dbo.avaliacao
FROM 'C:\Dados do Trabalho Prático SQL\Avaliacao.txt'
WITH (
	FIELDTERMINATOR = '\t',
	ROWTERMINATOR = '\n',
	KEEPIDENTITY
	);

BULK INSERT dbo.titulo_detalhe
FROM 'C:\Dados do Trabalho Prático SQL\Titulo_Detalhe.txt'
WITH (
	FIELDTERMINATOR = '\t',
	ROWTERMINATOR = '\n',
	KEEPIDENTITY
	);

-- Checagem do carregamento das 7 tabelas
USE DBProducoes
GO

SELECT 'SELECT COUNT(*) AS Qtde_Linhas_Tabelas ' + name + ' from ' + name
FROM sys.tables
ORDER BY name
GO