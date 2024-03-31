import express from 'express';
import { daily } from './statService.js';

const router = express.Router();

router.get(
  '/daily',
  (req, res, next) => {
    console.log('daily stat');
    next();
  },
  daily,
);

export default router;
