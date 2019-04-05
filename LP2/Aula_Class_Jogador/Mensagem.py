class Mensagem:

    #método construtor
    def __init__ (self, remetente, destinatario, assunto, corpo):
        self.remetente = remetente #self.nome é um atributo
        self.destinatario = destinatario
        self.assunto = assunto
        self.corpo = corpo
        self.foiLida = False

    #método de acesso (getters)
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

    def setFoiLida(self, status):
        self.foiLida = status
    
    def retornaMensagem(self):
        return "De: " + self.remetente + "\nPara: " + \
               self.destinatario + "\nAssunto: " + \
               self.assunto + "\n" + self.corpo
    
    def _str_(self):
        return self.retornaMensagem()
    

#Classe Servidor

class Servidor:

    #método construtor
    def __init__ (self, nome):
        self.nome = nome #self.--- é um atributo
        self.dicClientes = {}
        self.mensagem = []
    

    #método de acesso 
    def cadastrarCliente(self, cliente):
        dicClientes [

    def getDestinatario(self):
        return self.destinatario

    def getAssunto(self):
        return self.assunto

    def getCorpo(self):
        return self.corpo
    
    def getFoiLida(self):
        return self.foiLida

    def setFoiLida(self, status):
        self.foiLida = status
    
        
    

class Cliente:

    def __init__ (self, login, senha, servidor):
        self.login = login #self.--- é um atributo
        self.senha = senha
        self.servidor = servidor

    def getLogin(self):
        return self.login
    
    def getServidor(self):
        return self.servidor
    
    def getSenha(self):
        return self.senha

    #Método modificador
    def etSenha(self, novaSenha):
        self.senha = novaSenha
        
    #Outros métodos
    def enviarMensagem(self, mensagem):
        pass
        
    def LerNovaMensagem(self):
        pass
        
    def LerMensagem(self, indice):
        pass
        
    def ApagarMensagem(self, indice):
        pass

     
         
    
    
    
 
    
