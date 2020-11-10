import express from 'express';
import bodyParser from "body-parser";

const app = express();
const PORT = 8000;

let userRoute = require('./routes/users-routes')

// parse requests of content-type: application/json
app.use(bodyParser.json());

// parse requests of content-type: application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: true }));

// @ts-ignore: unused parameter
app.get('/', (req, res) => res.send('Welcome to Dough Bros'));

app.use('/users', userRoute);

app.listen(PORT, () => {
  console.log(`⚡️[server]: Server is running at http://localhost:${PORT}`);
});

