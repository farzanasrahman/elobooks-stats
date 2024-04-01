import app from './src/app.js';

const server = app.listen(3000, () => {
  console.log('Listening on port 3000');
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
