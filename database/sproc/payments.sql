#
# STORED PROCEDURES FOR PAYMENTS
#

USE `doughBros_db`;
DROP procedure IF EXISTS `createGroupExpense`;
DROP procedure IF EXISTS `getAllGroupExpenses`;
DROP procedure IF EXISTS `archiveGroupExpense`;
DROP procedure IF EXISTS `getAllPaymentsToUserInGroup`;
DROP procedure IF EXISTS `getAllPaymentsFromUserInGroup`;
DROP procedure IF EXISTS `payPayment`;
DROP procedure IF EXISTS `settlePayment`;

-- createGroupExpense

-- getAllGroupExpenses

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `getAllGroupExpenses` (IN `id` VARCHAR(255))
BEGIN

SELECT  FROM `group_expense` where `group_id` = `id`;
END$$

DELIMITER ;

-- archiveGroupExpense

-- getAllPaymentsToUserInGroup

-- getAllPaymentsFromUserInGroup

-- payPayment

-- settlePayment