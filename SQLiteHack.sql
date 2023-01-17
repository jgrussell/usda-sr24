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
#
BEGIN;
CREATE INDEX data_src_pk ON data_src(datasrc_id);
pragma writable_schema=1;
UPDATE sqlite_master SET name='sqlite_autoindex_data_src_1',sql=null WHERE name='data_src_pk';
UPDATE sqlite_master SET sql= SUBSTRING(sql, 1, LENGTH (sql) - 1) || ', primary key(datasrc_id))' WHERE name='data_src';
COMMIT;
#
BEGIN;
CREATE INDEX datsrcln_pk ON datsrcln(ndb_no, nutr_no, datasrc_id);
pragma writable_schema=1;
UPDATE sqlite_master SET name='sqlite_autoindex_datsrcln_1',sql=null WHERE name='datsrcln_pk';
UPDATE sqlite_master SET sql= SUBSTRING(sql, 1, LENGTH (sql) - 1) || ', primary key(ndb_no, nutr_no, datasrc_id), foreign key(datasrc_id) REFERENCES data_src(datasrc_id), foreign key(ndb_no, nutr_no) REFERENCES nut_data(ndb_no, nutr_no))' WHERE name='datsrcln';
COMMIT;
#
BEGIN;
CREATE INDEX deriv_cd_pk ON deriv_cd(deriv_cd);
pragma writable_schema=1;
UPDATE sqlite_master SET name='sqlite_autoindex_deriv_cd_1',sql=null WHERE name='deriv_cd_pk';
UPDATE sqlite_master SET sql= SUBSTRING(sql, 1, LENGTH (sql) - 1) || ', primary key(deriv_cd))' WHERE name='deriv_cd';
COMMIT;
#
BEGIN;
CREATE INDEX fd_group_pk ON fd_group(fdgrp_cd);
pragma writable_schema=1;
UPDATE sqlite_master SET name='sqlite_autoindex_fd_group_1',sql=null WHERE name='fd_group_pk';
UPDATE sqlite_master SET sql= SUBSTRING(sql, 1, LENGTH (sql) - 1) || ', primary key(fdgrp_cd))' WHERE name='fd_group';
COMMIT;
#
BEGIN;
CREATE INDEX food_des_pk ON food_des(ndb_no);
pragma writable_schema=1;
UPDATE sqlite_master SET name='sqlite_autoindex_food_des_1',sql=null WHERE name='food_des_pk';
UPDATE sqlite_master SET sql= SUBSTRING(sql, 1, LENGTH (sql) - 1) || ', primary key(ndb_no), foreign key(fdgrp_cd) REFERENCES fd_group(fdgrp_cd))' WHERE name='food_des';
COMMIT;
#
BEGIN;
CREATE INDEX langdesc_pk ON langdesc(factor_code);
pragma writable_schema=1;
UPDATE sqlite_master SET name='sqlite_autoindex_langdesc_1',sql=null WHERE name='langdesc_pk';
UPDATE sqlite_master SET sql= SUBSTRING(sql, 1, LENGTH (sql) - 1) || ', primary key(factor_code))' WHERE name='langdesc';
COMMIT;
#
BEGIN;
CREATE INDEX langual_pk ON langual(ndb_no, factor_code);
pragma writable_schema=1;
UPDATE sqlite_master SET name='sqlite_autoindex_langual_1',sql=null WHERE name='langual_pk';
UPDATE sqlite_master SET sql= SUBSTRING(sql, 1, LENGTH (sql) - 1) || ', primary key(ndb_no, factor_code), foreign key(factor_code) REFERENCES langdesc(factor_code), foreign key(ndb_no) REFERENCES food_des(ndb_no))' WHERE name='langual';
COMMIT;
#
BEGIN;
CREATE INDEX nut_data_pk ON nut_data(ndb_no, nutr_no);
pragma writable_schema=1;
UPDATE sqlite_master SET name='sqlite_autoindex_nut_data_1',sql=null WHERE name='nut_data_pk';
UPDATE sqlite_master SET sql= SUBSTRING(sql, 1, LENGTH (sql) - 1) || ', primary key(ndb_no, nutr_no), foreign key(ndb_no) REFERENCES food_des(ndb_no), foreign key(nutr_no) REFERENCES nutr_def(nutr_no), foreign key(src_cd) REFERENCES src_cd(src_cd), foreign key(deriv_cd) REFERENCES deriv_cd(deriv_cd))' WHERE name='nut_data';
COMMIT;
#
BEGIN;
CREATE INDEX nutr_def_pk ON nutr_def(nutr_no);
pragma writable_schema=1;
UPDATE sqlite_master SET name='sqlite_autoindex_nutr_def_1',sql=null WHERE name='nutr_def_pk';
UPDATE sqlite_master SET sql= SUBSTRING(sql, 1, LENGTH (sql) - 1) || ', primary key(nutr_no))' WHERE name='nutr_def';
COMMIT;
#
BEGIN;
CREATE INDEX src_cd_pk ON src_cd(src_cd);
pragma writable_schema=1;
UPDATE sqlite_master SET name='sqlite_autoindex_src_cd_1',sql=null WHERE name='src_cd_pk';
UPDATE sqlite_master SET sql= SUBSTRING(sql, 1, LENGTH (sql) - 1) || ', primary key(src_cd))' WHERE name='src_cd';
COMMIT;
#
BEGIN;
CREATE INDEX weight_pk ON weight(ndb_no, seq);
pragma writable_schema=1;
UPDATE sqlite_master SET name='sqlite_autoindex_weight_1',sql=null WHERE name='weight_pk';
UPDATE sqlite_master SET sql= SUBSTRING(sql, 1, LENGTH (sql) - 1) || ', primary key(ndb_no, seq), foreign key(ndb_no) REFERENCES food_des(ndb_no))' WHERE name='weight';
COMMIT;
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
