-- Junção de múltiplas tabelas para obter detalhes completos das transações de pedágio.
-- Inclui informações do usuário, veículo, categoria do veículo, localização do pedágio, data/hora e valor da transação.
SELECT 
    Usuario.Nome AS NomeUsuario,
    Veiculo.Placa,
    CategoriaVeiculo.Descricao AS CategoriaVeiculo,
    Pedagio.Localizacao AS LocalPedagio,
    TransacaoPedagio.DataHoraTransacao,
    TransacaoPedagio.ValorCobrado
FROM 
    TransacaoPedagio
INNER JOIN 
    TagPedagio ON TransacaoPedagio.TagID = TagPedagio.TagID
INNER JOIN 
    Veiculo ON TagPedagio.VeiculoID = Veiculo.VeiculoID
INNER JOIN 
    Usuario ON Veiculo.UsuarioID = Usuario.UsuarioID
INNER JOIN 
    CategoriaVeiculo ON Veiculo.CategoriaVeiculoID = CategoriaVeiculo.CategoriaVeiculoID
INNER JOIN 
    Pedagio ON TransacaoPedagio.PedagioID = Pedagio.PedagioID;

-- Junção de tabelas para obter transações de pedágio de veículos da categoria 'Carro'.
-- Resultados ordenados pela data e hora da transação em ordem decrescente.
SELECT 
    Usuario.Nome AS NomeUsuario,
    Veiculo.Placa,
    CategoriaVeiculo.Descricao AS CategoriaVeiculo,
    Pedagio.Localizacao AS LocalPedagio,
    TransacaoPedagio.DataHoraTransacao,
    TransacaoPedagio.ValorCobrado
FROM 
    TransacaoPedagio
INNER JOIN 
    TagPedagio ON TransacaoPedagio.TagID = TagPedagio.TagID
INNER JOIN 
    Veiculo ON TagPedagio.VeiculoID = Veiculo.VeiculoID
INNER JOIN 
    Usuario ON Veiculo.UsuarioID = Usuario.UsuarioID
INNER JOIN 
    CategoriaVeiculo ON Veiculo.CategoriaVeiculoID = CategoriaVeiculo.CategoriaVeiculoID
INNER JOIN 
    Pedagio ON TransacaoPedagio.PedagioID = Pedagio.PedagioID
WHERE 
    CategoriaVeiculo.Descricao = 'Carro'
ORDER BY 
    TransacaoPedagio.DataHoraTransacao DESC;

-- Junção de tabelas com filtragem por padrão de placa e intervalo de datas em transações de pedágio.
SELECT 
    Usuario.Nome AS NomeUsuario,
    Veiculo.Placa,
    CategoriaVeiculo.Descricao AS CategoriaVeiculo,
    Pedagio.Localizacao AS LocalPedagio,
    TransacaoPedagio.DataHoraTransacao,
    TransacaoPedagio.ValorCobrado
FROM 
    TransacaoPedagio
INNER JOIN 
    TagPedagio ON TransacaoPedagio.TagID = TagPedagio.TagID
INNER JOIN 
    Veiculo ON TagPedagio.VeiculoID = Veiculo.VeiculoID
INNER JOIN 
    Usuario ON Veiculo.UsuarioID = Usuario.UsuarioID
INNER JOIN 
    CategoriaVeiculo ON Veiculo.CategoriaVeiculoID = CategoriaVeiculo.CategoriaVeiculoID
INNER JOIN 
    Pedagio ON TransacaoPedagio.PedagioID = Pedagio.PedagioID
WHERE 
    Veiculo.Placa LIKE 'AB%' AND
    TransacaoPedagio.DataHoraTransacao BETWEEN '2023-01-01' AND '2023-12-31';

-- Junção de tabelas com filtragem por categoria de veículo e verificação de status ativo da tag de pedágio.
SELECT 
    Usuario.Nome AS NomeUsuario,
    Veiculo.Placa,
    CategoriaVeiculo.Descricao AS CategoriaVeiculo,
    TagPedagio.Ativa,
    Pedagio.Localizacao AS LocalPedagio,
    TransacaoPedagio.DataHoraTransacao,
    TransacaoPedagio.ValorCobrado
FROM 
    TransacaoPedagio
INNER JOIN 
    TagPedagio ON TransacaoPedagio.TagID = TagPedagio.TagID
INNER JOIN 
    Veiculo ON TagPedagio.VeiculoID = Veiculo.VeiculoID
INNER JOIN 
    Usuario ON Veiculo.UsuarioID = Usuario.UsuarioID
INNER JOIN 
    CategoriaVeiculo ON Veiculo.CategoriaVeiculoID = CategoriaVeiculo.CategoriaVeiculoID
INNER JOIN 
    Pedagio ON TransacaoPedagio.PedagioID = Pedagio.PedagioID
WHERE 
    CategoriaVeiculo.Descricao IN ('Carro', 'Moto') AND
    TagPedagio.Ativa = 1;

-- Agrupamento de dados de pedágio por localização para calcular a receita total de cada local.
SELECT 
    Pedagio.Localizacao AS LocalPedagio,
    SUM(TransacaoPedagio.ValorCobrado) AS TotalReceitas
FROM 
    TransacaoPedagio
INNER JOIN 
    Pedagio ON TransacaoPedagio.PedagioID = Pedagio.PedagioID
GROUP BY 
    Pedagio.Localizacao;

-- Identificação de localizações de pedágio com receita total excedendo um valor específico.
SELECT 
    Pedagio.Localizacao AS LocalPedagio,
    SUM(TransacaoPedagio.ValorCobrado) AS TotalReceitas
FROM 
    TransacaoPedagio
INNER JOIN 
    Pedagio ON TransacaoPedagio.PedagioID = Pedagio.PedagioID
GROUP BY 
    Pedagio.Localizacao
HAVING 
    SUM(TransacaoPedagio.ValorCobrado) > 10;

-- Identificação de transações de pedágio com valores acima da média geral.
SELECT 
    T.TransacaoID,
    T.DataHoraTransacao,
    T.ValorCobrado
FROM 
    TransacaoPedagio T
WHERE 
    T.ValorCobrado > (SELECT AVG(ValorCobrado) FROM TransacaoPedagio);

-- Identificação de veículos com média de recargas superior à média geral.
SELECT 
    V.VeiculoID,
    V.Placa,
    AVG(R.ValorRecarga) AS MediaRecargaVeiculo
FROM 
    Veiculo V
INNER JOIN 
    TagPedagio TP ON V.VeiculoID = TP.VeiculoID
INNER JOIN 
    Recarga R ON TP.TagID = R.TagID
GROUP BY 
    V.VeiculoID, V.Placa
HAVING 
    AVG(R.ValorRecarga) > (SELECT AVG(ValorRecarga) FROM Recarga);

-- Identificação de veículos com pelo menos uma transação de pedágio acima de um valor específico.
SELECT 
    V.VeiculoID,
    V.Placa
FROM 
    Veiculo V
WHERE 
    EXISTS (SELECT 1
            FROM TransacaoPedagio TP
            INNER JOIN TagPedagio T ON TP.TagID = T.TagID
            WHERE T.VeiculoID = V.VeiculoID AND TP.ValorCobrado > 10.00);

-- Criação de uma visão para veículos com transações de pedágio acima de um valor específico.
GO
CREATE VIEW VeiculosComTransacoesAltas AS
SELECT 
    V.VeiculoID,
    V.Placa,
    MAX(TP.ValorCobrado) AS MaiorTransacao
FROM 
    Veiculo V
INNER JOIN 
    TagPedagio T ON V.VeiculoID = T.VeiculoID
INNER JOIN 
    TransacaoPedagio TP ON T.TagID = TP.TagID
GROUP BY 
    V.VeiculoID, V.Placa
HAVING 
    MAX(TP.ValorCobrado) > 10.00;
GO
SELECT * FROM VeiculosComTransacoesAltas;
--DROP VIEW VeiculosComTransacoesAltas;
