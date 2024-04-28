import express from 'express';
import statRouter from './stat/statRouter.js';
const app = express();

app.get('/ping', (req, res, next) => {
  try {
    res.status(200).send('Pong');
  } catch (error) {
    next(error);
  }
});

app.use('/stat', statRouter);

app.use((req, res, next) => {
  const error = new Error('Not Found');
  error.status = 404;
  next(error);
});

// eslint-disable-next-line no-unused-vars
app.use((error, req, res, _) => {
  console.log(error);
  error.status = error.status || 500;
  res.status(error.status);
  res.send(`${error.status} error, path not found!`);
});
export default app;
