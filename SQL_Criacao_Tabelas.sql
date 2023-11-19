-- Cria��o de esquema para o sistema de cobran�a autom�tica em ped�gios

-- Cria��o da tabela de Usu�rios
CREATE TABLE Usuario (
    UsuarioID INT PRIMARY KEY IDENTITY,
    Nome NVARCHAR(100),
    CPF NVARCHAR(11),
    Email NVARCHAR(100)
);

-- Cria��o da tabela de Categoria de Ve�culos
CREATE TABLE CategoriaVeiculo (
    CategoriaVeiculoID INT PRIMARY KEY IDENTITY,
    Descricao NVARCHAR(50),
    TarifaBase MONEY
);

-- Cria��o da tabela de Ve�culos
CREATE TABLE Veiculo (
    VeiculoID INT PRIMARY KEY IDENTITY,
    Placa NVARCHAR(7),
    Modelo NVARCHAR(50),
    Marca NVARCHAR(50),
    Ano INT,
    UsuarioID INT FOREIGN KEY REFERENCES Usuario(UsuarioID),
    CategoriaVeiculoID INT FOREIGN KEY REFERENCES CategoriaVeiculo(CategoriaVeiculoID)
);

-- Cria��o da tabela de Tags de Ped�gio
CREATE TABLE TagPedagio (
    TagID INT PRIMARY KEY IDENTITY,
    VeiculoID INT FOREIGN KEY REFERENCES Veiculo(VeiculoID),
    Saldo MONEY,
    Ativa BIT
);

-- Cria��o da tabela de Ped�gios
CREATE TABLE Pedagio (
    PedagioID INT PRIMARY KEY IDENTITY,
    Localizacao NVARCHAR(255),
    Tarifa MONEY
);

-- Cria��o da tabela de Transa��es de Ped�gio
CREATE TABLE TransacaoPedagio (
    TransacaoID INT PRIMARY KEY IDENTITY,
    TagID INT FOREIGN KEY REFERENCES TagPedagio(TagID),
    PedagioID INT FOREIGN KEY REFERENCES Pedagio(PedagioID),
    DataHoraTransacao DATETIME,
    ValorCobrado MONEY
);

-- Cria��o da tabela de Recargas de Tags de Ped�gio
CREATE TABLE Recarga (
    RecargaID INT PRIMARY KEY IDENTITY,
    TagID INT FOREIGN KEY REFERENCES TagPedagio(TagID),
    ValorRecarga MONEY,
    DataHoraRecarga DATETIME
);

-- Cria��o da tabela de Hist�rico de Transa��es
CREATE TABLE HistoricoTransacao (
    HistoricoTransacaoID INT PRIMARY KEY IDENTITY,
    TagID INT FOREIGN KEY REFERENCES TagPedagio(TagID),
    DataHoraAlteracao DATETIME,
    SaldoAnterior MONEY,
    SaldoAtual MONEY
);
