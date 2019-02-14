# faça uma função relogio_segundos que:
# recebe um numero de segundos e  devolve uma string, 
# com a quantidade de horas, minutos e segundos correspondente. 
# Por exemplo, 3671 segundos corresponde a uma hora, 
# um minuto e 11 segundos.
# A sua resposta, nesse caso, deve ser a string
# '1 h, 1 min e 11 seg'
# não se preocupe com plurais (escrever mins ao invés de min)
#dica: // faz a divisão sem resto, % pega o resto
#ex: 16//5 == 3, 16%5 == 1
#dica: uma hora tem 3600 segundos, um minuto tem 60 segundos
def relogio_segundos(entrada):
    horas = entrada // 3600
    resto = entrada % 3600
    minutos = resto // 60
    segundos = resto % 60
    
    #ja deixei a string armada pra você
    return str(horas)+' h, '+str(minutos)+' min e '+str(segundos)+' seg'
