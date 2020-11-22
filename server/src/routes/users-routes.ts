import { Router } from "express";

const router = Router();

const UsersService = require("../controllers/users-service");
const usersServer = new UsersService();

// Create a new User
router.post('/createUser', (req, res) => {
  // Validate request
  if (!req.body) {
    res.status(400).send({
      message: "Content can not be empty!",
    });
  }

  usersServer
    .createUser(req)
    .then((users: any) => {
      res.json(users);
    })
    .catch((err: any) => {
      res.json(err);
    });
});

// Get User by ID
router.get('/getUser/:userID', (req, res) => {
  usersServer.findUserByID(req.params.userID).then((users: any) => {
      res.json(users);
  }).catch((err: any) => {
      res.json(err);
  });
});

// Get User by Email
router.get('/getUserByEmail/:email', (req, res) => {
  usersServer.findUserByEmail(req.params.email).then((users: any) => {
      res.json(users);
  }).catch((err: any) => {
      res.json(err);
  });
});

// Get All Users
router.get('/listUsers', (_, res) => {
    usersServer.findUsers().then((users: any) => {
        res.json(users);
    }).catch((err: any) => {
        res.json(err);
    });
});

module.exports = router