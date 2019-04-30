from typing import List

__alunos__ = ['aluno1@aluno.faculdadeimpacta.com.br',
              'aluno2@aluno.faculdadeimpacta.com.br']

########################################################################
class Pessoa:
    '''
    Abstração de pessoa:
    '''
    def __init__(self, nome: str, idade: int):
        self.nome = nome
        self.idade = idade
########################################################################

class Funcionario(Pessoa):
    
    '''
    Classe Abstrata funcionário.
    '''
    def calcula_salario(self) -> float:
        '''
        Calcula o salário do Mês para o funcionário
        '''
        #raise NotImplementedError

        return (self.carga_horaria_semanal * 35) * 4.5
       

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
                 carga_horaria_semanal: int = 40):
        self.nome = nome
        self.idade = idade
        self.email = email
        self.carga_horaria_semanal = carga_horaria_semanal
        


class Estagiario(Funcionario):
    '''
    Funcionário do tipo estagiário, salario base por hora 15,50
    e auxilio alimentação de 250 reais por mês.
    Regime de trabalho deve estar entre 16h e 30h semanais,
    caso contrário da raise em um ValueError.
    Para efeito de cálculo de salário o mês possui 4,5 semanas
    '''
    def __init__(self, nome: str, idade: int, email: str,
                 carga_horaria_semanal: int = 20):
        self.nome = nome
        self.idade = idade
        self.email = email
        self.carga_horaria_semanal = carga_horaria_semanal  


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

    def folha_pagamento(self) -> float:
        '''
        Devolve o montante total gasto com pagamento dos funcionários
        '''
        pass

    def dissidio_anual(self) -> None:
        '''
        Aumenta o valor da hora trabalhada em 5% para todos os funcionários
        '''
        
