while True:
    try:
        n = input("Entre com um número inteiro: ")
        x = int(n)
        break
    except ValueError:
        print("Não é um inteiro! Tente novamente.")
print("Muito Bem!")
