-----------------------------------------------------------------------------------
-- Modifica richiesta da Todaro (via mail), effettuata in SVI e TST  - 22/10/2018
-----------------------------------------------------------------------------------
ALTER TABLE sigit_wrk_config
   ALTER COLUMN valore_config_char TYPE character varying(100);


-----------------------------------------------------------------------------------
-- Modifica richiesta da Actis (via mail), effettuata in SVI e TST  - 06/04/2018
-----------------------------------------------------------------------------------

ALTER TABLE sigit_t_dett_tipo1 ADD COLUMN e_controlloweb timestamp without time zone;
ALTER TABLE sigit_t_dett_tipo2 ADD COLUMN e_controlloweb timestamp without time zone;
ALTER TABLE sigit_t_dett_tipo3 ADD COLUMN e_controlloweb timestamp without time zone;
ALTER TABLE sigit_t_dett_tipo4 ADD COLUMN e_controlloweb timestamp without time zone;

ALTER TABLE sigit_t_comp_cg ADD COLUMN alimentazione CHARACTER VARYING(100) ;
ALTER TABLE sigit_t_comp_cg ADD COLUMN note  CHARACTER VARYING(1000) ;
ALTER TABLE sigit_t_comp_cg ADD COLUMN tempo_manut_anni numeric ;

ALTER TABLE sigit_t_comp_gf ADD COLUMN note  CHARACTER VARYING(1000) ;
ALTER TABLE sigit_t_comp_gf ADD COLUMN tempo_manut_anni numeric ;

ALTER TABLE sigit_t_comp_sc ADD COLUMN nome_proprietario CHARACTER VARYING(50) ;
ALTER TABLE sigit_t_comp_sc ADD COLUMN cf_proprietario CHARACTER VARYING(16) ;
ALTER TABLE sigit_t_comp_sc ADD COLUMN note  CHARACTER VARYING(1000) ;
ALTER TABLE sigit_t_comp_sc ADD COLUMN tempo_manut_anni numeric ;

ALTER TABLE sigit_t_comp_gt ADD COLUMN note  CHARACTER VARYING(1000) ;
ALTER TABLE sigit_t_comp_gt ADD COLUMN tempo_manut_anni numeric ;


ALTER TABLE sigit_t_controllo_libretto ADD COLUMN dt_ult_mod timestamp without time zone;
ALTER TABLE sigit_t_controllo_libretto ADD COLUMN utente_ult_agg CHARACTER VARYING(16);



CREATE TABLE sigit_t_motivo_variazione_lib
(
	codice_impianto       NUMERIC  NOT NULL  CONSTRAINT  dom_0_1 CHECK (codice_impianto IN (0,1)),
	dt_modifica           TIMESTAMP  NOT NULL ,
	scheda_modificata     CHARACTER VARYING(20)  NULL ,
	motivo_modifica       CHARACTER VARYING(1000)  NULL 
);

ALTER TABLE sigit_t_motivo_variazione_lib
	ADD CONSTRAINT  PK_sigit_t_motivo_variazione_l PRIMARY KEY (codice_impianto,dt_modifica);

ALTER TABLE sigit_t_motivo_variazione_lib
	ADD CONSTRAINT  fk_sigit_t_controllo_libr_01 FOREIGN KEY (codice_impianto) REFERENCES sigit_t_controllo_libretto(codice_impianto);


ALTER TABLE sigit_t_allegato ADD COLUMN abcdf_controlloweb timestamp without time zone;


UPDATE sigit_t_comp_vx SET pressione_bar = REPLACE(pressione_bar, ',','.');
alter table sigit_t_comp_vx alter column pressione_bar type numeric using cast(pressione_bar as numeric);




--------------------------------------------------------------------------------
-- Modifica richiesta da Actis (via mail), effettuata in SVI e TST  - 29/05/2018
---------------------------------------------------------------------------------

ALTER TABLE sigit_t_dett_tipo1 ADD COLUMN e_nox_mg_kwh numeric;





-------------------------------------------------------------------------------------
--  Trattamento richiesto da Actis (via mail), effettuata in SVI e TST  - 13/06/2018
--------------------------------------------------------------------------------------

INSERT INTO sigit_d_dettaglio_vm(id_dettaglio_vm, des_dettaglio_vm) VALUES (4, 'Altro');

update sigit_t_comp_vm set fk_dettaglio_vm = 4 where altro_tipologia is not null and fk_dettaglio_vm is null and altro_tipologia <> '';




----------------------------------------------------------------------------------------
--  Modifica viste richiesta da Todaro (via mail), effettuata in SVI e TST  - 19/06/2018
-----------------------------------------------------------------------------------------

DROP VIEW vista_sk4_cg;

CREATE OR REPLACE VIEW vista_sk4_cg AS 
 SELECT DISTINCT sigit_t_comp_cg.codice_impianto, 
    sigit_t_comp_cg.id_tipo_componente, sigit_t_comp_cg.progressivo, 
    sigit_t_comp_cg.data_install, sigit_t_comp_cg.data_dismiss, 
    sigit_t_comp_cg.tempo_manut_anni,    
    sigit_t_comp_cg.matricola, sigit_t_comp_cg.fk_marca, 
    sigit_d_marca.des_marca, sigit_d_combustibile.id_combustibile, 
    sigit_d_combustibile.des_combustibile, sigit_t_comp_cg.modello, 
    sigit_t_comp_cg.potenza_termica_kw, sigit_t_comp_cg.data_ult_mod, 
    sigit_t_comp_cg.utente_ult_mod, sigit_t_comp_cg.tipologia, 
    sigit_t_comp_cg.potenza_elettrica_kw, sigit_t_comp_cg.temp_h2o_out_min, 
    sigit_t_comp_cg.temp_h2o_out_max, sigit_t_comp_cg.temp_h2o_in_min, 
    sigit_t_comp_cg.temp_h2o_in_max, sigit_t_comp_cg.temp_h2o_motore_min, 
    sigit_t_comp_cg.temp_h2o_motore_max, sigit_t_comp_cg.temp_fumi_valle_min, 
    sigit_t_comp_cg.temp_fumi_valle_max, sigit_t_comp_cg.temp_fumi_monte_min, 
    sigit_t_comp_cg.temp_fumi_monte_max, sigit_t_comp_cg.co_min, 
    sigit_t_comp_cg.co_max, sigit_t_comp_cg.flg_dismissione, 
    sigit_t_allegato.data_controllo,
    sigit_t_allegato.id_allegato
   FROM sigit_t_comp_cg
   LEFT JOIN sigit_d_marca ON sigit_t_comp_cg.fk_marca = sigit_d_marca.id_marca
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp_cg.fk_combustibile = sigit_d_combustibile.id_combustibile
   LEFT JOIN sigit_t_dett_tipo4 ON sigit_t_dett_tipo4.codice_impianto = sigit_t_comp_cg.codice_impianto AND sigit_t_dett_tipo4.fk_tipo_componente::text = sigit_t_comp_cg.id_tipo_componente::text AND sigit_t_dett_tipo4.progressivo = sigit_t_comp_cg.progressivo AND sigit_t_dett_tipo4.data_install = sigit_t_comp_cg.data_install
   LEFT JOIN sigit_t_allegato ON sigit_t_dett_tipo4.fk_allegato = sigit_t_allegato.id_allegato;
   
   
   
   
DROP VIEW vista_sk4_gf;

CREATE OR REPLACE VIEW vista_sk4_gf AS 
 SELECT DISTINCT sigit_t_comp_gf.codice_impianto, 
    sigit_t_comp_gf.id_tipo_componente, sigit_t_comp_gf.progressivo, 
    sigit_t_comp_gf.data_install, 
    sigit_t_comp_gf.tempo_manut_anni,
    sigit_t_comp_gf.matricola, 
    sigit_t_comp_gf.fk_marca, sigit_d_marca.des_marca, 
    sigit_d_combustibile.id_combustibile, sigit_d_combustibile.des_combustibile, 
    sigit_t_comp_gf.fk_dettaglio_gf, sigit_d_dettaglio_gf.des_dettaglio_gf, 
    sigit_t_comp_gf.modello, sigit_t_comp_gf.flg_sorgente_ext, 
    sigit_t_comp_gf.flg_fluido_utenze, sigit_t_comp_gf.fluido_frigorigeno, 
    sigit_t_comp_gf.n_circuiti, sigit_t_comp_gf.raffrescamento_eer, 
    sigit_t_comp_gf.raff_potenza_kw, sigit_t_comp_gf.raff_potenza_ass, 
    sigit_t_comp_gf.riscaldamento_cop, sigit_t_comp_gf.risc_potenza_kw, 
    sigit_t_comp_gf.risc_potenza_ass_kw, sigit_t_comp_gf.flg_dismissione, 
    sigit_t_comp_gf.data_dismiss, sigit_t_comp_gf.data_ult_mod, 
    sigit_t_comp_gf.utente_ult_mod, sigit_t_comp_gf.potenza_termica_kw, 
    sigit_t_allegato.data_controllo, sigit_t_allegato.id_allegato
   FROM sigit_t_comp_gf
   LEFT JOIN sigit_d_marca ON sigit_t_comp_gf.fk_marca = sigit_d_marca.id_marca
   LEFT JOIN sigit_d_dettaglio_gf ON sigit_t_comp_gf.fk_dettaglio_gf = sigit_d_dettaglio_gf.id_dettaglio_gf
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp_gf.fk_combustibile = sigit_d_combustibile.id_combustibile
   LEFT JOIN sigit_t_dett_tipo2 ON sigit_t_dett_tipo2.codice_impianto = sigit_t_comp_gf.codice_impianto AND sigit_t_dett_tipo2.fk_tipo_componente::text = sigit_t_comp_gf.id_tipo_componente::text AND sigit_t_dett_tipo2.progressivo = sigit_t_comp_gf.progressivo AND sigit_t_dett_tipo2.data_install = sigit_t_comp_gf.data_install
   LEFT JOIN sigit_t_allegato ON sigit_t_dett_tipo2.fk_allegato = sigit_t_allegato.id_allegato; 
   
   
   
 DROP VIEW vista_sk4_gt;
CREATE OR REPLACE VIEW vista_sk4_gt AS 
 SELECT DISTINCT sigit_t_comp_gt.codice_impianto, 
    sigit_t_comp_gt.id_tipo_componente, sigit_t_comp_gt.progressivo, 
    sigit_t_comp_gt.data_install, sigit_t_comp_gt.data_dismiss,
    sigit_t_comp_gt.tempo_manut_anni, 
    sigit_t_comp_gt.matricola, sigit_t_comp_gt.fk_marca, 
    sigit_d_marca.des_marca, sigit_d_combustibile.id_combustibile, 
    sigit_d_combustibile.des_combustibile, sigit_t_comp_gt.fk_fluido, 
    sigit_d_fluido.des_fluido, sigit_t_comp_gt.fk_dettaglio_gt, 
    sigit_d_dettaglio_gt.des_dettaglio_gt, sigit_t_comp_gt.modello, 
    sigit_t_comp_gt.potenza_termica_kw, sigit_t_comp_gt.data_ult_mod, 
    sigit_t_comp_gt.utente_ult_mod, sigit_t_comp_gt.rendimento_perc, 
    sigit_t_comp_gt.n_moduli, sigit_t_comp_gt.flg_dismissione, 
    sigit_t_allegato.data_controllo, sigit_t_allegato.id_allegato
   FROM sigit_t_comp_gt
   LEFT JOIN sigit_d_marca ON sigit_t_comp_gt.fk_marca = sigit_d_marca.id_marca
   LEFT JOIN sigit_d_fluido ON sigit_t_comp_gt.fk_fluido = sigit_d_fluido.id_fluido
   LEFT JOIN sigit_d_dettaglio_gt ON sigit_t_comp_gt.fk_dettaglio_gt = sigit_d_dettaglio_gt.id_dettaglio_gt
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp_gt.fk_combustibile = sigit_d_combustibile.id_combustibile
   LEFT JOIN sigit_t_dett_tipo1 ON sigit_t_dett_tipo1.codice_impianto = sigit_t_comp_gt.codice_impianto AND sigit_t_dett_tipo1.fk_tipo_componente::text = sigit_t_comp_gt.id_tipo_componente::text AND sigit_t_dett_tipo1.progressivo = sigit_t_comp_gt.progressivo AND sigit_t_dett_tipo1.data_install = sigit_t_comp_gt.data_install
   LEFT JOIN sigit_t_allegato ON sigit_t_dett_tipo1.fk_allegato = sigit_t_allegato.id_allegato;
   
   
   
   
 DROP VIEW vista_sk4_sc;        
CREATE OR REPLACE VIEW vista_sk4_sc AS 
 SELECT DISTINCT sigit_t_comp_sc.codice_impianto, 
    sigit_t_comp_sc.id_tipo_componente, sigit_t_comp_sc.progressivo, 
    sigit_t_comp_sc.data_install,
    sigit_t_comp_sc.tempo_manut_anni,      
    sigit_t_comp_sc.flg_dismissione, 
    sigit_t_comp_sc.data_dismiss, sigit_t_comp_sc.data_ult_mod, 
    sigit_t_comp_sc.utente_ult_mod, sigit_t_comp_sc.matricola, 
    sigit_t_comp_sc.modello, sigit_t_comp_sc.potenza_termica_kw, 
    sigit_t_comp_sc.fk_marca, sigit_d_marca.des_marca, 
    sigit_t_allegato.data_controllo, sigit_t_allegato.id_allegato
   FROM sigit_t_comp_sc
   LEFT JOIN sigit_d_marca ON sigit_t_comp_sc.fk_marca = sigit_d_marca.id_marca
   LEFT JOIN sigit_t_dett_tipo3 ON sigit_t_dett_tipo3.codice_impianto = sigit_t_comp_sc.codice_impianto AND sigit_t_dett_tipo3.fk_tipo_componente::text = sigit_t_comp_sc.id_tipo_componente::text AND sigit_t_dett_tipo3.progressivo = sigit_t_comp_sc.progressivo AND sigit_t_dett_tipo3.data_install = sigit_t_comp_sc.data_install
   LEFT JOIN sigit_t_allegato ON sigit_t_dett_tipo3.fk_allegato = sigit_t_allegato.id_allegato;   
   
   
   
   

--------------------------------------------------------------------------------------------
--  Nuove viste richieste da Todaro (telefonicamente), effettuate in SVI e TST  - 28/06/2018
---------------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW vista_comp_cg AS 
 SELECT sigit_t_comp_cg.codice_impianto, sigit_t_comp_cg.id_tipo_componente, 
    sigit_t_comp_cg.progressivo, sigit_t_comp_cg.data_install, 
    sigit_t_comp_cg.tipologia, sigit_t_comp_cg.potenza_elettrica_kw, 
    sigit_t_comp_cg.temp_h2o_out_min, sigit_t_comp_cg.temp_h2o_out_max, 
    sigit_t_comp_cg.temp_h2o_in_min, sigit_t_comp_cg.temp_h2o_in_max, 
    sigit_t_comp_cg.temp_h2o_motore_min, sigit_t_comp_cg.temp_h2o_motore_max, 
    sigit_t_comp_cg.temp_fumi_valle_min, sigit_t_comp_cg.temp_fumi_valle_max, 
    sigit_t_comp_cg.temp_fumi_monte_min, sigit_t_comp_cg.temp_fumi_monte_max, 
    sigit_t_comp_cg.co_min, sigit_t_comp_cg.co_max, 
    sigit_t_comp_cg.data_dismiss, sigit_t_comp_cg.flg_dismissione, 
    sigit_t_comp_cg.data_ult_mod, sigit_t_comp_cg.utente_ult_mod, 
    sigit_t_comp_cg.fk_marca, sigit_d_marca.des_marca, 
    sigit_d_combustibile.id_combustibile, sigit_d_combustibile.des_combustibile, 
    sigit_t_comp_cg.matricola, sigit_t_comp_cg.modello, 
    sigit_t_comp_cg.potenza_termica_kw, sigit_t_comp_cg.alimentazione, 
    sigit_t_comp_cg.note, sigit_t_comp_cg.tempo_manut_anni
   FROM sigit_t_comp_cg
   LEFT JOIN sigit_d_marca ON sigit_t_comp_cg.fk_marca = sigit_d_marca.id_marca
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp_cg.fk_combustibile = sigit_d_combustibile.id_combustibile;

ALTER TABLE vista_comp_cg
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_comp_cg TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_comp_cg TO sigit_new_rw;



CREATE OR REPLACE VIEW vista_comp_gf AS 
 SELECT sigit_t_comp_gf.codice_impianto, sigit_t_comp_gf.id_tipo_componente, 
    sigit_t_comp_gf.progressivo, sigit_t_comp_gf.data_install, 
    sigit_t_comp_gf.fk_dettaglio_gf, sigit_d_dettaglio_gf.des_dettaglio_gf, 
    sigit_t_comp_gf.flg_sorgente_ext, sigit_t_comp_gf.flg_fluido_utenze, 
    sigit_t_comp_gf.fluido_frigorigeno, sigit_t_comp_gf.n_circuiti, 
    sigit_t_comp_gf.raffrescamento_eer, sigit_t_comp_gf.raff_potenza_kw, 
    sigit_t_comp_gf.raff_potenza_ass, sigit_t_comp_gf.riscaldamento_cop, 
    sigit_t_comp_gf.risc_potenza_kw, sigit_t_comp_gf.risc_potenza_ass_kw, 
    sigit_t_comp_gf.data_dismiss, sigit_t_comp_gf.flg_dismissione, 
    sigit_t_comp_gf.data_ult_mod, sigit_t_comp_gf.utente_ult_mod, 
    sigit_t_comp_gf.fk_marca, sigit_d_marca.des_marca, 
    sigit_d_combustibile.id_combustibile, sigit_d_combustibile.des_combustibile, 
    sigit_t_comp_gf.matricola, sigit_t_comp_gf.modello, 
    sigit_t_comp_gf.potenza_termica_kw, sigit_t_comp_gf.note, 
    sigit_t_comp_gf.tempo_manut_anni
   FROM sigit_t_comp_gf
   LEFT JOIN sigit_d_marca ON sigit_t_comp_gf.fk_marca = sigit_d_marca.id_marca
   LEFT JOIN sigit_d_dettaglio_gf ON sigit_t_comp_gf.fk_dettaglio_gf = sigit_d_dettaglio_gf.id_dettaglio_gf
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp_gf.fk_combustibile = sigit_d_combustibile.id_combustibile;

ALTER TABLE vista_comp_gf
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_comp_gf TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_comp_gf TO sigit_new_rw;



CREATE OR REPLACE VIEW vista_comp_sc AS 
 SELECT sigit_t_comp_sc.codice_impianto, sigit_t_comp_sc.id_tipo_componente, 
    sigit_t_comp_sc.progressivo, sigit_t_comp_sc.data_install, 
    sigit_t_comp_sc.data_dismiss, sigit_t_comp_sc.flg_dismissione, 
    sigit_t_comp_sc.data_ult_mod, sigit_t_comp_sc.utente_ult_mod, 
    sigit_t_comp_sc.fk_marca, sigit_d_marca.des_marca, 
    sigit_t_comp_sc.matricola, sigit_t_comp_sc.modello, 
    sigit_t_comp_sc.potenza_termica_kw, sigit_t_comp_sc.nome_proprietario, 
    sigit_t_comp_sc.cf_proprietario, sigit_t_comp_sc.note, 
    sigit_t_comp_sc.tempo_manut_anni
   FROM sigit_t_comp_sc
   LEFT JOIN sigit_d_marca ON sigit_t_comp_sc.fk_marca = sigit_d_marca.id_marca;

ALTER TABLE vista_comp_sc
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_comp_sc TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_comp_sc TO sigit_new_rw;

        

CREATE OR REPLACE VIEW vista_comp_gt AS 
 SELECT sigit_t_comp_gt.codice_impianto, sigit_t_comp_gt.id_tipo_componente, 
    sigit_t_comp_gt.progressivo, sigit_t_comp_gt.data_install, 
    sigit_t_comp_gt.data_dismiss, sigit_t_comp_gt.matricola, 
    sigit_t_comp_gt.fk_marca, sigit_d_marca.des_marca, 
    sigit_d_combustibile.id_combustibile, sigit_d_combustibile.des_combustibile, 
    sigit_t_comp_gt.fk_fluido, sigit_d_fluido.des_fluido, 
    sigit_t_comp_gt.fk_dettaglio_gt, sigit_d_dettaglio_gt.des_dettaglio_gt, 
    sigit_t_comp_gt.modello, sigit_t_comp_gt.potenza_termica_kw, 
    sigit_t_comp_gt.data_ult_mod, sigit_t_comp_gt.utente_ult_mod, 
    sigit_t_comp_gt.rendimento_perc, sigit_t_comp_gt.n_moduli, 
    sigit_t_comp_gt.flg_dismissione,sigit_t_comp_gt.tempo_manut_anni
   FROM sigit_t_comp_gt
   LEFT JOIN sigit_d_marca ON sigit_t_comp_gt.fk_marca = sigit_d_marca.id_marca
   LEFT JOIN sigit_d_fluido ON sigit_t_comp_gt.fk_fluido = sigit_d_fluido.id_fluido
   LEFT JOIN sigit_d_dettaglio_gt ON sigit_t_comp_gt.fk_dettaglio_gt = sigit_d_dettaglio_gt.id_dettaglio_gt
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp_gt.fk_combustibile = sigit_d_combustibile.id_combustibile;

ALTER TABLE vista_comp_gt
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_comp_gt TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_comp_gt TO sigit_new_rw;


        
        
-----------------------------------------------------------------------------------
-- Modifica richiesta da Actis (calata giù), effettuata in SVI e TST  - 02/07/2018
------------------------------------------------------------------------------------

CREATE TABLE sigit_d_class_dpr660_96
(
	id_class              CHARACTER VARYING(10)  NOT NULL ,
	des_class             CHARACTER VARYING(200)  NULL 
);

ALTER TABLE sigit_d_class_dpr660_96
	ADD CONSTRAINT  PK_sigit_d_class_dpr660_96 PRIMARY KEY (id_class);



CREATE TABLE sigit_d_frequenza_manut
(
	id_frequenza          CHARACTER VARYING(10)  NOT NULL ,
	des_frequenza         CHARACTER VARYING(200)  NULL 
);

ALTER TABLE sigit_d_frequenza_manut
	ADD CONSTRAINT  PK_sigit_d_frequenza_manut PRIMARY KEY (id_frequenza);



CREATE TABLE sigit_t_dett_ispez_gt
(
	id_dett_ispez_gt      NUMERIC  NOT NULL ,
	fk_allegato           NUMERIC  NULL ,
	fk_tipo_componente    CHARACTER VARYING(5)  NULL ,
	progressivo           NUMERIC(3)  NOT NULL ,
	codice_impianto       NUMERIC  NOT NULL ,
	data_install          DATE  NOT NULL ,
	s6d_flg_evacu_fumi    CHARACTER VARYING(1)  NULL  CONSTRAINT  dom_n_f CHECK (s6d_flg_evacu_fumi IN ('N','F')),
	s6i_flg_tipo_b        NUMERIC(1)  NULL  CONSTRAINT  dom_tipob CHECK (s6i_flg_tipo_b IN (0,1)),
	s6i_flg_tipo_c        NUMERIC(1)  NULL  CONSTRAINT  dom_tipoc CHECK (s6i_flg_tipo_c IN (0,1)),
	s6j_fk_class_dpr660_96  CHARACTER VARYING(10)  NULL ,
	s6k_pot_term_focol_kw  NUMERIC  NULL ,
	s6k_bruciatore_da_kw  NUMERIC  NULL ,
	s6k_bruciatore_a_kw   NUMERIC  NULL ,
	s6l_portata_comb_m3_h  NUMERIC  NULL ,
	s6l_portata_comb_kg_h  CHARACTER VARYING(100)  NULL ,
	s6l_pot_term_focol_kw  NUMERIC  NULL ,
	s7a_fk_frequenza_manut  CHARACTER VARYING(10)  NULL ,
	s7a_flg_manut_effettuata  NUMERIC(1)  NULL  CONSTRAINT  dom_effet CHECK (s7a_flg_manut_effettuata IN (0,1)),
	s7a_data_ultima_manut  DATE  NULL ,
	s7b_flg_ree_presente  NUMERIC(1)  NULL  CONSTRAINT  dom_reep CHECK (s7b_flg_ree_presente IN (0,1)),
	s7b_data_ree          DATE  NULL ,
	s7b_flg_osservazioni  NUMERIC(1)  NULL  CONSTRAINT  dom_osserv CHECK (s7b_flg_osservazioni IN (0,1)),
	s7b_flg_raccomand     NUMERIC(1)  NULL  CONSTRAINT  dom_raccom CHECK (s7b_flg_raccomand IN (0,1)),
	s7b_flg_prescr        NUMERIC(1)  NULL  CONSTRAINT  dom_prescr CHECK (s7b_flg_prescr IN (0,1)),
	s8a_n_modulo_termico  CHARACTER VARYING(20)  NULL ,
	s8b_fumo_mis_1        NUMERIC  NULL ,
	s8b_fumo_mis_2        NUMERIC  NULL ,
	s8b_fumo_mis_3        NUMERIC  NULL ,
	s8c_marca_strum_misura  CHARACTER VARYING(100)  NULL ,
	s8c_modello_strum_misura  CHARACTER VARYING(100)  NULL ,
	s8c_matricola_strum_misura  CHARACTER VARYING(30)  NULL ,
	s8d_temp_fluido_mandata_c  NUMERIC  NULL ,
	s8d_temp_aria_c       NUMERIC  NULL ,
	s8d_temp_fumi_c       NUMERIC  NULL ,
	s8d_o2_perc           NUMERIC  NULL ,
	s8d_co2_perc          NUMERIC  NULL ,
	s8d_co_fumi_secchi_ppm  NUMERIC  NULL ,
	s8d_no_mg_kw_h        NUMERIC  NULL ,
	s8e_indice_aria       NUMERIC  NULL ,
	s8e_fumi_secchi_no_aria_ppm  NUMERIC  NULL ,
	s8e_qs_perc           NUMERIC  NULL ,
	s8e_et_perc           NUMERIC  NULL ,
	s8e_rend_comb_perc    NUMERIC  NULL ,
	s8e_nox_mg_kw_h       NUMERIC  NULL ,
	s9a_flg_monossido_carb  CHARACTER VARYING(1)  NULL  CONSTRAINT  dom_ri CHECK (s9a_flg_monossido_carb IN ('R','I')),
	s9b_flg_fumosita      CHARACTER VARYING(1)  NULL  CONSTRAINT  dom_rin CHECK (s9b_flg_fumosita IN ('R','I','N')),
	s9c_rend_min_combust_perc  NUMERIC  NULL ,
	s9c_flg_rend_combust_suff  NUMERIC(1)  NULL  CONSTRAINT  dom_rcsuff CHECK (s9c_flg_rend_combust_suff IN (0,1)),
	s9d_ossidi_azoto_lim_mg_kw_h  NUMERIC  NULL ,
	s9d_flg_ossidi_azoto  CHARACTER VARYING(1)  NULL  CONSTRAINT  dom_ossiazoto CHECK (s9d_flg_ossidi_azoto IN ('R','I')),
	s9e_flg_rispetto_normativa  NUMERIC  NULL  CONSTRAINT  dom_rispnorm CHECK (s9e_flg_rispetto_normativa IN (0,1)),
	s9e_flg_no_rispetto_7a  NUMERIC(1)  NULL  CONSTRAINT  dom_nr7a CHECK (s9e_flg_no_rispetto_7a IN (0,1)),
	s9e_flg_no_rispetto_7b  NUMERIC(1)  NULL  CONSTRAINT  dom_nr7b CHECK (s9e_flg_no_rispetto_7b IN (0,1)),
	s9e_flg_no_rispetto_9a  NUMERIC(1)  NULL  CONSTRAINT  dom_nr9a CHECK (s9e_flg_no_rispetto_9a IN (0,1)),
	s9e_flg_no_rispetto_9b  NUMERIC(1)  NULL  CONSTRAINT  dom_nr9b CHECK (s9e_flg_no_rispetto_9b IN (0,1)),
	s9e_flg_no_rispetto_9c  NUMERIC(1)  NULL  CONSTRAINT  dom_nr9c CHECK (s9e_flg_no_rispetto_9c IN (0,1)),
	s9e_flg_no_rispetto_9d  NUMERIC(1)  NULL  CONSTRAINT  dom_nr9d CHECK (s9e_flg_no_rispetto_9d IN (0,1)),
	data_ult_mod          TIMESTAMP  NOT NULL ,
	utente_ult_mod        CHARACTER VARYING(16)  NOT NULL ,
	controlloweb          TIMESTAMP  NULL 
);


ALTER TABLE sigit_t_dett_ispez_gt
	ADD CONSTRAINT  PK_sigit_t_dett_ispez_gt PRIMARY KEY (id_dett_ispez_gt);



CREATE TABLE sigit_t_rapp_ispez_gt
(
	id_allegato           NUMERIC  NOT NULL ,
	s1c_flg_ree_inviato   NUMERIC(1)  NULL  CONSTRAINT  dom_r_inv CHECK (s1c_flg_ree_inviato IN (0,1)),
	s1c_flg_ree_bollino   NUMERIC(1)  NULL  CONSTRAINT  dom_boll CHECK (s1c_flg_ree_bollino IN (0,1)),
	s1c_sigla_bollino     CHARACTER VARYING(2)  NULL ,
	s1c_num_bollino       NUMERIC(11)  NULL ,
	s1e_dt_prima_installazione  DATE  NULL ,
	s1e_pot_focolare_kw   NUMERIC  NULL ,
	s1e_pot_utile_kw      NUMERIC  NULL ,
	s1l_denom_delegato    CHARACTER VARYING(50)  NULL ,
	s1l_flg_delega        NUMERIC(1)  NULL  CONSTRAINT  dom_delega CHECK (s1l_flg_delega IN (0,1)),
	s2b1_flg_termo_contab  NUMERIC(1)  NULL  CONSTRAINT  dom_tcont CHECK (s2b1_flg_termo_contab IN (0,1,2)),
	s2b2_flg_uni_10200    NUMERIC(1)  NULL  CONSTRAINT  dom_uni_10200 CHECK (s2b2_flg_uni_10200 IN (0,1,2)),
	s2f_flg_tratt_clima_non_rich  NUMERIC(1)  NULL  CONSTRAINT  dom_trcl CHECK (s2f_flg_tratt_clima_non_rich IN (0,1)),
	s2f_flg_tratt_acs_non_rich  NUMERIC(1)  NULL  CONSTRAINT  dom_trat CHECK (s2f_flg_tratt_acs_non_rich IN (0,1)),
	s3a_flg_locale_int_idoneo  NUMERIC(1)  NULL  CONSTRAINT  dom_locid CHECK (s3a_flg_locale_int_idoneo IN (0,1,2)),
	s3b_flg_gen_ext_idoneo  NUMERIC(1)  NULL  CONSTRAINT  dom_genext CHECK (s3b_flg_gen_ext_idoneo IN (0,1,2)),
	s3c_flg_ventilaz_suff  NUMERIC(1)  NULL  CONSTRAINT  dom_vent CHECK (s3c_flg_ventilaz_suff IN (0,1,2)),
	s3d_flg_evac_fumi_idoneo  NUMERIC(1)  NULL  CONSTRAINT  dom_evac CHECK (s3d_flg_evac_fumi_idoneo IN (0,1,2)),
	s3e_flg_cartelli_presenti  NUMERIC(1)  NULL  CONSTRAINT  dom_cartel CHECK (s3e_flg_cartelli_presenti IN (0,1,2)),
	s3f_flg_estinz_presenti  NUMERIC(1)  NULL  CONSTRAINT  dom_estinz CHECK (s3f_flg_estinz_presenti IN (0,1,2)),
	s3g_flg_interr_gen_presenti  NUMERIC(1)  NULL  CONSTRAINT  dom_interr CHECK (s3g_flg_interr_gen_presenti IN (0,1,2)),
	s3h_flg_rubin_presente  NUMERIC(1)  NULL  CONSTRAINT  dom_rubin CHECK (s3h_flg_rubin_presente IN (0,1,2)),
	s3i_flg_assenza_perd_comb  NUMERIC(1)  NULL  CONSTRAINT  dom_pcomb CHECK (s3i_flg_assenza_perd_comb IN (0,1,2)),
	s3j_flg_temp_amb_funz  NUMERIC(1)  NULL  CONSTRAINT  dom_af CHECK (s3j_flg_temp_amb_funz IN (0,1,2)),
	s3k_flg_dm_1_12_1975  NUMERIC(1)  NULL  CONSTRAINT  dom_dm CHECK (s3k_flg_dm_1_12_1975 IN (0,1,2)),
	s4a_flg_lib_imp_presente  NUMERIC(1)  NULL  CONSTRAINT  dom_libpres CHECK (s4a_flg_lib_imp_presente IN (0,1)),
	s4b_flg_lib_compilato  NUMERIC(1)  NULL  CONSTRAINT  dom_libcomp CHECK (s4b_flg_lib_compilato IN (0,1)),
	s4c_flg_conformita_presente  NUMERIC(1)  NULL  CONSTRAINT  dom_confpres CHECK (s4c_flg_conformita_presente IN (0,1)),
	s4d_flg_lib_uso_presente  NUMERIC(1)  NULL  CONSTRAINT  dom_libuso CHECK (s4d_flg_lib_uso_presente IN (0,1)),
	s4e_flg_pratica_vvf_presente  NUMERIC(1)  NULL  CONSTRAINT  dom_vvf CHECK (s4e_flg_pratica_vvf_presente IN (0,1,2)),
	s4f_flg_pratica_inail_presente  NUMERIC(1)  NULL  CONSTRAINT  dom_prin CHECK (s4f_flg_pratica_inail_presente IN (0,1,2)),
	s4g_flg_dm12_1975     NUMERIC(1)  NULL  CONSTRAINT  dom_dm12 CHECK (s4g_flg_dm12_1975 IN (0,1,2)),
	s4g_matricola_dm_1_12_1975  CHARACTER VARYING(10)  NULL ,
	s5a_flg_adozione_valvole_term  NUMERIC(1)  NULL  CONSTRAINT  dom_vter CHECK (s5a_flg_adozione_valvole_term IN (0,1)),
	s5a_flg_isolamente_rete  NUMERIC(1)  NULL  CONSTRAINT  dom_isrt CHECK (s5a_flg_isolamente_rete IN (0,1)),
	s5a_flg_adoz_sist_trattam_h2o  NUMERIC(1)  NULL  CONSTRAINT  dom_sth2o CHECK (s5a_flg_adoz_sist_trattam_h2o IN (0,1)),
	s5a_flg_sostituz_sist_regolaz  NUMERIC(1)  NULL  CONSTRAINT  dom_ssr CHECK (s5a_flg_sostituz_sist_regolaz IN (0,1)),
	s5b_flg_no_interv_conv  NUMERIC(1)  NULL  CONSTRAINT  dom_noic CHECK (s5b_flg_no_interv_conv IN (0,1)),
	s5b_flg_relaz_dettaglio  NUMERIC(1)  NULL  CONSTRAINT  dom_rdet CHECK (s5b_flg_relaz_dettaglio IN (0,1)),
	s5b_flg_relaz_dettaglio_succ  NUMERIC(1)  NULL  CONSTRAINT  dom_rdsuc CHECK (s5b_flg_relaz_dettaglio_succ IN (0,1)),
	s5b_flg_valutaz_non_eseguita  NUMERIC(1)  NULL  CONSTRAINT  dom_vne CHECK (s5b_flg_valutaz_non_eseguita IN (0,1)),
	s5b_motivo_relaz_non_eseg  CHARACTER VARYING(100)  NULL ,
	s5c_flg_dimens_corretto  NUMERIC(1)  NULL  CONSTRAINT  dom_dimc CHECK (s5c_flg_dimens_corretto IN (0,1)),
	s5c_flg_dimens_non_controll  NUMERIC(1)  NULL  CONSTRAINT  dom_dimnco CHECK (s5c_flg_dimens_non_controll IN (0,1)),
	s5c_flg_dimens_relaz_succes  NUMERIC(1)  NULL  CONSTRAINT  dom_dmrsuc CHECK (s5c_flg_dimens_relaz_succes IN (0,1)),
	data_ult_mod          TIMESTAMP  NOT NULL ,
	utente_ult_mod        CHARACTER VARYING(16)  NOT NULL 
);


ALTER TABLE sigit_t_rapp_ispez_gt
	ADD CONSTRAINT  PK_sigit_t_rapp_ispez_gt PRIMARY KEY (id_allegato);

ALTER TABLE sigit_t_dett_ispez_gt
	ADD  CONSTRAINT  fk_sigit_t_allegato_comp_gt_02 FOREIGN KEY (fk_allegato,fk_tipo_componente,progressivo,codice_impianto,data_install) REFERENCES sigit_r_allegato_comp_gt(id_allegato,id_tipo_componente,progressivo,codice_impianto,data_install);

ALTER TABLE sigit_t_dett_ispez_gt
	ADD  CONSTRAINT  fk_sigit_d_class_dpr660_96_01 FOREIGN KEY (s6j_fk_class_dpr660_96) REFERENCES sigit_d_class_dpr660_96(id_class);

ALTER TABLE sigit_t_dett_ispez_gt
	ADD  CONSTRAINT  fk_sigit_d_frequenza_manut_01 FOREIGN KEY (s7a_fk_frequenza_manut) REFERENCES sigit_d_frequenza_manut(id_frequenza);

ALTER TABLE sigit_t_rapp_ispez_gt
	ADD  CONSTRAINT  FK_sigit_t_allegato_15 FOREIGN KEY (id_allegato) REFERENCES sigit_t_allegato(id_allegato);


-- Popolamento nuove tavole di decodifica

INSERT INTO sigit_d_class_dpr660_96(id_class, des_class) VALUES (1, 'Standard');
INSERT INTO sigit_d_class_dpr660_96(id_class, des_class) VALUES (2, 'A bassa temperatura');
INSERT INTO sigit_d_class_dpr660_96(id_class, des_class) VALUES (3, 'A gas a condensazione');


INSERT INTO sigit_d_frequenza_manut(id_frequenza, des_frequenza) VALUES (1, 'Semestrale');
INSERT INTO sigit_d_frequenza_manut(id_frequenza, des_frequenza) VALUES (2, 'Annuale');
INSERT INTO sigit_d_frequenza_manut(id_frequenza, des_frequenza) VALUES (3, 'Biennale');
INSERT INTO sigit_d_frequenza_manut(id_frequenza, des_frequenza) VALUES (4, 'Altro');


-----------------------------------------------------------------------------------
-- Modifica richiesta da Actis (calata giù), effettuata in SVI no TST  - 08/08/2018

-- pb aperti : sigit_t_ispezione_2018.fk_stato_ispezione ref con sigit_d_stato_ispezione già esistente

------------------------------------------------------------------------------------

CREATE TABLE sigit_d_stato_accertamento
(
	id_stato_accertamento  INTEGER  NOT NULL ,
	des_stato_accertamento  CHARACTER VARYING(100)  NOT NULL 
);

ALTER TABLE sigit_d_stato_accertamento
	ADD CONSTRAINT  PK_sigit_d_stato_accertamento PRIMARY KEY (id_stato_accertamento);


CREATE TABLE sigit_d_stato_sanzione
(
	id_stato_sanzione     INTEGER  NOT NULL ,
	des_stato_sanzione    CHARACTER VARYING(100)  NOT NULL 
);

ALTER TABLE sigit_d_stato_sanzione
	ADD CONSTRAINT  PK_sigit_d_stato_sanzione PRIMARY KEY (id_stato_sanzione);


CREATE TABLE sigit_d_tipo_anomalia
(
	id_tipo_anomalia      INTEGER  NOT NULL ,
	des_tipo_anomalia     CHARACTER VARYING(100)  NOT NULL 
);

ALTER TABLE sigit_d_tipo_anomalia
	ADD CONSTRAINT  PK_sigit_d_tipo_anomalia PRIMARY KEY (id_tipo_anomalia);


CREATE TABLE sigit_d_tipo_azione
(
	id_tipo_azione        INTEGER  NOT NULL ,
	des_tipo_azione       CHARACTER VARYING(100)  NOT NULL 
);

ALTER TABLE sigit_d_tipo_azione
	ADD CONSTRAINT  PK_sigit_d_tipo_azione PRIMARY KEY (id_tipo_azione);


CREATE TABLE sigit_d_tipo_conclusione
(
	id_tipo_conclusione   INTEGER  NOT NULL ,
	des_tipo_conclusione  CHARACTER VARYING(100)  NOT NULL 
);

ALTER TABLE sigit_d_tipo_conclusione
	ADD CONSTRAINT  PK_sigit_d_tipo_conclusione PRIMARY KEY (id_tipo_conclusione);


CREATE TABLE sigit_d_tipo_verifica
(
	id_tipo_verifica      INTEGER  NOT NULL ,
	des_tipo_verifica     CHARACTER VARYING(100)  NOT NULL 
);

ALTER TABLE sigit_d_tipo_verifica
	ADD CONSTRAINT  PK_sigit_d_tipo_verifica PRIMARY KEY (id_tipo_verifica);


CREATE TABLE sigit_t_accertamento
(
	id_accertamento       INTEGER  NOT NULL ,
	fk_verifica           INTEGER  NOT NULL ,
	fk_stato_accertamento  INTEGER  NOT NULL ,
	codice_impianto       NUMERIC  NOT NULL ,
	cf_creazione          CHARACTER VARYING(16)  NULL ,
	dt_creazione          DATE  NULL ,
	dt_conclusione        DATE  NULL ,
	fk_tipo_conclusione   INTEGER  NOT NULL ,
	fk_tipo_anomalia      INTEGER  NOT NULL ,
	dt_sveglia            DATE  NULL ,
	note_sveglia          CHARACTER VARYING(500)  NULL ,
	note                  CHARACTER VARYING(1000)  NULL 
);

ALTER TABLE sigit_t_accertamento
	ADD CONSTRAINT  PK_sigit_t_accertamento PRIMARY KEY (id_accertamento);


CREATE TABLE sigit_t_azione
(
	id_azione             INTEGER  NOT NULL ,
	dt_azione             DATE  NULL ,
	fk_tipo_azione        INTEGER  NOT NULL ,
	fk_verifica           INTEGER  NOT NULL ,
	fk_accertamento       INTEGER  NOT NULL ,
	fk_ispezione_2018     INTEGER  NOT NULL ,
	fk_sanzione           INTEGER  NOT NULL ,
	descrizione_azione    CHARACTER VARYING(1000)  NULL ,
	cf_utente_azione      CHARACTER VARYING(16)  NULL ,
	denom_utente_azione   CHARACTER VARYING(100)  NULL 
);

ALTER TABLE sigit_t_azione
	ADD CONSTRAINT  PK_sigit_t_azione PRIMARY KEY (id_azione);



CREATE TABLE sigit_t_doc_azione
(
	id_doc_azione         INTEGER  NOT NULL ,
	fk_azione             INTEGER  NOT NULL ,
	nome_doc_originale    CHARACTER VARYING(100)  NULL ,
	nome_doc              CHARACTER VARYING(100)  NULL ,
	uid_index             CHARACTER VARYING(50)  NULL ,
	data_ult_mod          DATE  NULL ,
	utente_ult_mod        CHARACTER VARYING(16)  NULL 
);

ALTER TABLE sigit_t_doc_azione
	ADD CONSTRAINT  PK_sigit_t_doc_azione PRIMARY KEY (id_doc_azione);



CREATE TABLE sigit_t_ispezione_2018
(
	id_ispezione_2018     INTEGER  NOT NULL ,
	fk_stato_ispezione    NUMERIC  NOT NULL ,
	fk_verifica           INTEGER  NOT NULL ,
	fk_accertamento       INTEGER  NOT NULL ,
	codice_impianto       NUMERIC  NOT NULL ,
	cf_ispettore          CHARACTER VARYING(16)  NULL ,
	data_ispezione        TIMESTAMP  NULL ,
	ente_competente       CHARACTER VARYING(100)  NULL ,
	flg_esito             NUMERIC(1)  NULL  CONSTRAINT  dom_0_1 CHECK (flg_esito IN (0,1)),
	dt_sveglia            TIMESTAMP  NULL ,
	note_sveglia          CHARACTER VARYING(100)  NOT NULL ,
	note                  CHARACTER VARYING(500)  NULL 
);

ALTER TABLE sigit_t_ispezione_2018
	ADD CONSTRAINT  PK_sigit_t_ispezione_2018 PRIMARY KEY (id_ispezione_2018);



CREATE TABLE sigit_t_sanzione
(
	id_sanzione           INTEGER  NOT NULL ,
	fk_stato_sanzione     INTEGER  NOT NULL ,
	fk_ispezione_2018     INTEGER  NOT NULL ,
	fk_accertamento       INTEGER  NOT NULL ,
	fk_pf_sanzionata      NUMERIC(6)  NOT NULL ,
	fk_pg_sanzionata      NUMERIC(6)  NOT NULL ,
	motivazione_sanzione  CHARACTER VARYING(1000)  NULL ,
	valore_sanzione       NUMERIC  NULL ,
	dt_creazione          DATE  NULL ,
	dt_comunicazione      DATE  NULL ,
	dt_pagamento          DATE  NULL ,
	note                  CHARACTER VARYING(1000)  NULL ,
	motivo_annullamento   CHARACTER VARYING(1000)  NULL ,
	dt_annullamento       DATE  NULL 
);

ALTER TABLE sigit_t_sanzione
	ADD CONSTRAINT  PK_sigit_t_sanzione PRIMARY KEY (id_sanzione);



CREATE TABLE sigit_t_verifica
(
	id_verifica           INTEGER  NOT NULL ,
	fk_tipo_verifica      INTEGER  NOT NULL ,
	fk_allegato           NUMERIC  NOT NULL ,
	fk_dato_distrib       INTEGER  NOT NULL ,
	codice_impianto       NUMERIC  NOT NULL ,
	cf_utente_caricamento  CHARACTER VARYING(16)  NULL ,
	denom_utente_caricamento  CHARACTER VARYING(100)  NULL ,
	dt_caricamento        DATE  NULL ,
	sigla_bollino         CHARACTER VARYING(2)  NOT NULL ,
	numero_bollino        NUMERIC(11)  NOT NULL ,
	dt_sveglia            DATE  NULL ,
	note_sveglia          CHARACTER VARYING(500)  NULL ,
	note                  CHARACTER VARYING(1000)  NULL 
);

ALTER TABLE sigit_t_verifica
	ADD CONSTRAINT  PK_sigit_t_verifica PRIMARY KEY (id_verifica);



ALTER TABLE sigit_t_accertamento
	ADD  CONSTRAINT  fk_sigit_t_verifica_02 FOREIGN KEY (fk_verifica) REFERENCES sigit_t_verifica(id_verifica);

ALTER TABLE sigit_t_accertamento
	ADD  CONSTRAINT  fk_sigit_d_stato_accertam_01 FOREIGN KEY (fk_stato_accertamento) REFERENCES sigit_d_stato_accertamento(id_stato_accertamento);

ALTER TABLE sigit_t_accertamento
	ADD  CONSTRAINT  fk_sigit_t_impianto_16 FOREIGN KEY (codice_impianto) REFERENCES sigit_t_impianto(codice_impianto);

ALTER TABLE sigit_t_accertamento
	ADD  CONSTRAINT  fk_sigit_d_tipo_conclusione_01 FOREIGN KEY (fk_tipo_conclusione) REFERENCES sigit_d_tipo_conclusione(id_tipo_conclusione);

ALTER TABLE sigit_t_accertamento
	ADD  CONSTRAINT  fk_sigit_d_tipo_anomalia_01 FOREIGN KEY (fk_tipo_anomalia) REFERENCES sigit_d_tipo_anomalia(id_tipo_anomalia);

ALTER TABLE sigit_t_azione
	ADD  CONSTRAINT  fk_sigit_d_tipo_azione_01 FOREIGN KEY (fk_tipo_azione) REFERENCES sigit_d_tipo_azione(id_tipo_azione);

ALTER TABLE sigit_t_azione
	ADD  CONSTRAINT  fk_sigit_t_verifica_03 FOREIGN KEY (fk_verifica) REFERENCES sigit_t_verifica(id_verifica);

ALTER TABLE sigit_t_azione
	ADD  CONSTRAINT  fk_sigit_t_accertamento_01 FOREIGN KEY (fk_accertamento) REFERENCES sigit_t_accertamento(id_accertamento);

ALTER TABLE sigit_t_azione
	ADD  CONSTRAINT  fk_sigit_t_ispezione_2018_02 FOREIGN KEY (fk_ispezione_2018) REFERENCES sigit_t_ispezione_2018(id_ispezione_2018);

ALTER TABLE sigit_t_azione
	ADD  CONSTRAINT  fk_sigit_t_sanzione_01 FOREIGN KEY (fk_sanzione) REFERENCES sigit_t_sanzione(id_sanzione);

ALTER TABLE sigit_t_doc_azione
	ADD  CONSTRAINT  fk_sigit_t_azione_01 FOREIGN KEY (fk_azione) REFERENCES sigit_t_azione(id_azione);

ALTER TABLE sigit_t_ispezione_2018
	ADD  CONSTRAINT  fk_sigit_t_ispezione_02 FOREIGN KEY (fk_stato_ispezione) REFERENCES sigit_d_stato_ispezione(id_stato_ispezione);

ALTER TABLE sigit_t_ispezione_2018
	ADD  CONSTRAINT  fk_sigit_t_impianto_17 FOREIGN KEY (codice_impianto) REFERENCES sigit_t_impianto(codice_impianto);

ALTER TABLE sigit_t_ispezione_2018
	ADD  CONSTRAINT  fk_sigit_t_verifica_01 FOREIGN KEY (fk_verifica) REFERENCES sigit_t_verifica(id_verifica);

ALTER TABLE sigit_t_ispezione_2018
	ADD  CONSTRAINT  fk_sigit_t_accertamento_03 FOREIGN KEY (fk_accertamento) REFERENCES sigit_t_accertamento(id_accertamento);

ALTER TABLE sigit_t_sanzione
	ADD  CONSTRAINT  fk_sigit_d_stato_sanzione_01 FOREIGN KEY (fk_stato_sanzione) REFERENCES sigit_d_stato_sanzione(id_stato_sanzione);

ALTER TABLE sigit_t_sanzione
	ADD  CONSTRAINT  fk_sigit_t_ispezione_2018_01 FOREIGN KEY (fk_ispezione_2018) REFERENCES sigit_t_ispezione_2018(id_ispezione_2018);

ALTER TABLE sigit_t_sanzione
	ADD  CONSTRAINT  fk_sigit_t_accertamento_02 FOREIGN KEY (fk_accertamento) REFERENCES sigit_t_accertamento(id_accertamento);

ALTER TABLE sigit_t_sanzione
	ADD  CONSTRAINT  FK_sigit_t_persona_fisica_10 FOREIGN KEY (fk_pf_sanzionata) REFERENCES sigit_t_persona_fisica(id_persona_fisica);

ALTER TABLE sigit_t_sanzione
	ADD  CONSTRAINT  FK_sigit_t_pers_giuridica_23 FOREIGN KEY (fk_pg_sanzionata) REFERENCES sigit_t_persona_giuridica(id_persona_giuridica);

ALTER TABLE sigit_t_verifica
	ADD  CONSTRAINT  FK_sigit_t_allegato_18 FOREIGN KEY (fk_allegato) REFERENCES sigit_t_allegato(id_allegato);

ALTER TABLE sigit_t_verifica
	ADD  CONSTRAINT  fk_sigit_d_tipo_verifica_01 FOREIGN KEY (fk_tipo_verifica) REFERENCES sigit_d_tipo_verifica(id_tipo_verifica);

ALTER TABLE sigit_t_verifica
	ADD  CONSTRAINT  fk_sigit_t_dato_distrib_02 FOREIGN KEY (fk_dato_distrib) REFERENCES sigit_t_dato_distrib(id_dato_distrib);

ALTER TABLE sigit_t_verifica
	ADD  CONSTRAINT  fk_sigit_t_impianto_15 FOREIGN KEY (codice_impianto) REFERENCES sigit_t_impianto(codice_impianto);



-------------------------------------------------------------------------------------------------------------
--
-- Nuova tavola richiesta da Todaro (mail), effettuata in SVI 09/08/2018 e in TST (v. mail Actis 18/09/2018)
--
-------------------------------------------------------------------------------------------------------------
CREATE TABLE sigit_t_doc_allegato
(
	id_doc_allegato       INTEGER  NOT NULL ,
	fk_allegato           NUMERIC  NOT NULL ,
	nome_doc_originale    CHARACTER VARYING(100)  NULL ,
	nome_doc              CHARACTER VARYING(100)  NULL ,
	uid_index             CHARACTER VARYING(50)  NULL ,
	descrizione           CHARACTER VARYING(100), 
	data_ult_mod          DATE  NULL ,
	utente_ult_mod        CHARACTER VARYING(16)  NULL ,
	Data_upload           TIMESTAMP  NULL ,
	Data_delete           TIMESTAMP  NULL 
);

ALTER TABLE sigit_t_doc_allegato
	ADD CONSTRAINT  PK_sigit_t_doc_allegato PRIMARY KEY (id_doc_allegato);


ALTER TABLE sigit_t_doc_allegato
	ADD CONSTRAINT  fk_sigit_t_allegato_19 FOREIGN KEY (fk_allegato) REFERENCES sigit_t_allegato(id_allegato);


CREATE SEQUENCE seq_t_doc_allegato
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE seq_t_doc_allegato
  OWNER TO sigit_new;
GRANT ALL ON SEQUENCE seq_t_doc_allegato TO sigit_new;
GRANT SELECT, UPDATE ON SEQUENCE seq_t_doc_allegato TO sigit_new_rw;




-- Insert dei recors con id=0 per rendere le relazioni forti
INSERT INTO sigit_t_allegato
    VALUES (0, 1, null, 1, 
            null, null, '10/08/201', null, null, 
            null, null, null, null, 
            null, null, null, null, 
            null, null, null, null, 
            null, null, '10/08/201', 
            '----------------', null, null, null, null, 
            null, null, null, 
            null, null, null, null, null);
            



INSERT INTO sigit_t_dato_distrib(
            id_dato_distrib, fk_tipo_contratto, fk_import_distrib, fk_categoria_util, 
            fk_combustibile, codice_assenza_catast, fk_unita_misura, flg_pf_pg, 
            cognome_denom, nome, cf_piva, anno_rif, nr_mesi_fattur, dug, 
            indirizzo, civico, cap, istat_comune, pod_pdr, consumo_anno, 
            consumo_mensile, mese_riferimento, consumo_giornaliero, giorno_riferimento, 
            volumetria)
    VALUES (0, 1, 1, 'C1', 
            1, null, 1, 'PF', 
            1, 1, 1, 1, 1, 1, 
            1, 1, null, null, null, 1, 
            null, null, null, null, 
            null);            
            

/* esiste già anche in prd, verificare se va bene
INSERT INTO sigit_t_impianto(
            codice_impianto, istat_comune, fk_stato, data_assegnazione, data_dismissione, 
            denominazione_comune, sigla_provincia, denominazione_provincia, 
            l1_3_pot_h2o_kw, l1_3_pot_clima_inv_kw, l1_3_pot_clima_est_kw, 
            l1_3_altro, l1_4_flg_h2o, l1_4_flg_aria, l1_4_altro, l1_5_flg_generatore, 
            l1_5_flg_pompa, l1_5_flg_frigo, l1_5_flg_telerisc, l1_5_flg_teleraffr, 
            l1_5_flg_cogeneratore, l1_5_altro, l1_5_sup_pannelli_sol_m2, 
            l1_5_altro_integrazione, l1_5_altro_integr_pot_kw, l1_5_flg_altro_clima_inv, 
            l1_5_flg_altro_clima_estate, l1_5_flg_altro_acs, l1_5_altro_desc, 
            data_ult_mod, utente_ult_mod, motivazione, proprietario, data_inserimento, 
            note, flg_tipo_impianto, flg_apparecc_ui_ext, flg_contabilizzazione, 
            data_intervento, fk_tipo_intervento, l11_1_flg_norma_uni_10389_1, 
            l11_1_altra_norma)
    VALUES (0, null, 1, '10/08/2018', null, 
            null, null, null, 
            null, null, null, 
            null, null, null, null, null, 
            null, null, null, null, 
            null, null, null, 
            null, null, null, 
            null, null, null, 
            '10/08/2018', '----------------', null, null, null, 
            null, null, null, null, 
            null, null, null, 
            null);
*/

INSERT INTO sigit_d_tipo_verifica(
            id_tipo_verifica, des_tipo_verifica)
    VALUES (0, 'Dato non presente');
    
    
    
INSERT INTO sigit_t_verifica(
            id_verifica, fk_tipo_verifica, fk_allegato, fk_dato_distrib, 
            codice_impianto, cf_utente_caricamento, denom_utente_caricamento, 
            dt_caricamento, sigla_bollino, numero_bollino, dt_sveglia, note_sveglia, 
            note)
    VALUES (0, 0, 0, 0, 
            0, null, 
            null, null, '-', 0, null, null, 
            null);




INSERT INTO sigit_d_stato_accertamento(
            id_stato_accertamento, des_stato_accertamento)
    VALUES (0, 'Dato non presente');


INSERT INTO sigit_d_tipo_conclusione(
            id_tipo_conclusione, des_tipo_conclusione)
    VALUES (0, 'Dato non presente');
    
    
INSERT INTO sigit_d_tipo_anomalia(
            id_tipo_anomalia, des_tipo_anomalia)
    VALUES (0, 'Dato non presente');
    
    
INSERT INTO sigit_t_accertamento(
            id_accertamento, fk_verifica, fk_stato_accertamento, codice_impianto, 
            cf_creazione, dt_creazione, dt_conclusione, fk_tipo_conclusione, 
            fk_tipo_anomalia, dt_sveglia, note_sveglia, note)
    VALUES (0, 0, 0, 0, 
            null, null, null, 0, 
            0, null, null, null);    


INSERT INTO sigit_d_stato_ispezione(
            id_stato_ispezione, des_stato_ispezione)
    VALUES (0, 'Dato non presente');
    
    
INSERT INTO sigit_t_ispezione_2018(
            id_ispezione_2018, fk_stato_ispezione, fk_verifica, fk_accertamento, 
            codice_impianto, cf_ispettore, data_ispezione, ente_competente, 
            flg_esito, dt_sveglia, note_sveglia, note)
    VALUES (0, 0, 0, 0, 
            0, null, null, null, 
            null, null, null, null);
            
            
INSERT INTO sigit_d_stato_sanzione(
            id_stato_sanzione, des_stato_sanzione)
    VALUES (0, 'Dato non presente');            
    
    
INSERT INTO sigit_t_sanzione(
            id_sanzione, fk_stato_sanzione, fk_ispezione_2018, fk_accertamento, 
            fk_pf_sanzionata, fk_pg_sanzionata, motivazione_sanzione, valore_sanzione, 
            dt_creazione, dt_comunicazione, dt_pagamento, note, motivo_annullamento, 
            dt_annullamento)
    VALUES (0, 0, 0, 0, 
            0, -2, null, null, 
            null, null, null, null, null, 
            null);    
            
            
            
----------------------------------------------------------------------------------------------------------
--su richiesta Actis (mail 11/09/2018) questo campo non va messo in questa tabella ma su sigit_t_comp4 con mome dt_controlloweb
--ALTER TABLE sigit_t_controllo_libretto ADD COLUMN flg_l4_controlloweb NUMERIC(1);

--------------------------------------------------------------------------------------------- 
-- richiesta Actis 11/09/2018  -  effettuata in SVI e TST
--------------------------------------------------------------------------------------------- 

ALTER TABLE sigit_t_comp4 ADD COLUMN dt_controlloweb timestamp without time zone;


--------------------------------------------------------------------------------------------- 
-- richiesta Todaro 11/09/2018 -  effettuata in SVI e TST
--------------------------------------------------------------------------------------------- 

ALTER TABLE sigit_d_tipo_documento ADD COLUMN  flg_visu_elenco_rapprova numeric(1,0) CONSTRAINT dom_0_1_vis CHECK (flg_visu_elenco_rapprova IN (0,1));


--------------------------------------------------------------------------------------------- 
-- richiesta Actis 14/09/2018  -  effettuata in SVI e TST
--------------------------------------------------------------------------------------------- 


CREATE TABLE sigit_t_azione_comp4
(
	codice_impianto       NUMERIC  NOT NULL ,
	id_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	progressivo           NUMERIC(3)  NOT NULL ,
	dt_install            DATE  NOT NULL ,
	dt_azione             TIMESTAMP  NULL ,
	cf_utente_azione      CHARACTER VARYING(16)  NULL ,
	descrizione_azione    CHARACTER VARYING(1000)  NULL 
);

ALTER TABLE sigit_t_azione_comp4
ADD CONSTRAINT  PK_sigit_t_azione_comp4 PRIMARY KEY (codice_impianto,id_tipo_componente,progressivo, dt_azione);

ALTER TABLE sigit_t_azione_comp4
ADD CONSTRAINT  fk_sigit_t_comp4_09 FOREIGN KEY (codice_impianto,id_tipo_componente,progressivo) REFERENCES sigit_t_comp4(codice_impianto,id_tipo_componente,progressivo);


--------------------------------------------------------------------------------------------- 
-- richiesta Todaro 08/10/2018 -  effettuata in SVI, TST e TU
--------------------------------------------------------------------------------------------- 
DROP VIEW vista_comp_gt_dett;

CREATE OR REPLACE VIEW vista_comp_gt_dett AS 
         SELECT sigit_t_dett_tipo1.codice_impianto, 
            sigit_t_dett_tipo1.fk_tipo_componente, 
            sigit_t_dett_tipo1.progressivo, sigit_t_dett_tipo1.data_install, 
            sigit_t_dett_tipo1.id_dett_tipo1, sigit_t_dett_tipo1.fk_allegato, 
            sigit_t_dett_tipo1.e_n_modulo_termico, 
            sigit_t_dett_tipo1.e_pot_term_focol_kw, 
            sigit_t_dett_tipo1.e_flg_clima_inverno, 
            sigit_t_dett_tipo1.e_flg_produz_acs, 
            sigit_t_dett_tipo1.e_flg_dispos_comando, 
            sigit_t_dett_tipo1.e_flg_dispos_sicurezza, 
            sigit_t_dett_tipo1.e_flg_valvola_sicurezza, 
            sigit_t_dett_tipo1.e_flg_scambiatore_fumi, 
            sigit_t_dett_tipo1.e_flg_riflusso, 
            sigit_t_dett_tipo1.e_flg_uni_10389_1, 
            sigit_t_dett_tipo1.e_flg_evacu_fumi, 
            sigit_t_dett_tipo1.e_depr_canale_fumo_pa, 
            sigit_t_dett_tipo1.e_temp_fumi_c, sigit_t_dett_tipo1.e_temp_aria_c, 
            sigit_t_dett_tipo1.e_o2_perc, sigit_t_dett_tipo1.e_co2_perc, 
            sigit_t_dett_tipo1.e_bacharach_min, 
            sigit_t_dett_tipo1.e_bacharach_med, 
            sigit_t_dett_tipo1.e_bacharach_max, 
            sigit_t_dett_tipo1.e_co_corretto_ppm, 
            sigit_t_dett_tipo1.e_rend_comb_perc, 
            sigit_t_dett_tipo1.e_rend_min_legge_perc, 
            sigit_t_dett_tipo1.e_nox_ppm,
            sigit_t_dett_tipo1.e_nox_mg_kwh,  
            sigit_t_dett_tipo1.data_ult_mod AS data_ult_mod_dett, 
            sigit_t_dett_tipo1.utente_ult_mod AS utente_ult_mod_dett, 
            sigit_t_allegato.data_controllo,
            sigit_t_allegato.fk_stato_rapp, 
            sigit_t_dett_tipo1.l11_1_portata_combustibile, 
            sigit_t_dett_tipo1.l11_1_portata_combustibile_um, 
            sigit_t_dett_tipo1.l11_1_altro_riferimento, 
            sigit_t_dett_tipo1.l11_1_co_no_aria_ppm, 
            sigit_t_dett_tipo1.l11_1_flg_rispetta_bacharach, 
            sigit_t_dett_tipo1.l11_1_flg_co_min_1000, 
            sigit_t_dett_tipo1.l11_1_flg_rend_mag_rend_min,
            sigit_t_persona_giuridica.sigla_rea, 
            sigit_t_persona_giuridica.numero_rea, 
            sigit_t_persona_giuridica.id_persona_giuridica, 
            sigit_r_comp4_manut.fk_ruolo
           FROM sigit_t_dett_tipo1
      JOIN sigit_t_allegato ON sigit_t_dett_tipo1.fk_allegato = sigit_t_allegato.id_allegato AND sigit_t_allegato.fk_stato_rapp <> 2::numeric
   JOIN sigit_r_comp4manut_all ON sigit_r_comp4manut_all.id_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_comp4_manut ON sigit_r_comp4_manut.id_r_comp4_manut = sigit_r_comp4manut_all.id_r_comp4_manut
   JOIN sigit_t_persona_giuridica ON sigit_r_comp4_manut.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
UNION 
         SELECT sigit_t_dett_tipo1.codice_impianto, 
            sigit_t_dett_tipo1.fk_tipo_componente, 
            sigit_t_dett_tipo1.progressivo, sigit_t_dett_tipo1.data_install, 
            sigit_t_dett_tipo1.id_dett_tipo1, sigit_t_dett_tipo1.fk_allegato, 
            sigit_t_dett_tipo1.e_n_modulo_termico, 
            sigit_t_dett_tipo1.e_pot_term_focol_kw, 
            sigit_t_dett_tipo1.e_flg_clima_inverno, 
            sigit_t_dett_tipo1.e_flg_produz_acs, 
            sigit_t_dett_tipo1.e_flg_dispos_comando, 
            sigit_t_dett_tipo1.e_flg_dispos_sicurezza, 
            sigit_t_dett_tipo1.e_flg_valvola_sicurezza, 
            sigit_t_dett_tipo1.e_flg_scambiatore_fumi, 
            sigit_t_dett_tipo1.e_flg_riflusso, 
            sigit_t_dett_tipo1.e_flg_uni_10389_1, 
            sigit_t_dett_tipo1.e_flg_evacu_fumi, 
            sigit_t_dett_tipo1.e_depr_canale_fumo_pa, 
            sigit_t_dett_tipo1.e_temp_fumi_c, sigit_t_dett_tipo1.e_temp_aria_c, 
            sigit_t_dett_tipo1.e_o2_perc, sigit_t_dett_tipo1.e_co2_perc, 
            sigit_t_dett_tipo1.e_bacharach_min, 
            sigit_t_dett_tipo1.e_bacharach_med, 
            sigit_t_dett_tipo1.e_bacharach_max, 
            sigit_t_dett_tipo1.e_co_corretto_ppm, 
            sigit_t_dett_tipo1.e_rend_comb_perc, 
            sigit_t_dett_tipo1.e_rend_min_legge_perc, 
            sigit_t_dett_tipo1.e_nox_ppm,
            sigit_t_dett_tipo1.e_nox_mg_kwh,
            sigit_t_dett_tipo1.data_ult_mod AS data_ult_mod_dett, 
            sigit_t_dett_tipo1.utente_ult_mod AS utente_ult_mod_dett, 
            sigit_t_allegato.data_controllo,
            sigit_t_allegato.fk_stato_rapp, 
            sigit_t_dett_tipo1.l11_1_portata_combustibile, 
            sigit_t_dett_tipo1.l11_1_portata_combustibile_um, 
            sigit_t_dett_tipo1.l11_1_altro_riferimento, 
            sigit_t_dett_tipo1.l11_1_co_no_aria_ppm, 
            sigit_t_dett_tipo1.l11_1_flg_rispetta_bacharach, 
            sigit_t_dett_tipo1.l11_1_flg_co_min_1000, 
            sigit_t_dett_tipo1.l11_1_flg_rend_mag_rend_min, 
            sigit_t_persona_giuridica.sigla_rea, 
            sigit_t_persona_giuridica.numero_rea, 
            COALESCE(sigit_t_persona_giuridica.id_persona_giuridica, sigit_t_persona_fisica.id_persona_fisica, sigit_t_persona_giuridica.id_persona_giuridica) AS id_persona_giuridica, 
            sigit_r_imp_ruolo_pfpg.fk_ruolo
           FROM sigit_t_dett_tipo1
      JOIN sigit_t_allegato ON sigit_t_dett_tipo1.fk_allegato = sigit_t_allegato.id_allegato AND sigit_t_allegato.fk_stato_rapp <> 2::numeric
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg = sigit_t_allegato.fk_imp_ruolo_pfpg
   LEFT JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
   LEFT JOIN sigit_t_persona_fisica ON sigit_r_imp_ruolo_pfpg.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica;

ALTER TABLE vista_comp_gt_dett
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_comp_gt_dett TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_comp_gt_dett TO sigit_new_rw;




DROP VIEW vista_comp_cg_dett;

CREATE OR REPLACE VIEW vista_comp_cg_dett AS 
         SELECT sigit_t_dett_tipo4.codice_impianto, 
            sigit_t_dett_tipo4.fk_tipo_componente, 
            sigit_t_dett_tipo4.progressivo, sigit_t_dett_tipo4.data_install, 
            sigit_t_dett_tipo4.fk_allegato, sigit_t_dett_tipo4.fk_fluido, 
            sigit_t_dett_tipo4.e_potenza_assorb_comb_kw, 
            sigit_t_dett_tipo4.e_potenza_term_bypass_kw, 
            sigit_t_dett_tipo4.e_temp_aria_c, 
            sigit_t_dett_tipo4.e_temp_h2o_out_c, 
            sigit_t_dett_tipo4.e_temp_h2o_in_c, 
            sigit_t_dett_tipo4.e_potenza_morsetti_kw, 
            sigit_t_dett_tipo4.e_temp_h2o_motore_c, 
            sigit_t_dett_tipo4.e_temp_fumi_valle_c, 
            sigit_t_dett_tipo4.e_temp_fumi_monte_c, 
            sigit_t_dett_tipo4.data_ult_mod AS data_ult_mod_dett, 
            sigit_t_dett_tipo4.utente_ult_mod AS utente_ult_mod_dett, 
            sigit_t_allegato.data_controllo,
            sigit_t_allegato.fk_stato_rapp, 
            sigit_t_dett_tipo4.l11_4_sovrafreq_soglia_hz_min, 
            sigit_t_dett_tipo4.l11_4_sovrafreq_soglia_hz_med, 
            sigit_t_dett_tipo4.l11_4_sovrafreq_soglia_hz_max, 
            sigit_t_dett_tipo4.l11_4_sovrafreq_tempo_s_min, 
            sigit_t_dett_tipo4.l11_4_sovrafreq_tempo_s_med, 
            sigit_t_dett_tipo4.l11_4_sovrafreq_tempo_s_max, 
            sigit_t_dett_tipo4.l11_4_sottofreq_soglia_hz_min, 
            sigit_t_dett_tipo4.l11_4_sottofreq_soglia_hz_med, 
            sigit_t_dett_tipo4.l11_4_sottofreq_soglia_hz_max, 
            sigit_t_dett_tipo4.l11_4_sottofreq_tempo_s_min, 
            sigit_t_dett_tipo4.l11_4_sottofreq_tempo_s_med, 
            sigit_t_dett_tipo4.l11_4_sottofreq_tempo_s_max, 
            sigit_t_dett_tipo4.l11_4_sovratens_soglia_v_min, 
            sigit_t_dett_tipo4.l11_4_sovratens_soglia_v_med, 
            sigit_t_dett_tipo4.l11_4_sovratens_soglia_v_max, 
            sigit_t_dett_tipo4.l11_4_sovratens_tempo_s_min, 
            sigit_t_dett_tipo4.l11_4_sovratens_tempo_s_med, 
            sigit_t_dett_tipo4.l11_4_sovratens_tempo_s_max, 
            sigit_t_dett_tipo4.l11_4_sottotens_soglia_v_min, 
            sigit_t_dett_tipo4.l11_4_sottotens_soglia_v_med, 
            sigit_t_dett_tipo4.l11_4_sottotens_soglia_v_max, 
            sigit_t_dett_tipo4.l11_4_sottotens_tempo_s_min, 
            sigit_t_dett_tipo4.l11_4_sottotens_tempo_s_med, 
            sigit_t_dett_tipo4.l11_4_sottotens_tempo_s_max, 
            sigit_t_persona_giuridica.sigla_rea, 
            sigit_t_persona_giuridica.numero_rea, 
            sigit_t_persona_giuridica.id_persona_giuridica, 
            sigit_r_comp4_manut.fk_ruolo, sigit_t_comp_cg.co_min, 
            sigit_t_comp_cg.co_max
           FROM sigit_t_comp_cg
      JOIN sigit_t_dett_tipo4 ON sigit_t_dett_tipo4.codice_impianto = sigit_t_comp_cg.codice_impianto AND sigit_t_dett_tipo4.fk_tipo_componente::text = sigit_t_comp_cg.id_tipo_componente::text AND sigit_t_dett_tipo4.progressivo = sigit_t_comp_cg.progressivo AND sigit_t_dett_tipo4.data_install = sigit_t_comp_cg.data_install
   JOIN sigit_t_allegato ON sigit_t_dett_tipo4.fk_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_comp4manut_all ON sigit_r_comp4manut_all.id_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_comp4_manut ON sigit_r_comp4_manut.id_r_comp4_manut = sigit_r_comp4manut_all.id_r_comp4_manut
   JOIN sigit_t_persona_giuridica ON sigit_r_comp4_manut.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
UNION 
         SELECT sigit_t_dett_tipo4.codice_impianto, 
            sigit_t_dett_tipo4.fk_tipo_componente, 
            sigit_t_dett_tipo4.progressivo, sigit_t_dett_tipo4.data_install, 
            sigit_t_dett_tipo4.fk_allegato, sigit_t_dett_tipo4.fk_fluido, 
            sigit_t_dett_tipo4.e_potenza_assorb_comb_kw, 
            sigit_t_dett_tipo4.e_potenza_term_bypass_kw, 
            sigit_t_dett_tipo4.e_temp_aria_c, 
            sigit_t_dett_tipo4.e_temp_h2o_out_c, 
            sigit_t_dett_tipo4.e_temp_h2o_in_c, 
            sigit_t_dett_tipo4.e_potenza_morsetti_kw, 
            sigit_t_dett_tipo4.e_temp_h2o_motore_c, 
            sigit_t_dett_tipo4.e_temp_fumi_valle_c, 
            sigit_t_dett_tipo4.e_temp_fumi_monte_c, 
            sigit_t_dett_tipo4.data_ult_mod AS data_ult_mod_dett, 
            sigit_t_dett_tipo4.utente_ult_mod AS utente_ult_mod_dett, 
            sigit_t_allegato.data_controllo,
            sigit_t_allegato.fk_stato_rapp,             
            sigit_t_dett_tipo4.l11_4_sovrafreq_soglia_hz_min, 
            sigit_t_dett_tipo4.l11_4_sovrafreq_soglia_hz_med, 
            sigit_t_dett_tipo4.l11_4_sovrafreq_soglia_hz_max, 
            sigit_t_dett_tipo4.l11_4_sovrafreq_tempo_s_min, 
            sigit_t_dett_tipo4.l11_4_sovrafreq_tempo_s_med, 
            sigit_t_dett_tipo4.l11_4_sovrafreq_tempo_s_max, 
            sigit_t_dett_tipo4.l11_4_sottofreq_soglia_hz_min, 
            sigit_t_dett_tipo4.l11_4_sottofreq_soglia_hz_med, 
            sigit_t_dett_tipo4.l11_4_sottofreq_soglia_hz_max, 
            sigit_t_dett_tipo4.l11_4_sottofreq_tempo_s_min, 
            sigit_t_dett_tipo4.l11_4_sottofreq_tempo_s_med, 
            sigit_t_dett_tipo4.l11_4_sottofreq_tempo_s_max, 
            sigit_t_dett_tipo4.l11_4_sovratens_soglia_v_min, 
            sigit_t_dett_tipo4.l11_4_sovratens_soglia_v_med, 
            sigit_t_dett_tipo4.l11_4_sovratens_soglia_v_max, 
            sigit_t_dett_tipo4.l11_4_sovratens_tempo_s_min, 
            sigit_t_dett_tipo4.l11_4_sovratens_tempo_s_med, 
            sigit_t_dett_tipo4.l11_4_sovratens_tempo_s_max, 
            sigit_t_dett_tipo4.l11_4_sottotens_soglia_v_min, 
            sigit_t_dett_tipo4.l11_4_sottotens_soglia_v_med, 
            sigit_t_dett_tipo4.l11_4_sottotens_soglia_v_max, 
            sigit_t_dett_tipo4.l11_4_sottotens_tempo_s_min, 
            sigit_t_dett_tipo4.l11_4_sottotens_tempo_s_med, 
            sigit_t_dett_tipo4.l11_4_sottotens_tempo_s_max, 
            sigit_t_persona_giuridica.sigla_rea, 
            sigit_t_persona_giuridica.numero_rea, 
            COALESCE(sigit_t_persona_giuridica.id_persona_giuridica, sigit_t_persona_fisica.id_persona_fisica, sigit_t_persona_giuridica.id_persona_giuridica) AS id_persona_giuridica, 
            sigit_r_imp_ruolo_pfpg.fk_ruolo, sigit_t_comp_cg.co_min, 
            sigit_t_comp_cg.co_max
           FROM sigit_t_comp_cg
      JOIN sigit_t_dett_tipo4 ON sigit_t_dett_tipo4.codice_impianto = sigit_t_comp_cg.codice_impianto AND sigit_t_dett_tipo4.fk_tipo_componente::text = sigit_t_comp_cg.id_tipo_componente::text AND sigit_t_dett_tipo4.progressivo = sigit_t_comp_cg.progressivo AND sigit_t_dett_tipo4.data_install = sigit_t_comp_cg.data_install
   JOIN sigit_t_allegato ON sigit_t_dett_tipo4.fk_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg = sigit_t_allegato.fk_imp_ruolo_pfpg
   LEFT JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
   LEFT JOIN sigit_t_persona_fisica ON sigit_r_imp_ruolo_pfpg.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica;

ALTER TABLE vista_comp_cg_dett
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_comp_cg_dett TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_comp_cg_dett TO sigit_new_rw;





DROP VIEW vista_comp_gf_dett;

CREATE OR REPLACE VIEW vista_comp_gf_dett AS 
         SELECT sigit_t_dett_tipo2.codice_impianto, 
            sigit_t_dett_tipo2.fk_tipo_componente, 
            sigit_t_dett_tipo2.progressivo, sigit_t_dett_tipo2.data_install, 
            sigit_t_dett_tipo2.id_dett_tipo2, sigit_t_dett_tipo2.fk_allegato, 
            sigit_t_dett_tipo2.e_n_circuito, sigit_t_dett_tipo2.e_flg_mod_prova, 
            sigit_t_dett_tipo2.e_flg_perdita_gas, 
            sigit_t_dett_tipo2.e_flg_leak_detector, 
            sigit_t_dett_tipo2.e_flg_param_termodinam, 
            sigit_t_dett_tipo2.e_flg_incrostazioni, 
            sigit_t_dett_tipo2.e_t_surrisc_c, sigit_t_dett_tipo2.e_t_sottoraf_c, 
            sigit_t_dett_tipo2.e_t_condensazione_c, 
            sigit_t_dett_tipo2.e_t_evaporazione_c, 
            sigit_t_dett_tipo2.e_t_in_ext_c, sigit_t_dett_tipo2.e_t_out_ext_c, 
            sigit_t_dett_tipo2.e_t_in_utenze_c, 
            sigit_t_dett_tipo2.e_t_out_utenze_c, 
            sigit_t_dett_tipo2.data_ult_mod AS data_ult_mod_dett, 
            sigit_t_dett_tipo2.utente_ult_mod AS utente_ult_mod_dett, 
            sigit_t_allegato.data_controllo,
            sigit_t_allegato.fk_stato_rapp, 
            sigit_t_dett_tipo2.l11_2_torre_t_out_fluido, 
            sigit_t_dett_tipo2.l11_2_torre_t_bulbo_umido, 
            sigit_t_dett_tipo2.l11_2_scambiatore_t_in_ext, 
            sigit_t_dett_tipo2.l11_2_scambiatore_t_out_ext, 
            sigit_t_dett_tipo2.l11_2_scambiat_t_in_macchina, 
            sigit_t_dett_tipo2.l11_2_scambiat_t_out_macchina, 
            sigit_t_dett_tipo2.l11_2_potenza_assorbita_kw, 
            sigit_t_dett_tipo2.l11_2_flg_pulizia_filtri, 
            sigit_t_dett_tipo2.l11_2_flg_verifica_superata, 
            sigit_t_dett_tipo2.l11_2_data_ripristino, 
            sigit_t_persona_giuridica.sigla_rea, 
            sigit_t_persona_giuridica.numero_rea, 
            sigit_t_persona_giuridica.id_persona_giuridica, 
            sigit_r_comp4_manut.fk_ruolo
           FROM sigit_t_dett_tipo2
      JOIN sigit_t_allegato ON sigit_t_dett_tipo2.fk_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_comp4manut_all ON sigit_r_comp4manut_all.id_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_comp4_manut ON sigit_r_comp4_manut.id_r_comp4_manut = sigit_r_comp4manut_all.id_r_comp4_manut
   JOIN sigit_t_persona_giuridica ON sigit_r_comp4_manut.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
UNION 
         SELECT sigit_t_dett_tipo2.codice_impianto, 
            sigit_t_dett_tipo2.fk_tipo_componente, 
            sigit_t_dett_tipo2.progressivo, sigit_t_dett_tipo2.data_install, 
            sigit_t_dett_tipo2.id_dett_tipo2, sigit_t_dett_tipo2.fk_allegato, 
            sigit_t_dett_tipo2.e_n_circuito, sigit_t_dett_tipo2.e_flg_mod_prova, 
            sigit_t_dett_tipo2.e_flg_perdita_gas, 
            sigit_t_dett_tipo2.e_flg_leak_detector, 
            sigit_t_dett_tipo2.e_flg_param_termodinam, 
            sigit_t_dett_tipo2.e_flg_incrostazioni, 
            sigit_t_dett_tipo2.e_t_surrisc_c, sigit_t_dett_tipo2.e_t_sottoraf_c, 
            sigit_t_dett_tipo2.e_t_condensazione_c, 
            sigit_t_dett_tipo2.e_t_evaporazione_c, 
            sigit_t_dett_tipo2.e_t_in_ext_c, sigit_t_dett_tipo2.e_t_out_ext_c, 
            sigit_t_dett_tipo2.e_t_in_utenze_c, 
            sigit_t_dett_tipo2.e_t_out_utenze_c, 
            sigit_t_dett_tipo2.data_ult_mod AS data_ult_mod_dett, 
            sigit_t_dett_tipo2.utente_ult_mod AS utente_ult_mod_dett, 
            sigit_t_allegato.data_controllo,
            sigit_t_allegato.fk_stato_rapp, 
            sigit_t_dett_tipo2.l11_2_torre_t_out_fluido, 
            sigit_t_dett_tipo2.l11_2_torre_t_bulbo_umido, 
            sigit_t_dett_tipo2.l11_2_scambiatore_t_in_ext, 
            sigit_t_dett_tipo2.l11_2_scambiatore_t_out_ext, 
            sigit_t_dett_tipo2.l11_2_scambiat_t_in_macchina, 
            sigit_t_dett_tipo2.l11_2_scambiat_t_out_macchina, 
            sigit_t_dett_tipo2.l11_2_potenza_assorbita_kw, 
            sigit_t_dett_tipo2.l11_2_flg_pulizia_filtri, 
            sigit_t_dett_tipo2.l11_2_flg_verifica_superata, 
            sigit_t_dett_tipo2.l11_2_data_ripristino, 
            sigit_t_persona_giuridica.sigla_rea, 
            sigit_t_persona_giuridica.numero_rea, 
            COALESCE(sigit_t_persona_giuridica.id_persona_giuridica, sigit_t_persona_fisica.id_persona_fisica, sigit_t_persona_giuridica.id_persona_giuridica) AS id_persona_giuridica, 
            sigit_r_imp_ruolo_pfpg.fk_ruolo
           FROM sigit_t_dett_tipo2
      JOIN sigit_t_allegato ON sigit_t_dett_tipo2.fk_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg = sigit_t_allegato.fk_imp_ruolo_pfpg
   LEFT JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
   LEFT JOIN sigit_t_persona_fisica ON sigit_r_imp_ruolo_pfpg.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica;

ALTER TABLE vista_comp_gf_dett
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_comp_gf_dett TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_comp_gf_dett TO sigit_new_rw;




DROP VIEW vista_comp_sc_dett;

CREATE OR REPLACE VIEW vista_comp_sc_dett AS 
         SELECT sigit_t_dett_tipo3.codice_impianto, 
            sigit_t_dett_tipo3.fk_tipo_componente, 
            sigit_t_dett_tipo3.progressivo, sigit_t_dett_tipo3.data_install, 
            sigit_t_dett_tipo3.fk_allegato, sigit_t_dett_tipo3.fk_fluido, 
            sigit_t_dett_tipo3.fk_fluido_alimentaz, 
            sigit_t_dett_tipo3.e_fluido_altro, 
            sigit_t_dett_tipo3.e_alimentazione_altro, 
            sigit_t_dett_tipo3.e_flg_clima_inverno, 
            sigit_t_dett_tipo3.e_flg_produz_acs, 
            sigit_t_dett_tipo3.e_flg_potenza_compatibile, 
            sigit_t_dett_tipo3.e_flg_coib_idonea, 
            sigit_t_dett_tipo3.e_flg_disp_funzionanti, 
            sigit_t_dett_tipo3.e_temp_ext_c, 
            sigit_t_dett_tipo3.e_temp_mand_primario_c, 
            sigit_t_dett_tipo3.e_temp_ritor_primario_c, 
            sigit_t_dett_tipo3.e_temp_mand_secondario_c, 
            sigit_t_dett_tipo3.e_temp_rit_secondario_c, 
            sigit_t_dett_tipo3.e_potenza_term_kw, 
            sigit_t_dett_tipo3.e_port_fluido_m3_h, 
            sigit_t_dett_tipo3.data_ult_mod AS data_ult_mod_dett, 
            sigit_t_dett_tipo3.utente_ult_mod AS utente_ult_mod_dett, 
            sigit_t_allegato.data_controllo,
            sigit_t_allegato.fk_stato_rapp, 
            sigit_t_persona_giuridica.sigla_rea, 
            sigit_t_persona_giuridica.numero_rea, 
            sigit_t_persona_giuridica.id_persona_giuridica, 
            sigit_r_comp4_manut.fk_ruolo
           FROM sigit_t_dett_tipo3
      JOIN sigit_t_allegato ON sigit_t_dett_tipo3.fk_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_comp4manut_all ON sigit_r_comp4manut_all.id_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_comp4_manut ON sigit_r_comp4_manut.id_r_comp4_manut = sigit_r_comp4manut_all.id_r_comp4_manut
   JOIN sigit_t_persona_giuridica ON sigit_r_comp4_manut.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
UNION 
         SELECT sigit_t_dett_tipo3.codice_impianto, 
            sigit_t_dett_tipo3.fk_tipo_componente, 
            sigit_t_dett_tipo3.progressivo, sigit_t_dett_tipo3.data_install, 
            sigit_t_dett_tipo3.fk_allegato, sigit_t_dett_tipo3.fk_fluido, 
            sigit_t_dett_tipo3.fk_fluido_alimentaz, 
            sigit_t_dett_tipo3.e_fluido_altro, 
            sigit_t_dett_tipo3.e_alimentazione_altro, 
            sigit_t_dett_tipo3.e_flg_clima_inverno, 
            sigit_t_dett_tipo3.e_flg_produz_acs, 
            sigit_t_dett_tipo3.e_flg_potenza_compatibile, 
            sigit_t_dett_tipo3.e_flg_coib_idonea, 
            sigit_t_dett_tipo3.e_flg_disp_funzionanti, 
            sigit_t_dett_tipo3.e_temp_ext_c, 
            sigit_t_dett_tipo3.e_temp_mand_primario_c, 
            sigit_t_dett_tipo3.e_temp_ritor_primario_c, 
            sigit_t_dett_tipo3.e_temp_mand_secondario_c, 
            sigit_t_dett_tipo3.e_temp_rit_secondario_c, 
            sigit_t_dett_tipo3.e_potenza_term_kw, 
            sigit_t_dett_tipo3.e_port_fluido_m3_h, 
            sigit_t_dett_tipo3.data_ult_mod AS data_ult_mod_dett, 
            sigit_t_dett_tipo3.utente_ult_mod AS utente_ult_mod_dett, 
            sigit_t_allegato.data_controllo,
            sigit_t_allegato.fk_stato_rapp, 
            sigit_t_persona_giuridica.sigla_rea, 
            sigit_t_persona_giuridica.numero_rea, 
            COALESCE(sigit_t_persona_giuridica.id_persona_giuridica, sigit_t_persona_fisica.id_persona_fisica, sigit_t_persona_giuridica.id_persona_giuridica) AS id_persona_giuridica, 
            sigit_r_imp_ruolo_pfpg.fk_ruolo
           FROM sigit_t_dett_tipo3
      JOIN sigit_t_allegato ON sigit_t_dett_tipo3.fk_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg = sigit_t_allegato.fk_imp_ruolo_pfpg
   LEFT JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
   LEFT JOIN sigit_t_persona_fisica ON sigit_r_imp_ruolo_pfpg.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica;

ALTER TABLE vista_comp_sc_dett
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_comp_sc_dett TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_comp_sc_dett TO sigit_new_rw;

