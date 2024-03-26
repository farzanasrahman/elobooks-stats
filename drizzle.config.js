export default {
  schema: './migrations/schema.js',
  out: './migrations',
  driver: 'pg',
  dbCredentials: {
    ssl: true,
    host: 'dpg-cj7lu95jeehc73b5h080-a.singapore-postgres.render.com',
    port: 5432,
    user: 'elodev',
    password: '9tbn3fAFr7ESwdM9d2AL6YGBwMWB1zwW',
    database: 'localmigrationtest',
  },
  verbose: true,
  strict: true,
};
