IF NOT EXISTS(SELECT 1 FROM SYS.DATABASES WHERE NAME = 'DAATesteAtlasQuantum')
	CREATE DATABASE DAATesteAtlasQuantum
GO
USE DAATesteAtlasQuantum
GO
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Usuario')
BEGIN
	CREATE TABLE Usuario(
	ID INT IDENTITY(1,1),
	Nome VARCHAR(50),
	Ativo BIT,
	DataAlteracao DATETIME,
	VersaoRegistro TIMESTAMP,
	PRIMARY KEY(ID))
END
GO
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'TipoOperacao')
BEGIN
	CREATE TABLE TipoOperacao(
	ID INT,
	Nome VARCHAR(20),
	DataAlteracao DATETIME,
	VersaoRegistro TIMESTAMP,
	PRIMARY KEY (ID))
END
GO
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Conta')
BEGIN
	CREATE TABLE Conta(
	ID INT IDENTITY(1,1),
	IdUsuario INT,
	NumeroConta INT,
	Ativo BIT,
	Saldo DECIMAL(11,2),
	DataAlteracao DATETIME,
	VersaoRegistro TIMESTAMP,
	PRIMARY KEY(ID),
	FOREIGN KEY (IdUsuario) REFERENCES Usuario(ID))
END
GO
IF NOT EXISTS(SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Transacao')
BEGIN
	CREATE TABLE Transacao(
	ID INT IDENTITY(1,1),
	IdUsuario INT,
	IdContaOrigem INT,
	IdContaDestino INT,
	IdTipoOperacao INT,
	Valor DECIMAL(11,2),
	DataAlteracao DATETIME,
	VersaoRegistro TIMESTAMP,
	PRIMARY KEY(ID),
	FOREIGN KEY (IdUsuario) REFERENCES Usuario(ID),
	FOREIGN KEY (IdContaOrigem) REFERENCES Conta(ID),
	FOREIGN KEY (IdContaDestino) REFERENCES Conta(ID),
	FOREIGN KEY (IdTipoOperacao) REFERENCES TipoOperacao(ID))
END
GO
IF NOT EXISTS (SELECT 1 FROM Usuario WHERE Nome = 'Daniel Augusto') 
BEGIN
	INSERT INTO Usuario (Nome, Ativo, DataAlteracao) VALUES
	('Daniel Augusto', 1, GETDATE())
END
GO
IF NOT EXISTS (SELECT 1 FROM Usuario WHERE Nome = 'Ana Clara') 
BEGIN
	INSERT INTO Usuario (Nome, Ativo, DataAlteracao) VALUES
	('Ana Clara', 1, GETDATE())
END
GO
IF NOT EXISTS (SELECT 1 FROM TipoOperacao WHERE Nome = 'Crédito')
BEGIN
	INSERT INTO TipoOperacao (ID, Nome, DataAlteracao) VALUES
	(1, 'Crédito', GETDATE())
END
GO
IF NOT EXISTS (SELECT 1 FROM TipoOperacao WHERE Nome = 'Débito')
BEGIN
	INSERT INTO TipoOperacao (ID, Nome, DataAlteracao) VALUES
	(2, 'Débito', GETDATE())
END
GO
IF NOT EXISTS (SELECT 1 FROM TipoOperacao WHERE Nome = 'Transferência')
BEGIN
	INSERT INTO TipoOperacao (ID, Nome, DataAlteracao) VALUES
	(3, 'Transferência', GETDATE())
END
GO
IF NOT EXISTS (SELECT 1 FROM Conta WHERE NumeroConta = 1108001)
BEGIN
	INSERT INTO Conta (IdUsuario, NumeroConta, Ativo, Saldo, DataAlteracao) VALUES
	((SELECT ID FROM Usuario WHERE Nome = 'Daniel Augusto'), 1108001, 1, 50.00, GETDATE())
END
GO
IF NOT EXISTS (SELECT 1 FROM Conta WHERE NumeroConta = 1108004) 
BEGIN
	INSERT INTO Conta (IdUsuario, NumeroConta, Ativo, Saldo, DataAlteracao) VALUES
	((SELECT ID FROM Usuario WHERE Nome = 'Ana Clara'), 1108004, 1, 70.00, GETDATE())
END
GO
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'InserirTransacao') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[InserirTransacao]
GO
CREATE PROCEDURE [dbo].[InserirTransacao] 
	--DECLARE
	@IdUsuario INT,
	@IdContaOrigem INT,
	@IdContaDestino INT,
	@IdTipoOperacao INT,
	@Valor DECIMAL(11,2)
AS
BEGIN
	DECLARE @Saldo DECIMAL(11,2)
	SELECT @Saldo = ISNULL(Conta.Saldo,0) FROM Conta WITH(NOLOCK) WHERE Conta.ID = @IdContaOrigem
	IF (@Saldo >= @Valor) 
	BEGIN
		INSERT INTO Transacao (IdUsuario, IdContaOrigem, IdContaDestino, IdTipoOperacao, Valor, DataAlteracao) VALUES
		(@IdUsuario, @IdContaOrigem, @IdContaDestino, @IdTipoOperacao, @Valor, GETDATE());

		UPDATE Conta 
		SET Saldo = (@Saldo - @Valor)
		WHERE ID = @IdContaOrigem

		UPDATE Conta 
		SET Saldo = (Saldo + @Valor)
		WHERE ID = @IdContaDestino

		RETURN 1
	END
	ELSE
		RETURN 0
END
GO