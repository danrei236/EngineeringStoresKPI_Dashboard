-- ================================================
-- BRONZE LAYER - Create Table for SOH 
-- ================================================

IF OBJECT_ID('Bronze.NationalCatEng', 'U') IS NOT NULL
	DROP TABLE Bronze.NationalCatEng;
GO
CREATE TABLE Bronze.NationalCatEng(
	item_code INT,
	item_description NVARCHAR(50),
	mfr_pn NVARCHAR(50),
	mtyp NVARCHAR(50),
	plant INT,
	sloc INT,
	StorageBin NVARCHAR(50),
	min_lvl INT,
	max_lvl INT,
	reorder_point INT,
	stck_avail INT, 
	BUn1 VARCHAR(50),
	InQualInsp INT,
	BU NVARCHAR(50),
	Blocked NVARCHAR(50),
	BUn2 NVARCHAR(50),
	MovAvgPrice FLOAT,

)

-- ================================================
-- BRONZE LAYER - Create Table for OPEN ORDERS 
-- ================================================
IF OBJECT_ID('Bronze.OpenOrdersEngWorc', 'U') IS NOT NULL
	DROP TABLE Bronze.OpenOrdersEngWorc;
GO
CREATE TABLE Bronze.OpenOrdersEngWorc(
	doc_date DATE,
	supplier NVARCHAR(50),
	order_no BIGINT,
	item_code INT,
	item_description NVARCHAR(50),
	oo_qty INT,
)
