class Mensagem:
    #método construtor
    def __init__(self, remetente, destinatario, servidorDestino, assunto, corpo):
        self.remetente = remetente
        self.destinatario = destinatario
        self.servidorDestino = servidorDestino
        self.assunto = assunto
        self.corpo = corpo
        self.foiLida = False

    #métodos de acesso
    def getRemetente(self):
        return self.remetente
    
    def getDestinatario(self):
        return self.destinatario
    
    def getServidorDestino(self):
        return self.servidorDestino
    
    def getAssunto(self):
        return self.assunto
    
    def getCorpo(self):
        return self.corpo
    
    def getFoiLida(self):
        return self.foiLida

    def retornaMensagem(self):
        return "De: " + self.remetente + "\nPara: " + \
               self.destinatario + "@" + self.servidorDestino \
               + "\nAssunto: " + self.assunto + "\n" + self.corpo

    def __str__(self):
        return self.retornaMensagem()

    #método modificador
    def setFoiLida(self, status):
        self.foiLida = status
