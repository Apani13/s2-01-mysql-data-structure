-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema optics
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema optics
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optics` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `optics` ;

-- -----------------------------------------------------
-- Table `optics`.`contact_information`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optics`.`contact_information` (
  `idcontact_information` INT NOT NULL AUTO_INCREMENT,
  `phone` VARCHAR(20) NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `street_number` INT NOT NULL,
  `floor` INT NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `zip_code` VARCHAR(10) NOT NULL,
  `province_state` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idcontact_information`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optics`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optics`.`customer` (
  `idcustomer` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `email_address` VARCHAR(100) NOT NULL,
  `registration_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `contact_information_idcontact_information` INT NOT NULL,
  PRIMARY KEY (`idcustomer`),
  INDEX `idcontact_information_idx` (`contact_information_idcontact_information` ASC) VISIBLE,
  UNIQUE INDEX `uq_email` (`email_address` ASC) VISIBLE,
  CONSTRAINT `idcontact_information`
    FOREIGN KEY (`contact_information_idcontact_information`)
    REFERENCES `optics`.`contact_information` (`idcontact_information`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optics`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optics`.`employee` (
  `idemployee` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idemployee`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optics`.`sale`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optics`.`sale` (
  `idsale` INT NOT NULL AUTO_INCREMENT,
  `sale_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `customer_idcustomer` INT NOT NULL,
  `employee_idemployee` INT NOT NULL,
  PRIMARY KEY (`idsale`),
  INDEX `idemployee_idx` (`employee_idemployee` ASC) VISIBLE,
  INDEX `idcustomer_idx` (`customer_idcustomer` ASC) VISIBLE,
  CONSTRAINT `idcustomer`
    FOREIGN KEY (`customer_idcustomer`)
    REFERENCES `optics`.`customer` (`idcustomer`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `idemployee`
    FOREIGN KEY (`employee_idemployee`)
    REFERENCES `optics`.`employee` (`idemployee`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optics`.`supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optics`.`supplier` (
  `idsupplier` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `fax` VARCHAR(30) NULL,
  `NIF` VARCHAR(9) NOT NULL,
  `contact_information_idcontact_information` INT NOT NULL,
  PRIMARY KEY (`idsupplier`),
  INDEX `idcontact_information_idx` (`contact_information_idcontact_information` ASC) VISIBLE,
  UNIQUE INDEX `uq_NIF` (`NIF` ASC) VISIBLE,
  CONSTRAINT `idcontact_information`
    FOREIGN KEY (`contact_information_idcontact_information`)
    REFERENCES `optics`.`contact_information` (`idcontact_information`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optics`.`brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optics`.`brand` (
  `idbrand` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `supplier_idsupplier` INT NOT NULL,
  PRIMARY KEY (`idbrand`),
  INDEX `idsupplier_idx` (`supplier_idsupplier` ASC) VISIBLE,
  CONSTRAINT `idsupplier`
    FOREIGN KEY (`supplier_idsupplier`)
    REFERENCES `optics`.`supplier` (`idsupplier`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optics`.`glasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optics`.`glasses` (
  `idglasses` INT NOT NULL AUTO_INCREMENT,
  `brand_idbrand` INT NOT NULL,
  `graduation_left_eye` DECIMAL(4,2) NOT NULL,
  `graduation_right_eye` DECIMAL(4,2) NOT NULL,
  `frame` ENUM('metallic', 'plastic', 'floating') NOT NULL,
  `frame_color` VARCHAR(45) NOT NULL,
  `glass_color` VARCHAR(45) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`idglasses`),
  INDEX `idbrand_idx` (`brand_idbrand` ASC) VISIBLE,
  CONSTRAINT `idbrand`
    FOREIGN KEY (`brand_idbrand`)
    REFERENCES `optics`.`brand` (`idbrand`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optics`.`recommendation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optics`.`recommendation` (
  `idrecommendation` INT NOT NULL AUTO_INCREMENT,
  `recommendation_by` INT NOT NULL,
  PRIMARY KEY (`idrecommendation`),
  INDEX `idcustomer_idx` (`recommendation_by` ASC) VISIBLE,
  CONSTRAINT `idcustomer`
    FOREIGN KEY (`recommendation_by`)
    REFERENCES `optics`.`customer` (`idcustomer`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optics`.`sales_glasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optics`.`sales_glasses` (
  `idsale` INT NOT NULL,
  `idglasses` INT NOT NULL,
  `quantity` INT NOT NULL,
  INDEX `idglasses_idx` (`idglasses` ASC) VISIBLE,
  PRIMARY KEY (`idsale`, `idglasses`),
  CONSTRAINT `idsale`
    FOREIGN KEY (`idsale`)
    REFERENCES `optics`.`sale` (`idsale`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `idglasses`
    FOREIGN KEY (`idglasses`)
    REFERENCES `optics`.`glasses` (`idglasses`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
