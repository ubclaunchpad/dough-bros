USE `doughBros_db`;
DROP procedure IF EXISTS `createGroupTable`;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `group`;
SET FOREIGN_KEY_CHECKS = 1;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `createGroupTable` ()
BEGIN

CREATE TABLE `group` (
  `group_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `fk_creator_id` int(9) unsigned NOT NULL,
  `group_name` int(9) unsigned NOT NULL,
  PRIMARY KEY (`group_id`),
  FOREIGN KEY (`fk_creator_id`)
	REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

END$$

DELIMITER ;