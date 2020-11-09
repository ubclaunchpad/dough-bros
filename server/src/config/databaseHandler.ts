"use strict";

const mysql = require("mysql");
const util = require("util");

const config = {
  host: "doughBros_db",
  port: 3306,
  user: "root",
  password: "root",
  database: "doughBros_db"
};

const connectionPool = mysql.createPool(config);

// Test Call
connectionPool.getConnection((err: any, connection: any) => {
  if (err) {
      console.error(err);
  } else {
      console.log(`[MySQL] Successful connection: ${config.host}:${config.port}`);
  }

  if (connection) {
      connection.release();
  }
});

connectionPool.query = util.promisify(connectionPool.query);

// const connection = mysql.createConnection(config);
// connection.connect(function(err:any) {
//   if (err) console.log(err);
//   console.log("Database Connected: " + config.host + ":" + config.port);
// });

module.exports = connectionPool;