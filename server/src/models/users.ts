// const sql = require("../config/databaseHandler");

// //Task object constructor
// export const User = function(this: any, user: any){
//     this.first_name = user.first_name;
//     this.last_name = user.last_name;
//     this.city = user.city;
//     this.phone = user.phone;
//     this.gender = user.gender;
//     this.email = user.email;
//     this.address = user.address;
//     this.postcode = user.postcode;
//     this.date_of_birth = user.date_of_birth;
// };

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