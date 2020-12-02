-- -------------------------------------------
-- Houson in Ailn group, owes Ailn 100.10 CAD
-- Surmeyers, Bob in Tison group, each owe Tison 100.25 CAD

-- create mock currency
CALL doughBros_db.createCurrency('CAD', '$');

-- create mock users
CALL doughBros_db.createUser('zhxcuiashui2442', 'Ailn', 'Rathmouth','mailn0@bravesites.com', 'mailn0', 0, 'q32cwadscdsg');
CALL doughBros_db.createUser('cewui3287rhd', 'Hounson', 'Port Lolamouth', 'dhounson1@slashdot.org', 'dhouson1,', 1, 'r3fwefewf');
CALL doughBros_db.createUser('csnuih23u2e', 'Tison', 'Lavernastad', 'ctison2@europa.eu', 'ctison2', 0, 'f32dasdsff');
CALL doughBros_db.createUser('r3j24qurhfsjdf', 'Surmeyers', 'Ethelville', 'msurmeyers3@nytimes.com', 'msurmeyers3', 0, 'qdewafewq23');
CALL doughBros_db.createUser('r3289qhfwui', 'Bob', 'Schulistland', 'scbob@opensource.org', 'scbob', 1, '3q2f3dwsafw');

-- create mock groups (Ailn group, Tison group)
CALL doughBros_db.createGroup('zhxcuiashui2442', 'Ailn group', 'www.Avataruri.com', 100);
CALL doughBros_db.createGroup('csnuih23u2e', 'Tison group', 'www.Avataruri.com', 300);

-- create mock group membership (Ailn group: Ailn, Houson, Tison group: Tison, Surmeyers, Bob)
CALL doughBros_db.addUserToGroup(1, 'zhxcuiashui2442', 'zhxcuiashui2442', 1);
CALL doughBros_db.addUserToGroup(1, 'cewui3287rhd', 'zhxcuiashui2442', 1);
CALL doughBros_db.addUserToGroup(2, 'csnuih23u2e', 'csnuih23u2e', 1);
CALL doughBros_db.addUserToGroup(2, 'r3j24qurhfsjdf', 'csnuih23u2e', 1);
CALL doughBros_db.addUserToGroup(2, 'r3289qhfwui', 'csnuih23u2e', 1);

-- create mock group expense
CALL doughBros_db.createGroupExpense(1, 'zhxcuiashui2442', 1, 'Ailn group expense', 0, 100);
CALL doughBros_db.createGroupExpense(2, 'csnuih23u2e', 1, 'Tison group expense', 0, 300);

-- create mock payments
CALL doughBros_db.createPayment('cewui3287rhd', 'zhxcuiashui2442', 'zhxcuiashui2442', 1, 1, 0, 0, 100);
CALL doughBros_db.createPayment('r3j24qurhfsjdf', 'csnuih23u2e', 'csnuih23u2e', 1, 1, 0, 0,  150);
CALL doughBros_db.createPayment('r3289qhfwui', 'csnuih23u2e', 'csnuih23u2e', 1, 1, 0, 0,  150);

-- -------------------------------------------