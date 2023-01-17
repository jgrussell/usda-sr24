#!/bin/bash
#
# Used to create the files in pg24/ from the USDA source data (sr24.zip).
# These files should be easier to bulk load into most databases.
#
# This will result in data loss from one misformed field of DERIV_CD.txt;
# but, that does not impact what I am attempting to accomplish here.
#
USDA_ZIP=sr24.zip # My input .zip file
mkdir -p sr24 # Create directory for output if it does not exist
#
# Get a list of data files withing the .zip archive.
usda_data=$(unzip -l $USDA_ZIP | grep .txt | cut -c 31-)
#
# Fix Windows encoding of µ using sed
# Filter out a few badly formatted rows of DERIV_CD.txt using grep
# Remove ~ record delimiters using tr
# Replace ^ field delimiters using tr
for FILE in $usda_data; do unzip -p $USDA_ZIP $FILE | sed 's/\xB5/\xC2\xB5/g' | grep '^~' | tr -d "~" | tr "^" "\\t" > sr24/$FILE; done
#
# Apparently the source system for these files was NOT case sensitive;
# but, most modern databases are. So, let's fix some keys:
mv sr24/LANGUAL.txt sr24/LANGUAL.txt.bak
cat sr24/LANGUAL.txt.bak | tr [:lower:] [:upper:] > sr24/LANGUAL.txt
rm sr24/LANGUAL.txt.bak
# Resulting sr24/*.txt should be ready for loading into database of your choice.
#
# Create local SQLite database from these files...
rm -f sr24/sr24.db # Remove SQLite database file if it does exist
#
# Ignore "COMMENT" syntax errors; SQLite still doesn't support this.
sqlite3 sr24/sr24.db < CreateTablesDDLsr24.sql
#
# Import resulting data files into new SQLite database file
# Yes, I know this could have been written with fewer lines of code; but,
# I will likely never run or modify this again.
sqlite3 -batch sr24/sr24.db <<EOF
.mode tabs
.import sr24/DATA_SRC.txt data_src
.import sr24/DATSRCLN.txt datsrcln
.import sr24/DERIV_CD.txt deriv_cd
.import sr24/FD_GROUP.txt fd_group
.import sr24/FOOD_DES.txt food_des
.import sr24/FOOTNOTE.txt footnote
.import sr24/LANGDESC.txt langdesc
.import sr24/LANGUAL.txt langual
.import sr24/NUT_DATA.txt nut_data
.import sr24/NUTR_DEF.txt nutr_def
.import sr24/SRC_CD.txt src_cd
.import sr24/WEIGHT.txt weight
EOF
# I quit working on this before I could figure out how to enable PK's and FK's
# after loading data, diminishing returns and all. (I don't really use SQLite.)
#
./SQLiteHack.sh
sqlite3 sr24/sr24.db < SQLiteHack.sql
