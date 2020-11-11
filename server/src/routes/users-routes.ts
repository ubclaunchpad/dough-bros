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

module.exports = router

// Get All Users
router.get('/listUsers', (_, res) => {
    usersServer.findUsers().then((users: any) => {
        res.json(users);
    }).catch((err: any) => {
        res.json(err);
    });
});
