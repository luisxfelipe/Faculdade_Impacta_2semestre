from typing import List, Union
Number = Union[int, float]

"""
1) Termine os métodos  calcula_juros()  e  saque(valor) da
   classe ContaPoupanca
   
2) Termine o método  calcula_juros() da classe ContaCorrente

3) Adicione um atributo à classe Conta chamado _operacoes:
    self._operacoes = []
   Ele servirá para guardar um extrato de todos as operações
   realizadas como saque, depósito, cobrança de juros,
   depósito de juros, etc.
   Você poderá registrar as operações assim:

    def saque(self, valor):
        self._saldo -= valor
        self._operacoes.append({'saque': valor})
"""

class Cliente:
    '''
    Classe Cliente do Módulo do Banco
    '''
    def __init__(self, nome: str, telefone: int, email: str) -> None:
        self._nome = nome
        self._tel = telefone
        self._email = email

    def get_nome(self) -> str:
        '''
        Acessor do atributo Nome
        '''
        return self._nome

    def get_telefone(self) -> int:
        '''
        Acessor do atributo Telefone
        '''
        return self._tel

    def set_telefone(self, novo_telefone: int) -> None:
        '''
        Mutador do atributo Telefone
        '''
        if not type(novo_telefone) == int:
            raise TypeError
        else:
            self._tel = novo_telefone

    def get_email(self) -> str:
        '''
        Acessor do atributo E-mail
        '''
        return self._email

    def set_email(self, novo_email) -> None:
        '''
        Mutador do atributo E-mail
        '''
        if '@' not in novo_email:
            raise ValueError
        self._email = novo_email


class Conta:
    '''
    Conta básica
    '''
    def __init__(self, clientes: List[Cliente],
                 numero_conta: int, saldo_inicial: Number):
        self._clientes = clientes
        self._numero = numero_conta
        if saldo_inicial < 0:
            raise ValueError
        self._saldo = saldo_inicial

    def get_clientes(self) -> List[Cliente]:
        '''
        Acessor Clientes
        '''
        return self._clientes

    def get_numero_conta(self) -> int:
        '''
        Acessor Número da Conta
        '''
        return self._numero

    def get_saldo(self) -> Number:
        '''
        Acessor Saldo
        '''
        return self._saldo

    def set_saldo(self, novo_saldo: Number) -> None:
        self._saldo = novo_saldo

    def deposito(self, valor: Number) -> None:
        self._saldo += valor

    def saque(self, valor: Number) -> None:
        self._saldo -= valor


class ContaPoupanca(Conta):
    '''
    Conta Poupança
    '''
    def __init__(self, clientes: List[Cliente], numero_conta: int,
                 saldo_inicial: Number, taxa_juros: float):
        super().__init__(clientes, numero_conta, saldo_inicial)
        self._juros = taxa_juros

    def calcula_juros(self) -> None:
        # calcule os juros recebidos e atualize o saldo
        pass

    def saque(self, valor):
        # caso o saldo não seja suficiente, lance uma
        # exceção ValueError, senão chame o método saque
        # da classe pai
        if valor > saldo_inicial:
            raise ValueError
        else:
            super.saque(valor)
        


class ContaCorrente(Conta):
    '''
    classe conta corrente
    '''
    def __init__(self, clientes, numero_conta, saldo_inicial, juros, limite):
        super().__init__(clientes, numero_conta, saldo_inicial)
        self._juros = juros
        self._limite = limite

    def calcula_juros(self):
        # caso minha conta esteja negativa, calcule os
        # juros devidos e atualize o saldo
        pass


class Banco:
    def __init__(self, nome):
        self.nome = nome
        self._contas = []

    def abre_cc(self, clientes, saldo_inicial):
        cc = ContaCorrente(clientes, len(self._contas) + 1,
                           saldo_inicial, 0.1, 100)
        self._contas.append(cc)

    def abre_cp(self, clientes, saldo_inicial):
        cp = ContaPoupanca(clientes, len(self._contas) + 1,
                           saldo_inicial, 0.01)
        self._contas.append(cp)

    def calcula_juros(self):
        for conta in self._contas:
            conta.calcula_juros()

    def mostra_saldos(self):
        for conta in self._contas:
            print(f'{conta.get_numero_conta()}: {conta.get_saldo()}')


'''
fulano = Cliente('fulano', 9999999, 'fulano@gmail.com')

bb = Banco('Meu Banco')

bb.abre_cc([fulano], 100)
bb.abre_cp([fulano], 300)
bb.abre_cc([fulano], 0)
bb._contas[2].saque(50)

bb.mostra_saldos()
bb.calcula_juros()
bb.mostra_saldos()
'''
