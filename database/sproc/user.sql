#
# STORED PROCEDURES FOR USER
#

USE `doughBros_db`;
DROP procedure IF EXISTS `createUser`;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `createUser` (IN `first_name` VARCHAR(100), IN `last_name` VARCHAR(100), IN `email_addr` VARCHAR(255), IN `facebook_id` VARCHAR(255), IN `is_anon` BOOLEAN)
BEGIN

INSERT INTO `user` (`first_name`, `last_name`, `email_addr`, `facebook_id`, `is_anon`)
	VALUES (`first_name`, `last_name`, `email_addr`, `facebook_id`, `is_anon`);

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `getUsers` (IN `user_id` INT(8))
BEGIN

SELECT  FROM `user` WHERE `user_id` = `user_id`;

END$$

DELIMITER ;