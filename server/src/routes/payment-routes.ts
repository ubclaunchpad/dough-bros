import { Router } from 'express';
import { sendMessageToUser } from '../notification/FCM';

const router = Router();

const PaymentService = require('../controllers/payment-service');
const paymentServer = new PaymentService();

const UserService = require("../controllers/user-service");
const userServer = new UserService();


router.post('/createPayment', (req, res) => {
  if (!req.body) {
    res.status(400).send({
      message: 'Content can not be empty!',
    });
  }

  paymentServer
    .createPayment(req)
    .then((payment: any) => {
      userServer.findUserByUID(req.body.fk_sender_id).then((user: any) => {
        sendMessageToUser(user.fcm_token, 'A payment is due from you!')
      })
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

router.get('/:groupID/pending/:userID', (req, res) => {
  if (!req.body) {
    res.status(400).send({
      message: 'Content can not be empty!',
    });
  }

  paymentServer
    .getAllPendingPaymentsToAndFromUserInGroup(req.params.userID, req.params.groupID)
    .then((payment: any) => {
      res.json(payment);
    })
    .catch((err: any) => {
      res.json(err);
    });
});

router.get('/settled/group/:groupID', (req, res) => {
  if (!req.body) {
    res.status(400).send({
      message: 'Content can not be empty!',
    });
  }

  paymentServer
    .getAllSettledPaymentsInGroup(req.params.groupID)
    .then((payment: any) => {
      res.json(payment);
    })
    .catch((err: any) => {
      res.json(err);
    });
});

router.get('/pending/group/:groupID', (req, res) => {
  if (!req.body) {
    res.status(400).send({
      message: 'Content can not be empty!',
    });
  }

  paymentServer
    .getAllPendingPaymentsInGroup(req.params.groupID)
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
    .getAllSettledPaymentsToUserInGroup(req.params.senderID, req.params.groupID)
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

router.put('/settlePayment/:paymentID/:receiverID', (req, res) => {
  paymentServer
    .settlePayment(req.params.paymentID)
    .then((payment: any) => {
      userServer.findUserByUID(req.params.receiverID, (err: any, res: any) => {
        if (err) {
          console.log(err);
          return;
        }
        let user = res[0];
        sendMessageToUser(
          user.fcm_token,
          `${user.first_name} settled a payment with you!`
        );
      });

      // userServer.findUserByUID(req.params.receiverID).then((user: any) => {
      //   if (user != null) {
      //     sendMessageToUser(
      //       user.fcm_token,
      //       `${user.first_name} settled a payment with you!`
      //     );
      //   }
      // });
      res.json(payment);
    })
    .catch((err: any) => {
      res.json(err);
    });
});

module.exports = router;
