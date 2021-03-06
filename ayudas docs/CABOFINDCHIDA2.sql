SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

USE `cabofind_cabofind` ;

-- -----------------------------------------------------
-- Table `cabofind_cabofind`.`categorias`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `cabofind_cabofind`.`categorias` (
  `ID_CATEGORIA` INT(11) NOT NULL AUTO_INCREMENT ,
  `CAT_NOMBRE` VARCHAR(30) NULL DEFAULT NULL ,
  `CAT_ESTATUS` VARCHAR(2) NULL DEFAULT NULL ,
  `CAT_URL` VARCHAR(50) NULL DEFAULT NULL ,
  PRIMARY KEY (`ID_CATEGORIA`) )
ENGINE = InnoDB
AUTO_INCREMENT = 59
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cabofind_cabofind`.`subcategoria`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `cabofind_cabofind`.`subcategoria` (
  `ID_SUBCATEGORIA` INT(11) NOT NULL AUTO_INCREMENT ,
  `SUB_NOMBRE` VARCHAR(30) NULL DEFAULT NULL ,
  `SUB_ESTATUS` VARCHAR(2) NULL DEFAULT NULL ,
  `ID_CATEGORIA` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`ID_SUBCATEGORIA`) ,
  INDEX `ID_CATEGORIA_idx` (`ID_CATEGORIA` ASC) ,
  CONSTRAINT `ID_CATEGORIA`
    FOREIGN KEY (`ID_CATEGORIA` )
    REFERENCES `cabofind_cabofind`.`categorias` (`ID_CATEGORIA` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 24
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cabofind_cabofind`.`exposicion`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `cabofind_cabofind`.`exposicion` (
  `ID_EXPOSICION` INT(11) NOT NULL AUTO_INCREMENT ,
  `EXP_NIVEL` VARCHAR(25) NOT NULL ,
  `EXP_FECHA_ALTA` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `EXP_FECHA_CADUCIDAD` VARCHAR(25) NOT NULL ,
  PRIMARY KEY (`ID_EXPOSICION`) )
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cabofind_cabofind`.`negocios`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `cabofind_cabofind`.`negocios` (
  `ID_NEGOCIO` INT(11) NOT NULL AUTO_INCREMENT ,
  `NEG_NOMBRE` VARCHAR(50) NULL DEFAULT NULL ,
  `NEG_CORREO` VARCHAR(45) NULL DEFAULT NULL ,
  `NEG_TEL` INT(10) NULL DEFAULT NULL ,
  `NEG_DIRECCION` VARCHAR(80) NULL DEFAULT NULL ,
  `NEG_DESCRIPCION` VARCHAR(255) NULL DEFAULT NULL ,
  `NEG_DESCRIPCION_ENG` VARCHAR(255) NULL DEFAULT NULL ,
  `NEG_RESPONSABLE` VARCHAR(45) NULL DEFAULT NULL ,
  `NEG_ESTATUS` VARCHAR(2) NULL DEFAULT NULL ,
  `NEG_ETIQUETAS` VARCHAR(500) NULL DEFAULT NULL ,
  `NEG_ETIQUETAS_ING` VARCHAR(500) NULL ,
  `NEG_FECHA` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `NEG_MAP` VARCHAR(1000) NULL ,
  `ID_SUBCATEGORIA` INT(11) NULL DEFAULT NULL ,
  `exposicion_ID_EXPOSICION` INT(11) NOT NULL ,
  PRIMARY KEY (`ID_NEGOCIO`) ,
  INDEX `ID_SUBCATEGORIA_idx` (`ID_SUBCATEGORIA` ASC) ,
  INDEX `fk_negocios_exposicion1_idx` (`exposicion_ID_EXPOSICION` ASC) ,
  CONSTRAINT `ID_SUBCATEGORIA`
    FOREIGN KEY (`ID_SUBCATEGORIA` )
    REFERENCES `cabofind_cabofind`.`subcategoria` (`ID_SUBCATEGORIA` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_negocios_exposicion1`
    FOREIGN KEY (`exposicion_ID_EXPOSICION` )
    REFERENCES `cabofind_cabofind`.`exposicion` (`ID_EXPOSICION` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 22
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cabofind_cabofind`.`caracteristicas`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `cabofind_cabofind`.`caracteristicas` (
  `ID_CARACTERISTICAS` INT(11) NOT NULL AUTO_INCREMENT ,
  `CAR_NOMBRE` VARCHAR(45) NULL DEFAULT NULL ,
  `CAR_NOMBRE_ENG` VARCHAR(45) NULL DEFAULT NULL ,
  `CAR_ESTATUS` VARCHAR(45) NULL DEFAULT NULL ,
  `CAR_FECHA` TIMESTAMP NULL DEFAULT NULL ,
  `negocios_ID_NEGOCIO` INT(11) NOT NULL ,
  PRIMARY KEY (`ID_CARACTERISTICAS`) ,
  INDEX `fk_caracteristicas_negocios1_idx` (`negocios_ID_NEGOCIO` ASC) ,
  CONSTRAINT `fk_caracteristicas_negocios1`
    FOREIGN KEY (`negocios_ID_NEGOCIO` )
    REFERENCES `cabofind_cabofind`.`negocios` (`ID_NEGOCIO` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cabofind_cabofind`.`galeria`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `cabofind_cabofind`.`galeria` (
  `ID_GALERIA` INT(11) NOT NULL AUTO_INCREMENT ,
  `GAL_FOTO` VARCHAR(255) NULL DEFAULT NULL ,
  `GAL_TIPO` VARCHAR(255) NULL DEFAULT NULL ,
  `GAL_ESTATUS` VARCHAR(2) NULL DEFAULT NULL ,
  `ID_NEGOCIO` INT(11) NULL DEFAULT NULL ,
  PRIMARY KEY (`ID_GALERIA`) ,
  INDEX `ID_NEGOCIO_idx` (`ID_NEGOCIO` ASC) ,
  CONSTRAINT `ID_NEGOCIO`
    FOREIGN KEY (`ID_NEGOCIO` )
    REFERENCES `cabofind_cabofind`.`negocios` (`ID_NEGOCIO` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 21
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `cabofind_cabofind`.`publicacion`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `cabofind_cabofind`.`publicacion` (
  `ID_PUBLICACION` INT(11) NOT NULL AUTO_INCREMENT ,
  `PUB_TITULO` VARCHAR(45) NULL DEFAULT NULL ,
  `PUB_TITULO_ING` VARCHAR(45) NOT NULL ,
  `PUB_DETALLE` VARCHAR(45) NULL DEFAULT NULL ,
  `PUB_DETALLE_ING` VARCHAR(45) NOT NULL ,
  `PUB_FECHA` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ,
  `PUB_VIDEO` VARCHAR(100) NULL DEFAULT NULL ,
  `negocios_ID_NEGOCIO` INT(11) NOT NULL ,
  `galeria_ID_GALERIA` INT(11) NOT NULL ,
  PRIMARY KEY (`ID_PUBLICACION`) ,
  INDEX `fk_PUBLICACION_negocios1_idx` (`negocios_ID_NEGOCIO` ASC) ,
  INDEX `fk_publicacion_galeria1_idx` (`galeria_ID_GALERIA` ASC) ,
  CONSTRAINT `fk_PUBLICACION_negocios1`
    FOREIGN KEY (`negocios_ID_NEGOCIO` )
    REFERENCES `cabofind_cabofind`.`negocios` (`ID_NEGOCIO` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_publicacion_galeria1`
    FOREIGN KEY (`galeria_ID_GALERIA` )
    REFERENCES `cabofind_cabofind`.`galeria` (`ID_GALERIA` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 44
DEFAULT CHARACTER SET = latin1;

USE `cabofind_cabofind` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
