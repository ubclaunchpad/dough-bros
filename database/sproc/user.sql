#
# STORED PROCEDURES FOR USER
#

USE `doughBros_db`;
DROP procedure IF EXISTS `createUser`;
DROP procedure IF EXISTS `getUser`;
DROP procedure IF EXISTS `getUserByEmail`;
DROP procedure IF EXISTS `getUserByPatternMatching`;

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
CREATE PROCEDURE `getUserByPatternMatching` (IN `search` VARCHAR(255))
BEGIN

SELECT * FROM `user`
WHERE ((`email_addr` REGEXP `search`)
OR (`first_name` REGEXP `search`)
OR (`last_name` REGEXP `search`));

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `getUserByUID` (IN `uid` VARCHAR(255))
BEGIN

SELECT * FROM `user` WHERE `firebase_uid` = `uid`;

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `getUserByEmail` (IN `email` VARCHAR(255))
BEGIN

SELECT * FROM `user` WHERE `email_addr` = `email`;

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `findOwner` (IN `group` INT(8))
BEGIN

SELECT * FROM `user` as u
JOIN (SELECT * FROM `group` WHERE `group_id`=`group`) as g
on g.fk_creator_id=u.firebase_uid;

END$$

DELIMITER ;