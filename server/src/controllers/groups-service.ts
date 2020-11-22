import { Group } from "../models/groups";

module.exports = class GroupsService {
  constructor() {}

  // Create Group
  createGroup(req: any) {
    const group = {
      creator_id: req.body.creator_id,
      group_name: req.body.group_name,
      }

    return new Promise((resolve, reject) => {
      Group.create(group, (err: any, result: any) => {
        if (err) {
          reject(err);
        }
        resolve(result);
      });
    });
  }

  // Find Group by Group ID
  findGroupByID(groupID: string) {
    return new Promise((resolve, reject) => {
      Group.findGroupByID(groupID, (err: any, res: any) => {
        if (err) {
          reject(err);
        }
        resolve(res);
      });
    });
  }

  // Find Group by UID
  findGroupByUID(UID: string) {
    return new Promise((resolve, reject) => {
      Group.findGroupByUID(UID, (err: any, res: any) => {
        if (err) {
          reject(err);
        }
        resolve(res);
      });
    });
  }

  // List Groups
  findGroups() {
    return new Promise((resolve, reject) => {
      Group.findGroups((err: any, res: any) => {
        if (err) {
          reject(err);
        }
        resolve(res);
      });
    });
  }
};
