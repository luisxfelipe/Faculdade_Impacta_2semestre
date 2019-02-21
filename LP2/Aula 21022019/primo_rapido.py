from math import sqrt

def primo_rapido(n):
    if n == 1:
        return False
    for i in range(2, int(sqrt(n))+1): #de 2 até raiz de n
        if n % i == 0:
            return False
    return True

def teste_primoRapido():
    if primo_rapido(1) != False:
        return False
    elif primo_rapido(2) != True:
        return False
    elif primo_rapido(7) != True:
        return False
    elif primo_rapido(11) != True:
        return False
    elif primo_rapido(15) != False:
        return False
    elif primo_rapido(123) != False:
        return False
    else:
        return True
            
