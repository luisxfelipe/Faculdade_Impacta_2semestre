def eh_numero(c):
    if c in '0123456789':
        return True
    return False

def eh_minuscula (c):
    if c in 'abcdefghijklmnopqrstuvwxyz':
        return True
    return False

def eh_maiuscula(c):
    if c in 'ABCDEFGHIJKLMNOPQRSTUVWXYZ':
        return True
    return False

def senha_boa(senha):
    maiuscula = False
    minuscula = False
    numero = False
    tamanho = False

    if len(senha) >= 8:
        tamanho = True

        for c in senha:
            if eh_maiuscula(c):
                maiuscula = True
            elif  eh_minuscula(c):
                minuscula = True
            elif eh_numero(c):
                numero = True

    return numero and maiuscula and minuscula and tamanho
