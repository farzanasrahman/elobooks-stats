import express from 'express';
import statRouter from './src/stat/statRouter.js';

const app = express();
app.use('/stat', statRouter);
export default app;
