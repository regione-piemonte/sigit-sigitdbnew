ALTER TABLE sigit_t_persona_giuridica add column flg_distributore  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_distr CHECK (flg_distributore IN (0,1));



CREATE TABLE sigit_d_stato_distrib
(
	id_stato_distrib      INTEGER  NOT NULL ,
	des_stato_distrib     CHARACTER VARYING(100)  NOT NULL 
);

ALTER TABLE sigit_d_stato_distrib
	ADD CONSTRAINT  PK_sigit_d_stato_distrib PRIMARY KEY (id_stato_distrib);



CREATE TABLE sigit_t_import_distrib
(
	id_import_distrib     INTEGER  NOT NULL ,
	fk_persona_giuridica  NUMERIC(6)  NOT NULL ,
	fk_stato_distrib      INTEGER  NOT NULL ,
	data_inizio_elab      TIMESTAMP  NULL ,
	data_fine_elab        TIMESTAMP  NULL ,
	data_annullamento     TIMESTAMP  NULL ,
	nome_file_import      CHARACTER VARYING(100)  NULL ,
	uid_index             CHARACTER VARYING(50)  NULL  ,
	anno_riferimento      NUMERIC(4)  NULL ,
	data_invio_mail_distrib TIMESTAMP,
  data_invio_mail_assistenza TIMESTAMP,
  tot_record_elaborati numeric(10,0),
  tot_record_scartati numeric(10,0)
);

ALTER TABLE sigit_t_import_distrib
	ADD CONSTRAINT  PK_sigit_t_import_distrib PRIMARY KEY (id_import_distrib);



CREATE TABLE sigit_t_log_distrib
(
	id_log_distrib        INTEGER  NOT NULL ,
	fk_import_distrib   INTEGER  NOT NULL ,
	msg_errore            CHARACTER VARYING(1000)  NULL 
);

ALTER TABLE sigit_t_log_distrib
	ADD CONSTRAINT  PK_sigit_t_log_distrib PRIMARY KEY (id_log_distrib);



ALTER TABLE sigit_t_import_distrib
	ADD CONSTRAINT  FK_sigit_t_pers_giuridica_09 FOREIGN KEY (fk_persona_giuridica) REFERENCES sigit_t_persona_giuridica(id_persona_giuridica);


ALTER TABLE sigit_t_import_distrib
	ADD CONSTRAINT  fk_sigit_d_stato_distrib_01 FOREIGN KEY (fk_stato_distrib) REFERENCES sigit_d_stato_distrib(id_stato_distrib);


ALTER TABLE sigit_t_log_distrib
	ADD CONSTRAINT  fk_sigit_t_import_distrib_01 FOREIGN KEY (fk_import_distrib) REFERENCES sigit_t_import_distrib(id_import_distrib);



alter TABLE sigit_wrk_ruolo_funz add column flg_distributori NUMERIC(1)  NULL  CONSTRAINT  flg_distributori CHECK (flg_distributori IN (0,1));



CREATE SEQUENCE seq_t_import_distrib
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;



CREATE SEQUENCE seq_t_log_distrib
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;





CREATE TABLE sigit_d_assenza_catast
(
	codice_assenza_catast  INTEGER  NOT NULL ,
	des_assenza_catast    CHARACTER VARYING(100)  NULL 
);

ALTER TABLE sigit_d_assenza_catast
	ADD CONSTRAINT  PK_sigit_d_assenza_catast PRIMARY KEY (codice_assenza_catast);



CREATE TABLE sigit_d_categoria_util
(
	id_categoria_util     CHARACTER VARYING(5)  NOT NULL ,
	des_categoria_util    CHARACTER VARYING(100)  NULL 
);

ALTER TABLE sigit_d_categoria_util
	ADD CONSTRAINT  PK_sigit_d_categoria_util PRIMARY KEY (id_categoria_util);



CREATE TABLE sigit_d_tipo_contratto_distrib
(
	id_tipo_contratto_distrib     INTEGER  NOT NULL ,
	des_tipo_contratto_distrib    CHARACTER VARYING(100)  NULL 
);

ALTER TABLE sigit_d_tipo_contratto_distrib
	ADD CONSTRAINT  PK_sigit_d_tipo_contratto_distrib PRIMARY KEY (id_tipo_contratto_distrib);



CREATE TABLE sigit_t_dato_distrib
(
	id_dato_distrib       INTEGER  NOT NULL ,
	fk_tipo_contratto     INTEGER  NOT NULL ,
	fk_import_distrib     INTEGER  NOT NULL ,
	fk_categoria_util     CHARACTER VARYING(5)  NOT NULL ,
	fk_combustibile       NUMERIC  NOT NULL ,
	codice_assenza_catast  INTEGER  NULL ,
	fk_unita_misura       CHARACTER VARYING(10)  NOT NULL ,
	flg_pf_pg             CHARACTER VARYING(2)  NOT NULL  CONSTRAINT  flg_pf_pg CHECK (flg_pf_pg IN ('PF','PG')),
	cognome_denom         CHARACTER VARYING(500)  NOT NULL ,
	nome                  CHARACTER VARYING(100)  NULL ,
	cf_piva               CHARACTER VARYING(16)  NOT NULL ,
	anno_rif              NUMERIC(4)  NOT NULL ,
	nr_mesi_fattur        NUMERIC(2)  NOT NULL ,
	dug                   CHARACTER VARYING(20)  NOT NULL ,
	indirizzo             CHARACTER VARYING(100)  NOT NULL ,
	civico                CHARACTER VARYING(10)  NOT NULL ,
	cap                   CHARACTER VARYING(5)  NULL ,
	istat_comune          CHARACTER VARYING(6)  NULL ,
	pod_pdr               CHARACTER VARYING(20)  NULL ,
	consumo_anno          NUMERIC  NOT NULL ,
	consumo_mensile       NUMERIC  NULL ,
	mese_riferimento      NUMERIC(2)  NULL ,
	consumo_giornaliero   NUMERIC  NULL ,
	giorno_riferimento    DATE  NULL ,
	volumetria            NUMERIC  NULL 
);

ALTER TABLE sigit_t_dato_distrib
	ADD CONSTRAINT  PK_sigit_t_dato_distrib PRIMARY KEY (id_dato_distrib);



CREATE TABLE sigit_t_rif_catast
(
	id_rif_catast         INTEGER  NOT NULL ,
	fk_dato_distrib       INTEGER  NOT NULL ,
	sezione               CHARACTER VARYING(5)  NULL ,
	foglio                CHARACTER VARYING(5)  NULL ,
	particella            CHARACTER VARYING(9)  NULL ,
	subalterno            CHARACTER VARYING(4)  NULL 
);

ALTER TABLE sigit_t_rif_catast
	ADD CONSTRAINT  PK_sigit_t_rif_catast PRIMARY KEY (id_rif_catast);





ALTER TABLE sigit_t_dato_distrib
	ADD CONSTRAINT  fk_sigit_t_import_distrib_02 FOREIGN KEY (fk_import_distrib) REFERENCES sigit_t_import_distrib(id_import_distrib);


ALTER TABLE sigit_t_dato_distrib
	ADD CONSTRAINT  fk_sigit_d_assenza_catast_01 FOREIGN KEY (codice_assenza_catast) REFERENCES sigit_d_assenza_catast(codice_assenza_catast);


ALTER TABLE sigit_t_dato_distrib
	ADD CONSTRAINT  fk_sigit_d_tipo_contr_distr_01 FOREIGN KEY (fk_tipo_contratto) REFERENCES sigit_d_tipo_contratto_distrib(id_tipo_contratto_distrib);


ALTER TABLE sigit_t_dato_distrib
	ADD CONSTRAINT  fk_sigit_d_categoria_util_01 FOREIGN KEY (fk_categoria_util) REFERENCES sigit_d_categoria_util(id_categoria_util);


ALTER TABLE sigit_t_dato_distrib
	ADD CONSTRAINT  fk_sigit_d_combustibile_08 FOREIGN KEY (fk_combustibile) REFERENCES sigit_d_combustibile(id_combustibile);


ALTER TABLE sigit_t_dato_distrib
	ADD CONSTRAINT  FK_sigit_d_unita_misura_03 FOREIGN KEY (fk_unita_misura) REFERENCES sigit_d_unita_misura(id_unita_misura);


ALTER TABLE sigit_t_rif_catast
	ADD CONSTRAINT  fk_sigit_t_dato_distrib_01 FOREIGN KEY (fk_dato_distrib) REFERENCES sigit_t_dato_distrib(id_dato_distrib);



CREATE SEQUENCE seq_t_dato_distrib
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;


CREATE SEQUENCE seq_t_rif_catast
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;



GRANT SELECT,UPDATE,INSERT,DELETE,TRUNCATE ON ALL TABLES IN SCHEMA sigit_new TO sigit_new_rw;

GRANT SELECT,UPDATE ON ALL SEQUENCES IN SCHEMA sigit_new TO sigit_new_rw;

