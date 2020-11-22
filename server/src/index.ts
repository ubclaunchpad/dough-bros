import express, {Request, Response} from 'express';
import bodyParser from "body-parser";

// @ts-ignore
const sql = require('./config/databaseHandler');

const app = express();
const PORT = 8000;

let userRoute = require('./routes/user-routes')
let paymentRoute = require('./routes/payment-routes')

// parse requests of content-type: application/json
app.use(bodyParser.json());

// parse requests of content-type: application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: true }));

// @ts-ignore: unused parameter
app.get('/', (req: Request, res: Response) => res.send('Welcome to Dough Bros!!'));

app.use('/users', userRoute);
app.use('/payments', paymentRoute);

app.listen(PORT, () => {
  console.log(`⚡️[server]: listening on PORT ${PORT}`);
});