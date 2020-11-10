import express, {Request, Response} from 'express';

// @ts-ignore
const sql = require('./config/databaseHandler');

const app = express();
const PORT = 8000;

// @ts-ignore: unused parameter
app.get('/', (req: Request, res: Response) => {
  res.send(`Welcome to the Dough Bros Server`);
});

app.listen(PORT, () => {
  console.log(`⚡️[server]: listening on PORT ${PORT}`);
});