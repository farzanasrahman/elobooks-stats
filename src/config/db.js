import { Kysely, PostgresDialect } from 'kysely';
import pkg from 'pg';
import { env } from './env.js';

const { Pool } = pkg;
const dialect = new PostgresDialect({
  pool: new Pool({
    ssl: true,
    host: env.DB_HOST,
    port: env.DB_PORT,
    user: env.DB_USER,
    password: env.DB_PASSWORD,
    database: env.DB_NAME,
    max: 5,
  }),
});

export const db = new Kysely({
  dialect,
});
