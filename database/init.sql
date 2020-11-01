#
# TABLE STRUCTURE FOR: user
#

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `user_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email_addr` varchar(255) NOT NULL,
  `facebook_id` varchar(255) NOT NULL,
  `is_anon` boolean NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

INSERT INTO `users` (`user_id`, `first_name`, `last_name`, `email_addr`, `facebook_id`, `is_anon`) VALUES (1, 'Ailn', 'Rathmouth','mailn0@bravesites.com', 'mailn0', 0);
INSERT INTO `users` (`user_id`, `first_name`, `last_name`, `email_addr`, `facebook_id`, `is_anon`) VALUES (2, 'Hounson', 'Port Lolamouth', 'dhounson1@slashdot.org', 'dhouson1,', 1);
INSERT INTO `users` (`user_id`, `first_name`, `last_name`, `email_addr`, `facebook_id`, `is_anon`) VALUES (3, 'Tison', 'Lavernastad', 'ctison2@europa.eu', 'ctison2', 0);
INSERT INTO `users` (`user_id`, `first_name`, `last_name`, `email_addr`, `facebook_id`, `is_anon`) VALUES (4, 'Surmeyers', 'Ethelville', 'msurmeyers3@nytimes.com', 'msurmeyers3', 0);
INSERT INTO `users` (`user_id`, `first_name`, `last_name`, `email_addr`, `facebook_id`, `is_anon`) VALUES (5, 'Bob', 'Schulistland', 'scbob@opensource.org', 'scbob', 1);

DROP TABLE IF EXISTS `group`;

CREATE TABLE `group` (
  `group_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `fk_creator_id` int(9) unsigned NOT NULL,
  `group_name` int(9) unsigned NOT NULL,
  PRIMARY KEY (`payment_id`),
  FOREIGN KEY (`fk_creator_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `group_membership`;

CREATE TABLE `group` (
  `fk_group_id` int(9) unsigned NOT NULL,
  `fk_user_id` int(9) unsigned NOT NULL,
  `fk_added_by` int(9) unsigned NOT NULL,
  `did_accept_invite` boolean NOT NULL,
  FOREIGN KEY (`fk_creator_id`),
  FOREIGN KEY (`fk_user_id`),
  FOREIGN KEY (`fk_added_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `group_membership`;

CREATE TABLE `pending_anon_user` (
  `request_id` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `fk_added_by` int(9) unsigned NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email_addr` varchar(255) NOT NULL,
  `facebook_id` varchar(255) NOT NULL,
  FOREIGN KEY (`fk_added_by`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
