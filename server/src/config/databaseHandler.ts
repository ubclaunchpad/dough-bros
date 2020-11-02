"use strict";

var mysql = require("mysql");

const config = {
  host: "localhost",
  port: 3307,
  user: "user",
  password: "root",
  database: "doughBros_db"
};

const connection = mysql.createConnection(config);
connection.connect(function(err:any) {
  if (err) console.log(err);
  console.log("Database Connected: " + config.host + ":" + config.port);
});

module.exports = connection;