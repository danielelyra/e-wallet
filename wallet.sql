
CREATE TABLE TIPO_CREDITO (
  `id_tipocredito` INT NOT NULL,
  `tipo_credito` VARCHAR(45) NULL,
  `prazo_validade` INT NULL,
  PRIMARY KEY (`id_tipocredito`),
  UNIQUE INDEX `id_tipocredito_UNIQUE` (`id_tipocredito` ASC) VISIBLE)
ENGINE = InnoDB;



CREATE TABLE CLIENTE (
  `id_cliente` INT NOT NULL,
  `nome` VARCHAR(60) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `cpf` VARCHAR(11) NOT NULL,
  `telefone` VARCHAR(15) NULL,
  `email` VARCHAR(60) NULL,
  `endereco` VARCHAR(100) NULL,
  `cep` VARCHAR(8) NULL,
  `estado` VARCHAR(45) NULL,
  `pais` VARCHAR(45) NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE,
  UNIQUE INDEX `cliente_id_UNIQUE` (`id_cliente` ASC) VISIBLE)
ENGINE = InnoDB;


CREATE TABLE WALLET (
  `id_wallet` INT NOT NULL,
  `data_criacao` DATE NULL,
  `id_cliente` INT NOT NULL,
  PRIMARY KEY (`id_wallet`),
  INDEX `fk_WALLET_CLIENTE1_idx` (`id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_WALLET_CLIENTE1`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `CLIENTE` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE TABLE COMPRAS (
  `id_compra` INT NOT NULL,
  `data_compra` DATE NULL,
  `valor_compra` DECIMAL(9,2) NULL,
  `id_wallet` INT NOT NULL,
  PRIMARY KEY (`id_compra`, `id_wallet`),
  INDEX `fk_COMPRAS_WALLET1_idx` (`id_wallet` ASC) VISIBLE,
  CONSTRAINT `fk_COMPRAS_WALLET1`
    FOREIGN KEY (`id_wallet`)
    REFERENCES `WALLET` (`id_wallet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE TABLE CREDITO_VOUCHER (
  `id_credvoucher` INT NOT NULL,
  `valor_voucher` DECIMAL(9,2) NULL,
  `data_criacao` DATETIME NULL,
  `data_expiracao` DATETIME NULL,
  `id_tipocredito` INT NOT NULL,
  `id_compra` INT NULL,
  `id_wallet` INT NOT NULL,
  PRIMARY KEY (`id_credvoucher`, `id_wallet`),
  INDEX `fk_CREDITO_VOUCHER_TIPO_CREDITO1_idx` (`id_tipocredito` ASC) VISIBLE,
  INDEX `fk_CREDITO_VOUCHER_COMPRAS1_idx` (`id_compra` ASC) VISIBLE,
  INDEX `fk_CREDITO_VOUCHER_WALLET1_idx` (`id_wallet` ASC) VISIBLE,
  CONSTRAINT `fk_CREDITO_VOUCHER_TIPO_CREDITO1`
    FOREIGN KEY (`id_tipocredito`)
    REFERENCES `TIPO_CREDITO` (`id_tipocredito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CREDITO_VOUCHER_COMPRAS1`
    FOREIGN KEY (`id_compra`)
    REFERENCES CLIENTE`COMPRAS` (`id_compra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CREDITO_VOUCHER_WALLET1`
    FOREIGN KEY (`id_wallet`)
    REFERENCES `WALLET` (`id_wallet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE TABLE CREDITO_BANCO (
  `id_credbanco` INT NOT NULL,
  `valor_credito` DECIMAL(9,2) NULL,
  `codigo_banco` INT NULL,
  `data_criacao` DATETIME NULL,
  `data_credito` DATETIME NULL,
  `id_tipocredito` INT NOT NULL,
  `id_wallet` INT NOT NULL,
  PRIMARY KEY (`id_credbanco`, `id_wallet`),
  INDEX `fk_CREDITO_BANCO_TIPO_CREDITO1_idx` (`id_tipocredito` ASC) VISIBLE,
  INDEX `fk_CREDITO_BANCO_WALLET1_idx` (`id_wallet` ASC) VISIBLE,
  CONSTRAINT `fk_CREDITO_BANCO_TIPO_CREDITO1`
    FOREIGN KEY (`id_tipocredito`)
    REFERENCES `TIPO_CREDITO` (`id_tipocredito`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CREDITO_BANCO_WALLET1`
    FOREIGN KEY (`id_wallet`)
    REFERENCES `WALLET` (`id_wallet`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


