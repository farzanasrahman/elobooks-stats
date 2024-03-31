import { db } from '../config/db.js';
import emailService from '../email/emailService.js';

export const daily = async (req, res) => {
  //1. get purchase data from db and calculate totalsum
  //2. get sales data deom db and calculate totalsum
  //3. create a simple html template using those values
  //4. sendmail using html template
  const yesterday = new Date();
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
  const totalAmountSum_sales = totalAmounts.reduce(
    (total, amount) => total + amount,
    0,
  );

  console.log('Total amount sum:', totalAmountSum_sales);

  console.log('Total amount sum:', totalAmounts);

  const purchase_data = await db
    .withSchema('org_HF49emb9HsTo8tuB::ins_M2SZ1pT5eATyvcx8')
    .selectFrom('purchase_copy')
    .select(['id', 'purchaseDate', 'totalAmount'])
    .where('purchaseDate', '>=', startOfDay.toISOString())
    .where('purchaseDate', '<', endOfDay.toISOString())
    //.compile();
    .execute();

  const totalAmount_purchase = purchase_data.map((purchase) =>
    parseInt(purchase.totalAmount),
  );
  const totalAmountSum_purchase = totalAmount_purchase.reduce(
    (total, amount) => total + amount,
    0,
  );

  console.log('Total amount sum:', totalAmountSum_purchase);

  console.log('Total amount sum:', totalAmount_purchase);

  await emailService.sendMail({
    from: 'process.env.EMAIL_USER', // sender address
    to: 'farzana.sadia01@northsouth.edu', // list of receivers
    subject: 'testing email from vscode', // Subject line
    text: `Daily statistics: Total Purchase: ${totalAmountSum_purchase}  Total Sales: ${totalAmountSum_sales}`, // plain text body
    html: `<h1>Daily Statistics:</h1>
    <p>Total Purchase:  ${totalAmountSum_purchase} Taka.</p>
    <p>Total Sale: ${totalAmountSum_sales} Taka.</p>`, // html body
  });
  console.log(sales_data);
  console.log(purchase_data);
  console.log(startOfDay);
  console.log(endOfDay);

  //sendMail
  res.send(
    `Daily statistics: Total Purchase: ${totalAmountSum_purchase}  Total Sales: ${totalAmountSum_sales}`,
  );
};
//export default { daily };
