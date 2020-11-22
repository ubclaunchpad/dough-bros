import { Group } from "../models/group";

module.exports = class GroupService {
  constructor() {}

  createGroup(req: any) {
    const group = {
        fk_creator_id: req.body.creator_id,
        group_name: req.body.group_name,
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
      fk_group_id: req.body.group_id,
      fk_user_id: req.body.user_id,
      fk_added_by_id: req.body.addedBy
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

  acceptGroupMembership(groupID: number, userID: string,) {
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
