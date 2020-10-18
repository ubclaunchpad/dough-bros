import express from 'express';

const app = express();
const PORT = 8000;

// @ts-ignore: unused parameter
app.get('/', (req, res) => res.send('Hello, World!'));
app.listen(PORT, () => {
  console.log(`⚡️[server]: Server is running at http://localhost:${PORT}`);
});

