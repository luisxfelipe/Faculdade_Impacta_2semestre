class Servidor:
    def __init__(self, nome):
        self.nome = nome
        self.dicClientes = {}
        self.mensagens = []

    #método de acesso
    def getNome(self):
        return self.nome

    def getMensagens(self):
        return self.mensagens

    #outros métodos
    def cadastrarCliente(self, cliente):
        self.dicClientes[ cliente.getLogin() ] = cliente

    def receberMensagem(self, mensagem, senha):
        #checar autenticidade
        login = mensagem.getRemetente()
        cliente = self.dicClientes[ login ]
        if cliente.getSenha() == senha:
            self.mensagens.append(mensagem)
        
        
