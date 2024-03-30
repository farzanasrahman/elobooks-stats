import express from 'express';
import { daily } from './statService.js';

const router = express.Router();

router.get(
  '/daily',
  (req, res, next) => {
    res.send('Daily stat');
    next();
  },
  daily,
);

export default router;
