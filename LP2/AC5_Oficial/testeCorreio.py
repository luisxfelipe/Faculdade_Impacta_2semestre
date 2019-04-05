from cliente import Cliente
from servidor import Servidor
from mensagem import Mensagem
from dns import DNS

dns = DNS()
s1 = Servidor('gmail', dns)
s2 = Servidor('hotmail', dns)
s3 = Servidor('yahoo', dns)
dns.cadastrarServidor('gmail', s1)
dns.cadastrarServidor('hotmail', s2)
dns.cadastrarServidor('yahoo', s3)


c1 = Cliente('Luis', '123424', s1)
c2 = Cliente('Gustavo', '123424', s2)
c3 = Cliente('João', '123424', s3)

s1.cadastrarCliente(c1)
s2.cadastrarCliente(c2)
s3.cadastrarCliente(c3)

m1 = Mensagem('João', 'Luis', s1,'Aula do Menezes', \
             'Luís, hoje a aula vai ser maneira!!!!!')

m2 = Mensagem('Luis', 'Gustavo', s2 ,'Aula LP2', \
             'Gustavo, se prepara porque o joão folou que a aula vai der dahora!')

m3 = Mensagem('Gustavo', 'João',s3 ,'Aula de Python', \
             'João, como assim a aula vai ser maneira vai ser dificil?')

