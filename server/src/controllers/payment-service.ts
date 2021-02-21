import { Payment } from '../models/payment';

module.exports = class PaymentService {
  constructor() {}

  createPayment(req: any) {
    const payment = {
      fk_sender_id: req.body.fk_sender_id,
      fk_receiver_id: req.body.fk_receiver_id,
      fk_creator_id: req.body.fk_creator_id,
      fk_parent_expense_id: req.body.fk_parent_expense_id,
      fk_currency_id: req.body.fk_currency_id,
      is_paid: req.body.is_paid,
      is_settled: req.body.is_settled,
      amount: req.body.amount,
    };

    return new Promise((resolve, reject) => {
      Payment.createPayment(payment, (err: any, res: any) => {
        if (err) {
          reject(err);
        }
        resolve(res);
      });
    });
  }

  getAllPaymentsByGroupExpense(parentExpenseID: number) {
    return new Promise((resolve, reject) => {
      Payment.getAllPaymentsByGroupExpense(
        parentExpenseID,
        (err: any, res: any) => {
          if (err) {
            reject(err);
          }
          resolve(res);
        }
      );
    });
  }

  getAllPendingPaymentsByGroupExpense(parentExpenseID: number) {
    return new Promise((resolve, reject) => {
      Payment.getAllPendingPaymentsByGroupExpense(
        parentExpenseID,
        (err: any, res: any) => {
          if (err) {
            reject(err);
          }
          resolve(res);
        }
      );
    });
  }

  getAllPaidPaymentsByGroupExpense(parentExpenseID: number) {
    return new Promise((resolve, reject) => {
      Payment.getAllPaidPaymentsByGroupExpense(
        parentExpenseID,
        (err: any, res: any) => {
          if (err) {
            reject(err);
          }
          resolve(res);
        }
      );
    });
  }

  getAllSettledPaymentsByGroupExpense(parentExpenseID: number) {
    return new Promise((resolve, reject) => {
      Payment.getAllSettledPaymentsByGroupExpense(
        parentExpenseID,
        (err: any, res: any) => {
          if (err) {
            reject(err);
          }
          resolve(res);
        }
      );
    });
  }

  getAllPaymentsToUserInGroup(receiverID: string, groupID: number) {
    return new Promise((resolve, reject) => {
      Payment.getAllPaymentsToUserInGroup(
        receiverID,
        groupID,
        (err: any, res: any) => {
          if (err) {
            reject(err);
          }
          resolve(res);
        }
      );
    });
  }

  getAllSettledPaymentsToUserInGroup(receiverID: string, groupID: number) {
    return new Promise((resolve, reject) => {
      Payment.getAllSettledPaymentsToUserInGroup(
        receiverID,
        groupID,
        (err: any, res: any) => {
          if (err) {
            reject(err);
          }
          resolve(res);
        }
      );
    });
  }

  getAllPaymentsFromUserInGroup(groupID: number, senderID: string) {
    return new Promise((resolve, reject) => {
      Payment.getAllPaymentsFromUserInGroup(
        groupID,
        senderID,
        (err: any, res: any) => {
          if (err) {
            reject(err);
          }
          resolve(res);
        }
      );
    });
  }

  payPayment(paymentID: number) {
    return new Promise((resolve, reject) => {
      Payment.payPayment(paymentID, (err: any, res: any) => {
        if (err) {
          reject(err);
        }
        resolve(res);
      });
    });
  }

  settlePayment(paymentID: number) {
    return new Promise((resolve, reject) => {
      Payment.settlePayment(paymentID, (err: any, res: any) => {
        if (err) {
          reject(err);
        }
        resolve(res);
      });
    });
  }
};
