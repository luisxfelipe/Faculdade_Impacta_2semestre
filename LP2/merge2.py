def merge2(lista1, lista2):
    i1 = i2 = 0
    lista3 = []

    while i1 < len(lista1) and i2 < len(lista2):
        if lista1[i1] < lista2[i2]:
            if  len(lista3) == 0 or lista3[-1] != lista1[i1]:
                lista3.append(lista1[i1])
            i1 += 1
        else:
            if len(lista3) == 0 or lista3[-1] != lista2[i2]:
                lista3.append(lista2[i2])
            i2 += 1

    while i1 < len(lista1) or i2 < len(lista2):
        if i1 < len(lista1): #lista1 ainda tem elementos
            if  len(lista3) == 0 or lista3[-1] != lista1[i1]:
                lista3.append(lista1[i1])
            i1 += 1
        else: #lista2 ainda tem elementos
            if len(lista3) == 0 or lista3[-1] != lista2[i2]:
                lista3.append(lista2[i2])
            i2 += 1

    return lista3
