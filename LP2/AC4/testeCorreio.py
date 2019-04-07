from cliente import Cliente
from servidor import Servidor
from mensagem import Mensagem

c = Cliente('Yago', '123456', 'gmail')
s = Servidor('gmail')
s.cadastrarCliente(c)
c = Cliente('Thays', '345678', 'gmail')
s.cadastrarCliente(c)
m = Mensagem('Yago', 'Thays', 'Aula do Menezes', \
             'Thays, hoje a aula vai ser maneira!!!!!')
s.receberMensagem(m, '123456') #senha correta
print("Primeiro envio: tamanho da lista = ", len(s.getMensagens()))

s.receberMensagem(m, '123') #senha errada
print("Segundo envio: tamanho da lista = ", len(s.getMensagens()))
