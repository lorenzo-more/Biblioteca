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

-------------------------------------------
-- DML:
-------------------------------------------

-- 5 Pessoas:

INSERT INTO Pessoas (cpf, nome, email, telefone, multa)
	VALUES ('03303303343', 'Lorenzo More', 'lorenzo.duarte@edu.pucrs.br', NULL, NULL);

INSERT INTO Pessoas (cpf, nome, email, telefone, multa)
	VALUES ('03649107240', 'Steve Jones', 'jones.steve@edu.pucrs.br', '51998789898', 2.0);

INSERT INTO Pessoas (cpf, nome, email, telefone, multa)
	VALUES ('49281225506', 'Juliana Pires', 'jupires@email.com', '51912531460', 4.50);

INSERT INTO Pessoas (cpf, nome, email, telefone, multa)
	VALUES ('09741713226', 'Lucia Martins', 'lucia.m@email.com', '51998742390', NULL);

INSERT INTO Pessoas (cpf, nome, email, telefone, multa)
	VALUES ('02301994578', 'Anderson Rosa', 'a.rosa@email.com.br', NULL, 26.90);

-- 2 Professores:

INSERT INTO Professores (cpf, data_contratacao)
	VALUES ('09741713226', TO_DATE('01/02/1989', 'DD/MM/YYYY'));

INSERT INTO Professores (cpf, data_contratacao)
	VALUES ('02301994578', TO_DATE('01/06/1999', 'DD/MM/YYYY'));

-- 3 Alunos:

INSERT INTO Alunos (cpf, matricula, creditos_concluidos)
	VALUES ('03303303343', '22103093', 24);

INSERT INTO Alunos (cpf, matricula, creditos_concluidos)
	VALUES ('03649107240', '22104070', 30);

INSERT INTO Alunos (cpf, matricula, creditos_concluidos)
	VALUES ('49281225506', '21309455', 40);

-- 4 Tipos_de_Obras ('Livro', 'Revista', 'Artigo', 'Material Especial')

INSERT INTO Tipos_de_Obras (codigo, descricao)
	VALUES (1, 'Livro');

INSERT INTO Tipos_de_Obras (codigo, descricao)
	VALUES (2, 'Revista');

INSERT INTO Tipos_de_Obras (codigo, descricao)
	VALUES (3, 'Artigo');

INSERT INTO Tipos_de_Obras (codigo, descricao)
	VALUES (4, 'Material Especial');

-- 5 Obras (2 Livros, 1 Revista, 1 Artigo, 1 Material Especial):

INSERT INTO Obras (codigo, titulo, nro_paginas, tipo_obra)
	VALUES (1, 'Java for Everyone: Late Objects', 831, 1);

INSERT INTO Obras (codigo, titulo, nro_paginas, tipo_obra)
	VALUES (2, 'A Game of Thrones', 694, 1);

INSERT INTO Obras (codigo, titulo, nro_paginas, tipo_obra)
	VALUES (3, 'IFAC Journal of Systems & Control', 512, 2);

INSERT INTO Obras (codigo, titulo, nro_paginas, tipo_obra)
	VALUES (4, 'On the Use of Design Thinking: A Survey of the Brazilian Agile Software Development Community', 13, 3);

INSERT INTO Obras (codigo, titulo, nro_paginas, tipo_obra)
	VALUES (5, 'Programa Espacial Brasileiro', 1005, 4);

-- Autores das obras:

INSERT INTO Autores (autor, cod_obra)
	VALUES ('Cay Horstmann', 1);

INSERT INTO Autores (autor, cod_obra)
	VALUES ('George R. R. Martin', 2);

INSERT INTO Autores (autor, cod_obra)
	VALUES ('IFAC', 3);

INSERT INTO Autores (autor, cod_obra)
	VALUES ('Rafael Parizi', 4);

INSERT INTO Autores (autor, cod_obra)
	VALUES ('Matheus Prestes', 4);

INSERT INTO Autores (autor, cod_obra)
	VALUES ('Sabrina Marczak', 4);

INSERT INTO Autores (autor, cod_obra)
	VALUES ('Tayana Conte', 4);

INSERT INTO Autores (autor, cod_obra)
	VALUES ('PEB', 5);
	
INSERT INTO Autores (autor, cod_obra)
	VALUES ('Instituto de Ciencia e Tecnologia', 5);

-- 10 Emprestimos:

INSERT INTO Emprestimos (fk_cpf_pessoa, fk_cod_obra, data_emprestimo, data_devolucao)
	VALUES ('03303303343', 1, TO_DATE('12/03/2020', 'DD/MM/YYYY'), TO_DATE('19/03/2020', 'DD/MM/YYYY'));

INSERT INTO Emprestimos (fk_cpf_pessoa, fk_cod_obra, data_emprestimo, data_devolucao)
	VALUES ('03303303343', 2, TO_DATE('15/03/2020', 'DD/MM/YYYY'), TO_DATE('22/03/2020', 'DD/MM/YYYY'));

INSERT INTO Emprestimos (fk_cpf_pessoa, fk_cod_obra, data_emprestimo, data_devolucao)
	VALUES ('03649107240', 3, TO_DATE('10/04/2020', 'DD/MM/YYYY'), TO_DATE('17/04/2020', 'DD/MM/YYYY'));

INSERT INTO Emprestimos (fk_cpf_pessoa, fk_cod_obra, data_emprestimo, data_devolucao)
	VALUES ('03649107240', 4, TO_DATE('25/04/2020', 'DD/MM/YYYY'), TO_DATE('03/05/2020', 'DD/MM/YYYY'));

INSERT INTO Emprestimos (fk_cpf_pessoa, fk_cod_obra, data_emprestimo, data_devolucao)
	VALUES ('49281225506', 1, TO_DATE('09/05/2020', 'DD/MM/YYYY'), TO_DATE('16/05/2020', 'DD/MM/YYYY'));

INSERT INTO Emprestimos (fk_cpf_pessoa, fk_cod_obra, data_emprestimo, data_devolucao)
	VALUES ('49281225506', 5, TO_DATE('21/05/2020', 'DD/MM/YYYY'), TO_DATE('30/05/2020', 'DD/MM/YYYY'));

INSERT INTO Emprestimos (fk_cpf_pessoa, fk_cod_obra, data_emprestimo, data_devolucao)
	VALUES ('09741713226', 4, TO_DATE('02/06/2020', 'DD/MM/YYYY'), TO_DATE('18/06/2020', 'DD/MM/YYYY'));

INSERT INTO Emprestimos (fk_cpf_pessoa, fk_cod_obra, data_emprestimo, data_devolucao)
	VALUES ('09741713226', 5, TO_DATE('19/06/2020', 'DD/MM/YYYY'), TO_DATE('27/06/2020', 'DD/MM/YYYY'));

INSERT INTO Emprestimos (fk_cpf_pessoa, fk_cod_obra, data_emprestimo, data_devolucao)
	VALUES ('02301994578', 2, TO_DATE('08/06/2020', 'DD/MM/YYYY'), TO_DATE('21/06/2020', 'DD/MM/YYYY'));

INSERT INTO Emprestimos (fk_cpf_pessoa, fk_cod_obra, data_emprestimo, data_devolucao)
	VALUES ('02301994578', 3, TO_DATE('15/07/2020', 'DD/MM/YYYY'), TO_DATE('29/07/2020', 'DD/MM/YYYY'));
	
COMMIT;
