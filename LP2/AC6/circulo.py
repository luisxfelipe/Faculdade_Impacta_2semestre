from figura import Figura

class Circulo(Figura):

    def __init__(self, x, y, cor, raio):
        super().__init__(x, y, cor)
        self.raio = raio

    def __str__(self):
        return self.raio

    def calculaArea(self):
        
        return  3.14 * (self.raio ** 2)

    def desenha(self):
        passo = 2 * self.__raio*math.tan(math.pi/45)
        for i in range(45):
            self._tartaruga.forward(passo)
            self._tartaruga.left(8)


