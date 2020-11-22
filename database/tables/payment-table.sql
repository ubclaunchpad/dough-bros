USE `doughBros_db`;
DROP procedure IF EXISTS `createPaymentTable`;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `payment`;
SET FOREIGN_KEY_CHECKS = 1;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `createPaymentTable` ()
BEGIN

CREATE TABLE `payment` (
  `payment_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `fk_sender_id` VARCHAR(255) NOT NULL,
  `fk_receiver_id` VARCHAR(255) NOT NULL,
  `fk_creator_id` VARCHAR(255) NOT NULL,
  `fk_parent_expense_id` int(9) unsigned NOT NULL,
  `fk_currency_id` int(9) unsigned NOT NULL,
  `is_paid` BOOLEAN DEFAULT 0 NOT NULL,
  `is_settled` BOOLEAN DEFAULT 0 NOT NULL,
  `amount` decimal(19, 4) unsigned NOT NULL,
  `timestamp` DATETIME,
  PRIMARY KEY (`payment_id`),
  FOREIGN KEY (`fk_sender_id`)
  REFERENCES `user` (`firebase_uid`)
    ON DELETE CASCADE,
  FOREIGN KEY (`fk_receiver_id`)
  REFERENCES `user` (`firebase_uid`)
    ON DELETE CASCADE,
  FOREIGN KEY (`fk_creator_id`)
  REFERENCES `user` (`firebase_uid`)
    ON DELETE CASCADE,
  FOREIGN KEY (`fk_parent_expense_id`)
  REFERENCES `group_expense` (`expense_id`)
    ON DELETE CASCADE,
  FOREIGN KEY (`fk_currency_id`)
  REFERENCES `currency` (`currency_id`)
    ON DELETE CASCADE    
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

END$$

DELIMITER ;
