import { db } from '../config/db.js';
import emailService from '../email/emailService.js';
import { getDailyStatTemplate } from '../utils/shared.js';

process.env.TZ = 'Asia/Dhaka';
/**
 * Fetches total Sum of Sales And purchase and sends mail
 */
export const daily = async (req, res) => {
  const yesterday = new Date(new Date().toLocaleString());
  yesterday.setDate(yesterday.getDate() - 1);
  yesterday.setUTCHours(0, 0, 0, 0);

  const startOfDay = new Date(yesterday);
  const endOfDay = new Date(yesterday);
  endOfDay.setUTCHours(23, 59, 59, 999);

  const sales_data = await db
    .withSchema('org_HF49emb9HsTo8tuB::ins_M2SZ1pT5eATyvcx8')
    .selectFrom('sales_copy')
    //.select(({ fn }) => [fn.sum('totalAmount').as('total')])
    .select(['id', 'salesDate', 'totalAmount'])
    .where('salesDate', '>=', startOfDay.toISOString())
    .where('salesDate', '<', endOfDay.toISOString())
    //.compile();
    .execute();

  const totalAmounts = sales_data.map((sale) => parseInt(sale.totalAmount));
  const totalSalesSum = totalAmounts.reduce(
    (total, amount) => total + amount,
    0,
  );

  const purchase_data = await db
    .withSchema('org_HF49emb9HsTo8tuB::ins_M2SZ1pT5eATyvcx8')
    .selectFrom('purchase_copy')
    .select(['id', 'purchaseDate', 'totalAmount'])
    .where('purchaseDate', '>=', startOfDay.toISOString())
    .where('purchaseDate', '<', endOfDay.toISOString())
    .execute();

  const totalPurchase = purchase_data.map((purchase) =>
    parseInt(purchase.totalAmount),
  );
  const totalPurchaseSum = totalPurchase.reduce(
    (total, amount) => total + amount,
    0,
  );

  await emailService.sendMail({
    from: 'process.env.EMAIL_USER',
    to: 'farzana.sadia01@northsouth.edu',
    subject: 'Elobooks Statistics',
    text: `Daily statistics: Total Purchase: ${totalPurchaseSum}  Total Sales: ${totalSalesSum}`,
    html: getDailyStatTemplate(totalSalesSum, totalPurchaseSum),
  });
  res.send(
    `Daily statistics: Total Purchase: ${totalPurchaseSum}  Total Sales: ${totalSalesSum}`,
  );
};
