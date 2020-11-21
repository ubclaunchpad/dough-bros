import { Payment } from "../models/payment";

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
      }

    return new Promise((resolve, reject) => {
      Payment.createPayment(payment, (err: any, res: any) => {
        if (err) {
          reject(err);
        }
        resolve(res);
      });
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
