/*
* This is mostlyl a blatant cut from the PostgreSQL database dump
* in the https://github.com/Adyg/usdanl-sr28-postgresql repository.
*
* A few missing constraints have been added and corrected to facilitate
* automatic ER diagram generation in code, anlytics tools, etc.
*
* These new constraints (all FK's currently) are at bottom of this script.
*
*/

--
-- Name: data_src_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY data_src
    ADD CONSTRAINT data_src_pkey PRIMARY KEY (datasrc_id);


--
-- Name: datsrcln_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY datsrcln
    ADD CONSTRAINT datsrcln_pkey PRIMARY KEY (ndb_no, nutr_no, datasrc_id);


--
-- Name: deriv_cd_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY deriv_cd
    ADD CONSTRAINT deriv_cd_pkey PRIMARY KEY (deriv_cd);


--
-- Name: fd_group_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY fd_group
    ADD CONSTRAINT fd_group_pkey PRIMARY KEY (fdgrp_cd);


--
-- Name: food_des_ndb_no_fdgrp_cd_key; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY food_des
    ADD CONSTRAINT food_des_ndb_no_fdgrp_cd_key UNIQUE (ndb_no, fdgrp_cd);


--
-- Name: food_des_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY food_des
    ADD CONSTRAINT food_des_pkey PRIMARY KEY (ndb_no);


--
-- Name: langdesc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY langdesc
    ADD CONSTRAINT langdesc_pkey PRIMARY KEY (factor_code);


--
-- Name: langual_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY langual
    ADD CONSTRAINT langual_pkey PRIMARY KEY (ndb_no, factor_code);


--
-- Name: nut_data_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY nut_data
    ADD CONSTRAINT nut_data_pkey PRIMARY KEY (ndb_no, nutr_no);


--
-- Name: nutr_def_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY nutr_def
    ADD CONSTRAINT nutr_def_pkey PRIMARY KEY (nutr_no);


--
-- Name: src_cd_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY src_cd
    ADD CONSTRAINT src_cd_pkey PRIMARY KEY (src_cd);


--
-- Name: weight_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace:
--

ALTER TABLE ONLY weight
    ADD CONSTRAINT weight_pkey PRIMARY KEY (ndb_no, seq);


--
-- Name: datsrcln_datasrc_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY datsrcln
    ADD CONSTRAINT datsrcln_datasrc_id_fkey FOREIGN KEY (datasrc_id) REFERENCES data_src(datasrc_id);

--
-- Name: food_des_fdgrp_cd_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY food_des
    ADD CONSTRAINT food_des_fdgrp_cd_fkey FOREIGN KEY (fdgrp_cd) REFERENCES fd_group(fdgrp_cd);


--
-- Name: langual_factor_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY langual
    ADD CONSTRAINT langual_factor_code_fkey FOREIGN KEY (factor_code) REFERENCES langdesc(factor_code);


--
-- Name: langual_ndb_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY langual
    ADD CONSTRAINT langual_ndb_no_fkey FOREIGN KEY (ndb_no) REFERENCES food_des(ndb_no);


--
-- Name: nut_data_ndb_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nut_data
    ADD CONSTRAINT nut_data_ndb_no_fkey FOREIGN KEY (ndb_no) REFERENCES food_des(ndb_no);


--
-- Name: nut_data_nutr_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nut_data
    ADD CONSTRAINT nut_data_nutr_no_fkey FOREIGN KEY (nutr_no) REFERENCES nutr_def(nutr_no);


--
-- Name: weight_ndb_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY weight
    ADD CONSTRAINT weight_ndb_no_fkey FOREIGN KEY (ndb_no) REFERENCES food_des(ndb_no);

--
-- New constraints follow
--
ALTER TABLE ONLY nut_data
    ADD CONSTRAINT nut_data_src_cd_fkey FOREIGN KEY (src_cd) REFERENCES src_cd(src_cd);

ALTER TABLE ONLY nut_data
    ADD CONSTRAINT nut_data_deriv_cd_fkey FOREIGN KEY (deriv_cd) REFERENCES deriv_cd(deriv_cd);

ALTER TABLE ONLY footnote
    ADD CONSTRAINT footnote_deriv_cd_fkey FOREIGN KEY (ndb_no) REFERENCES food_des(ndb_no);

ALTER TABLE ONLY footnote
    ADD CONSTRAINT footnote_nutr_no_fkey FOREIGN KEY (nutr_no) REFERENCES nutr_def(nutr_no);

ALTER TABLE ONLY datsrcln
    ADD CONSTRAINT datsrcln_nut_data_fkey FOREIGN KEY (ndb_no, nutr_no) REFERENCES nut_data(ndb_no, nutr_no);
