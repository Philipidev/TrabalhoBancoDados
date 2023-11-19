-- Jun��o de m�ltiplas tabelas para obter detalhes completos das transa��es de ped�gio.
-- Inclui informa��es do usu�rio, ve�culo, categoria do ve�culo, localiza��o do ped�gio, data/hora e valor da transa��o.
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

-- Jun��o de tabelas para obter transa��es de ped�gio de ve�culos da categoria 'Carro'.
-- Resultados ordenados pela data e hora da transa��o em ordem decrescente.
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

-- Jun��o de tabelas com filtragem por padr�o de placa e intervalo de datas em transa��es de ped�gio.
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

-- Jun��o de tabelas com filtragem por categoria de ve�culo e verifica��o de status ativo da tag de ped�gio.
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

-- Agrupamento de dados de ped�gio por localiza��o para calcular a receita total de cada local.
SELECT 
    Pedagio.Localizacao AS LocalPedagio,
    SUM(TransacaoPedagio.ValorCobrado) AS TotalReceitas
FROM 
    TransacaoPedagio
INNER JOIN 
    Pedagio ON TransacaoPedagio.PedagioID = Pedagio.PedagioID
GROUP BY 
    Pedagio.Localizacao;

-- Identifica��o de localiza��es de ped�gio com receita total excedendo um valor espec�fico.
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

-- Identifica��o de transa��es de ped�gio com valores acima da m�dia geral.
SELECT 
    T.TransacaoID,
    T.DataHoraTransacao,
    T.ValorCobrado
FROM 
    TransacaoPedagio T
WHERE 
    T.ValorCobrado > (SELECT AVG(ValorCobrado) FROM TransacaoPedagio);

-- Identifica��o de ve�culos com m�dia de recargas superior � m�dia geral.
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

-- Identifica��o de ve�culos com pelo menos uma transa��o de ped�gio acima de um valor espec�fico.
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

-- Cria��o de uma vis�o para ve�culos com transa��es de ped�gio acima de um valor espec�fico.
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
