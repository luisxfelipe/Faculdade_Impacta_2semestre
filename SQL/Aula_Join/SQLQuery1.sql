IF OBJECT_ID('MENSAGEM', 'U') IS NOT NULL
	DROP TABLE MENSAGEM
IF OBJECT_ID('ENTREGA', 'U') IS NOT NULL
	DROP TABLE ENTREGA
IF OBJECT_ID('ATIVIDADE_VINCULADA', 'U') IS NOT NULL
	DROP TABLE ATIVIDADE_VINCULADA
IF OBJECT_ID('ATIVIDADE', 'U') IS NOT NULL
	DROP TABLE ATIVIDADE
IF OBJECT_ID('SOLICITACAO_MATRICULA', 'U') IS NOT NULL
	DROP TABLE SOLICITACAO_MATRICULA
IF OBJECT_ID('DISCIPLINA_OFERTADA', 'U') IS NOT NULL
	DROP TABLE DISCIPLINA_OFERTADA
IF OBJECT_ID('CURSO', 'U') IS NOT NULL
	DROP TABLE CURSO
IF OBJECT_ID('DISCIPLINA', 'U') IS NOT NULL
	DROP TABLE DISCIPLINA
IF OBJECT_ID('PROFESSOR', 'U') IS NOT NULL
	DROP TABLE PROFESSOR
IF OBJECT_ID('ALUNO', 'U') IS NOT NULL
	DROP TABLE ALUNO
IF OBJECT_ID('COORDENADOR', 'U') IS NOT NULL
	DROP TABLE COORDENADOR
IF OBJECT_ID('USUARIO', 'U') IS NOT NULL
	DROP TABLE USUARIO
 
CREATE TABLE USUARIO(
	ID INT IDENTITY PRIMARY KEY,
	LOGIN VARCHAR(50) UNIQUE,
	SENHA VARCHAR(50) NOT NULL,
	DT_EXPIRACAO DATETIME DEFAULT ('1900-01-01')
);

CREATE TABLE COORDENADOR(
	ID INT IDENTITY PRIMARY KEY,
	ID_USUARIO INT FOREIGN KEY REFERENCES USUARIO(ID) NOT NULL,
	NOME VARCHAR(100) NOT NULL,
	EMAIL VARCHAR(100) UNIQUE NOT NULL,
	CELULAR VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE ALUNO(
	ID INT IDENTITY PRIMARY KEY,
	ID_USUARIO INT FOREIGN KEY REFERENCES USUARIO(ID) NOT NULL,
	NOME VARCHAR(100) NOT NULL,
	EMAIL VARCHAR(100) UNIQUE NOT NULL,
	CELULAR VARCHAR(20) UNIQUE NOT NULL,
	RA VARCHAR(50) NOT NULL,
	FOTO VARCHAR(500)
);

CREATE TABLE PROFESSOR(
	ID INT IDENTITY PRIMARY KEY,
	ID_USUARIO INT FOREIGN KEY REFERENCES USUARIO(ID) NOT NULL,
	NOME VARCHAR(100) NOT NULL,
	EMAIL VARCHAR(100) UNIQUE NOT NULL,
	CELULAR VARCHAR(20) UNIQUE NOT NULL,
	APELIDO VARCHAR(50) NOT NULL
);

CREATE TABLE DISCIPLINA(
	ID INT IDENTITY PRIMARY KEY,
	NOME VARCHAR(50) NOT NULL UNIQUE,
	DATA DATETIME NOT NULL DEFAULT (GETDATE()),
	STATUS VARCHAR(10) NOT NULL DEFAULT('ABERTA') CHECK( STATUS IN ('ABERTA', 'FECHADA') ),
	PLANO_DE_ENSINO VARCHAR(500) NOT NULL,
	CARGA_HORARIA INT NOT NULL CHECK( CARGA_HORARIA IN (40, 80) ),
	COMPETENCIAS VARCHAR(500) NOT NULL,
	HABILIDADES VARCHAR(500) NOT NULL,
	EMENTA VARCHAR(500) NOT NULL,
	CONTEUDO_PROGRAMATICO VARCHAR(500) NOT NULL,
	BIBLIOGRAFIA_BASICA VARCHAR(500) NOT NULL,
	BIBLIOGRAFIA_COMPLEMENTAR VARCHAR(500) NOT NULL,
	PERCENTUAL_PRATICO INT NOT NULL CHECK( PERCENTUAL_PRATICO >= 0 AND PERCENTUAL_PRATICO <= 100 ),
	PERCENTUAL_TEORICO INT NOT NULL CHECK( PERCENTUAL_TEORICO >= 0 AND PERCENTUAL_TEORICO <= 100 ),
	ID_COORDENADOR INT FOREIGN KEY REFERENCES COORDENADOR(ID) NOT NULL,
);

CREATE TABLE CURSO(
	ID INT IDENTITY PRIMARY KEY,
	NOME VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE DISCIPLINA_OFERTADA(
	ID INT IDENTITY PRIMARY KEY,
	ID_COORDENADOR INT FOREIGN KEY REFERENCES COORDENADOR(ID) NOT NULL,
	DT_INICIO_MATRICULA DATETIME,
	DT_FIM_MATRICULA DATETIME,
	ID_DISCIPLINA INT FOREIGN KEY REFERENCES DISCIPLINA(ID) NOT NULL,
	ID_CURSO INT FOREIGN KEY REFERENCES CURSO(ID) NOT NULL,
	ANO INT NOT NULL CHECK( ANO >= 1900 AND ANO <= 2100 ),
	SEMESTRE INT NOT NULL CHECK( SEMESTRE IN (1, 2) ),
	TURMA VARCHAR(1) NOT NULL CHECK( TURMA LIKE ( '[A-Z]' ) ),
	ID_PROFESSOR INT FOREIGN KEY REFERENCES PROFESSOR(ID),
	METODOLOGIA VARCHAR(500),
	RECURSOS VARCHAR(500),
	CRITERIO_AVALIACAO VARCHAR(500),
	PLANO_DE_AULAS VARCHAR(500),
	CONSTRAINT UQ_OFERTA UNIQUE ( ID_CURSO, ANO, SEMESTRE, TURMA )
);

CREATE TABLE SOLICITACAO_MATRICULA(
	ID INT IDENTITY PRIMARY KEY,
	ID_ALUNO INT FOREIGN KEY REFERENCES ALUNO(ID) NOT NULL,
	ID_DISCIPLINA_OFERTADA INT FOREIGN KEY REFERENCES DISCIPLINA_OFERTADA(ID) NOT NULL,
	DT_SOLICITACAO DATETIME NOT NULL DEFAULT (GETDATE()),
	ID_COORDENADOR INT FOREIGN KEY REFERENCES COORDENADOR(ID),
	STATUS VARCHAR(20) DEFAULT('SOLICITADA') CHECK( STATUS IN ('SOLICITADA', 'APROVADA', 'REJEITADA', 'CANCELADA') )

);

CREATE TABLE ATIVIDADE(
	ID INT IDENTITY PRIMARY KEY,
	TITULO VARCHAR(100) NOT NULL UNIQUE,
	DESCRICAO VARCHAR(500),
	CONTEUDO VARCHAR(100) NOT NULL,
	TIPO VARCHAR(20) NOT NULL CHECK ( TIPO IN ('RESPOSTA ABERTA', 'TESTE') ),
	EXTRAS VARCHAR(100),
	ID_PROFESSOR INT FOREIGN KEY REFERENCES PROFESSOR(ID) NOT NULL,
);

CREATE TABLE ATIVIDADE_VINCULADA(
	ID INT IDENTITY PRIMARY KEY,
	ID_ATIVIDADE INT FOREIGN KEY REFERENCES ATIVIDADE(ID) NOT NULL,
	ID_PROFESSOR INT FOREIGN KEY REFERENCES PROFESSOR(ID) NOT NULL,
	ID_DISCIPLINA_OFERTADA INT FOREIGN KEY REFERENCES DISCIPLINA_OFERTADA(ID) NOT NULL,
	ROTULO VARCHAR(50) NOT NULL,
	STATUS VARCHAR(50) NOT NULL CHECK( STATUS IN ('DISPONIBILIZADA','ABERTA','FECHADA','ENCERRADA','PRORROGADA') ),
	CONSTRAINT UQ_ATIVIDADE UNIQUE ( ID_ATIVIDADE, ID_DISCIPLINA_OFERTADA, ROTULO )
);

CREATE TABLE ENTREGA(
	ID INT IDENTITY PRIMARY KEY,
	ID_ALUNO INT FOREIGN KEY REFERENCES ALUNO(ID) NOT NULL,
	ID_ATIVIDADE_VINCULADA INT FOREIGN KEY REFERENCES ATIVIDADE_VINCULADA(ID) NOT NULL,
	TITULO VARCHAR(50) NOT NULL,
	RESPOSTA VARCHAR(500) NOT NULL,
	DT_ENTREGA DATETIME NOT NULL DEFAULT (GETDATE()),
	STATUS VARCHAR(50) NOT NULL DEFAULT('ENTREGUE') CHECK( STATUS IN ('ENTREGUE','CORRIGIDO') ),
	ID_PROFESSOR INT FOREIGN KEY REFERENCES PROFESSOR(ID),
	NOTA DECIMAL(4,2) CHECK( NOTA >= 0 AND NOTA <= 10 ),
	DT_AVALIACAO DATETIME,
	OBS VARCHAR(500),
	CONSTRAINT UQ_ENTREGA UNIQUE ( ID_ALUNO, ID_ATIVIDADE_VINCULADA )
);

CREATE TABLE MENSAGEM(
	ID INT IDENTITY PRIMARY KEY,
	ID_ALUNO INT FOREIGN KEY REFERENCES ALUNO(ID) NOT NULL,
	ID_PROFESSOR INT FOREIGN KEY REFERENCES PROFESSOR(ID) NOT NULL,
	ASSUNTO VARCHAR(50) NOT NULL,
	REFERENCIA VARCHAR(50) NOT NULL,
	CONTEUDO VARCHAR(500) NOT NULL,
	STATUS VARCHAR(50) NOT NULL DEFAULT('ENVIADO') CHECK( STATUS IN ('ENVIADO','LIDO', 'RESPONDIDO') ),
	DT_ENVIO DATETIME NOT NULL DEFAULT (GETDATE()),
	DT_REPOSTA DATETIME,
	RESPOSTA VARCHAR(500)
);

-- AC6 --- DEVERÁ SER ENTREGUE HOJE E EM UM ÚNICO SCRIPT
-- 1. INSIRA UM REGISTRO EM CADA TABELA
insert into usuario (login, senha) 
values ('usuario_1', '1');

insert into coordenador (id_usuario, nome, email, celular) 
values (1, 'coordenador_1', 'cod1@cod.com', '1');

insert into aluno (id_usuario, nome, email, celular, ra) 
values (1, 'aluno_1', 'al1@al.com', '1', '1');

insert into professor (id_usuario, nome, email, celular, apelido)
values (1, 'professor_1', 'pro1@pro.com', '1', 'prof_1');

insert into disciplina (nome, plano_de_ensino, carga_horaria, competencias, habilidades, ementa, 
	conteudo_programatico, bibliografia_basica, bibliografia_complementar, 
	percentual_pratico, percentual_teorico, id_coordenador)
values ('matematica', 'plano de ensino', 40, 'competencias', 'habilidades', 'ementa', 
	'conteudo', 'bibliografia basica', 'bibliografia complementar',
	60, 40, 1);

insert into curso (nome)
values ('Ensino Fundamental');

insert into disciplina_ofertada (id_coordenador, dt_inicio_matricula, dt_fim_matricula, id_disciplina,
	id_curso, ano, semestre, turma,
	id_professor, metodologia, recursos, criterio_avaliacao, plano_de_aulas)
values (1, getdate(), getdate()+7, 1, 
	1, 2018, 2, 'D',
	1, 'metodologia', 'recursos', 'criterio de avaliacao', 'plano de aulas');

insert into solicitacao_matricula (id_aluno, id_disciplina_ofertada, dt_solicitacao, id_coordenador)
values (1, 1, getdate(), 1);

insert into atividade (titulo, descricao, conteudo, tipo, extras, id_professor)
values ('titulo', 'descricao', 'conteudo', 'RESPOSTA ABERTA', 'extras', 1);

insert into atividade_vinculada (id_atividade, id_professor, id_disciplina_ofertada, rotulo, status)
values (1, 1, 1, 'ac1', 'DISPONIBILIZADA');

insert into entrega (id_aluno, id_atividade_vinculada, titulo, resposta, id_professor, nota, dt_avaliacao, obs)
values (1, 1, 'entrega', 'resposta', 1, 0, null, 'obs');

insert into mensagem (id_aluno, id_professor, assunto, referencia, conteudo)
values (1, 1, ' assunto', 'referencia', 'conteudo');

-- 2. CRIE UM USUARIO COM LOGIN 'EMILIO.MURTA' E SENHA '123456'
insert into usuario (login, senha)
values ('emilio.murta', '123456');

-- 3. ATUALIZE A DT_EXPIRACAO DO USUARIO PARA O DIA DE HOJE E A SENHA PARA '654321'
update usuario
set dt_expiracao=getdate(), senha='654321'
where login='emilio.murta';

-- 4. CRIE UM PROFESSOR PARA O USUARIO CRIADO (UTILIZE UM SELECT PARA DESCOBRIR O ID DO USUARIO CRIADO)
insert into professor (id_usuario, nome, email, celular, apelido)
values (2, 'emilio murta', 'emilio.murta@fit.com', 2, 'murta');

-- 5. GARANTA A EXISTENCIA DE APENAS TRES DISCIPLINAS: 'LP', 'BD2' E 'ESTATISTICA' -- TODAS COM STATUS ABERTA
delete from entrega;
delete from atividade_vinculada;
delete from solicitacao_matricula;
delete from disciplina_ofertada;
delete from disciplina;
delete from curso;
insert into disciplina (nome, plano_de_ensino, carga_horaria, competencias, habilidades, ementa, 
	conteudo_programatico, bibliografia_basica, bibliografia_complementar, 
	percentual_pratico, percentual_teorico, id_coordenador)
values 
('lp', 'plano de ensino', 40, 'competencias', 'habilidades', 'ementa', 
	'conteudo', 'bibliografia basica', 'bibliografia complementar',
	60, 40, 1),
('bd2', 'plano de ensino', 40, 'competencias', 'habilidades', 'ementa', 
	'conteudo', 'bibliografia basica', 'bibliografia complementar',
	60, 40, 1),
('estatistica', 'plano de ensino', 40, 'competencias', 'habilidades', 'ementa', 
	'conteudo', 'bibliografia basica', 'bibliografia complementar',
	60, 40, 1);

-- 6. CRIE DOIS CURSOS 'SI' E 'ADS' (FAÇA ISSO EM APENAS UMA INSTRUCAO)
insert into curso(nome) values ('SI'), ('ADS');

-- 7. OFERECA TODAS AS DISCIPLINAS EM TODOS OS CURSOS (FAÇA ISSO USANDO INSERT COM SELECT)
	-- DICA: SELECT * FROM CURSO, DISCIPLINA RETORNA O PRODUTO CARTESIANO DAS DUAS RELAÇÕES
	-- DICA2: O SELECT ABAIXO UTILIZA ROW_NUMBER PARA TRAZER O NRO DE CADA LINHA (PODE SER UTIL)
		--SELECT ROW_NUMBER() OVER(ORDER BY TABLE_NAME),--
		--	TABLE_NAME 
		--FROM INFORMATION_SCHEMA.TABLES
insert into disciplina_ofertada (id_coordenador, dt_inicio_matricula, dt_fim_matricula, id_disciplina,
	id_curso, ano, semestre, turma,
	id_professor, metodologia, recursos, criterio_avaliacao, plano_de_aulas)
select 1, getdate(), getdate()+7, disciplina.id, 
	curso.id, 2018 + (row_number() over(order by curso.id)), 1, 'A',
	1, 'metodologia', 'recursos', 'criterio de avaliacao', 'plano de aulas'
from disciplina, curso

-- 8. ATUALIZE O PROFESSOR DE TODAS AS DISCIPLINAS OFERTADAS PARA O PROFESSOR CRIADO (EMILIO.MURTA) -- UTILIZE UPDATE COM SUBSELECT
update disciplina_ofertada
set id_professor=(select id from professor where nome = 'emilio murta');

-- 9. CRIE MAIS 9 ALUNOS (FACA ISSO EM UMA INSTRUCAO APENAS)
insert into aluno (id_usuario, nome, email, celular, ra) 
values 
(1, 'aluno_2', 'al2@al.com', '2', '2'),
(1, 'aluno_3', 'al3@al.com', '3', '3'),
(1, 'aluno_4', 'al4@al.com', '4', '4'),
(1, 'aluno_5', 'al5@al.com', '5', '5'),
(1, 'aluno_6', 'al6@al.com', '6', '6'),
(1, 'aluno_7', 'al7@al.com', '7', '7'),
(1, 'aluno_8', 'al8@al.com', '8', '8'),
(1, 'aluno_9', 'al9@al.com', '9', '9'),
(1, 'aluno_10', 'al10@al.com', '10', '10');

-- 10. CRIE UMA SOLICITACAO DE MATRICULA PARA OS PRIMEIROS 5 ALUNOS NO PRIMEIRO CURSO (TODAS AS DISCIPLINAS) -- UTILIZE INSERT COM SELECT
insert into solicitacao_matricula (id_aluno, id_disciplina_ofertada, dt_solicitacao, id_coordenador)
select aluno.id, disciplina_ofertada.id, getdate(), 1
from aluno, disciplina_ofertada
where disciplina_ofertada.id_curso=3
order by aluno.id offset 0 rows fetch next 15 rows only;

-- 11. CRIE UMA SOLICITACAO DE MATRICULA PARA OS ULTIMOS 5 ALUNOS NO SEGUNDO CURSO (TODAS AS DISCIPLINAS) -- UTILIZE INSERT COM SELECT
	-- DICA: ORDER BY <ALGUMA_COISA> OFFSET 10 ROWS FETCH NEXT 5 ROWS ONLY; 
	-- ESSE COMANDO INSERIDO NO FINAL DO SELECT VAI DESPREZAR AS 10 PRIMEIRAS LINHAS E TRARÁ AS PRÓXIMAS 5
insert into solicitacao_matricula (id_aluno, id_disciplina_ofertada, dt_solicitacao, id_coordenador)
select aluno.id, disciplina_ofertada.id, getdate(), 1
from aluno, disciplina_ofertada
where disciplina_ofertada.id_curso=2
order by aluno.id offset 15 rows fetch next 15 rows only;

-- 12. CRIE 3 ATIVIDADES NOVAS (UMA PARA CADA DISCIPLINA)
insert into atividade (titulo, descricao, conteudo, tipo, extras, id_professor)
select 'titulo_' + nome, 'descricao', 'conteudo', 'RESPOSTA ABERTA', 'extras', 1
from disciplina

-- 13. VINCULE CADA ATIVIDADE EM SUA DISCIPLINA OFERTADA (UMA POR CURSO) E UTILIZANDO O PROFESSOR (EMILIO.MURTA) PARA CADA ATIVIDADE VINCULADA 
		-- DEVERÃO SER GERADAS 2 ATIVIDADES_VINCULADAS PARA CADA ATIVIDADE POIS TEMOS CADA DISCIPLINA OFERTADA EM CADA CURSO EM UM TOTAL DE 2 CURSOS
		-- FACA ESSE PROCESSO MANUALMENTE (SEM UTILIZAR INSERT COM SELECT) -- CUIDADO COM OS IDS, SE ERRAR NA INSERÇÃO FAÇA TRUNCATE DAS TABELAS 
		-- OU DROP E CRIE NOVAMENTE
insert into atividade_vinculada (id_atividade, id_professor, id_disciplina_ofertada, rotulo, status)
select a.id id_atividade,
(select id from professor where nome = 'emilio murta') id_professor,
d.id id_disciplina_ofertada, 
'AC' + convert(varchar, a.TITULO) + convert(varchar, d.id) rotulo,
'DISPONIBILIZADA'
from disciplina_ofertada d, 
	disciplina di,
	atividade a
where a.titulo like '%lp%'
	and di.id = d.ID_DISCIPLINA
	and di.NOME like '%lp%'
union
select a.id id_atividade,
(select id from professor where nome = 'emilio murta') id_professor,
d.id id_disciplina_ofertada, 
'AC' + convert(varchar, a.TITULO) + convert(varchar, d.id) rotulo,
'DISPONIBILIZADA'
from disciplina_ofertada d, 
	disciplina di,
	atividade a
where a.titulo like '%bd%'
	and di.id = d.ID_DISCIPLINA
	and di.NOME like '%bd%'
union
select a.id id_atividade,
(select id from professor where nome = 'emilio murta') id_professor,
d.id id_disciplina_ofertada, 
'AC' + convert(varchar, a.TITULO) + convert(varchar, d.id) rotulo,
'DISPONIBILIZADA'
from disciplina_ofertada d, 
	disciplina di,
	atividade a
where a.titulo like '%estat%'
	and di.id = d.ID_DISCIPLINA
	and di.NOME like '%estat%'

-- 14. CRIE UMA ENTREGA PARA CADA ALUNO PARA CADA ATIVIDADE (OS ALUNOS QUE ENTREGAREM DEVEM ESTAR MATRICULADOS NA DISCIPLINA OFERTADA)
		-- PODE FAZER MANUALMENTE OU USANDO INSERT COM SELECT
insert into entrega (id_aluno, id_atividade_vinculada, titulo, resposta)
select s.id_aluno, a.id,
'entrega av' + convert(varchar, a.id) + 'aluno' + convert(varchar, s.id_aluno),
'resposta av' + convert(varchar, a.id) + 'aluno' + convert(varchar, s.id_aluno)
from atividade_vinculada a,
disciplina_ofertada d,
solicitacao_matricula s
where a.ID_DISCIPLINA_OFERTADA = d.id
	and d.id = s.id_disciplina_ofertada
order by s.id_aluno																																																	

-- 15. INSIRA UMA MENSAGEM DE UM PROFESSOR QUALQUER PARA UM ALUNO QUALQUER -- FACA INSERT MANUAL (SEM INSERT COM SELECT)
insert into mensagem (id_aluno, id_professor, assunto, referencia, conteudo)
values(1, 1, 'assunto15', 'ref15', 'cont15');

-- 16. ATUALIZE AS NOTAS DE TODOS OS ALUNOS QUE O NOME COMEÇA COM A LETRA 'A' PARA 7
update entrega
set nota = 7
where id_aluno in (
	select id from aluno where nome like '%a%'
);

-- 17. ATUALIZE A DATA DE INICIO DE TODAS AS DISCIPLINAS OFERTADAS PARA O DIA DE HOJE
update disciplina_ofertada set dt_inicio_matricula = getdate();

-- 18. ATUALIZE A DATA DE FIM DE TODAS AS DISCIPLINAS OFERTADAS PARA O DIA DE HOJE + 7 DIAS
update disciplina_ofertada set dt_fim_matricula = getdate()+7;

-- 19. CRIE UM SCRIPT PARA APAGAR TODOS OS REGISTROS INSERIDOS EM TODAS AS TABELAS (CUIDADO COM A ORDEM DE EXECUÇÃO POR CONTA DAS FKS)
DELETE FROM MENSAGEM;
DELETE FROM ENTREGA;
DELETE FROM ATIVIDADE_VINCULADA;
DELETE FROM ATIVIDADE;
DELETE FROM SOLICITACAO_MATRICULA;
DELETE FROM DISCIPLINA_OFERTADA;
DELETE FROM CURSO;
DELETE FROM DISCIPLINA;
DELETE FROM PROFESSOR;
DELETE FROM ALUNO;
DELETE FROM COORDENADOR;
DELETE FROM USUARIO;

-- 20. APLIQUE NOVAMENTE TODOS OS PROCEDIMENTOS ANTERIORES ATÉ O PASSO 18 GARANTINDO QUE TERÃO OS MESMOS IDS
IF OBJECT_ID('MENSAGEM', 'U') IS NOT NULL
	DROP TABLE MENSAGEM
IF OBJECT_ID('ENTREGA', 'U') IS NOT NULL
	DROP TABLE ENTREGA
IF OBJECT_ID('ATIVIDADE_VINCULADA', 'U') IS NOT NULL
	DROP TABLE ATIVIDADE_VINCULADA
IF OBJECT_ID('ATIVIDADE', 'U') IS NOT NULL
	DROP TABLE ATIVIDADE
IF OBJECT_ID('SOLICITACAO_MATRICULA', 'U') IS NOT NULL
	DROP TABLE SOLICITACAO_MATRICULA
IF OBJECT_ID('DISCIPLINA_OFERTADA', 'U') IS NOT NULL
	DROP TABLE DISCIPLINA_OFERTADA
IF OBJECT_ID('CURSO', 'U') IS NOT NULL
	DROP TABLE CURSO
IF OBJECT_ID('DISCIPLINA', 'U') IS NOT NULL
	DROP TABLE DISCIPLINA
IF OBJECT_ID('PROFESSOR', 'U') IS NOT NULL
	DROP TABLE PROFESSOR
IF OBJECT_ID('ALUNO', 'U') IS NOT NULL
	DROP TABLE ALUNO
IF OBJECT_ID('COORDENADOR', 'U') IS NOT NULL
	DROP TABLE COORDENADOR
IF OBJECT_ID('USUARIO', 'U') IS NOT NULL
	DROP TABLE USUARIO
 
CREATE TABLE USUARIO(
	ID INT IDENTITY PRIMARY KEY,
	LOGIN VARCHAR(50) UNIQUE,
	SENHA VARCHAR(50) NOT NULL,
	DT_EXPIRACAO DATETIME DEFAULT ('1900-01-01')
);

CREATE TABLE COORDENADOR(
	ID INT IDENTITY PRIMARY KEY,
	ID_USUARIO INT FOREIGN KEY REFERENCES USUARIO(ID) NOT NULL,
	NOME VARCHAR(100) NOT NULL,
	EMAIL VARCHAR(100) UNIQUE NOT NULL,
	CELULAR VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE ALUNO(
	ID INT IDENTITY PRIMARY KEY,
	ID_USUARIO INT FOREIGN KEY REFERENCES USUARIO(ID) NOT NULL,
	NOME VARCHAR(100) NOT NULL,
	EMAIL VARCHAR(100) UNIQUE NOT NULL,
	CELULAR VARCHAR(20) UNIQUE NOT NULL,
	RA VARCHAR(50) NOT NULL,
	FOTO VARCHAR(500)
);

CREATE TABLE PROFESSOR(
	ID INT IDENTITY PRIMARY KEY,
	ID_USUARIO INT FOREIGN KEY REFERENCES USUARIO(ID) NOT NULL,
	NOME VARCHAR(100) NOT NULL,
	EMAIL VARCHAR(100) UNIQUE NOT NULL,
	CELULAR VARCHAR(20) UNIQUE NOT NULL,
	APELIDO VARCHAR(50) NOT NULL
);

CREATE TABLE DISCIPLINA(
	ID INT IDENTITY PRIMARY KEY,
	NOME VARCHAR(50) NOT NULL UNIQUE,
	DATA DATETIME NOT NULL DEFAULT (GETDATE()),
	STATUS VARCHAR(10) NOT NULL DEFAULT('ABERTA') CHECK( STATUS IN ('ABERTA', 'FECHADA') ),
	PLANO_DE_ENSINO VARCHAR(500) NOT NULL,
	CARGA_HORARIA INT NOT NULL CHECK( CARGA_HORARIA IN (40, 80) ),
	COMPETENCIAS VARCHAR(500) NOT NULL,
	HABILIDADES VARCHAR(500) NOT NULL,
	EMENTA VARCHAR(500) NOT NULL,
	CONTEUDO_PROGRAMATICO VARCHAR(500) NOT NULL,
	BIBLIOGRAFIA_BASICA VARCHAR(500) NOT NULL,
	BIBLIOGRAFIA_COMPLEMENTAR VARCHAR(500) NOT NULL,
	PERCENTUAL_PRATICO INT NOT NULL CHECK( PERCENTUAL_PRATICO >= 0 AND PERCENTUAL_PRATICO <= 100 ),
	PERCENTUAL_TEORICO INT NOT NULL CHECK( PERCENTUAL_TEORICO >= 0 AND PERCENTUAL_TEORICO <= 100 ),
	ID_COORDENADOR INT FOREIGN KEY REFERENCES COORDENADOR(ID) NOT NULL,
);

CREATE TABLE CURSO(
	ID INT IDENTITY PRIMARY KEY,
	NOME VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE DISCIPLINA_OFERTADA(
	ID INT IDENTITY PRIMARY KEY,
	ID_COORDENADOR INT FOREIGN KEY REFERENCES COORDENADOR(ID) NOT NULL,
	DT_INICIO_MATRICULA DATETIME,
	DT_FIM_MATRICULA DATETIME,
	ID_DISCIPLINA INT FOREIGN KEY REFERENCES DISCIPLINA(ID) NOT NULL,
	ID_CURSO INT FOREIGN KEY REFERENCES CURSO(ID) NOT NULL,
	ANO INT NOT NULL CHECK( ANO >= 1900 AND ANO <= 2100 ),
	SEMESTRE INT NOT NULL CHECK( SEMESTRE IN (1, 2) ),
	TURMA VARCHAR(1) NOT NULL CHECK( TURMA LIKE ( '[A-Z]' ) ),
	ID_PROFESSOR INT FOREIGN KEY REFERENCES PROFESSOR(ID),
	METODOLOGIA VARCHAR(500),
	RECURSOS VARCHAR(500),
	CRITERIO_AVALIACAO VARCHAR(500),
	PLANO_DE_AULAS VARCHAR(500),
	CONSTRAINT UQ_OFERTA UNIQUE ( ID_CURSO, ANO, SEMESTRE, TURMA )
);

CREATE TABLE SOLICITACAO_MATRICULA(
	ID INT IDENTITY PRIMARY KEY,
	ID_ALUNO INT FOREIGN KEY REFERENCES ALUNO(ID) NOT NULL,
	ID_DISCIPLINA_OFERTADA INT FOREIGN KEY REFERENCES DISCIPLINA_OFERTADA(ID) NOT NULL,
	DT_SOLICITACAO DATETIME NOT NULL DEFAULT (GETDATE()),
	ID_COORDENADOR INT FOREIGN KEY REFERENCES COORDENADOR(ID),
	STATUS VARCHAR(20) DEFAULT('SOLICITADA') CHECK( STATUS IN ('SOLICITADA', 'APROVADA', 'REJEITADA', 'CANCELADA') )

);

CREATE TABLE ATIVIDADE(
	ID INT IDENTITY PRIMARY KEY,
	TITULO VARCHAR(100) NOT NULL UNIQUE,
	DESCRICAO VARCHAR(500),
	CONTEUDO VARCHAR(100) NOT NULL,
	TIPO VARCHAR(20) NOT NULL CHECK ( TIPO IN ('RESPOSTA ABERTA', 'TESTE') ),
	EXTRAS VARCHAR(100),
	ID_PROFESSOR INT FOREIGN KEY REFERENCES PROFESSOR(ID) NOT NULL,
);

CREATE TABLE ATIVIDADE_VINCULADA(
	ID INT IDENTITY PRIMARY KEY,
	ID_ATIVIDADE INT FOREIGN KEY REFERENCES ATIVIDADE(ID) NOT NULL,
	ID_PROFESSOR INT FOREIGN KEY REFERENCES PROFESSOR(ID) NOT NULL,
	ID_DISCIPLINA_OFERTADA INT FOREIGN KEY REFERENCES DISCIPLINA_OFERTADA(ID) NOT NULL,
	ROTULO VARCHAR(50) NOT NULL,
	STATUS VARCHAR(50) NOT NULL CHECK( STATUS IN ('DISPONIBILIZADA','ABERTA','FECHADA','ENCERRADA','PRORROGADA') ),
	CONSTRAINT UQ_ATIVIDADE UNIQUE ( ID_ATIVIDADE, ID_DISCIPLINA_OFERTADA, ROTULO )
);

CREATE TABLE ENTREGA(
	ID INT IDENTITY PRIMARY KEY,
	ID_ALUNO INT FOREIGN KEY REFERENCES ALUNO(ID) NOT NULL,
	ID_ATIVIDADE_VINCULADA INT FOREIGN KEY REFERENCES ATIVIDADE_VINCULADA(ID) NOT NULL,
	TITULO VARCHAR(50) NOT NULL,
	RESPOSTA VARCHAR(500) NOT NULL,
	DT_ENTREGA DATETIME NOT NULL DEFAULT (GETDATE()),
	STATUS VARCHAR(50) NOT NULL DEFAULT('ENTREGUE') CHECK( STATUS IN ('ENTREGUE','CORRIGIDO') ),
	ID_PROFESSOR INT FOREIGN KEY REFERENCES PROFESSOR(ID),
	NOTA DECIMAL(4,2) CHECK( NOTA >= 0 AND NOTA <= 10 ),
	DT_AVALIACAO DATETIME,
	OBS VARCHAR(500),
	CONSTRAINT UQ_ENTREGA UNIQUE ( ID_ALUNO, ID_ATIVIDADE_VINCULADA )
);

CREATE TABLE MENSAGEM(
	ID INT IDENTITY PRIMARY KEY,
	ID_ALUNO INT FOREIGN KEY REFERENCES ALUNO(ID) NOT NULL,
	ID_PROFESSOR INT FOREIGN KEY REFERENCES PROFESSOR(ID) NOT NULL,
	ASSUNTO VARCHAR(50) NOT NULL,
	REFERENCIA VARCHAR(50) NOT NULL,
	CONTEUDO VARCHAR(500) NOT NULL,
	STATUS VARCHAR(50) NOT NULL DEFAULT('ENVIADO') CHECK( STATUS IN ('ENVIADO','LIDO', 'RESPONDIDO') ),
	DT_ENVIO DATETIME NOT NULL DEFAULT (GETDATE()),
	DT_REPOSTA DATETIME,
	RESPOSTA VARCHAR(500)
);

-- AC6 --- DEVERÁ SER ENTREGUE HOJE E EM UM ÚNICO SCRIPT
-- 1. INSIRA UM REGISTRO EM CADA TABELA
insert into usuario (login, senha) 
values ('usuario_1', '1');

insert into coordenador (id_usuario, nome, email, celular) 
values (1, 'coordenador_1', 'cod1@cod.com', '1');

insert into aluno (id_usuario, nome, email, celular, ra) 
values (1, 'aluno_1', 'al1@al.com', '1', '1');

insert into professor (id_usuario, nome, email, celular, apelido)
values (1, 'professor_1', 'pro1@pro.com', '1', 'prof_1');

insert into disciplina (nome, plano_de_ensino, carga_horaria, competencias, habilidades, ementa, 
	conteudo_programatico, bibliografia_basica, bibliografia_complementar, 
	percentual_pratico, percentual_teorico, id_coordenador)
values ('matematica', 'plano de ensino', 40, 'competencias', 'habilidades', 'ementa', 
	'conteudo', 'bibliografia basica', 'bibliografia complementar',
	60, 40, 1);

insert into curso (nome)
values ('Ensino Fundamental');

insert into disciplina_ofertada (id_coordenador, dt_inicio_matricula, dt_fim_matricula, id_disciplina,
	id_curso, ano, semestre, turma,
	id_professor, metodologia, recursos, criterio_avaliacao, plano_de_aulas)
values (1, getdate(), getdate()+7, 1, 
	1, 2018, 2, 'D',
	1, 'metodologia', 'recursos', 'criterio de avaliacao', 'plano de aulas');

insert into solicitacao_matricula (id_aluno, id_disciplina_ofertada, dt_solicitacao, id_coordenador)
values (1, 1, getdate(), 1);

insert into atividade (titulo, descricao, conteudo, tipo, extras, id_professor)
values ('titulo', 'descricao', 'conteudo', 'RESPOSTA ABERTA', 'extras', 1);

insert into atividade_vinculada (id_atividade, id_professor, id_disciplina_ofertada, rotulo, status)
values (1, 1, 1, 'ac1', 'DISPONIBILIZADA');

insert into entrega (id_aluno, id_atividade_vinculada, titulo, resposta, id_professor, nota, dt_avaliacao, obs)
values (1, 1, 'entrega', 'resposta', 1, 0, null, 'obs');

insert into mensagem (id_aluno, id_professor, assunto, referencia, conteudo)
values (1, 1, ' assunto', 'referencia', 'conteudo');

-- 2. CRIE UM USUARIO COM LOGIN 'EMILIO.MURTA' E SENHA '123456'
insert into usuario (login, senha)
values ('emilio.murta', '123456');

-- 3. ATUALIZE A DT_EXPIRACAO DO USUARIO PARA O DIA DE HOJE E A SENHA PARA '654321'
update usuario
set dt_expiracao=getdate(), senha='654321'
where login='emilio.murta';

-- 4. CRIE UM PROFESSOR PARA O USUARIO CRIADO (UTILIZE UM SELECT PARA DESCOBRIR O ID DO USUARIO CRIADO)
insert into professor (id_usuario, nome, email, celular, apelido)
values (2, 'emilio murta', 'emilio.murta@fit.com', 2, 'murta');

-- 5. GARANTA A EXISTENCIA DE APENAS TRES DISCIPLINAS: 'LP', 'BD2' E 'ESTATISTICA' -- TODAS COM STATUS ABERTA
delete from entrega;
delete from atividade_vinculada;
delete from solicitacao_matricula;
delete from disciplina_ofertada;
delete from disciplina;
delete from curso;
insert into disciplina (nome, plano_de_ensino, carga_horaria, competencias, habilidades, ementa, 
	conteudo_programatico, bibliografia_basica, bibliografia_complementar, 
	percentual_pratico, percentual_teorico, id_coordenador)
values 
('lp', 'plano de ensino', 40, 'competencias', 'habilidades', 'ementa', 
	'conteudo', 'bibliografia basica', 'bibliografia complementar',
	60, 40, 1),
('bd2', 'plano de ensino', 40, 'competencias', 'habilidades', 'ementa', 
	'conteudo', 'bibliografia basica', 'bibliografia complementar',
	60, 40, 1),
('estatistica', 'plano de ensino', 40, 'competencias', 'habilidades', 'ementa', 
	'conteudo', 'bibliografia basica', 'bibliografia complementar',
	60, 40, 1);

-- 6. CRIE DOIS CURSOS 'SI' E 'ADS' (FAÇA ISSO EM APENAS UMA INSTRUCAO)
insert into curso(nome) values ('SI'), ('ADS');

-- 7. OFERECA TODAS AS DISCIPLINAS EM TODOS OS CURSOS (FAÇA ISSO USANDO INSERT COM SELECT)
	-- DICA: SELECT * FROM CURSO, DISCIPLINA RETORNA O PRODUTO CARTESIANO DAS DUAS RELAÇÕES
	-- DICA2: O SELECT ABAIXO UTILIZA ROW_NUMBER PARA TRAZER O NRO DE CADA LINHA (PODE SER UTIL)
		--SELECT ROW_NUMBER() OVER(ORDER BY TABLE_NAME),--
		--	TABLE_NAME 
		--FROM INFORMATION_SCHEMA.TABLES
insert into disciplina_ofertada (id_coordenador, dt_inicio_matricula, dt_fim_matricula, id_disciplina,
	id_curso, ano, semestre, turma,
	id_professor, metodologia, recursos, criterio_avaliacao, plano_de_aulas)
select 1, getdate(), getdate()+7, disciplina.id, 
	curso.id, 2018 + (row_number() over(order by curso.id)), 1, 'A',
	1, 'metodologia', 'recursos', 'criterio de avaliacao', 'plano de aulas'
from disciplina, curso

-- 8. ATUALIZE O PROFESSOR DE TODAS AS DISCIPLINAS OFERTADAS PARA O PROFESSOR CRIADO (EMILIO.MURTA) -- UTILIZE UPDATE COM SUBSELECT
update disciplina_ofertada
set id_professor=(select id from professor where nome = 'emilio murta');

-- 9. CRIE MAIS 9 ALUNOS (FACA ISSO EM UMA INSTRUCAO APENAS)
insert into aluno (id_usuario, nome, email, celular, ra) 
values 
(1, 'aluno_2', 'al2@al.com', '2', '2'),
(1, 'aluno_3', 'al3@al.com', '3', '3'),
(1, 'aluno_4', 'al4@al.com', '4', '4'),
(1, 'aluno_5', 'al5@al.com', '5', '5'),
(1, 'aluno_6', 'al6@al.com', '6', '6'),
(1, 'aluno_7', 'al7@al.com', '7', '7'),
(1, 'aluno_8', 'al8@al.com', '8', '8'),
(1, 'aluno_9', 'al9@al.com', '9', '9'),
(1, 'aluno_10', 'al10@al.com', '10', '10');

-- 10. CRIE UMA SOLICITACAO DE MATRICULA PARA OS PRIMEIROS 5 ALUNOS NO PRIMEIRO CURSO (TODAS AS DISCIPLINAS) -- UTILIZE INSERT COM SELECT
insert into solicitacao_matricula (id_aluno, id_disciplina_ofertada, dt_solicitacao, id_coordenador)
select aluno.id, disciplina_ofertada.id, getdate(), 1
from aluno, disciplina_ofertada
where disciplina_ofertada.id_curso=3
order by aluno.id offset 0 rows fetch next 15 rows only;

-- 11. CRIE UMA SOLICITACAO DE MATRICULA PARA OS ULTIMOS 5 ALUNOS NO SEGUNDO CURSO (TODAS AS DISCIPLINAS) -- UTILIZE INSERT COM SELECT
	-- DICA: ORDER BY <ALGUMA_COISA> OFFSET 10 ROWS FETCH NEXT 5 ROWS ONLY; 
	-- ESSE COMANDO INSERIDO NO FINAL DO SELECT VAI DESPREZAR AS 10 PRIMEIRAS LINHAS E TRARÁ AS PRÓXIMAS 5
insert into solicitacao_matricula (id_aluno, id_disciplina_ofertada, dt_solicitacao, id_coordenador)
select aluno.id, disciplina_ofertada.id, getdate(), 1
from aluno, disciplina_ofertada
where disciplina_ofertada.id_curso=2
order by aluno.id offset 15 rows fetch next 15 rows only;

-- 12. CRIE 3 ATIVIDADES NOVAS (UMA PARA CADA DISCIPLINA)
insert into atividade (titulo, descricao, conteudo, tipo, extras, id_professor)
select 'titulo_' + nome, 'descricao', 'conteudo', 'RESPOSTA ABERTA', 'extras', 1
from disciplina

-- 13. VINCULE CADA ATIVIDADE EM SUA DISCIPLINA OFERTADA (UMA POR CURSO) E UTILIZANDO O PROFESSOR (EMILIO.MURTA) PARA CADA ATIVIDADE VINCULADA 
		-- DEVERÃO SER GERADAS 2 ATIVIDADES_VINCULADAS PARA CADA ATIVIDADE POIS TEMOS CADA DISCIPLINA OFERTADA EM CADA CURSO EM UM TOTAL DE 2 CURSOS
		-- FACA ESSE PROCESSO MANUALMENTE (SEM UTILIZAR INSERT COM SELECT) -- CUIDADO COM OS IDS, SE ERRAR NA INSERÇÃO FAÇA TRUNCATE DAS TABELAS 
		-- OU DROP E CRIE NOVAMENTE
insert into atividade_vinculada (id_atividade, id_professor, id_disciplina_ofertada, rotulo, status)
select a.id id_atividade,
(select id from professor where nome = 'emilio murta') id_professor,
d.id id_disciplina_ofertada, 
'AC' + convert(varchar, a.TITULO) + convert(varchar, d.id) rotulo,
'DISPONIBILIZADA'
from disciplina_ofertada d, 
	disciplina di,
	atividade a
where a.titulo like '%lp%'
	and di.id = d.ID_DISCIPLINA
	and di.NOME like '%lp%'
union
select a.id id_atividade,
(select id from professor where nome = 'emilio murta') id_professor,
d.id id_disciplina_ofertada, 
'AC' + convert(varchar, a.TITULO) + convert(varchar, d.id) rotulo,
'DISPONIBILIZADA'
from disciplina_ofertada d, 
	disciplina di,
	atividade a
where a.titulo like '%bd%'
	and di.id = d.ID_DISCIPLINA
	and di.NOME like '%bd%'
union
select a.id id_atividade,
(select id from professor where nome = 'emilio murta') id_professor,
d.id id_disciplina_ofertada, 
'AC' + convert(varchar, a.TITULO) + convert(varchar, d.id) rotulo,
'DISPONIBILIZADA'
from disciplina_ofertada d, 
	disciplina di,
	atividade a
where a.titulo like '%estat%'
	and di.id = d.ID_DISCIPLINA
	and di.NOME like '%estat%'

-- 14. CRIE UMA ENTREGA PARA CADA ALUNO PARA CADA ATIVIDADE (OS ALUNOS QUE ENTREGAREM DEVEM ESTAR MATRICULADOS NA DISCIPLINA OFERTADA)
		-- PODE FAZER MANUALMENTE OU USANDO INSERT COM SELECT
insert into entrega (id_aluno, id_atividade_vinculada, titulo, resposta)
select s.id_aluno, a.id,
'entrega av' + convert(varchar, a.id) + 'aluno' + convert(varchar, s.id_aluno),
'resposta av' + convert(varchar, a.id) + 'aluno' + convert(varchar, s.id_aluno)
from atividade_vinculada a,
disciplina_ofertada d,
solicitacao_matricula s
where a.ID_DISCIPLINA_OFERTADA = d.id
	and d.id = s.id_disciplina_ofertada
order by s.id_aluno																																																	

-- 15. INSIRA UMA MENSAGEM DE UM PROFESSOR QUALQUER PARA UM ALUNO QUALQUER -- FACA INSERT MANUAL (SEM INSERT COM SELECT)
insert into mensagem (id_aluno, id_professor, assunto, referencia, conteudo)
values(1, 1, 'assunto15', 'ref15', 'cont15');

-- 16. ATUALIZE AS NOTAS DE TODOS OS ALUNOS QUE O NOME COMEÇA COM A LETRA 'A' PARA 7
update entrega
set nota = 7
where id_aluno in (
	select id from aluno where nome like '%a%'
);

-- 17. ATUALIZE A DATA DE INICIO DE TODAS AS DISCIPLINAS OFERTADAS PARA O DIA DE HOJE
update disciplina_ofertada set dt_inicio_matricula = getdate();

-- 18. ATUALIZE A DATA DE FIM DE TODAS AS DISCIPLINAS OFERTADAS PARA O DIA DE HOJE + 7 DIAS
update disciplina_ofertada set dt_fim_matricula = getdate()+7;


-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--   SUA AC8 A PARTIR DESTE PONTO
--   CRIE O DQL PARA GERAR OS RELATORIOS SOLICITADOS
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
---
-- Para Coordenador: Total de alunos por disciplinaOfertada ( mesmo que não tenha alunos ).
---

SELECT SM.ID_DISCIPLINA_OFERTADA, DO.ID, COUNT(SM.ID_DISCIPLINA_OFERTADA)
FROM SOLICITACAO_MATRICULA SM
LEFT JOIN DISCIPLINA_OFERTADA DO ON SM.ID_DISCIPLINA_OFERTADA = DO.ID
GROUP BY SM.ID_DISCIPLINA_OFERTADA, DO.ID


---
-- Para Aluno: Dado 1 aluno, calcular sua Media por Disciplina ofertada 
-- ( média simples das Acs, atividades não entregues terão nota = 0).
---


SELECT	A.ID AS IDALUNO, DO.ID AS IDDISCIPLINA_OFERTADA, AVG(E.NOTA) AS MEDIA_PONDERADA
		--A.ID AS IDALUNO, A.NOME,
		--DO.ID AS IDDICIPLINA_OFERTADA,
		--D.NOME,
		--AV.ID AS IDATIVIDADE_VINCULADA
		
		--,E.ID AS IDENTREGA, E.TITULO, E.NOTA
FROM ALUNO A
INNER JOIN SOLICITACAO_MATRICULA SM ON A.ID = SM.ID_ALUNO 
INNER JOIN DISCIPLINA_OFERTADA DO ON SM.ID_DISCIPLINA_OFERTADA = DO.ID
INNER JOIN DISCIPLINA D ON DO.ID_DISCIPLINA = D.ID 
INNER JOIN ATIVIDADE_VINCULADA AV ON DO.ID = AV.ID_DISCIPLINA_OFERTADA
LEFT JOIN ENTREGA E ON A.ID = E.ID_ALUNO
GROUP BY E.NOTA, A.ID, DO.ID
---
-- Para Professor: Lista de alunos e seu status [aprovado/reprovado] por disciplinaOfertada. 
-- (usar média simples das Acs ) [Desafio: só considerar as 7 melhores notas ].
---

SELECT	A.ID AS IDALUNO, DO.ID AS IDDISCIPLINA_OFERTADA,
		AVG(E.NOTA) AS MEDIA_PONDERADA, CASE 
											WHEN AVG(E.NOTA) >= 7 then 'APROVADO'   
											ELSE 'REPROVADO'
										end as STATUS
		--A.ID AS IDALUNO, A.NOME,
		--DO.ID AS IDDICIPLINA_OFERTADA,
		--D.NOME,
		--AV.ID AS IDATIVIDADE_VINCULADA
		
		--,E.ID AS IDENTREGA, E.TITULO, E.NOTA
FROM ALUNO A
INNER JOIN SOLICITACAO_MATRICULA SM ON A.ID = SM.ID_ALUNO 
INNER JOIN DISCIPLINA_OFERTADA DO ON SM.ID_DISCIPLINA_OFERTADA = DO.ID
INNER JOIN DISCIPLINA D ON DO.ID_DISCIPLINA = D.ID 
INNER JOIN ATIVIDADE_VINCULADA AV ON DO.ID = AV.ID_DISCIPLINA_OFERTADA
LEFT JOIN ENTREGA E ON A.ID = E.ID_ALUNO
GROUP BY E.NOTA, A.ID, DO.ID

---
-- Para Coordenador: Média da diferença em dias, entre a data de entrega dos trabalhos e a
-- data da correção do professor, por disciplinaOfertada. ( se não entregue, assumir data atual ).
---

SELECT	A.ID AS IDALUNO, E.DT_ENTREGA AS ENTREGA, 
		E.DT_AVALIACAO AS AVALIACAO, DO.ID AS IDDISCIPLINA_OFERTADA,
		AVG(DATEDIFF(DAY , E.DT_ENTREGA, ISNULL(E.DT_AVALIACAO, GETDATE()))) AS MEDIA
		--A.ID AS IDALUNO, A.NOME,
		--DO.ID AS IDDICIPLINA_OFERTADA,
		--D.NOME,
		--AV.ID AS IDATIVIDADE_VINCULADA
		
		--,E.ID AS IDENTREGA, E.TITULO, E.NOTA
FROM ALUNO A
INNER JOIN SOLICITACAO_MATRICULA SM ON A.ID = SM.ID_ALUNO 
INNER JOIN DISCIPLINA_OFERTADA DO ON SM.ID_DISCIPLINA_OFERTADA = DO.ID
INNER JOIN DISCIPLINA D ON DO.ID_DISCIPLINA = D.ID 
INNER JOIN ATIVIDADE_VINCULADA AV ON DO.ID = AV.ID_DISCIPLINA_OFERTADA
LEFT JOIN ENTREGA E ON A.ID = E.ID_ALUNO
GROUP BY E.NOTA, A.ID, DO.ID, E.DT_ENTREGA, E.DT_AVALIACAO