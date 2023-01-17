#!/bin/bash
#
# Used to create statements in the SQLiteHack.sql file from the
# CreateSQLitePKsDDLsr24.sql file.
#
# These hack is only needed if you are using SQLite or similar databases
# that do not support adding PK's after table creation/loading. (This will
# almost certainly need to be changed for any such database other than
# SQLite since it create SQLite specific syntax.)
#
SQL_IN=CreateConstraintsDDLsr24.sql # Generic file for creating PK's
SQL_OUT=SQLiteHack.sql # SQLite specific file for creating PK's
#
# Comment the output file
cat > $SQL_OUT <<'EOF'
/*
*
* Only run this script if loading SQLite!!!!
*
* This script is only needed for SQLite since SQLite still does note
* allow many ALTER TABLE statements after table creation. But, having
* constraints in place would not only slow table loading but also preclude
* use of the other generic *.sql scripts created for this project.
*
* As with many tricks, I owe much thanks to the folks on Stack Overflow,
* specifically, in this case:
*   https://stackoverflow.com/a/20561207
*
*/
EOF
#
# Get list of tables with PK's
# This assumes SQL_IN is formatted basically like a PostgreSQL database
# dump with DDL statements uppercase and table names lower case withou spaces.
#
table_list=$(grep --ignore-case --before-context=1 "PRIMARY KEY" $SQL_IN | grep "ALTER TABLE" | tr -d [:upper:] | tr -d [:blank:] | uniq)
#
#BEGIN;
#CREATE INDEX src_cd_test_pk ON src_cd_test(src_cd);
#pragma writable_schema=1;
#UPDATE sqlite_master SET name='sqlite_autoindex_src_cd_test_1',sql=null WHERE name='src_cd_test_pk';
#UPDATE sqlite_master SET sql= SUBSTRING(sql, 1, LENGTH (sql) - 1) || ', primary key(src_cd))' WHERE name='src_cd_test';
#COMMIT;
#
for t in $table_list; do
	echo "#" >> $SQL_OUT
	echo "BEGIN;" >> $SQL_OUT
	# Get column(s) for PRIMARY KEY of this table
	pk_line=$(grep $t $SQL_IN | grep "PRIMARY KEY (")
	pk_start=$(echo $pk_line | awk 'END{print index($0,"(")}')
	pk_end=$(echo $pk_line | awk 'END{print index($0,")")}')
	pk_cols=$(echo $pk_line | cut -c ${pk_start}-${pk_end})
	echo "CREATE INDEX ${t}_pk ON ${t}${pk_cols};" >> $SQL_OUT
	echo "pragma writable_schema=1;" >> $SQL_OUT
	echo "UPDATE sqlite_master SET name='sqlite_autoindex_${t}_1',sql=null WHERE name='${t}_pk';" >> $SQL_OUT
	echo -n "UPDATE sqlite_master SET sql= SUBSTRING(sql, 1, LENGTH (sql) - 1) || ', primary key${pk_cols}" >> $SQL_OUT
#	Get the FK list for the table we are working on at this point.
#   This FOREIGN KEY logic is VERY dependent on the format of the input file
#   being as expected.
	fk_list=$(grep --ignore-case --after-context=1 "ALTER TABLE.*${t}" $SQL_IN | grep "ADD CONSTRAINT" | grep "FOREIGN KEY")
	prioIFS=$IFS
	IFS=$'\n'
	for fk_line in $fk_list; do
		fk_start=$(echo $fk_line | awk 'END{print index($0,"(")}')
		fk_end=$(echo $fk_line | awk 'END{print index($0,";")}')
		fk_def=$(echo $fk_line | cut -c ${fk_start}-${fk_end} | tr -d ";")
		echo -n ", foreign key${fk_def}" >> $SQL_OUT
	done
	IFS=$IFS
	echo ")' WHERE name='${t}';" >> $SQL_OUT
	echo "COMMIT;" >> $SQL_OUT
done
#
#	The footnote table, as currently designed, does not have a PK defined. So,
#	the code above does not work to generate FK's for this table.
#	Rather than make this code even more convoluted, I am just manually added
#	these FK's to the script being created.
cat >> $SQL_OUT <<'EOF'
#
BEGIN;
pragma writable_schema=1;
UPDATE sqlite_master SET sql='CREATE TABLE footnote (
    ndb_no character varying(5) NOT NULL,
    footnt_no character varying(4) NOT NULL,
    footnt_typ character varying(1),
    nutr_no character varying(3),
    footnt_txt character varying(200) NOT NULL,
    foreign key(ndb_no) REFERENCES food_des(ndb_no), foreign key(nutr_no) REFERENCES nutr_def(nutr_no)
);'  WHERE name='footnote';
COMMIT;
EOF




