# Generated by Django 2.1.3 on 2018-11-29 00:22

import contas.models.alunos
import contas.models.usuarios
import datetime
from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Usuario',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('last_login', models.DateTimeField(blank=True, null=True, verbose_name='last login')),
                ('login', models.CharField(max_length=100, unique=True)),
                ('password', models.CharField(db_column='senha', max_length=128, verbose_name='Senha')),
                ('dt_expiracao', models.DateField(blank=True, default=datetime.date(1900, 1, 1), null=True)),
                ('tipo', models.CharField(choices=[('C', 'Coordenador'), ('P', 'Professor'), ('A', 'Aluno')], max_length=1)),
            ],
            options={
                'abstract': False,
            },
            managers=[
                ('objects', contas.models.usuarios.UsuarioManager()),
            ],
        ),
        migrations.CreateModel(
            name='Aluno',
            fields=[
                ('usuario_ptr', models.OneToOneField(auto_created=True, on_delete=django.db.models.deletion.CASCADE, parent_link=True, primary_key=True, serialize=False, to=settings.AUTH_USER_MODEL)),
                ('nome', models.CharField(max_length=255)),
                ('email', models.CharField(max_length=255, unique=True)),
                ('celular', models.CharField(max_length=20, unique=True)),
                ('ra', models.CharField(max_length=20, unique=True)),
                ('foto', models.ImageField(blank=True, null=True, upload_to=contas.models.alunos.diretorio_aluno)),
            ],
            options={
                'verbose_name': 'aluno',
                'verbose_name_plural': 'alunos',
            },
            bases=('contas.usuario', models.Model),
            managers=[
                ('objects', contas.models.usuarios.UsuarioManager()),
            ],
        ),
        migrations.CreateModel(
            name='Coordenador',
            fields=[
                ('usuario_ptr', models.OneToOneField(auto_created=True, on_delete=django.db.models.deletion.CASCADE, parent_link=True, primary_key=True, serialize=False, to=settings.AUTH_USER_MODEL)),
                ('nome', models.CharField(max_length=255)),
                ('email', models.CharField(max_length=255, unique=True)),
                ('celular', models.CharField(max_length=20, unique=True)),
            ],
            options={
                'verbose_name': 'coordenador',
                'verbose_name_plural': 'coordenadores',
            },
            bases=('contas.usuario', models.Model),
            managers=[
                ('objects', contas.models.usuarios.UsuarioManager()),
            ],
        ),
        migrations.CreateModel(
            name='Professor',
            fields=[
                ('usuario_ptr', models.OneToOneField(auto_created=True, on_delete=django.db.models.deletion.CASCADE, parent_link=True, primary_key=True, serialize=False, to=settings.AUTH_USER_MODEL)),
                ('nome', models.CharField(max_length=255)),
                ('email', models.CharField(max_length=255, unique=True)),
                ('celular', models.CharField(max_length=20, unique=True)),
                ('apelido', models.CharField(max_length=255)),
            ],
            options={
                'verbose_name': 'professor',
                'verbose_name_plural': 'professores',
            },
            bases=('contas.usuario', models.Model),
            managers=[
                ('objects', contas.models.usuarios.UsuarioManager()),
            ],
        ),
    ]