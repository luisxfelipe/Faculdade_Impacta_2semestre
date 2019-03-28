from cliente import Cliente
from servidor import Servidor
from mensagem import Mensagem

s1 = Servidor('gmail')
c1 = Cliente('Yago', '123456', s1)
s1.cadastrarCliente(c1)

s2 = Servidor('hotmail')
c2 = Cliente('Luis', '123424', s2)
s2.cadastrarCliente(c2)

s3= Servidor('outlook')
c3 = Cliente('Thays', '345678', s3)
s3.cadastrarCliente(c3)

m1 = Mensagem('Yago', 'Thays', 'Aula do Menezes', \
             'Thays, hoje a aula vai ser maneira!!!!!')
m2 = Mensagem('Yago', 'Thays', 'teste para ser apagado', \
             'Thays, tem que apagar!!!!!')



c1.enviarMensagem(m1)

'''
s.receberMensagem(m, '123456') #senha correta
print("Primeiro envio: tamanho da lista = ", len(s.getMensagens()))

s.receberMensagem(m, '123') #senha errada
print("Segundo envio: tamanho da lista = ", len(s.getMensagens()))

'''
