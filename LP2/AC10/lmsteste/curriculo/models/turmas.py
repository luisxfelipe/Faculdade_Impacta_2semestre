from django.db import models

class Turma(models.Model):
    ano = models.IntegerField()
    semestre = models.IntegerField()
    nome = models.CharField(max_length=50)
    tipo =  models.CharField(max_length=100)

    def __str__(self):
        return "{}-{}-{}".format(self.ano, self.semestre, self.nome, self.tipo)

    class Meta:
        unique_together = ("ano", "semestre", "nome", "tipo")