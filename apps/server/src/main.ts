/**
 * This is not a production server yet!
 * This is only a minimal backend to get started.
 */

import * as express from 'express';
import * as cors from 'cors';
import { environment } from './environments';

const app = express();

if (environment.cors) {
  app.use(cors(environment.cors));
}

app.get('/api', (req, res) => {
  res.send({ message: 'Welcome to Just Test!' });
});

app.get('/health', (req, res) => {
  res.sendStatus(200);
});

const port = process.env.port || 3001;
const server = app.listen(port, () => {
  console.log(`Listening at http://localhost:${port}/api`);
});
server.on('error', console.error);
