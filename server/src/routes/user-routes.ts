import { Router } from 'express';

const router = Router();

const UserService = require('../controllers/user-service');
const userServer = new UserService();

// Create a new User
router.post('/createUser', (req, res) => {
  // Validate request
  if (!req.body) {
    res.status(400).send({
      message: 'Content can not be empty!',
    });
  }

  userServer
    .createUser(req)
    .then((user: any) => {
      res.json(user);
    })
    .catch((err: any) => {
      res.json(err);
    });
});

// Get User by ID
router.get('/getUserByUID/:userID', (req, res) => {
  userServer
    .findUserByUID(req.params.userID)
    .then((user: any) => {
      res.json(user);
    })
    .catch((err: any) => {
      res.json(err);
    });
});

// Get User by Email
router.get('/getUserByEmail/:email', (req, res) => {
  userServer.findUserByEmail(req.params.email).then((users: any) => {
      res.json(users);
  }).catch((err: any) => {
      res.json(err);
  });
});

// Get User by GroupID
router.get('/getOwnerByGroupID/:groupID', (req, res) => {
  userServer.findOwner(req.params.groupID).then((users: any) => {
      res.json(users);
  }).catch((err: any) => {
      res.json(err);
  });
});

// Get All Users
router.get('/getAllUsers', (_, res) => {
  userServer
    .findAllUsers()
    .then((users: any) => {
      res.json(users);
    })
    .catch((err: any) => {
      res.json(err);
    });
});

// Get User List by Regex Matching
router.get('/findUserByPatternMatching/:search', (req, res) => {
  userServer.findUserByPatternMatching(req.params.search).then((users: any) => {
      res.json(users);
  }).catch((err: any) => {
      res.json(err);
  });
});

module.exports = router;
