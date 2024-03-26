import nodemailer from 'nodemailer';
import { env } from './env.js';
//import { config } from 'dotenv';
//config();
export const transporter = nodemailer.createTransport({
  host: 'smtp.gmail.com',
  port: 587,
  secure: false, // Use `true` for port 465, `false` for all other ports
  auth: {
    user: env.EMAIL_USER,
    pass: env.EMAIL_USER_PASSWORD,
    // user: process.env.email_sender,
    // pass: process.env.user_password,
  },
});
//dqohfrvetsnmuafz
/*
export const transporter = nodemailer.createTransport({
  host: 'sandbox.smtp.mailtrap.io',
  //host: 'live.smtp.mailtrap.io',
  port: 2525,
  secure: false,
  requireTLS: true,
  auth: {
    user: '2f5f74dd58fdc0',
    pass: '678b64c929d7ee',
  },
});
*/
