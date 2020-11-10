import { Router } from "express";

const router = Router();

const UsersService = require("../controllers/users-service");
const usersServer = new UsersService();

// Create a new Customer
router.get('/createUser', (req, res) => {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Methods", "POST, GET");
  res.setHeader("Access-Control-Allow-Headers", "Content-Type");
  
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

// get all
// router.get('/users', (req,res) => {
//     usersServer.findUsers().then((users: any) => {
//         res.json(users);
//     }).catch((err: any) => {
//         res.json(err);
//     });
// });
