const sql = require('../config/database-handler');

export const Group = function (this: any, group: any) {
  this.group_id = group.group_id;
  this.fk_creator_id = group.gk_creator_id;
  this.group_name = group.group_name;
};

Group.createGroup = (newGroup: any, result: any) => {
  sql.query(
    'CALL createGroupExpense(?,?)',
    [newGroup.fk_creator_id, newGroup.group_name],
    (err: any, res: any) => {
      if (err) {
        console.log('error: ', err);
        result(err, null);
      } else {
        console.log('Created Group: ', res);
        result(null, res);
      }
    }
  );
};

Group.addUserToGroup = (newGroupMembership: any, result: any) => {
  sql.query(
    'CALL addUserToGroup(?,?,?,)',
    [
      newGroupMembership.fk_group_id,
      newGroupMembership.fk_user_id,
      newGroupMembership.fk_added_by_id,
    ],
    (err: any, res: any) => {
      if (err) {
        console.log('error: ', err);
        result(err, null);
      } else {
        console.log('Created Group Membership: ', res);
        result(null, res);
      }
    }
  );
};

Group.getAllGroupUsers = (groupID: number, result: any) => {
  sql.query('CALL getAllGroupUsers(?)', groupID, (err: any, res: any) => {
    if (err) {
      console.log('error: ', err);
      result(err, null);
    } else {
      console.log(res);
      result(null, res);
    }
  });
};

Group.acceptGroupMembership = (
  groupID: number,
  userID: string,
  result: any
) => {
  sql.query(
    'CALL archiveGroupExpense(?,?)',
    groupID,
    userID,
    (err: any, res: any) => {
      if (err) {
        console.log('error: ', err);
        result(err, null);
      } else {
        console.log(res);
        result(null, res);
      }
    }
  );
};
