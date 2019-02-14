'''
Monte uma função quebra em dois 
que recebe uma lista L e um numero D

Ela devolve duas listas: uma dos numeros de L menores que D
e a outra, dos numeros de L maiores que D.

Se L tiver algum números igual a D, ele deve ser colocado na segunda lista
'''

def quebra_em_dois(lista,divisor):
    maiores = []
    menores = []

    for x in lista:
        if x < divisor:
            menores.append(x)
        else:
            maiores.append(x)
            
    return menores, maiores
