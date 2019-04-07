from figura import Figura
from quadrado import Quadrado
from circulo import Circulo

#Criandos os objetos circulo
c1 = Circulo(15) 
c2 = Circulo(20) 
c3 = Circulo(28)

#Criandos os objetos quadrado
q1 = Quadrado(15)
q2 = Quadrado(20)
q3 = Quadrado(28)
 
print('A area do 1º circulo é: ', c1.calculaArea())
print('A area do 2º circulo é: ', c2.calculaArea())
print('A area do 3º circulo é: ', c3.calculaArea())

resultado1 = float(c1.calculaArea())

resultado2 = float(c2.calculaArea())

resultado3 = float(c3.calculaArea())

if (resultado1 == 706.5 and resultado2 == 1256.0 and resultado3 == 2461.76):
    print("\nO teste de circulo está correto")
else:
    print("\nO teste de circulo está errado")


print('\nA area do 1º quadrado é: ', q1.calculaArea())
print('A area do 2º quadrado é: ', q2.calculaArea())
print('A area do 3º quadrado é: ', q3.calculaArea())

resultado4 = float(q1.calculaArea())

resultado5 = float(q2.calculaArea())

resultado6 = float(q3.calculaArea())

if (resultado4 == 30 and resultado5 == 40.0 and resultado6 == 56.0):
    print("\nO teste de circulo está correto")
else:
    print("\nO teste de circulo está errado")



