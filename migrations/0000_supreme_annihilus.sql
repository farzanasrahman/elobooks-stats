-- Current sql file was generated after introspecting the database
-- If you want to run this migration please uncomment this code before executing migrations
/*
DO $$ BEGIN
 CREATE TYPE "product_template_attribute_type_enum" AS ENUM('text', 'boolean', 'float', 'dropdown');
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "tenants" (
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"id" varchar PRIMARY KEY NOT NULL,
	"name" varchar NOT NULL,
	"display_name" varchar DEFAULT 'null' NOT NULL,
	"description" varchar DEFAULT 'null' NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "transfer_stock" (
	"id" varchar PRIMARY KEY NOT NULL,
	"keywords" varchar NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"from_warehouse_id" varchar,
	"to_warehouse_id" varchar,
	"user_id" uuid,
	"transferDate" timestamp DEFAULT now() NOT NULL,
	"totalStockValue" numeric DEFAULT '0' NOT NULL,
	"note" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "transfer_stock_copy" (
	"id" varchar PRIMARY KEY NOT NULL,
	"transferDate" timestamp DEFAULT now() NOT NULL,
	"totalStockValue" numeric DEFAULT '0' NOT NULL,
	"note" varchar,
	"keywords" varchar NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"from_warehouse_id" varchar,
	"to_warehouse_id" varchar,
	"user_id" uuid
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "transfer_stock_product" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"quantity" integer NOT NULL,
	"unitPrice" numeric DEFAULT '0' NOT NULL,
	"stockValue" numeric DEFAULT '0' NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"transfer_stock_id" varchar,
	"product_id" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "address" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"street" varchar,
	"area" varchar,
	"city" varchar,
	"country" varchar,
	"zip" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "category" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"name" varchar NOT NULL,
	"description" varchar NOT NULL,
	"keywords" varchar,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "UQ_23c05c292c439d77b0de816b500" UNIQUE("name")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "client" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"name" varchar NOT NULL,
	"email" varchar NOT NULL,
	"mobileNumber" varchar NOT NULL,
	"keywords" varchar NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"deleted_at" timestamp,
	"clientCode" varchar NOT NULL,
	"address" uuid,
	CONSTRAINT "UQ_16172474f6e1b1214ecf7450133" UNIQUE("clientCode"),
	CONSTRAINT "REL_d6a484c4e2de6b5993f68d1b19" UNIQUE("address")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "client_payment_method" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"accountName" varchar NOT NULL,
	"accountNumber" varchar NOT NULL,
	"bankName" varchar NOT NULL,
	"branchName" varchar NOT NULL,
	"swiftCode" varchar NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"client_id" uuid
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "client_photo" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"client_id" uuid,
	"photo_uid" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "client_point_of_contact" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"name" varchar NOT NULL,
	"designation" varchar NOT NULL,
	"email" varchar NOT NULL,
	"mobileNumber" varchar NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"client_id" uuid
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "client_tags" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"tag_id" uuid,
	"client_id" uuid
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "company_config" (
	"id" varchar PRIMARY KEY NOT NULL,
	"companyName" varchar NOT NULL,
	"companyEmail" varchar NOT NULL,
	"companyNumber" varchar NOT NULL,
	"companyWebsite" varchar NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"address" uuid,
	CONSTRAINT "UQ_88e788f969e8ffd4b073c500582" UNIQUE("companyWebsite"),
	CONSTRAINT "REL_529cd72c0cab514573aecb7144" UNIQUE("address")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "company_payment_method" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"accountName" varchar NOT NULL,
	"accountNumber" varchar NOT NULL,
	"bankName" varchar NOT NULL,
	"branchName" varchar NOT NULL,
	"swiftCode" varchar NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"company_id" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "transfer_stock_product_copy" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"quantity" integer NOT NULL,
	"unitPrice" numeric DEFAULT '0' NOT NULL,
	"stockValue" numeric DEFAULT '0' NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"transfer_stock_copy_id" varchar,
	"product_variant_id" uuid
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "damage" (
	"id" varchar PRIMARY KEY NOT NULL,
	"damageDate" timestamp NOT NULL,
	"damageDetails" varchar NOT NULL,
	"totalAmount" numeric DEFAULT 0 NOT NULL,
	"keywords" varchar NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"User_id" uuid,
	"warehouse_id" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "damage_copy" (
	"id" varchar PRIMARY KEY NOT NULL,
	"damageDate" timestamp NOT NULL,
	"damageDetails" varchar NOT NULL,
	"totalAmount" numeric DEFAULT '0' NOT NULL,
	"keywords" varchar NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"User_id" uuid,
	"warehouse_id" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "inventory_copy" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"quantity" integer NOT NULL,
	"unitPrice" numeric DEFAULT '0' NOT NULL,
	"totalStockValue" numeric DEFAULT '0' NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"product_variant_id" uuid,
	"warehouse_id" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "damage_expense" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"damage_id" varchar,
	"expense_id" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "damage_product" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"quantity" integer NOT NULL,
	"lossAmount" numeric DEFAULT 0 NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"damage_id" varchar,
	"product_id" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "damage_product_copy" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"quantity" integer NOT NULL,
	"lossAmount" numeric DEFAULT '0' NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"damage_copy_id" varchar,
	"product_variant_id" uuid
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "erp_options" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"attribute" varchar NOT NULL,
	"value" varchar NOT NULL,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "expense_category" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"name" varchar(20) NOT NULL,
	"description" varchar,
	"keywords" varchar,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "expense_photo" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"expense_id" varchar,
	"photo_uid" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "inventory" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"quantity" integer NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"product_id" varchar,
	"warehouse_id" varchar,
	"unitPrice" numeric DEFAULT 0 NOT NULL,
	"totalStockValue" numeric DEFAULT 0 NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "inventory_lot" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"lotEntryDate" timestamp DEFAULT now() NOT NULL,
	"quantity" integer NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"product_id" varchar,
	"supplier_id" uuid,
	"warehouse_id" varchar,
	"unitPrice" numeric DEFAULT 0 NOT NULL,
	"subTotal" numeric DEFAULT 0 NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "inventory_lot_copy" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"lotEntryDate" timestamp DEFAULT now() NOT NULL,
	"quantity" integer NOT NULL,
	"unitPrice" numeric DEFAULT '0' NOT NULL,
	"subTotal" numeric DEFAULT '0' NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"product_variant_id" uuid,
	"supplier_id" uuid,
	"warehouse_id" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "logging" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"requestName" varchar NOT NULL,
	"requestType" varchar NOT NULL,
	"requestMethod" varchar NOT NULL,
	"contentLength" integer NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"user_id" uuid
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "migrations" (
	"id" serial PRIMARY KEY NOT NULL,
	"timestamp" bigint NOT NULL,
	"name" varchar NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "product" (
	"id" varchar PRIMARY KEY NOT NULL,
	"name" varchar NOT NULL,
	"sku" varchar NOT NULL,
	"productDetails" varchar,
	"keywords" varchar NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"avatar" varchar,
	"productTags" varchar,
	"avgPurchasePrice" numeric DEFAULT 0 NOT NULL,
	"avgSellingPrice" numeric DEFAULT 0 NOT NULL,
	CONSTRAINT "UQ_34f6ca1cd897cc926bdcca1ca39" UNIQUE("sku"),
	CONSTRAINT "REL_876d7195b6d5651c21a337661c" UNIQUE("avatar")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "product_category" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"category_id" uuid,
	"product_id" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "product_copy" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"name" varchar NOT NULL,
	"sku" varchar NOT NULL,
	"description" varchar NOT NULL,
	"purchasePrice" numeric DEFAULT '0' NOT NULL,
	"sellingPrice" numeric DEFAULT '0' NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"photo" varchar,
	"category_id" uuid,
	"customFields" jsonb,
	CONSTRAINT "UQ_00b6d0f625a081eeafc06d16c17" UNIQUE("sku"),
	CONSTRAINT "REL_f0b8f5c126817e7965a1467390" UNIQUE("photo")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "product_tags" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"tag_id" uuid,
	"product_id" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "product_tags_copy" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"tag_id" uuid,
	"product_id" uuid
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "product_template" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"name" varchar NOT NULL,
	"description" varchar,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "UQ_3c6edf6a0f66f7647fafe7989b8" UNIQUE("name")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "product_template_attribute" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"name" varchar NOT NULL,
	"type" "product_template_attribute_type_enum" NOT NULL,
	"required" boolean NOT NULL,
	"allowCustomValue" boolean DEFAULT false NOT NULL,
	"options" text[],
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"product_template_id" uuid,
	CONSTRAINT "Unique_Template_Attribute_Constraint" UNIQUE("name","product_template_id")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "product_type" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"product_id" uuid,
	"product_template_id" uuid,
	CONSTRAINT "Unique_Product_Type_Constraint" UNIQUE("product_id","product_template_id")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "product_variant_attribute" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"value" varchar,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"product_variant_id" uuid,
	"product_copy_id" uuid,
	"product_template_id" uuid,
	"product_template_attribute_id" uuid,
	CONSTRAINT "Unique_Product_Variant_Attribute_Constraint" UNIQUE("product_variant_id","product_template_attribute_id")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "product_variant_tag" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"tag_id" uuid,
	"product_variant_id" uuid
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "purchase_expense" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"purchase_id" varchar,
	"expense_id" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "purchase" (
	"id" varchar PRIMARY KEY NOT NULL,
	"purchaseAddress" varchar NOT NULL,
	"purchaseDate" timestamp NOT NULL,
	"purchaseStatus" varchar NOT NULL,
	"subTotal" numeric DEFAULT '0' NOT NULL,
	"vatAmount" numeric DEFAULT '0' NOT NULL,
	"shipmentCost" numeric DEFAULT '0' NOT NULL,
	"discountCost" numeric DEFAULT '0' NOT NULL,
	"note" varchar,
	"keywords" varchar NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"supplier_id" uuid,
	"user_id" uuid,
	"warehouse_id" varchar,
	"supplier_poc_id" uuid,
	"totalAmount" numeric DEFAULT 0 NOT NULL,
	"transaction_id" varchar,
	CONSTRAINT "UQ_4bd2c5fafafe809ad10e01cb35b" UNIQUE("transaction_id")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "purchase_copy" (
	"id" varchar PRIMARY KEY NOT NULL,
	"purchaseAddress" varchar NOT NULL,
	"purchaseDate" timestamp NOT NULL,
	"purchaseStatus" varchar NOT NULL,
	"subTotal" numeric DEFAULT '0' NOT NULL,
	"vatAmount" numeric DEFAULT '0' NOT NULL,
	"shipmentCost" numeric DEFAULT '0' NOT NULL,
	"discountCost" numeric DEFAULT '0' NOT NULL,
	"totalAmount" numeric DEFAULT '0' NOT NULL,
	"note" varchar,
	"keywords" varchar NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"warehouse_id" varchar,
	"supplier_poc_id" uuid,
	"supplier_id" uuid,
	"user_id" uuid,
	"transaction_id" varchar,
	CONSTRAINT "UQ_9b98a6e365c5d8c5928f943d459" UNIQUE("transaction_id")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "purchase_payment_attachment" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"purchase_payment_id" varchar,
	"attachment_uid" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "purchase_payment_attachment_copy" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"purchase_payment_copy_id" varchar,
	"attachment_uid" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "purchase_payment_logs" (
	"id" varchar PRIMARY KEY NOT NULL,
	"paymentType" varchar NOT NULL,
	"paymentDetails" varchar NOT NULL,
	"paymentDate" timestamp NOT NULL,
	"ledgerPaymentId" varchar,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"purchase_id" varchar,
	"payment_id" uuid,
	"company_bank_id" uuid,
	"currentPaidAmount" numeric DEFAULT 0 NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "purchase_payment_logs_copy" (
	"id" varchar PRIMARY KEY NOT NULL,
	"paymentType" varchar NOT NULL,
	"paymentDetails" varchar NOT NULL,
	"paymentDate" timestamp NOT NULL,
	"currentPaidAmount" numeric DEFAULT '0' NOT NULL,
	"ledgerPaymentId" varchar,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"purchase_copy_id" varchar,
	"payment_id" uuid,
	"company_bank_id" uuid
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "purchase_product" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"quantity" integer NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"purchase_id" varchar,
	"product_id" varchar,
	"unitPrice" numeric DEFAULT 0 NOT NULL,
	"subTotal" numeric DEFAULT 0 NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "return_expense" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"return_id" varchar,
	"expense_id" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "purchase_product_copy" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"quantity" integer NOT NULL,
	"unitPrice" numeric DEFAULT '0' NOT NULL,
	"subTotal" numeric DEFAULT '0' NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"purchase_copy_id" varchar,
	"product_variant_id" uuid
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "purchase_receipt" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"purchase_id" varchar,
	"receipt_uid" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "purchase_receipt_copy" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"purchase_copy_id" varchar,
	"receipt_uid" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "return_copy" (
	"id" varchar PRIMARY KEY NOT NULL,
	"returnDate" timestamp NOT NULL,
	"returnStatus" varchar NOT NULL,
	"totalAmount" numeric DEFAULT '0' NOT NULL,
	"keywords" varchar NOT NULL,
	"note" varchar,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"user_id" uuid,
	"client_id" uuid,
	"sales_copy_id" varchar,
	"warehouse_id" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "return_product" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"lossAmount" numeric DEFAULT 0 NOT NULL,
	"returnQuantity" integer NOT NULL,
	"subTotal" numeric DEFAULT 0 NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"returns_id" varchar,
	"product_id" varchar,
	"sales_product_id" uuid,
	CONSTRAINT "REL_ba75639acc552b6e09bd81148b" UNIQUE("sales_product_id")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "return_product_copy" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"lossAmount" numeric DEFAULT '0' NOT NULL,
	"returnQuantity" integer NOT NULL,
	"subTotal" numeric DEFAULT '0' NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"return_copy_id" varchar,
	"product_variant_id" uuid,
	"sales_product_copy_id" uuid,
	CONSTRAINT "REL_d9def54c05f5c5e0cdf5d86860" UNIQUE("sales_product_copy_id")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "sales" (
	"id" varchar PRIMARY KEY NOT NULL,
	"salesDate" timestamp NOT NULL,
	"salesAddress" varchar NOT NULL,
	"salesStatus" varchar NOT NULL,
	"subTotal" numeric DEFAULT '0' NOT NULL,
	"vatAmount" numeric DEFAULT '0' NOT NULL,
	"shipmentCost" numeric DEFAULT '0' NOT NULL,
	"discountCost" numeric DEFAULT '0' NOT NULL,
	"totalAmount" numeric DEFAULT 0 NOT NULL,
	"note" varchar,
	"keywords" varchar NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"client_id" uuid,
	"user_id" uuid,
	"warehouse_id" varchar,
	"client_poc_id" uuid,
	"salesCompletedAt" timestamp with time zone DEFAULT '2023-12-15 22:36:40.491697'::timestamp without time zone,
	"transaction_id" varchar,
	CONSTRAINT "UQ_000ae4a84cb4f52cb1bd99e033e" UNIQUE("transaction_id")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "sales_copy" (
	"id" varchar PRIMARY KEY NOT NULL,
	"salesDate" timestamp NOT NULL,
	"salesAddress" varchar NOT NULL,
	"salesStatus" varchar NOT NULL,
	"subTotal" numeric DEFAULT '0' NOT NULL,
	"vatAmount" numeric DEFAULT '0' NOT NULL,
	"shipmentCost" numeric DEFAULT '0' NOT NULL,
	"discountCost" numeric DEFAULT '0' NOT NULL,
	"totalAmount" numeric DEFAULT '0' NOT NULL,
	"note" varchar,
	"keywords" varchar NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"salesCompletedAt" timestamp with time zone DEFAULT now(),
	"client_id" uuid,
	"warehouse_id" varchar,
	"client_poc_id" uuid,
	"user_id" uuid,
	"transaction_id" varchar,
	CONSTRAINT "UQ_3667a7774127db2aa74205d5fb4" UNIQUE("transaction_id")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "sales_expense" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"sales_id" varchar,
	"expense_id" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "sales_payment_attachment" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"sales_payment_id" varchar,
	"attachment_uid" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "sales_payment_logs" (
	"id" varchar PRIMARY KEY NOT NULL,
	"paymentType" varchar NOT NULL,
	"paymentDetails" varchar NOT NULL,
	"paymentDate" timestamp NOT NULL,
	"currentPaidAmount" numeric DEFAULT 0 NOT NULL,
	"ledgerPaymentId" varchar,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"sales_id" varchar,
	"payment_id" uuid,
	"company_bank_id" uuid
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "sales_payment_logs_copy" (
	"id" varchar PRIMARY KEY NOT NULL,
	"paymentType" varchar NOT NULL,
	"paymentDetails" varchar NOT NULL,
	"paymentDate" timestamp NOT NULL,
	"currentPaidAmount" numeric DEFAULT '0' NOT NULL,
	"ledgerPaymentId" varchar,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"sales_copy_id" varchar,
	"payment_id" uuid,
	"company_bank_id" uuid
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "supplier_point_of_contact" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"name" varchar NOT NULL,
	"designation" varchar NOT NULL,
	"email" varchar NOT NULL,
	"mobileNumber" varchar NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"supplier_id" uuid
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "sales_product" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"quantity" integer NOT NULL,
	"unitPrice" numeric DEFAULT 0 NOT NULL,
	"subTotal" numeric DEFAULT 0 NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"sales_id" varchar,
	"product_id" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "sales_product_copy" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"quantity" integer NOT NULL,
	"unitPrice" numeric DEFAULT '0' NOT NULL,
	"subTotal" numeric DEFAULT '0' NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"sales_copy_id" varchar,
	"product_variant_id" uuid
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "supplier" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"name" varchar NOT NULL,
	"email" varchar NOT NULL,
	"mobileNumber" varchar NOT NULL,
	"keywords" varchar NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"deleted_at" timestamp,
	"supplierCode" varchar NOT NULL,
	"address" uuid,
	CONSTRAINT "UQ_3a549541ba7efac006e19197556" UNIQUE("supplierCode"),
	CONSTRAINT "REL_3e592e2a9dad2e1ec5deb50ffd" UNIQUE("address")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "supplier_payment_method" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"accountName" varchar NOT NULL,
	"accountNumber" varchar NOT NULL,
	"bankName" varchar NOT NULL,
	"branchName" varchar NOT NULL,
	"swiftCode" varchar NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"supplier_id" uuid
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "supplier_photo" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"supplier_id" uuid,
	"photo_uid" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "supplier_product" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"product_id" varchar,
	"supplier_id" uuid
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "supplier_tags" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"tag_id" uuid,
	"supplier_id" uuid
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "tags" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"name" varchar NOT NULL,
	"description" varchar NOT NULL,
	"keywords" varchar,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "UQ_d90243459a697eadb8ad56e9092" UNIQUE("name")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "typeorm_metadata" (
	"type" varchar NOT NULL,
	"database" varchar,
	"schema" varchar,
	"table" varchar,
	"name" varchar,
	"value" text
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "user" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"name" varchar NOT NULL,
	"email" varchar NOT NULL,
	"mobileNumber" varchar NOT NULL,
	"userCode" varchar NOT NULL,
	"role" varchar NOT NULL,
	"keywords" varchar NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	CONSTRAINT "UQ_6bd3b94c05cc2bd28326e542279" UNIQUE("userCode")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "user_photo" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"user_id" uuid,
	"photo_uid" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "warehouse_point_of_contact" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"name" varchar NOT NULL,
	"designation" varchar NOT NULL,
	"email" varchar NOT NULL,
	"mobileNumber" varchar NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"warehouse_id" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "photo" (
	"uid" varchar PRIMARY KEY NOT NULL,
	"name" varchar NOT NULL,
	"url" varchar NOT NULL,
	"thumbUrl" varchar NOT NULL,
	"size" integer NOT NULL,
	"type" varchar NOT NULL,
	"lastModifiedDate" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "product_variants" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"sku" varchar NOT NULL,
	"name" varchar NOT NULL,
	"description" varchar,
	"purchasePrice" numeric DEFAULT '0' NOT NULL,
	"sellingPrice" numeric DEFAULT '0' NOT NULL,
	"variant_hash" varchar,
	"customFields" jsonb,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"product_copy_id" uuid,
	"photo" varchar,
	"category_id" uuid,
	CONSTRAINT "UQ_46f236f21640f9da218a063a866" UNIQUE("sku"),
	CONSTRAINT "UQ_caaeca24d0754f86e413e8a7274" UNIQUE("variant_hash"),
	CONSTRAINT "REL_01f43a98b627dda4c364564cf9" UNIQUE("photo")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "return" (
	"id" varchar PRIMARY KEY NOT NULL,
	"returnDate" timestamp NOT NULL,
	"returnStatus" varchar NOT NULL,
	"totalAmount" numeric DEFAULT 0 NOT NULL,
	"keywords" varchar NOT NULL,
	"note" varchar,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"user_id" uuid,
	"client_id" uuid,
	"sales_id" varchar,
	"warehouse_id" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "company_config_photo" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"company_id" varchar,
	"photo_uid" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "warehouse" (
	"id" varchar PRIMARY KEY NOT NULL,
	"name" varchar NOT NULL,
	"email" varchar NOT NULL,
	"mobileNumber" varchar NOT NULL,
	"warehouseCode" varchar NOT NULL,
	"totalStockValue" integer DEFAULT 0 NOT NULL,
	"keywords" varchar NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"address" uuid,
	CONSTRAINT "UQ_3647c8d73e51bbe22ed642a4d22" UNIQUE("warehouseCode"),
	CONSTRAINT "REL_6a259d00df9829720028e35ab2" UNIQUE("address")
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "sales_payment_attachment_copy" (
	"id" uuid PRIMARY KEY DEFAULT uuid_generate_v4() NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"sales_payment_copy_id" varchar,
	"attachment_uid" varchar
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "expense" (
	"id" varchar PRIMARY KEY NOT NULL,
	"expenseDate" timestamp NOT NULL,
	"amount" integer NOT NULL,
	"note" varchar,
	"paymentType" varchar NOT NULL,
	"keywords" varchar,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"category" uuid,
	"paymentMethod" uuid
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "product_meta_data" (
	"attribute" varchar NOT NULL,
	"value" varchar NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL,
	"productId" varchar NOT NULL,
	CONSTRAINT "PK_54768cef3547b51673270e57118" PRIMARY KEY("attribute","productId")
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "transfer_stock" ADD CONSTRAINT "FK_25f498f37708e4444159b8a0bd2" FOREIGN KEY ("from_warehouse_id") REFERENCES "public"."warehouse"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "transfer_stock" ADD CONSTRAINT "FK_ba0b84eb08a0ed1b44bd9e25de4" FOREIGN KEY ("to_warehouse_id") REFERENCES "public"."warehouse"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "transfer_stock" ADD CONSTRAINT "FK_d9c6541444768c85c6466bf57b4" FOREIGN KEY ("user_id") REFERENCES "public"."user"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "transfer_stock_copy" ADD CONSTRAINT "FK_0ff9ff2ec832ec5cfc452e910e2" FOREIGN KEY ("to_warehouse_id") REFERENCES "public"."warehouse"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "transfer_stock_copy" ADD CONSTRAINT "FK_19af582e6e9c584a5c19894fbeb" FOREIGN KEY ("user_id") REFERENCES "public"."user"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "transfer_stock_copy" ADD CONSTRAINT "FK_7ad077c42e615f40bc510bd0639" FOREIGN KEY ("from_warehouse_id") REFERENCES "public"."warehouse"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "transfer_stock_product" ADD CONSTRAINT "FK_61ec451a7c58c7e1a20d14f0778" FOREIGN KEY ("product_id") REFERENCES "public"."product"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "transfer_stock_product" ADD CONSTRAINT "FK_c3f203a3cff3af7946556c81436" FOREIGN KEY ("transfer_stock_id") REFERENCES "public"."transfer_stock"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "client" ADD CONSTRAINT "FK_d6a484c4e2de6b5993f68d1b198" FOREIGN KEY ("address") REFERENCES "public"."address"("id") ON DELETE set null ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "client_payment_method" ADD CONSTRAINT "FK_52cbe2b6bbcaea36df3479bd758" FOREIGN KEY ("client_id") REFERENCES "public"."client"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "client_photo" ADD CONSTRAINT "FK_a85498f96ba0f1d542f851dedb2" FOREIGN KEY ("photo_uid") REFERENCES "public"."photo"("uid") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "client_photo" ADD CONSTRAINT "FK_b477c5feca225aa955f39d18bb5" FOREIGN KEY ("client_id") REFERENCES "public"."client"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "client_point_of_contact" ADD CONSTRAINT "FK_ecb270b2b823bc1756b2f3d1b53" FOREIGN KEY ("client_id") REFERENCES "public"."client"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "client_tags" ADD CONSTRAINT "FK_32e80c0dae4fc149b834efd79a9" FOREIGN KEY ("client_id") REFERENCES "public"."client"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "client_tags" ADD CONSTRAINT "FK_9d9bfa856d131515eade0a58b73" FOREIGN KEY ("tag_id") REFERENCES "public"."tags"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "company_config" ADD CONSTRAINT "FK_529cd72c0cab514573aecb71446" FOREIGN KEY ("address") REFERENCES "public"."address"("id") ON DELETE set null ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "company_payment_method" ADD CONSTRAINT "FK_f57bc28f5e951c65046cfd41dbe" FOREIGN KEY ("company_id") REFERENCES "public"."company_config"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "transfer_stock_product_copy" ADD CONSTRAINT "FK_7a23d0deffab4d9fce8f2a6f092" FOREIGN KEY ("product_variant_id") REFERENCES "public"."product_variants"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "transfer_stock_product_copy" ADD CONSTRAINT "FK_dca9edb292a9dfae0e6ab5dbf03" FOREIGN KEY ("transfer_stock_copy_id") REFERENCES "public"."transfer_stock_copy"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "damage" ADD CONSTRAINT "FK_38b835afda2db81df59cbd271d5" FOREIGN KEY ("User_id") REFERENCES "public"."user"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "damage" ADD CONSTRAINT "FK_41262f4201c698cb90eb91bceee" FOREIGN KEY ("warehouse_id") REFERENCES "public"."warehouse"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "damage_copy" ADD CONSTRAINT "FK_3303583d2a215c35c27dc5966a7" FOREIGN KEY ("warehouse_id") REFERENCES "public"."warehouse"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "damage_copy" ADD CONSTRAINT "FK_d68fba31dabc56e681c309278d7" FOREIGN KEY ("User_id") REFERENCES "public"."user"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "inventory_copy" ADD CONSTRAINT "FK_591ea9af2ef69fb0fd3ab72eac9" FOREIGN KEY ("product_variant_id") REFERENCES "public"."product_variants"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "inventory_copy" ADD CONSTRAINT "FK_f65b50d73fc119883e8e39283a8" FOREIGN KEY ("warehouse_id") REFERENCES "public"."warehouse"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "damage_expense" ADD CONSTRAINT "FK_9d7ef850a8b4f0ee7b6a87576bb" FOREIGN KEY ("damage_id") REFERENCES "public"."damage"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "damage_expense" ADD CONSTRAINT "FK_b7718e1e4071f3e2f87e1ca6fbb" FOREIGN KEY ("expense_id") REFERENCES "public"."expense"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "damage_product" ADD CONSTRAINT "FK_3bfb48b9da5995242e240bb929c" FOREIGN KEY ("product_id") REFERENCES "public"."product"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "damage_product" ADD CONSTRAINT "FK_85e3c48a5a56726160ea8b14d7a" FOREIGN KEY ("damage_id") REFERENCES "public"."damage"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "damage_product_copy" ADD CONSTRAINT "FK_2a0f7386e0bb340e57023650d77" FOREIGN KEY ("product_variant_id") REFERENCES "public"."product_variants"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "damage_product_copy" ADD CONSTRAINT "FK_cea4bbb57bfeaf36e8d88f83f2c" FOREIGN KEY ("damage_copy_id") REFERENCES "public"."damage_copy"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "expense_photo" ADD CONSTRAINT "FK_ae58c89b209d599c6711b0768f1" FOREIGN KEY ("expense_id") REFERENCES "public"."expense"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "expense_photo" ADD CONSTRAINT "FK_fe6d1bdff68daccb753b1929d8f" FOREIGN KEY ("photo_uid") REFERENCES "public"."photo"("uid") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "inventory" ADD CONSTRAINT "FK_5d9d73a4c5fe0202714a51e4649" FOREIGN KEY ("warehouse_id") REFERENCES "public"."warehouse"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "inventory" ADD CONSTRAINT "FK_732fdb1f76432d65d2c136340dc" FOREIGN KEY ("product_id") REFERENCES "public"."product"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "inventory_lot" ADD CONSTRAINT "FK_8549439bece29c27b54fa24d2a3" FOREIGN KEY ("product_id") REFERENCES "public"."product"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "inventory_lot" ADD CONSTRAINT "FK_902bcfc01f7e94bd6871a572525" FOREIGN KEY ("warehouse_id") REFERENCES "public"."warehouse"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "inventory_lot" ADD CONSTRAINT "FK_93ff452ff4ed985cbd6dc73ee80" FOREIGN KEY ("supplier_id") REFERENCES "public"."supplier"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "inventory_lot_copy" ADD CONSTRAINT "FK_5daf362f85c53454727c7db0898" FOREIGN KEY ("product_variant_id") REFERENCES "public"."product_variants"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "inventory_lot_copy" ADD CONSTRAINT "FK_639058ec5eb71f9f130f3f65a93" FOREIGN KEY ("warehouse_id") REFERENCES "public"."warehouse"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "inventory_lot_copy" ADD CONSTRAINT "FK_ea71b18bc79d904f2f221fe5a80" FOREIGN KEY ("supplier_id") REFERENCES "public"."supplier"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "logging" ADD CONSTRAINT "FK_68374361bd8c1487bdf4312ddaa" FOREIGN KEY ("user_id") REFERENCES "public"."user"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "product" ADD CONSTRAINT "FK_876d7195b6d5651c21a337661ca" FOREIGN KEY ("avatar") REFERENCES "public"."photo"("uid") ON DELETE set null ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "product_category" ADD CONSTRAINT "FK_0374879a971928bc3f57eed0a59" FOREIGN KEY ("product_id") REFERENCES "public"."product"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "product_category" ADD CONSTRAINT "FK_2df1f83329c00e6eadde0493e16" FOREIGN KEY ("category_id") REFERENCES "public"."category"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "product_copy" ADD CONSTRAINT "FK_9f7c9a4c4c3cb906fc1367a18b7" FOREIGN KEY ("category_id") REFERENCES "public"."category"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "product_copy" ADD CONSTRAINT "FK_f0b8f5c126817e7965a14673901" FOREIGN KEY ("photo") REFERENCES "public"."photo"("uid") ON DELETE set null ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "product_tags" ADD CONSTRAINT "FK_5b0c6fc53c574299ecc7f9ee22e" FOREIGN KEY ("product_id") REFERENCES "public"."product"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "product_tags" ADD CONSTRAINT "FK_f2cd3faf2e129a4c69c05a291e8" FOREIGN KEY ("tag_id") REFERENCES "public"."tags"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "product_tags_copy" ADD CONSTRAINT "FK_75b7eb79b6e19138cee206e13e5" FOREIGN KEY ("tag_id") REFERENCES "public"."tags"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "product_tags_copy" ADD CONSTRAINT "FK_8f1f192c7f249209412d433735a" FOREIGN KEY ("product_id") REFERENCES "public"."product_copy"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "product_template_attribute" ADD CONSTRAINT "FK_38a4e7a29cf8288572406d6732c" FOREIGN KEY ("product_template_id") REFERENCES "public"."product_template"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "product_type" ADD CONSTRAINT "FK_c26c323511ccdfe972f75d25ee3" FOREIGN KEY ("product_template_id") REFERENCES "public"."product_template"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "product_type" ADD CONSTRAINT "FK_f75f0e1005c80ab9ae7d9c8ea68" FOREIGN KEY ("product_id") REFERENCES "public"."product_copy"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "product_variant_attribute" ADD CONSTRAINT "FK_6b7872da324fe00beb5e44d6bf9" FOREIGN KEY ("product_copy_id") REFERENCES "public"."product_copy"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "product_variant_attribute" ADD CONSTRAINT "FK_a9c8f8ba9bd11b5849b3f481c6c" FOREIGN KEY ("product_variant_id") REFERENCES "public"."product_variants"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "product_variant_attribute" ADD CONSTRAINT "FK_af39b10860e6676e1c5249d4bf6" FOREIGN KEY ("product_template_id") REFERENCES "public"."product_template"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "product_variant_attribute" ADD CONSTRAINT "FK_d946273dd23de944721efe52913" FOREIGN KEY ("product_template_attribute_id") REFERENCES "public"."product_template_attribute"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "product_variant_tag" ADD CONSTRAINT "FK_492137456ac3cf12e69dec756dd" FOREIGN KEY ("product_variant_id") REFERENCES "public"."product_variants"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "product_variant_tag" ADD CONSTRAINT "FK_e0ba37c03deea7279ecd852a8b2" FOREIGN KEY ("tag_id") REFERENCES "public"."tags"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_expense" ADD CONSTRAINT "FK_fbbbee91e8f4333f34f47615edf" FOREIGN KEY ("purchase_id") REFERENCES "public"."purchase"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_expense" ADD CONSTRAINT "FK_fd39af24995da2e5c39fea758f5" FOREIGN KEY ("expense_id") REFERENCES "public"."expense"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase" ADD CONSTRAINT "FK_63ca6eb85a88b1b5533d3940543" FOREIGN KEY ("supplier_poc_id") REFERENCES "public"."supplier_point_of_contact"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase" ADD CONSTRAINT "FK_70cde4590fe02609fe19d3d7cce" FOREIGN KEY ("warehouse_id") REFERENCES "public"."warehouse"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase" ADD CONSTRAINT "FK_8d9a856657c46725d085c73e4fc" FOREIGN KEY ("supplier_id") REFERENCES "public"."supplier"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase" ADD CONSTRAINT "FK_c4f9e58ae516d88361b37ed9532" FOREIGN KEY ("user_id") REFERENCES "public"."user"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_copy" ADD CONSTRAINT "FK_0cdf411a286eaab6d4114c8c951" FOREIGN KEY ("warehouse_id") REFERENCES "public"."warehouse"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_copy" ADD CONSTRAINT "FK_ce7c766547016221dee1a597dfb" FOREIGN KEY ("user_id") REFERENCES "public"."user"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_copy" ADD CONSTRAINT "FK_e7f1f9293416472113ac9c78cf1" FOREIGN KEY ("supplier_id") REFERENCES "public"."supplier"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_copy" ADD CONSTRAINT "FK_e8f3b192f996f10ecb9386c2fea" FOREIGN KEY ("supplier_poc_id") REFERENCES "public"."supplier_point_of_contact"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_payment_attachment" ADD CONSTRAINT "FK_38685d951d9edfe9fc0c241d5ca" FOREIGN KEY ("attachment_uid") REFERENCES "public"."photo"("uid") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_payment_attachment" ADD CONSTRAINT "FK_4e81573e17ec0af17443ad6fd2d" FOREIGN KEY ("purchase_payment_id") REFERENCES "public"."purchase_payment_logs"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_payment_attachment_copy" ADD CONSTRAINT "FK_3e75ac1d3646a39877c8ea12666" FOREIGN KEY ("attachment_uid") REFERENCES "public"."photo"("uid") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_payment_attachment_copy" ADD CONSTRAINT "FK_f75042fefa4983e6a2f8d13da0c" FOREIGN KEY ("purchase_payment_copy_id") REFERENCES "public"."purchase_payment_logs_copy"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_payment_logs" ADD CONSTRAINT "FK_1c321c7e89c994d2aa000f3bdc7" FOREIGN KEY ("payment_id") REFERENCES "public"."supplier_payment_method"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_payment_logs" ADD CONSTRAINT "FK_56351480a99b33cec79e4b168b9" FOREIGN KEY ("purchase_id") REFERENCES "public"."purchase"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_payment_logs" ADD CONSTRAINT "FK_e8537a183402fd854c7196b6e8c" FOREIGN KEY ("company_bank_id") REFERENCES "public"."company_payment_method"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_payment_logs_copy" ADD CONSTRAINT "FK_17d6eaa6b175df13c132f6e8ff1" FOREIGN KEY ("purchase_copy_id") REFERENCES "public"."purchase_copy"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_payment_logs_copy" ADD CONSTRAINT "FK_62d387dcfb4a8c7f527b64d5afa" FOREIGN KEY ("payment_id") REFERENCES "public"."supplier_payment_method"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_payment_logs_copy" ADD CONSTRAINT "FK_8d0341b327dfeca51ab0e602e18" FOREIGN KEY ("company_bank_id") REFERENCES "public"."company_payment_method"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_product" ADD CONSTRAINT "FK_2c3ae950b4eaefc4c65747f018e" FOREIGN KEY ("purchase_id") REFERENCES "public"."purchase"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_product" ADD CONSTRAINT "FK_5de05b42aeedcd8565a7f1061e7" FOREIGN KEY ("product_id") REFERENCES "public"."product"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "return_expense" ADD CONSTRAINT "FK_4d4c47c04ec95542b51065693fb" FOREIGN KEY ("return_id") REFERENCES "public"."return"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "return_expense" ADD CONSTRAINT "FK_d3ce0e5d85ce4ff8f2f53a7bf20" FOREIGN KEY ("expense_id") REFERENCES "public"."expense"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_product_copy" ADD CONSTRAINT "FK_379d12b3c51bb4bc6184ac72df3" FOREIGN KEY ("purchase_copy_id") REFERENCES "public"."purchase_copy"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_product_copy" ADD CONSTRAINT "FK_ff251a07de37dfe6eaa846fbbc5" FOREIGN KEY ("product_variant_id") REFERENCES "public"."product_variants"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_receipt" ADD CONSTRAINT "FK_3366f62f54f633a82d69a6ec68f" FOREIGN KEY ("purchase_id") REFERENCES "public"."purchase"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_receipt" ADD CONSTRAINT "FK_a8a927a580f4c67756ba0ba3c46" FOREIGN KEY ("receipt_uid") REFERENCES "public"."photo"("uid") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_receipt_copy" ADD CONSTRAINT "FK_175f8ffe2a7963cffd05abd1777" FOREIGN KEY ("receipt_uid") REFERENCES "public"."photo"("uid") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "purchase_receipt_copy" ADD CONSTRAINT "FK_fd5ef3469ca679839406f7c181b" FOREIGN KEY ("purchase_copy_id") REFERENCES "public"."purchase_copy"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "return_copy" ADD CONSTRAINT "FK_0b49304ef53c0c9057912578592" FOREIGN KEY ("user_id") REFERENCES "public"."user"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "return_copy" ADD CONSTRAINT "FK_8255ed3244a7a86c56abd92b6c1" FOREIGN KEY ("client_id") REFERENCES "public"."client"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "return_copy" ADD CONSTRAINT "FK_895c1c0af421e818c1603c61b10" FOREIGN KEY ("warehouse_id") REFERENCES "public"."warehouse"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "return_copy" ADD CONSTRAINT "FK_977c6a5002191526494819278ce" FOREIGN KEY ("sales_copy_id") REFERENCES "public"."sales_copy"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "return_product" ADD CONSTRAINT "FK_27c21fc1a993f4f5b1d1b841500" FOREIGN KEY ("product_id") REFERENCES "public"."product"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "return_product" ADD CONSTRAINT "FK_5e8ce7ea7aec8c38c6530c389ae" FOREIGN KEY ("returns_id") REFERENCES "public"."return"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "return_product" ADD CONSTRAINT "FK_ba75639acc552b6e09bd81148bf" FOREIGN KEY ("sales_product_id") REFERENCES "public"."sales_product"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "return_product_copy" ADD CONSTRAINT "FK_8ed2ec777f663b3ad8ed89609ce" FOREIGN KEY ("return_copy_id") REFERENCES "public"."return_copy"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "return_product_copy" ADD CONSTRAINT "FK_d9def54c05f5c5e0cdf5d868609" FOREIGN KEY ("sales_product_copy_id") REFERENCES "public"."sales_product_copy"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "return_product_copy" ADD CONSTRAINT "FK_eef556385f9f8950eb5e40f3d7c" FOREIGN KEY ("product_variant_id") REFERENCES "public"."product_variants"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sales" ADD CONSTRAINT "FK_45e72974e37a5c6b1ae756d567d" FOREIGN KEY ("warehouse_id") REFERENCES "public"."warehouse"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sales" ADD CONSTRAINT "FK_5f282f3656814ec9ca2675aef6f" FOREIGN KEY ("user_id") REFERENCES "public"."user"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sales" ADD CONSTRAINT "FK_b28dab2ad37b83fed99f1fc5896" FOREIGN KEY ("client_poc_id") REFERENCES "public"."client_point_of_contact"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sales" ADD CONSTRAINT "FK_c49d95226945ca3a93584f912ca" FOREIGN KEY ("client_id") REFERENCES "public"."client"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sales_copy" ADD CONSTRAINT "FK_824aee2943fc69e7ee294db3acc" FOREIGN KEY ("user_id") REFERENCES "public"."user"("id") ON DELETE no action ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sales_copy" ADD CONSTRAINT "FK_a8cedc2a156bf14ba087fb01487" FOREIGN KEY ("warehouse_id") REFERENCES "public"."warehouse"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sales_copy" ADD CONSTRAINT "FK_ae3ac02f2dab8b518e9304381aa" FOREIGN KEY ("client_id") REFERENCES "public"."client"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sales_copy" ADD CONSTRAINT "FK_f834cd0adaafa8dd93cd3c73636" FOREIGN KEY ("client_poc_id") REFERENCES "public"."client_point_of_contact"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sales_expense" ADD CONSTRAINT "FK_8d474348c03ba5618e218f5fdb0" FOREIGN KEY ("expense_id") REFERENCES "public"."expense"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sales_expense" ADD CONSTRAINT "FK_94979fab30abc6398582f24cc56" FOREIGN KEY ("sales_id") REFERENCES "public"."sales"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sales_payment_attachment" ADD CONSTRAINT "FK_283479693690b416a028dec2cab" FOREIGN KEY ("sales_payment_id") REFERENCES "public"."sales_payment_logs"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sales_payment_attachment" ADD CONSTRAINT "FK_85426701e5a11fd80b5671e11cb" FOREIGN KEY ("attachment_uid") REFERENCES "public"."photo"("uid") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sales_payment_logs" ADD CONSTRAINT "FK_853c3f8008edd634c8e45691fb5" FOREIGN KEY ("sales_id") REFERENCES "public"."sales"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sales_payment_logs" ADD CONSTRAINT "FK_d4112b394a732688e89f0f01ee8" FOREIGN KEY ("payment_id") REFERENCES "public"."client_payment_method"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sales_payment_logs" ADD CONSTRAINT "FK_debde8f6dd066ad03d2402cd7b2" FOREIGN KEY ("company_bank_id") REFERENCES "public"."company_payment_method"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sales_payment_logs_copy" ADD CONSTRAINT "FK_3c69ff609acad6b86ad8b1d7d56" FOREIGN KEY ("sales_copy_id") REFERENCES "public"."sales_copy"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sales_payment_logs_copy" ADD CONSTRAINT "FK_73f55c0132f69cb53310c2d0b97" FOREIGN KEY ("company_bank_id") REFERENCES "public"."company_payment_method"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sales_payment_logs_copy" ADD CONSTRAINT "FK_7ea8a26d898929a5f756a90616b" FOREIGN KEY ("payment_id") REFERENCES "public"."client_payment_method"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "supplier_point_of_contact" ADD CONSTRAINT "FK_faf26ed6133ffdf599fa34af59f" FOREIGN KEY ("supplier_id") REFERENCES "public"."supplier"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sales_product" ADD CONSTRAINT "FK_9bd2580a16e86b28d4f462c774c" FOREIGN KEY ("sales_id") REFERENCES "public"."sales"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sales_product" ADD CONSTRAINT "FK_e4a6a8d75f87381b593f7dff5b2" FOREIGN KEY ("product_id") REFERENCES "public"."product"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sales_product_copy" ADD CONSTRAINT "FK_53e79d21c31d08b1c488fd85aee" FOREIGN KEY ("product_variant_id") REFERENCES "public"."product_variants"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sales_product_copy" ADD CONSTRAINT "FK_ffe75d304811c69c7b999444dac" FOREIGN KEY ("sales_copy_id") REFERENCES "public"."sales_copy"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "supplier" ADD CONSTRAINT "FK_3e592e2a9dad2e1ec5deb50ffd8" FOREIGN KEY ("address") REFERENCES "public"."address"("id") ON DELETE set null ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "supplier_payment_method" ADD CONSTRAINT "FK_500c94f90f0f1b4471366d11f7b" FOREIGN KEY ("supplier_id") REFERENCES "public"."supplier"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "supplier_photo" ADD CONSTRAINT "FK_c5c12e76494f09b1cfd70f26816" FOREIGN KEY ("supplier_id") REFERENCES "public"."supplier"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "supplier_photo" ADD CONSTRAINT "FK_efb5f1d8aeae40625736d5f8fe9" FOREIGN KEY ("photo_uid") REFERENCES "public"."photo"("uid") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "supplier_product" ADD CONSTRAINT "FK_cd3f318963eb379dc486e751cba" FOREIGN KEY ("product_id") REFERENCES "public"."product"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "supplier_product" ADD CONSTRAINT "FK_e88b7cdd655777df63c3138bc1e" FOREIGN KEY ("supplier_id") REFERENCES "public"."supplier"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "supplier_tags" ADD CONSTRAINT "FK_7aef77626b208139c291fae0d96" FOREIGN KEY ("supplier_id") REFERENCES "public"."supplier"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "supplier_tags" ADD CONSTRAINT "FK_d214dff725f89fa8a138c17bb48" FOREIGN KEY ("tag_id") REFERENCES "public"."tags"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "user_photo" ADD CONSTRAINT "FK_b34629da7eb906c7752d8e17765" FOREIGN KEY ("photo_uid") REFERENCES "public"."photo"("uid") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "user_photo" ADD CONSTRAINT "FK_c980e02b83a3d62361f5431dd8e" FOREIGN KEY ("user_id") REFERENCES "public"."user"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "warehouse_point_of_contact" ADD CONSTRAINT "FK_e74ce342f7dca4fea1ec4ef6957" FOREIGN KEY ("warehouse_id") REFERENCES "public"."warehouse"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "product_variants" ADD CONSTRAINT "FK_01f43a98b627dda4c364564cf9d" FOREIGN KEY ("photo") REFERENCES "public"."photo"("uid") ON DELETE set null ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "product_variants" ADD CONSTRAINT "FK_406133284b91775cdde583b91a5" FOREIGN KEY ("category_id") REFERENCES "public"."category"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "product_variants" ADD CONSTRAINT "FK_5c828b4047802902ea9c9c0d7aa" FOREIGN KEY ("product_copy_id") REFERENCES "public"."product_copy"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "return" ADD CONSTRAINT "FK_03da820ca5bd3355f51de8d9652" FOREIGN KEY ("sales_id") REFERENCES "public"."sales"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "return" ADD CONSTRAINT "FK_16df27a62e4f7256c4c056e7169" FOREIGN KEY ("client_id") REFERENCES "public"."client"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "return" ADD CONSTRAINT "FK_491ea477791838491a009499996" FOREIGN KEY ("warehouse_id") REFERENCES "public"."warehouse"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "return" ADD CONSTRAINT "FK_7871dcb5530915eaa0346a13fcc" FOREIGN KEY ("user_id") REFERENCES "public"."user"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "company_config_photo" ADD CONSTRAINT "FK_0c83181374f74b73066d55a2eb0" FOREIGN KEY ("company_id") REFERENCES "public"."company_config"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "company_config_photo" ADD CONSTRAINT "FK_62ec27da98338215aebc74dbd8e" FOREIGN KEY ("photo_uid") REFERENCES "public"."photo"("uid") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "warehouse" ADD CONSTRAINT "FK_6a259d00df9829720028e35ab2f" FOREIGN KEY ("address") REFERENCES "public"."address"("id") ON DELETE set null ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sales_payment_attachment_copy" ADD CONSTRAINT "FK_274acd7f77c0ad58e3e5baecdb1" FOREIGN KEY ("sales_payment_copy_id") REFERENCES "public"."sales_payment_logs_copy"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "sales_payment_attachment_copy" ADD CONSTRAINT "FK_fd0d8610f4472713fcc90071d7c" FOREIGN KEY ("attachment_uid") REFERENCES "public"."photo"("uid") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "expense" ADD CONSTRAINT "FK_3005f26af8a717b9a2c5b8111c2" FOREIGN KEY ("category") REFERENCES "public"."expense_category"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "expense" ADD CONSTRAINT "FK_7baab10b971a5e603d0df7a257b" FOREIGN KEY ("paymentMethod") REFERENCES "public"."company_payment_method"("id") ON DELETE set null ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "product_meta_data" ADD CONSTRAINT "FK_f987c3b04425ff83bfe5d2aef17" FOREIGN KEY ("productId") REFERENCES "public"."product"("id") ON DELETE cascade ON UPDATE cascade;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;

*/