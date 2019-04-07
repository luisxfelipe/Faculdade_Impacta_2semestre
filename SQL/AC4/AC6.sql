-- 1. Retorne os dados de alunos e seus respectivos usuários:
-- + aluno: nome, email, ra
-- + usuario: login, dt_expiracao
SELECT		A.NOME, A.EMAIL, A.RA,
			U.LOGIN, U.DT_EXPIRACAO
FROM		ALUNO A
INNER JOIN	USUARIO U ON A.ID_USUARIO = U.ID

-- 2. Retorne todos os alunos e suas respectivas matriculas nas disciplinas
-- + aluno: nome, ra
-- + disciplina: nome, status
-- + matricula: dt_solicitacao, status
SELECT		A.NOME, A.RA,
			SM.DT_SOLICITACAO, SM.STATUS
FROM		ALUNO A
INNER JOIN	SOLICITACAO_MATRICULA SM ON A.ID = SM.ID_ALUNO

-- 3. Adicione os dados do coordenador e professor da disciplina na qual o aluno 
-- está tentando se matricular
-- + aluno: nome, ra
-- + disciplina: nome, status
-- + matricula: dt_solicitacao, status
-- + professor: nome, email
-- + coordenador: nome, email

SELECT		A.NOME, A.RA,
			D.NOME, D.STATUS,
			SM.DT_SOLICITACAO, SM.STATUS,
			P.NOME, P.EMAIL,
			C.NOME, C.EMAIL
FROM		ALUNO A
INNER JOIN	SOLICITACAO_MATRICULA SM ON A.ID = SM.ID_ALUNO
INNER JOIN	DISCIPLINA_OFERTADA DF ON DF.ID_DISCIPLINA = SM.ID_DISCIPLINA_OFERTADA
INNER JOIN	DISCIPLINA D ON D.ID = DF.ID_DISCIPLINA
INNER JOIN	PROFESSOR P ON DF.ID_PROFESSOR = P.ID
INNER JOIN  COORDENADOR C ON  DF.ID_COORDENADOR = C.ID

-- 4. Execute o script abaixo (delete) e retorne os alunos que não fizeram entregas desejadas
-- DICA: O aluno está matriculado em disciplina que foi ofertada e tem atividade vinculada porém não tem entrega
--

delete from entrega where id = 31
		
SELECT		A.NOME, A.RA,
			SM.*,
			AV.ROTULO,
			E.DT_ENTREGA
FROM		ALUNO A
INNER JOIN	SOLICITACAO_MATRICULA SM ON A.ID = SM.ID_ALUNO
INNER JOIN DISCIPLINA_OFERTADA DO ON SM.ID_DISCIPLINA_OFERTADA = DO.ID
INNER JOIN ATIVIDADE_VINCULADA AV ON SM.ID_DISCIPLINA_OFERTADA = AV.ID_DISCIPLINA_OFERTADA
FULL JOIN ENTREGA E ON SM.ID_ALUNO = E.ID_ALUNO 




