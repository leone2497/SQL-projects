use schedulazione;
CREATE TABLE KPI_VALORE (
  Centro VARCHAR(255),
  KPI_1 DECIMAL(10, 2),
  KPI_2 DECIMAL(10, 2),
  KPI_3 VARCHAR(255),
  KPI_4 DECIMAL(10, 2),
  KPI_5 DECIMAL(10, 2),
  Mese datetime
);
INSERT INTO KPI_VALORE(
SELECT
  Centro,
  `% reale Utilizzo Schedulatore` / 100 as KPI_1,
  (CASE
    WHEN (`Numero Medio Operatori per Run di Schedulazione` / `Numero Medio Giornaliero Operatori Disponibili`) > 1 THEN ROUND(1, 2)
    ELSE ROUND((`Numero Medio Operatori per Run di Schedulazione` / `Numero Medio Giornaliero Operatori Disponibili`), 2)
  END) as KPI_2,
  `Orizzonte Medio` as KPI_3,
  `% Media Odl Validi e Schedulati` / 100 as KPI_4,
  ROUND((`Numero Run` / 22), 2) as KPI_5, cast(periodo as datetime) as Mese
FROM schedulazione.`db_completo (1)`);
select * from schedulazione.KPI_VALORE;