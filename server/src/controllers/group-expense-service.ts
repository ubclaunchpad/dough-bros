import { GroupExpense } from '../models/group-expense';
import { Payment } from '../models/payment';

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

  splitGroupExpense(req: any) {
    let user_amounts = req.body.user_amounts;

    const group_expense = {
      fk_group_id: req.body.fk_group_id,
      fk_added_by_id: req.body.fk_added_by_id,
      fk_currency_id: req.body.fk_currency_id,
      is_settled: req.body.is_settled,
      expense_name: req.body.expense_name,
      amount: req.body.amount,
    };

    return new Promise((resolve, reject) => {
      // create new group expense
      GroupExpense.createGroupExpense(group_expense, (err: any, res: any) => {
        if (err) {
          reject(err);
        }
        resolve(res);
      });
    }).then((result: any) => {
      return new Promise((resolve, reject) => {

        //create payment for each user
        for (var user_amount of user_amounts) {
          const user_payment = {
            fk_group_id: req.body.fk_group_id,
            fk_sender_id: user_amount.fk_sender_id,              // list of user ids
            fk_receiver_id: req.body.fk_added_by_id,    // currently: receiver_id = creator_id
            fk_creator_id: req.body.fk_added_by_id,
            fk_parent_expense_id: result.expense_id,           // get created group_expense_id from res
            fk_currency_id: req.body.fk_currency_id,
            amount: user_amount.amount,                   // list of amounts 
          };
          
          Payment.createPayment(user_payment, (err: any, res: any) => {
            if (err) {
              reject(err);
            }
            resolve(res);
          });
        }
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
