from servidor import Servidor

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
        self.login = mensagem.remetente
        Servidor.receberMensagem(mensagem, self.senha)
    
    def lerNovaMensagem(self):
        Servidor.retornarNovaMensagem(self.login, self.senha)
    
    def lerMensagem(self, indice):
        Servidor.retornarMensagem(indice, self.login, self.senha)
    
    def apagarMensagem(self, indice):
        Servidor.apagarMensagem(indice , login, senha)
    
