-- Criação do Banco de Dados
CREATE DATABASE DBProducoes
GO

-- Criação de todos objetos necessários ao banco.
USE DBProducoes
GO

CREATE TABLE dbo.pessoa (
                cod_pessoa INT NOT NULL,
                nom_pessoa VARCHAR(500) NOT NULL,
                ano_nascimento INT,
                ano_falecimento INT,
                dsc_profissao VARCHAR(1000),
                CONSTRAINT pk_pessoa PRIMARY KEY (cod_pessoa)
)

CREATE TABLE dbo.titulo (
                cod_titulo INT NOT NULL,
                nom_titulo VARCHAR(1000),
                CONSTRAINT pk_titulo PRIMARY KEY (cod_titulo)
)

CREATE TABLE dbo.elenco (
                cod_elenco INT IDENTITY NOT NULL,
                cod_titulo INT NOT NULL,
                cod_pessoa INT NOT NULL,
                dsc_funcao VARCHAR(1000) NOT NULL,
                dsc_personagem VARCHAR(1000),
                CONSTRAINT pk_elenco PRIMARY KEY (cod_elenco, cod_titulo, cod_pessoa)
)

CREATE TABLE dbo.titulo_detalhe (
                cod_titulo INT NOT NULL,
                tip_titulo VARCHAR(100) NOT NULL,
                nom_principal_titulo VARCHAR(1000) NOT NULL,
                nom_original_titulo VARCHAR(1000) NOT NULL,
                ind_adulto BIT NOT NULL,
                ano_lancamento INT NOT NULL,
                qtd_minutos SMALLINT,
                dsc_genero VARCHAR(1000),
                CONSTRAINT pk_titulo_detalhe PRIMARY KEY (cod_titulo)
)

CREATE TABLE dbo.autoria (
                cod_autoria INT IDENTITY NOT NULL,
                cod_titulo INT NOT NULL,
                cod_pessoa INT NOT NULL,
                CONSTRAINT pk_autoria PRIMARY KEY (cod_autoria, cod_titulo, cod_pessoa)
)

CREATE TABLE dbo.direcao (
                cod_titulo INT NOT NULL,
                cod_pessoa INT NOT NULL,
                cod_direcao INT IDENTITY NOT NULL,
                CONSTRAINT pk_direcao PRIMARY KEY (cod_titulo, cod_pessoa, cod_direcao)
)

CREATE TABLE dbo.avaliacao (
                cod_titulo INT NOT NULL,
                classificacao_media INT NOT NULL,
                qtd_votos INT NOT NULL,
                CONSTRAINT avaliacao_pk PRIMARY KEY (cod_titulo)
)

ALTER TABLE dbo.elenco ADD CONSTRAINT pessoa_elenco_fk
FOREIGN KEY (cod_pessoa)
REFERENCES dbo.pessoa (cod_pessoa)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE dbo.autoria ADD CONSTRAINT pessoa_autoria_fk
FOREIGN KEY (cod_pessoa)
REFERENCES dbo.pessoa (cod_pessoa)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE dbo.direcao ADD CONSTRAINT pessoa_direcao_fk
FOREIGN KEY (cod_pessoa)
REFERENCES dbo.pessoa (cod_pessoa)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE dbo.avaliacao ADD CONSTRAINT titulo_avaliacao_fk
FOREIGN KEY (cod_titulo)
REFERENCES dbo.titulo (cod_titulo)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE dbo.direcao ADD CONSTRAINT titulo_direcao_fk
FOREIGN KEY (cod_titulo)
REFERENCES dbo.titulo (cod_titulo)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE dbo.autoria ADD CONSTRAINT titulo_autoria_fk
FOREIGN KEY (cod_titulo)
REFERENCES dbo.titulo (cod_titulo)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE dbo.titulo_detalhe ADD CONSTRAINT titulo_titulo_detalhe_fk
FOREIGN KEY (cod_titulo)
REFERENCES dbo.titulo (cod_titulo)
ON DELETE NO ACTION
ON UPDATE NO ACTION

ALTER TABLE dbo.elenco ADD CONSTRAINT titulo_elenco_fk
FOREIGN KEY (cod_titulo)
REFERENCES dbo.titulo (cod_titulo)
ON DELETE NO ACTION
ON UPDATE NO ACTION