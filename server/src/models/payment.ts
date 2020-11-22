const sql = require("../config/databaseHandler");

export const Payment = function (this: any, payment: any) {
  this.payment_id = payment.payment_id;
  this.fk_sender_id = payment.fk_sender_id;
  this.fk_receiver_id = payment.fk_receiver_id;
  this.fk_creator_id = payment.fk_creator_id;
  this.fk_parent_expense_id = payment.fk_parent_expense_id;
  this.fk_currency_id = payment.fk_currency_id;
  this.is_paid = payment.is_paid;
  this.is_settled = payment.is_settled;
  this.amount = payment.amount;
  this.timestamp = payment.timestamp;
};

Payment.createPayment = (newPayment: any, result: any) => {
  sql.query(
    "CALL createPayment(?,?,?,?,?,,,?)",
    [
        newPayment.fk_sender_id,
        newPayment.fk_receiver_id,
        newPayment.fk_creator_id,
        newPayment.fk_parent_expense_id,
        newPayment.fk_currency_id,
        newPayment.amount,
    ],
    (err: any, res: any) => {
      if (err) {
        console.log("error: ", err);
        result(err, null);
      } else {
        console.log("Created Payment: ", res);
        result(null, res);
      }
    }
  );
};

Payment.payPayment = (paymentID: number, result: any) => {
    sql.query(
      "CALL payPayment(?)", paymentID,
      (err: any, res: any) => {
        if (err) {
          console.log("error: ", err);
          result(err, null);
        } else {
          console.log(res);
          result(null, res);
        }
      }
    );
  };

  Payment.settlePayment = (paymentID: number, result: any) => {
    sql.query(
      "CALL settlePayment(?)", paymentID,
      (err: any, res: any) => {
        if (err) {
          console.log("error: ", err);
          result(err, null);
        } else {
          console.log(res);
          result(null, res);
        }
      }
    );
  };