-- =+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+
-- DATASET IS BASED ON A ENGINEERING STORES AND BACK DATED TO 2021
-- =+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+=+


-- ===========================================================
-- TOTAL ITEM COUNT AND SOH VALUE QUERY - GOLD LAYER
-- ===========================================================
/*	Target SOH VALUE is 8MIL, currently is 8,3MIL.
	Discuss with Engineering, Projects, Procurement and Finance:
	Stock obsolesence, Stock Add_ons for New machinery installed in Manufacturing
	Evaluate the current 8MIL Target, posibillity to increase based on stock_addons.

*/
SELECT
	soh.item_code,
	soh.item_description,
	plant,
	sloc,
	storage_bin,
	min_lvl,
	max_lvl,
	stck_avail,
	COALESCE(oo.item_sum_qty,0) oo_qty,
	stck_avail + COALESCE(oo.item_sum_qty,0) tot_stockincl_OO,
	soh.mov_avg_price,
	COUNT(soh.item_code) OVER() TotalItemCount,
	SUM(soh.valuePerItem) OVER() SOHVALUE
FROM Silver.WorcEngSoh soh
LEFT JOIN Silver.OpenOrdersWorc oo
	ON soh.item_code = oo.item_code
WHERE soh.mov_avg_price != 0 AND stck_avail + COALESCE(oo.item_sum_qty,0) != 0 
ORDER BY storage_bin;


-- ===========================================================
-- INSERT SOH VALUE INTO ANOTHER TABLE WITH DATE - GOLD LAYER - Table is already Created.
-- ===========================================================
CREATE PROCEDURE SohWeeklyMovement AS
BEGIN
INSERT INTO Gold.SohValueWeeklyMovement (weekend_date, sohvalue)
		VALUES  (GETDATE(), (SELECT
							 SUM(soh.valuePerItem) SOHVALUE
							 FROM Silver.WorcEngSoh soh
							 LEFT JOIN Silver.OpenOrdersWorc oo
							 ON soh.item_code = oo.item_code
						  	 WHERE soh.mov_avg_price != 0 AND stck_avail + COALESCE(oo.item_sum_qty,0) != 0
							 )
				 )
END


-- ===========================================================
-- OBSOLETE VALUE AND TOTAL OBS ITEMS - GOLD LAYER
-- ===========================================================
/* Obsolete value is 900K, engineering & Procurement to final review spares for write off.
	Compile summary and submit to Finance and Risk for write off within F22 (Before June 2022)
	Transormer (included) is 647K, discuss with National Team the plan forward.
*/

SELECT *,
	COUNT(*) OVER() total_obs,
	SUM(valuePerItem) OVER() TotalObsValue
FROM Silver.WorcEngSoh
WHERE max_lvl = 0 and stck_avail > 0;



-- ===========================================================
-- OPEN ORDER VALUE PER SUPPLIER QUERY - GOLD LAYER
-- ===========================================================
/* Focus on the top 5 Suppliers with the highest value

*/
SELECT
	DISTINCT supplier_name,
	SUM(line_value) OVER(PARTITION BY supplier_name) value_per_supplier
FROM Silver.OpenOrdersWorc
ORDER BY value_per_supplier DESC;


-- ===========================================================
-- OPEN ORDERS - LINE VALUE, TOTAL OPEN ORDER VALUE  - GOLD LAYER
-- ===========================================================
/* Current Open Order Value = 1.19MIL. 
   Procurement/Expediting team to minimize open order value to 700K before month end
*/
SELECT *, 
	SUM(line_value) OVER(PARTITION BY item_code) oo_total_value,
	SUM(oo_qty) OVER(PARTITION BY item_code) oo_tot_qty,
	SUM(line_value) OVER() oo_total_value
FROM Silver.OpenOrdersWorc;


-- ===========================================================
-- OPEN ORDERS DAYS OUTSTANDING (DATEDIFF)  - GOLD LAYER
-- ===========================================================
/*	Items is outstanding for more then 18 and 30 days. contact supplier immediately, explain the urgency.
	Procurement to source an alternative supplier if not bottleneck supplier, if on contract check terms, 
	alternatively verify if our regional engineering stores have the item instock.
	proactively work with Procurement/engineering/maintenance_planning to resolve.
	
*/
SELECT 
	COUNT(*) OVER() Count_lines,
	item_code,
	item_description,
	doc_date,
	order_no,
	Supplier_name,
	item_sum_qty,
	line_value,
	DATEDIFF(day, doc_date, '2021-11-14') diff_days,
CASE 
	WHEN DATEDIFF(day, doc_date, '2021-11-14') > 30 THEN '30days+ Action Immediately'
	WHEN DATEDIFF(day, doc_date, '2021-11-14') > 18 THEN '18days+ Medium Action required'
	WHEN DATEDIFF(day, doc_date, '2021-11-14') > 7 THEN '7days+ Low action Required'
	ELSE 'No Action Required'
END Priorities
FROM Silver.OpenOrdersWorc
ORDER BY doc_date;


-- ===========================================================
-- HOW MANY OPEN ORDERS SOH IS ON ZERO  - GOLD LAYER
-- ===========================================================
/*Insight: 82 Orders is on Zero -
communicate to engineering/maintenance team, they will have to plan their maintenance accordingly. 
if breakdown occurs and spares is required, measure the after effect or cost involve.
*/
SELECT 
	COUNT(*) OVER() Count_lines,
	oo.item_code,
	oo.item_description,
	oo.doc_date,
	oo.order_no,
	oo.Supplier_name,
	oo.item_sum_qty,
	soh.stck_avail,
	oo.line_value,
	DATEDIFF(day, doc_date, '2021-11-14') diff_days,
CASE 
	WHEN DATEDIFF(day, doc_date, '2021-11-14') > 30 THEN '30days+ Action Immediately'
	WHEN DATEDIFF(day, doc_date, '2021-11-14') > 18 THEN '18days+ Medium Action required'
	WHEN DATEDIFF(day, doc_date, '2021-11-14') > 7 THEN '7days+ Low action Required'
	ELSE 'No Action Required'
END Priorities
FROM Silver.OpenOrdersWorc oo
LEFT JOIN Silver.WorcEngSoh soh
	ON oo.item_code = soh.item_code
WHERE stck_avail = 0
ORDER BY doc_date;