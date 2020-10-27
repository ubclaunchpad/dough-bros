"use strict";

import mysql from "mysql";

const config = {
  host: "localhost",
  port: 3307,
  user: "user",
  password: "root",
  database: "doughBros_db"
};

const connection = mysql.createConnection(config);
connection.connect(function(err) {
  if (err) console.log(err);
  console.log("Database Connected: " + config.host + ":" + config.port);
});

module.exports = connection;