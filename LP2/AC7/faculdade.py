class Disciplina:
    '''    
    Abstração de uma disciplinai, possui os atributos Nome e carga Horária
    '''
    def __init__(self, nome: str, carga_horaria: int) -> None:
        self._nome = nome
        self._carga_horaria = carga_horaria
        
    def get_nome(self) -> str:
        '''
        Acessor do atributo nome
        '''
        return self._nome
    
    def get_carga_horaria(self) -> int:
        '''
        Acessor do atributo cargar horaria
        '''
        return self._carga_horaria
    
class Pessoa:
    '''
    Abstração de uma pessoa no Modelo, classe base para Aluno e Professor
    que contém dados pertencentes a ambos.
    '''
    def __init__(self, nome: str, telefone: int, email: float) -> None:
        self._nome = nome
        self._telefone = telefone
        self._email = email
    def get_nome(self) -> str:
        '''
        Acessor do atributo Nome
        '''
        return self._nome
    
    def get_telefone(self) -> int:
        '''
        Acessor do atributo telefone
        '''
        return self._telefone
    def set_telefone(self, novo_telefone: int) -> None:
        '''
        Mutador do atributo telefone deve checar se é um número inteiro e,
        caso contrário devolver um TypeError
        '''

        if type(novo_telefone) == int:
            self._telefone = novo_telefone
            return novo_telefone 
        else:
            return TypeError
        
    def get_email(self) -> str:
        '''
        Acessor do atributo email
        '''
        return self._email
    
    def set_email(self, novo_email) -> None:
        '''
        Mutador do atributo email, deve checar se é um email válido
        (se possuir o caractere '@') e caso contrário devolver
        um ValueError
        '''

        teste = 0

        a = str(novo_email)

        i = 0
        
        for i in range(len(a)):
            
            if a[i] == '@':
                teste = 1
            
            i += 1

        if teste == 1:
            self._email = novo_email
        else:
            return 'Valor inválido (@ não foi encontrado no email)'
            
        
class Aluno(Pessoa):
    def __init__(self, nome: str, telefone: int,
                 email: str, n_matricula: int) -> None:
        Pessoa.__init__(self, nome, telefone, email)
        self._n_matricula = n_matricula
        self.lista_disciplina = []

    def get_nome(self):
        '''
        Acessor do atributo nome
        '''
        return self._nome

    def get_email(self):
        '''
        Acessor do atributo email
        '''
        return self._email

    def get_telefone(self):
        '''
        Acessor do atributo telefone
        '''
        return self._telefone
        
    def get_matricula(self) -> int:    
        '''
        Acessor do atributo matricula
        '''
        return self._n_matricula
    
    def matricular(self, disciplina: Disciplina) -> None:
        '''
        Realiza matrícula do Aluno na disciplina
        '''
        self.lista_disciplina.append(disciplina)
        
    def lista_disciplinas(self) -> list:
        '''
        Devolve a lista de disciplinas em que o aluno esta matriculado
        '''
        '''
        lista = []
        lista = self.lista_disciplina

        return lista

        '''
        i = 0

        
        for i in range(len(self.lista)):
            
            return self.lista[i]
            
            i += 1
       

        
class Professor(Pessoa):
    '''
    Entidade professor do Modelo
    '''
    def __init__(self, nome: str, telefone: int,
                 email: str) -> None:
        Pessoa.__init__(self, nome, telefone, email)
        self.lista_disciplina = []
    
    '''
    '  Metodos GET
    '''
    def get_nome(self):
        '''
        Acessor do atributo nome
        '''
        return self._nome

    def get_email(self):
        '''
        Acessor do atributo email
        '''
        return self._email

    def get_telefone(self):
        '''
        Acessor do atributo telefone
        '''
        return self._telefone
        
    def ministra(self, disciplina: Disciplina) -> None:
        '''
        Atribui o professor como ministrante da disiciplina
        Um professor não pode dar mais de 200 horas de aula,
        Caso um professor tente atribuir mais de 200h devolve
        ValueError
        '''
        self.lista_disciplina.append(disciplina)
    def lista_disciplinas(self) -> list:
        '''
        lista as disciplinas ministradas pelo professor
        '''
        i = 0
        
        for i in range(len(self.lista_disciplina)):
            
            return self.lista_disciplina[i]
            
            i += 1
