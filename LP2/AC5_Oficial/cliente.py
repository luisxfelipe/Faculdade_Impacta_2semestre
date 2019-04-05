class Cliente:
    def __init__(self, login, senha, servidor):
        self.login = login
        self.senha = senha
        self.servidor = servidor

    #métodos de acesso
    def getLogin(self):
        return self.login

    def getSenha(self):
        return self.senha

    def getServidor(self):
        return self.servidor

    #método modificador
    def setSenha(self, novaSenha):
        self.senha = novaSenha

    #outros métodos
    def enviarMensagem(self, mensagem):
        pass
    
    def lerNovaMensagem(self):
        pass
    
    def lerMensagem(self, indice):
        pass
    
    def apagarMensagem(self, indice):
        pass
    
