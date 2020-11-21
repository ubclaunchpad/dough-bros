USE `doughBros_db`;
DROP procedure IF EXISTS `createGroupExpenseTable`;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `group_expense`;
SET FOREIGN_KEY_CHECKS = 1;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `createGroupExpenseTable` ()
BEGIN

CREATE TABLE `group_expense` (
   `expense_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
   `fk_group_id` int(9) unsigned NOT NULL,
   `fk_added_by_id` VARCHAR(255) NOT NULL,
   `fk_currency_id` int(9) unsigned NOT NULL,
   `expense_name` varchar(255) NOT NULL,
   `is_archived` BOOLEAN DEFAULT 0 NOT NULL,
   `amount` decimal(19, 4) unsigned NOT NULL,
   PRIMARY KEY (`expense_id`),
   FOREIGN KEY (`fk_group_id`)
   REFERENCES `group` (`group_id`)
     ON DELETE CASCADE,
   FOREIGN KEY (`fk_added_by_id`)
   REFERENCES `user` (`firebase_uid`)
     ON DELETE CASCADE,
   FOREIGN KEY (`fk_currency_id`)
   REFERENCES `currency` (`currency_id`)
     ON DELETE CASCADE
 ) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

END$$

DELIMITER ;

