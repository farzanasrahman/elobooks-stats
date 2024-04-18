import { config } from 'dotenv';
import { cleanEnv, str, num } from 'envalid';

config();

export const env = cleanEnv(process.env, {
  EMAIL_USER: str(),
  EMAIL_USER_PASSWORD: str(),
  DB_HOST: str(),
  DB_PORT: num({ default: 5432 }),
  DB_USER: str(),
  DB_PASSWORD: str(),
  DB_NAME: str(),
  PORT: num({ default: 8080 }),
});
