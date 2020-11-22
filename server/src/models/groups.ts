const sql = require("../config/databaseHandler");

// Task object constructor <- I have no idea how to insert this into SQL
export const Group = function (this: any, group: any) {
  this.creator_id = group.creator_id;
  this.group_name = group.group_name;
};

Group.create = (newGroup: any, result: any) => {
  sql.query(
    "CALL createGroup(?,?)",
    [
      newGroup.creator_id,
      newGroup.group_name,
    ],
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

// TODO
Group.findGroupByID = (ID: string, result: any) => {
  sql.query(
    "CALL getUser(?)",
    ID,
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

// TODO
Group.findGroupByUID = (UID: string, result: any) => {
  sql.query(
    "CALL getUserByEmail(?)",
    UID,
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

Group.findGroups = (result: any) => {
  sql.query("SELECT * FROM `group`", (err: any, res: any) => {
    if (err) {
      console.log("error: ", err);
      result(err, null);
    } else {
      console.log(res);
      result(null, res);
    }
  });
};
