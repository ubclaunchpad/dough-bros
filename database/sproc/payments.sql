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
CREATE PROCEDURE `createPayment` (IN `sender_id` INT(8), IN `receiver_id` INT(8), IN `creator_id` INT(8), IN `parent_expense_id` INT(8), IN `currency_id` INT(8), IN `amount` decimal(10, 2))
BEGIN

INSERT INTO `pending_payments` (`fk_sender_id`, `fk_receiver_id`, `fk_creator_id`, `fk_parent_expense_id`, `fk_currency_id`, `amount`)
	VALUES (`sender_id`, `receiver_id`, `creator_id`, `parent_expense_id`, `currency_id`, `amount`);

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `getAllPaymentsToUserInGroup` (IN `user_id` INT(8), IN `group_id` INT(8))
BEGIN

SELECT * FROM `pending_payments` WHERE `user_id` = `fk_receiver_id`;

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `getAllPaymentsFromUserInGroup` (IN `user_id` INT(8), IN `group_id` INT(8))
BEGIN

SELECT * FROM `pending_payments` WHERE `user_id` = `fk_sender_id`;

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `payPayment` (IN `payment_id` INT(8))
BEGIN

BEGIN TRANSACTION;
INSERT INTO `paid_payments`
SELECT * FROM `pending_payments`
WHERE `payment_id` = `payment_id`;

DELETE FROM `pending_payments`
WHERE `payment_id` = `payment_id`;

COMMIT;

END$$

DELIMITER ;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `settlePayment` (IN `payment_id` INT(8))
BEGIN

BEGIN TRANSACTION;
INSERT INTO `settled_payments`
SELECT * FROM `paid_payments`
WHERE `payment_id` = `payment_id`;

DELETE FROM `paid_payments`
WHERE `payment_id` = `payment_id`;

COMMIT;

END$$

DELIMITER ;
