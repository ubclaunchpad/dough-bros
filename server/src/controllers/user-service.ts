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
  findUserByUID(userID: string) {
    return new Promise((resolve, reject) => {
      User.findUserByUID(userID, (err: any, res: any) => {
        if (err) {
          reject(err);
        }
        resolve(res);
      });
    });
  }

  // Find User by Email
  findUserByEmail(email: string) {
    return new Promise((resolve, reject) => {
      User.findUsersByEmail(email, (err: any, res: any) => {
        if (err) {
          reject(err);
        }
        resolve(res);
      });
    });
  }

  // Find Owner
  findOwner(groupID: string) {
    return new Promise((resolve, reject) => {
      User.findOwner(groupID, (err: any, res: any) => {
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
      User.findUsers((err: any, res: any) => {
        if (err) {
          reject(err);
        }
        resolve(res);
      });
    });
  }

    // List Users Matching Regex Search
  findUserByPatternMatching(search: string) {
    return new Promise((resolve, reject) => {
      User.findUserByPatternMatching(search, (err: any, res: any) => {
        if (err) {
          reject(err);
        }
        resolve(res);
      });
    });
  }
};