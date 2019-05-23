# Generated by Django 2.1.7 on 2019-05-23 12:40

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('curriculo', '0004_auto_20190520_1043'),
    ]

    operations = [
        migrations.AddField(
            model_name='turma',
            name='tipo',
            field=models.TextField(default='presencial', max_length=500),
            preserve_default=False,
        ),
        migrations.AlterUniqueTogether(
            name='turma',
            unique_together={('ano', 'semestre', 'nome', 'tipo')},
        ),
    ]
