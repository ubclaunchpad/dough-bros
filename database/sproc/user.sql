#
# STORED PROCEDURES FOR USER
#

USE `doughBros_db`;
DROP procedure IF EXISTS `createUser`;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `createUser` (IN `firebase_uid` VARCHAR(255), IN `first_name` VARCHAR(100), IN `last_name` VARCHAR(100), IN `email_addr` VARCHAR(255), IN `facebook_id` VARCHAR(255), IN `is_anon` BOOLEAN, IN `fcm_token` VARCHAR(255))
BEGIN

INSERT INTO `user` (`firebase_uid`, `first_name`, `last_name`, `email_addr`, `facebook_id`, `is_anon`, `fcm_token`)
	VALUES (`firebase_uid`, `first_name`, `last_name`, `email_addr`, `facebook_id`, `is_anon`, `fcm_token`)
	ON DUPLICATE KEY UPDATE
		`first_name` = `first_name`,
		`last_name` = `last_name`,
		`email_addr` = `email_addr`,
		`facebook_id` = `facebook_id`,
		`is_anon` = `is_anon`,
		`fcm_token` = `fcm_token`;

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `getUsers` (IN `user_id` INT(8))
BEGIN

SELECT * FROM `user` WHERE `user_id` = `user_id`;

END$$

DELIMITER ;