USE `doughBros_db`;
DROP procedure IF EXISTS `createPendingAnonUserTable`;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `pending_anon_user`;
SET FOREIGN_KEY_CHECKS = 1;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `createPendingAnonUserTable` ()
BEGIN

CREATE TABLE `pending_anon_user` (
  `request_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `fk_added_by` int(9) unsigned NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email_addr` varchar(255) NOT NULL,
  `facebook_id` varchar(255) NOT NULL,
  PRIMARY KEY (`request_id`),
  FOREIGN KEY (`fk_added_by`)
	REFERENCES `user` (`user_id`)
    ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

END$$

DELIMITER ;