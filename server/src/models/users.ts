const sql = require("../config/databaseHandler");

// //Task object constructor
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
    sql.query("INSERT INTO user SET ?", newUser, (err: any, _: any) => {
      if (err) {
        console.log("error: ", err);
        result(err, null);
      }
  
      console.log("Created User: ", { ...newUser });
      result(null, { ...newUser });
    });
  };

// User.findAllUsers = (result: any) => {
//     sql.query("SELECT * from user", (err: any, res: any) => {
//         if (err) {
//             console.log("error: ", err);
//             result(err, null);
//         } else {
//             console.log(res);
//             result(null, res);
//         }
//     });
// };