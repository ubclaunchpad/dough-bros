#
# STORED PROCEDURES FOR EXPENSES
#

USE `doughBros_db`;
DROP procedure IF EXISTS `createGroupExpense`;
DROP procedure IF EXISTS `getGroupExpense`;
DROP procedure IF EXISTS `getAllGroupExpenses`;
DROP procedure IF EXISTS `archiveGroupExpense`;

DELIMITER $$
USE `doughBros_db`$$

CREATE PROCEDURE `createGroupExpense` (IN `group_id` INT(8), IN `added_by_id` VARCHAR(255), IN `currency_id` INT(8), IN `expense_name` VARCHAR(255), IN `is_archived` bool, IN `amount` decimal(10, 2))
BEGIN

INSERT INTO `group_expense` (`fk_group_id`, `fk_added_by_id`, `fk_currency_id`, `expense_name`, `is_archived`, `amount`)
	VALUES (`group_id`, `added_by`, `currency_id`, `expense_name`, `amount`);

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$

CREATE PROCEDURE `getGroupExpense` (IN `expense_id` INT(8))
BEGIN

SELECT * FROM `group_expense` WHERE `expense_id` = `expense_id`;

END$$

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `getAllGroupExpenses` (IN `group_id` INT(8))
BEGIN

SELECT * FROM `group_expense` WHERE `group_id` = `fk_group_id`;


END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `archiveGroupExpense` (IN `expense_id` INT(8))
BEGIN

UPDATE `group_expense`
SET `is_archived` = 1 WHERE `expense_id` = `expense_id`;

END$$

DELIMITER ;
