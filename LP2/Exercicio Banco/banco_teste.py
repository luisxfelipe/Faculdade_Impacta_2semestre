#Teste Banco
from banco import Cliente, Conta, ContaPoupanca, ContaCorrente, Banco

fulano = Cliente('fulano', 9999999, 'fulano@gmail.com')

bb = Banco('Banco Teste')

bb.abre_cp([fulano], 500)




