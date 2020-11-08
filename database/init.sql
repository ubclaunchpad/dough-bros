#
# INIT DATABASE SCHEMA
#

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `user`;
DROP TABLE IF EXISTS `group`;
DROP TABLE IF EXISTS `pending_anon_user`;
DROP TABLE IF EXISTS `group_membership`;
SET FOREIGN_KEY_CHECKS = 1;


# CREATE TABLES
CALL doughBros_db.createUserTable;
CALL doughBros_db.createGroupTable;
CALL doughBros_db.createGroupMembershipTable;
CALL doughBros_db.createPendingAnonUserTable;