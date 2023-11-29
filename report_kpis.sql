-- let's create a monthly report for KPIs created by us using a database monthly provided
-- we create the table where we store the KPIs
use calls;
CREATE TABLE KPI_value (
  Centro VARCHAR(255),
  KPI_1 DECIMAL(10, 2),
  KPI_2 DECIMAL(10, 2),
  KPI_3 datetime,
  KPI_4 DECIMAL(10, 2),
  KPI_5 DECIMAL(10, 2),
  Mese datetime
);
-- calculating KPIs and inserting into the tbale KPI_VALORE that will be our final report
INSERT INTO KPI_value(
SELECT
  Centro,
  `% time_on_call` / 100 as KPI_1,
  (CASE
    WHEN (`scheduled calls` / `effective calls`) > 1 THEN ROUND(1, 2)
    ELSE ROUND((`scheduled calls` / `effective calls`), 2)
  END) as KPI_2,
  `time_calls` as KPI_3,
  `% avarage_time_call` / 100 as KPI_4,
  ROUND((`number_of_call_per_day` / 22), 2) as KPI_5, period as Mese
FROM calls.`db_completo (1)`);
select * from calls.KPI_value;
