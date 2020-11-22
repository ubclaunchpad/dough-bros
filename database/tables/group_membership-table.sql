USE `doughBros_db`;
DROP procedure IF EXISTS `createGroupMembershipTable`;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `group_membership`;
SET FOREIGN_KEY_CHECKS = 1;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `createGroupMembershipTable` ()
BEGIN

CREATE TABLE `group_membership` (
  `fk_group_id` int(9) unsigned NOT NULL,
  `fk_user_id` varchar(255) NOT NULL,
  `fk_added_by_id` varchar(255) NOT NULL,
  `did_accept_invite` BOOLEAN DEFAULT 0 NOT NULL,
  FOREIGN KEY (`fK_group_id`)
	  REFERENCES `group` (`group_id`)
    ON DELETE CASCADE,
  FOREIGN KEY (`fk_user_id`)
	  REFERENCES `user` (`firebase_uid`)
    ON DELETE CASCADE,
  FOREIGN KEY (`fk_added_by_id`)
	  REFERENCES `user` (`firebase_uid`)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

END$$

DELIMITER ;