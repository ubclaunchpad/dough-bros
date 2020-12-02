USE `doughBros_db`;
DROP procedure IF EXISTS `createCurrencyTable`;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `currency`;
SET FOREIGN_KEY_CHECKS = 1;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `createCurrencyTable` ()
BEGIN

CREATE TABLE `currency` (
  `currency_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `currency_name` varchar(255),
  `currency_code` varchar(10),
  PRIMARY KEY (`currency_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

END$$

DELIMITER ;