class Mensagem:
    #método construtor
    def __init__(self, remetente, destinatario, assunto, corpo):
        self.remetente = remetente
        self.destinatario = destinatario
        self.assunto = assunto
        self.corpo = corpo
        self.foiLida = False

    #métodos de acesso
    def getRemetente(self):
        return self.remetente
    
    def getDestinatario(self):
        return self.destinatario
    
    def getAssunto(self):
        return self.assunto
    
    def getCorpo(self):
        return self.corpo
    
    def getFoiLida(self):
        return self.foiLida

    def retornaMensagem(self):
        return "De: " + self.remetente + "\nPara: " + \
               self.destinatario + "\nAssunto: " + \
               self.assunto + "\n" + self.corpo

    def __str__(self):
        return self.retornaMensagem()

    #método modificador
    def setFoiLida(self, status):
        self.foiLida = status
