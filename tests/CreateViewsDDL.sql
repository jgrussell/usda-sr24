/*
DROP VIEW IF EXISTS food_nutr; 
CREATE VIEW food_nutr AS 
select
	food_des.ndb_no,
	food_des.long_desc,
	food_des.shrt_desc,
	food_des.comname,
	food_des.manufacname,
	food_des.refuse,
	food_des.sciname,
	fd_group.fdgrp_cd,
	fd_group.fdgrp_desc,
	nut_data.nutr_val,
	nut_data.low_eb,
	nut_data.up_eb,
	nutr_def.nutr_no, 
	nutr_def.tagname, 
	nutr_def.nutrdesc,
	nutr_def.sr_order
FROM 
	food_des
INNER JOIN
	fd_group
ON
	fd_group.fdgrp_cd = food_des.fdgrp_cd 
INNER JOIN
	nutr_def
ON
	nutr_def.nutr_no = nut_data.nutr_no 
INNER JOIN
	nut_data
ON
	nut_data.nutr_no = nutr_def.nutr_no AND 
	nut_data.ndb_no  = food_des.ndb_no 
-- Outer join to footnote
;
*/

DROP VIEW IF EXISTS cron_o_meter_nutr; 
CREATE VIEW cron_o_meter_nutr AS 
SELECT 	
	nutr_no ,
	TRIM (
	CASE nutr_no
		WHEN 204 THEN 'Fat'
		WHEN 404 THEN 'B1 (Thiamine)'
		WHEN 205 THEN 'Carbs'
		WHEN 291 THEN 'Fiber'
		WHEN 269 THEN 'Sugars'
		WHEN 221 THEN 'Alcohol'
		WHEN 318 THEN 'Vitamin A'
		WHEN 321 THEN 'Beta-carotene'		
		WHEN 322 THEN 'Alpha-carotene'
		WHEN 334 THEN 'Beta-cryptoxanthin'
		WHEN 338 THEN 'Lutein+Zeaxanthin '
		WHEN 417 THEN 'Folate'
		WHEN 418 THEN 'B12 (Cyanocobalamin)'
		WHEN 405 THEN 'B2 (Riboflavin)'
		WHEN 406 THEN 'B3 (Niacin)'
		WHEN 410 THEN 'B5 (Pantothenic Acid)'
		WHEN 415 THEN 'B6 (Pyridoxine)'
		WHEN 401 THEN 'Vitamin C'		
		WHEN 323 THEN 'Vitamin E'
		WHEN 341 THEN 'Beta Tocopherol'
		WHEN 343 THEN 'Delta Tocopherol'
		WHEN 342 THEN 'Gamma Tocopherol'
		WHEN 430 THEN 'Vitamin K'
		WHEN 421 THEN 'Choline'
		WHEN 301 THEN 'Calcium'
		WHEN 312 THEN 'Copper'
		WHEN 313 THEN 'Fluoride'
		WHEN 303 THEN 'Iron'
		WHEN 304 THEN 'Magnesium'
		WHEN 315 THEN 'Manganese'
		WHEN 305 THEN 'Phosphorus'
		WHEN 306 THEN 'Potassium'
		WHEN 317 THEN 'Selenium'
		WHEN 307 THEN 'Sodium'
		WHEN 309 THEN 'Zinc'
		WHEN 606 THEN 'Saturated'
		WHEN 645 THEN 'Monounsaturated'
		WHEN 646 THEN 'Polyunsaturated'
		WHEN 619 THEN 'Omega-3'
		WHEN 618 THEN 'Omega-6'
		WHEN 605 THEN 'Trans-Fats'
		WHEN 636 THEN 'Phytosterol'
		ELSE nutrdesc 
	END) AS nutrdesc_cron_o_meter,
	units,		
	CASE nutr_no
		-- General
		WHEN 208 THEN 10
		-- WHEN 268 THEN 10		
		WHEN 203 THEN 20
		WHEN 205 THEN 30
		WHEN 291 THEN 40
		WHEN 209 THEN 50
		WHEN 269 THEN 60
		WHEN 204 THEN 70
		WHEN 221 THEN 80 
		WHEN 262 THEN 90 
		WHEN 255 THEN 100
		WHEN 207 THEN 110
		-- Vitamins
		WHEN 318 THEN 2000 
		WHEN 319 THEN 2010 -- Retinol
		WHEN 322 THEN 2020 -- Alpha-carotene
		WHEN 321 THEN 2030 -- Beta-carotene
		WHEN 334 THEN 2040 -- Beta-cryptoxanthin
		WHEN 337 THEN 2050
		WHEN 338 THEN 2060
		WHEN 417 THEN 2070
		WHEN 404 THEN 2080
		WHEN 405 THEN 2090
		WHEN 406 THEN 2100
		WHEN 410 THEN 2110
		WHEN 415 THEN 2120 -- B6 (Pyridoxine)
		WHEN 418 THEN 2125 -- B12
		WHEN 334 THEN 2130
		WHEN 401 THEN 2140
		WHEN 324 THEN 2150 -- Vitamin D  
		WHEN 323 THEN 2160
		WHEN 341 THEN 2170
		WHEN 343 THEN 2180
		WHEN 342 THEN 2190
		WHEN 430 THEN 2200
		WHEN null THEN 2210 --Biotin (may not be in sr24)
		WHEN 421 THEN 2220
		-- Minerals
		WHEN 301 THEN 3010
		WHEN null THEN 30 -- Chromium (may not be in sr24)
		WHEN 312 THEN 3030
		WHEN 313 THEN 3040
		WHEN 303 THEN 3050
		WHEN 304 THEN 3060
		WHEN 315 THEN 3070
		WHEN 305 THEN 3080
		WHEN 306 THEN 3090
		WHEN 317 THEN 3100
		WHEN 307 THEN 3110
		WHEN 309 THEN 3120
		-- Lipids
		WHEN 606 THEN 4010
		WHEN 645 THEN 4020
		WHEN 646 THEN 4030
		WHEN 619 THEN 4040 -- Omega-3?
		WHEN 618 THEN 4050 -- Omega-6?
		WHEN 605 THEN 4060
		WHEN 601 THEN 4070
		WHEN 636 THEN 4080		
		ELSE 9999
	END AS sr_order_cron_o_meter
FROM
	nutr_def
;

DROP VIEW IF EXISTS cron_o_meter_food_all_nutr; 
CREATE VIEW cron_o_meter_food_all_nutr AS 
SELECT
	food_des.ndb_no,
	food_des.long_desc ,
	cron_o_meter_nutr.nutr_no,
	cron_o_meter_nutr.nutrdesc_cron_o_meter,
	cron_o_meter_nutr.sr_order_cron_o_meter,
	cron_o_meter_nutr.units 	
FROM 
	food_des
INNER JOIN
	cron_o_meter_nutr
ON 
	TRUE 
;

-- Likely not the most efficient approach; but, 
-- this is good enough for testing purposes. And,
-- it is reasonably easy to understand; I hope.
DROP VIEW IF EXISTS cron_o_meter_nutr_data; 
CREATE VIEW cron_o_meter_nutr_data AS 
SELECT
	ndb_no,
	nutr_no,
	nutr_val
FROM
	nut_data
WHERE 
	nutr_no NOT IN ('618', '619')
UNION ALL SELECT -- Calculate total Omega-3 when we the components are available.
	ndb_no,
	'619' AS nutr_no,
	SUM(nutr_val) AS nutr_val
FROM
	nut_data
WHERE 
	nutr_no IN ('621','629','631','851','852') AND nutr_val > 0
GROUP BY 
	ndb_no,
	'619'	
UNION ALL SELECT -- Use reported undifferentiated Omega-3 when we don't have components.
	ndb_no,
	nutr_no,
	nutr_val
FROM
	nut_data
WHERE 
	nutr_no = '619' AND
	ndb_no NOT IN (select DISTINCT ndb_no FROM nut_data WHERE nutr_no IN ('621','629','631','851','852') AND nutr_val > 0)	
UNION ALL SELECT -- Calculate total Omega-6 when we the components are available.
	ndb_no,
	'618' AS nutr_no,
	SUM(nutr_val) AS nutr_val
FROM
	nut_data
WHERE 
	nutr_no IN ('672','675','685','853','855') AND nutr_val > 0
GROUP BY 
	ndb_no,
	'618'	
UNION ALL SELECT -- Use reported undifferentiated Omega-6 when we don't have components.
	ndb_no,
	nutr_no,
	nutr_val
FROM
	nut_data
WHERE 
	nutr_no = '618' AND
	ndb_no NOT IN (select DISTINCT ndb_no FROM nut_data WHERE nutr_no IN ('672','675','685','853','855') AND nutr_val > 0)	
;

DROP VIEW IF EXISTS cron_o_meter_report_data; 
CREATE VIEW cron_o_meter_report_data AS 
SELECT 
	cron_o_meter_food_all_nutr.ndb_no ,
	cron_o_meter_food_all_nutr.nutr_no,
	cron_o_meter_food_all_nutr.sr_order_cron_o_meter,
	CASE cron_o_meter_food_all_nutr.nutrdesc_cron_o_meter
		WHEN 'Fiber' THEN '  ' || nutrdesc_cron_o_meter	
		WHEN 'Starch' THEN '  ' || nutrdesc_cron_o_meter
		WHEN 'Sugars' THEN '  ' || nutrdesc_cron_o_meter
		WHEN 'Retinol' THEN '  ' || nutrdesc_cron_o_meter
		WHEN 'Alpha-carotene' THEN '  ' || nutrdesc_cron_o_meter
		WHEN 'Beta-carotene' THEN '  ' || nutrdesc_cron_o_meter
		WHEN 'Beta-cryptoxanthin' THEN '  ' || nutrdesc_cron_o_meter
		WHEN 'Lycopene' THEN '  ' || nutrdesc_cron_o_meter
		WHEN 'Lutein+Zeaxanthin' THEN '  ' || nutrdesc_cron_o_meter
		WHEN 'Beta Tocopherol' THEN '  ' || nutrdesc_cron_o_meter
		WHEN 'Delta Tocopherol' THEN '  ' || nutrdesc_cron_o_meter
		WHEN 'Gamma Tocopherol' THEN '  ' || nutrdesc_cron_o_meter
		WHEN 'Omega-3' THEN '  ' || nutrdesc_cron_o_meter
		WHEN 'Omega-6' THEN '  ' || nutrdesc_cron_o_meter	
		ELSE nutrdesc_cron_o_meter
	END	AS nutrient_cron_o_meter,
	IFNULL(nutr_val, 0) AS nutr_val,
	cron_o_meter_food_all_nutr.units
FROM
	cron_o_meter_food_all_nutr
LEFT OUTER JOIN 
	cron_o_meter_nutr_data 
ON
	cron_o_meter_nutr_data.ndb_no = cron_o_meter_food_all_nutr.ndb_no AND 
	cron_o_meter_nutr_data.nutr_no = cron_o_meter_food_all_nutr.nutr_no 
;

DROP VIEW IF EXISTS cron_o_meter_report_data_for_QA; 
CREATE VIEW cron_o_meter_report_data_for_QA AS 
SELECT 
	ndb_no ,
	nutr_no,
	sr_order_cron_o_meter,
	nutrient_cron_o_meter  || 
		CASE LENGTH(nutrient_cron_o_meter) --RPAD(nutrdesc_cron_o_meter, 21) for SQLite
			WHEN 1 THEN '                    ' 
			WHEN 2 THEN '                   ' 
			WHEN 3 THEN '                  ' 
			WHEN 4 THEN '                 ' 
			WHEN 5 THEN '                ' 
			WHEN 6 THEN '               ' 
			WHEN 7 THEN '              '
			WHEN 8 THEN '             '
			WHEN 9 THEN '            '
			WHEN 10 THEN '           '
			WHEN 11 THEN '          '
			WHEN 12 THEN '         '
			WHEN 13 THEN '        '
			WHEN 14 THEN '       '
			WHEN 15 THEN '      '
			WHEN 16 THEN '     '
			WHEN 17 THEN '    '
			WHEN 18 THEN '   '
			WHEN 19 THEN '  '
			WHEN 20 THEN ' '
			ELSE ''
		END || '|' ||
		CASE INSTR(cast(nutr_val * 100 as text), '.')
			WHEN 0 THEN CASE LENGTH(cast(nutr_val * 100 as text))
				WHEN 1 THEN '     '
				WHEN 2 THEN '    '
				WHEN 3 THEN '   '
				WHEN 4 THEN '  '
				WHEN 5 THEN ' '				
				ELSE ''
			END || cast(nutr_val * 100 as text) || '.0'
			ELSE CASE LENGTH(cast(nutr_val * 1000 as text))
				WHEN 3 THEN '      '
				WHEN 4 THEN '     '
				WHEN 5 THEN '    '
				WHEN 6 THEN '   '
				WHEN 7 THEN '  '
				WHEN 8 THEN ' '				
				ELSE ''
			END || cast(nutr_val * 100 as text)
		END || ' ' || units AS report_line
FROM 
	cron_o_meter_report_data 
WHERE
	sr_order_cron_o_meter < 9999
;

DROP VIEW IF EXISTS cron_o_meter_amino_acids ;
CREATE VIEW cron_o_meter_amino_acids AS 
SELECT 	
	nutr_no ,
	CASE nutr_no
		WHEN '513' THEN 'ALA' 
		WHEN '511' THEN 'ARG' 
		WHEN '514' THEN 'ASP'
		WHEN '507' THEN 'CYS'
		WHEN '515' THEN 'GLU' 
		WHEN '516' THEN 'GLY' 
		WHEN '512' THEN 'HIS' 
		WHEN '521' THEN 'HYP'
		WHEN '503' THEN 'ILE' 
		WHEN '504' THEN 'LEU'
		WHEN '505' THEN 'LYS'
		WHEN '506' THEN 'MET'
		WHEN '508' THEN 'PHE' 
		WHEN '517' THEN 'PRO'
		WHEN '518' THEN 'SER' 
		WHEN '502' THEN 'THR' 
		WHEN '501' THEN 'TRP' 
		WHEN '509' THEN 'TYR' 
		WHEN '510' THEN 'VAL'
		ELSE NULL
	END AS nutrdesc_cron_o_meter_amino_acids,
	units
FROM
	nutr_def
;

DROP VIEW IF EXISTS cron_o_meter_amino_acids_GUI_for_QA; 
CREATE VIEW cron_o_meter_amino_acids_GUI_for_QA AS 
SELECT 
	nut_data.ndb_no,
	nutrdesc_cron_o_meter_amino_acids ,
	round(100 * nut_data.nutr_val, 1) AS 'Amount'
FROM 
	cron_o_meter_amino_acids
INNER JOIN
	cron_o_meter_food_all_nutr
ON 
	cron_o_meter_food_all_nutr.nutr_no = cron_o_meter_amino_acids.nutr_no 
INNER JOIN 
	nut_data
ON
	nut_data.ndb_no = cron_o_meter_food_all_nutr.ndb_no AND 
	nut_data.nutr_no = cron_o_meter_food_all_nutr.nutr_no 		
WHERE 
	nutrdesc_cron_o_meter_amino_acids IS NOT NULL 
;
