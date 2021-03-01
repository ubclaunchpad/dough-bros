import { Router } from "express";

const router = Router();

const GroupService = require("../controllers/group-service");
const groupServer = new GroupService();

router.post('/createGroup', (req, res) => {
  if (!req.body) {
    res.status(400).send({
      message: "Content can not be empty!",
    });
  }

  groupServer.createGroup(req).then((group: any) => {
      res.json(group);
    })
    .catch((err: any) => {
      res.json(err);
    });
});

router.post('/addUserToGroup', (req,res) => {
    if (!req.body) {
        res.status(400).send({
          message: "Content can not be empty!",
        });
    }

  groupServer.addUserToGroup(req).then((membership: any) => {
      res.json(membership);
  }).catch((err: any) => {
      res.json(err);
  });
});

// Get Group by UID
router.get('/getGroupByUID/:userID', (req, res) => {
  groupServer.getGroupByUID(req.params.userID).then((user: any) => {
      res.json(user);
  }).catch((err: any) => {
      res.json(err);
  });
});

// Get Pending Group by UID
router.get('/getPendingGroupByUID/:userID', (req, res) => {
  groupServer.getPendingGroupByUID(req.params.userID).then((user: any) => {
      res.json(user);
  }).catch((err: any) => {
      res.json(err);
  });
});

router.get('/getAllGroupUsers/:groupID', (req, res) => {
    groupServer.getAllGroupUsers(req.params.groupID).then((users: any) => {
        res.json(users);
    }).catch((err: any) => {
        res.json(err);
    });
});

router.put('/acceptGroupMembership/:groupID/:userID', (req, res) => {
    groupServer.acceptGroupMembership(req.params.groupID, req.params.userID).then((membership: any) => {
        res.json(membership);
    }).catch((err: any) => {
        res.json(err);
    });
});

module.exports = router