INSERT INTO Endereco (logradouro, uf, cep, numero) VALUES ('Rua das Rosas', 'SP', '06643852', '601')

INSERT INTO Endereco (logradouro, uf, cep, numero, complemento) VALUES ('Rua das Margaridas', 'SP', '06643871', '21', 'BLOCO C')

INSERT INTO Proprietario (nome, cpf, telefone, idade, IDEndereco) 
VALUES('José Antônio', '74685123854', '11963521478', '56', 4)

INSERT INTO TipoImovel (tipo) VALUES ('Apartamento')

INSERT INTO Imovel (IDEndereco, matricula, IDTipoImovel) VALUES (6, '23854565', 1)

INSERT INTO ProprietarioImovel (IDProprietario, IDImovel) VALUES (2, 1)

INSERT INTO Cliente (nome, cpf, idade, telefone) VALUES ('Roberto Firmino Fretas', '45871230145', '26', '11985476310')

INSERT INTO HistoricoImovel (IDCliente, IDImovel, dataEntrada, dataSaida) VALUES (1, 1, '15032019', '15032020')

SELECT * FROM Proprietario (NOLOCK)

SELECT * FROM Endereco (NOLOCK)

SELECT * FROM ProprietarioImovel (NOLOCK)

SELECT * FROM Imovel (NOLOCK)

SELECT * FROM TipoImovel (NOLOCK)

SELECT * FROM HistoricoImovel (NOLOCK)

SELECT * FROM Cliente (NOLOCK)






