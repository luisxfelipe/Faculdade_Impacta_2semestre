from typing import List

__alunos__ = ['aluno1@aluno.faculdadeimpacta.com.br',
              'aluno2@aluno.faculdadeimpacta.com.br']


class Pessoa:
    '''
    Abstração de pessoa:
    '''
    def __init__(self, nome: str, idade: int):
        self.nome = nome
        self.idade = idade


class Funcionario(Pessoa):
    '''
    Classe Abstrata funcionário.
    '''
    def calcula_salario(self) -> float:
        '''
        Calcula o salário do Mês para o funcionário
        '''
        raise NotImplementedError

    def altera_carga_horaria(self, nova_carga_horaria: int) -> None:
        '''
        altera a carga horária do funcionário, respeitando o limite,
        de horas por categoria.
        Caso o numero informado seja inválido, da raise em um ValueError
        '''
        raise NotImplementedError

    def consulta_carga_horaria(self) -> int:
        '''
        Devolve a carga horária de trabalho do funcionário
        '''
        raise NotImplementedError

    def aumenta_salario(self) -> None:
        '''
        Da um aumento de 5% no valor da hora trabalhada para o funcionário
        '''
        raise NotImplementedError

class Programador(Funcionario):
    '''
    Funcionário do tipo programador, salario base por hora 35,00.
    Regime de trabalho deve estar entre 20 e 40h semanais,
    caso contrário devolve um ValueError.
    Para efeito de cálculo de pagamento o mês possui 4,5 semanas
    '''
    def __init__(self, nome: str, idade: int, email: str,
                 carga_horaria_semanal: int = 40, salario: float = 35):
        super().__init__(nome, idade)
        self.email = email
        self.carga_horaria_semanal = carga_horaria_semanal
        self.salario = salario

    def calcula_salario(self) -> float:
        '''
        Calcula o salário do Mês para o funcionário
        '''
        return (self.carga_horaria_semanal * self.salario) * 4.5

    def altera_carga_horaria(self, nova_carga_horaria: int) -> None:
        '''
        altera a carga horária do funcionário, respeitando o limite,
        de horas por categoria.
        Caso o numero informado seja inválido, da raise em um ValueError
        '''
        
        if nova_carga_horaria >= 20 and nova_carga_horaria <= 40:
               self.carga_horaria_semanal = nova_carga_horaria
        else:
            return ValueError

    def consulta_carga_horaria(self) -> int:
        '''
        Devolve a carga horária de trabalho do funcionário
        '''
        return self.carga_horaria_semanal

    def aumenta_salario(self) -> None:
        '''
        Da um aumento de 5% no valor da hora trabalhada para o funcionário
        '''
        self.salario += (self.salario / 100) * 5

        


class Estagiario(Funcionario):
    '''
    Funcionário do tipo estagiário, salario base por hora 15,50
    e auxilio alimentação de 250 reais por mês.
    Regime de trabalho deve estar entre 16h e 30h semanais,
    caso contrário da raise em um ValueError.
    Para efeito de cálculo de salário o mês possui 4,5 semanas
    '''
    def __init__(self, nome: str, idade: int, email: str,
                 carga_horaria_semanal: int = 20, salario: float = 15.50):
        super().__init__(nome, idade)
        self.email = email
        self.carga_horaria_semanal = carga_horaria_semanal
        self.salario = salario

    def calcula_salario(self) -> float:
        '''
        Calcula o salário do Mês para o funcionário
        '''
        return ((self.carga_horaria_semanal * self.salario) * 4.5) + 250

    def altera_carga_horaria(self, nova_carga_horaria: int) -> None:
        '''
        altera a carga horária do funcionário, respeitando o limite,
        de horas por categoria.
        Caso o numero informado seja inválido, da raise em um ValueError
        '''
        
        if nova_carga_horaria >= 16 and nova_carga_horaria <= 30:
            self.carga_horaria_semanal = nova_carga_horaria
        else:
            return ValueError

    def consulta_carga_horaria(self) -> int:
        '''
        Devolve a carga horária de trabalho do funcionário
        '''
        return self.carga_horaria_semanal

    def aumenta_salario(self) -> None:
        '''
        Da um aumento de 5% no valor da hora trabalhada para o funcionário
        '''
        self.salario += (self.salario / 100) * 5


class Empresa:
    '''
    Classe empresa, gerencia diversos funcionários
    '''
    def __init__(self, nome: str, cnpj: int, area_atuacao: str,
                 equipe: List[Funcionario] = []):
        self.nome = nome
        self.cnpj = cnpj
        self.area_atuacao = area_atuacao
        self.equipe = equipe

    def contrata(self, novo_funcionario: Funcionario) -> None:
        '''
        Contrata um novo funcionário para a empresa
        '''
        self.equipe.append(novo_funcionario)

    def lista_fucionarios(self) -> List[Funcionario]:
        '''
        Devolve um lista com todos os funcionarios
        '''
        return self.equipe

    def folha_pagamento(self) -> float:
        '''
        Devolve o montante total gasto com pagamento dos funcionários
        '''

        i = 0

        montante = 0

        List = self.equipe

        for i in range(len(List)):
            a = List[i].calcula_salario()
            montante = montante + a

        return montante

    def dissidio_anual(self) -> None:
        '''
        Aumenta o valor da hora trabalhada em 5% para todos os funcionários
        '''

        for func in self.equipe:
            func.aumenta_salario()

 










            
