
-- ==============================================================================
-- CLEAN TABLE, IMPORT DATA FOR SOH AND OPEN ORDERS CREATE THE STORED PROCEDURE
-- ==============================================================================
CREATE OR ALTER PROCEDURE IngestingDataSOH_OO AS
BEGIN
	PRINT '========================================================================'
	PRINT 'BRONZE LAYER - LOADING THE STOCK-ON-HAND AND OPEN ORDER VALUES IN TABLES'
	PRINT '========================================================================'

	PRINT '*******************************************************'
	PRINT '>>  TRUNCATE THE SOH TABLE'
	PRINT '--------------'
	TRUNCATE TABLE Bronze.NationalCatEng

	PRINT '--------------'
	PRINT '>>  LOADING THE STOCK-ON-HAND VALUES IN TABLES'
	--PRINT '*******************************************************'

	BULK INSERT Bronze.NationalCatEng
		FROM 'C:\Users\danre\Desktop\Data Analytics Bootcamp\Dashboards\RCL Data Project\soh14112021.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ';',
			TABLOCK
			);
	PRINT '*******************************************************'
	PRINT '>>  TRUNCATE THE OPEN ORDERS TABLE'
	PRINT '--------------'
	TRUNCATE TABLE Bronze.OpenOrdersEngWorc

	PRINT '--------------'
	PRINT '>>  LOADING THE OPEN ORDER VALUES IN TABLES'
	--PRINT '*******************************************************'

	BULK INSERT Bronze.OpenOrdersEngWorc
		FROM 'C:\Users\danre\Desktop\Data Analytics Bootcamp\Dashboards\RCL Data Project\oo14112021.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ';',
			TABLOCK
			);
END

