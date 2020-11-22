#
# INIT DATABASE SCHEMA
#

# CREATE TABLES
CALL doughBros_db.createUserTable;
CALL doughBros_db.createGroupTable;
CALL doughBros_db.createGroupMembershipTable;
CALL doughBros_db.createPendingAnonUserTable;
CALL doughBros_db.createCurrencyTable;
CALL doughBros_db.createGroupExpenseTable;
CALL doughBros_db.createPaymentTable;
CALL doughBros_db.createDisputeTable;
