import { User } from "../models/users";

module.exports = class UsersService {

    constructor() { }

    //find all
    findAllUsers() {
        return new Promise((resolve, reject) => {
            User.findAllUsers((err: any, res: any) => {
                if (err) {
                    reject(err);
                }
                resolve(res);
            });
        });
    }
}