#
# STORED PROCEDURES FOR PAYMENTS
#

USE `doughBros_db`;
DROP procedure IF EXISTS `createPayment`;
DROP procedure IF EXISTS `getAllPaymentsToUserInGroup`;
DROP procedure IF EXISTS `getAllPaymentsFromUserInGroup`;
DROP procedure IF EXISTS `payPayment`;
DROP procedure IF EXISTS `settlePayment`;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `createPayment` (IN `sender_id` VARCHAR(255), IN `receiver_id` VARCHAR(255), IN `creator_id` VARCHAR(255), IN `parent_expense_id` INT(8), IN `currency_id` INT(8), IN `is_paid` BOOLEAN, IN `is_settled` BOOLEAN,  IN `amount` decimal(10, 2))
BEGIN

INSERT INTO `payment` (`fk_sender_id`, `fk_receiver_id`, `fk_creator_id`, `fk_parent_expense_id`, `fk_currency_id`, `is_paid`, `is_settled`, `amount`)
	VALUES (`sender_id`, `receiver_id`, `creator_id`, `parent_expense_id`, `currency_id`, `is_paid`, `is_settled`, `amount`);

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `getAllPaymentsByGroupExpense` (IN `parent_expense_id` INT(8))
BEGIN

SELECT * FROM `payment` WHERE `fk_parent_expense_id` = `parent_expense_id`;

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `getAllPendingPaymentsByGroupExpense` (IN `parent_expense_id` INT(8))
BEGIN

SELECT * FROM `payment` WHERE (`fk_parent_expense_id` = `parent_expense_id` AND `is_paid` = 0 AND `is_settled` = 0);

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `getAllPaidPaymentsByGroupExpense` (IN `parent_expense_id` INT(8))
BEGIN

SELECT * FROM `payment` WHERE (`fk_parent_expense_id` = `parent_expense_id` AND `is_paid` = 1 AND `is_settled` = 0);

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `getAllSettledPaymentsByGroupExpense` (IN `parent_expense_id` INT(8))
BEGIN

SELECT * FROM `payment` WHERE (`fk_parent_expense_id` = `parent_expense_id` AND `is_settled` = 1);

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `getAllPaymentsToUserInGroup` (IN `receiver_id` VARCHAR(255), IN `group_id` INT(8))
BEGIN

SELECT p.*, u.first_name, u.last_name
FROM `payment` as p 
JOIN `user` as u ON u.firebase_uid = p.fk_sender_id
WHERE (p.fk_receiver_id = `receiver_id` AND p.fk_parent_expense_id = (
		SELECT `expense_id` FROM `group_expense` WHERE `fk_group_id` = `group_id`)
	);

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `getAllSettledPaymentsToUserInGroup` (IN `receiver_id` VARCHAR(255), IN `group_id` INT(8))
BEGIN

SELECT p.*, u.first_name, u.last_name
FROM `payment` as p 
JOIN `user` as u ON u.firebase_uid = p.fk_sender_id
WHERE (p.fk_receiver_id = `receiver_id` AND p.is_settled = 1 AND p.fk_parent_expense_id = (
		SELECT `expense_id` FROM `group_expense` WHERE `fk_group_id` = `group_id`)
	);

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `getAllPaymentsFromUserInGroup` (IN `sender_id` VARCHAR(255), IN `group_id` INT(8))
BEGIN

SELECT * FROM `payment` WHERE (`fk_sender_id` = `sender_id`
	AND `fk_parent_expense_id` = (
		SELECT `expense_id` FROM `group_expense` WHERE `fk_group_id` = `group_id`)
	);

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `payPayment` (IN `payment_id` INT(8))
BEGIN

UPDATE `payment`
SET `is_paid` = 1 WHERE `payment_id` = `payment_id`;

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `settlePayment` (IN `payment_id` INT(8))
BEGIN

UPDATE `payment`
SET `is_settled` = 1 WHERE `payment_id` = `payment_id`;

END$$

DELIMITER ;
