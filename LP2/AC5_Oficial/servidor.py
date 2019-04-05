from dns import DNS

class Servidor:
    def __init__(self, nome, DNS):
        self.nome = nome
        self.dicClientes = {}
        self.mensagens = []
        self.DNS = DNS

    #método de acesso
    def getNome(self):
        return self.nome

    def getMensagens(self):
        return self.mensagens

    #outros métodos
    def cadastrarCliente(self, cliente):
        self.dicClientes[ cliente.getLogin() ] = cliente

    def receberMensagem(self, mensagem, senha):
        #tenho que descobrir se a mensagem é para mim
        #ou para outro servidor
        if mensagem.getServidorDestino() == self.nome:
            #checar autenticidade
            login = mensagem.getRemetente()
            cliente = self.dicClientes[ login ]
            if cliente.getSenha() == senha:
                self.mensagens.append(mensagem)
        else: #a mensagem é para outro servidor...
            outroServidor = self.DNS.consultarServidor( \
                mensagem.getServidorDestino() )
            outroServidor.receberDeOutroServidor(mensagem)

    def receberDeOutroServidor(self, mensagem):
        self.mensagens.append(mensagem)
        

