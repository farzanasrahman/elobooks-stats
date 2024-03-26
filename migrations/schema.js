import {
  pgTable,
  pgEnum,
  timestamp,
  varchar,
  //foreignKey,
  uuid,
  numeric,
  integer,
  unique,
  serial,
  bigint,
  jsonb,
  boolean,
  text,
  primaryKey,
} from 'drizzle-orm/pg-core';
import { sql } from 'drizzle-orm';

export const productTemplateAttributeTypeEnum = pgEnum(
  'product_template_attribute_type_enum',
  ['text', 'boolean', 'float', 'dropdown'],
);

export const tenants = pgTable('tenants', {
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  id: varchar('id').primaryKey().notNull(),
  name: varchar('name').notNull(),
  displayName: varchar('display_name').default('null').notNull(),
  description: varchar('description').default('null').notNull(),
});

export const transferStock = pgTable('transfer_stock', {
  id: varchar('id').primaryKey().notNull(),
  keywords: varchar('keywords').notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  fromWarehouseId: varchar('from_warehouse_id').references(() => warehouse.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
  toWarehouseId: varchar('to_warehouse_id').references(() => warehouse.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
  userId: uuid('user_id').references(() => user.id),
  transferDate: timestamp('transferDate', { mode: 'string' })
    .defaultNow()
    .notNull(),
  totalStockValue: numeric('totalStockValue').default('0').notNull(),
  note: varchar('note'),
});

export const transferStockCopy = pgTable('transfer_stock_copy', {
  id: varchar('id').primaryKey().notNull(),
  transferDate: timestamp('transferDate', { mode: 'string' })
    .defaultNow()
    .notNull(),
  totalStockValue: numeric('totalStockValue').default('0').notNull(),
  note: varchar('note'),
  keywords: varchar('keywords').notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  fromWarehouseId: varchar('from_warehouse_id').references(() => warehouse.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
  toWarehouseId: varchar('to_warehouse_id').references(() => warehouse.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
  userId: uuid('user_id').references(() => user.id),
});

export const transferStockProduct = pgTable('transfer_stock_product', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  quantity: integer('quantity').notNull(),
  unitPrice: numeric('unitPrice').default('0').notNull(),
  stockValue: numeric('stockValue').default('0').notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  transferStockId: varchar('transfer_stock_id').references(
    () => transferStock.id,
    { onDelete: 'cascade', onUpdate: 'cascade' },
  ),
  productId: varchar('product_id').references(() => product.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
});

export const address = pgTable('address', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  street: varchar('street'),
  area: varchar('area'),
  city: varchar('city'),
  country: varchar('country'),
  zip: varchar('zip'),
});

export const category = pgTable(
  'category',
  {
    id: uuid('id')
      .default(sql`uuid_generate_v4()`)
      .primaryKey()
      .notNull(),
    name: varchar('name').notNull(),
    description: varchar('description').notNull(),
    keywords: varchar('keywords'),
    createdAt: timestamp('created_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
  },
  (table) => {
    return {
      uq23C05C292C439D77B0De816B500: unique(
        'UQ_23c05c292c439d77b0de816b500',
      ).on(table.name),
    };
  },
);

export const client = pgTable(
  'client',
  {
    id: uuid('id')
      .default(sql`uuid_generate_v4()`)
      .primaryKey()
      .notNull(),
    name: varchar('name').notNull(),
    email: varchar('email').notNull(),
    mobileNumber: varchar('mobileNumber').notNull(),
    keywords: varchar('keywords').notNull(),
    createdAt: timestamp('created_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    deletedAt: timestamp('deleted_at', { mode: 'string' }),
    clientCode: varchar('clientCode').notNull(),
    address: uuid('address').references(() => address.id, {
      onDelete: 'set null',
    }),
  },
  (table) => {
    return {
      uq16172474F6E1B1214Ecf7450133: unique(
        'UQ_16172474f6e1b1214ecf7450133',
      ).on(table.clientCode),
      relD6A484C4E2De6B5993F68D1B19: unique(
        'REL_d6a484c4e2de6b5993f68d1b19',
      ).on(table.address),
    };
  },
);

export const clientPaymentMethod = pgTable('client_payment_method', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  accountName: varchar('accountName').notNull(),
  accountNumber: varchar('accountNumber').notNull(),
  bankName: varchar('bankName').notNull(),
  branchName: varchar('branchName').notNull(),
  swiftCode: varchar('swiftCode').notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  clientId: uuid('client_id').references(() => client.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
});

export const clientPhoto = pgTable('client_photo', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  clientId: uuid('client_id').references(() => client.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
  photoUid: varchar('photo_uid').references(() => photo.uid, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
});

export const clientPointOfContact = pgTable('client_point_of_contact', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  name: varchar('name').notNull(),
  designation: varchar('designation').notNull(),
  email: varchar('email').notNull(),
  mobileNumber: varchar('mobileNumber').notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  clientId: uuid('client_id').references(() => client.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
});

export const clientTags = pgTable('client_tags', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  tagId: uuid('tag_id').references(() => tags.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
  clientId: uuid('client_id').references(() => client.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
});

export const companyConfig = pgTable(
  'company_config',
  {
    id: varchar('id').primaryKey().notNull(),
    companyName: varchar('companyName').notNull(),
    companyEmail: varchar('companyEmail').notNull(),
    companyNumber: varchar('companyNumber').notNull(),
    companyWebsite: varchar('companyWebsite').notNull(),
    createdAt: timestamp('created_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    address: uuid('address').references(() => address.id, {
      onDelete: 'set null',
    }),
  },
  (table) => {
    return {
      uq88E788F969E8Ffd4B073C500582: unique(
        'UQ_88e788f969e8ffd4b073c500582',
      ).on(table.companyWebsite),
      rel529Cd72C0Cab514573Aecb7144: unique(
        'REL_529cd72c0cab514573aecb7144',
      ).on(table.address),
    };
  },
);

export const companyPaymentMethod = pgTable('company_payment_method', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  accountName: varchar('accountName').notNull(),
  accountNumber: varchar('accountNumber').notNull(),
  bankName: varchar('bankName').notNull(),
  branchName: varchar('branchName').notNull(),
  swiftCode: varchar('swiftCode').notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  companyId: varchar('company_id').references(() => companyConfig.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
});

export const transferStockProductCopy = pgTable('transfer_stock_product_copy', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  quantity: integer('quantity').notNull(),
  unitPrice: numeric('unitPrice').default('0').notNull(),
  stockValue: numeric('stockValue').default('0').notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  transferStockCopyId: varchar('transfer_stock_copy_id').references(
    () => transferStockCopy.id,
    { onDelete: 'cascade', onUpdate: 'cascade' },
  ),
  productVariantId: uuid('product_variant_id').references(
    () => productVariants.id,
    { onDelete: 'set null', onUpdate: 'cascade' },
  ),
});

export const damage = pgTable('damage', {
  id: varchar('id').primaryKey().notNull(),
  damageDate: timestamp('damageDate', { mode: 'string' }).notNull(),
  damageDetails: varchar('damageDetails').notNull(),
  totalAmount: numeric('totalAmount').default('0').notNull(),
  keywords: varchar('keywords').notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  userId: uuid('User_id').references(() => user.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
  warehouseId: varchar('warehouse_id').references(() => warehouse.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
});

export const damageCopy = pgTable('damage_copy', {
  id: varchar('id').primaryKey().notNull(),
  damageDate: timestamp('damageDate', { mode: 'string' }).notNull(),
  damageDetails: varchar('damageDetails').notNull(),
  totalAmount: numeric('totalAmount').default('0').notNull(),
  keywords: varchar('keywords').notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  userId: uuid('User_id').references(() => user.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
  warehouseId: varchar('warehouse_id').references(() => warehouse.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
});

export const inventoryCopy = pgTable('inventory_copy', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  quantity: integer('quantity').notNull(),
  unitPrice: numeric('unitPrice').default('0').notNull(),
  totalStockValue: numeric('totalStockValue').default('0').notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  productVariantId: uuid('product_variant_id').references(
    () => productVariants.id,
    { onDelete: 'set null', onUpdate: 'cascade' },
  ),
  warehouseId: varchar('warehouse_id').references(() => warehouse.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
});

export const damageExpense = pgTable('damage_expense', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  damageId: varchar('damage_id').references(() => damage.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
  expenseId: varchar('expense_id').references(() => expense.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
});

export const damageProduct = pgTable('damage_product', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  quantity: integer('quantity').notNull(),
  lossAmount: numeric('lossAmount').default('0').notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  damageId: varchar('damage_id').references(() => damage.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
  productId: varchar('product_id').references(() => product.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
});

export const damageProductCopy = pgTable('damage_product_copy', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  quantity: integer('quantity').notNull(),
  lossAmount: numeric('lossAmount').default('0').notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  damageCopyId: varchar('damage_copy_id').references(() => damageCopy.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
  productVariantId: uuid('product_variant_id').references(
    () => productVariants.id,
    { onDelete: 'set null', onUpdate: 'cascade' },
  ),
});

export const erpOptions = pgTable('erp_options', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  attribute: varchar('attribute').notNull(),
  value: varchar('value').notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
});

export const expenseCategory = pgTable('expense_category', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  name: varchar('name', { length: 20 }).notNull(),
  description: varchar('description'),
  keywords: varchar('keywords'),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
});

export const expensePhoto = pgTable('expense_photo', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  expenseId: varchar('expense_id').references(() => expense.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
  photoUid: varchar('photo_uid').references(() => photo.uid, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
});

export const inventory = pgTable('inventory', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  quantity: integer('quantity').notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  productId: varchar('product_id').references(() => product.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
  warehouseId: varchar('warehouse_id').references(() => warehouse.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
  unitPrice: numeric('unitPrice').default('0').notNull(),
  totalStockValue: numeric('totalStockValue').default('0').notNull(),
});

export const inventoryLot = pgTable('inventory_lot', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  lotEntryDate: timestamp('lotEntryDate', { mode: 'string' })
    .defaultNow()
    .notNull(),
  quantity: integer('quantity').notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  productId: varchar('product_id').references(() => product.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
  supplierId: uuid('supplier_id').references(() => supplier.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
  warehouseId: varchar('warehouse_id').references(() => warehouse.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
  unitPrice: numeric('unitPrice').default('0').notNull(),
  subTotal: numeric('subTotal').default('0').notNull(),
});

export const inventoryLotCopy = pgTable('inventory_lot_copy', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  lotEntryDate: timestamp('lotEntryDate', { mode: 'string' })
    .defaultNow()
    .notNull(),
  quantity: integer('quantity').notNull(),
  unitPrice: numeric('unitPrice').default('0').notNull(),
  subTotal: numeric('subTotal').default('0').notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  productVariantId: uuid('product_variant_id').references(
    () => productVariants.id,
    { onDelete: 'set null', onUpdate: 'cascade' },
  ),
  supplierId: uuid('supplier_id').references(() => supplier.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
  warehouseId: varchar('warehouse_id').references(() => warehouse.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
});

export const logging = pgTable('logging', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  requestName: varchar('requestName').notNull(),
  requestType: varchar('requestType').notNull(),
  requestMethod: varchar('requestMethod').notNull(),
  contentLength: integer('contentLength').notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  userId: uuid('user_id').references(() => user.id),
});

export const migrations = pgTable('migrations', {
  id: serial('id').primaryKey().notNull(),
  // You can use { mode: "bigint" } if numbers are exceeding js number limitations
  timestamp: bigint('timestamp', { mode: 'number' }).notNull(),
  name: varchar('name').notNull(),
});

export const product = pgTable(
  'product',
  {
    id: varchar('id').primaryKey().notNull(),
    name: varchar('name').notNull(),
    sku: varchar('sku').notNull(),
    productDetails: varchar('productDetails'),
    keywords: varchar('keywords').notNull(),
    createdAt: timestamp('created_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    avatar: varchar('avatar').references(() => photo.uid, {
      onDelete: 'set null',
    }),
    productTags: varchar('productTags'),
    avgPurchasePrice: numeric('avgPurchasePrice').default('0').notNull(),
    avgSellingPrice: numeric('avgSellingPrice').default('0').notNull(),
  },
  (table) => {
    return {
      uq34F6Ca1Cd897Cc926Bdcca1Ca39: unique(
        'UQ_34f6ca1cd897cc926bdcca1ca39',
      ).on(table.sku),
      rel876D7195B6D5651C21A337661C: unique(
        'REL_876d7195b6d5651c21a337661c',
      ).on(table.avatar),
    };
  },
);

export const productCategory = pgTable('product_category', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  categoryId: uuid('category_id').references(() => category.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
  productId: varchar('product_id').references(() => product.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
});

export const productCopy = pgTable(
  'product_copy',
  {
    id: uuid('id')
      .default(sql`uuid_generate_v4()`)
      .primaryKey()
      .notNull(),
    name: varchar('name').notNull(),
    sku: varchar('sku').notNull(),
    description: varchar('description').notNull(),
    purchasePrice: numeric('purchasePrice').default('0').notNull(),
    sellingPrice: numeric('sellingPrice').default('0').notNull(),
    createdAt: timestamp('created_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    photo: varchar('photo').references(() => photo.uid, {
      onDelete: 'set null',
    }),
    categoryId: uuid('category_id').references(() => category.id, {
      onDelete: 'set null',
      onUpdate: 'cascade',
    }),
    customFields: jsonb('customFields'),
  },
  (table) => {
    return {
      uq00B6D0F625A081Eeafc06D16C17: unique(
        'UQ_00b6d0f625a081eeafc06d16c17',
      ).on(table.sku),
      relF0B8F5C126817E7965A1467390: unique(
        'REL_f0b8f5c126817e7965a1467390',
      ).on(table.photo),
    };
  },
);

export const productTags = pgTable('product_tags', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  tagId: uuid('tag_id').references(() => tags.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
  productId: varchar('product_id').references(() => product.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
});

export const productTagsCopy = pgTable('product_tags_copy', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  tagId: uuid('tag_id').references(() => tags.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
  productId: uuid('product_id').references(() => productCopy.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
});

export const productTemplate = pgTable(
  'product_template',
  {
    id: uuid('id')
      .default(sql`uuid_generate_v4()`)
      .primaryKey()
      .notNull(),
    name: varchar('name').notNull(),
    description: varchar('description'),
    createdAt: timestamp('created_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
  },
  (table) => {
    return {
      uq3C6Edf6A0F66F7647Fafe7989B8: unique(
        'UQ_3c6edf6a0f66f7647fafe7989b8',
      ).on(table.name),
    };
  },
);

export const productTemplateAttribute = pgTable(
  'product_template_attribute',
  {
    id: uuid('id')
      .default(sql`uuid_generate_v4()`)
      .primaryKey()
      .notNull(),
    name: varchar('name').notNull(),
    type: productTemplateAttributeTypeEnum('type').notNull(),
    required: boolean('required').notNull(),
    allowCustomValue: boolean('allowCustomValue').default(false).notNull(),
    options: text('options').array(),
    createdAt: timestamp('created_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    productTemplateId: uuid('product_template_id').references(
      () => productTemplate.id,
      { onDelete: 'cascade', onUpdate: 'cascade' },
    ),
  },
  (table) => {
    return {
      uniqueTemplateAttributeConstraint: unique(
        'Unique_Template_Attribute_Constraint',
      ).on(table.name, table.productTemplateId),
    };
  },
);

export const productType = pgTable(
  'product_type',
  {
    id: uuid('id')
      .default(sql`uuid_generate_v4()`)
      .primaryKey()
      .notNull(),
    createdAt: timestamp('created_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    productId: uuid('product_id').references(() => productCopy.id, {
      onDelete: 'cascade',
      onUpdate: 'cascade',
    }),
    productTemplateId: uuid('product_template_id').references(
      () => productTemplate.id,
      { onDelete: 'cascade', onUpdate: 'cascade' },
    ),
  },
  (table) => {
    return {
      uniqueProductTypeConstraint: unique('Unique_Product_Type_Constraint').on(
        table.productId,
        table.productTemplateId,
      ),
    };
  },
);

export const productVariantAttribute = pgTable(
  'product_variant_attribute',
  {
    id: uuid('id')
      .default(sql`uuid_generate_v4()`)
      .primaryKey()
      .notNull(),
    value: varchar('value'),
    createdAt: timestamp('created_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    productVariantId: uuid('product_variant_id').references(
      () => productVariants.id,
      { onDelete: 'cascade', onUpdate: 'cascade' },
    ),
    productCopyId: uuid('product_copy_id').references(() => productCopy.id, {
      onDelete: 'cascade',
      onUpdate: 'cascade',
    }),
    productTemplateId: uuid('product_template_id').references(
      () => productTemplate.id,
      { onDelete: 'cascade', onUpdate: 'cascade' },
    ),
    productTemplateAttributeId: uuid(
      'product_template_attribute_id',
    ).references(() => productTemplateAttribute.id, {
      onDelete: 'cascade',
      onUpdate: 'cascade',
    }),
  },
  (table) => {
    return {
      uniqueProductVariantAttributeConstraint: unique(
        'Unique_Product_Variant_Attribute_Constraint',
      ).on(table.productVariantId, table.productTemplateAttributeId),
    };
  },
);

export const productVariantTag = pgTable('product_variant_tag', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  tagId: uuid('tag_id').references(() => tags.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
  productVariantId: uuid('product_variant_id').references(
    () => productVariants.id,
    { onDelete: 'cascade', onUpdate: 'cascade' },
  ),
});

export const purchaseExpense = pgTable('purchase_expense', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  purchaseId: varchar('purchase_id').references(() => purchase.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
  expenseId: varchar('expense_id').references(() => expense.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
});

export const purchase = pgTable(
  'purchase',
  {
    id: varchar('id').primaryKey().notNull(),
    purchaseAddress: varchar('purchaseAddress').notNull(),
    purchaseDate: timestamp('purchaseDate', { mode: 'string' }).notNull(),
    purchaseStatus: varchar('purchaseStatus').notNull(),
    subTotal: numeric('subTotal').default('0').notNull(),
    vatAmount: numeric('vatAmount').default('0').notNull(),
    shipmentCost: numeric('shipmentCost').default('0').notNull(),
    discountCost: numeric('discountCost').default('0').notNull(),
    note: varchar('note'),
    keywords: varchar('keywords').notNull(),
    createdAt: timestamp('created_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    supplierId: uuid('supplier_id').references(() => supplier.id, {
      onDelete: 'set null',
      onUpdate: 'cascade',
    }),
    userId: uuid('user_id').references(() => user.id),
    warehouseId: varchar('warehouse_id').references(() => warehouse.id, {
      onDelete: 'set null',
      onUpdate: 'cascade',
    }),
    supplierPocId: uuid('supplier_poc_id').references(
      () => supplierPointOfContact.id,
      { onDelete: 'set null', onUpdate: 'cascade' },
    ),
    totalAmount: numeric('totalAmount').default('0').notNull(),
    transactionId: varchar('transaction_id'),
  },
  (table) => {
    return {
      uq4Bd2C5Fafafe809Ad10E01Cb35B: unique(
        'UQ_4bd2c5fafafe809ad10e01cb35b',
      ).on(table.transactionId),
    };
  },
);

export const purchaseCopy = pgTable(
  'purchase_copy',
  {
    id: varchar('id').primaryKey().notNull(),
    purchaseAddress: varchar('purchaseAddress').notNull(),
    purchaseDate: timestamp('purchaseDate', { mode: 'string' }).notNull(),
    purchaseStatus: varchar('purchaseStatus').notNull(),
    subTotal: numeric('subTotal').default('0').notNull(),
    vatAmount: numeric('vatAmount').default('0').notNull(),
    shipmentCost: numeric('shipmentCost').default('0').notNull(),
    discountCost: numeric('discountCost').default('0').notNull(),
    totalAmount: numeric('totalAmount').default('0').notNull(),
    note: varchar('note'),
    keywords: varchar('keywords').notNull(),
    createdAt: timestamp('created_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    warehouseId: varchar('warehouse_id').references(() => warehouse.id, {
      onDelete: 'set null',
      onUpdate: 'cascade',
    }),
    supplierPocId: uuid('supplier_poc_id').references(
      () => supplierPointOfContact.id,
      { onDelete: 'set null', onUpdate: 'cascade' },
    ),
    supplierId: uuid('supplier_id').references(() => supplier.id, {
      onDelete: 'set null',
      onUpdate: 'cascade',
    }),
    userId: uuid('user_id').references(() => user.id),
    transactionId: varchar('transaction_id'),
  },
  (table) => {
    return {
      uq9B98A6E365C5D8C5928F943D459: unique(
        'UQ_9b98a6e365c5d8c5928f943d459',
      ).on(table.transactionId),
    };
  },
);

export const purchasePaymentAttachment = pgTable(
  'purchase_payment_attachment',
  {
    id: uuid('id')
      .default(sql`uuid_generate_v4()`)
      .primaryKey()
      .notNull(),
    createdAt: timestamp('created_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    purchasePaymentId: varchar('purchase_payment_id').references(
      () => purchasePaymentLogs.id,
      { onDelete: 'cascade', onUpdate: 'cascade' },
    ),
    attachmentUid: varchar('attachment_uid').references(() => photo.uid, {
      onDelete: 'cascade',
      onUpdate: 'cascade',
    }),
  },
);

export const purchasePaymentAttachmentCopy = pgTable(
  'purchase_payment_attachment_copy',
  {
    id: uuid('id')
      .default(sql`uuid_generate_v4()`)
      .primaryKey()
      .notNull(),
    createdAt: timestamp('created_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    purchasePaymentCopyId: varchar('purchase_payment_copy_id').references(
      () => purchasePaymentLogsCopy.id,
      { onDelete: 'cascade', onUpdate: 'cascade' },
    ),
    attachmentUid: varchar('attachment_uid').references(() => photo.uid, {
      onDelete: 'cascade',
      onUpdate: 'cascade',
    }),
  },
);

export const purchasePaymentLogs = pgTable('purchase_payment_logs', {
  id: varchar('id').primaryKey().notNull(),
  paymentType: varchar('paymentType').notNull(),
  paymentDetails: varchar('paymentDetails').notNull(),
  paymentDate: timestamp('paymentDate', { mode: 'string' }).notNull(),
  ledgerPaymentId: varchar('ledgerPaymentId'),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  purchaseId: varchar('purchase_id').references(() => purchase.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
  paymentId: uuid('payment_id').references(() => supplierPaymentMethod.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
  companyBankId: uuid('company_bank_id').references(
    () => companyPaymentMethod.id,
    { onDelete: 'set null', onUpdate: 'cascade' },
  ),
  currentPaidAmount: numeric('currentPaidAmount').default('0').notNull(),
});

export const purchasePaymentLogsCopy = pgTable('purchase_payment_logs_copy', {
  id: varchar('id').primaryKey().notNull(),
  paymentType: varchar('paymentType').notNull(),
  paymentDetails: varchar('paymentDetails').notNull(),
  paymentDate: timestamp('paymentDate', { mode: 'string' }).notNull(),
  currentPaidAmount: numeric('currentPaidAmount').default('0').notNull(),
  ledgerPaymentId: varchar('ledgerPaymentId'),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  purchaseCopyId: varchar('purchase_copy_id').references(
    () => purchaseCopy.id,
    { onDelete: 'cascade', onUpdate: 'cascade' },
  ),
  paymentId: uuid('payment_id').references(() => supplierPaymentMethod.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
  companyBankId: uuid('company_bank_id').references(
    () => companyPaymentMethod.id,
    { onDelete: 'set null', onUpdate: 'cascade' },
  ),
});

export const purchaseProduct = pgTable('purchase_product', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  quantity: integer('quantity').notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  purchaseId: varchar('purchase_id').references(() => purchase.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
  productId: varchar('product_id').references(() => product.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
  unitPrice: numeric('unitPrice').default('0').notNull(),
  subTotal: numeric('subTotal').default('0').notNull(),
});

export const returnExpense = pgTable('return_expense', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  returnId: varchar('return_id').references(() => returnTable.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
  expenseId: varchar('expense_id').references(() => expense.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
});

export const purchaseProductCopy = pgTable('purchase_product_copy', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  quantity: integer('quantity').notNull(),
  unitPrice: numeric('unitPrice').default('0').notNull(),
  subTotal: numeric('subTotal').default('0').notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  purchaseCopyId: varchar('purchase_copy_id').references(
    () => purchaseCopy.id,
    { onDelete: 'cascade', onUpdate: 'cascade' },
  ),
  productVariantId: uuid('product_variant_id').references(
    () => productVariants.id,
    { onDelete: 'set null', onUpdate: 'cascade' },
  ),
});

export const purchaseReceipt = pgTable('purchase_receipt', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  purchaseId: varchar('purchase_id').references(() => purchase.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
  receiptUid: varchar('receipt_uid').references(() => photo.uid, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
});

export const purchaseReceiptCopy = pgTable('purchase_receipt_copy', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  purchaseCopyId: varchar('purchase_copy_id').references(
    () => purchaseCopy.id,
    { onDelete: 'cascade', onUpdate: 'cascade' },
  ),
  receiptUid: varchar('receipt_uid').references(() => photo.uid, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
});

export const returnCopy = pgTable('return_copy', {
  id: varchar('id').primaryKey().notNull(),
  returnDate: timestamp('returnDate', { mode: 'string' }).notNull(),
  returnStatus: varchar('returnStatus').notNull(),
  totalAmount: numeric('totalAmount').default('0').notNull(),
  keywords: varchar('keywords').notNull(),
  note: varchar('note'),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  userId: uuid('user_id').references(() => user.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
  clientId: uuid('client_id').references(() => client.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
  salesCopyId: varchar('sales_copy_id').references(() => salesCopy.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
  warehouseId: varchar('warehouse_id').references(() => warehouse.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
});

export const returnProduct = pgTable(
  'return_product',
  {
    id: uuid('id')
      .default(sql`uuid_generate_v4()`)
      .primaryKey()
      .notNull(),
    lossAmount: numeric('lossAmount').default('0').notNull(),
    returnQuantity: integer('returnQuantity').notNull(),
    subTotal: numeric('subTotal').default('0').notNull(),
    createdAt: timestamp('created_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    returnsId: varchar('returns_id').references(() => returnTable.id, {
      onDelete: 'cascade',
      onUpdate: 'cascade',
    }),
    productId: varchar('product_id').references(() => product.id, {
      onDelete: 'set null',
      onUpdate: 'cascade',
    }),
    salesProductId: uuid('sales_product_id').references(() => salesProduct.id, {
      onDelete: 'set null',
      onUpdate: 'cascade',
    }),
  },
  (table) => {
    return {
      relBa75639Acc552B6E09Bd81148B: unique(
        'REL_ba75639acc552b6e09bd81148b',
      ).on(table.salesProductId),
    };
  },
);

export const returnProductCopy = pgTable(
  'return_product_copy',
  {
    id: uuid('id')
      .default(sql`uuid_generate_v4()`)
      .primaryKey()
      .notNull(),
    lossAmount: numeric('lossAmount').default('0').notNull(),
    returnQuantity: integer('returnQuantity').notNull(),
    subTotal: numeric('subTotal').default('0').notNull(),
    createdAt: timestamp('created_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    returnCopyId: varchar('return_copy_id').references(() => returnCopy.id, {
      onDelete: 'cascade',
      onUpdate: 'cascade',
    }),
    productVariantId: uuid('product_variant_id').references(
      () => productVariants.id,
      { onDelete: 'set null', onUpdate: 'cascade' },
    ),
    salesProductCopyId: uuid('sales_product_copy_id').references(
      () => salesProductCopy.id,
      { onDelete: 'set null', onUpdate: 'cascade' },
    ),
  },
  (table) => {
    return {
      relD9Def54C05F5C5E0Cdf5D86860: unique(
        'REL_d9def54c05f5c5e0cdf5d86860',
      ).on(table.salesProductCopyId),
    };
  },
);

export const sales = pgTable(
  'sales',
  {
    id: varchar('id').primaryKey().notNull(),
    salesDate: timestamp('salesDate', { mode: 'string' }).notNull(),
    salesAddress: varchar('salesAddress').notNull(),
    salesStatus: varchar('salesStatus').notNull(),
    subTotal: numeric('subTotal').default('0').notNull(),
    vatAmount: numeric('vatAmount').default('0').notNull(),
    shipmentCost: numeric('shipmentCost').default('0').notNull(),
    discountCost: numeric('discountCost').default('0').notNull(),
    totalAmount: numeric('totalAmount').default('0').notNull(),
    note: varchar('note'),
    keywords: varchar('keywords').notNull(),
    createdAt: timestamp('created_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    clientId: uuid('client_id').references(() => client.id, {
      onDelete: 'set null',
      onUpdate: 'cascade',
    }),
    userId: uuid('user_id').references(() => user.id),
    warehouseId: varchar('warehouse_id').references(() => warehouse.id, {
      onDelete: 'set null',
      onUpdate: 'cascade',
    }),
    clientPocId: uuid('client_poc_id').references(
      () => clientPointOfContact.id,
      { onDelete: 'set null', onUpdate: 'cascade' },
    ),
    salesCompletedAt: timestamp('salesCompletedAt', {
      withTimezone: true,
      mode: 'string',
    }).defaultNow(),
    transactionId: varchar('transaction_id'),
  },
  (table) => {
    return {
      uq000Ae4A84Cb4F52Cb1Bd99E033E: unique(
        'UQ_000ae4a84cb4f52cb1bd99e033e',
      ).on(table.transactionId),
    };
  },
);

export const salesCopy = pgTable(
  'sales_copy',
  {
    id: varchar('id').primaryKey().notNull(),
    salesDate: timestamp('salesDate', { mode: 'string' }).notNull(),
    salesAddress: varchar('salesAddress').notNull(),
    salesStatus: varchar('salesStatus').notNull(),
    subTotal: numeric('subTotal').default('0').notNull(),
    vatAmount: numeric('vatAmount').default('0').notNull(),
    shipmentCost: numeric('shipmentCost').default('0').notNull(),
    discountCost: numeric('discountCost').default('0').notNull(),
    totalAmount: numeric('totalAmount').default('0').notNull(),
    note: varchar('note'),
    keywords: varchar('keywords').notNull(),
    createdAt: timestamp('created_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    salesCompletedAt: timestamp('salesCompletedAt', {
      withTimezone: true,
      mode: 'string',
    }).defaultNow(),
    clientId: uuid('client_id').references(() => client.id, {
      onDelete: 'set null',
      onUpdate: 'cascade',
    }),
    warehouseId: varchar('warehouse_id').references(() => warehouse.id, {
      onDelete: 'set null',
      onUpdate: 'cascade',
    }),
    clientPocId: uuid('client_poc_id').references(
      () => clientPointOfContact.id,
      { onDelete: 'set null', onUpdate: 'cascade' },
    ),
    userId: uuid('user_id').references(() => user.id),
    transactionId: varchar('transaction_id'),
  },
  (table) => {
    return {
      uq3667A7774127Db2Aa74205D5Fb4: unique(
        'UQ_3667a7774127db2aa74205d5fb4',
      ).on(table.transactionId),
    };
  },
);

export const salesExpense = pgTable('sales_expense', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  salesId: varchar('sales_id').references(() => sales.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
  expenseId: varchar('expense_id').references(() => expense.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
});

export const salesPaymentAttachment = pgTable('sales_payment_attachment', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  salesPaymentId: varchar('sales_payment_id').references(
    () => salesPaymentLogs.id,
    { onDelete: 'cascade', onUpdate: 'cascade' },
  ),
  attachmentUid: varchar('attachment_uid').references(() => photo.uid, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
});

export const salesPaymentLogs = pgTable('sales_payment_logs', {
  id: varchar('id').primaryKey().notNull(),
  paymentType: varchar('paymentType').notNull(),
  paymentDetails: varchar('paymentDetails').notNull(),
  paymentDate: timestamp('paymentDate', { mode: 'string' }).notNull(),
  currentPaidAmount: numeric('currentPaidAmount').default('0').notNull(),
  ledgerPaymentId: varchar('ledgerPaymentId'),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  salesId: varchar('sales_id').references(() => sales.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
  paymentId: uuid('payment_id').references(() => clientPaymentMethod.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
  companyBankId: uuid('company_bank_id').references(
    () => companyPaymentMethod.id,
    { onDelete: 'set null', onUpdate: 'cascade' },
  ),
});

export const salesPaymentLogsCopy = pgTable('sales_payment_logs_copy', {
  id: varchar('id').primaryKey().notNull(),
  paymentType: varchar('paymentType').notNull(),
  paymentDetails: varchar('paymentDetails').notNull(),
  paymentDate: timestamp('paymentDate', { mode: 'string' }).notNull(),
  currentPaidAmount: numeric('currentPaidAmount').default('0').notNull(),
  ledgerPaymentId: varchar('ledgerPaymentId'),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  salesCopyId: varchar('sales_copy_id').references(() => salesCopy.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
  paymentId: uuid('payment_id').references(() => clientPaymentMethod.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
  companyBankId: uuid('company_bank_id').references(
    () => companyPaymentMethod.id,
    { onDelete: 'set null', onUpdate: 'cascade' },
  ),
});

export const supplierPointOfContact = pgTable('supplier_point_of_contact', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  name: varchar('name').notNull(),
  designation: varchar('designation').notNull(),
  email: varchar('email').notNull(),
  mobileNumber: varchar('mobileNumber').notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  supplierId: uuid('supplier_id').references(() => supplier.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
});

export const salesProduct = pgTable('sales_product', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  quantity: integer('quantity').notNull(),
  unitPrice: numeric('unitPrice').default('0').notNull(),
  subTotal: numeric('subTotal').default('0').notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  salesId: varchar('sales_id').references(() => sales.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
  productId: varchar('product_id').references(() => product.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
});

export const salesProductCopy = pgTable('sales_product_copy', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  quantity: integer('quantity').notNull(),
  unitPrice: numeric('unitPrice').default('0').notNull(),
  subTotal: numeric('subTotal').default('0').notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  salesCopyId: varchar('sales_copy_id').references(() => salesCopy.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
  productVariantId: uuid('product_variant_id').references(
    () => productVariants.id,
    { onDelete: 'set null', onUpdate: 'cascade' },
  ),
});

export const supplier = pgTable(
  'supplier',
  {
    id: uuid('id')
      .default(sql`uuid_generate_v4()`)
      .primaryKey()
      .notNull(),
    name: varchar('name').notNull(),
    email: varchar('email').notNull(),
    mobileNumber: varchar('mobileNumber').notNull(),
    keywords: varchar('keywords').notNull(),
    createdAt: timestamp('created_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    deletedAt: timestamp('deleted_at', { mode: 'string' }),
    supplierCode: varchar('supplierCode').notNull(),
    address: uuid('address').references(() => address.id, {
      onDelete: 'set null',
    }),
  },
  (table) => {
    return {
      uq3A549541Ba7Efac006E19197556: unique(
        'UQ_3a549541ba7efac006e19197556',
      ).on(table.supplierCode),
      rel3E592E2A9Dad2E1Ec5Deb50Ffd: unique(
        'REL_3e592e2a9dad2e1ec5deb50ffd',
      ).on(table.address),
    };
  },
);

export const supplierPaymentMethod = pgTable('supplier_payment_method', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  accountName: varchar('accountName').notNull(),
  accountNumber: varchar('accountNumber').notNull(),
  bankName: varchar('bankName').notNull(),
  branchName: varchar('branchName').notNull(),
  swiftCode: varchar('swiftCode').notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  supplierId: uuid('supplier_id').references(() => supplier.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
});

export const supplierPhoto = pgTable('supplier_photo', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  supplierId: uuid('supplier_id').references(() => supplier.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
  photoUid: varchar('photo_uid').references(() => photo.uid, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
});

export const supplierProduct = pgTable('supplier_product', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  productId: varchar('product_id').references(() => product.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
  supplierId: uuid('supplier_id').references(() => supplier.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
});

export const supplierTags = pgTable('supplier_tags', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  tagId: uuid('tag_id').references(() => tags.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
  supplierId: uuid('supplier_id').references(() => supplier.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
});

export const tags = pgTable(
  'tags',
  {
    id: uuid('id')
      .default(sql`uuid_generate_v4()`)
      .primaryKey()
      .notNull(),
    name: varchar('name').notNull(),
    description: varchar('description').notNull(),
    keywords: varchar('keywords'),
    createdAt: timestamp('created_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
  },
  (table) => {
    return {
      uqD90243459A697Eadb8Ad56E9092: unique(
        'UQ_d90243459a697eadb8ad56e9092',
      ).on(table.name),
    };
  },
);

export const typeormMetadata = pgTable('typeorm_metadata', {
  type: varchar('type').notNull(),
  database: varchar('database'),
  schema: varchar('schema'),
  table: varchar('table'),
  name: varchar('name'),
  value: text('value'),
});

export const user = pgTable(
  'user',
  {
    id: uuid('id')
      .default(sql`uuid_generate_v4()`)
      .primaryKey()
      .notNull(),
    name: varchar('name').notNull(),
    email: varchar('email').notNull(),
    mobileNumber: varchar('mobileNumber').notNull(),
    userCode: varchar('userCode').notNull(),
    role: varchar('role').notNull(),
    keywords: varchar('keywords').notNull(),
    createdAt: timestamp('created_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
  },
  (table) => {
    return {
      uq6Bd3B94C05Cc2Bd28326E542279: unique(
        'UQ_6bd3b94c05cc2bd28326e542279',
      ).on(table.userCode),
    };
  },
);

export const userPhoto = pgTable('user_photo', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  userId: uuid('user_id').references(() => user.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
  photoUid: varchar('photo_uid').references(() => photo.uid, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
});

export const warehousePointOfContact = pgTable('warehouse_point_of_contact', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  name: varchar('name').notNull(),
  designation: varchar('designation').notNull(),
  email: varchar('email').notNull(),
  mobileNumber: varchar('mobileNumber').notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  warehouseId: varchar('warehouse_id').references(() => warehouse.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
});

export const photo = pgTable('photo', {
  uid: varchar('uid').primaryKey().notNull(),
  name: varchar('name').notNull(),
  url: varchar('url').notNull(),
  thumbUrl: varchar('thumbUrl').notNull(),
  size: integer('size').notNull(),
  type: varchar('type').notNull(),
  lastModifiedDate: timestamp('lastModifiedDate', { mode: 'string' }).notNull(),
});

export const productVariants = pgTable(
  'product_variants',
  {
    id: uuid('id')
      .default(sql`uuid_generate_v4()`)
      .primaryKey()
      .notNull(),
    sku: varchar('sku').notNull(),
    name: varchar('name').notNull(),
    description: varchar('description'),
    purchasePrice: numeric('purchasePrice').default('0').notNull(),
    sellingPrice: numeric('sellingPrice').default('0').notNull(),
    variantHash: varchar('variant_hash'),
    customFields: jsonb('customFields'),
    createdAt: timestamp('created_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    productCopyId: uuid('product_copy_id').references(() => productCopy.id, {
      onDelete: 'cascade',
      onUpdate: 'cascade',
    }),
    photo: varchar('photo').references(() => photo.uid, {
      onDelete: 'set null',
    }),
    categoryId: uuid('category_id').references(() => category.id, {
      onDelete: 'set null',
      onUpdate: 'cascade',
    }),
  },
  (table) => {
    return {
      uq46F236F21640F9Da218A063A866: unique(
        'UQ_46f236f21640f9da218a063a866',
      ).on(table.sku),
      uqCaaeca24D0754F86E413E8A7274: unique(
        'UQ_caaeca24d0754f86e413e8a7274',
      ).on(table.variantHash),
      rel01F43A98B627Dda4C364564Cf9: unique(
        'REL_01f43a98b627dda4c364564cf9',
      ).on(table.photo),
    };
  },
);

export const returnTable = pgTable('return', {
  id: varchar('id').primaryKey().notNull(),
  returnDate: timestamp('returnDate', { mode: 'string' }).notNull(),
  returnStatus: varchar('returnStatus').notNull(),
  totalAmount: numeric('totalAmount').default('0').notNull(),
  keywords: varchar('keywords').notNull(),
  note: varchar('note'),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  userId: uuid('user_id').references(() => user.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
  clientId: uuid('client_id').references(() => client.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
  salesId: varchar('sales_id').references(() => sales.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
  warehouseId: varchar('warehouse_id').references(() => warehouse.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
});

export const companyConfigPhoto = pgTable('company_config_photo', {
  id: uuid('id')
    .default(sql`uuid_generate_v4()`)
    .primaryKey()
    .notNull(),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  companyId: varchar('company_id').references(() => companyConfig.id, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
  photoUid: varchar('photo_uid').references(() => photo.uid, {
    onDelete: 'cascade',
    onUpdate: 'cascade',
  }),
});

export const warehouse = pgTable(
  'warehouse',
  {
    id: varchar('id').primaryKey().notNull(),
    name: varchar('name').notNull(),
    email: varchar('email').notNull(),
    mobileNumber: varchar('mobileNumber').notNull(),
    warehouseCode: varchar('warehouseCode').notNull(),
    totalStockValue: integer('totalStockValue').default(0).notNull(),
    keywords: varchar('keywords').notNull(),
    createdAt: timestamp('created_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    address: uuid('address').references(() => address.id, {
      onDelete: 'set null',
    }),
  },
  (table) => {
    return {
      uq3647C8D73E51Bbe22Ed642A4D22: unique(
        'UQ_3647c8d73e51bbe22ed642a4d22',
      ).on(table.warehouseCode),
      rel6A259D00Df9829720028E35Ab2: unique(
        'REL_6a259d00df9829720028e35ab2',
      ).on(table.address),
    };
  },
);

export const salesPaymentAttachmentCopy = pgTable(
  'sales_payment_attachment_copy',
  {
    id: uuid('id')
      .default(sql`uuid_generate_v4()`)
      .primaryKey()
      .notNull(),
    createdAt: timestamp('created_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    salesPaymentCopyId: varchar('sales_payment_copy_id').references(
      () => salesPaymentLogsCopy.id,
      { onDelete: 'cascade', onUpdate: 'cascade' },
    ),
    attachmentUid: varchar('attachment_uid').references(() => photo.uid, {
      onDelete: 'set null',
      onUpdate: 'cascade',
    }),
  },
);

export const expense = pgTable('expense', {
  id: varchar('id').primaryKey().notNull(),
  expenseDate: timestamp('expenseDate', { mode: 'string' }).notNull(),
  amount: integer('amount').notNull(),
  note: varchar('note'),
  paymentType: varchar('paymentType').notNull(),
  keywords: varchar('keywords'),
  createdAt: timestamp('created_at', { mode: 'string' }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { mode: 'string' }).defaultNow().notNull(),
  category: uuid('category').references(() => expenseCategory.id, {
    onDelete: 'set null',
    onUpdate: 'cascade',
  }),
  paymentMethod: uuid('paymentMethod').references(
    () => companyPaymentMethod.id,
    { onDelete: 'set null', onUpdate: 'cascade' },
  ),
});

export const productMetaData = pgTable(
  'product_meta_data',
  {
    attribute: varchar('attribute').notNull(),
    value: varchar('value').notNull(),
    createdAt: timestamp('created_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    updatedAt: timestamp('updated_at', { mode: 'string' })
      .defaultNow()
      .notNull(),
    productId: varchar('productId')
      .notNull()
      .references(() => product.id, {
        onDelete: 'cascade',
        onUpdate: 'cascade',
      }),
  },
  (table) => {
    return {
      pk54768Cef3547B51673270E57118: primaryKey({
        columns: [table.attribute, table.productId],
        name: 'PK_54768cef3547b51673270e57118',
      }),
    };
  },
);
