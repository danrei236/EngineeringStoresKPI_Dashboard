
	IF OBJECT_ID('Gold.SohValueWeeklyMovement', 'U') IS NOT NULL
		DROP TABLE Gold.SohValueWeeklyMovement
CREATE TABLE Gold.SohValueWeeklyMovement (
		weekend_date DATE, 
		sohvalue BIGINT,
		dwh_create_date DATETIME2 DEFAULT GETDATE()
		CONSTRAINT pk_weekend_date PRIMARY KEY(weekend_date)
		)

--hard code historic values and add the current weekly stock-on-hand value

INSERT INTO Gold.SohValueWeeklyMovement (weekend_date, sohvalue)
		VALUES  ('2026-02-15', 8023427),
				('2026-02-22', 8400511),
				('2026-03-01', 9283642),
				('2026-03-08', 9829408),
				('2026-03-15', 8563233),
				('2026-03-22', 8054443),
				('2026-03-29', 8018786),
				('2026-04-05', 7806398),
				('2026-04-12', 8028656),
				('2026-04-19', 8220520)


SELECT * FROM Gold.SohValueWeeklyMovement
ORDER BY weekend_date;

	INSERT INTO Gold.SohValueWeeklyMovement (weekend_date, sohvalue)
		VALUES  (GETDATE(), (SELECT
							 SUM(soh.valuePerItem) SOHVALUE
							 FROM Silver.WorcEngSoh soh
							 LEFT JOIN Silver.OpenOrdersWorc oo
							 ON soh.item_code = oo.item_code
						  	 WHERE soh.mov_avg_price != 0 AND stck_avail + COALESCE(oo.item_sum_qty,0) != 0
							 )
				 )