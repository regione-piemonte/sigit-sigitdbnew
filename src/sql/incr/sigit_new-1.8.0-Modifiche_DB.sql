ALTER TABLE sigit_t_impianto ALTER COLUMN data_assegnazione SET NOT NULL;

ALTER TABLE sigit_t_allegato  ADD COLUMN motivo_respinta character varying(500);

ALTER TABLE sigit_t_unita_immobiliare ADD COLUMN flg_noaccatastato NUMERIC(1)  NULL  
	CONSTRAINT  dom_noac_01 CHECK (flg_noaccatastato IN (0,1));

ALTER TABLE sigit_t_impianto   ADD COLUMN note character varying(1000);

ALTER TABLE sigit_t_persona_giuridica ADD COLUMN flg_cat NUMERIC(1)  NULL  CONSTRAINT  dom_cat_01 CHECK (flg_cat IN (0,1));

CREATE TABLE sigit_r_pg_pg_nomina
(
	id_persona_giuridica_cat  NUMERIC(6)  NOT NULL ,
	id_persona_giuridica_impresa  NUMERIC(6)  NOT NULL ,
	data_inizio           DATE  NOT NULL ,
	data_fine             DATE  NULL,
	data_ultima_modifica date,
	utente_ultima_modifica character varying(50)	  
);

ALTER TABLE sigit_r_pg_pg_nomina
	ADD CONSTRAINT  PK_sigit_r_pg_pg_nomina PRIMARY KEY (id_persona_giuridica_cat,id_persona_giuridica_impresa,data_inizio);


ALTER TABLE sigit_r_pg_pg_nomina
	ADD CONSTRAINT  FK_sigit_t_pers_giuridica_10 FOREIGN KEY (id_persona_giuridica_cat) REFERENCES sigit_t_persona_giuridica(id_persona_giuridica);

ALTER TABLE sigit_r_pg_pg_nomina
	ADD CONSTRAINT  FK_sigit_t_pers_giuridica_11 FOREIGN KEY (id_persona_giuridica_impresa) REFERENCES sigit_t_persona_giuridica(id_persona_giuridica);



ALTER TABLE sigit_wrk_ruolo_funz  ADD COLUMN flg_incarichi_cat     NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_incat CHECK (flg_incarichi_cat IN (0,1));


INSERT INTO sigit_d_fluido(id_fluido, des_fluido) VALUES (99,'Altro');


ALTER TABLE sigit_t_dett_tipo3 DROP CONSTRAINT fk_sigit_d_combustibile_04;


update sigit_t_dett_tipo3 set fk_fluido_alimentaz=99 where fk_fluido_alimentaz<>99;


ALTER TABLE sigit_t_dett_tipo3
  ADD CONSTRAINT fk_sigit_d_fluido_06 FOREIGN KEY (fk_fluido_alimentaz)
      REFERENCES sigit_d_fluido (id_fluido) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION; 




