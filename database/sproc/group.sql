#
# STORED PROCEDURES FOR GROUP
#

USE `doughBros_db`;
DROP procedure IF EXISTS `createGroup`;
DROP procedure IF EXISTS `addUserToGroup`;
DROP procedure IF EXISTS `getAllGroupUsers`;
DROP procedure IF EXISTS `removeUserFromGroup`;
DROP procedure IF EXISTS `getGroupsByUser`;
DROP procedure IF EXISTS `getGroupName`;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `createGroup` (IN `creator_id` INT(8), IN `group_name` VARCHAR(255))
BEGIN

INSERT INTO `group` (`fk_creator_id`, `group_name`)
	VALUES (`creator_id`, `group_name`);

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `addUserToGroup` (IN `group_id` INT(8), IN `user_id` INT(8), IN `added_by` INT(8), IN `did_accept_invite` BOOLEAN)
BEGIN

INSERT INTO `group_membership` (`fk_group_id`, `fk_user_id`, `fk_added_by`, `did_accept_invite`)
	VALUES (`group_id`, `user_id`, `added_by`, `did_accept_invite`);

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `getAllGroupUsers` (IN `group_id` INT(8))
BEGIN

SELECT  FROM `group_membership` WHERE `fk_group_id` = `group_id`;

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `removeUserFromGroup` (IN `group_id` INT(8), IN `user_id` INT(8))
BEGIN

DELETE  FROM `group_membership` WHERE `fk_group_id` = `group_id` AND `fk_user_id` = `user_id`;

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `getGroupsByUser` (IN `user_id` INT(8))
BEGIN 

SELECT  FROM `group_membership` WHERE `fk_user_id` = `user_id`;

END$$

DELIMITER ;

DELIMITER $$
USE `doughBrows_db`$$
CREATE PROCEDURE `getGroupName` (IN `id` INT(8))
BEGIN

SELECT `group_name` FROM `group` WHERE `group_id` = `id`;

END$$

DELIMITER ;