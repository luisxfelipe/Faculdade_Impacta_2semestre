from empresa import Programador, Estagiario, Empresa

# Programador


def test_cria_prog_cg_invalida():
    try:
        Programador('Fulano', 25, 'fulano@empresa.com', 60)
    except ValueError:
        pass
    else:
        raise AssertionError('Não deveria criar com carga Horaria inválida')


def test_prog_consulta_cg():
    prog = Programador('Fulano', 25, 'fulano@empresa.com')
    assert prog.consulta_carga_horaria() == 40


def test_prog_altera_cg():
    prog = Programador('Fulano', 25, 'fulano@empresa.com')
    prog.altera_carga_horaria(36)
    assert prog.consulta_carga_horaria() == 36


def test_prog_altera_cg_error():
    prog = Programador('Fulano', 25, 'fulano@empresa.com')
    try:
        prog.altera_carga_horaria(16)
    except ValueError:
        assert prog.consulta_carga_horaria() == 40
    else:
        raise AssertionError('Trocou para carga horaria inválida')


def test_prog_calcula_salario():
    prog = Programador('Fulano', 25, 'fulano@empresa.com')
    assert prog.calcula_salario() == 6300


def test_prog_recebe_aumento():
    prog = Programador('Fulano', 25, 'fulano@empresa.com')
    prog.aumenta_salario()
    assert prog.calcula_salario() == 6615


# Estagiario


def test_cria_est_cg_invalida():
    try:
        Estagiario('Fulano', 25, 'fulano@empresa.com', 10)
    except ValueError:
        pass
    else:
        raise AssertionError('Não deveria criar com carga Horaria inválida')


def test_est_consulta_cg():
    est = Estagiario('Fulano', 25, 'fulano@empresa.com')
    assert est.consulta_carga_horaria() == 20


def test_est_altera_cg():
    est = Estagiario('Fulano', 25, 'fulano@empresa.com')
    est.altera_carga_horaria(30)
    assert est.consulta_carga_horaria() == 30


def test_est_altera_cg_error():
    est = Estagiario('Fulano', 25, 'fulano@empresa.com')
    try:
        est.altera_carga_horaria(36)
    except ValueError:
        assert est.consulta_carga_horaria() == 20
    else:
        raise AssertionError('Trocou para carga horaria inválida')


def test_est_calcula_salario():
    est = Estagiario('Fulano', 25, 'fulano@empresa.com')
    assert est.calcula_salario() == 1645


def test_est_recebe_aumento():
    est = Estagiario('Fulano', 25, 'fulano@empresa.com')
    est.aumenta_salario()
    assert abs(est.calcula_salario() - 1714.75) < 0.01


# Empresa

def test_lista_func_empresa():
    emp = Empresa('ACME', 123456789, 'Tecnologia')
    assert emp.lista_fucionarios() == []


def test_inclui_func():
    emp = Empresa('ACME', 123456789, 'Tecnologia')
    est = Estagiario('Fulano', 25, 'fulano@empresa.com')
    emp.contrata(est)
    assert len(emp.lista_fucionarios()) == 1
    assert emp.lista_fucionarios()[0].nome == 'Fulano'


def test_folha_pagamento():
    prog = Programador('Cicrano', 31, 'cicrano@empresa.com')
    emp = Empresa('ACME', 123456789, 'Tecnologia', [prog])
    est = Estagiario('Fulano', 25, 'fulano@empresa.com')
    emp.contrata(est)
    assert emp.folha_pagamento() == 7945


def test_dissidio():
    prog = Programador('Cicrano', 31, 'cicrano@empresa.com')
    emp = Empresa('ACME', 123456789, 'Tecnologia', [prog])
    est = Estagiario('Fulano', 25, 'fulano@empresa.com')
    emp.contrata(est)
    emp.dissidio_anual()
    assert abs(emp.folha_pagamento() - 8329.75) < 0.01

#test_cria_prog_cg_invalida()
#test_prog_consulta_cg()
#test_prog_altera_cg()
#test_prog_altera_cg_error()
#passou
test_prog_calcula_salario()
#test_prog_recebe_aumento()
#test_cria_est_cg_invalida()
#test_est_consulta_cg()
#test_est_altera_cg()
#test_est_altera_cg_error()
#test_est_calcula_salario()
#test_est_recebe_aumento()
#test_lista_func_empresa()
#test_inclui_func()
#test_folha_pagamento()
#test_dissidio()
