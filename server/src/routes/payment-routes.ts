import { Router } from 'express';

const router = Router();

const PaymentService = require('../controllers/payment-service');
const paymentServer = new PaymentService();

router.post('/createPayment', (req, res) => {
  if (!req.body) {
    res.status(400).send({
      message: 'Content can not be empty!',
    });
  }

  paymentServer
    .createPayment(req)
    .then((payment: any) => {
      res.json(payment);
    })
    .catch((err: any) => {
      res.json(err);
    });
});

router.get('/:parentExpenseID', (req, res) => {
  if (!req.body) {
    res.status(400).send({
      message: 'Content can not be empty!',
    });
  }

  paymentServer
    .getAllPaymentsByGroupExpense(req.params.parentExpenseID)
    .then((payment: any) => {
      res.json(payment);
    })
    .catch((err: any) => {
      res.json(err);
    });
});

router.get('/pending/:parentExpenseID', (req, res) => {
  if (!req.body) {
    res.status(400).send({
      message: 'Content can not be empty!',
    });
  }

  paymentServer
    .getAllPendingPaymentsByGroupExpense(req.params.parentExpenseID)
    .then((payment: any) => {
      res.json(payment);
    })
    .catch((err: any) => {
      res.json(err);
    });
});

router.get('/paid/:parentExpenseID', (req, res) => {
  if (!req.body) {
    res.status(400).send({
      message: 'Content can not be empty!',
    });
  }

  paymentServer
    .getAllPaidPaymentsByGroupExpense(req.params.parentExpenseID)
    .then((payment: any) => {
      res.json(payment);
    })
    .catch((err: any) => {
      res.json(err);
    });
});

router.get('/settled/:parentExpenseID', (req, res) => {
  if (!req.body) {
    res.status(400).send({
      message: 'Content can not be empty!',
    });
  }

  paymentServer
    .getAllSettledPaymentsByGroupExpense(req.params.parentExpenseID)
    .then((payment: any) => {
      res.json(payment);
    })
    .catch((err: any) => {
      res.json(err);
    });
});

router.get('/:groupID/received/:receiverID', (req, res) => {
  if (!req.body) {
    res.status(400).send({
      message: 'Content can not be empty!',
    });
  }

  paymentServer
    .getAllPaymentsToUserInGroup(req.params.receiverID, req.params.groupID)
    .then((payment: any) => {
      res.json(payment);
    })
    .catch((err: any) => {
      res.json(err);
    });
});

router.get('/:groupID/settled/:receiverID', (req, res) => {
  if (!req.body) {
    res.status(400).send({
      message: 'Content can not be empty!',
    });
  }

  paymentServer
    .getAllSettledPaymentsToUserInGroup(req.params.receiverID, req.params.groupID)
    .then((payment: any) => {
      res.json(payment);
    })
    .catch((err: any) => {
      res.json(err);
    });
});

router.get('/:groupID/sent/:senderID', (req, res) => {
  if (!req.body) {
    res.status(400).send({
      message: 'Content can not be empty!',
    });
  }

  paymentServer
    .getAllPaymentsFromUserInGroup(req.params.groupID, req.params.senderID)
    .then((payment: any) => {
      res.json(payment);
    })
    .catch((err: any) => {
      res.json(err);
    });
});

router.put('/payPayment/:paymentID', (req, res) => {
  paymentServer
    .payPayment(req.params.paymentID)
    .then((payment: any) => {
      res.json(payment);
    })
    .catch((err: any) => {
      res.json(err);
    });
});

router.put('/payPayment/:paymentID', (req, res) => {
  paymentServer
    .settlePayment(req.params.paymentID)
    .then((payment: any) => {
      res.json(payment);
    })
    .catch((err: any) => {
      res.json(err);
    });
});

module.exports = router;
