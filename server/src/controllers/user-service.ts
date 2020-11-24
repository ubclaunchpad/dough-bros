import { User } from '../models/user';

module.exports = class UserService {
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
    };

    return new Promise((resolve, reject) => {
      User.createUser(user, (err: any, result: any) => {
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
      User.findUserByID(userID, (err: any, res: any) => {
        if (err) {
          reject(err);
        }
        resolve(res);
      });
    });
  }

  // List Users
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
};
