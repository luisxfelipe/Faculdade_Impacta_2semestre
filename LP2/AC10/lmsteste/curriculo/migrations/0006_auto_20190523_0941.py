# Generated by Django 2.1.7 on 2019-05-23 12:41

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('curriculo', '0005_auto_20190523_0940'),
    ]

    operations = [
        migrations.AlterField(
            model_name='turma',
            name='tipo',
            field=models.CharField(max_length=1),
        ),
    ]
