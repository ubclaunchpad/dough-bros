import { User } from "../models/users";

module.exports = class UsersService {
  constructor() {}

  // Create User
  createUser(req: any) {
    const user = {
        firebase_uid: req.body.firebase_uid,
        first_name: req.body.first_name,
        last_name: req.body.last_name,
        email_addr: req.body.email_addr,
        facebook_id: req.body.facebook_id,
        is_anon: req.body.is_anon,
        fcm_token: req.body.fcm_token,
      }

    return new Promise((resolve, reject) => {
      User.create(user, (err: any, result: any) => {
        if (err) {
          reject(err);
        }
        resolve(result);
      });
    });
  }

  // Find User by ID
  findUserByID(userID: string) {
    return new Promise((resolve, reject) => {
      User.findUsersByID(userID, (err: any, res: any) => {
        if (err) {
          reject(err);
        }
        resolve(res);
      });
    });
  }

  // List Users
  findUsers() {
    return new Promise((resolve, reject) => {
      User.findUsers((err: any, res: any) => {
        if (err) {
          reject(err);
        }
        resolve(res);
      });
    });
  }
};
