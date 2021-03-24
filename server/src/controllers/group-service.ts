import { Group } from '../models/group';
import { GroupExpense } from '../models/group-expense';

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

  setGroupName(groupID: number, groupName: string) {
    return new Promise((resolve, reject) => {
      Group.setGroupName(groupID, groupName, (err: any, res: any) => {
        if (err) {
          reject(err);
        }
        resolve(res);
      });
    });
  }

  deleteGroup(groupID: number) {
    return new Promise((resolve, reject) => {
      // get list of group expenses by group id
      GroupExpense.getGroupExpenseByGroupId(groupID, (err: any, res: any) => {
        if (err) {
          reject(err);
        }
        resolve(res);
      });
    }).then((group_expense_list: any) => {
      return new Promise((resolve, reject) => {
        // for each group expense id, delete all payments
        for (var group_expense of group_expense_list){
          GroupExpense.deleteGroupExpenseById(group_expense.expense_id, (err: any, res: any) => {
            if (err) {
              reject(err);
            }
            resolve(res);
          });
        }
        // delete group members from group
        Group.removeAllUsersFromGroup(groupID, (err: any, res: any) => {
          if (err) {
            reject(err);
          }
          resolve(res);
        });
        // delete group
        Group.deleteGroup(groupID, (err: any, res: any) => {
          if (err) {
            reject(err);
          }
          resolve(res);
        });
      });
    });
  }
};