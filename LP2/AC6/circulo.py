from figura import Figura

class Circulo(Figura):


    def __init__(self, raio):
        self.raio = raio

    def __str__(self):
        return self.raio

    def calculaArea(self):
        
        return  3.14 * (self.raio ** 2)


