const sql = require("../config/databaseHandler");

// Task object constructor <- I have no idea how to insert this into SQL
export const User = function(this: any, user: any){
    this.firebase_uid = user.firebase_uid;
    this.first_name = user.first_name;
    this.last_name = user.last_name;
    this.email_addr = user.email_addr;
    this.facebook_id = user.facebook_id;
    this.is_anon = user.is_anon;
    this.fcm_token = user.fcm_token;
};

User.create = (newUser: any, result: any) => {
    sql.query("INSERT INTO user SET ? ON DUPLICATE KEY UPDATE ?", [newUser, newUser], (err: any, res: any) => {
      if (err) {
        console.log("error: ", err);
        result(err, null);
      } else {
        console.log("Created User: ", { id: res.insertId, ...newUser });
        result(null, { id: res.insertId, ...newUser });
      }
    });
  };

User.findUsers = (result: any) => {
    sql.query("SELECT * FROM user", (err: any, res: any) => {
        if (err) {
            console.log("error: ", err);
            result(err, null);
        } else {
            console.log(res);
            result(null, res);
        }
    });
};