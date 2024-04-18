import express from 'express';
import { daily } from './statService.js';

const router = express.Router();

router.get('/daily', daily);

export default router;
