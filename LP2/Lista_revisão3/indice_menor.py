'''implemente uma funcao indice_menor, 
que recebe uma lista e devolve o indice do seu menor elemento. 
Se houver mais de um menor elemento, retorna o indice menor.
por exemplo, a=[2,3,1] indice_menor(a) retorna 2, pois a[2]==1'''
def indice_menor(lista):
    menor = lista[0]
    ind_menor = 0

    for i in range(1, len(lista)):
        if lista[i] < menor:
            menor = lista[i]
            ind_menor = lista[i]
    return ind_menor
