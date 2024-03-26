import express from 'express';

const router = express.Router();

router.get('/daily', (req, res) => {
  res.send('Daily stat');
});

export default router;
