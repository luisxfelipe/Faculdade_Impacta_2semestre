class Jogador:

    #método construtor
    def __init__ (self, nome, time, camisa, velocidade, ):
        self.nome = nome #self.nome é um atributo
        self.time = time
        self.camisa = camisa
        self.velocidade = velocidade

    #método de acesso (getters)
    def getNome(self):
        return self.nome

    def getTime(self):
        return self.time

    def getCamisa(self):
        return self.camisa

    def getVelocidade(self):
        return self.velocidade
    
