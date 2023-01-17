# What?

These are the files and scripts that I used to load the USDA National Nutrient Database for Standard Reference, Legacy Release 24 (SR24) files into various database.

These are from an older release of the final version of these files which can still be downloaded from [USDA National Nutrient Database for Standard Reference, Legacy Release | Ag Data Commons](https://data.nal.usda.gov/dataset/usda-national-nutrient-database-standard-reference-legacy-release).

# Why?

- This is mostly a learning project to brush up on some old, long forgotten, data engineering skills using newer, open source, tools:
  
  - [DBeaver](https://github.com/dbeaver/dbeaver)
  
  - Free Managed Cloud Offerings
    
    - [CockroachDB](https://cockroachlabs.cloud/)
    
    - [YugabyteDB](https://cloud.yugabyte.com)
  
  - [Budibase](https://account.budibase.app/auth/login)
  
  - GitHub Releases

- If I build the nutrition focused meal/diet planning/tracking/optimization application that has been bouncing around in my head for years, this will be used for my initial QA since this data is the basis of the application that I am currently using, [CRON-o-Meter](https://sourceforge.net/projects/cronometer/).

- I thought somebody else out there might find it useful to see how I dealt with an old Windows .zip file containing special characters such as µ.

# How?

1. I started with a copy of [sr24.zip](https://github.com/jgrussell/usda-sr24/blob/main/sr24.zip) which I had downloaded from the USDA many years ago.
   
   - I no longer see this file on the USDA's web page.
   - Had I found [jonathanvx/SR24](https://github.com/jonathanvx/SR24) first, I would have started with this.

2. I created and ran **sr24.sh** to transform the USDA data files into something more easily usable by various database table bulk load commands such as Postgres's `IMPORT INTO`.

3. Load data into your database of choice as follows:
   
   1. Run **CreateTablesDDLsr24.sql** 
   
   2. Load data using native database tools, [DBeaver](https://github.com/dbeaver/dbeaver) data import tasks, or whatever you like.
      
      * I had intended to utilize bulk imports such as `IMPORT INTO src_cd DELIMITED DATA ('https://MY-PERSONAL-WEB-SERVER/SRC_CD.txt');` which threw SQL Error *[XXUUU]: ERROR: external network access is disabled* on [CockroachDB](https://cockroachlabs.cloud/).
      
      * Since I could not use None for the Quote and Escape characters with this import tool, I set them to ~ and ^ respectively knowing those characters could not be in these import files. (See **sr24.sh** for details.)
   
   3. Run **CreateConstraintsDDLsr24.sql**

# To Do

- [ ] Basic data QA

- [ ] Test DDL on additional databases
  
  - [ ] MariaDB/MySQL
  
  - [ ] Oracle?
  
  - [ ] Microsoft SQL Server?
  
  - [ ] Other free online managed relational databases?

- [ ] Consider refactoring `footnote` table to normalize it?

- [ ] SQLite issues?
  
  - [x] Why does `select * from sqlite_master where type = 'datsrcln';` return two rows in SQLite?
  
  - [ ] Finish `SQLiteHack.sql` to add ~~PK's~~ and FK's to SQLite database?

# Notes

- ## [Download FoodData Central Data](https://fdc.nal.usda.gov/download-datasets.html)

https://github.com/Adyg/usdanl-sr28-postgresql

`git clone -b master --depth 1 --single-branch https://github.com/Adyg/usdanl-sr28-postgresql.git`

# Fix Data files for pg import

cut DATA_SRC.txt -c 2- | tr -d "~" | tr "^" "\\t" | head

for FILE in *.txt; do cut $FILE -c 2- | tr -d "~" | tr "^" "\\t" > pg24/$FILE; done

https://hiwt.com/SRC_CD.txt

### Change DDL and/or manually fix data file and Re-import

- [ ] DERIV_CD
- [ ] FOOTNOTE
- [ ] DATA_SRC (including record D5021)

# To Do

- Move stuff from /home/jgr/.local/share/DBeaverData/workspace6/General/Scripts/ to git
- `IMPORT INTO src_cd DELIMITED DATA ('https://hiwt.com/SRC_CD.txt');` threw SQL Error *\[XXUUU\]: ERROR: external network access is disabled* on CockroachLabs.

https://github.com/littlebunch/bfpd-rs
https://academic.oup.com/ajcn/article/115/3/619/6459205?login=false

https://docplayer.net/101054235-Im2calories-towards-an-automated-mobile-vision-food-diary.html

https://github.com/m5n/nutriana

https://github.com/lxaw/ComprehensiveFoodDatabase

# Should Have Started with This

[GitHub - jonathanvx/SR24: USDA National Nutrient Database for Standard Reference](https://github.com/jonathanvx/SR24)
