const sql = require('../config/database-handler');

export const Group = function (this: any, group: any) {
  this.group_id = group.group_id;
  this.fk_creator_id = group.firebase_uid;
  this.group_name = group.group_name;
  this.image_uri = group.image_uri;
  this.amount = group.amount;
};

Group.createGroup = (newGroup: any, result: any) => {
  sql.query(
    "INSERT INTO `group` SET ?", newGroup,
    (err: any, res: any) => {
      if (err) {
        console.log('error: ', err);
        result(err, null);
      } else {
        console.log("Created Group: ", { id: res.insertId, ...newGroup });
        result(null, { id: res.insertId, ...newGroup });
      }
    }
  );
};

Group.addUserToGroup = (newGroupMembership: any, result: any) => {
  sql.query(
    "CALL addUserToGroup(?,?,?,?)",
    [
      newGroupMembership.group_id,
      newGroupMembership.user_id,
      newGroupMembership.added_by_id,
      0
    ],
    (err: any, res: any) => {
      if (err) {
        console.log("error: ", err);
        result(err, null);
      } else {
        console.log("Created Group Membership: ", { id: res.insertId, ...newGroupMembership });
        result(null, { id: res.insertId, ...newGroupMembership });
      }
    }
  );
};

  // Todo Convert Image, Amount & Other Fields Later!!
Group.findGroupByUID = (userID: string, result: any) => {
  sql.query(
    "CALL getGroupByUID(?)",
    userID,
    (err: any, res: any) => {
      if (err) {
        console.log("error: ", err);
        result(err, null);
      } else {
        result(null, res[0]);
      }
    }
  );
};

Group.findPendingGroupByUID = (userID: string, result: any) => {
  sql.query(
    "CALL getPendingGroupByUID(?)",
    userID,
    (err: any, res: any) => {
      if (err) {
        console.log("error: ", err);
        result(err, null);
      } else {
        result(null, res[0]);
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
      result(null, res[0]);
    }
  });
};

Group.acceptGroupMembership = (
  groupID: number,
  userID: string,
  result: any
) => {
  sql.query(
    'CALL acceptGroupMembership(?, ?)',
    [groupID, userID],
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

Group.setGroupName = (
  groupID: number,
  groupName: string,
  result: any
) => {
  sql.query(
    'CALL setGroupName(?, ?)',
    [groupID, groupName],
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

Group.deleteGroup = (groupID: number, result: any) => {
  sql.query(
    "CALL deleteGroup(?)",
    groupID,
    (err: any, res: any) => {
      if (err) {
        console.log("error: ", err);
        result(err, null);
      } else {
        result(null, res[0]);
      }
    }
  );
};

Group.removeAllUsersFromGroup = (groupID: number, result: any) => {
  sql.query(
    "CALL removeAllUsersFromGroup(?)",
    groupID,
    (err: any, res: any) => {
      if (err) {
        console.log("error: ", err);
        result(err, null);
      } else {
        result(null, res[0]);
      }
    }
  );
};