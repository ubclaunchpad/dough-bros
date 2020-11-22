USE `doughBros_db`;
DROP procedure IF EXISTS `createDisputeTable`;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `dispute`;
SET FOREIGN_KEY_CHECKS = 1;

DELIMITER $$
USE `doughBros_db`$$
CREATE PROCEDURE `createDisputeTable` ()
BEGIN

CREATE TABLE `dispute` (
  `dispute_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `fk_initiator_id` VARCHAR(255) NOT NULL,
  `fk_recipient_id` VARCHAR(255) NOT NULL,
  `fk_payment_id` int(9) unsigned NOT NULL,
  `dispute_type` VARCHAR(255),
  `dispute_description` VARCHAR(255),
  PRIMARY KEY (`dispute_id`),
  FOREIGN KEY (`fk_initiator_id`)
  REFERENCES `user` (`firebase_uid`)
    ON DELETE CASCADE,
  FOREIGN KEY (`fk_recipient_id`)
  REFERENCES `user` (`firebase_uid`)
    ON DELETE CASCADE,
  FOREIGN KEY (`fk_payment_id`)
  REFERENCES `payment` (`payment_id`)
    ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

END$$

DELIMITER ;
