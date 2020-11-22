import { Router } from "express";

const router = Router();

const GroupsService = require("../controllers/groups-service");
const groupsService = new GroupsService();

// Create a new Group
router.post('/createGroup', (req, res) => {
  // Validate request
  if (!req.body) {
    res.status(400).send({
      message: "Content can not be empty!",
    });
  }

  groupsService
    .createGroup(req)
    .then((users: any) => {
      res.json(users);
    })
    .catch((err: any) => {
      res.json(err);
    });
});

// Get Group by ID
router.get('/getGroup/:groupID', (req, res) => {
  groupsService.findUserByID(req.params.groupID).then((users: any) => {
      res.json(users);
  }).catch((err: any) => {
      res.json(err);
  });
});

// Get Group by UID
router.get('/getGroupByUID/:UID', (req, res) => {
  groupsService.findUserByUID(req.params.UID).then((users: any) => {
      res.json(users);
  }).catch((err: any) => {
      res.json(err);
  });
});

// Get All Groups
router.get('/listGroups', (_, res) => {
    groupsService.findGroups().then((users: any) => {
        res.json(users);
    }).catch((err: any) => {
        res.json(err);
    });
});

module.exports = router