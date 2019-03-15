CREATE TABLE Endereco
(
	IDEndereco		INT PRIMARY KEY IDENTITY(1,1),
	logradouro		VARCHAR(50) NOT NULL,
	uf				CHAR(2) NOT NULL,
	cep				CHAR(8) NOT NULL,
	numero			CHAR(10) NOT NULL,
	complemento		VARCHAR(20)
)

CREATE TABLE Proprietario
(
	IDProprietario	INT PRIMARY KEY IDENTITY(1,1),
	nome			VARCHAR(50) NOT NULL,
	cpf				VARCHAR(11) NOT NULL,
	telefone		VARCHAR(11),
	idade			CHAR(3) NOT NULL,
	IDEndereco		INT
)

CREATE TABLE ProprietarioImovel
(
	IDProprietario	INT NOT NULL,
	IDImovel		INT NOT NULL
)

CREATE TABLE Imovel
(
	IDImovel		INT PRIMARY KEY IDENTITY(1,1),
	IDEndereco		INT NOT NULL,
	matricura		VARCHAR(20) NOT NULL,
	IDTipoImovel	INT
)

CREATE TABLE TipoImovel
(
	IDTipoImovel	INT PRIMARY KEY IDENTITY(1,1),
	tipo			VARCHAR(20) NOT NULL
)

CREATE TABLE HistoricoImovel
(
	IDCliente	INT,
	IDImovel	INT,
	dataEntrada	VARCHAR(8) NOT NULL,
	dataSaida	VARCHAR(8) NOT NULL
)

CREATE TABLE Cliente
(
	IDCliente	INT PRIMARY KEY IDENTITY(1,1),
	nome			VARCHAR(50) NOT NULL,
	cpf				VARCHAR(11) NOT NULL,
	idade			CHAR(3) NOT NULL,
	telefone		VARCHAR(11)
)

ALTER TABLE Proprietario ADD CONSTRAINT UQ_CPF_Proprietario UNIQUE (cpf);

ALTER TABLE Proprietario ADD CONSTRAINT FK_Proprietario_Endereco 
FOREIGN KEY (IDEndereco) REFERENCES Endereco (IDEndereco);

ALTER TABLE ProprietarioImovel ADD CONSTRAINT FK_ProprietarioImovel_IDProprietario
FOREIGN KEY (IDProprietario) REFERENCES Proprietario(IDProprietario);

ALTER TABLE ProprietarioImovel ADD CONSTRAINT FK_ProprietarioImovel_IDImovel
FOREIGN KEY (IDImovel) REFERENCES Imovel(IDImovel);

ALTER TABLE Imovel ADD CONSTRAINT FK_IDEndereco_Imovel
FOREIGN KEY (IDEndereco) REFERENCES Endereco (IDEndereco);

ALTER TABLE Imovel ADD CONSTRAINT DF_TipoImovel
DEFAULT 'N/D' FOR IDTipoImovel;

ALTER TABLE HistoricoImovel ADD CONSTRAINT FK_IDCliente_HistoricoImovel
FOREIGN KEY (IDCliente) REFERENCES Cliente (IDCliente);

ALTER TABLE HistoricoImovel ADD CONSTRAINT FK_IDImovel_HistoricoImovel
FOREIGN KEY (IDImovel) REFERENCES Imovel (IDImovel);

ALTER TABLE Cliente ADD CONSTRAINT UQ_CPF_Cliente UNIQUE (cpf);

ALTER TABLE Cliente ADD CONSTRAINT CK_Idade_Cliente
CHECK (idade >= 18);

ALTER TABLE Endereco ADD CONSTRAINT DF_Complemento DEFAULT 'N/D' FOR complemento;

ALTER TABLE Imovel ADD CONSTRAINT FK_IDTipoImovel
FOREIGN KEY (IDTipoImovel) REFERENCES TipoImovel (IDTipoImovel);
