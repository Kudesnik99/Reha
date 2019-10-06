-- MySQL Script generated by MySQL Workbench
-- Sun Oct  6 15:27:37 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema reha
-- -----------------------------------------------------
-- Java School task DB.

-- -----------------------------------------------------
-- Schema reha
--
-- Java School task DB.
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `reha` DEFAULT CHARACTER SET utf8 ;
USE `reha` ;

-- -----------------------------------------------------
-- Table `reha`.`Event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reha`.`Event` (
  `event_id` INT NOT NULL AUTO_INCREMENT,
  `patient_id` INT NOT NULL,
  `treatment_id` INT NOT NULL COMMENT 'Which treatment creates this event.',
  `date_time` DATETIME NOT NULL,
  `status` TINYINT NOT NULL,
  `remedy_id` INT NOT NULL,
  `reason` VARCHAR(45) NULL,
  PRIMARY KEY (`event_id`),
  INDEX `patient_id_idx` (`patient_id` ASC) VISIBLE,
  INDEX `treatment_id_idx` (`treatment_id` ASC) VISIBLE,
  CONSTRAINT `ev_patient_id`
    FOREIGN KEY (`patient_id`)
    REFERENCES `reha`.`Patient` (`patient_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `ev_treatment_id`
    FOREIGN KEY (`treatment_id`)
    REFERENCES `reha`.`Treatment` (`treatment_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reha`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reha`.`Patient` (
  `patient_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL,
  `second_name` VARCHAR(45) NOT NULL,
  ` diagnosis` VARCHAR(45) NULL,
  ` insurance_num` INT NULL,
  `doctor_id` INT NOT NULL,
  `discharged` TINYINT NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`patient_id`),
  INDEX `doctor_id_idx` (`doctor_id` ASC) VISIBLE,
  CONSTRAINT `pat_doctor_id`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `reha`.`User` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reha`.`Remedy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reha`.`Remedy` (
  `remedy_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `type` TINYINT NOT NULL,
  `unit` VARCHAR(10) NULL,
  PRIMARY KEY (`remedy_id`),
  INDEX `idx_name` (`type` ASC, `name` ASC) INVISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reha`.`Treatment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reha`.`Treatment` (
  `treatment_id` INT NOT NULL AUTO_INCREMENT,
  `patient_id` INT NOT NULL,
  `time_pattern` VARCHAR(45) NOT NULL,
  `time_pattern_modifier` VARCHAR(45) NULL,
  `period` DATE NULL,
  `dose` INT NOT NULL,
  `status` VARCHAR(45) NOT NULL COMMENT 'assigned\nprocessing\nexecuted\npartly_executed\ncanseled\n',
  `treatment_result` VARCHAR(90) NULL,
  `remedy_id` INT NOT NULL,
  PRIMARY KEY (`treatment_id`),
  INDEX `patient_id_idx` (`patient_id` ASC) VISIBLE,
  INDEX `remedy_id_idx` (`remedy_id` ASC) VISIBLE,
  CONSTRAINT `tr_patient_id`
    FOREIGN KEY (`patient_id`)
    REFERENCES `reha`.`Patient` (`patient_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `tr_remedy_id`
    FOREIGN KEY (`remedy_id`)
    REFERENCES `reha`.`Remedy` (`remedy_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `reha`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `reha`.`User` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL,
  `second_name` VARCHAR(45) NOT NULL,
  `role` TINYINT NOT NULL,
  `avatar` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `login` VARCHAR(45) NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `login_UNIQUE` (`login` ASC) VISIBLE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
