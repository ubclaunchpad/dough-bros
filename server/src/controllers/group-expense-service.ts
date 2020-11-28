import { GroupExpense } from '../models/group-expense';

module.exports = class GroupExpenseService {
  constructor() {}

  createGroupExpense(req: any) {
    const group_expense = {
      fk_group_id: req.body.group_id,
      fk_added_by_id: req.body.addedBy,
      fk_currency_id: req.body.currency_id,
      is_settled: req.body.is_settled,
      expense_name: req.body.expense_name,
      amount: req.body.amount,
    };

    return new Promise((resolve, reject) => {
      GroupExpense.createGroupExpense(group_expense, (err: any, res: any) => {
        if (err) {
          reject(err);
        }
        resolve(res);
      });
    });
  }

  getGroupExpenseById(groupExpenseID: number) {
    return new Promise((resolve, reject) => {
      GroupExpense.getGroupExpenseById(groupExpenseID, (err: any, res: any) => {
        if (err) {
          reject(err);
        }
        resolve(res);
      });
    });
  }

  getGroupExpenseByGroupId(groupID: number) {
    return new Promise((resolve, reject) => {
      GroupExpense.getGroupExpenseByGroupId(groupID, (err: any, res: any) => {
        if (err) {
          reject(err);
        }
        resolve(res);
      });
    });
  }

  archiveGroupExpense(groupExpenseID: number) {
    return new Promise((resolve, reject) => {
      GroupExpense.archiveGroupExpense(groupExpenseID, (err: any, res: any) => {
        if (err) {
          reject(err);
        }
        resolve(res);
      });
    });
  }
};
