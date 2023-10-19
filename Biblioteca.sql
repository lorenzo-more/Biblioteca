-------------------------------------------
-- Trabalho 1 de Banco de Dados II
-- Titulo: Biblioteca
-- Autor:  Lorenzo More
-------------------------------------------


-------------------------------------------
-- DDL:
-------------------------------------------

DROP TABLE Tipos_de_Obras 	CASCADE CONSTRAINTS;
DROP TABLE Autores 		CASCADE CONSTRAINTS;
DROP TABLE Obras 			CASCADE CONSTRAINTS;
DROP TABLE Professores 		CASCADE CONSTRAINTS;
DROP TABLE Alunos 		CASCADE CONSTRAINTS;
DROP TABLE Pessoas 		CASCADE CONSTRAINTS;
DROP TABLE Emprestimos 		CASCADE CONSTRAINTS;

CREATE TABLE Pessoas
(
	cpf 				VARCHAR(15)		NOT NULL,
	nome 				VARCHAR(70)		NOT NULL,
	email 			VARCHAR(50) 	NOT NULL,
	telefone 			VARCHAR(16) 	NULL,
	multa 			NUMERIC(4,2)	NULL,
	
	CONSTRAINT  		PK_Pessoas 		PRIMARY KEY (cpf),
	CONSTRAINT 			AK_Pessoas 		UNIQUE (email)
);

CREATE TABLE Professores
(
	cpf 				VARCHAR(15) 	NOT NULL,
	data_contratacao 		DATE 			NOT NULL
);

CREATE TABLE Alunos
(
	cpf 				VARCHAR(15) 	NOT NULL,
	matricula 			VARCHAR(10)		NOT NULL,
	creditos_concluidos 	NUMERIC(3)		NOT NULL,
	
	CONSTRAINT AK_Alunos 	UNIQUE (matricula)

);

CREATE TABLE Tipos_de_Obras
(
	codigo 		NUMERIC(1) 	NOT NULL,
	descricao 		VARCHAR(50)	NOT NULL,
	
	CONSTRAINT 	PK_Tipos_de_Obras PRIMARY KEY (codigo)
);

CREATE TABLE Autores
(
	autor 		VARCHAR(70) NOT NULL,
	cod_obra 		NUMERIC(3) 	NOT NULL,
	
	CONSTRAINT 	PK_Autores PRIMARY KEY (autor)
);

CREATE TABLE Obras
(
	codigo 		NUMERIC(3) 	NOT NULL,
	titulo 		VARCHAR(150) NOT NULL,
	nro_paginas 	NUMERIC(4) 	NOT NULL,
	tipo_obra 		NUMERIC(1)	NOT NULL,
	
	CONSTRAINT 	PK_Obras PRIMARY KEY (codigo)	
);

CREATE TABLE Emprestimos
(
	fk_cpf_pessoa 	VARCHAR(15) NOT NULL,
	fk_cod_obra 	NUMERIC(3)	NOT NULL,
	data_emprestimo 	DATE 		NOT NULL,
	data_devolucao 	DATE 		NOT NULL,
	
	CONSTRAINT PK_Emprestimos PRIMARY KEY (fk_cpf_pessoa, fk_cod_obra)
);

ALTER TABLE Pessoas
ADD
(
	CHECK (multa > 0.0)
);

ALTER TABLE Professores
ADD
(
	CONSTRAINT FK_Professores
	FOREIGN KEY (cpf)
	REFERENCES Pessoas (cpf)
	ON DELETE CASCADE
);

ALTER TABLE Alunos
ADD
(
	CONSTRAINT FK_Alunos
	FOREIGN KEY (cpf)
	REFERENCES Pessoas (cpf)
	ON DELETE CASCADE
);

ALTER TABLE Tipos_de_Obras
ADD
(
	CHECK (descricao IN ('Livro', 'Revista', 'Artigo', 'Material Especial'))
);

ALTER TABLE Obras
ADD
(
	CONSTRAINT 	FK_Obras
	FOREIGN KEY (tipo_obra)
	REFERENCES Tipos_de_Obras (codigo),
	
	CHECK (nro_paginas > 0)
);

ALTER TABLE Autores
ADD
(
	CONSTRAINT 	FK_Autores
	FOREIGN KEY (cod_obra)
	REFERENCES Obras (codigo)
	ON DELETE CASCADE
);

ALTER TABLE Emprestimos
ADD
(
	CONSTRAINT FK_Emprestimos_Obras
	FOREIGN KEY (fk_cod_obra)
	REFERENCES Obras (codigo)
	ON DELETE SET NULL,
	
	CONSTRAINT FK_Emprestimos_Pessoas 
	FOREIGN KEY (fk_cpf_pessoa)
	REFERENCES Pessoas (cpf)
	ON DELETE SET NULL
);

