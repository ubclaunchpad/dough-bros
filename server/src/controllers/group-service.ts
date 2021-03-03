import { Group } from '../models/group';

module.exports = class GroupService {
  constructor() {}

  createGroup(req: any) {
    const group = {
        fk_creator_id: req.body.creator_id,
        group_name: req.body.group_name,
        image_uri: req.body.image_uri,
        amount: req.body.amount,
      }

    return new Promise((resolve, reject) => {
      Group.createGroup(group, (err: any, res: any) => {
        if (err) {
          reject(err);
        }
        resolve(res);
      });
    });
  }

  addUserToGroup(req: any) {
    const addInfo = {
      group_id: req.body.group_id,
      user_id: req.body.user_id,
      added_by_id: req.body.added_by_id
    }
    return new Promise((resolve, reject) => {
      Group.addUserToGroup(addInfo, (err: any, res: any) => {
        if (err) {
          reject(err);
        }
        resolve(res);
      });
    });
  }

  getGroupByUID(userID: string) {
    return new Promise((resolve, reject) => {
      Group.findGroupByUID(userID, (err: any, res: any) => {
        if (err) {
          reject(err);
        }
        resolve(res);
      });
    });
  }

  getPendingGroupByUID(userID: string) {
    return new Promise((resolve, reject) => {
      Group.findPendingGroupByUID(userID, (err: any, res: any) => {
        if (err) {
          reject(err);
        }
        resolve(res);
      });
    });
  }

  getAllGroupUsers(groupID: number) {
    return new Promise((resolve, reject) => {
      Group.getAllGroupUsers(groupID, (err: any, res: any) => {
        if (err) {
          reject(err);
        }
        resolve(res);
      });
    });
  }

  acceptGroupMembership(groupID: number, userID: string) {
    return new Promise((resolve, reject) => {
      Group.acceptGroupMembership(groupID, userID, (err: any, res: any) => {
        if (err) {
          reject(err);
        }
        resolve(res);
      });
    });
  }
};