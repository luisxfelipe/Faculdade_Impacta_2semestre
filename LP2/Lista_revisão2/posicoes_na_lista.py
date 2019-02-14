def troca(lista,pos1,pos2):
    aux = lista[pos1]
    lista[pos1] = lista[pos2]
    lista[pos2] = aux
    
    return lista
