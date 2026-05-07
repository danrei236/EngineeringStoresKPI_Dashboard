-- ============================================
-- EXECUTE PROCEDURE
-- ============================================
--EXEC InsertSilverLayerData;

	-- ===========================================================
	-- CREATE SILVER LAYER PROCEDURE 
	-- ===========================================================
	CREATE OR ALTER PROCEDURE InsertSilverLayerData AS
	BEGIN
	-- ===========================================================
	-- STOCK ON HAND - INSERT DATA INTO TABLE - SILVER LAYER
	-- ===========================================================
		TRUNCATE TABLE Silver.WorcEngSoh;
		TRUNCATE TABLE Silver.OpenOrdersWorc;
	
		WITH CTE_SOH_CAT AS
		(	SELECT 
			item_code,
			item_description,
			plant,
			sloc,
			StorageBin storage_bin,
			min_lvl,
			max_lvl,
			stck_avail,
			MovAvgPrice mov_avg_price,
			stck_avail * MovAvgPrice valuePerItem
		FROM Bronze.NationalCatEng
		WHERE max_lvl > 0 OR stck_avail > 0
		)
		INSERT INTO Silver.WorcEngSoh(
					item_code,
					item_description,
					plant,
					sloc,
					storage_bin,
					min_lvl,
					max_lvl,
					stck_avail,
					mov_avg_price,
					valuePerItem)
		SELECT 
			item_code,
			item_description,
			plant,
			sloc,
			storage_bin,
			min_lvl,
			max_lvl,
			stck_avail,
			mov_avg_price,
			valuePerItem
		FROM CTE_SOH_CAT;


		-- ===========================================================
		-- OPEN ORDERS - INSERT DATA INTO TABLE - SILVER LAYER
		-- ===========================================================
		WITH CTE_OpenOrders AS
		(
		SELECT *,
			SUM(oo_qty) OVER(PARTITION BY item_code ORDER BY item_code) TotalByItem
		FROM Bronze.OpenOrdersEngWorc
		WHERE doc_date IS NOT NULL
		)

		--COPY RESULTS OF QUERY INTO SILVER.OPENORDERSWORC TABLE
		INSERT INTO Silver.OpenOrdersWorc  (doc_date,
											supplier_name,
											order_no,
											item_code,
											item_description,
											oo_qty,
											item_sum_qty,
											mov_avg_price,
											line_value)
		SELECT
			oo.doc_date,
			LEFT(TRIM(SUBSTRING(supplier,8,LEN(supplier))),3) supplier_name,
			oo.order_no,
			oo.item_code,
			oo.item_description,
			oo.oo_qty,
			oo.TotalByItem item_sum_qty,
			soh.mov_avg_price mov_avg_price,
			oo.oo_qty * soh.mov_avg_price line_value
		FROM CTE_OpenOrders oo
		JOIN Silver.WorcEngSoh soh
		ON oo.item_code = soh.item_code
		;
END



