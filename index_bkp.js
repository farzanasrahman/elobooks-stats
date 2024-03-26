import express from 'express';
import { db } from './src/config/db.js';
import cron from 'node-cron';
import emailService from './src/email/emailService.js';
import statRouter from './src/stat/statRouter.js';
//import { client } from './migrations/schema.js';
//import { sql } from 'drizzle-orm';

const app = express();
app.use('/stat', statRouter);

/*
const data = await db
  .withSchema('org_cQhNtiLlvP1rfNTE::ins_PxJMyxNIEPhkMUmX')
  .selectFrom('client')
  .selectAll()
  .execute();
*/
//const data = await db.execute(
//  sql`SELECT * FROM "org_cQhNtiLlvP1rfNTE::ins_PxJMyxNIEPhkMUmX"."client" limit 10`,
//);

await emailService.sendMail({
  from: 'process.env.email_sender', // sender address
  to: 'farzana.sadia01@northsouth.edu', // list of receivers
  subject: 'testing email from vscode', // Subject line
  text: 'Hello?', // plain text body
  html: '<h2>Hello??</h2>', // html body
});

cron.schedule('* * * * *', async () => {
  const yesterday = new Date();
  yesterday.setDate(yesterday.getDate() - 1);
  yesterday.setUTCHours(0, 0, 0, 0);

  const startOfDay = new Date(yesterday);
  const endOfDay = new Date(yesterday);
  endOfDay.setUTCHours(23, 59, 59, 999);
  console.log('running a task every minute');

  const data = await db
    .withSchema('org_cQhNtiLlvP1rfNTE::ins_PxJMyxNIEPhkMUmX')
    .selectFrom('sales_copy')
    //.select(({ fn }) => [fn.sum('totalAmount').as('total')])
    .select(['id', 'salesDate', 'totalAmount'])
    .where('salesDate', '>=', startOfDay.toISOString())
    .where('salesDate', '<', endOfDay.toISOString())
    //.compile();
    .execute();

  console.log(data);
  console.log(startOfDay);
  console.log(endOfDay);
});

app.get('/sale', async function (req, res) {
  const yesterday = new Date();
  yesterday.setDate(yesterday.getDate() - 1);
  yesterday.setUTCHours(0, 0, 0, 0);
  cron.schedule('* * * * *', async () => {
    const yesterday = new Date();
    yesterday.setDate(yesterday.getDate() - 1);
    yesterday.setUTCHours(0, 0, 0, 0);

    const startOfDay = new Date(yesterday);
    const endOfDay = new Date(yesterday);
    endOfDay.setUTCHours(23, 59, 59, 999);
    console.log('running a task every minute');

    const data = await db
      .withSchema('org_cQhNtiLlvP1rfNTE::ins_PxJMyxNIEPhkMUmX')
      .selectFrom('sales_copy')
      //.select(({ fn }) => [fn.sum('totalAmount').as('total')])
      .select(['id', 'salesDate', 'totalAmount'])
      .where('salesDate', '>=', startOfDay.toISOString())
      .where('salesDate', '<', endOfDay.toISOString())
      //.compile();
      .execute();

    console.log(data);
    console.log(startOfDay);
    console.log(endOfDay);
  });
  res.send(`Data shown for purchased items on ${yesterday}`);
});

app.get('/purchase', async function (req, res) {
  const yesterday = new Date();
  yesterday.setDate(yesterday.getDate() - 1);
  yesterday.setUTCHours(0, 0, 0, 0);

  cron.schedule('* * * * *', async () => {
    const yesterday = new Date();
    yesterday.setDate(yesterday.getDate() - 1);
    yesterday.setUTCHours(0, 0, 0, 0);

    const startOfDay = new Date(yesterday);
    const endOfDay = new Date(yesterday);
    endOfDay.setUTCHours(23, 59, 59, 999);
    console.log('running a task every minute');

    const data = await db
      .withSchema('org_cQhNtiLlvP1rfNTE::ins_PxJMyxNIEPhkMUmX')
      .selectFrom('purchase_copy')
      //.select(({ fn }) => [fn.sum('totalAmount').as('total')])
      .select(['id', 'purchaseDate', 'totalAmount'])
      .where('purchaseDate', '>=', startOfDay.toISOString())
      .where('purchaseDate', '<', endOfDay.toISOString())
      //.compile();
      .execute();

    console.log(data);
    console.log(startOfDay);
    console.log(endOfDay);
  });
  res.send(`Data shown for purchased items on ${yesterday}`);
});

/*
app.get('/', async function (req, res) {
  const yesterday = new Date();
  yesterday.setDate(yesterday.getDate() - 1);
  const data = await db
    .withSchema('org_cQhNtiLlvP1rfNTE::ins_PxJMyxNIEPhkMUmX')
    .selectFrom('purchase_copy')
    //.select(({ fn }) => [fn.sum('totalAmount').as('total')])
    .select(['id', 'purchaseDate', 'totalAmount'])
    .where('purchaseDate', '>=', yesterday)
    .where('purchaseDate', '<', new Date())
    .execute();
  res.json(data);
});
*/
app.listen(3000);
