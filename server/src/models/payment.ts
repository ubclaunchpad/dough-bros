const sql = require('../config/database-handler');

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
    'CALL createPayment(?,?,?,?,?,?,?,?)',
    [
      newPayment.fk_sender_id,
      newPayment.fk_receiver_id,
      newPayment.fk_creator_id,
      newPayment.fk_parent_expense_id,
      newPayment.fk_currency_id,
      0,
      0,
      newPayment.amount,
    ],
    (err: any, res: any) => {
      if (err) {
        console.log('error: ', err);
        result(err, null);
      } else {
        console.log('Created Payment: ', res);
        result(null, res);
      }
    }
  );
};

Payment.getAllPaymentsByGroupExpense = (
  parentExpenseID: number,
  result: any
) => {
  sql.query(
    'CALL getAllPaymentsByGroupExpense(?)',
    parentExpenseID,
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
};

Payment.getAllPendingPaymentsByGroupExpense = (
  parentExpenseID: number,
  result: any
) => {
  sql.query(
    'CALL getAllPendingPaymentsByGroupExpense(?)',
    parentExpenseID,
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
};

Payment.getAllPaidPaymentsByGroupExpense = (
  parentExpenseID: number,
  result: any
) => {
  sql.query(
    'CALL getAllPaidPaymentsByGroupExpense(?)',
    parentExpenseID,
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
};

Payment.getAllSettledPaymentsByGroupExpense = (
  parentExpenseID: number,
  result: any
) => {
  sql.query(
    'CALL getAllSettledPaymentsByGroupExpense(?)',
    parentExpenseID,
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
};

Payment.getAllPaymentsToUserInGroup = (
  receiverID: string,
  groupID: number,
  result: any
) => {
  sql.query(
    'CALL getAllPaymentsToUserInGroup(?, ?)',
    [receiverID, groupID],
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
};

Payment.getAllSettledPaymentsToUserInGroup = (
  receiverID: string,
  groupID: number,
  result: any
) => {
  sql.query(
    'CALL getAllSettledPaymentsToUserInGroup(?, ?)',
    [receiverID, groupID],
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
};

Payment.getAllPaymentsFromUserInGroup = (
  groupID: number,
  senderID: string,
  result: any
) => {
  sql.query(
    'CALL getAllPaymentsFromUserInGroup(?, ?)',
    [groupID, senderID],
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
};

Payment.getAllPendingPaymentsToAndFromUserInGroup = (
  userID: string,
  groupID: number,
  result: any
) => {
  sql.query(
    'CALL getAllPendingPaymentsToAndFromUserInGroup(?, ?)',
    [userID, groupID],
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
};

Payment.getAllSettledPaymentsInGroup = (
  groupID: number,
  result: any
) => {
  sql.query(
    'CALL getAllSettledPaymentsInGroup(?)',
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
};

Payment.getAllPendingPaymentsInGroup = (
  groupID: number,
  result: any
) => {
  sql.query(
    'CALL getAllPendingPaymentsInGroup(?)',
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
};

Payment.payPayment = (paymentID: number, result: any) => {
  sql.query('CALL payPayment(?)', paymentID, (err: any, res: any) => {
    if (err) {
      console.log('error: ', err);
      result(err, null);
    } else {
      console.log(res);
      result(null, res);
    }
  });
};

Payment.settlePayment = (paymentID: number, result: any) => {
  sql.query('CALL settlePayment(?)', paymentID, (err: any, res: any) => {
    if (err) {
      console.log('error: ', err);
      result(err, null);
    } else {
      console.log(res);
      result(null, res);
    }
  });
};
