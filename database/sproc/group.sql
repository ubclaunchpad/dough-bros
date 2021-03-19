#
# STORED PROCEDURES FOR GROUP
#

USE `doughBros_db`;
DROP procedure IF EXISTS `createGroup`;
DROP procedure IF EXISTS `addUserToGroup`;
DROP procedure IF EXISTS `getAllGroupUsers`;
DROP procedure IF EXISTS `removeUserFromGroup`;
DROP procedure IF EXISTS `acceptGroupMembership`;
DROP procedure IF EXISTS `getAllAcceptedGroupUsers`;
DROP procedure IF EXISTS `setGroupName`;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `createGroup` (IN `creator_id` VARCHAR(255), IN `group_name` VARCHAR(255), IN `image_uri` VARCHAR(255), IN `amount` FLOAT(8))
BEGIN

INSERT INTO `group` (`fk_creator_id`, `group_name`, `image_uri`, `amount`)
	VALUES (`creator_id`, `group_name`, `image_uri`, `amount`);

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
CREATE PROCEDURE `getGroupByUID` (IN `user_id` VARCHAR(255))
BEGIN

SELECT `group_id`, `fk_creator_id` as `creator_id`, `group_name`, `image_uri`, `amount`
FROM `group`
WHERE `fk_creator_id` = `user_id`
UNION
SELECT `group_id`, `fk_creator_id` as `creator_id`, `group_name`, `image_uri`, `amount` FROM `group` as g
JOIN (SELECT `fk_group_id` FROM `group_membership` WHERE `fk_user_id` = `user_id` AND `did_accept_invite` = 1) as mb
ON mb.fk_group_id=g.group_id;

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `getPendingGroupByUID` (IN `user_id` VARCHAR(255))
BEGIN

SELECT `group_id`, `fk_creator_id` as `creator_id`, `group_name`, `image_uri`, `amount` FROM `group` as g
JOIN (SELECT `fk_group_id` FROM `group_membership` WHERE `fk_user_id` = `user_id` AND `did_accept_invite` = 0) as mb
ON mb.fk_group_id=g.group_id;

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `getAllGroupUsers` (IN `group_id` INT(8))
BEGIN

SELECT * FROM `user` as u
JOIN (SELECT * FROM `group_membership` WHERE `fk_group_id` = `group_id`) as mb
ON mb.fk_user_id=u.firebase_uid;

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

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `getAllAcceptedGroupUsers` (IN `group_id` INT(8))
BEGIN

SELECT * FROM `group_membership` WHERE (`fk_group_id` = `group_id` AND `did_accept_invite` = 1);

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `setGroupName` (IN `group_details_id` INT(8), IN `group_name` VARCHAR(255))
BEGIN

UPDATE `group`
SET `group_name` = `group_name` WHERE (`group_id` = `group_details_id`);

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `deleteGroup` (IN `group_id` INT(8))
BEGIN

DELETE FROM `group` WHERE `group_id` = `group_id`;

END$$

DELIMITER ;
