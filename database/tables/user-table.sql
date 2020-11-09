USE `doughBros_db`;
DROP procedure IF EXISTS `createUserTable`;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `user`;
SET FOREIGN_KEY_CHECKS = 1;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `createUserTable` ()
BEGIN

CREATE TABLE `user` (
  `firebase_uid` varchar(255) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email_addr` varchar(255) NOT NULL,
  `facebook_id` varchar(255) NOT NULL,
  `is_anon` bool NOT NULL,
  `fcm_token` varchar(255) NOT NULL,
  PRIMARY KEY (`firebase_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

END$$

DELIMITER ;