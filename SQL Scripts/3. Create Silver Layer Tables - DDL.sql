
-- ===========================================================
-- STOCK ON HAND - CREATE TABLE - SILVER LAYER
-- ===========================================================
	IF OBJECT_ID('Silver.WorcEngSoh', 'U') IS NOT NULL
		DROP TABLE Silver.WorcEngSoh;
	CREATE TABLE Silver.WorcEngSoh(
			item_code INT,
			item_description NVARCHAR(50),
			plant INT,
			sloc INT,
			storage_bin NVARCHAR(50),
			min_lvl INT,
			max_lvl INT,
			stck_avail INT,
			mov_avg_price FLOAT,
			valuePerItem FLOAT,
			dwh_create_date DATETIME2 DEFAULT GETDATE()
			)

-- ===========================================================
-- OPEN ORDERS - CREATE TABLE - SILVER LAYER
-- ===========================================================
	IF OBJECT_ID('Silver.OpenOrdersWorc', 'U') IS NOT NULL
		DROP TABLE Silver.OpenOrdersWorc;
	CREATE TABLE Silver.OpenOrdersWorc(
			doc_date DATE,
			supplier_name NVARCHAR(3),
			order_no BIGINT,
			item_code INT,
			item_description NVARCHAR(50),
			oo_qty INT,
			item_sum_qty INT,
			mov_avg_price FLOAT,
			line_value FLOAT,
			dwh_create_date DATETIME2 DEFAULT GETDATE()
			)

