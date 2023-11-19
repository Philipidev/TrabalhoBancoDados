-- Inserindo mais registros na tabela CategoriaVeiculo
INSERT INTO CategoriaVeiculo (Descricao, TarifaBase) VALUES ('Ônibus', 20.00);
INSERT INTO CategoriaVeiculo (Descricao, TarifaBase) VALUES ('Van', 18.00);
INSERT INTO CategoriaVeiculo (Descricao, TarifaBase) VALUES ('Moto', 5.00);
INSERT INTO CategoriaVeiculo (Descricao, TarifaBase) VALUES ('Carro', 10.00);
INSERT INTO CategoriaVeiculo (Descricao, TarifaBase) VALUES ('Caminhão', 15.00);
INSERT INTO CategoriaVeiculo (Descricao, TarifaBase) VALUES ('Bicicleta', 2.00);
INSERT INTO CategoriaVeiculo (Descricao, TarifaBase) VALUES ('Triciclo', 3.00);

-- Inserindo mais registros na tabela Usuario
INSERT INTO Usuario (Nome, CPF, Email) VALUES ('Carlos Pereira', '34567890123', 'carlos.pereira@email.com');
INSERT INTO Usuario (Nome, CPF, Email) VALUES ('Ana Beatriz', '45678901234', 'ana.beatriz@email.com');
INSERT INTO Usuario (Nome, CPF, Email) VALUES ('João Silva', '12345678901', 'joao.silva@email.com');
INSERT INTO Usuario (Nome, CPF, Email) VALUES ('Maria Oliveira', '23456789012', 'maria.oliveira@email.com');
INSERT INTO Usuario (Nome, CPF, Email) VALUES ('Pedro Martins', '56789012345', 'pedro.martins@email.com');
INSERT INTO Usuario (Nome, CPF, Email) VALUES ('Julia Carvalho', '67890123456', 'julia.carvalho@email.com');


-- Inserindo mais registros na tabela Veiculo
INSERT INTO Veiculo (Placa, Modelo, Marca, Ano, UsuarioID, CategoriaVeiculoID) VALUES ('DEF4G56', 'Modelo C', 'Marca C', 2018, 3, 3);
INSERT INTO Veiculo (Placa, Modelo, Marca, Ano, UsuarioID, CategoriaVeiculoID) VALUES ('HIJ1K23', 'Modelo D', 'Marca D', 2021, 4, 4);
INSERT INTO Veiculo (Placa, Modelo, Marca, Ano, UsuarioID, CategoriaVeiculoID) VALUES ('ABC1D23', 'Modelo A', 'Marca A', 2020, 1, 2);
INSERT INTO Veiculo (Placa, Modelo, Marca, Ano, UsuarioID, CategoriaVeiculoID) VALUES ('XYZ9W87', 'Modelo B', 'Marca B', 2019, 2, 1);
INSERT INTO Veiculo (Placa, Modelo, Marca, Ano, UsuarioID, CategoriaVeiculoID) VALUES ('LMN2T98', 'Modelo E', 'Marca E', 2017, 5, 5);
INSERT INTO Veiculo (Placa, Modelo, Marca, Ano, UsuarioID, CategoriaVeiculoID) VALUES ('OPQ3U67', 'Modelo F', 'Marca F', 2022, 6, 6);


-- Inserindo mais registros na tabela TagPedagio
INSERT INTO TagPedagio (VeiculoID, Saldo, Ativa) VALUES (3, 100.00, 1);
INSERT INTO TagPedagio (VeiculoID, Saldo, Ativa) VALUES (4, 60.00, 1);
INSERT INTO TagPedagio (VeiculoID, Saldo, Ativa) VALUES (1, 50.00, 1);
INSERT INTO TagPedagio (VeiculoID, Saldo, Ativa) VALUES (2, 75.00, 1);
INSERT INTO TagPedagio (VeiculoID, Saldo, Ativa) VALUES (5, 30.00, 1);
INSERT INTO TagPedagio (VeiculoID, Saldo, Ativa) VALUES (6, 80.00, 1);


-- Inserindo mais registros na tabela Pedagio
INSERT INTO Pedagio (Localizacao, Tarifa) VALUES ('Local C', 12.00);
INSERT INTO Pedagio (Localizacao, Tarifa) VALUES ('Local D', 10.00);
INSERT INTO Pedagio (Localizacao, Tarifa) VALUES ('Local A', 10.00);
INSERT INTO Pedagio (Localizacao, Tarifa) VALUES ('Local B', 15.00);
INSERT INTO Pedagio (Localizacao, Tarifa) VALUES ('Local E', 8.00);
INSERT INTO Pedagio (Localizacao, Tarifa) VALUES ('Local F', 7.00);

-- Inserindo mais registros na tabela TransacaoPedagio
INSERT INTO TransacaoPedagio (TagID, PedagioID, DataHoraTransacao, ValorCobrado) VALUES (3, 3, GETDATE(), 12.00);
INSERT INTO TransacaoPedagio (TagID, PedagioID, DataHoraTransacao, ValorCobrado) VALUES (4, 4, GETDATE(), 10.00);
INSERT INTO TransacaoPedagio (TagID, PedagioID, DataHoraTransacao, ValorCobrado) VALUES (1, 1, GETDATE(), 10.00);
INSERT INTO TransacaoPedagio (TagID, PedagioID, DataHoraTransacao, ValorCobrado) VALUES (2, 2, GETDATE(), 15.00);
INSERT INTO TransacaoPedagio (TagID, PedagioID, DataHoraTransacao, ValorCobrado) VALUES (5, 5, GETDATE(), 8.00);
INSERT INTO TransacaoPedagio (TagID, PedagioID, DataHoraTransacao, ValorCobrado) VALUES (6, 6, GETDATE(), 7.00);


-- Inserindo mais registros na tabela Recarga
INSERT INTO Recarga (TagID, ValorRecarga, DataHoraRecarga) VALUES (3, 50.00, GETDATE());
INSERT INTO Recarga (TagID, ValorRecarga, DataHoraRecarga) VALUES (4, 20.00, GETDATE());
INSERT INTO Recarga (TagID, ValorRecarga, DataHoraRecarga) VALUES (1, 30.00, GETDATE());
INSERT INTO Recarga (TagID, ValorRecarga, DataHoraRecarga) VALUES (2, 40.00, GETDATE());
INSERT INTO Recarga (TagID, ValorRecarga, DataHoraRecarga) VALUES (5, 25.00, GETDATE());
INSERT INTO Recarga (TagID, ValorRecarga, DataHoraRecarga) VALUES (6, 55.00, GETDATE());


-- Inserindo mais registros na tabela HistoricoTransacao
INSERT INTO HistoricoTransacao (TagID, DataHoraAlteracao, SaldoAnterior, SaldoAtual) VALUES (3, GETDATE(), 50.00, 100.00);
INSERT INTO HistoricoTransacao (TagID, DataHoraAlteracao, SaldoAnterior, SaldoAtual) VALUES (4, GETDATE(), 40.00, 60.00);
INSERT INTO HistoricoTransacao (TagID, DataHoraAlteracao, SaldoAnterior, SaldoAtual) VALUES (1, GETDATE(), 20.00, 50.00);
INSERT INTO HistoricoTransacao (TagID, DataHoraAlteracao, SaldoAnterior, SaldoAtual) VALUES (2, GETDATE(), 35.00, 75.00);
INSERT INTO HistoricoTransacao (TagID, DataHoraAlteracao, SaldoAnterior, SaldoAtual) VALUES (5, GETDATE(), 5.00, 30.00);
INSERT INTO HistoricoTransacao (TagID, DataHoraAlteracao, SaldoAnterior, SaldoAtual) VALUES (6, GETDATE(), 25.00, 80.00);
