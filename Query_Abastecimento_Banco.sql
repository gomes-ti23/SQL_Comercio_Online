USE DBProducoes
GO

-- Inser��o dos dados nas tabelas do banco respeitando a sua ordem de preced�ncia.
BULK INSERT dbo.titulo
FROM 'C:\Dados do Trabalho Pr�tico SQL\Titulo.txt'
WITH (
	FIELDTERMINATOR = '\t',
	ROWTERMINATOR = '\n',
	KEEPIDENTITY
	);

BULK INSERT dbo.pessoa
FROM 'C:\Dados do Trabalho Pr�tico SQL\Pessoa.txt'
WITH (
	FIELDTERMINATOR = '\t',
	ROWTERMINATOR = '\n',
	KEEPIDENTITY
	);

USE DBProducoes
GO

BULK INSERT dbo.direcao
FROM 'C:\Dados do Trabalho Pr�tico SQL\Direcao.txt'
WITH (
	FIELDTERMINATOR = '\t',
	ROWTERMINATOR = '\n',
	KEEPIDENTITY
	);

BULK INSERT dbo.autoria
FROM 'C:\Dados do Trabalho Pr�tico SQL\Autoria.txt'
WITH (
	FIELDTERMINATOR = '\t',
	ROWTERMINATOR = '\n',
	KEEPIDENTITY
	);

BULK INSERT dbo.elenco
FROM 'C:\Dados do Trabalho Pr�tico SQL\Elenco.txt'
WITH (
	FIELDTERMINATOR = '\t',
	ROWTERMINATOR = '\n',
	KEEPIDENTITY
	);

BULK INSERT dbo.avaliacao
FROM 'C:\Dados do Trabalho Pr�tico SQL\Avaliacao.txt'
WITH (
	FIELDTERMINATOR = '\t',
	ROWTERMINATOR = '\n',
	KEEPIDENTITY
	);

BULK INSERT dbo.titulo_detalhe
FROM 'C:\Dados do Trabalho Pr�tico SQL\Titulo_Detalhe.txt'
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