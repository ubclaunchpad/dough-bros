#
# STORED PROCEDURES FOR USER
#

USE `doughBros_db`;
DROP procedure IF EXISTS `createUser`;
DROP procedure IF EXISTS `getGroupsByUser`;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `createUser` (IN `first_name` VARCHAR(100), IN `last_name` VARCHAR(100), IN `email_addr` VARCHAR(255), IN `facebook_id` VARCHAR(255), IN `is_anon` BOOLEAN)
BEGIN

INSERT INTO `user` (`first_name`, `last_name`, `email_addr`, `facebook_id`, `is_anon`)
	VALUES (`first_name`, `last_name`, `email_addr`, `facebook_id`, `is_anon`);

END$$

DELIMITER ;