-- Criação de esquema para o sistema de cobrança automática em pedágios

-- Criação da tabela de Usuários
CREATE TABLE Usuario (
    UsuarioID INT PRIMARY KEY IDENTITY,
    Nome NVARCHAR(100),
    CPF NVARCHAR(11),
    Email NVARCHAR(100)
);

-- Criação da tabela de Categoria de Veículos
CREATE TABLE CategoriaVeiculo (
    CategoriaVeiculoID INT PRIMARY KEY IDENTITY,
    Descricao NVARCHAR(50),
    TarifaBase MONEY
);

-- Criação da tabela de Veículos
CREATE TABLE Veiculo (
    VeiculoID INT PRIMARY KEY IDENTITY,
    Placa NVARCHAR(7),
    Modelo NVARCHAR(50),
    Marca NVARCHAR(50),
    Ano INT,
    UsuarioID INT FOREIGN KEY REFERENCES Usuario(UsuarioID),
    CategoriaVeiculoID INT FOREIGN KEY REFERENCES CategoriaVeiculo(CategoriaVeiculoID)
);

-- Criação da tabela de Tags de Pedágio
CREATE TABLE TagPedagio (
    TagID INT PRIMARY KEY IDENTITY,
    VeiculoID INT FOREIGN KEY REFERENCES Veiculo(VeiculoID),
    Saldo MONEY,
    Ativa BIT
);

-- Criação da tabela de Pedágios
CREATE TABLE Pedagio (
    PedagioID INT PRIMARY KEY IDENTITY,
    Localizacao NVARCHAR(255),
    Tarifa MONEY
);

-- Criação da tabela de Transações de Pedágio
CREATE TABLE TransacaoPedagio (
    TransacaoID INT PRIMARY KEY IDENTITY,
    TagID INT FOREIGN KEY REFERENCES TagPedagio(TagID),
    PedagioID INT FOREIGN KEY REFERENCES Pedagio(PedagioID),
    DataHoraTransacao DATETIME,
    ValorCobrado MONEY
);

-- Criação da tabela de Recargas de Tags de Pedágio
CREATE TABLE Recarga (
    RecargaID INT PRIMARY KEY IDENTITY,
    TagID INT FOREIGN KEY REFERENCES TagPedagio(TagID),
    ValorRecarga MONEY,
    DataHoraRecarga DATETIME
);

-- Criação da tabela de Histórico de Transações
CREATE TABLE HistoricoTransacao (
    HistoricoTransacaoID INT PRIMARY KEY IDENTITY,
    TagID INT FOREIGN KEY REFERENCES TagPedagio(TagID),
    DataHoraAlteracao DATETIME,
    SaldoAnterior MONEY,
    SaldoAtual MONEY
);
