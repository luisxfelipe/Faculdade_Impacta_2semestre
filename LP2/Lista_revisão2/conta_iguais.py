def conta_iguais(a, b, c):
    string = ""
    if a == b and a == c:
        string = 'todos iguais'
    elif a == b and a != c or b == c and b != a or a == c and a != b:
        string = 'dois iguais'
    elif a != b and a != c:
        string = 'diferentes'

    return string
