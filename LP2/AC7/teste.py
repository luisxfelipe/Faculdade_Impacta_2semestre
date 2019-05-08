from faculdade import Disciplina, Pessoa, Aluno, Professor

def test_pessoa():
    pes = Pessoa('Fulano da Silva', 999999, 'fulano@mail.com')
    assert pes.get_nome() == 'Fulano da Silva'
    assert pes.get_email() == 'fulano@mail.com'
    assert pes.get_telefone() == 999999

test_pessoa()
