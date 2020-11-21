#
# STORED PROCEDURES FOR GROUP
#

USE `doughBros_db`;
DROP procedure IF EXISTS `createGroup`;
DROP procedure IF EXISTS `addUserToGroup`;
DROP procedure IF EXISTS `getAllGroupUsers`;
DROP procedure IF EXISTS `removeUserFromGroup`;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `createGroup` (IN `creator_id` VARCHAR(255), IN `group_name` VARCHAR(255))
BEGIN

INSERT INTO `group` (`fk_creator_id`, `group_name`)
	VALUES (`creator_id`, `group_name`);

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `addUserToGroup` (IN `group_id` INT(8), IN `user_id` VARCHAR(255), IN `added_by_id` VARCHAR(255), IN `did_accept_invite` BOOLEAN)
BEGIN

INSERT INTO `group_membership` (`fk_group_id`, `fk_user_id`, `fk_added_by_id`, `did_accept_invite`)
	VALUES (`group_id`, `user_id`, `added_by_id`, `did_accept_invite`);

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `getAllGroupUsers` (IN `group_id` INT(8))
BEGIN

SELECT * FROM `group_membership` WHERE `fk_group_id` = `group_id`;

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `removeUserFromGroup` (IN `group_id` INT(8), IN `user_id` VARCHAR(255))
BEGIN

DELETE FROM `group_membership` WHERE `fk_group_id` = `group_id` AND `fk_user_id` = `user_id`;

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `acceptGroupMembership` (IN `group_id` INT(8), IN `user_id` VARCHAR(255))
BEGIN

UPDATE `group_membership`
SET `did_accept_invite` = 1 WHERE (`fk_group_id` = `group_id` AND `fk_user_id` = `user_id`);

END$$

DELIMITER ;


