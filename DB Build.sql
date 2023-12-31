-- MySQL Script generated by MySQL Workbench
-- Mon Sep 11 22:36:42 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Organisation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Organisation` (
  `idOrganisation` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idOrganisation`),
  UNIQUE INDEX `idOrganisation_UNIQUE` (`idOrganisation` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Creator Account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Creator Account` (
  `creatorID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`creatorID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Organisation Creator`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Organisation Creator` (
  `Organisation_idOrganisation` INT NOT NULL,
  `Creator Account_creatorID` INT NOT NULL,
  PRIMARY KEY (`Organisation_idOrganisation`, `Creator Account_creatorID`),
  INDEX `fk_Organisation_has_Creator Account_Creator Account1_idx` (`Creator Account_creatorID` ASC) VISIBLE,
  INDEX `fk_Organisation_has_Creator Account_Organisation_idx` (`Organisation_idOrganisation` ASC) VISIBLE,
  CONSTRAINT `fk_Organisation_has_Creator Account_Organisation`
    FOREIGN KEY (`Organisation_idOrganisation`)
    REFERENCES `mydb`.`Organisation` (`idOrganisation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Organisation_has_Creator Account_Creator Account1`
    FOREIGN KEY (`Creator Account_creatorID`)
    REFERENCES `mydb`.`Creator Account` (`creatorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Event` (
  `eventID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `bbox` POLYGON NULL,
  `Organisation_idOrganisation` INT NOT NULL,
  PRIMARY KEY (`eventID`, `Organisation_idOrganisation`),
  INDEX `fk_Event_Organisation1_idx` (`Organisation_idOrganisation` ASC) VISIBLE,
  CONSTRAINT `fk_Event_Organisation1`
    FOREIGN KEY (`Organisation_idOrganisation`)
    REFERENCES `mydb`.`Organisation` (`idOrganisation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Activity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Activity` (
  `activityID` INT NOT NULL AUTO_INCREMENT,
  `centreLocation` POINT NOT NULL,
  `polygonLocation` POLYGON NOT NULL,
  `bbox` POLYGON NOT NULL,
  `description` TEXT NULL,
  `startTime` DATETIME NULL,
  `endTime` DATETIME NULL,
  `name` VARCHAR(45) NOT NULL,
  `Event_eventID` INT NOT NULL,
  `Event_Organisation_idOrganisation` INT NOT NULL,
  PRIMARY KEY (`activityID`, `Event_eventID`, `Event_Organisation_idOrganisation`),
  INDEX `fk_Activity_Event1_idx` (`Event_eventID` ASC, `Event_Organisation_idOrganisation` ASC) VISIBLE,
  CONSTRAINT `fk_Activity_Event1`
    FOREIGN KEY (`Event_eventID` , `Event_Organisation_idOrganisation`)
    REFERENCES `mydb`.`Event` (`eventID` , `Organisation_idOrganisation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Activity Creator`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Activity Creator` (
  `Activity_activityID` INT NOT NULL,
  `Creator Account_creatorID` INT NOT NULL,
  PRIMARY KEY (`Activity_activityID`, `Creator Account_creatorID`),
  INDEX `fk_Activity_has_Creator Account_Creator Account1_idx` (`Creator Account_creatorID` ASC) VISIBLE,
  INDEX `fk_Activity_has_Creator Account_Activity1_idx` (`Activity_activityID` ASC) VISIBLE,
  CONSTRAINT `fk_Activity_has_Creator Account_Activity1`
    FOREIGN KEY (`Activity_activityID`)
    REFERENCES `mydb`.`Activity` (`activityID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Activity_has_Creator Account_Creator Account1`
    FOREIGN KEY (`Creator Account_creatorID`)
    REFERENCES `mydb`.`Creator Account` (`creatorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`User Account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`User Account` (
  `userID` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`userID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Join`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Join` (
  `User Account_userID` INT NOT NULL,
  `Event_eventID` INT NOT NULL,
  `Event_Organisation_idOrganisation` INT NOT NULL,
  PRIMARY KEY (`User Account_userID`, `Event_eventID`, `Event_Organisation_idOrganisation`),
  INDEX `fk_User Account_has_Event_Event1_idx` (`Event_eventID` ASC, `Event_Organisation_idOrganisation` ASC) VISIBLE,
  INDEX `fk_User Account_has_Event_User Account1_idx` (`User Account_userID` ASC) VISIBLE,
  CONSTRAINT `fk_User Account_has_Event_User Account1`
    FOREIGN KEY (`User Account_userID`)
    REFERENCES `mydb`.`User Account` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User Account_has_Event_Event1`
    FOREIGN KEY (`Event_eventID` , `Event_Organisation_idOrganisation`)
    REFERENCES `mydb`.`Event` (`eventID` , `Organisation_idOrganisation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Visit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Visit` (
  `User Account_userID` INT NOT NULL,
  `Activity_activityID` INT NOT NULL,
  `Activity_Event_eventID` INT NOT NULL,
  `Activity_Event_Organisation_idOrganisation` INT NOT NULL,
  PRIMARY KEY (`User Account_userID`, `Activity_activityID`, `Activity_Event_eventID`, `Activity_Event_Organisation_idOrganisation`),
  INDEX `fk_User Account_has_Activity_Activity1_idx` (`Activity_activityID` ASC, `Activity_Event_eventID` ASC, `Activity_Event_Organisation_idOrganisation` ASC) VISIBLE,
  INDEX `fk_User Account_has_Activity_User Account1_idx` (`User Account_userID` ASC) VISIBLE,
  CONSTRAINT `fk_User Account_has_Activity_User Account1`
    FOREIGN KEY (`User Account_userID`)
    REFERENCES `mydb`.`User Account` (`userID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User Account_has_Activity_Activity1`
    FOREIGN KEY (`Activity_activityID` , `Activity_Event_eventID` , `Activity_Event_Organisation_idOrganisation`)
    REFERENCES `mydb`.`Activity` (`activityID` , `Event_eventID` , `Event_Organisation_idOrganisation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
