from figura import Figura

class Quadrado(Figura):

    #Contrutor
    def __init__(self, lado):
        self.lado = lado

    
    def calculaArea(self):
        
        return self.lado * 2

