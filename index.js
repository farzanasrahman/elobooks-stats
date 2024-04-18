import app from './src/app.js';
import { env } from './src/config/env.js';

const server = app.listen(env.PORT, () => {
  console.log(`Listening on port ${env.PORT}`);
});

const SIGNALS = ['SIGINT', 'SIGTERM', 'SIGHUP'];
for (let i = 0; i < SIGNALS.length; i++) {
  process.on(SIGNALS[i], () => {
    console.error(`👋 ${SIGNALS[i]} RECEIVED. Shutting down gracefully`);
    server.close(() => {
      console.error('💥 Process terminated!');
    });
  });
}
