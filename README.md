# What?

These are the files and scripts that I used to load the USDA National Nutrient Database for Standard Reference, Legacy Release 24 (SR24) files into various database.

The source files are from an older release; the final version of these files can still be downloaded from [USDA National Nutrient Database for Standard Reference, Legacy Release | Ag Data Commons](https://data.nal.usda.gov/dataset/usda-national-nutrient-database-standard-reference-legacy-release).

If you are just looking for the cleaned up output files and/or the SQLite database loaded from them, you don't need to run anything. These are all contained in the `/sr24` folder of each release.

# Why?

- This is mostly a learning project to brush up on some old, long forgotten, data engineering skills using newer, open source, tools:
  
  - [DBeaver](https://github.com/dbeaver/dbeaver)
  
  - Free Managed Cloud Offerings
    
    - [CockroachDB](https://cockroachlabs.cloud/)
    
    - [YugabyteDB](https://cloud.yugabyte.com)
  
  - [Budibase](https://account.budibase.app/auth/login)
  
  - GitHub Releases

- If I build the nutrition focused meal/diet planning/tracking/optimization application that has been bouncing around in my head for years, this will be used for my initial QA since this data is the basis of the application that I am currently using, [CRON-o-Meter](https://sourceforge.net/projects/cronometer/).

- I thought somebody else out there might find some of this useful:
  
  - Dealing with an old Windows `.zip` file containing special characters such as µ.
  
  - Adding PRIMARY KEYs and FOREIGN KEYs to SQLite tables **after** loading data into them. (SQLite does not support many standard ALTER TABLE statements.)

# How?

1. I started with a copy of [sr24.zip](https://github.com/jgrussell/usda-sr24/blob/main/sr24.zip) which I had downloaded from the USDA many years ago.
   
   - I no longer see this file on the USDA's web page.
   - Had I found [jonathanvx/SR24](https://github.com/jonathanvx/SR24) first, I would have started with this.

2. I created and ran **sr24.sh** to transform the USDA data files into something more easily usable by various database table bulk load commands such as Postgres's `IMPORT INTO`. This script also [re-]creates and populates the `sr24.db` SQLite database on each run.

3. I will be loading this data into a variety of online managed databases as follows:
   
   1. Run **CreateTablesDDLsr24.sql** 
   
   2. Load data using native database tools, [DBeaver](https://github.com/dbeaver/dbeaver) data import tasks, or whatever you like.
      
      * I had intended to utilize bulk imports such as `IMPORT INTO src_cd DELIMITED DATA ('https://MY-PERSONAL-WEB-SERVER/SRC_CD.txt');` which threw SQL Error *[XXUUU]: ERROR: external network access is disabled* on [CockroachDB](https://cockroachlabs.cloud/).
      
      * Since I could not use None for the Quote and Escape characters with this import tool, I set them to ~ and ^ respectively knowing those characters could not be in these import files. (These were the delimiters in the original Windows files. See **sr24.sh** in the files inside [sr24.zip](https://github.com/jgrussell/usda-sr24/blob/main/sr24.zip) for more details if you are interested.)
   
   3. Run **CreateConstraintsDDLsr24.sql**

# To Do

- [ ] Basic data QA

- [ ] Test DDL on additional databases
  
  - [ ] MariaDB/MySQL
  
  - [ ] Oracle?
  
  - [ ] Microsoft SQL Server?
  
  - [ ] Other free online managed relational databases?

- [ ] Consider refactoring `footnote` table to normalize it?

# Note
