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

async function attemptConnection() {
  try {
    const connection: any = await new Promise((resolve, reject) => {
      connectionPool.getConnection((err: any, connection: any) => {
        if (err) {
            console.error(err);
            reject(err);
        } else {
            console.log(`[MySQL] Successful connection: ${config.host}:${config.port}`);
        }
        resolve(connection);
      });
    });

    connection.release();
    return 0;
  } catch (err) {
    return -1;
  }
}

function delay(t: number, val: any) {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve(val);
    }, t);
  });
}

async function connectToMySQL(numTries: number, waitTime: number) {
  for (var i = 0; i < numTries; i++) {
    const exitCode = await attemptConnection();

    if (exitCode == -1) {
      await delay(waitTime, 0);
    } else {
      return;
    }
  }

  console.log(`[MySQL] ERROR: Could not connect after ${numTries} tries with ${waitTime} ms delay`);
}

connectToMySQL(3, 2000);
connectionPool.query = util.promisify(connectionPool.query);

module.exports = connectionPool;
