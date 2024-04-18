import express from 'express';
import statRouter from './stat/statRouter.js';
const app = express();

app.get('/ping', (req, res) => {
  res.status(200).send('Pong');
});
app.use('/stat', statRouter);
export default app;
