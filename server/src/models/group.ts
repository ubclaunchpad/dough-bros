const sql = require("../config/databaseHandler");

export const Group = function (this: any, group: any) {
  this.group_id = group.group_id;
  this.fk_creator_id = group.firebase_uid;
  this.group_name = group.group_name;
};

Group.createGroup = (newGroup: any, result: any) => {
  sql.query(
    "INSERT INTO `group` SET ?", newGroup,
    (err: any, res: any) => {
      if (err) {
        console.log("error: ", err);
        result(err, null);
      } else {
        console.log("Created Group: ", { id: res.insertId, ...newGroup });
        result(null, { id: res.insertId, ...newGroup });
      }
    }
  );
};

// Auto accepting invite rn!!
Group.addUserToGroup = (newGroupMembership: any, result: any) => {
    sql.query(
      "CALL addUserToGroup(?,?,?,?)",
      [
        newGroupMembership.fk_group_id,
        newGroupMembership.fk_user_id,
        newGroupMembership.fk_added_by_id,
        1
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

  Group.getAllGroupUsers = (groupID: number, result: any) => {
    sql.query(
      "CALL getAllGroupUsers(?)", groupID,
      (err: any, res: any) => {
        if (err) {
          console.log("error: ", err);
          result(err, null);
        } else {
          console.log(res);
          result(null, res);
        }
      }
    );
  };

  Group.acceptGroupMembership = (groupID: number, userID: string, result: any) => {
    sql.query(
      "CALL archiveGroupExpense(?,?)", groupID, userID,
      (err: any, res: any) => {
        if (err) {
          console.log("error: ", err);
          result(err, null);
        } else {
          console.log(res);
          result(null, res);
        }
      }
    );
  };