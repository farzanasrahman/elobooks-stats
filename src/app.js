import express from 'express';
import statRouter from './stat/statRouter.js';

const app = express();
app.use('/stat', statRouter);
export default app;
