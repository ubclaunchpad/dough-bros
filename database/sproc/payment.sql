#
# STORED PROCEDURES FOR PAYMENTS
#

USE `doughBros_db`;
DROP procedure IF EXISTS `createPayment`;
DROP procedure IF EXISTS `getAllPaymentsToUserInGroup`;
DROP procedure IF EXISTS `getAllPaymentsFromUserInGroup`;
DROP procedure IF EXISTS `getAllSettledPaymentsToUserInGroup`;
DROP procedure IF EXISTS `payPayment`;
DROP procedure IF EXISTS `settlePayment`;
DROP procedure IF EXISTS `deletePayment`;
DROP procedure IF EXISTS `getAllPaymentsByGroupExpense`;
DROP procedure IF EXISTS `getAllPendingPaymentsByGroupExpense`;
DROP procedure IF EXISTS `getAllSettledPaymentsByGroupExpense`;
DROP procedure IF EXISTS `getAllPaidPaymentsByGroupExpense`;
DROP procedure IF EXISTS `getAllPendingPaymentsInGroup`;
DROP procedure IF EXISTS `getAllPendingPaymentsToAndFromUserInGroup`;
DROP procedure IF EXISTS `getAllSettledPaymentsInGroup`;

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
CREATE PROCEDURE `getAllPendingPaymentsToAndFromUserInGroup` (IN `user_uid` VARCHAR(255), `group_id` INT(8))
BEGIN

SELECT * FROM `payment` WHERE ((`fk_sender_id` = `user_uid` OR `fk_receiver_id` = `user_uid`)
	AND `fk_parent_expense_id` IN (
		SELECT `expense_id` FROM `group_expense` WHERE `fk_group_id` = `group_id`)
	AND `is_paid` = 0
	AND `is_settled` = 0
	);
END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `getAllSettledPaymentsInGroup` (IN `group_id` INT(8))
BEGIN

SELECT p.*,
us.first_name AS first_name_sender,
us.last_name AS last_name_sender, 
ur.first_name AS first_name_receiver, 
ur.last_name AS last_name_receiver
FROM `payment` AS p
JOIN `user` AS us ON us.firebase_uid = p.fk_sender_id
JOIN `user` AS ur ON ur.firebase_uid = p.fk_receiver_id
WHERE (p.fk_parent_expense_id IN 
	(
	SELECT `expense_id` FROM `group_expense`
	WHERE `fk_group_id` = `group_id`
	)
	AND p.is_settled = 1
);

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `getAllPendingPaymentsInGroup` (IN `group_id` INT(8))
BEGIN

SELECT p.*,
us.first_name AS first_name_sender,
us.last_name AS last_name_sender, 
ur.first_name AS first_name_receiver, 
ur.last_name AS last_name_receiver
FROM `payment` AS p
JOIN `user` AS us ON us.firebase_uid = p.fk_sender_id
JOIN `user` AS ur ON ur.firebase_uid = p.fk_receiver_id
WHERE (p.fk_parent_expense_id IN 
	(
	SELECT `expense_id` FROM `group_expense`
	WHERE `fk_group_id` = `group_id`
	)
	AND p.is_paid = 0
	AND p.is_settled = 0
);
	
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
CREATE PROCEDURE `getAllPaymentsFromUserInGroup` (IN `group_id` INT(8), IN `sender_id` VARCHAR(255))
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

UPDATE payment as p
SET p.is_paid = 1 WHERE p.payment_id = `payment_id`;

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `settlePayment` (IN `payment_id` INT(8))
BEGIN

UPDATE `payment` as p
SET p.is_settled = 1 WHERE p.payment_id = `payment_id`;

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `deletePayment` (IN `group_expense_id` INT(8))
BEGIN

DELETE * FROM `payment` WHERE `fk_parent_expense_id` = `group_expense_id`;

END$$

DELIMITER ;
