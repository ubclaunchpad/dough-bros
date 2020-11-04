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
  `fk_user_id` int(9) unsigned NOT NULL,
  `fk_added_by` int(9) unsigned NOT NULL,
  `did_accept_invite` bool NOT NULL,
  FOREIGN KEY (`fK_group_id`)
	REFERENCES `group` (`group_id`)
    ON DELETE CASCADE,
  FOREIGN KEY (`fk_user_id`)
	REFERENCES `user` (`user_id`)
    ON DELETE CASCADE,
  FOREIGN KEY (`fk_added_by`)
	REFERENCES `user` (`user_id`)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

END$$

DELIMITER ;