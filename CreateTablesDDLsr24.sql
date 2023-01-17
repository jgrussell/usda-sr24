/*
* This is mostlyl a blatant copy from this with SR28 in the
* https://github.com/Adyg/usdanl-sr28-postgresql repository.
*/

--
-- Name: data_src; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE data_src (
    datasrc_id character varying(6) NOT NULL,
    authors character varying(255),
    title character varying(255),
    year character varying(4),
    journal character varying(135),
    vol_city character varying(16),
    issue_state character varying(5),
    start_page character varying(5),
    end_page character varying(5)
);


-- ALTER TABLE public.data_src OWNER TO postgres;

--
-- Name: TABLE data_src; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE data_src IS 'Provides a citation to the DataSrc_ID in the Sources of Data Link table.';


--
-- Name: COLUMN data_src.datasrc_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN data_src.datasrc_id IS 'Unique ID identifying the reference/source.';


--
-- Name: COLUMN data_src.authors; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN data_src.authors IS 'List of authors for a journal article or name of sponsoring organization for other documents.';


--
-- Name: COLUMN data_src.title; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN data_src.title IS 'Title of article or name of document, such as a report from a company or trade association.';


--
-- Name: COLUMN data_src.year; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN data_src.year IS 'Year article or document was published.';


--
-- Name: COLUMN data_src.journal; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN data_src.journal IS 'Name of the journal in which the article was published.';


--
-- Name: COLUMN data_src.vol_city; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN data_src.vol_city IS 'Volume number for journal articles, books, or reports; city where sponsoring organization is located.';


--
-- Name: COLUMN data_src.issue_state; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN data_src.issue_state IS 'Issue number for journal article; State where the sponsoring organization is located.';


--
-- Name: COLUMN data_src.start_page; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN data_src.start_page IS 'Starting page number of article/document.';


--
-- Name: COLUMN data_src.end_page; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN data_src.end_page IS 'Ending page number of article/document.';


--
-- Name: datsrcln; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE datsrcln (
    ndb_no character varying(5) NOT NULL,
    nutr_no character varying(3) NOT NULL,
    datasrc_id character varying(6) NOT NULL
);


-- ALTER TABLE public.datsrcln OWNER TO postgres;

--
-- Name: TABLE datsrcln; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE datsrcln IS 'Used to link
the Nutrient Data table with the Sources of Data table. It is needed to resolve the many-to-
many relationship between the two tables.';


--
-- Name: COLUMN datsrcln.ndb_no; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN datsrcln.ndb_no IS '5-digit Nutrient Databank number that uniquely
identifies a food item. If this field is defined as
numeric, the leading zero will be lost.';


--
-- Name: COLUMN datsrcln.nutr_no; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN datsrcln.nutr_no IS 'Unique 3-digit identifier code for a nutrient.';


--
-- Name: COLUMN datsrcln.datasrc_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN datsrcln.datasrc_id IS 'Unique ID identifying the reference/source.';


--
-- Name: deriv_cd; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE deriv_cd (
    deriv_cd character varying(4) NOT NULL,
    deriv_desc character varying(120) NOT NULL
);


-- ALTER TABLE public.deriv_cd OWNER TO postgres;

--
-- Name: TABLE deriv_cd; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE deriv_cd IS 'Provides information on how the nutrient values were determined. The table contains the
derivation codes and their descriptions.';


--
-- Name: COLUMN deriv_cd.deriv_cd; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN deriv_cd.deriv_cd IS 'Derivation Code.';


--
-- Name: COLUMN deriv_cd.deriv_desc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN deriv_cd.deriv_desc IS 'Description of derivation code giving specific information on how the value was determined.';


--
-- Name: fd_group; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE fd_group (
    fdgrp_cd character varying(4) NOT NULL,
    fdgrp_desc character varying(60) NOT NULL
);


-- ALTER TABLE public.fd_group OWNER TO postgres;

--
-- Name: TABLE fd_group; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE fd_group IS 'A support file to the Food Description table and contains a list of food groups used in SR28
and their descriptions.';


--
-- Name: COLUMN fd_group.fdgrp_cd; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN fd_group.fdgrp_cd IS '4-digit code identifying a food group. Only the first 2
digits are currently assigned. In the future, the last 2
digits may be used. Codes may not be consecutive.';


--
-- Name: COLUMN fd_group.fdgrp_desc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN fd_group.fdgrp_desc IS 'Name of food group.';


--
-- Name: food_des; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE food_des (
    ndb_no character varying(5) NOT NULL,
    fdgrp_cd character varying(4) NOT NULL,
    long_desc character varying(200) NOT NULL,
    shrt_desc character varying(60) NOT NULL,
    comname character varying(100),
    manufacname character varying(65),
    survey character varying(1),
    ref_desc character varying(135),
    refuse numeric(2,0),
    sciname character varying(65),
    n_factor numeric(4,2),
    pro_factor numeric(4,2),
    fat_factor numeric(4,2),
    cho_factor numeric(4,2)
);


-- ALTER TABLE public.food_des OWNER TO postgres;

--
-- Name: TABLE food_des; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE food_des IS 'Contains long and
short descriptions and food group designators for all food items, along with common
names, manufacturer name, scientific name, percentage and description of refuse, and
factors used for calculating protein and kilocalories, if applicable. Items used in the
FNDDS are also identified by value of "Y" in the Survey field.';


--
-- Name: COLUMN food_des.ndb_no; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN food_des.ndb_no IS '5-digit Nutrient Databank number that uniquely
identifies a food item. If this field is defined as
numeric, the leading zero will be lost.';


--
-- Name: COLUMN food_des.fdgrp_cd; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN food_des.fdgrp_cd IS '4-digit code indicating food group to which a food
item belongs.';


--
-- Name: COLUMN food_des.long_desc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN food_des.long_desc IS '200-character description of food item.';


--
-- Name: COLUMN food_des.shrt_desc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN food_des.shrt_desc IS '60-character abbreviated description of food item.
Generated from the 200-character description using
abbreviations in Appendix A. If short description is
longer than 60 characters, additional abbreviations
are made.';


--
-- Name: COLUMN food_des.comname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN food_des.comname IS 'Other names commonly used to describe a food,
including local or regional names for various foods,
for example, "soda" or "pop" for "carbonated
beverages".';


--
-- Name: COLUMN food_des.manufacname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN food_des.manufacname IS 'Indicates the company that manufactured the
product, when appropriate.';


--
-- Name: COLUMN food_des.survey; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN food_des.survey IS 'Indicates if the food item is used in the USDA Food
and Nutrient Database for Dietary Studies (FNDDS)
and thus has a complete nutrient profile for the 65
FNDDS nutrients.';


--
-- Name: COLUMN food_des.ref_desc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN food_des.ref_desc IS 'Description of inedible parts of a food item (refuse),
such as seeds or bone.';


--
-- Name: COLUMN food_des.refuse; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN food_des.refuse IS 'Percentage of refuse.';


--
-- Name: COLUMN food_des.sciname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN food_des.sciname IS 'Scientific name of the food item. Given for the least
processed form of the food (usually raw), if
applicable.';


--
-- Name: COLUMN food_des.n_factor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN food_des.n_factor IS 'Factor for converting nitrogen to protein.';


--
-- Name: COLUMN food_des.pro_factor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN food_des.pro_factor IS 'Factor for calculating calories from protein.';


--
-- Name: COLUMN food_des.fat_factor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN food_des.fat_factor IS 'Factor for calculating calories from fat.';


--
-- Name: COLUMN food_des.cho_factor; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN food_des.cho_factor IS 'Factor for calculating calories from carbohydrate.';


--
-- Name: footnote; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE footnote (
    ndb_no character varying(5) NOT NULL,
    footnt_no character varying(4) NOT NULL,
    footnt_typ character varying(1),
    nutr_no character varying(3),
    footnt_txt character varying(200) NOT NULL
);


-- ALTER TABLE public.footnote OWNER TO postgres;

--
-- Name: TABLE footnote; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE footnote IS 'Contains additional information about the food item, household weight, and nutrient value.';


--
-- Name: COLUMN footnote.ndb_no; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN footnote.ndb_no IS '5-digit Nutrient Databank number that uniquely
identifies a food item. If this field is defined as
numeric, the leading zero will be lost.';


--
-- Name: COLUMN footnote.footnt_no; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN footnote.footnt_no IS 'Sequence number. If a given footnote applies to
more than one nutrient number, the same footnote
number is used. As a result, this table cannot be
indexed and there is no primary key.';


--
-- Name: COLUMN footnote.footnt_typ; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN footnote.footnt_typ IS 'Type of footnote:
D = footnote adding information to the food
description;
M = footnote adding information to measure
description;
N = footnote providing additional information on a
nutrient value. If the Footnt_typ = N, the Nutr_No will
also be filled in.';


--
-- Name: COLUMN footnote.nutr_no; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN footnote.nutr_no IS 'Unique 3-digit identifier code for a nutrient to which
footnote applies.';


--
-- Name: COLUMN footnote.footnt_txt; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN footnote.footnt_txt IS 'Footnote text.';


--
-- Name: langdesc; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE langdesc (
    factor_code character varying(5) NOT NULL,
    description character varying(140) NOT NULL
);


-- ALTER TABLE public.langdesc OWNER TO postgres;

--
-- Name: TABLE langdesc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE langdesc IS 'A support table to the LanguaL Factor table and contains the descriptions for only those
factors used in coding the selected food items codes in this release of SR.';


--
-- Name: COLUMN langdesc.factor_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN langdesc.factor_code IS 'The LanguaL factor from the Thesaurus. Only those
codes used to factor the foods contained in the
LanguaL Factor table are included in this table.';


--
-- Name: COLUMN langdesc.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN langdesc.description IS 'The description of the LanguaL Factor Code from the
thesaurus.';


--
-- Name: langual; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE langual (
    ndb_no character varying(5) NOT NULL,
    factor_code character varying(5) NOT NULL
);


-- ALTER TABLE public.langual OWNER TO postgres;

--
-- Name: TABLE langual; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE langual IS 'Support table to the
Food Description table and contains the factors from the LanguaL Thesaurus used to
code a particular food.';


--
-- Name: COLUMN langual.ndb_no; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN langual.ndb_no IS '5-digit Nutrient Databank number that uniquely
identifies a food item. If this field is defined as
numeric, the leading zero will be lost.';


--
-- Name: COLUMN langual.factor_code; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN langual.factor_code IS 'The LanguaL factor from the Thesaurus.';


--
-- Name: nut_data; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE nut_data (
    ndb_no character varying(5) NOT NULL,
    nutr_no character varying(3) NOT NULL,
    nutr_val numeric(10,3) NOT NULL,
    num_data_pts numeric(5,0) NOT NULL,
    std_error numeric(8,3),
    src_cd character varying(2) NOT NULL,
    deriv_cd character varying(4),
    ref_ndb_no character varying(5),
    add_nutr_mark character varying(1),
    num_studies numeric(2,0),
    min numeric(10,3),
    max numeric(10,3),
    df numeric(4,0),
    low_eb numeric(10,3),
    up_eb numeric(10,3),
    stat_cmt character varying(10),
    addmod_date character varying(10),
    cc character varying(1)
);


-- ALTER TABLE public.nut_data OWNER TO postgres;

--
-- Name: TABLE nut_data; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE nut_data IS 'Contains the nutrient
values and information about the values, including expanded statistical information.';


--
-- Name: COLUMN nut_data.ndb_no; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN nut_data.ndb_no IS '5-digit Nutrient Databank number that uniquely
identifies a food item. If this field is defined as
numeric, the leading zero will be lost.';


--
-- Name: COLUMN nut_data.nutr_no; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN nut_data.nutr_no IS 'Unique 3-digit identifier code for a nutrient.';


--
-- Name: COLUMN nut_data.nutr_val; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN nut_data.nutr_val IS 'Amount in 100 grams, edible portion.';


--
-- Name: COLUMN nut_data.num_data_pts; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN nut_data.num_data_pts IS 'Number of data points is the number of analyses
used to calculate the nutrient value. If the number of
data points is 0, the value was calculated or
imputed.';


--
-- Name: COLUMN nut_data.std_error; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN nut_data.std_error IS 'Standard error of the mean. Null if cannot be
calculated. The standard error is also not given if the
number of data points is less than three.';


--
-- Name: COLUMN nut_data.src_cd; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN nut_data.src_cd IS 'Code indicating type of data.';


--
-- Name: COLUMN nut_data.deriv_cd; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN nut_data.deriv_cd IS 'Data Derivation Code giving specific information on
how the value is determined. This field is populated
only for items added or updated starting with SR14.
This field may not be populated if older records were
used in the calculation of the mean value.';


--
-- Name: COLUMN nut_data.ref_ndb_no; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN nut_data.ref_ndb_no IS 'NDB number of the item used to calculate a missing
value. Populated only for items added or updated
starting with SR14.';


--
-- Name: COLUMN nut_data.add_nutr_mark; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN nut_data.add_nutr_mark IS 'Indicates a vitamin or mineral added for fortification
or enrichment. This field is populated for ready-to-
eat breakfast cereals and many brand-name hot
cereals in food group 08.';


--
-- Name: COLUMN nut_data.num_studies; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN nut_data.num_studies IS 'Number of studies.';


--
-- Name: COLUMN nut_data.min; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN nut_data.min IS 'Minimum value.';


--
-- Name: COLUMN nut_data.max; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN nut_data.max IS 'Maximum value.';


--
-- Name: COLUMN nut_data.df; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN nut_data.df IS 'Degrees of freedom.';


--
-- Name: COLUMN nut_data.low_eb; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN nut_data.low_eb IS 'Lower 95% error bound.';


--
-- Name: COLUMN nut_data.up_eb; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN nut_data.up_eb IS 'Upper 95% error bound.';


--
-- Name: COLUMN nut_data.stat_cmt; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN nut_data.stat_cmt IS 'Statistical comments. See definitions below.';


--
-- Name: COLUMN nut_data.addmod_date; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN nut_data.addmod_date IS 'Indicates when a value was either added to the
database or last modified.';


--
-- Name: COLUMN nut_data.cc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN nut_data.cc IS 'Confidence Code indicating data quality, based on
evaluation of sample plan, sample handling,
analytical method, analytical quality control, and
number of samples analyzed. Not included in this
release, but is planned for future releases.';


--
-- Name: nutr_def; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE nutr_def (
    nutr_no character varying(3) NOT NULL,
    units character varying(7) NOT NULL,
    tagname character varying(20),
    nutrdesc character varying(60) NOT NULL,
    num_dec character varying(1) NOT NULL,
    sr_order numeric(6,0) NOT NULL
);


-- ALTER TABLE public.nutr_def OWNER TO postgres;

--
-- Name: TABLE nutr_def; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE nutr_def IS 'A support table to
the Nutrient Data table. It provides the 3-digit nutrient code, unit of measure, INFOODS
tagname, and description.';


--
-- Name: COLUMN nutr_def.nutr_no; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN nutr_def.nutr_no IS 'Unique 3-digit identifier code for a nutrient.';


--
-- Name: COLUMN nutr_def.units; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN nutr_def.units IS 'Units of measure.';


--
-- Name: COLUMN nutr_def.tagname; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN nutr_def.tagname IS 'International Network of Food Data Systems
(INFOODS) Tagnames.';


--
-- Name: COLUMN nutr_def.nutrdesc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN nutr_def.nutrdesc IS 'Name of nutrient/food component.';


--
-- Name: COLUMN nutr_def.num_dec; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN nutr_def.num_dec IS 'Number of decimal places to which a nutrient value is
rounded.';


--
-- Name: COLUMN nutr_def.sr_order; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN nutr_def.sr_order IS 'Used to sort nutrient records in the same order as
various reports produced from SR.';


--
-- Name: src_cd; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE src_cd (
    src_cd character varying(2) NOT NULL,
    srccd_desc character varying(60) NOT NULL
);


-- ALTER TABLE public.src_cd OWNER TO postgres;

--
-- Name: TABLE src_cd; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE src_cd IS 'Contains codes indicating the type of data (analytical, calculated, assumed zero, and so on) in the Nutrient Data table.
To improve the usability of the database and to provide values for the FNDDS, NDL staff imputed nutrient values for a number
of proximate components, total dietary fiber, total sugar, and vitamin and mineral values.';


--
-- Name: COLUMN src_cd.src_cd; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN src_cd.src_cd IS 'A 2-digit code indicating type of data.';


--
-- Name: COLUMN src_cd.srccd_desc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN src_cd.srccd_desc IS 'Description of source code that identifies the type of nutrient data.';


--
-- Name: weight; Type: TABLE; Schema: public; Owner: postgres; Tablespace:
--

CREATE TABLE weight (
    ndb_no character varying(5) NOT NULL,
    seq character varying(2) NOT NULL,
    amount numeric(6,3) NOT NULL,
    msre_desc character varying(84) NOT NULL,
    gm_wgt numeric(7,1) NOT NULL,
    num_data_pts numeric(4,0),
    std_dev numeric(7,3)
);


-- ALTER TABLE public.weight OWNER TO postgres;

--
-- Name: TABLE weight; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE weight IS 'Contains the weight in grams of
a number of common measures for each food item.';


--
-- Name: COLUMN weight.ndb_no; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weight.ndb_no IS '5-digit Nutrient Databank number that uniquely
identifies a food item. If this field is defined as
numeric, the leading zero will be lost.';


--
-- Name: COLUMN weight.seq; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weight.seq IS 'Sequence number.';


--
-- Name: COLUMN weight.amount; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weight.amount IS 'Unit modifier (for example, 1 in "1 cup").';


--
-- Name: COLUMN weight.msre_desc; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weight.msre_desc IS 'Description (for example, cup, diced, and 1-inch pieces).';


--
-- Name: COLUMN weight.gm_wgt; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weight.gm_wgt IS 'Gram weight.';


--
-- Name: COLUMN weight.num_data_pts; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weight.num_data_pts IS 'Number of data points.';


--
-- Name: COLUMN weight.std_dev; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN weight.std_dev IS 'Standard deviation.';


--
-- Data for Name: data_src; Type: TABLE DATA; Schema: public; Owner: postgres
--
