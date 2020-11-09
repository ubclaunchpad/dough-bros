#
# INIT DATABASE SCHEMA
#

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `user`;
DROP TABLE IF EXISTS `group`;
DROP TABLE IF EXISTS `pending_anon_user`;
DROP TABLE IF EXISTS `group_membership`;

DROP TABLE IF EXISTS `currency`;
DROP TABLE IF EXISTS `group_expense`;
DROP TABLE IF EXISTS `pending_payment`;
SET FOREIGN_KEY_CHECKS = 1;


# CREATE TABLES
CALL doughBros_db.createUserTable;
CALL doughBros_db.createGroupTable;
CALL doughBros_db.createGroupMembershipTable;
CALL doughBros_db.createPendingAnonUserTable;

CALL doughBros_db.createCurrencyTable;
CALL doughBros_db.createGroupExpenseTable;
CALL doughBros_db.createPendingPaymentTable;