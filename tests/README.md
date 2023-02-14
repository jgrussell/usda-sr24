# What?

These are the files and scripts that I used to verify the data in this database matches what is contained in and reported by the final official release of the [CRON-o-Meter](https://sourceforge.net/projects/cronometer/) application.

# Why?

- My assumption is that the the [CRON-o-Meter](https://sourceforge.net/projects/cronometer/) application is representing/calculating its information from the database correctly; so, this gives me a good baseline and set of test cases for this project.

- If I build the nutrition focused meal/diet planning/tracking/optimization application that has been bouncing around in my head for years, this will be used for my initial QA since this data is the basis of the application that I am currently using, [CRON-o-Meter](https://sourceforge.net/projects/cronometer/).

# How?

1. Created a series of [SQLite views](./CreateViewsDDL.sql) (hopefully applicable to other databases as well) for interpreting and formatting the USDA data similarly to the [CRON-o-Meter](https://sourceforge.net/projects/cronometer/) application.

2. Created single food test files as follows:
   
   1. Select a date in the [CRON-o-Meter](https://sourceforge.net/projects/cronometer/) application which does not have any foods.
   
   2. Add 10000g of a food to use for testing. (The application suffers from rounding/truncation issues at more realistic food amounts.)
   
   3. Export a *Nutrition Report* (the only option of the *Reports* menu) into this directory for the selected day containing only the food to be tested, ensuring the following:
      
      - Targets Only is NOT checked
      - Output format is Text (rather than HTML)
   
   4. Open the *Food Editor* n the [CRON-o-Meter](https://sourceforge.net/projects/cronometer/) application to find the `ndb_no` for the food (labeled `USDA:` in the *Food Editor* pop-up window).
   
   5. Compare the resulting export file with the data from `cron_o_meter_report_data_for_QA` for the food item being tested. For example, the [tomato.txt](./tomato.txt) file contains data for *Tomatoes, red, ripe, raw, year round average* which `ndb_no='11529'` ; so, use this SQL to create the report lines for comparison:
      
      ```sql
      SELECT * 
      FROM cron_o_meter_report_data_for_QA 
      WHERE ndb_no = '11529' -- tomato.txt file
      ORDER BY sr_order_cron_o_meter;
      ```
   
   6. Add the name of the exported file and its `ndb_no` to the `testFood` associative array in the [testsSQLite.sh](../testsSQLite.sh) script for automated testing.

3. Verified that all nutrients included in the [CRON-o-Meter](https://sourceforge.net/projects/cronometer/) application's *Nutrition Report* have been tested with at least one food using the following SQL:
   
   ```sql
   SELECT nutr_no, MAX(nutr_val)
   FROM cron_o_meter_report_data
   WHERE
       sr_order_cron_o_meter < 9999 AND
       ndb_no IN (
       '12152', -- pistacio.txt
       '11098', -- sprouts.txt
       '14355', -- tea.txt
       '01123', -- egg.txt
       '01001', -- saltbutter.txt
       '11529', -- tomato.txt
       '14096', -- wine.txt
       '17343'  -- grounddeer.txt
   )
   GROUP BY nutr_no
   ORDER BY 2;
   ```

4. Visually checked Amino Acids (included in the [CRON-o-Meter](https://sourceforge.net/projects/cronometer/) application's GUI but not in its *Nutrition Report* for a couple of the foods used in prior testing, for example:
   
   ```sql
   SELECT * FROM cron_o_meter_amino_acids_GUI_for_QA 
   WHERE ndb_no = '17343' -- Game meat, deer, ground, raw
   ORDER BY nutrdesc_cron_o_meter_amino_acids; 
   ```

# To Do

- [ ] Automate tests to verify counts match between source files and target tables.

- [ ] Basic data QA for other iterations of this database (managed SaaS, local via Podman, etc.) to ensure those data loads were successful and match SQLite.

# Notes

I am actively seeking an easy to use, open source tool, harness, application, or framework for this kind of testing.
