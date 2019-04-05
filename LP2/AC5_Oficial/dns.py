class DNS():
    def __init__(self):
        self.dicServidores = {}

    def cadastrarServidor(self, nome, servidor):
        self.dicServidores[nome] = servidor

    def consultarServidor(self, nome):
        return self.dicServidores[nome]
