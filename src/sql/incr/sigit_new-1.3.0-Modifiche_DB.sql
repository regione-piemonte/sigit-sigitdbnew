DROP VIEW vista_ricerca_allegati;


create table sigit_t_libretto_20150131 as select * from sigit_t_libretto;

create table sigit_t_allegato_20150131 as select * from sigit_t_allegato;

create table sigit_t_all_respinto_20150131 as select * from sigit_t_all_respinto;



ALTER TABLE sigit_t_libretto DROP COLUMN xml_libretto;


CREATE TABLE sigit_t_lib_txt
(
	id_libretto           NUMERIC  NOT NULL ,
	xml_libretto          text  NULL 
);



ALTER TABLE sigit_t_lib_txt
	ADD CONSTRAINT  PK_sigit_t_lib_txt PRIMARY KEY (id_libretto);



ALTER TABLE sigit_t_lib_txt
	ADD CONSTRAINT  fk_sigit_t_libretto_02 FOREIGN KEY (id_libretto) REFERENCES sigit_t_libretto(id_libretto);




ALTER TABLE sigit_t_allegato DROP COLUMN xml_allegato;

CREATE TABLE sigit_t_all_txt
(
	id_allegato           NUMERIC  NOT NULL ,
	xml_allegato          text  NULL 
);



ALTER TABLE sigit_t_all_txt
	ADD CONSTRAINT  PK_sigit_t_all_txt PRIMARY KEY (id_allegato);



ALTER TABLE sigit_t_all_txt
	ADD CONSTRAINT  FK_sigit_t_allegato_07 FOREIGN KEY (id_allegato) REFERENCES sigit_t_allegato(id_allegato);


ALTER TABLE sigit_t_all_respinto DROP COLUMN xml_allegato;

CREATE TABLE sigit_t_allresp_txt
(
	data_controllo        DATE  NOT NULL ,
	id_imp_ruolo_pfpg     NUMERIC  NOT NULL ,
	id_allegato           NUMERIC  NOT NULL ,
	xml_allegato          text  NULL 
);



ALTER TABLE sigit_t_allresp_txt
	ADD CONSTRAINT  PK_sigit_t_allresp_txt PRIMARY KEY (data_controllo,id_imp_ruolo_pfpg,id_allegato);



ALTER TABLE sigit_t_allresp_txt
	ADD CONSTRAINT  fk_sigit_t_all_respinto_02 FOREIGN KEY (data_controllo,id_imp_ruolo_pfpg,id_allegato) REFERENCES sigit_t_all_respinto(data_controllo,id_imp_ruolo_pfpg,id_allegato);



CREATE TABLE sigit_t_imp_xml
(
	id_import             INTEGER  NOT NULL ,
	file_import           text  NULL 
);



ALTER TABLE sigit_t_imp_xml
	ADD CONSTRAINT  PK_sigit_t_imp_xml PRIMARY KEY (id_import);




CREATE TABLE sigit_t_import
(
	id_import             INTEGER  NOT NULL ,
	data_inizio           TIMESTAMP  NULL ,
	data_fine             TIMESTAMP  NULL ,
	nome_file_import      CHARACTER VARYING(100)  NULL ,
	flg_esito             NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_esito CHECK (flg_esito IN (0,1)),
	codice_impianto       NUMERIC  NULL ,
	fk_pre_import         INTEGER  NOT NULL ,
	fk_allegato           NUMERIC  NULL,
	msg_errore            CHARACTER VARYING(1000)  NULL  
);



ALTER TABLE sigit_t_import
	ADD CONSTRAINT  PK_sigit_t_import PRIMARY KEY (id_import);




CREATE TABLE sigit_t_pre_import
(
	id_pre_import         INTEGER  NOT NULL ,
	n_file                INTEGER  NULL ,
	msg                   CHARACTER VARYING(2000)  NULL ,
	data_ult_mod          TIMESTAMP  NULL ,
	utente_ult_mod        CHARACTER VARYING(16)  NULL ,
	id_persona_fisica     NUMERIC(6)  NOT NULL 
);



ALTER TABLE sigit_t_pre_import
	ADD CONSTRAINT  PK_sigit_t_pre_import PRIMARY KEY (id_pre_import);



CREATE TABLE sigit_tmp_libretto
(
	id_libretto           NUMERIC  NOT NULL ,
	flg_elaborato         NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_elab CHECK (flg_elaborato IN (0,1)),
	flg_esito_elab        NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_esel CHECK (flg_esito_elab IN (0,1)),
	data_elab             TIMESTAMP  NULL 
);



ALTER TABLE sigit_tmp_libretto
	ADD CONSTRAINT  PK_sigit_tmp_libretto PRIMARY KEY (id_libretto);



ALTER TABLE sigit_t_imp_xml
	ADD CONSTRAINT  fk_sigit_t_import_01 FOREIGN KEY (id_import) REFERENCES sigit_t_import(id_import);


ALTER TABLE sigit_t_import
	ADD CONSTRAINT  fk_sigit_t_pre_import_01 FOREIGN KEY (fk_pre_import) REFERENCES sigit_t_pre_import(id_pre_import);



ALTER TABLE sigit_t_import
	ADD CONSTRAINT  FK_sigit_t_allegato_06 FOREIGN KEY (fk_allegato) REFERENCES sigit_t_allegato(id_allegato);





ALTER TABLE sigit_t_pre_import
	ADD CONSTRAINT  FK_sigit_t_persona_fisica_05 FOREIGN KEY (id_persona_fisica) REFERENCES sigit_t_persona_fisica(id_persona_fisica);




CREATE SEQUENCE seq_t_pre_import
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
  
  
CREATE SEQUENCE seq_t_import
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;  
  


INSERT INTO sigit_wrk_config(id_config, chiave_config, valore_config_num, valore_config_char,valore_flag)
    VALUES (6, 'MAX_LIBRETTI_DA_ELABORARE',5,null,null);



