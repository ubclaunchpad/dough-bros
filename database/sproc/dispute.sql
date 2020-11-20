#
# STORED PROCEDURES FOR PAYMENT DISPUTES
#

USE `doughBros_db`;
DROP procedure IF EXISTS `createDispute`;
DROP procedure IF EXISTS `resolveDispute`;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `createDispute` (IN `dispute_id` INT(8), IN `initiator_id` INT(8), IN `recipient_id` INT(8), IN `payment_id` INT(8), IN `type` VARCHAR(255), IN `description` VARCHAR(255))
BEGIN

INSERT INTO `dispute` (`fk_creator_id`, `fk_initiator_id`, `fk_recipient_id`, `fk_recipient_id`, `dispute_type`, `dispute_description`)
	VALUES (`dispute_id`, `initiator_id`, `recipient_id`, `recipient_id`, `type`, `description`);

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `resolveDispute` (IN `dispute_id` INT(8))
BEGIN

DELETE FROM `dispute` WHERE `dispute_id` = `dispute_id`;

END$$

DELIMITER ;
