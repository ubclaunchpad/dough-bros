import { Router } from "express";

const router = Router();

const GroupExpenseService = require("../controllers/group-expense-service");
const groupExpenseServer = new GroupExpenseService();

router.post('/createGroupExpense', (req, res) => {
  if (!req.body) {
    res.status(400).send({
      message: "Content can not be empty!",
    });
  }

  groupExpenseServer.createGroupExpense(req).then((expense: any) => {
      res.json(expense);
    })
    .catch((err: any) => {
      res.json(err);
    });
});

router.post('/splitGroupExpense/', (req, res) => {
  groupExpenseServer.splitGroupExpense(req).then((expense: any) => {
      res.json(expense);
    })
    .catch((err: any) => {
      res.json(err);
    });
});

router.get('/getGroupExpenseById/:groupExpenseID', (req, res) => {
    groupExpenseServer.getGroupExpenseById(req.params.groupExpenseID).then((expense: any) => {
        res.json(expense);
    }).catch((err: any) => {
        res.json(err);
    });
});

router.get('/getGroupExpenseByGroupId/:groupID', (req, res) => {
  groupExpenseServer.getGroupExpenseByGroupId(req.params.groupID).then((expense: any) => {
      res.json(expense);
  }).catch((err: any) => {
      res.json(err);
  });
});

router.put('/archiveGroupExpense/:groupExpenseID', (req,res) => {
  groupExpenseServer.archiveGroupExpense(req.params.groupExpenseID).then((expense: any) => {
      res.json(expense);
  }).catch((err: any) => {
      res.json(err);
  });
});

module.exports = router