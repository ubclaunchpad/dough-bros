#
# CREATE TABLE STRUCTURES
#

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `user`;
DROP TABLE IF EXISTS `group`;
DROP TABLE IF EXISTS `pending_anon_user`;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE `user` (
  `user_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email_addr` varchar(255) NOT NULL,
  `facebook_id` varchar(255) NOT NULL,
  `is_anon` bool NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

# creating user instances, todelete
CALL doughBros_db.createUser('Ailn', 'Rathmouth','mailn0@bravesites.com', 'mailn0', 0);
CALL doughBros_db.createUser('Hounson', 'Port Lolamouth', 'dhounson1@slashdot.org', 'dhouson1,', 1);
CALL doughBros_db.createUser('Tison', 'Lavernastad', 'ctison2@europa.eu', 'ctison2', 0);
CALL doughBros_db.createUser('Surmeyers', 'Ethelville', 'msurmeyers3@nytimes.com', 'msurmeyers3', 0);
CALL doughBros_db.createUser('Bob', 'Schulistland', 'scbob@opensource.org', 'scbob', 1);

CREATE TABLE `group` (
  `group_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `fk_creator_id` int(9) unsigned NOT NULL,
  `group_name` int(9) unsigned NOT NULL,
  PRIMARY KEY (`group_id`),
  FOREIGN KEY (`fk_creator_id`)
	REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `group_membership`;

CREATE TABLE `group_membership` (
  `fk_group_id` int(9) unsigned NOT NULL,
  `fk_user_id` int(9) unsigned NOT NULL,
  `fk_added_by` int(9) unsigned NOT NULL,
  `did_accept_invite` bool NOT NULL,
  FOREIGN KEY (`fK_group_id`)
	REFERENCES `group` (`group_id`)
    ON DELETE CASCADE,
  FOREIGN KEY (`fk_user_id`)
	REFERENCES `user` (`user_id`)
    ON DELETE CASCADE,
  FOREIGN KEY (`fk_added_by`)
	REFERENCES `user` (`user_id`)
    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `pending_anon_user` (
  `request_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `fk_added_by` int(9) unsigned NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email_addr` varchar(255) NOT NULL,
  `facebook_id` varchar(255) NOT NULL,
  PRIMARY KEY (`request_id`),
  FOREIGN KEY (`fk_added_by`)
	REFERENCES `user` (`user_id`)
    ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
