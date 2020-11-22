import { Router } from "express";

const router = Router();

const PaymentService = require("../controllers/payment-service");
const paymentServer = new PaymentService();

router.post('/createPayment', (req, res) => {
  if (!req.body) {
    res.status(400).send({
      message: "Content can not be empty!",
    });
  }

  paymentServer.createPayment(req).then((payment: any) => {
      res.json(payment);
    })
    .catch((err: any) => {
      res.json(err);
    });
});

router.put('/payPayment/:paymentID', (req, res) => {
  paymentServer.payPayment(req.params.paymentID).then((payment: any) => {
      res.json(payment);
  }).catch((err: any) => {
      res.json(err);
  });
});

router.put('/payPayment/:paymentID', (req, res) => {
    paymentServer.settlePayment(req.params.paymentID).then((payment: any) => {
        res.json(payment);
    }).catch((err: any) => {
        res.json(err);
    });
});

module.exports = router