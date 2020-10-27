import { Router } from "express";

const router = Router();

const UsersService = require('../services/users-service');
const usersServer = new UsersService();

// get all
router.get('/', (req,res) => {
    usersServer.findUsers().then((users: any) => {
        res.json(users);
    }).catch((err: any) => {
        res.json(err);
    });
});
