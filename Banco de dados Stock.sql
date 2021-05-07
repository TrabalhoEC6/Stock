drop database Stock;
create database Stock;

create table `stock`.`Fornecedor`(
`codigoFornecedor` int primary key auto_increment,
`razaoSocial` varchar(50),
`endereço` varchar(50),
`telefone` varchar(18),
`email` varchar(50)
);

create table `stock`.`Unidade`(
`codigoUnidade` int primary key auto_increment,
`franquia` varchar(50)
);


CREATE TABLE `stock`.`Produto` (
`codigoProduto` int primary key not null,
`nomeProduto` varchar(45),
`dataValidade` date,
`dataProcessamento` date,
`precoVenda` double(5,2),
`quantidade` int,
`estoque` varchar(20),
`armazenamento` varchar(15),
`codigoFornecedor` int,
`loteProduto` int,
`codigoUnidade` int,
CONSTRAINT fk_ProUni FOREIGN KEY (codigoUnidade) REFERENCES Unidade (codigoUnidade),
CONSTRAINT fk_ProFor FOREIGN KEY (codigoFornecedor) REFERENCES Fornecedor (codigoFornecedor)
);

create table `stock`.`Usuario`(
`codigoUsuario` int primary key not null auto_increment,
`login` varchar(20),
`nome` varchar(50),
`senha` varchar(50),
`codigoUnidade` int,
CONSTRAINT fk_UsuUni FOREIGN KEY (codigoUnidade) REFERENCES Unidade (codigoUnidade)
);

create table `stock`.`ProdutosVendidos`(
`codigoVenda` INT NOT NULL AUTO_INCREMENT,
`codigoProduto` int,
`quantidade` int,
`valor unitario` int,
`codigoUnidade` int,
`codigoUsuario` int,
CONSTRAINT fk_ProVenPro FOREIGN KEY (codigoProduto) REFERENCES Produto (codigoProduto),
CONSTRAINT fk_ProVenUni FOREIGN KEY (codigoUnidade) REFERENCES Unidade (codigoUnidade),
CONSTRAINT fk_ProVenUsi FOREIGN KEY (codigoUsuario) REFERENCES Usuario (codigoUsuario),
primary key(`codigoVenda`)
);

create table `stock`.`Alteracao_PrecoPorData`(
`codigoAlteracao` INT NOT NULL AUTO_INCREMENT,
`codigoProduto` int,
`porcentagem de aumento` varchar(5),
`porcentagem de desconto` varchar(5),
`dataAlteracaoInicio` date,
`dataAlteracaoFim` date,
`codigoUsuario` int,
CONSTRAINT fk_ProdAlt FOREIGN KEY (codigoProduto) REFERENCES Produto (codigoProduto),
CONSTRAINT fk_UsuarioAlt FOREIGN KEY (codigoUsuario) REFERENCES Usuario (codigoUsuario),
primary key(`codigoAlteracao`)
);
 
Select *
From stock.produto;

DELIMITER $$
CREATE procedure `sp_insereProduto`(in `codigoProduto` int,in `nomeProduto` varchar(45), in `dataValidade` date, in `dataProcessamento` date, in `precoVenda` double(5,2), in `quantidade` int,
 in `estoque` varchar(20), in `armazenamento` varchar(15), in `codigoFornecedor` int, in `loteProduto` int, in `codigoUnidade` int)
begin
	insert into Produto(`codigoProduto`, `nomeProduto`,`armazenamento`, `dataValidade`, `dataProcessamento`, `precoVenda`, `quantidade`, 
    `estoque`, `armazenamento`, `codigoFornecedor`, `loteProduto`, `codigoUnidade`) values (`nomeProduto`,`armazenamento`, `dataValidade`, `dataProcessamento`, `precoVenda`, `quantidade`, 
    `estoque`, `armazenamento`, `codigoFornecedor`, `loteProduto`, `codigoUnidade`);
end $$
DELIMITER ;

DELIMITER $$
CREATE procedure `sp_deleteProduto`(in `codigoProduto` int)
begin
	Delete from Produto where `codigoProduto`= `codigoProduto`;
end $$
DELIMITER ;

DELIMITER $

CREATE TRIGGER tgr_InserirProdutosVendidos AFTER Insert
ON ProdutoVendido
FOR EACH ROW
BEGIN
	UPDATE Produto SET quantidade = quantidade - NEW.Quantidade
WHERE codigoProduto = NEW.Produto;
END$

DELIMITER ;


