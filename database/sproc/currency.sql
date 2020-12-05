#
# STORED PROCEDURES FOR CURRENCY
#

USE `doughBros_db`;
DROP procedure IF EXISTS `createCurrency`;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `createCurrency` (IN `currency_name` VARCHAR(255), IN `currency_code` VARCHAR(10))
BEGIN

INSERT INTO `currency` (`currency_name`, `currency_code`)
	VALUES (`currency_name`, `currency_code`);

END$$

DELIMITER ;