const sql = require('../config/database-handler');

export const GroupExpense = function (this: any, groupExpense: any) {
  this.expense_id = groupExpense.expense_id;
  this.fk_group_id = groupExpense.fk_group_id;
  this.fk_added_by_id = groupExpense.fk_added_by_id;
  this.fk_currency_id = groupExpense.fk_currency_id;
  this.is_settled = groupExpense.is_settled;
  this.expense_name = groupExpense.expense_name;
  this.amount = groupExpense.amount;
};

GroupExpense.createGroupExpense = (newGroupExpense: any, result: any) => {
  sql.query(
    'CALL createGroupExpense(?,?,?,,?,?)',
    [
      newGroupExpense.fk_group_id,
      newGroupExpense.fk_added_by_id,
      newGroupExpense.fk_currency_id,
      newGroupExpense.expense_name,
      newGroupExpense.amount,
    ],
    (err: any, res: any) => {
      if (err) {
        console.log('error: ', err);
        result(err, null);
      } else {
        console.log('Created Group Expense: ', res);
        result(null, res);
      }
    }
  );
};

GroupExpense.getGroupExpenseById = (groupExpenseID: number, result: any) => {
  sql.query(
    'CALL getGroupExpenseById(?)',
    groupExpenseID,
    (err: any, res: any) => {
      if (err) {
        console.log('error: ', err);
        result(err, null);
      } else {
        console.log(res);
        result(null, res);
      }
    }
  );
};

GroupExpense.archiveGroupExpense = (groupExpenseID: number, result: any) => {
  sql.query(
    'CALL archiveGroupExpense(?)',
    groupExpenseID,
    (err: any, res: any) => {
      if (err) {
        console.log('error: ', err);
        result(err, null);
      } else {
        console.log(res);
        result(null, res);
      }
    }
  );
};
