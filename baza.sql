-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema botcoder
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema botcoder
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `botcoder` DEFAULT CHARACTER SET utf8 ;
USE `botcoder` ;

-- -----------------------------------------------------
-- Table `botcoder`.`Country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `botcoder`.`Country` ;

CREATE TABLE IF NOT EXISTS `botcoder`.`Country` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `botcoder`.`Organizations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `botcoder`.`Organizations` ;

CREATE TABLE IF NOT EXISTS `botcoder`.`Organizations` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `coun_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Organizations_Country_idx` (`coun_id` ASC) VISIBLE,
  CONSTRAINT `fk_Organizations_Country`
    FOREIGN KEY (`coun_id`)
    REFERENCES `botcoder`.`Country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `botcoder`.`Images`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `botcoder`.`Images` ;

CREATE TABLE IF NOT EXISTS `botcoder`.`Images` (
  `id` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `botcoder`.`UserTypes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `botcoder`.`UserTypes` ;

CREATE TABLE IF NOT EXISTS `botcoder`.`UserTypes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `botcoder`.`Users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `botcoder`.`Users` ;

CREATE TABLE IF NOT EXISTS `botcoder`.`Users` (
  `username` VARCHAR(32) NOT NULL,
  `password_hash` VARCHAR(89) NOT NULL,
  `name` VARCHAR(32) NOT NULL,
  `surname` VARCHAR(32) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `org_id` INT NULL,
  `coun_id` INT NULL,
  `img_id` VARCHAR(16) NULL,
  `type_id` INT NOT NULL,
  PRIMARY KEY (`username`),
  INDEX `fk_Users_Organizations1_idx` (`org_id` ASC) VISIBLE,
  INDEX `fk_Users_Country1_idx` (`coun_id` ASC) VISIBLE,
  INDEX `fk_Users_Images1_idx` (`img_id` ASC) VISIBLE,
  INDEX `fk_Users_UserTypes1_idx` (`type_id` ASC) VISIBLE,
  FULLTEXT INDEX `username` (`username`) VISIBLE,
  CONSTRAINT `fk_Users_Organizations1`
    FOREIGN KEY (`org_id`)
    REFERENCES `botcoder`.`Organizations` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Users_Country1`
    FOREIGN KEY (`coun_id`)
    REFERENCES `botcoder`.`Country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Users_Images1`
    FOREIGN KEY (`img_id`)
    REFERENCES `botcoder`.`Images` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Users_UserTypes1`
    FOREIGN KEY (`type_id`)
    REFERENCES `botcoder`.`UserTypes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `botcoder`.`Sessions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `botcoder`.`Sessions` ;

CREATE TABLE IF NOT EXISTS `botcoder`.`Sessions` (
  `id` VARCHAR(16) NOT NULL,
  `username` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Sessions_Users1_idx` (`username` ASC) VISIBLE,
  CONSTRAINT `fk_Sessions_Users1`
    FOREIGN KEY (`username`)
    REFERENCES `botcoder`.`Users` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `botcoder`.`Competitions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `botcoder`.`Competitions` ;

CREATE TABLE IF NOT EXISTS `botcoder`.`Competitions` (
  `id` VARCHAR(16) NOT NULL,
  `name` VARCHAR(128) NOT NULL,
  `description` VARCHAR(4096) NULL,
  `start` TIMESTAMP NOT NULL,
  `end` TIMESTAMP NOT NULL,
  `public` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  FULLTEXT INDEX `name` (`name`) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `botcoder`.`TaskTypes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `botcoder`.`TaskTypes` ;

CREATE TABLE IF NOT EXISTS `botcoder`.`TaskTypes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `botcoder`.`ProgrammingLanguages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `botcoder`.`ProgrammingLanguages` ;

CREATE TABLE IF NOT EXISTS `botcoder`.`ProgrammingLanguages` (
  `id` INT NOT NULL,
  `extension` VARCHAR(8) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `botcoder`.`Tasks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `botcoder`.`Tasks` ;

CREATE TABLE IF NOT EXISTS `botcoder`.`Tasks` (
  `id` VARCHAR(16) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `time_limit` INT NOT NULL,
  `memory_limit` INT NOT NULL,
  `ram_limit` INT NOT NULL,
  `task_type_id` INT NOT NULL,
  `username` VARCHAR(32) NOT NULL,
  `checker_pl_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Tasks_TaskTypes1_idx` (`task_type_id` ASC) VISIBLE,
  INDEX `fk_Tasks_Users1_idx` (`username` ASC) VISIBLE,
  FULLTEXT INDEX `name` (`name`) VISIBLE,
  INDEX `fk_Tasks_ProgrammingLanguages1_idx` (`checker_pl_id` ASC) VISIBLE,
  CONSTRAINT `fk_Tasks_TaskTypes1`
    FOREIGN KEY (`task_type_id`)
    REFERENCES `botcoder`.`TaskTypes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tasks_Users1`
    FOREIGN KEY (`username`)
    REFERENCES `botcoder`.`Users` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tasks_ProgrammingLanguages1`
    FOREIGN KEY (`checker_pl_id`)
    REFERENCES `botcoder`.`ProgrammingLanguages` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `botcoder`.`SubmissionStatus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `botcoder`.`SubmissionStatus` ;

CREATE TABLE IF NOT EXISTS `botcoder`.`SubmissionStatus` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `botcoder`.`Submissions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `botcoder`.`Submissions` ;

CREATE TABLE IF NOT EXISTS `botcoder`.`Submissions` (
  `id` VARCHAR(20) NOT NULL,
  `username` VARCHAR(32) NOT NULL,
  `status_id` INT NOT NULL,
  `score` DOUBLE NULL,
  `time` INT NULL,
  `memory` INT NULL,
  `ram` INT NULL,
  `task_id` VARCHAR(16) NOT NULL,
  `comp_id` VARCHAR(16) NULL,
  `arival_time` TIMESTAMP NOT NULL,
  `pl_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Submissions_Users1_idx` (`username` ASC) VISIBLE,
  INDEX `fk_Submitions_SubmissionStatus1_idx` (`status_id` ASC) VISIBLE,
  INDEX `fk_Submissions_Tasks1_idx` (`task_id` ASC) VISIBLE,
  INDEX `fk_Submissions_Competitions1_idx` (`comp_id` ASC) VISIBLE,
  INDEX `fk_Submissions_ProgrammingLanguages1_idx` (`pl_id` ASC) VISIBLE,
  CONSTRAINT `fk_Submissions_Users1`
    FOREIGN KEY (`username`)
    REFERENCES `botcoder`.`Users` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Submissions_SubmisionStatus1`
    FOREIGN KEY (`status_id`)
    REFERENCES `botcoder`.`SubmissionStatus` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Submissions_Tasks1`
    FOREIGN KEY (`task_id`)
    REFERENCES `botcoder`.`Tasks` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Submissions_Competitions1`
    FOREIGN KEY (`comp_id`)
    REFERENCES `botcoder`.`Competitions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Submissions_ProgrammingLanguages1`
    FOREIGN KEY (`pl_id`)
    REFERENCES `botcoder`.`ProgrammingLanguages` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `botcoder`.`TestCases`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `botcoder`.`TestCases` ;

CREATE TABLE IF NOT EXISTS `botcoder`.`TestCases` (
  `id` VARCHAR(16) NOT NULL,
  `task_id` VARCHAR(16) NOT NULL,
  `num` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_TestCases_Tasks1_idx` (`task_id` ASC) VISIBLE,
  CONSTRAINT `fk_TestCases_Tasks1`
    FOREIGN KEY (`task_id`)
    REFERENCES `botcoder`.`Tasks` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `botcoder`.`CompetitionTasks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `botcoder`.`CompetitionTasks` ;

CREATE TABLE IF NOT EXISTS `botcoder`.`CompetitionTasks` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comp_id` VARCHAR(16) NOT NULL,
  `task_id` VARCHAR(16) NOT NULL,
  `num` INT NOT NULL,
  INDEX `fk_CompetitionTasks_Competitions1_idx` (`comp_id` ASC) VISIBLE,
  INDEX `fk_CompetitionTasks_Tasks1_idx` (`task_id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_CompetitionTasks_Competitions1`
    FOREIGN KEY (`comp_id`)
    REFERENCES `botcoder`.`Competitions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CompetitionTasks_Tasks1`
    FOREIGN KEY (`task_id`)
    REFERENCES `botcoder`.`Tasks` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `botcoder`.`Rating`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `botcoder`.`Rating` ;

CREATE TABLE IF NOT EXISTS `botcoder`.`Rating` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(32) NOT NULL,
  `comp_id` VARCHAR(16) NOT NULL,
  `rating` DOUBLE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Raiting_Users1_idx` (`username` ASC) VISIBLE,
  INDEX `fk_Raiting_Competitions1_idx` (`comp_id` ASC) VISIBLE,
  CONSTRAINT `fk_Raiting_Users1`
    FOREIGN KEY (`username`)
    REFERENCES `botcoder`.`Users` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Raiting_Competitions1`
    FOREIGN KEY (`comp_id`)
    REFERENCES `botcoder`.`Competitions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `botcoder`.`Creators`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `botcoder`.`Creators` ;

CREATE TABLE IF NOT EXISTS `botcoder`.`Creators` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `competition_id` VARCHAR(16) NOT NULL,
  `username` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Creators_Competitions1_idx` (`competition_id` ASC) VISIBLE,
  INDEX `fk_Creators_Users1_idx` (`username` ASC) VISIBLE,
  CONSTRAINT `fk_Creators_Competitions1`
    FOREIGN KEY (`competition_id`)
    REFERENCES `botcoder`.`Competitions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Creators_Users1`
    FOREIGN KEY (`username`)
    REFERENCES `botcoder`.`Users` (`username`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `botcoder`.`UserTypes`
-- -----------------------------------------------------
START TRANSACTION;
USE `botcoder`;
INSERT INTO `botcoder`.`UserTypes` (`id`, `type`) VALUES (1, 'user');
INSERT INTO `botcoder`.`UserTypes` (`id`, `type`) VALUES (2, 'moderator');
INSERT INTO `botcoder`.`UserTypes` (`id`, `type`) VALUES (3, 'admin');
INSERT INTO `botcoder`.`UserTypes` (`id`, `type`) VALUES (4, 'judge');

COMMIT;


-- -----------------------------------------------------
-- Data for table `botcoder`.`Users`
-- -----------------------------------------------------
START TRANSACTION;
USE `botcoder`;
INSERT INTO `botcoder`.`Users` (`username`, `password_hash`, `name`, `surname`, `email`, `org_id`, `coun_id`, `img_id`, `type_id`) VALUES ('_TvUuAuSPCafOK9_VL2U4w', 'Qmh6O2ZObz330tC6nlfZV7/slAYFOf5UPKHlTbPdImM=$Ogn4oRCgztG3vyrPG55y9rD9JDipIC5zjBt+E0lBg/E=', 'judge', 'host', 'problem judge', NULL, NULL, NULL, 4);
INSERT INTO `botcoder`.`Users` (`username`, `password_hash`, `name`, `surname`, `email`, `org_id`, `coun_id`, `img_id`, `type_id`) VALUES ('judge', 'judgejudge', 'judge', 'host', 'asd', NULL, NULL, NULL, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `botcoder`.`TaskTypes`
-- -----------------------------------------------------
START TRANSACTION;
USE `botcoder`;
INSERT INTO `botcoder`.`TaskTypes` (`id`, `name`) VALUES (1, 'classical');
INSERT INTO `botcoder`.`TaskTypes` (`id`, `name`) VALUES (2, 'bot_1v1');
INSERT INTO `botcoder`.`TaskTypes` (`id`, `name`) VALUES (3, 'bot_2v2');
INSERT INTO `botcoder`.`TaskTypes` (`id`, `name`) VALUES (4, 'bot_4');

COMMIT;


-- -----------------------------------------------------
-- Data for table `botcoder`.`ProgrammingLanguages`
-- -----------------------------------------------------
START TRANSACTION;
USE `botcoder`;
INSERT INTO `botcoder`.`ProgrammingLanguages` (`id`, `extension`) VALUES (1, 'c');
INSERT INTO `botcoder`.`ProgrammingLanguages` (`id`, `extension`) VALUES (2, 'cpp');
INSERT INTO `botcoder`.`ProgrammingLanguages` (`id`, `extension`) VALUES (3, 'java');
INSERT INTO `botcoder`.`ProgrammingLanguages` (`id`, `extension`) VALUES (4, 'py2');
INSERT INTO `botcoder`.`ProgrammingLanguages` (`id`, `extension`) VALUES (5, 'py3');

COMMIT;


-- -----------------------------------------------------
-- Data for table `botcoder`.`SubmissionStatus`
-- -----------------------------------------------------
START TRANSACTION;
USE `botcoder`;
INSERT INTO `botcoder`.`SubmissionStatus` (`id`, `description`) VALUES (1, 'QUE');
INSERT INTO `botcoder`.`SubmissionStatus` (`id`, `description`) VALUES (2, 'RTE');
INSERT INTO `botcoder`.`SubmissionStatus` (`id`, `description`) VALUES (3, 'MLE');
INSERT INTO `botcoder`.`SubmissionStatus` (`id`, `description`) VALUES (4, 'SLE');
INSERT INTO `botcoder`.`SubmissionStatus` (`id`, `description`) VALUES (5, 'TLE');
INSERT INTO `botcoder`.`SubmissionStatus` (`id`, `description`) VALUES (6, 'CE');
INSERT INTO `botcoder`.`SubmissionStatus` (`id`, `description`) VALUES (7, 'RUN');
INSERT INTO `botcoder`.`SubmissionStatus` (`id`, `description`) VALUES (8, 'ACC');

COMMIT;

