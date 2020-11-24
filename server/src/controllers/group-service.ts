import { Group } from '../models/group';

module.exports = class GroupService {
  constructor() {}

  createGroup(req: any) {
    const group = {
      fk_creator_id: req.body.gk_creator_id,
      group_name: req.body.group_name,
    };

    return new Promise((resolve, reject) => {
      Group.createGroup(group, (err: any, res: any) => {
        if (err) {
          reject(err);
        }
        resolve(res);
      });
    });
  }

  addUserToGroup(groupMembership: any) {
    return new Promise((resolve, reject) => {
      Group.addUserToGroup(groupMembership, (err: any, res: any) => {
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
