const sql = require('../config/database-handler');

export const GroupExpense = function (this: any, groupExpense: any) {
  this.expense_id = groupExpense.expense_id;
  this.fk_group_id = groupExpense.fk_group_id;
  this.fk_added_by_id = groupExpense.fk_added_by_id;
  this.fk_currency_id = groupExpense.fk_currency_id;
  this.is_archived = groupExpense.is_archived;
  this.expense_name = groupExpense.expense_name;
  this.amount = groupExpense.amount;
};

GroupExpense.createGroupExpense = (newGroupExpense: any, result: any) => {
  sql.query(
    //'CALL createGroupExpense(?,?,?,?,?,?)',
    'INSERT INTO group_expense (`fk_group_id`, `fk_added_by_id`, `fk_currency_id`, `expense_name`, `is_archived`, `amount`) VALUES (?,?,?,?,?,?)',
    [
      newGroupExpense.fk_group_id,
      newGroupExpense.fk_added_by_id,
      newGroupExpense.fk_currency_id,
      newGroupExpense.expense_name,
      0,
      newGroupExpense.amount,
    ],
    (err: any, res: any) => {
      if (err) {
        console.log('error: ', err);
        result(err, null);
      } else {
        //SELECT id FROM tableName ORDER BY id DESC LIMIT 1
        console.log('Created Group Expense: ', { expense_id: res.insertId, ...newGroupExpense });
        result(null, { expense_id: res.insertId, ...newGroupExpense });
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
    'CALL deleteGroupExpense(?)',
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

GroupExpense.getGroupExpenseByPaymentId = (paymentID: number, result: any) => {
  sql.query(
    'CALL getGroupExpenseByPaymentId(?)',
    paymentID,
    (err: any, res: any) => {
      if (err) {
        console.log('error: ', err);
        result(err, null);
      } else {
        console.log(res);
        result(null, res[0]);
      }
    }
  );
}

GroupExpense.getGroupExpenseByGroupId = (groupID: number, result: any) => {
  sql.query(
    'CALL getAllGroupExpenses(?)',
    groupID,
    (err: any, res: any) => {
      if (err) {
        console.log('error: ', err);
        result(err, null);
      } else {
        console.log(res);
        result(null, res[0]);
      }
    }
  );
}

GroupExpense.deleteGroupExpenseById = (groupExpenseID: number, result: any) => {
  sql.query(
    'CALL deleteGroupExpenseById(?)',
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
