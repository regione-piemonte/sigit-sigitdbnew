-----------------------------------------------------------------------------------
-- Modifiche secondo rilascio 2019 - 
-- effettuata  in SVI  - 04/06/2019   (Mail Actis)
-----------------------------------------------------------------------------------
ALTER TABLE sigit_t_rapp_ispez_gt ADD COLUMN s1c_data_ree date;
ALTER TABLE sigit_t_rapp_ispez_gt 
	ADD COLUMN s5c_flg_dimens_non_corretto  NUMERIC(1)  NULL  CONSTRAINT  s5c_dnc1_0_1 CHECK (s5c_flg_dimens_non_corretto IN (0,1));

ALTER TABLE sigit_t_dett_ispez_gt ADD COLUMN s7a_frequenza_manut_altro character varying(50);

	
/*
ALTER TABLE sigit_t_rapp_ispez_gf ADD COLUMN s1c_data_ree date;
ALTER TABLE sigit_t_rapp_ispez_gf 
	ADD COLUMN s5c_flg_dimens_non_corretto  NUMERIC(1)  NULL  CONSTRAINT  s5c_dnc2_0_1 CHECK (s5c_flg_dimens_non_corretto IN (0,1));

ALTER TABLE sigit_t_dett_ispez_gf ADD COLUMN s7a_frequenza_manut_altro character varying(50);
ALTER TABLE sigit_t_dett_ispez_gf ADD COLUMN s8a_n_circuito character varying(30);
ALTER TABLE sigit_t_dett_ispez_gf ADD COLUMN data_ult_mod timestamp without time zone;
ALTER TABLE sigit_t_dett_ispez_gf ADD COLUMN utente_ult_mod character varying(16)  NOT NULL;
ALTER TABLE sigit_t_dett_ispez_gf ADD COLUMN controlloweb timestamp without time zone  NOT NULL;

ALTER TABLE sigit_t_dett_ispez_gf RENAME s8d_temp_uscita_fluido_c  TO s8j_temp_uscita_fluido_c;
*/

----------------------------------------------------------------------------------------
-- 30/10/2018  Lorita
-- Correzione tabella sigit_d_frequenza_manut
----------------------------------------------------------------------------------------
ALTER TABLE sigit_t_dett_ispez_gt DROP COLUMN 
  s7a_fk_frequenza_manut CASCADE;

DROP TABLE sigit_d_frequenza_manut;

CREATE TABLE sigit_d_frequenza_manut
(
  id_frequenza integer NOT NULL,
  des_frequenza character varying(200),
  CONSTRAINT pk_sigit_d_frequenza_manut PRIMARY KEY (id_frequenza)
);

insert into sigit_d_frequenza_manut 
values (1,'Semestrale');
insert into sigit_d_frequenza_manut 
values (2,'Annuale');
insert into sigit_d_frequenza_manut 
values (3,'Biennale');
insert into sigit_d_frequenza_manut 
values (4,'Altro');

ALTER TABLE sigit_t_dett_ispez_gt  ADD
	  s7a_fk_frequenza_manut integer NULL;
	  
ALTER TABLE sigit_t_dett_ispez_gt  
	ADD CONSTRAINT  fk_sigit_d_frequenza_manut_01 FOREIGN KEY (s7a_fk_frequenza_manut) REFERENCES sigit_d_frequenza_manut (id_frequenza);

--******************************************************************************************
--******************************************************************************************
CREATE TABLE sigit_t_rapp_ispez_gf
(
  id_allegato numeric NOT NULL,
  s1c_flg_ree_inviato numeric(1,0),
  s1c_flg_ree_bollino numeric(1,0),
  s1c_sigla_bollino character varying(2),
  s1c_num_bollino numeric(11,0),
  s1e_dt_prima_installazione date,
  s1e_pot_termica_max_kw numeric,
  s1l_denom_delegato character varying(50),
  s1l_flg_delega numeric(1,0),
  s2e_flg_tratt_h2o_non_rich numeric(1,0),
  s3a_flg_locale_int_idoneo numeric(1,0),
  s3b_flg_linee_elettr_idonee numeric(1,0),
  s3c_flg_ventilaz_adeguate numeric(1,0),
  s3d_flg_coibentazioni_idonee numeric(1,0),
  s4a_flg_lib_imp_presente numeric(1,0),
  s4b_flg_lib_compilato numeric(1,0),
  s4c_flg_conformita_presente numeric(1,0),
  s4d_flg_lib_uso_presente numeric(1,0),
  s5a_flg_sostituz_macchine_reg numeric(1,0),
  s5a_flg_sostituz_sistemi_reg numeric(1,0),
  s5a_flg_isolam_rete_distrib numeric(1,0),
  s5a_flg_isolam_canali_distrib numeric(1,0),
  s5b_flg_no_interv_conv numeric(1,0),
  s5b_flg_relaz_dettaglio numeric(1,0),
  s5b_flg_relaz_dettaglio_succ numeric(1,0),
  s5b_flg_valutaz_non_eseguita numeric(1,0),
  s5b_motivo_relaz_non_eseg character varying(100),
  s5c_flg_dimens_corretto numeric(1,0),
  s5c_flg_dimens_non_controll numeric(1,0),
  s5c_flg_dimens_relaz_succes numeric(1,0),
  data_ult_mod timestamp without time zone NOT NULL,
  utente_ult_mod character varying(16) NOT NULL,
  s1c_data_ree date,
  s5c_flg_dimens_non_corretto numeric(1,0),
  CONSTRAINT pk_sigit_t_rapp_ispez_gf PRIMARY KEY (id_allegato),
  CONSTRAINT fk_sigit_t_allegato_17 FOREIGN KEY (id_allegato)
      REFERENCES sigit_t_allegato (id_allegato) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT coid_0_1_2 CHECK (s3d_flg_coibentazioni_idonee = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric])),
  CONSTRAINT conp_0_1 CHECK (s4c_flg_conformita_presente = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT dimc_0_1 CHECK (s5c_flg_dimens_corretto = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT dimnc_0_1 CHECK (s5c_flg_dimens_non_controll = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT dimrs_0_1 CHECK (s5c_flg_dimens_relaz_succes = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT dlg_0_1 CHECK (s1l_flg_delega = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT impp_0_1 CHECK (s4a_flg_lib_imp_presente = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT ird_0_1 CHECK (s5a_flg_isolam_rete_distrib = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT iscad_0_1 CHECK (s5a_flg_isolam_canali_distrib = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT lei_0_1_2 CHECK (s3b_flg_linee_elettr_idonee = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric])),
  CONSTRAINT libc_0_1 CHECK (s4b_flg_lib_compilato = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT locid_0_1_2 CHECK (s3a_flg_locale_int_idoneo = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric])),
  CONSTRAINT lup_0_1 CHECK (s4d_flg_lib_uso_presente = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT noic_0_1 CHECK (s5b_flg_no_interv_conv = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT rebo_0_1 CHECK (s1c_flg_ree_bollino = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT reds_0_1 CHECK (s5b_flg_relaz_dettaglio_succ = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT redt_0_1 CHECK (s5b_flg_relaz_dettaglio = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT rein_01 CHECK (s1c_flg_ree_inviato = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT s5c_dnc2_0_1 CHECK (s5c_flg_dimens_non_corretto = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT som_0_1 CHECK (s5a_flg_sostituz_macchine_reg = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT sosr_0_1 CHECK (s5a_flg_sostituz_sistemi_reg = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT th2o_0_1 CHECK (s2e_flg_tratt_h2o_non_rich = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT vad_0_1_2 CHECK (s3c_flg_ventilaz_adeguate = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric])),
  CONSTRAINT vane_0_1 CHECK (s5b_flg_valutaz_non_eseguita = ANY (ARRAY[0::numeric, 1::numeric]))
)
WITH (
  OIDS=FALSE
);
ALTER TABLE sigit_t_rapp_ispez_gf
  OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_t_rapp_ispez_gf TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE sigit_t_rapp_ispez_gf TO sigit_new_rw;



CREATE TABLE sigit_t_dett_ispez_gf
(
  id_dett_ispez_gf numeric NOT NULL,
  fk_allegato numeric NOT NULL,
  fk_tipo_componente character varying(5) NOT NULL,
  progressivo numeric(3,0) NOT NULL,
  codice_impianto numeric NOT NULL,
  data_install date NOT NULL,
  s6h_flg_inverter numeric(1,0),
  s6n_flg_fuga_diretta numeric(1,0),
  s6n_flg_fuga_indiretta numeric(1,0),
  s7a_fk_frequenza_manut integer,
  s7a_flg_manut_effettuata numeric(1,0),
  s7a_data_ultima_manut date,
  s7b_flg_registro_apparecc numeric(1,0),
  s7c_flg_ree_presente numeric(1,0),
  s7c_data_ree date,
  s7c_flg_osservazioni numeric(1,0),
  s7c_flg_raccomand numeric(1,0),
  s7c_flg_prescr numeric(1,0),
  s8b_flg_prove_riscaldamento numeric(1,0),
  s8b_flg_prove_raffrescamento numeric(1,0),
  s8c_flg_filtri_puliti numeric(1,0),
  s8d_flg_assenza_perdite_gas numeric(1,0),
  s8e_marca_strum_misura character varying(100),
  s8e_modello_strum_misura character varying(100),
  s8e_matricola_strum_misura character varying(30),
  s8f_pot_assorbita_kw numeric,
  s8g_flg_strumentazione_fissa numeric(1,0),
  s8h_operatore_denominazione character varying(100),
  s8i_operatore_num_iscriz character varying(30),
  s8j_surriscaldamento_k numeric,
  s8j_sottoraffreddamento_k numeric,
  s8j_temp_condensazione_c numeric,
  s8j_temp_evaporazione_c numeric,
  s8j_temp_sorg_ingresso_c numeric,
  s8j_temp_sorg_uscita_c numeric,
  s8j_temp_ingresso_fluido_c numeric,
  s8j_temp_uscita_fluido_c numeric,
  s9a_flg_verifica_superata numeric(1,0),
  s9b_flg_rispetto_normativa numeric,
  s9c_flg_no_rispetto_7a numeric(1,0),
  s9c_flg_no_rispetto_7b numeric(1,0),
  s9c_flg_no_rispetto_8d numeric(1,0),
  s9c_flg_no_rispetto_9a numeric(1,0),
  s7a_frequenza_manut_altro character varying(50),
  s8a_n_circuito character varying(30),
  data_ult_mod timestamp without time zone,
  utente_ult_mod character varying(16) NOT NULL,
  controlloweb timestamp without time zone NOT NULL,
  CONSTRAINT pk_sigit_t_dett_ispez_gf PRIMARY KEY (id_dett_ispez_gf),
  CONSTRAINT fk_sigit_d_frequenza_manut_02 FOREIGN KEY (s7a_fk_frequenza_manut)
      REFERENCES sigit_d_frequenza_manut (id_frequenza) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_sigit_t_allegato_comp_gf_02 FOREIGN KEY (fk_allegato, fk_tipo_componente, progressivo, codice_impianto, data_install)
      REFERENCES sigit_r_allegato_comp_gf (id_allegato, id_tipo_componente, progressivo, codice_impianto, data_install) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fd_0_1_2 CHECK (s6n_flg_fuga_diretta = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric])),
  CONSTRAINT fi_0_1_2 CHECK (s6n_flg_fuga_indiretta = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric])),
  CONSTRAINT fip_0_1 CHECK (s8c_flg_filtri_puliti = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT inv_0_1 CHECK (s6h_flg_inverter = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT meff_0_1 CHECK (s7a_flg_manut_effettuata = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT ossv_0_1 CHECK (s7c_flg_osservazioni = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT pgas_0_1_2 CHECK (s8d_flg_assenza_perdite_gas = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric])),
  CONSTRAINT praff_0_1 CHECK (s8b_flg_prove_raffrescamento = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT pre_0_1 CHECK (s7c_flg_prescr = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT prisc_0_1 CHECK (s8b_flg_prove_riscaldamento = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT r7a_0_1 CHECK (s9c_flg_no_rispetto_7a = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT r7b_0_1 CHECK (s9c_flg_no_rispetto_7b = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT r8d_0_1 CHECK (s9c_flg_no_rispetto_8d = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT r9a_0_1 CHECK (s9c_flg_no_rispetto_9a = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT racc_0_1 CHECK (s7c_flg_raccomand = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT reap_0_1_2 CHECK (s7b_flg_registro_apparecc = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric])),
  CONSTRAINT reep_0_1 CHECK (s7c_flg_ree_presente = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT risn_0_1 CHECK (s9b_flg_rispetto_normativa = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT stf_0_1 CHECK (s8g_flg_strumentazione_fissa = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT vsup_0_1 CHECK (s9a_flg_verifica_superata = ANY (ARRAY[0::numeric, 1::numeric]))
)
WITH (
  OIDS=FALSE
);
ALTER TABLE sigit_t_dett_ispez_gf
  OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_t_dett_ispez_gf TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE sigit_t_dett_ispez_gf TO sigit_new_rw;


--******************************************************************************************
--******************************************************************************************



-----------------------------------------------------------------------------------
-- 17/06/2019 Richieste Actis + Todaro 
-- effettuata  in SVI 
-----------------------------------------------------------------------------------
CREATE SEQUENCE seq_t_dett_ispez_gt
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE seq_t_dett_ispez_gt
  OWNER TO sigit_new;
GRANT ALL ON SEQUENCE seq_t_dett_ispez_gt TO sigit_new;
GRANT SELECT, UPDATE ON SEQUENCE seq_t_dett_ispez_gt TO sigit_new_rw;



CREATE SEQUENCE seq_t_dett_ispez_gf
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE seq_t_dett_ispez_gf
  OWNER TO sigit_new;
GRANT ALL ON SEQUENCE seq_t_dett_ispez_gf TO sigit_new;
GRANT SELECT, UPDATE ON SEQUENCE seq_t_dett_ispez_gf TO sigit_new_rw;




----------------------------------------------------------------------------------------------
-- 25/06/2019 Modifiche su viste_sk4_xx richieste da Actis, calata giù - eseguite solo in dev
----------------------------------------------------------------------------------------------

DROP VIEW vista_sk4_gt;

CREATE OR REPLACE VIEW vista_sk4_gt AS 
 SELECT DISTINCT sigit_t_comp_gt.codice_impianto,  -- prende tutti i gt, e se valorizzati completa con ree e manutenzioni
    sigit_t_comp_gt.id_tipo_componente, sigit_t_comp_gt.progressivo, 
    sigit_t_comp_gt.data_install, sigit_t_comp_gt.data_dismiss, 
    sigit_t_comp_gt.tempo_manut_anni, sigit_t_comp_gt.matricola, 
    sigit_t_comp_gt.fk_marca, sigit_d_marca.des_marca, 
    sigit_d_combustibile.id_combustibile, sigit_d_combustibile.des_combustibile, 
    sigit_t_comp_gt.fk_fluido, sigit_d_fluido.des_fluido, 
    sigit_t_comp_gt.fk_dettaglio_gt, sigit_d_dettaglio_gt.des_dettaglio_gt, 
    sigit_t_comp_gt.modello, sigit_t_comp_gt.potenza_termica_kw, 
    sigit_t_comp_gt.data_ult_mod, sigit_t_comp_gt.utente_ult_mod, 
    sigit_t_comp_gt.rendimento_perc, sigit_t_comp_gt.n_moduli, 
    sigit_t_comp_gt.flg_dismissione, sigit_t_allegato.data_controllo, 
    sigit_t_allegato.id_allegato, sigit_t_allegato.fk_tipo_documento, sigit_d_tipo_documento.des_tipo_documento
   FROM sigit_t_comp_gt
   LEFT JOIN sigit_d_marca ON sigit_t_comp_gt.fk_marca = sigit_d_marca.id_marca
   LEFT JOIN sigit_d_fluido ON sigit_t_comp_gt.fk_fluido = sigit_d_fluido.id_fluido
   LEFT JOIN sigit_d_dettaglio_gt ON sigit_t_comp_gt.fk_dettaglio_gt = sigit_d_dettaglio_gt.id_dettaglio_gt
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp_gt.fk_combustibile = sigit_d_combustibile.id_combustibile
   LEFT JOIN sigit_t_dett_tipo1 ON sigit_t_dett_tipo1.codice_impianto = sigit_t_comp_gt.codice_impianto AND 
   sigit_t_dett_tipo1.fk_tipo_componente::text = sigit_t_comp_gt.id_tipo_componente::text AND 
   sigit_t_dett_tipo1.progressivo = sigit_t_comp_gt.progressivo AND 
   sigit_t_dett_tipo1.data_install = sigit_t_comp_gt.data_install
   LEFT JOIN sigit_t_allegato ON sigit_t_dett_tipo1.fk_allegato = sigit_t_allegato.id_allegato
   LEFT JOIN sigit_d_tipo_documento ON sigit_t_allegato.fk_tipo_documento = sigit_d_tipo_documento.id_tipo_documento
--
 union  																														-- prende tutti i rapporti prova e completa con i dati dei gt
--
  SELECT DISTINCT sigit_t_comp_gt.codice_impianto, 
    sigit_t_comp_gt.id_tipo_componente, sigit_t_comp_gt.progressivo, 
    sigit_t_comp_gt.data_install, sigit_t_comp_gt.data_dismiss, 
    sigit_t_comp_gt.tempo_manut_anni, sigit_t_comp_gt.matricola, 
    sigit_t_comp_gt.fk_marca, sigit_d_marca.des_marca, 
    sigit_d_combustibile.id_combustibile, sigit_d_combustibile.des_combustibile, 
    sigit_t_comp_gt.fk_fluido, sigit_d_fluido.des_fluido, 
    sigit_t_comp_gt.fk_dettaglio_gt, sigit_d_dettaglio_gt.des_dettaglio_gt, 
    sigit_t_comp_gt.modello, sigit_t_comp_gt.potenza_termica_kw, 
    sigit_t_comp_gt.data_ult_mod, sigit_t_comp_gt.utente_ult_mod, 
    sigit_t_comp_gt.rendimento_perc, sigit_t_comp_gt.n_moduli, 
    sigit_t_comp_gt.flg_dismissione, sigit_t_allegato.data_controllo, 
    sigit_t_allegato.id_allegato, sigit_t_allegato.fk_tipo_documento, sigit_d_tipo_documento.des_tipo_documento
   FROM sigit_t_dett_ispez_gt 
   LEFT JOIN sigit_t_comp_gt ON sigit_t_dett_ispez_gt.codice_impianto = sigit_t_comp_gt.codice_impianto AND 
   sigit_t_dett_ispez_gt.fk_tipo_componente::text = sigit_t_comp_gt.id_tipo_componente::text AND 
   sigit_t_dett_ispez_gt.progressivo = sigit_t_comp_gt.progressivo AND 
   sigit_t_dett_ispez_gt.data_install = sigit_t_comp_gt.data_install
   LEFT JOIN sigit_d_marca ON sigit_t_comp_gt.fk_marca = sigit_d_marca.id_marca
   LEFT JOIN sigit_d_fluido ON sigit_t_comp_gt.fk_fluido = sigit_d_fluido.id_fluido
   LEFT JOIN sigit_d_dettaglio_gt ON sigit_t_comp_gt.fk_dettaglio_gt = sigit_d_dettaglio_gt.id_dettaglio_gt
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp_gt.fk_combustibile = sigit_d_combustibile.id_combustibile
   LEFT JOIN sigit_t_allegato ON sigit_t_dett_ispez_gt.fk_allegato = sigit_t_allegato.id_allegato
   LEFT JOIN sigit_d_tipo_documento ON sigit_t_allegato.fk_tipo_documento = sigit_d_tipo_documento.id_tipo_documento;
 
 GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_sk4_gt TO sigit_new_rw;
 
 
 

DROP VIEW vista_sk4_gf;

CREATE OR REPLACE VIEW vista_sk4_gf AS 
 SELECT  sigit_t_comp_gf.codice_impianto, 
    sigit_t_comp_gf.id_tipo_componente, sigit_t_comp_gf.progressivo, 
    sigit_t_comp_gf.data_install, sigit_t_comp_gf.tempo_manut_anni, 
    sigit_t_comp_gf.matricola, sigit_t_comp_gf.fk_marca, 
    sigit_d_marca.des_marca, sigit_d_combustibile.id_combustibile, 
    sigit_d_combustibile.des_combustibile, sigit_t_comp_gf.fk_dettaglio_gf, 
    sigit_d_dettaglio_gf.des_dettaglio_gf, sigit_t_comp_gf.modello, 
    sigit_t_comp_gf.flg_sorgente_ext, sigit_t_comp_gf.flg_fluido_utenze, 
    sigit_t_comp_gf.fluido_frigorigeno, sigit_t_comp_gf.n_circuiti, 
    sigit_t_comp_gf.raffrescamento_eer, sigit_t_comp_gf.raff_potenza_kw, 
    sigit_t_comp_gf.raff_potenza_ass, sigit_t_comp_gf.riscaldamento_cop, 
    sigit_t_comp_gf.risc_potenza_kw, sigit_t_comp_gf.risc_potenza_ass_kw, 
    sigit_t_comp_gf.flg_dismissione, sigit_t_comp_gf.data_dismiss, 
    sigit_t_comp_gf.data_ult_mod, sigit_t_comp_gf.utente_ult_mod, 
    sigit_t_comp_gf.potenza_termica_kw, sigit_t_allegato.data_controllo, 
    sigit_t_allegato.id_allegato, sigit_t_allegato.fk_tipo_documento, sigit_d_tipo_documento.des_tipo_documento
   FROM sigit_t_comp_gf
   LEFT JOIN sigit_d_marca ON sigit_t_comp_gf.fk_marca = sigit_d_marca.id_marca
   LEFT JOIN sigit_d_dettaglio_gf ON sigit_t_comp_gf.fk_dettaglio_gf = sigit_d_dettaglio_gf.id_dettaglio_gf
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp_gf.fk_combustibile = sigit_d_combustibile.id_combustibile
   LEFT JOIN sigit_t_dett_tipo2 ON sigit_t_dett_tipo2.codice_impianto = sigit_t_comp_gf.codice_impianto 
   AND sigit_t_dett_tipo2.fk_tipo_componente::text = sigit_t_comp_gf.id_tipo_componente::text 
   AND sigit_t_dett_tipo2.progressivo = sigit_t_comp_gf.progressivo 
   AND sigit_t_dett_tipo2.data_install = sigit_t_comp_gf.data_install
   LEFT JOIN sigit_t_allegato ON sigit_t_dett_tipo2.fk_allegato = sigit_t_allegato.id_allegato
   LEFT JOIN sigit_d_tipo_documento ON sigit_t_allegato.fk_tipo_documento = sigit_d_tipo_documento.id_tipo_documento
 union  																														
   SELECT  sigit_t_comp_gf.codice_impianto, 
    sigit_t_comp_gf.id_tipo_componente, sigit_t_comp_gf.progressivo, 
    sigit_t_comp_gf.data_install, sigit_t_comp_gf.tempo_manut_anni, 
    sigit_t_comp_gf.matricola, sigit_t_comp_gf.fk_marca, 
    sigit_d_marca.des_marca, sigit_d_combustibile.id_combustibile, 
    sigit_d_combustibile.des_combustibile, sigit_t_comp_gf.fk_dettaglio_gf, 
    sigit_d_dettaglio_gf.des_dettaglio_gf, sigit_t_comp_gf.modello, 
    sigit_t_comp_gf.flg_sorgente_ext, sigit_t_comp_gf.flg_fluido_utenze, 
    sigit_t_comp_gf.fluido_frigorigeno, sigit_t_comp_gf.n_circuiti, 
    sigit_t_comp_gf.raffrescamento_eer, sigit_t_comp_gf.raff_potenza_kw, 
    sigit_t_comp_gf.raff_potenza_ass, sigit_t_comp_gf.riscaldamento_cop, 
    sigit_t_comp_gf.risc_potenza_kw, sigit_t_comp_gf.risc_potenza_ass_kw, 
    sigit_t_comp_gf.flg_dismissione, sigit_t_comp_gf.data_dismiss, 
    sigit_t_comp_gf.data_ult_mod, sigit_t_comp_gf.utente_ult_mod, 
    sigit_t_comp_gf.potenza_termica_kw, sigit_t_allegato.data_controllo, 
    sigit_t_allegato.id_allegato, sigit_t_allegato.fk_tipo_documento, sigit_d_tipo_documento.des_tipo_documento
   FROM sigit_t_dett_ispez_gf
   LEFT JOIN sigit_t_comp_gf ON sigit_t_dett_ispez_gf.codice_impianto = sigit_t_comp_gf.codice_impianto and 
   sigit_t_dett_ispez_gf.fk_tipo_componente::text = sigit_t_comp_gf.id_tipo_componente::text AND 
   sigit_t_dett_ispez_gf.progressivo = sigit_t_comp_gf.progressivo AND 
   sigit_t_dett_ispez_gf.data_install = sigit_t_comp_gf.data_install
   LEFT JOIN sigit_d_marca ON sigit_t_comp_gf.fk_marca = sigit_d_marca.id_marca
   LEFT JOIN sigit_d_dettaglio_gf ON sigit_t_comp_gf.fk_dettaglio_gf = sigit_d_dettaglio_gf.id_dettaglio_gf
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp_gf.fk_combustibile = sigit_d_combustibile.id_combustibile
      LEFT JOIN sigit_t_allegato ON sigit_t_dett_ispez_gf.fk_allegato = sigit_t_allegato.id_allegato
   LEFT JOIN sigit_d_tipo_documento ON sigit_t_allegato.fk_tipo_documento = sigit_d_tipo_documento.id_tipo_documento;

GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_sk4_gf TO sigit_new_rw;




DROP VIEW vista_sk4_sc;

CREATE OR REPLACE VIEW vista_sk4_sc AS 
 SELECT DISTINCT sigit_t_comp_sc.codice_impianto, 
    sigit_t_comp_sc.id_tipo_componente, sigit_t_comp_sc.progressivo, 
    sigit_t_comp_sc.data_install, sigit_t_comp_sc.tempo_manut_anni, 
    sigit_t_comp_sc.flg_dismissione, sigit_t_comp_sc.data_dismiss, 
    sigit_t_comp_sc.data_ult_mod, sigit_t_comp_sc.utente_ult_mod, 
    sigit_t_comp_sc.matricola, sigit_t_comp_sc.modello, 
    sigit_t_comp_sc.potenza_termica_kw, sigit_t_comp_sc.fk_marca, 
    sigit_d_marca.des_marca, sigit_t_allegato.data_controllo, 
    sigit_t_allegato.id_allegato, sigit_t_allegato.fk_tipo_documento, sigit_d_tipo_documento.des_tipo_documento
   FROM sigit_t_comp_sc
   LEFT JOIN sigit_d_marca ON sigit_t_comp_sc.fk_marca = sigit_d_marca.id_marca
   LEFT JOIN sigit_t_dett_tipo3 ON sigit_t_dett_tipo3.codice_impianto = sigit_t_comp_sc.codice_impianto 
   AND sigit_t_dett_tipo3.fk_tipo_componente::text = sigit_t_comp_sc.id_tipo_componente::text 
   AND sigit_t_dett_tipo3.progressivo = sigit_t_comp_sc.progressivo 
   AND sigit_t_dett_tipo3.data_install = sigit_t_comp_sc.data_install
   LEFT JOIN sigit_t_allegato ON sigit_t_dett_tipo3.fk_allegato = sigit_t_allegato.id_allegato
   LEFT JOIN sigit_d_tipo_documento ON sigit_t_allegato.fk_tipo_documento = sigit_d_tipo_documento.id_tipo_documento;

GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_sk4_sc TO sigit_new_rw;




DROP VIEW vista_sk4_cg;

CREATE OR REPLACE VIEW vista_sk4_cg AS 
 SELECT DISTINCT sigit_t_comp_cg.codice_impianto, 
    sigit_t_comp_cg.id_tipo_componente, sigit_t_comp_cg.progressivo, 
    sigit_t_comp_cg.data_install, sigit_t_comp_cg.data_dismiss, 
    sigit_t_comp_cg.tempo_manut_anni, sigit_t_comp_cg.matricola, 
    sigit_t_comp_cg.fk_marca, sigit_d_marca.des_marca, 
    sigit_d_combustibile.id_combustibile, sigit_d_combustibile.des_combustibile, 
    sigit_t_comp_cg.modello, sigit_t_comp_cg.potenza_termica_kw, 
    sigit_t_comp_cg.data_ult_mod, sigit_t_comp_cg.utente_ult_mod, 
    sigit_t_comp_cg.tipologia, sigit_t_comp_cg.potenza_elettrica_kw, 
    sigit_t_comp_cg.temp_h2o_out_min, sigit_t_comp_cg.temp_h2o_out_max, 
    sigit_t_comp_cg.temp_h2o_in_min, sigit_t_comp_cg.temp_h2o_in_max, 
    sigit_t_comp_cg.temp_h2o_motore_min, sigit_t_comp_cg.temp_h2o_motore_max, 
    sigit_t_comp_cg.temp_fumi_valle_min, sigit_t_comp_cg.temp_fumi_valle_max, 
    sigit_t_comp_cg.temp_fumi_monte_min, sigit_t_comp_cg.temp_fumi_monte_max, 
    sigit_t_comp_cg.co_min, sigit_t_comp_cg.co_max, 
    sigit_t_comp_cg.flg_dismissione, sigit_t_allegato.data_controllo, 
    sigit_t_allegato.id_allegato, sigit_t_allegato.fk_tipo_documento, sigit_d_tipo_documento.des_tipo_documento
   FROM sigit_t_comp_cg
   LEFT JOIN sigit_d_marca ON sigit_t_comp_cg.fk_marca = sigit_d_marca.id_marca
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp_cg.fk_combustibile = sigit_d_combustibile.id_combustibile
   LEFT JOIN sigit_t_dett_tipo4 ON sigit_t_dett_tipo4.codice_impianto = sigit_t_comp_cg.codice_impianto 
   AND sigit_t_dett_tipo4.fk_tipo_componente::text = sigit_t_comp_cg.id_tipo_componente::text 
   AND sigit_t_dett_tipo4.progressivo = sigit_t_comp_cg.progressivo 
   AND sigit_t_dett_tipo4.data_install = sigit_t_comp_cg.data_install
   LEFT JOIN sigit_t_allegato ON sigit_t_dett_tipo4.fk_allegato = sigit_t_allegato.id_allegato
   LEFT JOIN sigit_d_tipo_documento ON sigit_t_allegato.fk_tipo_documento = sigit_d_tipo_documento.id_tipo_documento;

GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_sk4_cg TO sigit_new_rw;


---------------------------------------------------------------------------------------
-- 01/07/2019 Storicizzazione con Katia
---------------------------------------------------------------------------------------
CREATE TABLE sigit_wrk_log_prec
(
  codice_fiscale character varying(16),
  data_operazione timestamp without time zone,
  tbl_impattata character varying(30),
  id_record character varying(500),
  tipo_operazione character varying(20),
  id_log serial NOT NULL,
  CONSTRAINT pk_sigit_wrk_log_prec PRIMARY KEY (id_log)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE sigit_wrk_log_prec OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_wrk_log_prec TO sigit_new;
GRANT SELECT, UPDATE, INSERT, TRUNCATE, DELETE ON TABLE sigit_wrk_log_prec TO sigit_new_rw;



/* Passati a Todaro vanno eseguiti dal primo gennaio dell'anno nuovo

delete  from sigit_wrk_log_prec;

insert into sigit_wrk_log_prec 
select * 
from sigit_wrk_log 
where date_part('year', data_operazione) = date_part('year', now())-2;

delete  from sigit_wrk_log where date_part('year', data_operazione) = date_part('year', now())-2 ;
*/

  
  


 -------------------------------------------------------
 -- Libretto
 -------------------------------------------------------
 
 CREATE TABLE sigit_s_libretto
(
  id_libretto numeric NOT NULL,
  fk_stato numeric NOT NULL,
  fk_motivo_consolid numeric,
  fk_tipo_documento numeric NOT NULL,
  data_consolidamento date,
  file_index character varying(100),
  uid_index character varying(50),
  cf_redattore character varying(16),
  flg_controllo_bozza numeric(1,0),
  data_ult_mod timestamp without time zone NOT NULL,
  utente_ult_mod character varying(16) NOT NULL,
  codice_impianto numeric NOT NULL,
  CONSTRAINT pk_sigit_s_libretto PRIMARY KEY (id_libretto));

ALTER TABLE sigit_s_libretto OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_s_libretto TO sigit_new;
GRANT SELECT, UPDATE, INSERT, TRUNCATE, DELETE ON TABLE sigit_s_libretto TO sigit_new_rw;

CREATE INDEX ie1_sigit_s_libretto
  ON sigit_s_libretto
  USING btree
  (codice_impianto);



/* Passati a Todaro 

-- caso istante t0, primo impianto in funzione del rilascio 2019

 delete from sigit_s_libretto 
where date_part('year', data_consolidamento) = date_part('year', now())- 10; 

 insert into sigit_s_libretto 
select * from sigit_t_libretto 
where date_part('year', data_consolidamento) < date_part('year', now())- 4; 

delete  from sigit_t_libretto 
where date_part('year', data_consolidamento) < date_part('year', now())- 4; 



-- caso istante tn, situazione a regime

 delete from sigit_s_libretto 
where date_part('year', data_consolidamento) = date_part('year', now())- 10; 

 insert into sigit_s_libretto 
select * from sigit_t_libretto 
where date_part('year', data_consolidamento) = date_part('year', now())- 4; 

delete  from sigit_t_libretto 
where date_part('year', data_consolidamento) = date_part('year', now())- 4; 

*/


 
 
-----------------------------------------------------------
-- 02/08/2019 - Mail Actis
-- effettuata  in SVI 
-----------------------------------------------------------
 ALTER TABLE sigit_t_allegato DROP COLUMN fk_ispezione_2018;
-- ATTENZIONE non si fa perchè esiste il record 0
-- ALTER TABLE sigit_t_ispezione_2018 ALTER COLUMN codice_impianto DROP NOT NULL;

ALTER TABLE sigit_t_dett_ispez_gf ALTER COLUMN controlloweb DROP NOT NULL;



-----------------------------------------------------------
-- 06/08/2019 - Riunione con  Actis
-- effettuata  in SVI 
-----------------------------------------------------------

-- eliminazione campi butta_xx
ALTER TABLE sigit_r_allegato_comp_gt DROP COLUMN butta_fk_r_pg;
ALTER TABLE sigit_r_allegato_comp_gt DROP COLUMN butta_fk_3r_pg;
ALTER TABLE sigit_r_allegato_comp_gt DROP COLUMN butta_fk_r_pf;
ALTER TABLE sigit_r_allegato_comp_gt DROP COLUMN butta_fk_3resp;
ALTER TABLE sigit_r_allegato_comp_gt DROP COLUMN butta_fk_resp;

ALTER TABLE sigit_r_allegato_comp_gf DROP COLUMN butta_fk_r_pg;
ALTER TABLE sigit_r_allegato_comp_gf DROP COLUMN butta_fk_3r_pg;
ALTER TABLE sigit_r_allegato_comp_gf DROP COLUMN butta_fk_r_pf;
ALTER TABLE sigit_r_allegato_comp_gf DROP COLUMN butta_fk_3resp;
ALTER TABLE sigit_r_allegato_comp_gf DROP COLUMN butta_fk_resp;


-- Completamento campi e constraint dimenticati lo scorso rilascio
ALTER TABLE sigit_r_allegato_comp_gf ADD COLUMN fk_imp_ruolo_pfpg_ispettore numeric;

ALTER TABLE sigit_r_allegato_comp_gf
  ADD CONSTRAINT fk_sigit_r_imp_ruolo_pfpg_11 FOREIGN KEY (fk_imp_ruolo_pfpg_ispettore)
      REFERENCES sigit_r_imp_ruolo_pfpg (id_imp_ruolo_pfpg) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;


ALTER TABLE sigit_r_allegato_comp_gt
  ADD CONSTRAINT fk_sigit_r_imp_ruolo_pfpg_10 FOREIGN KEY (fk_imp_ruolo_pfpg_ispettore)
      REFERENCES sigit_r_imp_ruolo_pfpg (id_imp_ruolo_pfpg) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;
      
      
      
      
-- Indici

create index on sigit_new.sigit_r_allegato_comp_gt (fk_imp_ruolo_pfpg);
create index on sigit_new.sigit_r_allegato_comp_gt (id_tipo_componente,progressivo,codice_impianto,data_install);
create index on sigit_new.sigit_r_allegato_comp_gt (fk_contratto);
create index on sigit_new.sigit_r_comp4_contratto (codice_impianto,id_tipo_componente,progressivo);
create index on sigit_new.sigit_r_comp4_manut (codice_impianto,id_tipo_componente,progressivo);
create index on sigit_new.sigit_r_comp4_manut (fk_ruolo);
create index on sigit_new.sigit_r_imp_ruolo_pfpg (fk_persona_fisica);
create index on sigit_new.sigit_t_allegato (fk_pg_cat);
create index on sigit_new.sigit_t_allegato (fk_stato_rapp);
create index on sigit_new.sigit_t_codice_boll (fk_transazione_boll,fk_potenza,fk_prezzo,fk_dt_inizio_acquisto);
create index on sigit_new.sigit_t_allegato (fk_imp_ruolo_pfpg);
create index on sigit_new.sigit_t_comp4 (id_tipo_componente);
create index on sigit_new.sigit_t_comp_gf (fk_dettaglio_gf);
create index on sigit_new.sigit_t_comp_gf (id_tipo_componente,progressivo,codice_impianto);
create index on sigit_new.sigit_t_comp_gf (fk_marca);
create index on sigit_new.sigit_t_comp_gf (fk_combustibile);
create index on sigit_new.sigit_t_comp_gt (fk_marca);
create index on sigit_new.sigit_t_comp_gt (id_tipo_componente,progressivo,codice_impianto);
create index on sigit_new.sigit_t_comp_gt (fk_combustibile);
create index on sigit_new.sigit_t_allegato (fk_sigla_bollino,fk_numero_bollino);
create index on sigit_new.sigit_t_allegato (fk_tipo_documento);
-- NON FUNZIONA perchè è stato eliminato il campo
--create index on sigit_new.sigit_t_allegato (fk_ispezione_2018);
create index on sigit_new.sigit_t_allegato (fk_tipo_manutenzione);
create index on sigit_new.sigit_r_comp4manut_all (id_r_comp4_manut);
create index on sigit_new.sigit_t_comp_gt (fk_dettaglio_gt);
create index on sigit_new.sigit_t_comp_gt (fk_fluido);
create index on sigit_new.sigit_t_consumo_14_4 (fk_unita_misura);
create index on sigit_new.sigit_t_comp_x (id_tipo_componente);
create index on sigit_new.sigit_t_comp_x (fk_marca);
create index on sigit_new.sigit_t_contratto_2019 (fk_imp_ruolo_pfpg_resp);
create index on sigit_new.sigit_t_contratto_2019 (fk_tipo_cessazione);
create index on sigit_new.sigit_t_contratto_2019 (codice_impianto);
create index on sigit_new.sigit_t_contratto_2019 (fk_pg_3_resp);
create index on sigit_new.sigit_t_contratto (fk_pf_responsabile);
create index on sigit_new.sigit_t_contratto (fk_tipo_contratto);
create index on sigit_new.sigit_t_contratto (fk_pg_3_resp);
create index on sigit_new.sigit_t_contratto (fk_pg_responsabile);
create index on sigit_new.sigit_t_consumo_14_4 (codice_impianto);
create index on sigit_new.sigit_t_dato_distrib (fk_categoria_util);
create index on sigit_new.sigit_t_dato_distrib (fk_unita_misura);
create index on sigit_new.sigit_t_libretto (fk_tipo_documento);
create index on sigit_new.sigit_t_log_distrib (fk_import_distrib);
create index on sigit_new.sigit_t_libretto (fk_motivo_consolid);
create index on sigit_new.sigit_t_libretto (fk_stato);
create index on sigit_new.sigit_t_impianto (fk_stato);
create index on sigit_new.sigit_t_impianto (fk_stato);
create index on sigit_new.sigit_t_dato_distrib (codice_assenza_catast);
create index on sigit_new.sigit_t_dato_distrib (fk_combustibile);
create index on sigit_new.sigit_t_dato_distrib (fk_tipo_contratto);
create index on sigit_new.sigit_t_dato_distrib (fk_import_distrib);
create index on sigit_new.sigit_t_storico_variaz_stato (stato_da);
create index on sigit_new.sigit_t_transazione_boll (id_stato_transazione);
create index on sigit_new.sigit_t_unita_immobiliare (l1_2_fk_categoria);
create index on sigit_new.sigit_t_unita_immobiliare (codice_impianto);
create index on sigit_new.sigit_t_transazione_boll (fk_tipo_pagamento);
create index on sigit_new.sigit_t_storico_variaz_stato (stato_a);
create index on sigit_new.sigit_t_rif_catast (fk_dato_distrib);
create index on sigit_new.sigit_t_rapp_dettaglio (fk_rapporto_controllo);
create index on sigit_new.sigit_t_rapp_controllo (fk_allegato);
create index on sigit_new.sigit_t_persona_giuridica (fk_stato_pg);



-----------------------------------------------------------
-- 20/09/2019 - Mail di  Actis /06/09)
-- effettuata  in SVI con Lorita
-----------------------------------------------------------
ALTER TABLE sigit_t_sanzione ADD COLUMN cf_responsabile character varying(16);
ALTER TABLE sigit_t_sanzione ADD COLUMN denom_ut_responsabile character varying(100);
ALTER TABLE sigit_t_sanzione ADD COLUMN dt_sveglia date;
ALTER TABLE sigit_t_sanzione ADD COLUMN note_sveglia character varying(500);

----------------------------------------------------------------------------------------
-- 09/10/2019  Lorita
-- Creati script per le nuove tabelle progettate insieme a Flora
-- Aggiunte tabelle: sigit_r_ispez_ispet, sigit_s_allegato, sigit_s_rapp_controllo, sigit_s_rapp_dettaglio e loro legami
-- Modificata sigit_t_ispezione_2018 per aggiunta fk_ispez_ispet e legame
-- 10/10/2018  Lorita
-- Corretto legame sigit_r_ispez_ispet - sigit_t_ispezione_2018
----------------------------------------------------------------------------------------
CREATE TABLE sigit_r_ispez_ispet
(
	id_ispez_ispet        NUMERIC(12)  NOT NULL ,
	codice_impianto       NUMERIC  NULL ,
	fk_ruolo              NUMERIC  NULL ,
	data_inizio           DATE  NULL ,
	data_fine             DATE  NULL ,
	fk_persona_fisica     NUMERIC(9)  NULL ,
	fk_persona_giuridica  NUMERIC(9)  NULL ,
	data_ult_mod          TIMESTAMP  NOT NULL ,
	utente_ult_mod        CHARACTER VARYING(16)  NOT NULL ,
	flg_primo_caricatore  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1 CHECK (flg_primo_caricatore IN (0,1)),
	id_ispezione_2018     INTEGER  NULL 
);

ALTER TABLE sigit_r_ispez_ispet
	ADD CONSTRAINT  PK_sigit_r_ispez_ispet PRIMARY KEY (id_ispez_ispet);

ALTER TABLE sigit_r_ispez_ispet OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_r_ispez_ispet TO sigit_new;
GRANT SELECT, UPDATE, INSERT, TRUNCATE, DELETE ON TABLE sigit_r_ispez_ispet TO sigit_new_rw;


CREATE TABLE sigit_s_allegato
(
	id_allegato           NUMERIC  NOT NULL ,
	fk_stato_rapp         NUMERIC(2)  NOT NULL ,
	fk_imp_ruolo_pfpg     NUMERIC  NULL ,
	fk_tipo_documento     NUMERIC  NOT NULL ,
	fk_sigla_bollino      CHARACTER VARYING(2)  NULL ,
	fk_numero_bollino     NUMERIC(11)  NULL ,
	data_controllo        DATE  NOT NULL ,
	b_flg_libretto_uso    NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_lib_uso CHECK (b_flg_libretto_uso IN (0,1,2)),
	b_flg_dichiar_conform  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_dic_conf CHECK (b_flg_dichiar_conform IN (0,1,2)),
	b_flg_lib_imp         NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_lib_imp CHECK (b_flg_lib_imp IN (0,1,2)),
	b_flg_lib_compl       NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_lib_compl CHECK (b_flg_lib_compl IN (0,1,2)),
	f_osservazioni        CHARACTER VARYING(1000)  NULL ,
	f_raccomandazioni     CHARACTER VARYING(1000)  NULL ,
	f_prescrizioni        CHARACTER VARYING(1000)  NULL ,
	f_flg_puo_funzionare  NUMERIC(1)  NULL ,
	f_intervento_entro    DATE  NULL ,
	f_ora_arrivo          CHARACTER VARYING(10)  NULL ,
	f_ora_partenza        CHARACTER VARYING(10)  NULL ,
	f_denominaz_tecnico   CHARACTER VARYING(100)  NULL ,
	f_flg_firma_tecnico   NUMERIC(1)  NULL  CONSTRAINT  dom_0_1 CHECK (f_flg_firma_tecnico IN (0,1)),
	f_flg_firma_responsabile  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_bis CHECK (f_flg_firma_responsabile IN (0,1)),
	data_invio            DATE  NULL ,
	nome_allegato         CHARACTER VARYING(50)  NULL ,
	data_ult_mod          TIMESTAMP  NOT NULL ,
	utente_ult_mod        CHARACTER VARYING(16)  NOT NULL ,
	cf_redattore          CHARACTER VARYING(16)  NULL ,
	uid_index             CHARACTER VARYING(50)  NULL ,
	flg_controllo_bozza   NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_cb CHECK (flg_controllo_bozza IN (0,1)),
	a_potenza_termica_nominale_max  NUMERIC  NULL ,
	f_firma_tecnico       CHAR VARYING(200)  NULL ,
	f_firma_responsabile  CHARACTER VARYING(200)  NULL ,
	elenco_combustibili   CHARACTER VARYING(1000)  NULL ,
	elenco_apparecchiature  CHARACTER VARYING(1000)  NULL ,
	data_respinta 		  DATE   NULL ,
	motivo_respinta       CHARACTER VARYING(500)  NULL ,
	fk_pg_cat             NUMERIC(9)  NULL ,
	abcdf_controlloweb    TIMESTAMP  NULL ,
	fk_tipo_manutenzione  INTEGER  NOT NULL ,
	altro_descr           CHARACTER VARYING(50)  NULL
);

ALTER TABLE sigit_s_allegato
	ADD CONSTRAINT  PK_sigit_s_allegato PRIMARY KEY (id_allegato);

ALTER TABLE sigit_s_allegato OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_s_allegato TO sigit_new;
GRANT SELECT, UPDATE, INSERT, TRUNCATE, DELETE ON TABLE sigit_s_allegato TO sigit_new_rw;


CREATE TABLE sigit_s_rapp_controllo
(
	id_rapporto_controllo  NUMERIC  NOT NULL ,
	fk_allegato           NUMERIC  NOT NULL ,
	note_ufficio          CHARACTER VARYING(500)  NULL ,
	flg_locale_ok         NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_loc CHECK (flg_locale_ok IN (0,1,2)),
	flg_aerazione_ok      NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_aer CHECK (flg_aerazione_ok IN (0,1,2)),
	flg_aerazione_libera  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_lib CHECK (flg_aerazione_libera IN (0,1,2)),
	flg_assenza_fughe_gas  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_gas CHECK (flg_assenza_fughe_gas IN (0,1,2)),
	flg_evacuazione_fumi  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_fumi CHECK (flg_evacuazione_fumi IN (0,1,2)),
	flg_rapporto_controllo  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_rapp CHECK (flg_rapporto_controllo IN (0,1)),
	flg_certificazione    NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_cert CHECK (flg_certificazione IN (0,1)),
	flg_pratica_ispesl    NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_isp CHECK (flg_pratica_ispesl IN (0,1)),
	flg_cert_prev_incendi  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_prev CHECK (flg_cert_prev_incendi IN (0,1)),
	flg_centraletermica   NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_ev CHECK (flg_centraletermica IN (0,1))
);

ALTER TABLE sigit_s_rapp_controllo
	ADD CONSTRAINT  PK_SIGIT_S_RAPP_CONTROLLO PRIMARY KEY (ID_RAPPORTO_CONTROLLO);

ALTER TABLE sigit_s_rapp_controllo OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_s_rapp_controllo TO sigit_new;
GRANT SELECT, UPDATE, INSERT, TRUNCATE, DELETE ON TABLE sigit_s_rapp_controllo TO sigit_new_rw;


CREATE TABLE sigit_s_rapp_dettaglio
(
	id_rapporto_dettaglio  NUMERIC   DEFAULT  0 NOT NULL ,
	fk_rapporto_controllo  NUMERIC  NOT NULL ,
	flg_pendenze          NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_pend CHECK (flg_pendenze IN (0,1,2)),
	flg_sezioni           NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_sez CHECK (flg_sezioni IN (0,1,2)),
	flg_curve             NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_curve CHECK (flg_curve IN (0,1,2)),
	flg_lunghezza         NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_lun CHECK (flg_lunghezza IN (0,1,2)),
	flg_stato_ok          NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_stato CHECK (flg_stato_ok IN (0,1,2)),
	flg_singolo           NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_sing CHECK (flg_singolo IN (0,1,2)),
	flg_a_parete          NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_par CHECK (flg_a_parete IN (0,1,2)),
	flg_no_riflusso       NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_rifl CHECK (flg_no_riflusso IN (0,1,2)),
	flg_coibentazioni     NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_coib CHECK (flg_coibentazioni IN (0,1,2)),
	flg_no_perdite        NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_noperd CHECK (flg_no_perdite IN (0,1,2)),
	flg_cannafumaria_collettiva  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_cann CHECK (flg_cannafumaria_collettiva IN (0,1,2)),
	flg_ugelli_puliti     NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_uge CHECK (flg_ugelli_puliti IN (0,1,2)),
	flg_rompitiraggio_ok  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_rom CHECK (flg_rompitiraggio_ok IN (0,1,2)),
	flg_scambiatore_pulito  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_scpul CHECK (flg_scambiatore_pulito IN (0,1,2)),
	flg_funzionamento_ok  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_funz CHECK (flg_funzionamento_ok IN (0,1,2)),
	flg_dispositivi_ok    NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_disp CHECK (flg_dispositivi_ok IN (0,1,2)),
	flg_assenza_perdite_acqua  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_ass CHECK (flg_assenza_perdite_acqua IN (0,1,2)),
	flg_valvola_sicur_libera  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_valv CHECK (flg_valvola_sicur_libera IN (0,1,2)),
	flg_vaso_esp_carico   NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_esp CHECK (flg_vaso_esp_carico IN (0,1,2)),
	flg_sicurezza_ok      NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_sic CHECK (flg_sicurezza_ok IN (0,1,2)),
	flg_no_usure_deformazioni  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_nousu CHECK (flg_no_usure_deformazioni IN (0,1,2)),
	flg_circuito_aria_libero  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_circ CHECK (flg_circuito_aria_libero IN (0,1,2)),
	flg_accopp_gen_ok     NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_accop CHECK (flg_accopp_gen_ok IN (0,1,2)),
	flg_funzionamento_corretto  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_fcorr CHECK (flg_funzionamento_corretto IN (0,1,2)),
	temp_fumi             NUMERIC(6,2)  NULL ,
	temp_aria             NUMERIC(6,2)  NULL ,
	o2                    NUMERIC(6,2)  NULL ,
	co2                   NUMERIC(6,2)  NULL ,
	bacharach             NUMERIC(6,2)  NULL ,
	co                    NUMERIC(6,2)  NULL ,
	rend_comb             NUMERIC(6,2)  NULL ,
	flg_libretto_bruciatore  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_libbr CHECK (flg_libretto_bruciatore IN (0,1,2)),
	nox                   NUMERIC(6,2)  NULL ,
	flg_libretto_caldaia  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_libcald CHECK (flg_libretto_caldaia IN (0,1,2)),
	note_documentazione   CHARACTER VARYING(500)  NULL ,
	flg_ev_linee_elettriche  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_evlele CHECK (flg_ev_linee_elettriche IN (0,1,2)),
	flg_ev_bruciatore     NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_evbr CHECK (flg_ev_bruciatore IN (0,1,2)),
	flg_ev_generatore_calore  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_evgen CHECK (flg_ev_generatore_calore IN (0,1,2)),
	flg_ev_canali_fumo    NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_evfumo CHECK (flg_ev_canali_fumo IN (0,1,2)),
	flg_controllo_rend    NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_cont CHECK (flg_controllo_rend IN (0,1,2)),
	tiraggio              NUMERIC(6,2)  NULL ,
	note                  CHARACTER VARYING(500)  NULL ,
	b_flg_dichiar_conform numeric(1,0),
	f_raccomandazioni character varying(1000),
	f_prescrizioni character varying(1000)
);

ALTER TABLE sigit_s_rapp_dettaglio
	ADD CONSTRAINT  PK_SIGIT_S_RAPP_DETTAGLIO PRIMARY KEY (ID_RAPPORTO_DETTAGLIO);

ALTER TABLE sigit_s_rapp_controllo OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_s_rapp_controllo TO sigit_new;
GRANT SELECT, UPDATE, INSERT, TRUNCATE, DELETE ON TABLE sigit_s_rapp_controllo TO sigit_new_rw;

-- fk
ALTER TABLE sigit_r_ispez_ispet
	ADD CONSTRAINT  fk_sigit_t_impianto_19 FOREIGN KEY (codice_impianto) REFERENCES sigit_t_impianto(codice_impianto);

ALTER TABLE sigit_r_ispez_ispet
	ADD CONSTRAINT  FK_sigit_t_persona_fisica_12 FOREIGN KEY (fk_persona_fisica) REFERENCES sigit_t_persona_fisica(id_persona_fisica);

ALTER TABLE sigit_r_ispez_ispet
	ADD CONSTRAINT  FK_sigit_t_pers_giuridica_26 FOREIGN KEY (fk_persona_giuridica) REFERENCES sigit_t_persona_giuridica(id_persona_giuridica);

ALTER TABLE sigit_r_ispez_ispet
	ADD CONSTRAINT  fk_sigit_d_ruolo_04 FOREIGN KEY (fk_ruolo) REFERENCES sigit_d_ruolo(id_ruolo);

ALTER TABLE sigit_r_ispez_ispet
	ADD CONSTRAINT  fk_sigit_t_ispezione_2018_01 FOREIGN KEY (id_ispezione_2018) REFERENCES sigit_t_ispezione_2018(id_ispezione_2018);

	
ALTER TABLE sigit_s_allegato
	ADD CONSTRAINT  fk_sigit_d_tipo_manut_02 FOREIGN KEY (fk_tipo_manutenzione) REFERENCES sigit_d_tipo_manutenzione(id_tipo_manutenzione);



ALTER TABLE sigit_s_allegato
	ADD CONSTRAINT  FK_sigit_d_tipo_documento_04 FOREIGN KEY (fk_tipo_documento) REFERENCES sigit_d_tipo_documento(id_tipo_documento);



ALTER TABLE sigit_s_allegato
	ADD CONSTRAINT  FK_sigit_d_stato_rapp_02 FOREIGN KEY (fk_stato_rapp) REFERENCES sigit_d_stato_rapp(id_stato_rapp);



ALTER TABLE sigit_s_allegato
	ADD CONSTRAINT  FK_sigit_t_codice_boll_02 FOREIGN KEY (fk_sigla_bollino,fk_numero_bollino) REFERENCES sigit_t_codice_boll(sigla_bollino,numero_bollino);



ALTER TABLE sigit_s_allegato
	ADD CONSTRAINT  FK_sigit_t_pers_giuridica_25 FOREIGN KEY (fk_pg_cat) REFERENCES sigit_t_persona_giuridica(id_persona_giuridica);



ALTER TABLE sigit_s_allegato
	ADD CONSTRAINT  FK_sigit_r_imp_ruolo_pfpg_12 FOREIGN KEY (fk_imp_ruolo_pfpg) REFERENCES sigit_r_imp_ruolo_pfpg(id_imp_ruolo_pfpg);



ALTER TABLE sigit_s_rapp_controllo
	ADD CONSTRAINT  fk_sigit_s_allegato_01 FOREIGN KEY (fk_allegato) REFERENCES sigit_s_allegato(id_allegato);



ALTER TABLE sigit_s_rapp_dettaglio
	ADD CONSTRAINT  FK_sigit_s_rapp_controllo_01 FOREIGN KEY (fk_rapporto_controllo) REFERENCES sigit_s_rapp_controllo(id_rapporto_controllo);

-- alter tabelle esistenti

-- errato
--ALTER TABLE sigit_t_ispezione_2018 ADD
--	fk_ispez_ispet        NUMERIC(12)  NULL 
--;

-- errato
--ALTER TABLE sigit_t_ispezione_2018
--	ADD CONSTRAINT  FK_sigit_r_ispez_ispet_01 FOREIGN KEY (fk_ispez_ispet) REFERENCES sigit_r_ispez_ispet(id_ispez_ispet);

----------------------------------------------------------------------------------------
-- 11/10/2018  Lorita
-- Corretto legame sigit_r_ispez_ispet - sigit_t_allegato
-- Cancellati campi inutilizzati su sigit_r_allegato_comp_gf, sigit_r_allegato_comp_gt
----------------------------------------------------------------------------------------

ALTER TABLE sigit_t_allegato ADD
	fk_ispez_ispet        NUMERIC(12)  NULL ;

ALTER TABLE sigit_t_allegato
	ADD CONSTRAINT  FK_sigit_r_ispez_ispet_02 FOREIGN KEY (fk_ispez_ispet) REFERENCES sigit_r_ispez_ispet(id_ispez_ispet);
	
ALTER TABLE sigit_r_allegato_comp_gf DROP COLUMN fk_imp_ruolo_pfpg_ispettore;

ALTER TABLE sigit_r_allegato_comp_gt DROP COLUMN fk_imp_ruolo_pfpg_ispettore;

----------------------------------------------------------------------------------------
-- 11/10/2018  Lorita
-- Migrazione allegati
-- Creazione vista allegati storico
----------------------------------------------------------------------------------------

create table sigit_t_allegato_rilascio_2019_11 as
select *
from sigit_t_allegato;

create table sigit_t_rapp_controllo_rilascio_2019_11 as
select *
from sigit_t_rapp_controllo;

create table sigit_t_rapp_dettaglio_rilascio_2019_11 as
select *
from sigit_t_rapp_dettaglio;	

create table sigit_t_all_txt_rilascio_2019_11 as
select *
from sigit_t_all_txt;

insert into sigit_s_allegato (
	id_allegato, 	fk_stato_rapp,	fk_imp_ruolo_pfpg,	fk_tipo_documento,	fk_sigla_bollino,
	fk_numero_bollino,	data_controllo,	b_flg_libretto_uso,	b_flg_dichiar_conform,	b_flg_lib_imp,
	b_flg_lib_compl,	f_osservazioni,	f_raccomandazioni,	f_prescrizioni,	f_flg_puo_funzionare,
	f_intervento_entro,	f_ora_arrivo,	f_ora_partenza,	f_denominaz_tecnico,	f_flg_firma_tecnico,
	f_flg_firma_responsabile,	data_invio,	nome_allegato,	data_ult_mod,	utente_ult_mod,
	cf_redattore,	uid_index,	flg_controllo_bozza,	a_potenza_termica_nominale_max,	f_firma_tecnico,
	f_firma_responsabile,	elenco_combustibili,	elenco_apparecchiature,	data_respinta,	motivo_respinta,
	fk_pg_cat,	abcdf_controlloweb,	fk_tipo_manutenzione,	altro_descr)
select 
	id_allegato, 	fk_stato_rapp,	fk_imp_ruolo_pfpg,	fk_tipo_documento,	fk_sigla_bollino,
	fk_numero_bollino,	data_controllo,	b_flg_libretto_uso,	b_flg_dichiar_conform,	b_flg_lib_imp,
	b_flg_lib_compl,	f_osservazioni,	f_raccomandazioni,	f_prescrizioni,	f_flg_puo_funzionare,
	f_intervento_entro,	f_ora_arrivo,	f_ora_partenza,	f_denominaz_tecnico,	f_flg_firma_tecnico,
	f_flg_firma_responsabile,	data_invio,	nome_allegato,	data_ult_mod,	utente_ult_mod,
	cf_redattore,	uid_index,	flg_controllo_bozza,	a_potenza_termica_nominale_max,	f_firma_tecnico,
	f_firma_responsabile,	elenco_combustibili,	elenco_apparecchiature,	data_respinta,	motivo_respinta,
	fk_pg_cat,	abcdf_controlloweb,	fk_tipo_manutenzione,	altro_descr
from sigit_t_allegato
where fk_tipo_documento IN (1,2);

insert into sigit_s_rapp_controllo 
select *
from sigit_t_rapp_controllo
where fk_allegato in (
select id_allegato
from sigit_t_allegato
where fk_tipo_documento IN (1,2)
);

insert into sigit_s_rapp_dettaglio
select *
from sigit_t_rapp_dettaglio
where fk_rapporto_controllo in (
select id_rapporto_controllo
from sigit_t_rapp_controllo
where fk_allegato in (
select id_allegato
from sigit_t_allegato
where fk_tipo_documento IN (1,2)
)
);

truncate table sigit_t_rapp_dettaglio cascade;

truncate table sigit_t_rapp_controllo cascade;

/*
delete 
from sigit_t_rapp_dettaglio;
where fk_rapporto_controllo in (
select id_rapporto_controllo
from sigit_t_rapp_controllo
where fk_allegato in (
select id_allegato
from sigit_t_allegato
where fk_tipo_documento IN (1,2)
)
);
 */

/*
delete 
from sigit_t_rapp_controllo;
where fk_allegato in (
select id_allegato
from sigit_t_allegato
where fk_tipo_documento IN (1,2)
);
 */

delete 
from sigit_t_all_txt
where id_allegato in (
select id_allegato
from sigit_t_allegato
where fk_tipo_documento IN (1,2)
);

delete from sigit_t_doc_allegato
where id_doc_allegato = 1944;

delete
from sigit_t_allegato
where fk_tipo_documento IN (1,2)
and id_allegato != 0;


CREATE OR REPLACE VIEW vista_ricerca_allegati_storico AS 
         SELECT DISTINCT a.id_allegato, a.fk_stato_rapp, srapp.des_stato_rapp, 
            a.fk_imp_ruolo_pfpg, a.fk_tipo_documento, doc.des_tipo_documento, 
            a.fk_sigla_bollino, a.fk_numero_bollino, a.data_controllo, 
            a.b_flg_libretto_uso, a.b_flg_dichiar_conform, a.b_flg_lib_imp, 
            a.b_flg_lib_compl, a.f_osservazioni, a.f_raccomandazioni, 
            a.f_prescrizioni, a.f_flg_puo_funzionare, a.f_intervento_entro, 
            a.f_ora_arrivo, a.f_ora_partenza, a.f_denominaz_tecnico, 
            a.f_flg_firma_tecnico, a.f_flg_firma_responsabile, a.data_invio, 
            a.data_respinta, a.nome_allegato, a.a_potenza_termica_nominale_max, 
            a.data_ult_mod, a.utente_ult_mod, a.elenco_combustibili, 
            a.elenco_apparecchiature, a.fk_pg_cat, a.altro_descr, ru.des_ruolo, 
            ru.ruolo_funz, pg.id_persona_giuridica, 
            pg.denominazione AS pg_denominazione, 
            pg.codice_fiscale AS pg_codice_fiscale, 
            pg.fk_stato_pg AS pg_fk_stato_pg, pg.sigla_rea AS pg_sigla_rea, 
            pg.numero_rea AS pg_numero_rea, r1.codice_impianto, 
            i.denominazione_comune AS comune_impianto, 
            i.sigla_provincia AS sigla_prov_impianto, 
            COALESCE(u.indirizzo_sitad, u.indirizzo_non_trovato) AS indirizzo_unita_immob, 
            u.civico AS civico_unita_immob, a.flg_controllo_bozza, a.uid_index, 
            tm.id_tipo_manutenzione, tm.des_tipo_manutenzione
           FROM sigit_s_allegato a
      JOIN sigit_r_imp_ruolo_pfpg r1 ON a.fk_imp_ruolo_pfpg = r1.id_imp_ruolo_pfpg
   JOIN sigit_d_ruolo ru ON r1.fk_ruolo = ru.id_ruolo
   JOIN sigit_d_tipo_documento doc ON a.fk_tipo_documento = doc.id_tipo_documento
   JOIN sigit_d_tipo_manutenzione tm ON a.fk_tipo_manutenzione = tm.id_tipo_manutenzione
   JOIN sigit_d_stato_rapp srapp ON a.fk_stato_rapp = srapp.id_stato_rapp
   LEFT JOIN sigit_t_persona_giuridica pg ON r1.fk_persona_giuridica = pg.id_persona_giuridica
   LEFT JOIN sigit_t_impianto i ON r1.codice_impianto = i.codice_impianto
   LEFT JOIN sigit_t_unita_immobiliare u ON r1.codice_impianto = u.codice_impianto
  WHERE u.flg_principale = 1::numeric;

ALTER TABLE vista_ricerca_allegati_storico
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_ricerca_allegati_storico TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_ricerca_allegati_storico TO sigit_new_rw;

----------------------------------------------------------------------------------------
-- 14/10/2018  Lorita
-- Modifica vista_ricerca_allegati
-- Creazione indici sigit_r_ispez_ispet
----------------------------------------------------------------------------------------

-- backup pre modifica vista_ricerca_allegati
/*
CREATE OR REPLACE VIEW vista_ricerca_allegati AS 
         SELECT DISTINCT a.id_allegato, a.fk_stato_rapp, srapp.des_stato_rapp, 
            a.fk_imp_ruolo_pfpg, a.fk_tipo_documento, doc.des_tipo_documento, 
            a.fk_sigla_bollino, a.fk_numero_bollino, a.data_controllo, 
            a.b_flg_libretto_uso, a.b_flg_dichiar_conform, a.b_flg_lib_imp, 
            a.b_flg_lib_compl, a.f_osservazioni, a.f_raccomandazioni, 
            a.f_prescrizioni, a.f_flg_puo_funzionare, a.f_intervento_entro, 
            a.f_ora_arrivo, a.f_ora_partenza, a.f_denominaz_tecnico, 
            a.f_flg_firma_tecnico, a.f_flg_firma_responsabile, a.data_invio, 
            a.data_respinta, a.nome_allegato, a.a_potenza_termica_nominale_max, 
            a.data_ult_mod, a.utente_ult_mod, a.elenco_combustibili, 
            a.elenco_apparecchiature, a.fk_pg_cat, a.altro_descr, ru.des_ruolo, 
            ru.ruolo_funz, pg.id_persona_giuridica, 
            pg.denominazione AS pg_denominazione, 
            pg.codice_fiscale AS pg_codice_fiscale, 
            pg.fk_stato_pg AS pg_fk_stato_pg, pg.sigla_rea AS pg_sigla_rea, 
            pg.numero_rea AS pg_numero_rea, r1.codice_impianto, 
            i.denominazione_comune AS comune_impianto, 
            i.sigla_provincia AS sigla_prov_impianto, 
            COALESCE(u.indirizzo_sitad, u.indirizzo_non_trovato) AS indirizzo_unita_immob, 
            u.civico AS civico_unita_immob, a.flg_controllo_bozza, a.uid_index, 
            tm.id_tipo_manutenzione, tm.des_tipo_manutenzione
           FROM sigit_t_allegato a
      JOIN sigit_r_comp4manut_all ON a.id_allegato = sigit_r_comp4manut_all.id_allegato
   JOIN sigit_r_comp4_manut r1 ON sigit_r_comp4manut_all.id_r_comp4_manut = r1.id_r_comp4_manut
   JOIN sigit_d_ruolo ru ON r1.fk_ruolo = ru.id_ruolo
   JOIN sigit_d_tipo_documento doc ON a.fk_tipo_documento = doc.id_tipo_documento
   JOIN sigit_d_tipo_manutenzione tm ON a.fk_tipo_manutenzione = tm.id_tipo_manutenzione
   JOIN sigit_d_stato_rapp srapp ON a.fk_stato_rapp = srapp.id_stato_rapp
   LEFT JOIN sigit_t_persona_giuridica pg ON r1.fk_persona_giuridica = pg.id_persona_giuridica
   LEFT JOIN sigit_t_impianto i ON r1.codice_impianto = i.codice_impianto
   LEFT JOIN sigit_t_unita_immobiliare u ON r1.codice_impianto = u.codice_impianto
  WHERE u.flg_principale = 1::numeric
UNION 
         SELECT DISTINCT a.id_allegato, a.fk_stato_rapp, srapp.des_stato_rapp, 
            a.fk_imp_ruolo_pfpg, a.fk_tipo_documento, doc.des_tipo_documento, 
            a.fk_sigla_bollino, a.fk_numero_bollino, a.data_controllo, 
            a.b_flg_libretto_uso, a.b_flg_dichiar_conform, a.b_flg_lib_imp, 
            a.b_flg_lib_compl, a.f_osservazioni, a.f_raccomandazioni, 
            a.f_prescrizioni, a.f_flg_puo_funzionare, a.f_intervento_entro, 
            a.f_ora_arrivo, a.f_ora_partenza, a.f_denominaz_tecnico, 
            a.f_flg_firma_tecnico, a.f_flg_firma_responsabile, a.data_invio, 
            a.data_respinta, a.nome_allegato, a.a_potenza_termica_nominale_max, 
            a.data_ult_mod, a.utente_ult_mod, a.elenco_combustibili, 
            a.elenco_apparecchiature, a.fk_pg_cat, a.altro_descr, ru.des_ruolo, 
            ru.ruolo_funz, pg.id_persona_giuridica, 
            pg.denominazione AS pg_denominazione, 
            pg.codice_fiscale AS pg_codice_fiscale, 
            pg.numero_rea AS pg_numero_rea, r1.codice_impianto, 
            pg.fk_stato_pg AS pg_fk_stato_pg, pg.sigla_rea AS pg_sigla_rea, 
            i.denominazione_comune AS comune_impianto, 
            i.sigla_provincia AS sigla_prov_impianto, 
            COALESCE(u.indirizzo_sitad, u.indirizzo_non_trovato) AS indirizzo_unita_immob, 
            u.civico AS civico_unita_immob, a.flg_controllo_bozza, a.uid_index, 
            tm.id_tipo_manutenzione, tm.des_tipo_manutenzione
           FROM sigit_t_allegato a
      JOIN sigit_r_imp_ruolo_pfpg r1 ON a.fk_imp_ruolo_pfpg = r1.id_imp_ruolo_pfpg
   JOIN sigit_d_ruolo ru ON r1.fk_ruolo = ru.id_ruolo
   JOIN sigit_d_tipo_documento doc ON a.fk_tipo_documento = doc.id_tipo_documento
   JOIN sigit_d_tipo_manutenzione tm ON a.fk_tipo_manutenzione = tm.id_tipo_manutenzione
   JOIN sigit_d_stato_rapp srapp ON a.fk_stato_rapp = srapp.id_stato_rapp
   LEFT JOIN sigit_t_persona_giuridica pg ON r1.fk_persona_giuridica = pg.id_persona_giuridica
   LEFT JOIN sigit_t_impianto i ON r1.codice_impianto = i.codice_impianto
   LEFT JOIN sigit_t_unita_immobiliare u ON r1.codice_impianto = u.codice_impianto
  WHERE u.flg_principale = 1::numeric;
*/
-- modifica vista_ricerca_allegati
CREATE OR REPLACE VIEW vista_ricerca_allegati AS 
         SELECT DISTINCT a.id_allegato, a.fk_stato_rapp, srapp.des_stato_rapp, 
            a.fk_ispez_ispet, a.fk_tipo_documento, doc.des_tipo_documento, 
            a.fk_sigla_bollino, a.fk_numero_bollino, a.data_controllo, 
            a.b_flg_libretto_uso, a.b_flg_dichiar_conform, a.b_flg_lib_imp, 
            a.b_flg_lib_compl, a.f_osservazioni, a.f_raccomandazioni, 
            a.f_prescrizioni, a.f_flg_puo_funzionare, a.f_intervento_entro, 
            a.f_ora_arrivo, a.f_ora_partenza, a.f_denominaz_tecnico, 
            a.f_flg_firma_tecnico, a.f_flg_firma_responsabile, a.data_invio, 
            a.data_respinta, a.nome_allegato, a.a_potenza_termica_nominale_max, 
            a.data_ult_mod, a.utente_ult_mod, a.elenco_combustibili, 
            a.elenco_apparecchiature, a.fk_pg_cat, a.altro_descr, ru.des_ruolo, 
            ru.ruolo_funz, pg.id_persona_giuridica, 
            pg.denominazione AS pg_denominazione, 
            pg.codice_fiscale AS pg_codice_fiscale, 
            pg.fk_stato_pg AS pg_fk_stato_pg, pg.sigla_rea AS pg_sigla_rea, 
            pg.numero_rea AS pg_numero_rea, r1.codice_impianto, 
            i.denominazione_comune AS comune_impianto, 
            i.sigla_provincia AS sigla_prov_impianto, 
            COALESCE(u.indirizzo_sitad, u.indirizzo_non_trovato) AS indirizzo_unita_immob, 
            u.civico AS civico_unita_immob, a.flg_controllo_bozza, a.uid_index, 
            tm.id_tipo_manutenzione, tm.des_tipo_manutenzione
           FROM sigit_t_allegato a
      JOIN sigit_r_comp4manut_all ON a.id_allegato = sigit_r_comp4manut_all.id_allegato
   JOIN sigit_r_comp4_manut r1 ON sigit_r_comp4manut_all.id_r_comp4_manut = r1.id_r_comp4_manut
   JOIN sigit_d_ruolo ru ON r1.fk_ruolo = ru.id_ruolo
   JOIN sigit_d_tipo_documento doc ON a.fk_tipo_documento = doc.id_tipo_documento
   JOIN sigit_d_tipo_manutenzione tm ON a.fk_tipo_manutenzione = tm.id_tipo_manutenzione
   JOIN sigit_d_stato_rapp srapp ON a.fk_stato_rapp = srapp.id_stato_rapp
   LEFT JOIN sigit_t_persona_giuridica pg ON r1.fk_persona_giuridica = pg.id_persona_giuridica
   LEFT JOIN sigit_t_impianto i ON r1.codice_impianto = i.codice_impianto
   LEFT JOIN sigit_t_unita_immobiliare u ON r1.codice_impianto = u.codice_impianto
  WHERE u.flg_principale = 1::numeric
UNION 
         SELECT DISTINCT a.id_allegato, a.fk_stato_rapp, srapp.des_stato_rapp, 
            a.fk_ispez_ispet, a.fk_tipo_documento, doc.des_tipo_documento, 
            a.fk_sigla_bollino, a.fk_numero_bollino, a.data_controllo, 
            a.b_flg_libretto_uso, a.b_flg_dichiar_conform, a.b_flg_lib_imp, 
            a.b_flg_lib_compl, a.f_osservazioni, a.f_raccomandazioni, 
            a.f_prescrizioni, a.f_flg_puo_funzionare, a.f_intervento_entro, 
            a.f_ora_arrivo, a.f_ora_partenza, a.f_denominaz_tecnico, 
            a.f_flg_firma_tecnico, a.f_flg_firma_responsabile, a.data_invio, 
            a.data_respinta, a.nome_allegato, a.a_potenza_termica_nominale_max, 
            a.data_ult_mod, a.utente_ult_mod, a.elenco_combustibili, 
            a.elenco_apparecchiature, a.fk_pg_cat, a.altro_descr, ru.des_ruolo, 
            ru.ruolo_funz, pg.id_persona_giuridica, 
            pg.denominazione AS pg_denominazione, 
            pg.codice_fiscale AS pg_codice_fiscale, 
            pg.fk_stato_pg AS pg_fk_stato_pg, pg.sigla_rea AS pg_sigla_rea, 
            pg.numero_rea AS pg_numero_rea, r1.codice_impianto, 
            i.denominazione_comune AS comune_impianto, 
            i.sigla_provincia AS sigla_prov_impianto, 
            COALESCE(u.indirizzo_sitad, u.indirizzo_non_trovato) AS indirizzo_unita_immob, 
            u.civico AS civico_unita_immob, a.flg_controllo_bozza, a.uid_index, 
            tm.id_tipo_manutenzione, tm.des_tipo_manutenzione
           FROM sigit_t_allegato a
      JOIN sigit_r_ispez_ispet r1 ON a.fk_ispez_ispet = r1.id_ispez_ispet
   JOIN sigit_d_ruolo ru ON r1.fk_ruolo = ru.id_ruolo
   JOIN sigit_d_tipo_documento doc ON a.fk_tipo_documento = doc.id_tipo_documento
   JOIN sigit_d_tipo_manutenzione tm ON a.fk_tipo_manutenzione = tm.id_tipo_manutenzione
   JOIN sigit_d_stato_rapp srapp ON a.fk_stato_rapp = srapp.id_stato_rapp
   LEFT JOIN sigit_t_persona_giuridica pg ON r1.fk_persona_giuridica = pg.id_persona_giuridica
   LEFT JOIN sigit_t_impianto i ON r1.codice_impianto = i.codice_impianto
   LEFT JOIN sigit_t_unita_immobiliare u ON r1.codice_impianto = u.codice_impianto
  WHERE u.flg_principale = 1::numeric;

ALTER TABLE vista_ricerca_allegati
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_ricerca_allegati TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_ricerca_allegati TO sigit_new_rw;

-- query di suppoorto inviata a Mariuccia / Beppe
--select *, (select count(*)
-- from sigit_t_verifica v
-- where v.codice_impianto = vista_ricerca_allegati.codice_impianto
-- ) presenza_verifiche
--from vista_ricerca_allegati

CREATE INDEX ind_ispez_ispet_imp
  ON sigit_r_ispez_ispet
  USING btree
  (codice_impianto);

CREATE INDEX ind_ispez_ispet_pf
  ON sigit_r_ispez_ispet
  USING btree
  (fk_persona_fisica);

CREATE INDEX ind_ispez_ispet_pg
  ON sigit_r_ispez_ispet
  USING btree
  (fk_persona_giuridica);
  
CREATE INDEX ind_verifica_imp
  ON sigit_t_verifica
  USING btree
  (codice_impianto);

-- Creazione sequence x sigit_r_ispez_ispet
CREATE SEQUENCE seq_r_ispez_ispet
  INCREMENT 1
  MINVALUE 5000000
  MAXVALUE 9223372036854775807
  START 5000000
  CACHE 1;
ALTER TABLE seq_r_ispez_ispet
  OWNER TO sigit_new;
GRANT ALL ON SEQUENCE seq_r_ispez_ispet TO sigit_new;
GRANT SELECT, UPDATE ON SEQUENCE seq_r_ispez_ispet TO sigit_new_rw;

----------------------------------------------------------------------------------------
-- 17/10/2018  Lorita
-- cancellazione legame fk_imp_ruolo_pfpg su sigit_t_allegato
-- Revisione viste
-- Cancellazione vistee tabelle non più usate
----------------------------------------------------------------------------------------

ALTER TABLE sigit_t_allegato DROP COLUMN 
  fk_imp_ruolo_pfpg CASCADE;
  
-- non serve quindi rinominiamo
ALTER VIEW vista_allegati_ispezione RENAME TO butta_vista_allegati_ispezione;

-- backup pre modifica vista_allegati
/*
CREATE OR REPLACE VIEW vista_allegati AS 
         SELECT a.id_allegato, a.fk_stato_rapp, a.fk_imp_ruolo_pfpg AS fk_tab, 
            a.fk_tipo_documento, doc.des_tipo_documento, a.fk_sigla_bollino, 
            a.fk_numero_bollino, a.data_controllo, a.f_osservazioni, 
            a.f_raccomandazioni, a.f_prescrizioni, a.f_flg_puo_funzionare, 
            a.f_intervento_entro, r1.codice_impianto, a.fk_pg_cat
           FROM sigit_t_allegato a
      JOIN sigit_r_imp_ruolo_pfpg r1 ON a.fk_imp_ruolo_pfpg = r1.id_imp_ruolo_pfpg
   JOIN sigit_d_tipo_documento doc ON a.fk_tipo_documento = doc.id_tipo_documento
UNION 
         SELECT DISTINCT a.id_allegato, a.fk_stato_rapp, 
            r1.id_r_comp4_manut AS fk_tab, a.fk_tipo_documento, 
            doc.des_tipo_documento, a.fk_sigla_bollino, a.fk_numero_bollino, 
            a.data_controllo, a.f_osservazioni, a.f_raccomandazioni, 
            a.f_prescrizioni, a.f_flg_puo_funzionare, a.f_intervento_entro, 
            r1.codice_impianto, a.fk_pg_cat
           FROM sigit_t_allegato a
      JOIN sigit_r_comp4manut_all ON a.id_allegato = sigit_r_comp4manut_all.id_allegato
   JOIN sigit_r_comp4_manut r1 ON sigit_r_comp4manut_all.id_r_comp4_manut = r1.id_r_comp4_manut
   JOIN sigit_d_tipo_documento doc ON a.fk_tipo_documento = doc.id_tipo_documento;
*/
--  modifica vista_allegati
CREATE OR REPLACE VIEW vista_allegati AS 
         SELECT a.id_allegato, a.fk_stato_rapp, a.fk_ispez_ispet AS fk_tab, 
            a.fk_tipo_documento, doc.des_tipo_documento, a.fk_sigla_bollino, 
            a.fk_numero_bollino, a.data_controllo, a.f_osservazioni, 
            a.f_raccomandazioni, a.f_prescrizioni, a.f_flg_puo_funzionare, 
            a.f_intervento_entro, r1.codice_impianto, a.fk_pg_cat
           FROM sigit_t_allegato a
      JOIN sigit_r_ispez_ispet r1 ON a.fk_ispez_ispet = r1.id_ispez_ispet
   JOIN sigit_d_tipo_documento doc ON a.fk_tipo_documento = doc.id_tipo_documento
UNION 
         SELECT DISTINCT a.id_allegato, a.fk_stato_rapp, 
            r1.id_r_comp4_manut AS fk_tab, a.fk_tipo_documento, 
            doc.des_tipo_documento, a.fk_sigla_bollino, a.fk_numero_bollino, 
            a.data_controllo, a.f_osservazioni, a.f_raccomandazioni, 
            a.f_prescrizioni, a.f_flg_puo_funzionare, a.f_intervento_entro, 
            r1.codice_impianto, a.fk_pg_cat
           FROM sigit_t_allegato a
      JOIN sigit_r_comp4manut_all ON a.id_allegato = sigit_r_comp4manut_all.id_allegato
   JOIN sigit_r_comp4_manut r1 ON sigit_r_comp4manut_all.id_r_comp4_manut = r1.id_r_comp4_manut
   JOIN sigit_d_tipo_documento doc ON a.fk_tipo_documento = doc.id_tipo_documento;

-- backup vista_comp_cg_dett
/*
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
            sigit_t_allegato.data_controllo, sigit_t_allegato.fk_stato_rapp, 
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
  WHERE sigit_t_allegato.fk_tipo_documento = 6::numeric
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
            sigit_t_allegato.data_controllo, sigit_t_allegato.fk_stato_rapp, 
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
   LEFT JOIN sigit_t_persona_fisica ON sigit_r_imp_ruolo_pfpg.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica
  WHERE sigit_t_allegato.fk_tipo_documento = 6::numeric;
*/
-- modifica vista_comp_cg_dett
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
            sigit_t_allegato.data_controllo, sigit_t_allegato.fk_stato_rapp, 
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
  WHERE sigit_t_allegato.fk_tipo_documento = 6::numeric
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
            sigit_t_allegato.data_controllo, sigit_t_allegato.fk_stato_rapp, 
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
            sigit_r_ispez_ispet.fk_ruolo, sigit_t_comp_cg.co_min, 
            sigit_t_comp_cg.co_max
           FROM sigit_t_comp_cg
      JOIN sigit_t_dett_tipo4 ON sigit_t_dett_tipo4.codice_impianto = sigit_t_comp_cg.codice_impianto AND sigit_t_dett_tipo4.fk_tipo_componente::text = sigit_t_comp_cg.id_tipo_componente::text AND sigit_t_dett_tipo4.progressivo = sigit_t_comp_cg.progressivo AND sigit_t_dett_tipo4.data_install = sigit_t_comp_cg.data_install
   JOIN sigit_t_allegato ON sigit_t_dett_tipo4.fk_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_ispez_ispet ON sigit_r_ispez_ispet.id_ispez_ispet = sigit_t_allegato.fk_ispez_ispet
   LEFT JOIN sigit_t_persona_giuridica ON sigit_r_ispez_ispet.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
   LEFT JOIN sigit_t_persona_fisica ON sigit_r_ispez_ispet.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica
  WHERE sigit_t_allegato.fk_tipo_documento = 6::numeric;

-- backup vista_comp_gf_dett
/*
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
            sigit_t_allegato.data_controllo, sigit_t_allegato.fk_stato_rapp, 
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
  WHERE sigit_t_allegato.fk_tipo_documento = 4::numeric
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
            sigit_t_allegato.data_controllo, sigit_t_allegato.fk_stato_rapp, 
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
   LEFT JOIN sigit_t_persona_fisica ON sigit_r_imp_ruolo_pfpg.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica
  WHERE sigit_t_allegato.fk_tipo_documento = 4::numeric;
*/
-- modifica vista_comp_gf_dett
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
            sigit_t_allegato.data_controllo, sigit_t_allegato.fk_stato_rapp, 
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
  WHERE sigit_t_allegato.fk_tipo_documento = 4::numeric
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
            sigit_t_allegato.data_controllo, sigit_t_allegato.fk_stato_rapp, 
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
            sigit_r_ispez_ispet.fk_ruolo
           FROM sigit_t_dett_tipo2
      JOIN sigit_t_allegato ON sigit_t_dett_tipo2.fk_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_ispez_ispet ON sigit_r_ispez_ispet.id_ispez_ispet = sigit_t_allegato.fk_ispez_ispet
   LEFT JOIN sigit_t_persona_giuridica ON sigit_r_ispez_ispet.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
   LEFT JOIN sigit_t_persona_fisica ON sigit_r_ispez_ispet.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica
  WHERE sigit_t_allegato.fk_tipo_documento = 4::numeric;

-- backup vista_comp_gt_dett
/*
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
            sigit_t_dett_tipo1.e_nox_ppm, sigit_t_dett_tipo1.e_nox_mg_kwh, 
            sigit_t_dett_tipo1.data_ult_mod AS data_ult_mod_dett, 
            sigit_t_dett_tipo1.utente_ult_mod AS utente_ult_mod_dett, 
            sigit_t_allegato.data_controllo, sigit_t_allegato.fk_stato_rapp, 
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
  WHERE sigit_t_allegato.fk_tipo_documento = 3::numeric
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
            sigit_t_dett_tipo1.e_nox_ppm, sigit_t_dett_tipo1.e_nox_mg_kwh, 
            sigit_t_dett_tipo1.data_ult_mod AS data_ult_mod_dett, 
            sigit_t_dett_tipo1.utente_ult_mod AS utente_ult_mod_dett, 
            sigit_t_allegato.data_controllo, sigit_t_allegato.fk_stato_rapp, 
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
   LEFT JOIN sigit_t_persona_fisica ON sigit_r_imp_ruolo_pfpg.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica
  WHERE sigit_t_allegato.fk_tipo_documento = 3::numeric;
*/
-- modifica vista_comp_gt_dett
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
            sigit_t_dett_tipo1.e_nox_ppm, sigit_t_dett_tipo1.e_nox_mg_kwh, 
            sigit_t_dett_tipo1.data_ult_mod AS data_ult_mod_dett, 
            sigit_t_dett_tipo1.utente_ult_mod AS utente_ult_mod_dett, 
            sigit_t_allegato.data_controllo, sigit_t_allegato.fk_stato_rapp, 
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
  WHERE sigit_t_allegato.fk_tipo_documento = 3::numeric
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
            sigit_t_dett_tipo1.e_nox_ppm, sigit_t_dett_tipo1.e_nox_mg_kwh, 
            sigit_t_dett_tipo1.data_ult_mod AS data_ult_mod_dett, 
            sigit_t_dett_tipo1.utente_ult_mod AS utente_ult_mod_dett, 
            sigit_t_allegato.data_controllo, sigit_t_allegato.fk_stato_rapp, 
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
            sigit_r_ispez_ispet.fk_ruolo
           FROM sigit_t_dett_tipo1
      JOIN sigit_t_allegato ON sigit_t_dett_tipo1.fk_allegato = sigit_t_allegato.id_allegato AND sigit_t_allegato.fk_stato_rapp <> 2::numeric
   JOIN sigit_r_ispez_ispet ON sigit_r_ispez_ispet.id_ispez_ispet = sigit_t_allegato.fk_ispez_ispet
   LEFT JOIN sigit_t_persona_giuridica ON sigit_r_ispez_ispet.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
   LEFT JOIN sigit_t_persona_fisica ON sigit_r_ispez_ispet.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica
  WHERE sigit_t_allegato.fk_tipo_documento = 3::numeric;

-- backup vista_comp_sc_dett
/*
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
            sigit_t_allegato.data_controllo, sigit_t_allegato.fk_stato_rapp, 
            sigit_t_persona_giuridica.sigla_rea, 
            sigit_t_persona_giuridica.numero_rea, 
            sigit_t_persona_giuridica.id_persona_giuridica, 
            sigit_r_comp4_manut.fk_ruolo
           FROM sigit_t_dett_tipo3
      JOIN sigit_t_allegato ON sigit_t_dett_tipo3.fk_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_comp4manut_all ON sigit_r_comp4manut_all.id_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_comp4_manut ON sigit_r_comp4_manut.id_r_comp4_manut = sigit_r_comp4manut_all.id_r_comp4_manut
   JOIN sigit_t_persona_giuridica ON sigit_r_comp4_manut.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
  WHERE sigit_t_allegato.fk_tipo_documento = 5::numeric
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
            sigit_t_allegato.data_controllo, sigit_t_allegato.fk_stato_rapp, 
            sigit_t_persona_giuridica.sigla_rea, 
            sigit_t_persona_giuridica.numero_rea, 
            COALESCE(sigit_t_persona_giuridica.id_persona_giuridica, sigit_t_persona_fisica.id_persona_fisica, sigit_t_persona_giuridica.id_persona_giuridica) AS id_persona_giuridica, 
            sigit_r_imp_ruolo_pfpg.fk_ruolo
           FROM sigit_t_dett_tipo3
      JOIN sigit_t_allegato ON sigit_t_dett_tipo3.fk_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg = sigit_t_allegato.fk_imp_ruolo_pfpg
   LEFT JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
   LEFT JOIN sigit_t_persona_fisica ON sigit_r_imp_ruolo_pfpg.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica
  WHERE sigit_t_allegato.fk_tipo_documento = 5::numeric;
*/
-- modifica vista_comp_sc_dett
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
            sigit_t_allegato.data_controllo, sigit_t_allegato.fk_stato_rapp, 
            sigit_t_persona_giuridica.sigla_rea, 
            sigit_t_persona_giuridica.numero_rea, 
            sigit_t_persona_giuridica.id_persona_giuridica, 
            sigit_r_comp4_manut.fk_ruolo
           FROM sigit_t_dett_tipo3
      JOIN sigit_t_allegato ON sigit_t_dett_tipo3.fk_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_comp4manut_all ON sigit_r_comp4manut_all.id_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_comp4_manut ON sigit_r_comp4_manut.id_r_comp4_manut = sigit_r_comp4manut_all.id_r_comp4_manut
   JOIN sigit_t_persona_giuridica ON sigit_r_comp4_manut.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
  WHERE sigit_t_allegato.fk_tipo_documento = 5::numeric
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
            sigit_t_allegato.data_controllo, sigit_t_allegato.fk_stato_rapp, 
            sigit_t_persona_giuridica.sigla_rea, 
            sigit_t_persona_giuridica.numero_rea, 
            COALESCE(sigit_t_persona_giuridica.id_persona_giuridica, sigit_t_persona_fisica.id_persona_fisica, sigit_t_persona_giuridica.id_persona_giuridica) AS id_persona_giuridica, 
            sigit_r_ispez_ispet.fk_ruolo
           FROM sigit_t_dett_tipo3
      JOIN sigit_t_allegato ON sigit_t_dett_tipo3.fk_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_ispez_ispet ON sigit_r_ispez_ispet.id_ispez_ispet = sigit_t_allegato.fk_ispez_ispet
   LEFT JOIN sigit_t_persona_giuridica ON sigit_r_ispez_ispet.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
   LEFT JOIN sigit_t_persona_fisica ON sigit_r_ispez_ispet.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica
  WHERE sigit_t_allegato.fk_tipo_documento = 5::numeric;

-- non serve quindi rinominiamo
-- ALTER VIEW vista_ricerca_impianti_00 RENAME TO butta_vista_ricerca_impianti_00;

-- backup prima di cancellazione vista_allegati_old
/*
CREATE OR REPLACE VIEW vista_allegati_old AS 
 SELECT a.id_allegato, a.fk_imp_ruolo_pfpg, a.fk_tipo_documento, 
    doc.des_tipo_documento, a.fk_sigla_bollino, a.fk_numero_bollino, 
    a.data_controllo, a.f_osservazioni, a.f_raccomandazioni, a.f_prescrizioni, 
    a.f_flg_puo_funzionare, a.f_intervento_entro, 
    pg.codice_fiscale AS pg_codice_fiscale, r1.codice_impianto
   FROM sigit_t_allegato a
   JOIN sigit_r_imp_ruolo_pfpg r1 ON a.fk_imp_ruolo_pfpg = r1.id_imp_ruolo_pfpg
   JOIN sigit_d_tipo_documento doc ON a.fk_tipo_documento = doc.id_tipo_documento
   JOIN sigit_t_persona_giuridica pg ON r1.fk_persona_giuridica = pg.id_persona_giuridica;

ALTER TABLE vista_allegati_old
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_allegati_old TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_allegati_old TO sigit_new_rw;
*/

-- DROP VIEW vista_allegati_old;
 
-- backup prima di cancellazione vista_ricerca_3_responsabile_old
/*
CREATE OR REPLACE VIEW vista_ricerca_3_responsabile_old AS 
 SELECT a.codice_impianto, ic.id_tipo_componente, ic.progressivo, a.fk_ruolo, 
    dr.des_ruolo, ic.id_contratto, ic.data_caricamento, ic.data_revoca, 
    ic.data_inserimento_revoca, c.fk_pg_3_resp, c.fk_pg_responsabile, 
    c.fk_pf_responsabile, c.data_inizio AS data_inizio_contratto, 
    c.data_fine AS data_fine_contratto, c.flg_tacito_rinnovo, 
    COALESCE(pg.codice_fiscale, pf.codice_fiscale) AS resp_codice_fiscale, 
    COALESCE(pg.denominazione, pf.cognome) AS resp_denominazione, 
    pf.nome AS resp_nome, pg3r.denominazione AS terzo_resp_denominazione, 
    pg3r.sigla_rea AS terzo_resp_sigla_rea, 
    pg3r.numero_rea AS terzo_resp_numero_rea, 
    pg3r.codice_fiscale AS codice_fiscale_3_resp, 
    pg3r.comune AS denom_comune_3_resp, pg3r.sigla_prov AS sigla_prov_3_resp, 
    pg3r.provincia AS denom_provincia_3_resp, 
    imp.denominazione_comune AS denom_comune_impianto, 
    imp.denominazione_provincia AS denom_prov_impianto, 
    imp.sigla_provincia AS sigla_prov_impianto
   FROM sigit_r_imp_ruolo_pfpg a
   JOIN sigit_t_impianto imp ON imp.codice_impianto = a.codice_impianto
   JOIN sigit_r_comp4_contratto ic ON a.codice_impianto = ic.codice_impianto
   JOIN sigit_t_contratto_old c ON ic.id_contratto = c.id_contratto
   JOIN sigit_d_ruolo dr ON dr.id_ruolo = a.fk_ruolo
   LEFT JOIN sigit_t_persona_giuridica pg ON pg.id_persona_giuridica = c.fk_pg_responsabile
   LEFT JOIN sigit_t_persona_fisica pf ON pf.id_persona_fisica = c.fk_pf_responsabile
   JOIN sigit_t_persona_giuridica pg3r ON pg3r.id_persona_giuridica = c.fk_pg_3_resp
  WHERE a.fk_persona_fisica = c.fk_pf_responsabile OR a.fk_persona_giuridica = c.fk_pg_responsabile;
*/

-- DROP VIEW vista_ricerca_3_responsabile_old;

-- backup prima di cancellazione vista_ricerca_impianti_old
/*
CREATE OR REPLACE VIEW vista_ricerca_impianti_old AS 
 SELECT DISTINCT sigit_t_impianto.codice_impianto, 
    sigit_t_impianto.istat_comune, sigit_t_impianto.denominazione_comune, 
    sigit_t_impianto.sigla_provincia, sigit_t_impianto.denominazione_provincia, 
    sigit_t_impianto.fk_stato, sigit_t_impianto.l1_3_pot_h2o_kw, 
    sigit_t_impianto.l1_3_pot_clima_inv_kw, 
    sigit_t_impianto.l1_3_pot_clima_est_kw, sigit_t_unita_immobiliare.flg_nopdr, 
    COALESCE(sigit_t_unita_immobiliare.indirizzo_sitad, sigit_t_unita_immobiliare.indirizzo_non_trovato) AS indirizzo_unita_immob, 
    sigit_t_unita_immobiliare.civico, sigit_t_unita_immobiliare.sezione, 
    sigit_t_unita_immobiliare.foglio, sigit_t_unita_immobiliare.particella, 
    sigit_t_unita_immobiliare.subalterno, 
    sigit_t_unita_immobiliare.pod_elettrico, sigit_t_unita_immobiliare.pdr_gas, 
    q_pf_ruolo.id_pf_responsabile, q_pg_ruolo.id_pg_responsabile, 
    q_contratto.id_pg_3r, 
    COALESCE(q_pf_ruolo.denominazione_resp, q_pg_ruolo.denominazione_resp::text, q_pf_ruolo.denominazione_resp) AS denominazione_responsabile, 
    q_contratto.denominazione_3_responsabile, q_contratto.sigla_rea_3r, 
    q_contratto.numero_rea_3r, q_contratto.codice_fiscale_3r, 
    COALESCE(q_pf_ruolo.codice_fisc, q_pg_ruolo.codice_fisc, q_pf_ruolo.codice_fisc) AS codice_fiscale, 
    COALESCE(q_pf_ruolo.data_fine_pfpg, q_pg_ruolo.data_fine_pfpg, q_pf_ruolo.data_fine_pfpg) AS data_fine_pfpg, 
    COALESCE(q_pf_ruolo.ruolo_resp, q_pg_ruolo.ruolo_resp, q_pf_ruolo.ruolo_resp) AS ruolo_responsabile, 
    COALESCE(q_pf_ruolo.ruolo_funz1, q_pg_ruolo.ruolo_funz1, q_pf_ruolo.ruolo_funz1) AS ruolo_funz, 
    sigit_t_impianto.flg_tipo_impianto, sigit_t_impianto.flg_apparecc_ui_ext, 
    sigit_t_impianto.flg_contabilizzazione, sigit_d_stato_imp.des_stato
   FROM sigit_t_impianto
   JOIN sigit_d_stato_imp ON sigit_t_impianto.fk_stato = sigit_d_stato_imp.id_stato
   JOIN sigit_t_unita_immobiliare ON sigit_t_impianto.codice_impianto = sigit_t_unita_immobiliare.codice_impianto
   LEFT JOIN ( SELECT sigit_r_imp_ruolo_pfpg_1.id_imp_ruolo_pfpg, 
    sigit_r_imp_ruolo_pfpg_1.codice_impianto, 
    sigit_r_imp_ruolo_pfpg_1.data_fine AS data_fine_pfpg, 
    sigit_t_persona_fisica.id_persona_fisica AS id_pf_responsabile, 
    sigit_t_persona_fisica.codice_fiscale AS codice_fisc, 
    (COALESCE(sigit_t_persona_fisica.cognome, ' '::character varying)::text || ' '::text) || COALESCE(sigit_t_persona_fisica.nome, ' '::character varying)::text AS denominazione_resp, 
    sigit_r_imp_ruolo_pfpg_1.fk_ruolo AS ruolo_resp, 
    sigit_d_ruolo.ruolo_funz AS ruolo_funz1, now() AS data_validita, 
    sigit_r_imp_ruolo_pfpg_1.data_inizio, sigit_r_imp_ruolo_pfpg_1.data_fine
   FROM sigit_d_ruolo
   JOIN (sigit_r_imp_ruolo_pfpg sigit_r_imp_ruolo_pfpg_1
   JOIN sigit_t_persona_fisica ON sigit_r_imp_ruolo_pfpg_1.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica) ON sigit_d_ruolo.id_ruolo = sigit_r_imp_ruolo_pfpg_1.fk_ruolo
  WHERE (sigit_r_imp_ruolo_pfpg_1.fk_ruolo = ANY (ARRAY[4::numeric, 5::numeric, 10::numeric, 11::numeric, 12::numeric, 13::numeric])) AND sigit_r_imp_ruolo_pfpg_1.data_inizio <= now() AND now() <= COALESCE(sigit_r_imp_ruolo_pfpg_1.data_fine::timestamp with time zone, now(), sigit_r_imp_ruolo_pfpg_1.data_fine::timestamp with time zone)) q_pf_ruolo ON sigit_t_impianto.codice_impianto = q_pf_ruolo.codice_impianto
   LEFT JOIN ( SELECT sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg, 
    sigit_r_imp_ruolo_pfpg.codice_impianto, 
    sigit_r_imp_ruolo_pfpg.data_fine AS data_fine_pfpg, 
    sigit_t_persona_giuridica.id_persona_giuridica AS id_pg_responsabile, 
    sigit_t_persona_giuridica.codice_fiscale AS codice_fisc, 
    sigit_t_persona_giuridica.denominazione AS denominazione_resp, 
    sigit_r_imp_ruolo_pfpg.fk_ruolo AS ruolo_resp, 
    sigit_d_ruolo.ruolo_funz AS ruolo_funz1, now() AS data_validita, 
    sigit_r_imp_ruolo_pfpg.data_inizio, sigit_r_imp_ruolo_pfpg.data_fine
   FROM sigit_d_ruolo
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_d_ruolo.id_ruolo = sigit_r_imp_ruolo_pfpg.fk_ruolo
   JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
  WHERE (sigit_r_imp_ruolo_pfpg.fk_ruolo = ANY (ARRAY[4::numeric, 5::numeric, 10::numeric, 11::numeric, 12::numeric, 13::numeric])) AND sigit_r_imp_ruolo_pfpg.data_inizio <= now() AND now() <= COALESCE(sigit_r_imp_ruolo_pfpg.data_fine::timestamp with time zone, now(), sigit_r_imp_ruolo_pfpg.data_fine::timestamp with time zone)) q_pg_ruolo ON sigit_t_impianto.codice_impianto = q_pg_ruolo.codice_impianto
   LEFT JOIN ( SELECT sigit_t_contratto.id_contratto, 
    sigit_r_comp4_contratto.codice_impianto, 
    sigit_r_comp4_contratto.data_revoca, sigit_t_contratto.flg_tacito_rinnovo, 
    sigit_t_contratto.data_inizio, 
    sigit_t_persona_giuridica_1.id_persona_giuridica AS id_pg_3r, 
    sigit_t_persona_giuridica_1.denominazione AS denominazione_3_responsabile, 
    sigit_t_persona_giuridica_1.sigla_rea AS sigla_rea_3r, 
    sigit_t_persona_giuridica_1.numero_rea AS numero_rea_3r, 
    sigit_t_persona_giuridica_1.codice_fiscale AS codice_fiscale_3r
   FROM sigit_d_tipo_contratto
   JOIN (sigit_r_comp4_contratto
   JOIN sigit_t_contratto_old sigit_t_contratto ON sigit_r_comp4_contratto.id_contratto = sigit_t_contratto.id_contratto
   JOIN sigit_t_persona_giuridica sigit_t_persona_giuridica_1 ON sigit_t_contratto.fk_pg_3_resp = sigit_t_persona_giuridica_1.id_persona_giuridica) ON sigit_d_tipo_contratto.id_tipo_contratto = sigit_t_contratto.fk_tipo_contratto
  WHERE sigit_r_comp4_contratto.data_revoca IS NULL AND (sigit_t_contratto.flg_tacito_rinnovo = 1::numeric OR sigit_t_contratto.flg_tacito_rinnovo = 0::numeric AND sigit_t_contratto.data_fine >= now()::date)) q_contratto ON sigit_t_impianto.codice_impianto = q_contratto.codice_impianto
  WHERE sigit_t_unita_immobiliare.flg_principale = 1::numeric;
*/

-- DROP VIEW vista_ricerca_impianti_old;

-- backup prima di cancellazione vista_tot_impianto_butta
/*
CREATE OR REPLACE VIEW vista_tot_impianto_butta AS 
         SELECT sigit_t_impianto.codice_impianto, 
            sigit_t_impianto.denominazione_provincia, 
            sigit_t_impianto.sigla_provincia, sigit_t_impianto.istat_comune, 
            sigit_t_impianto.denominazione_comune, 
            sigit_t_unita_immobiliare.indirizzo_sitad, 
            sigit_t_unita_immobiliare.civico, 
            sigit_t_unita_immobiliare.flg_principale, 
            'PF'::character varying(2) AS pf_pg, 
            sigit_t_persona_fisica.id_persona_fisica, 
            sigit_t_persona_fisica.nome, 
            sigit_t_persona_fisica.cognome AS denominazione, 
            sigit_d_ruolo.id_ruolo, sigit_d_ruolo.des_ruolo, 
            sigit_d_ruolo.ruolo_funz, sigit_t_persona_fisica.codice_fiscale, 
            NULL::character varying(2) AS sigla_rea, 
            NULL::numeric(11,0) AS numero_rea, 
            sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg, 
            sigit_t_contratto_2019.data_inizio AS data_inizio_contratto, 
            sigit_t_contratto_2019.data_fine AS data_fine_contratto, 
            sigit_t_contratto_2019.fk_pg_3_resp AS id_persona_giuridica_3r, 
            sigit_t_persona_giuridica.codice_fiscale AS codice_fiscale_3r, 
            sigit_t_persona_giuridica.sigla_rea AS sigla_rea_3r, 
            sigit_t_persona_giuridica.numero_rea AS numero_rea_3r, 
            sigit_t_persona_giuridica.denominazione AS denominazione_3r, 
            (sigit_t_persona_fisica.cognome::text || ' '::text) || sigit_t_persona_fisica.nome::text AS contratto_resp_pf, 
            NULL::character varying(100) AS contratto_resp_pg, 
            sigit_r_imp_ruolo_pfpg.data_inizio AS data_inizio_pfpg, 
            sigit_r_imp_ruolo_pfpg.data_fine AS data_fine_pfpg, 
            sigit_t_contratto_2019.id_contratto, 
            sigit_t_contratto_2019.data_cessazione, 
            sigit_t_contratto_2019.flg_tacito_rinnovo
           FROM sigit_t_impianto
      LEFT JOIN sigit_t_contratto_2019 ON sigit_t_impianto.codice_impianto = sigit_t_contratto_2019.codice_impianto
   LEFT JOIN sigit_t_persona_giuridica ON sigit_t_contratto_2019.fk_pg_3_resp = sigit_t_persona_giuridica.id_persona_giuridica
   LEFT JOIN sigit_t_unita_immobiliare ON sigit_t_impianto.codice_impianto = sigit_t_unita_immobiliare.codice_impianto
   LEFT JOIN (sigit_r_imp_ruolo_pfpg
   LEFT JOIN sigit_d_ruolo ON sigit_r_imp_ruolo_pfpg.fk_ruolo = sigit_d_ruolo.id_ruolo
   LEFT JOIN sigit_t_persona_fisica ON sigit_r_imp_ruolo_pfpg.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica) ON sigit_t_contratto_2019.fk_imp_ruolo_pfpg_resp = sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg
  WHERE sigit_t_unita_immobiliare.flg_principale = 1::numeric AND (sigit_t_contratto_2019.data_cessazione IS NULL AND sigit_t_contratto_2019.flg_tacito_rinnovo = 1::numeric OR sigit_t_contratto_2019.data_cessazione IS NULL AND sigit_t_contratto_2019.flg_tacito_rinnovo = 0::numeric AND sigit_t_contratto_2019.data_fine > now())
UNION 
         SELECT sigit_t_impianto.codice_impianto, 
            sigit_t_impianto.denominazione_provincia, 
            sigit_t_impianto.sigla_provincia, sigit_t_impianto.istat_comune, 
            sigit_t_impianto.denominazione_comune, 
            sigit_t_unita_immobiliare.indirizzo_sitad, 
            sigit_t_unita_immobiliare.civico, 
            sigit_t_unita_immobiliare.flg_principale, 
            'PF'::character varying(2) AS pf_pg, 
            pg2.id_persona_giuridica AS id_persona_fisica, 
            NULL::character varying(100) AS nome, pg2.denominazione, 
            sigit_d_ruolo.id_ruolo, sigit_d_ruolo.des_ruolo, 
            sigit_d_ruolo.ruolo_funz, pg2.codice_fiscale, pg2.sigla_rea, 
            pg2.numero_rea, sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg, 
            sigit_t_contratto_2019.data_inizio AS data_inizio_contratto, 
            sigit_t_contratto_2019.data_fine AS data_fine_contratto, 
            sigit_t_contratto_2019.fk_pg_3_resp AS id_persona_giuridica_3r, 
            sigit_t_persona_giuridica.codice_fiscale AS codice_fiscale_3r, 
            sigit_t_persona_giuridica.sigla_rea AS sigla_rea_3r, 
            sigit_t_persona_giuridica.numero_rea AS numero_rea_3r, 
            sigit_t_persona_giuridica.denominazione AS denominazione_3r, 
            NULL::character varying(100) AS contratto_resp_pf, 
            pg2.denominazione AS contratto_resp_pg, 
            sigit_r_imp_ruolo_pfpg.data_inizio AS data_inizio_pfpg, 
            sigit_r_imp_ruolo_pfpg.data_fine AS data_fine_pfpg, 
            sigit_t_contratto_2019.id_contratto, 
            sigit_t_contratto_2019.data_cessazione, 
            sigit_t_contratto_2019.flg_tacito_rinnovo
           FROM sigit_t_impianto
      LEFT JOIN sigit_t_contratto_2019 ON sigit_t_impianto.codice_impianto = sigit_t_contratto_2019.codice_impianto
   LEFT JOIN sigit_t_persona_giuridica ON sigit_t_contratto_2019.fk_pg_3_resp = sigit_t_persona_giuridica.id_persona_giuridica
   LEFT JOIN sigit_t_unita_immobiliare ON sigit_t_impianto.codice_impianto = sigit_t_unita_immobiliare.codice_impianto
   LEFT JOIN (sigit_r_imp_ruolo_pfpg
   LEFT JOIN sigit_d_ruolo ON sigit_r_imp_ruolo_pfpg.fk_ruolo = sigit_d_ruolo.id_ruolo
   LEFT JOIN sigit_t_persona_giuridica pg2 ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = pg2.id_persona_giuridica) ON sigit_t_contratto_2019.fk_imp_ruolo_pfpg_resp = sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg
  WHERE sigit_t_unita_immobiliare.flg_principale = 1::numeric AND (sigit_t_contratto_2019.data_cessazione IS NULL AND sigit_t_contratto_2019.flg_tacito_rinnovo = 1::numeric OR sigit_t_contratto_2019.data_cessazione IS NULL AND sigit_t_contratto_2019.flg_tacito_rinnovo = 0::numeric AND sigit_t_contratto_2019.data_fine > now());
*/

-- DROP VIEW vista_tot_impianto_butta;

-- backup prima di cancellazione vista_tot_impianto_old
/*
CREATE OR REPLACE VIEW vista_tot_impianto_old AS 
         SELECT sigit_t_impianto.codice_impianto, 
            sigit_t_impianto.denominazione_provincia, 
            sigit_t_impianto.sigla_provincia, sigit_t_impianto.istat_comune, 
            sigit_t_impianto.denominazione_comune, 
            COALESCE(sigit_t_unita_immobiliare.indirizzo_sitad, sigit_t_unita_immobiliare.indirizzo_non_trovato) AS indirizzo_unita_immob, 
            sigit_t_unita_immobiliare.civico, 
            sigit_t_unita_immobiliare.flg_principale, 
            'PF'::character varying(2) AS pf_pg, 
            sigit_t_persona_fisica.id_persona_fisica, 
            sigit_t_persona_fisica.nome, 
            sigit_t_persona_fisica.cognome AS denominazione, 
            sigit_d_ruolo.id_ruolo, sigit_d_ruolo.des_ruolo, 
            sigit_d_ruolo.ruolo_funz, sigit_t_persona_fisica.codice_fiscale, 
            NULL::character varying(2) AS sigla_rea, 
            NULL::numeric(11,0) AS numero_rea, 
            sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg, 
            cont.data_inizio_contratto, cont.data_fine_contratto, 
            cont.id_persona_giuridica_3r, cont.denominazione_3r, 
            cont.codice_fiscale_3r, cont.sigla_rea_3r, cont.numero_rea_3r, 
            cont.contratto_resp_pf, cont.contratto_resp_pg, 
            sigit_t_comp4.id_tipo_componente, sigit_t_comp4.progressivo, 
            sigit_r_imp_ruolo_pfpg.data_inizio AS data_inizio_pfpg, 
            sigit_r_imp_ruolo_pfpg.data_fine AS data_fine_pfpg, 
            cont.id_contratto, cont.data_revoca, cont.flg_tacito_rinnovo, 
            cont.des_tipo_contratto
           FROM sigit_t_unita_immobiliare
      JOIN sigit_t_impianto ON sigit_t_unita_immobiliare.codice_impianto = sigit_t_impianto.codice_impianto
   LEFT JOIN sigit_t_comp4 ON sigit_t_impianto.codice_impianto = sigit_t_comp4.codice_impianto
   JOIN (sigit_t_persona_fisica
   JOIN (sigit_d_ruolo
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_d_ruolo.id_ruolo = sigit_r_imp_ruolo_pfpg.fk_ruolo) ON sigit_t_persona_fisica.id_persona_fisica = sigit_r_imp_ruolo_pfpg.fk_persona_fisica) ON sigit_t_impianto.codice_impianto = sigit_r_imp_ruolo_pfpg.codice_impianto
   LEFT JOIN ( SELECT sigit_t_contratto.id_contratto, 
    sigit_r_comp4_contratto.codice_impianto, 
    sigit_r_comp4_contratto.data_revoca, sigit_t_contratto.flg_tacito_rinnovo, 
    sigit_t_contratto.data_inizio AS data_inizio_contratto, 
    sigit_t_contratto.data_fine AS data_fine_contratto, 
    sigit_t_contratto.nome_file_index, sigit_t_contratto.uid_index, 
    sigit_d_tipo_contratto.des_tipo_contratto, 
    sigit_t_persona_giuridica.id_persona_giuridica AS id_persona_giuridica_3r, 
    sigit_t_persona_giuridica.denominazione AS denominazione_3r, 
    sigit_t_persona_giuridica.codice_fiscale AS codice_fiscale_3r, 
    sigit_t_persona_giuridica.sigla_rea AS sigla_rea_3r, 
    sigit_t_persona_giuridica.numero_rea AS numero_rea_3r, 
    (sigit_t_persona_fisica.cognome::text || ' '::text) || sigit_t_persona_fisica.nome::text AS contratto_resp_pf, 
    sigit_t_persona_giuridica_1.denominazione AS contratto_resp_pg
   FROM sigit_t_persona_giuridica
   JOIN (sigit_t_persona_fisica
   RIGHT JOIN (sigit_t_contratto_old sigit_t_contratto
   JOIN sigit_r_comp4_contratto ON sigit_t_contratto.id_contratto = sigit_r_comp4_contratto.id_contratto) ON sigit_t_persona_fisica.id_persona_fisica = sigit_t_contratto.fk_pf_responsabile) ON sigit_t_persona_giuridica.id_persona_giuridica = sigit_t_contratto.fk_pg_3_resp
   LEFT JOIN sigit_t_persona_giuridica sigit_t_persona_giuridica_1 ON sigit_t_contratto.fk_pg_responsabile = sigit_t_persona_giuridica_1.id_persona_giuridica
   JOIN sigit_d_tipo_contratto ON sigit_t_contratto.fk_tipo_contratto = sigit_d_tipo_contratto.id_tipo_contratto
  WHERE sigit_r_comp4_contratto.data_revoca IS NULL AND sigit_t_contratto.flg_tacito_rinnovo = 1::numeric OR sigit_r_comp4_contratto.data_revoca IS NULL AND sigit_t_contratto.flg_tacito_rinnovo = 0::numeric AND sigit_t_contratto.data_fine > now()) cont ON sigit_t_impianto.codice_impianto = cont.codice_impianto
  WHERE sigit_t_unita_immobiliare.flg_principale = 1::numeric
UNION 
         SELECT sigit_t_impianto.codice_impianto, 
            sigit_t_impianto.denominazione_provincia, 
            sigit_t_impianto.sigla_provincia, sigit_t_impianto.istat_comune, 
            sigit_t_impianto.denominazione_comune, 
            COALESCE(sigit_t_unita_immobiliare.indirizzo_sitad, sigit_t_unita_immobiliare.indirizzo_non_trovato) AS indirizzo_unita_immob, 
            sigit_t_unita_immobiliare.civico, 
            sigit_t_unita_immobiliare.flg_principale, 
            'PG'::character varying(2) AS pf_pg, 
            sigit_t_persona_giuridica.id_persona_giuridica AS id_persona_fisica, 
            NULL::character varying(100) AS nome, 
            sigit_t_persona_giuridica.denominazione, sigit_d_ruolo.id_ruolo, 
            sigit_d_ruolo.des_ruolo, sigit_d_ruolo.ruolo_funz, 
            sigit_t_persona_giuridica.codice_fiscale, 
            sigit_t_persona_giuridica.sigla_rea, 
            sigit_t_persona_giuridica.numero_rea, 
            sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg, 
            cont.data_inizio_contratto, cont.data_fine_contratto, 
            cont.id_persona_giuridica_3r, cont.denominazione_3r, 
            cont.codice_fiscale_3r, cont.sigla_rea_3r, cont.numero_rea_3r, 
            cont.contratto_resp_pf, cont.contratto_resp_pg, 
            sigit_t_comp4.id_tipo_componente, sigit_t_comp4.progressivo, 
            sigit_r_imp_ruolo_pfpg.data_inizio AS data_inizio_pfpg, 
            sigit_r_imp_ruolo_pfpg.data_fine AS data_fine_pfpg, 
            cont.id_contratto, cont.data_revoca, cont.flg_tacito_rinnovo, 
            cont.des_tipo_contratto
           FROM sigit_t_unita_immobiliare
      JOIN sigit_t_impianto ON sigit_t_unita_immobiliare.codice_impianto = sigit_t_impianto.codice_impianto
   LEFT JOIN sigit_t_comp4 ON sigit_t_impianto.codice_impianto = sigit_t_comp4.codice_impianto
   JOIN (sigit_t_persona_giuridica
   JOIN (sigit_d_ruolo
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_d_ruolo.id_ruolo = sigit_r_imp_ruolo_pfpg.fk_ruolo) ON sigit_t_persona_giuridica.id_persona_giuridica = sigit_r_imp_ruolo_pfpg.fk_persona_giuridica) ON sigit_t_impianto.codice_impianto = sigit_r_imp_ruolo_pfpg.codice_impianto
   LEFT JOIN ( SELECT sigit_t_contratto.id_contratto, 
    sigit_r_comp4_contratto.codice_impianto, 
    sigit_r_comp4_contratto.data_revoca, sigit_t_contratto.flg_tacito_rinnovo, 
    sigit_t_contratto.data_inizio AS data_inizio_contratto, 
    sigit_t_contratto.data_fine AS data_fine_contratto, 
    sigit_t_contratto.nome_file_index, sigit_t_contratto.uid_index, 
    sigit_d_tipo_contratto.des_tipo_contratto, 
    sigit_t_persona_giuridica.id_persona_giuridica AS id_persona_giuridica_3r, 
    sigit_t_persona_giuridica.denominazione AS denominazione_3r, 
    sigit_t_persona_giuridica.codice_fiscale AS codice_fiscale_3r, 
    sigit_t_persona_giuridica.sigla_rea AS sigla_rea_3r, 
    sigit_t_persona_giuridica.numero_rea AS numero_rea_3r, 
    (sigit_t_persona_fisica.cognome::text || ' '::text) || sigit_t_persona_fisica.nome::text AS contratto_resp_pf, 
    sigit_t_persona_giuridica_1.denominazione AS contratto_resp_pg
   FROM sigit_t_persona_giuridica
   JOIN (sigit_t_persona_fisica
   RIGHT JOIN (sigit_t_contratto_old sigit_t_contratto
   JOIN sigit_r_comp4_contratto ON sigit_t_contratto.id_contratto = sigit_r_comp4_contratto.id_contratto) ON sigit_t_persona_fisica.id_persona_fisica = sigit_t_contratto.fk_pf_responsabile) ON sigit_t_persona_giuridica.id_persona_giuridica = sigit_t_contratto.fk_pg_3_resp
   LEFT JOIN sigit_t_persona_giuridica sigit_t_persona_giuridica_1 ON sigit_t_contratto.fk_pg_responsabile = sigit_t_persona_giuridica_1.id_persona_giuridica
   JOIN sigit_d_tipo_contratto ON sigit_t_contratto.fk_tipo_contratto = sigit_d_tipo_contratto.id_tipo_contratto
  WHERE sigit_r_comp4_contratto.data_revoca IS NULL AND sigit_t_contratto.flg_tacito_rinnovo = 1::numeric OR sigit_r_comp4_contratto.data_revoca IS NULL AND sigit_t_contratto.flg_tacito_rinnovo = 0::numeric AND sigit_t_contratto.data_fine > now()) cont ON sigit_t_impianto.codice_impianto = cont.codice_impianto
  WHERE sigit_t_unita_immobiliare.flg_principale = 1::numeric;
*/

-- DROP VIEW vista_tot_impianto_old;

-- backup pre modifica vista_ricerca_ispezioni
/*
CREATE OR REPLACE VIEW vista_ricerca_ispezioni AS 
 SELECT sigit_r_imp_ruolo_pfpg.codice_impianto, 
    sigit_t_ispezione.id_imp_ruolo_pfpg, sigit_t_ispezione.fk_stato_ispezione, 
    sigit_d_stato_ispezione.des_stato_ispezione, 
    sigit_t_ispezione.ente_competente, sigit_t_ispezione.data_ispezione, 
    sigit_t_ispezione.flg_esito, sigit_t_ispezione.data_ult_mod, 
    sigit_t_ispezione.utente_ult_mod, sigit_t_ispezione.note, 
    sigit_t_allegato.id_allegato, sigit_t_allegato.fk_stato_rapp, 
    sigit_d_stato_rapp.des_stato_rapp, sigit_t_allegato.fk_tipo_documento, 
    sigit_d_tipo_documento.des_tipo_documento, 
    sigit_t_allegato.fk_sigla_bollino, sigit_t_allegato.fk_numero_bollino, 
    sigit_t_allegato.data_controllo, sigit_t_allegato.b_flg_libretto_uso, 
    sigit_t_allegato.b_flg_dichiar_conform, sigit_t_allegato.b_flg_lib_imp, 
    sigit_t_allegato.b_flg_lib_compl, sigit_t_allegato.f_osservazioni, 
    sigit_t_allegato.f_raccomandazioni, sigit_t_allegato.f_prescrizioni, 
    sigit_t_allegato.f_flg_puo_funzionare, sigit_t_allegato.f_intervento_entro, 
    sigit_t_allegato.f_ora_arrivo, sigit_t_allegato.f_ora_partenza, 
    sigit_t_allegato.f_denominaz_tecnico, sigit_t_allegato.f_flg_firma_tecnico, 
    sigit_t_allegato.f_flg_firma_responsabile, sigit_t_allegato.data_invio, 
    sigit_t_allegato.nome_allegato, 
    sigit_t_allegato.data_ult_mod AS data_ult_mod_allegato, 
    sigit_t_allegato.utente_ult_mod AS utente_ult_mod_allegato, 
    sigit_t_allegato.cf_redattore, sigit_t_allegato.uid_index, 
    sigit_t_allegato.f_firma_tecnico, sigit_t_allegato.f_firma_responsabile, 
    sigit_t_allegato.flg_controllo_bozza, 
    sigit_t_allegato.a_potenza_termica_nominale_max, 
    sigit_t_allegato.elenco_combustibili, 
    sigit_t_allegato.elenco_apparecchiature, 
    sigit_t_persona_fisica.id_persona_fisica, sigit_t_persona_fisica.nome, 
    sigit_t_persona_fisica.cognome, sigit_t_persona_fisica.codice_fiscale
   FROM sigit_t_ispezione
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_t_ispezione.id_imp_ruolo_pfpg = sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg
   JOIN sigit_t_persona_fisica ON sigit_r_imp_ruolo_pfpg.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica
   LEFT JOIN sigit_t_allegato ON sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg = sigit_t_allegato.fk_imp_ruolo_pfpg
   LEFT JOIN sigit_d_tipo_documento ON sigit_t_allegato.fk_tipo_documento = sigit_d_tipo_documento.id_tipo_documento
   LEFT JOIN sigit_d_stato_rapp ON sigit_t_allegato.fk_stato_rapp = sigit_d_stato_rapp.id_stato_rapp
   JOIN sigit_d_stato_ispezione ON sigit_t_ispezione.fk_stato_ispezione = sigit_d_stato_ispezione.id_stato_ispezione
  WHERE sigit_r_imp_ruolo_pfpg.fk_ruolo = 2::numeric;
*/
-- modifica vista_ricerca_ispezioni CAMPI DIVERSI
/*
DROP VIEW vista_ricerca_ispezioni;

CREATE OR REPLACE VIEW vista_ricerca_ispezioni AS 
 SELECT sigit_t_ispezione_2018.id_ispezione_2018, 
    sigit_r_ispez_ispet.codice_impianto, sigit_r_ispez_ispet.id_ispez_ispet, 
    sigit_t_ispezione_2018.fk_stato_ispezione, 
    sigit_d_stato_ispezione.des_stato_ispezione, 
    sigit_t_ispezione_2018.ente_competente, sigit_t_ispezione_2018.dt_creazione, 
    sigit_t_ispezione_2018.dt_conclusione, sigit_t_ispezione_2018.flg_esito, 
    sigit_t_ispezione_2018.note, sigit_t_allegato.id_allegato, 
    sigit_t_allegato.fk_stato_rapp, sigit_d_stato_rapp.des_stato_rapp, 
    sigit_t_allegato.fk_tipo_documento, 
    sigit_d_tipo_documento.des_tipo_documento, 
    sigit_t_allegato.fk_sigla_bollino, sigit_t_allegato.fk_numero_bollino, 
    sigit_t_allegato.data_controllo, sigit_t_allegato.b_flg_libretto_uso, 
    sigit_t_allegato.b_flg_dichiar_conform, sigit_t_allegato.b_flg_lib_imp, 
    sigit_t_allegato.b_flg_lib_compl, sigit_t_allegato.f_osservazioni, 
    sigit_t_allegato.f_raccomandazioni, sigit_t_allegato.f_prescrizioni, 
    sigit_t_allegato.f_flg_puo_funzionare, sigit_t_allegato.f_intervento_entro, 
    sigit_t_allegato.f_ora_arrivo, sigit_t_allegato.f_ora_partenza, 
    sigit_t_allegato.f_denominaz_tecnico, sigit_t_allegato.f_flg_firma_tecnico, 
    sigit_t_allegato.f_flg_firma_responsabile, sigit_t_allegato.data_invio, 
    sigit_t_allegato.nome_allegato, 
    sigit_t_allegato.data_ult_mod AS data_ult_mod_allegato, 
    sigit_t_allegato.utente_ult_mod AS utente_ult_mod_allegato, 
    sigit_t_allegato.cf_redattore, sigit_t_allegato.uid_index, 
    sigit_t_allegato.f_firma_tecnico, sigit_t_allegato.f_firma_responsabile, 
    sigit_t_allegato.flg_controllo_bozza, 
    sigit_t_allegato.a_potenza_termica_nominale_max, 
    sigit_t_allegato.elenco_combustibili, 
    sigit_t_allegato.elenco_apparecchiature, 
    sigit_t_persona_fisica.id_persona_fisica, sigit_t_persona_fisica.nome, 
    sigit_t_persona_fisica.cognome, sigit_t_persona_fisica.codice_fiscale
   FROM sigit_t_ispezione_2018
   JOIN sigit_r_ispez_ispet ON sigit_t_ispezione_2018.id_ispezione_2018 = sigit_r_ispez_ispet.id_ispezione_2018
   JOIN sigit_t_persona_fisica ON sigit_r_ispez_ispet.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica
   LEFT JOIN sigit_t_allegato ON sigit_r_ispez_ispet.id_ispez_ispet = sigit_t_allegato.fk_ispez_ispet
   LEFT JOIN sigit_d_tipo_documento ON sigit_t_allegato.fk_tipo_documento = sigit_d_tipo_documento.id_tipo_documento
   LEFT JOIN sigit_d_stato_rapp ON sigit_t_allegato.fk_stato_rapp = sigit_d_stato_rapp.id_stato_rapp
   JOIN sigit_d_stato_ispezione ON sigit_t_ispezione_2018.fk_stato_ispezione = sigit_d_stato_ispezione.id_stato_ispezione
  WHERE sigit_r_ispez_ispet.fk_ruolo = 2::numeric
  AND sigit_r_ispez_ispet.id_ispez_ispet = (
	select max(id_ispez_ispet)
	from sigit_r_ispez_ispet rii
	where rii.id_ispezione_2018 = sigit_r_ispez_ispet.id_ispezione_2018
  );

ALTER TABLE vista_ricerca_ispezioni
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_ricerca_ispezioni TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_ricerca_ispezioni TO sigit_new_rw;
*/

-- backup pre modifica vista_tot_impianto
/*
CREATE OR REPLACE VIEW vista_tot_impianto AS 
         SELECT sigit_t_impianto.codice_impianto, 
            sigit_t_impianto.denominazione_provincia, 
            sigit_t_impianto.sigla_provincia, sigit_t_impianto.istat_comune, 
            sigit_t_impianto.denominazione_comune, 
            COALESCE(sigit_t_unita_immobiliare.indirizzo_sitad, sigit_t_unita_immobiliare.indirizzo_non_trovato) AS indirizzo_sitad, 
            sigit_t_unita_immobiliare.civico, 
            sigit_t_unita_immobiliare.flg_principale, 
            'PF'::character varying(2) AS pf_pg, 
            sigit_t_persona_fisica.id_persona_fisica, 
            sigit_t_persona_fisica.nome, 
            sigit_t_persona_fisica.cognome AS denominazione, 
            sigit_d_ruolo.id_ruolo, sigit_d_ruolo.des_ruolo, 
            sigit_d_ruolo.ruolo_funz, sigit_t_persona_fisica.codice_fiscale, 
            NULL::character varying(2) AS sigla_rea, 
            NULL::numeric(11,0) AS numero_rea, 
            sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg, 
            sigit_r_imp_ruolo_pfpg.data_inizio AS data_inizio_pfpg, 
            sigit_r_imp_ruolo_pfpg.data_fine AS data_fine_pfpg
           FROM sigit_d_ruolo
      JOIN (sigit_t_persona_fisica
      JOIN (sigit_t_impianto
      JOIN sigit_t_unita_immobiliare ON sigit_t_impianto.codice_impianto = sigit_t_unita_immobiliare.codice_impianto
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_t_impianto.codice_impianto = sigit_r_imp_ruolo_pfpg.codice_impianto) ON sigit_t_persona_fisica.id_persona_fisica = sigit_r_imp_ruolo_pfpg.fk_persona_fisica) ON sigit_d_ruolo.id_ruolo = sigit_r_imp_ruolo_pfpg.fk_ruolo
  WHERE sigit_t_unita_immobiliare.flg_principale = 1::numeric
UNION 
         SELECT sigit_t_impianto.codice_impianto, 
            sigit_t_impianto.denominazione_provincia, 
            sigit_t_impianto.sigla_provincia, sigit_t_impianto.istat_comune, 
            sigit_t_impianto.denominazione_comune, 
            COALESCE(sigit_t_unita_immobiliare.indirizzo_sitad, sigit_t_unita_immobiliare.indirizzo_non_trovato) AS indirizzo_sitad, 
            sigit_t_unita_immobiliare.civico, 
            sigit_t_unita_immobiliare.flg_principale, 
            'PG'::character varying(2) AS pf_pg, 
            sigit_t_persona_giuridica.id_persona_giuridica AS id_persona_fisica, 
            NULL::character varying(100) AS nome, 
            sigit_t_persona_giuridica.denominazione, sigit_d_ruolo.id_ruolo, 
            sigit_d_ruolo.des_ruolo, sigit_d_ruolo.ruolo_funz, 
            sigit_t_persona_giuridica.codice_fiscale, 
            sigit_t_persona_giuridica.sigla_rea, 
            sigit_t_persona_giuridica.numero_rea, 
            sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg, 
            sigit_r_imp_ruolo_pfpg.data_inizio AS data_inizio_pfpg, 
            sigit_r_imp_ruolo_pfpg.data_fine AS data_fine_pfpg
           FROM sigit_d_ruolo
      JOIN (sigit_t_persona_giuridica
      JOIN (sigit_t_impianto
      JOIN sigit_t_unita_immobiliare ON sigit_t_impianto.codice_impianto = sigit_t_unita_immobiliare.codice_impianto
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_t_impianto.codice_impianto = sigit_r_imp_ruolo_pfpg.codice_impianto) ON sigit_t_persona_giuridica.id_persona_giuridica = sigit_r_imp_ruolo_pfpg.fk_persona_giuridica) ON sigit_d_ruolo.id_ruolo = sigit_r_imp_ruolo_pfpg.fk_ruolo
  WHERE sigit_t_unita_immobiliare.flg_principale = 1::numeric;
*/

DROP VIEW vista_tot_impianto;

-- modifica vista_tot_impianto
CREATE OR REPLACE VIEW vista_tot_impianto AS 
         SELECT sigit_t_impianto.codice_impianto, 
            sigit_t_impianto.denominazione_provincia, 
            sigit_t_impianto.sigla_provincia, sigit_t_impianto.istat_comune, 
            sigit_t_impianto.denominazione_comune, 
            COALESCE(sigit_t_unita_immobiliare.indirizzo_sitad, sigit_t_unita_immobiliare.indirizzo_non_trovato) AS indirizzo_sitad, 
            sigit_t_unita_immobiliare.civico, 
            sigit_t_unita_immobiliare.flg_principale, 
            'PF'::character varying(2) AS pf_pg, 
            sigit_t_persona_fisica.id_persona_fisica, 
            sigit_t_persona_fisica.nome, 
            sigit_t_persona_fisica.cognome AS denominazione, 
            sigit_d_ruolo.id_ruolo, sigit_d_ruolo.des_ruolo, 
            sigit_d_ruolo.ruolo_funz, sigit_t_persona_fisica.codice_fiscale, 
            NULL::character varying(2) AS sigla_rea, 
            NULL::numeric(11,0) AS numero_rea, 
            sigit_r_ispez_ispet.id_ispez_ispet, 
            sigit_r_ispez_ispet.data_inizio AS data_inizio_pfpg, 
            sigit_r_ispez_ispet.data_fine AS data_fine_pfpg
           FROM sigit_d_ruolo
      JOIN (sigit_t_persona_fisica
      JOIN (sigit_t_impianto
      JOIN sigit_t_unita_immobiliare ON sigit_t_impianto.codice_impianto = sigit_t_unita_immobiliare.codice_impianto
   JOIN sigit_r_ispez_ispet ON sigit_t_impianto.codice_impianto = sigit_r_ispez_ispet.codice_impianto) 
	ON sigit_t_persona_fisica.id_persona_fisica = sigit_r_ispez_ispet.fk_persona_fisica) 
	ON sigit_d_ruolo.id_ruolo = sigit_r_ispez_ispet.fk_ruolo
  WHERE sigit_t_unita_immobiliare.flg_principale = 1::numeric
UNION 
         SELECT sigit_t_impianto.codice_impianto, 
            sigit_t_impianto.denominazione_provincia, 
            sigit_t_impianto.sigla_provincia, sigit_t_impianto.istat_comune, 
            sigit_t_impianto.denominazione_comune, 
            COALESCE(sigit_t_unita_immobiliare.indirizzo_sitad, sigit_t_unita_immobiliare.indirizzo_non_trovato) AS indirizzo_sitad, 
            sigit_t_unita_immobiliare.civico, 
            sigit_t_unita_immobiliare.flg_principale, 
            'PG'::character varying(2) AS pf_pg, 
            sigit_t_persona_giuridica.id_persona_giuridica AS id_persona_fisica, 
            NULL::character varying(100) AS nome, 
            sigit_t_persona_giuridica.denominazione, sigit_d_ruolo.id_ruolo, 
            sigit_d_ruolo.des_ruolo, sigit_d_ruolo.ruolo_funz, 
            sigit_t_persona_giuridica.codice_fiscale, 
            sigit_t_persona_giuridica.sigla_rea, 
            sigit_t_persona_giuridica.numero_rea, 
            sigit_r_ispez_ispet.id_ispez_ispet, 
            sigit_r_ispez_ispet.data_inizio AS data_inizio_pfpg, 
            sigit_r_ispez_ispet.data_fine AS data_fine_pfpg
           FROM sigit_d_ruolo
      JOIN (sigit_t_persona_giuridica
      JOIN (sigit_t_impianto
      JOIN sigit_t_unita_immobiliare ON sigit_t_impianto.codice_impianto = sigit_t_unita_immobiliare.codice_impianto
   JOIN sigit_r_ispez_ispet ON sigit_t_impianto.codice_impianto = sigit_r_ispez_ispet.codice_impianto) 
	ON sigit_t_persona_giuridica.id_persona_giuridica = sigit_r_ispez_ispet.fk_persona_giuridica) 
	ON sigit_d_ruolo.id_ruolo = sigit_r_ispez_ispet.fk_ruolo
  WHERE sigit_t_unita_immobiliare.flg_principale = 1::numeric;

-- backup pre modifica v_chk_2_3_cg
/*
CREATE OR REPLACE VIEW v_chk_2_3_cg AS 
         SELECT DISTINCT c.id_contratto, rc4c.codice_impianto, a.id_allegato, 
            a.data_controllo, c.data_inizio, c.data_fine, c.flg_tacito_rinnovo, 
            rc4c.data_revoca
           FROM sigit_r_allegato_comp_cg all_cmp, sigit_t_allegato a, 
            sigit_t_contratto_old c, sigit_r_comp4_contratto rc4c
          WHERE a.id_allegato = all_cmp.id_allegato AND all_cmp.fk_contratto = c.id_contratto AND c.id_contratto = rc4c.id_contratto AND a.fk_stato_rapp = 1::numeric AND (rc4c.data_revoca IS NOT NULL AND NOT (a.data_controllo >= c.data_inizio AND a.data_controllo <= rc4c.data_revoca) OR rc4c.data_revoca IS NULL AND c.flg_tacito_rinnovo = 0::numeric AND NOT (a.data_controllo >= c.data_inizio AND a.data_controllo <= c.data_fine) OR rc4c.data_revoca IS NULL AND c.flg_tacito_rinnovo = 1::numeric AND NOT a.data_controllo >= c.data_inizio)
UNION 
         SELECT NULL::numeric AS id_contratto, rimp.codice_impianto, 
            a.id_allegato, a.data_controllo, rimp.data_inizio, rimp.data_fine, 
            NULL::numeric AS flg_tacito_rinnovo, 
            NULL::timestamp without time zone AS data_revoca
           FROM sigit_r_allegato_comp_cg all_cmp, sigit_t_allegato a, 
            sigit_r_imp_ruolo_pfpg rimp
          WHERE a.id_allegato = all_cmp.id_allegato AND all_cmp.fk_imp_ruolo_pfpg = rimp.id_imp_ruolo_pfpg AND a.fk_stato_rapp = 1::numeric AND (a.data_controllo < rimp.data_inizio OR a.data_controllo > rimp.data_fine AND rimp.data_fine IS NOT NULL);
*/

DROP VIEW v_chk_2_3_cg;

-- backup pre modifica
/*
CREATE OR REPLACE VIEW v_chk_2_3_gf AS 
         SELECT DISTINCT c.id_contratto, rc4c.codice_impianto, a.id_allegato, 
            a.data_controllo, c.data_inizio, c.data_fine, c.flg_tacito_rinnovo, 
            rc4c.data_revoca
           FROM sigit_r_allegato_comp_gf all_cmp, sigit_t_allegato a, 
            sigit_t_contratto_old c, sigit_r_comp4_contratto rc4c
          WHERE a.id_allegato = all_cmp.id_allegato AND all_cmp.fk_contratto = c.id_contratto AND c.id_contratto = rc4c.id_contratto AND a.fk_stato_rapp = 1::numeric AND (rc4c.data_revoca IS NOT NULL AND NOT (a.data_controllo >= c.data_inizio AND a.data_controllo <= rc4c.data_revoca) OR rc4c.data_revoca IS NULL AND c.flg_tacito_rinnovo = 0::numeric AND NOT (a.data_controllo >= c.data_inizio AND a.data_controllo <= c.data_fine) OR rc4c.data_revoca IS NULL AND c.flg_tacito_rinnovo = 1::numeric AND NOT a.data_controllo >= c.data_inizio)
UNION 
         SELECT NULL::numeric AS id_contratto, rimp.codice_impianto, 
            a.id_allegato, a.data_controllo, rimp.data_inizio, rimp.data_fine, 
            NULL::numeric AS flg_tacito_rinnovo, 
            NULL::timestamp without time zone AS data_revoca
           FROM sigit_r_allegato_comp_gf all_cmp, sigit_t_allegato a, 
            sigit_r_imp_ruolo_pfpg rimp
          WHERE a.id_allegato = all_cmp.id_allegato AND all_cmp.fk_imp_ruolo_pfpg = rimp.id_imp_ruolo_pfpg AND a.fk_stato_rapp = 1::numeric AND (a.data_controllo < rimp.data_inizio OR a.data_controllo > rimp.data_fine AND rimp.data_fine IS NOT NULL);
*/

DROP VIEW v_chk_2_3_gf;

-- backup pre modifica
/*
CREATE OR REPLACE VIEW v_chk_2_3_gt AS 
         SELECT DISTINCT c.id_contratto, rc4c.codice_impianto, a.id_allegato, 
            a.data_controllo, c.data_inizio, c.data_fine, c.flg_tacito_rinnovo, 
            rc4c.data_revoca
           FROM sigit_r_allegato_comp_gt all_cmp, sigit_t_allegato a, 
            sigit_t_contratto_old c, sigit_r_comp4_contratto rc4c
          WHERE a.id_allegato = all_cmp.id_allegato AND all_cmp.fk_contratto = c.id_contratto AND c.id_contratto = rc4c.id_contratto AND a.fk_stato_rapp = 1::numeric AND (rc4c.data_revoca IS NOT NULL AND NOT (a.data_controllo >= c.data_inizio AND a.data_controllo <= rc4c.data_revoca) OR rc4c.data_revoca IS NULL AND c.flg_tacito_rinnovo = 0::numeric AND NOT (a.data_controllo >= c.data_inizio AND a.data_controllo <= c.data_fine) OR rc4c.data_revoca IS NULL AND c.flg_tacito_rinnovo = 1::numeric AND NOT a.data_controllo >= c.data_inizio)
UNION 
         SELECT NULL::numeric AS id_contratto, rimp.codice_impianto, 
            a.id_allegato, a.data_controllo, rimp.data_inizio, rimp.data_fine, 
            NULL::numeric AS flg_tacito_rinnovo, 
            NULL::timestamp without time zone AS data_revoca
           FROM sigit_r_allegato_comp_gt all_cmp, sigit_t_allegato a, 
            sigit_r_imp_ruolo_pfpg rimp
          WHERE a.id_allegato = all_cmp.id_allegato AND all_cmp.fk_imp_ruolo_pfpg = rimp.id_imp_ruolo_pfpg AND a.fk_stato_rapp = 1::numeric AND (a.data_controllo < rimp.data_inizio OR a.data_controllo > rimp.data_fine AND rimp.data_fine IS NOT NULL);
*/

DROP VIEW v_chk_2_3_gt;

-- backup pre modifica
/*
CREATE OR REPLACE VIEW v_chk_2_3_sc AS 
         SELECT DISTINCT c.id_contratto, rc4c.codice_impianto, a.id_allegato, 
            a.data_controllo, c.data_inizio, c.data_fine, c.flg_tacito_rinnovo, 
            rc4c.data_revoca
           FROM sigit_r_allegato_comp_sc all_cmp, sigit_t_allegato a, 
            sigit_t_contratto_old c, sigit_r_comp4_contratto rc4c
          WHERE a.id_allegato = all_cmp.id_allegato AND all_cmp.fk_contratto = c.id_contratto AND c.id_contratto = rc4c.id_contratto AND a.fk_stato_rapp = 1::numeric AND (rc4c.data_revoca IS NOT NULL AND NOT (a.data_controllo >= c.data_inizio AND a.data_controllo <= rc4c.data_revoca) OR rc4c.data_revoca IS NULL AND c.flg_tacito_rinnovo = 0::numeric AND NOT (a.data_controllo >= c.data_inizio AND a.data_controllo <= c.data_fine) OR rc4c.data_revoca IS NULL AND c.flg_tacito_rinnovo = 1::numeric AND NOT a.data_controllo >= c.data_inizio)
UNION 
         SELECT NULL::numeric AS id_contratto, rimp.codice_impianto, 
            a.id_allegato, a.data_controllo, rimp.data_inizio, rimp.data_fine, 
            NULL::numeric AS flg_tacito_rinnovo, 
            NULL::timestamp without time zone AS data_revoca
           FROM sigit_r_allegato_comp_sc all_cmp, sigit_t_allegato a, 
            sigit_r_imp_ruolo_pfpg rimp
          WHERE a.id_allegato = all_cmp.id_allegato AND all_cmp.fk_imp_ruolo_pfpg = rimp.id_imp_ruolo_pfpg AND a.fk_stato_rapp = 1::numeric AND (a.data_controllo < rimp.data_inizio OR a.data_controllo > rimp.data_fine AND rimp.data_fine IS NOT NULL);
*/

DROP VIEW v_chk_2_3_sc;

-- backup pre cancellazione
/*
CREATE OR REPLACE VIEW v_chk_2_1 AS 
 SELECT rc4c.id_contratto, rc4c.codice_impianto, 
    count(rc4c.id_contratto) AS cont_con, 
    count(rc4c.codice_impianto) AS cont_impianto
   FROM ( SELECT sigit_r_comp4_contratto.id_contratto, 
            sigit_r_comp4_contratto.codice_impianto, 
            sigit_r_comp4_contratto.data_caricamento::date AS dt_caricamento, 
            sigit_r_comp4_contratto.data_revoca, 
            sigit_r_comp4_contratto.data_inserimento_revoca
           FROM sigit_r_comp4_contratto
          GROUP BY sigit_r_comp4_contratto.id_contratto, sigit_r_comp4_contratto.codice_impianto, sigit_r_comp4_contratto.data_revoca, sigit_r_comp4_contratto.data_inserimento_revoca, sigit_r_comp4_contratto.data_caricamento::date
          ORDER BY sigit_r_comp4_contratto.id_contratto, sigit_r_comp4_contratto.codice_impianto) rc4c
  GROUP BY rc4c.id_contratto, rc4c.codice_impianto
 HAVING count(rc4c.id_contratto) > 1 AND count(rc4c.codice_impianto) > 1;
*/

DROP VIEW v_chk_2_1;

--cancellazione vecchie tabelle e viste x vecchie migrazioni
DROP VIEW v_chk_2_2_pf_sandro;
DROP VIEW v_chk_2_2_pg_sandro;
--DROP VIEW v_chk_migraz_contr_no_migrati;
DROP VIEW v_chk_migrazione_contratti_vers2_pf;
DROP VIEW v_chk_migrazione_contratti_vers2_pfpg;
DROP VIEW v_chk_migrazione_contratti_vers2_pg;

DROP TABLE sigit_r_comp4_contratto;
DROP TABLE sigit_r_impianto_contratto CASCADE;
--DROP TABLE sigit_t_contratto_old;

----------------------------------------------------------------------------------------
-- 24/10/2018  Lorita
-- Aggiunta campi su sigit_t_ispezione_2018
-- Revisione vista vista_ricerca_ispezioni
----------------------------------------------------------------------------------------
ALTER TABLE sigit_t_ispezione_2018 ADD
	istat_prov_competenza      CHARACTER VARYING(3)  NULL 
;

ALTER TABLE sigit_t_ispezione_2018 ADD
	flg_acc_sostitutivo        NUMERIC(1)  NULL  CONSTRAINT  acc_0_1 CHECK (flg_acc_sostitutivo IN (0,1))
;

-- MANCA MODIFICHE DATE sigit_t_ispezione_2018 !!!
ALTER TABLE sigit_t_ispezione_2018 DROP COLUMN
  data_ispezione;
  
ALTER TABLE sigit_t_ispezione_2018 ADD COLUMN
  dt_creazione timestamp without time zone;
  
ALTER TABLE sigit_t_ispezione_2018 ADD COLUMN
  dt_conclusione timestamp without time zone;

CREATE OR REPLACE VIEW vista_ricerca_ispezioni AS 
 SELECT sigit_t_ispezione_2018.id_ispezione_2018, 
    sigit_t_ispezione_2018.codice_impianto, sigit_r_ispez_ispet.id_ispez_ispet, 
    sigit_t_ispezione_2018.fk_stato_ispezione, 
    sigit_d_stato_ispezione.des_stato_ispezione, 
    sigit_t_ispezione_2018.ente_competente, sigit_t_ispezione_2018.dt_creazione, 
    sigit_t_ispezione_2018.dt_conclusione, sigit_t_ispezione_2018.flg_esito, 
    sigit_t_ispezione_2018.note, sigit_t_allegato.id_allegato, 
    sigit_t_allegato.fk_stato_rapp, sigit_d_stato_rapp.des_stato_rapp, 
    sigit_t_allegato.fk_tipo_documento, 
    sigit_d_tipo_documento.des_tipo_documento, 
    sigit_t_allegato.fk_sigla_bollino, sigit_t_allegato.fk_numero_bollino, 
    sigit_t_allegato.data_controllo, sigit_t_allegato.b_flg_libretto_uso, 
    sigit_t_allegato.b_flg_dichiar_conform, sigit_t_allegato.b_flg_lib_imp, 
    sigit_t_allegato.b_flg_lib_compl, sigit_t_allegato.f_osservazioni, 
    sigit_t_allegato.f_raccomandazioni, sigit_t_allegato.f_prescrizioni, 
    sigit_t_allegato.f_flg_puo_funzionare, sigit_t_allegato.f_intervento_entro, 
    sigit_t_allegato.f_ora_arrivo, sigit_t_allegato.f_ora_partenza, 
    sigit_t_allegato.f_denominaz_tecnico, sigit_t_allegato.f_flg_firma_tecnico, 
    sigit_t_allegato.f_flg_firma_responsabile, sigit_t_allegato.data_invio, 
    sigit_t_allegato.nome_allegato, 
    sigit_t_allegato.data_ult_mod AS data_ult_mod_allegato, 
    sigit_t_allegato.utente_ult_mod AS utente_ult_mod_allegato, 
    sigit_t_allegato.cf_redattore, sigit_t_allegato.uid_index, 
    sigit_t_allegato.f_firma_tecnico, sigit_t_allegato.f_firma_responsabile, 
    sigit_t_allegato.flg_controllo_bozza, 
    sigit_t_allegato.a_potenza_termica_nominale_max, 
    sigit_t_allegato.elenco_combustibili, 
    sigit_t_allegato.elenco_apparecchiature, 
    sigit_t_persona_fisica.id_persona_fisica, sigit_t_persona_fisica.nome, 
    sigit_t_persona_fisica.cognome, sigit_t_persona_fisica.codice_fiscale, 
    sigit_t_ispezione_2018.istat_prov_competenza, 
    sigit_t_ispezione_2018.flg_acc_sostitutivo, 
    sigit_t_ispezione_2018.cf_ispettore_secondario
   FROM sigit_t_ispezione_2018
   LEFT JOIN sigit_r_ispez_ispet ON sigit_t_ispezione_2018.id_ispezione_2018 = sigit_r_ispez_ispet.id_ispezione_2018
   LEFT JOIN sigit_t_persona_fisica ON sigit_r_ispez_ispet.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica
   LEFT JOIN sigit_t_allegato ON sigit_r_ispez_ispet.id_ispez_ispet = sigit_t_allegato.fk_ispez_ispet
   LEFT JOIN sigit_d_tipo_documento ON sigit_t_allegato.fk_tipo_documento = sigit_d_tipo_documento.id_tipo_documento
   LEFT JOIN sigit_d_stato_rapp ON sigit_t_allegato.fk_stato_rapp = sigit_d_stato_rapp.id_stato_rapp
   JOIN sigit_d_stato_ispezione ON sigit_t_ispezione_2018.fk_stato_ispezione = sigit_d_stato_ispezione.id_stato_ispezione
  WHERE sigit_t_ispezione_2018.id_ispezione_2018 <> 0;


ALTER TABLE sigit_t_verifica alter column sigla_bollino drop not null;

ALTER TABLE sigit_t_verifica alter column  numero_bollino drop not null;

----------------------------------------------------------------------------------------
-- 18/11/2018  Lorita
-- Correzione tabella sigit_t_allegato
----------------------------------------------------------------------------------------
DROP VIEW vista_ricerca_ispezioni;

DROP VIEW vista_ricerca_allegati;

DROP VIEW vista_ricerca_allegati_storico;

ALTER TABLE sigit_t_allegato
   ALTER COLUMN nome_allegato TYPE character varying(100);

ALTER TABLE sigit_t_allegato_rilascio_2019_11
   ALTER COLUMN nome_allegato TYPE character varying(100);

ALTER TABLE sigit_s_allegato
   ALTER COLUMN nome_allegato TYPE character varying(100); 

CREATE OR REPLACE VIEW vista_ricerca_ispezioni AS 
 SELECT sigit_t_ispezione_2018.id_ispezione_2018, 
    sigit_t_ispezione_2018.codice_impianto, sigit_r_ispez_ispet.id_ispez_ispet, 
    sigit_t_ispezione_2018.fk_stato_ispezione, 
    sigit_d_stato_ispezione.des_stato_ispezione, 
    sigit_t_ispezione_2018.ente_competente, sigit_t_ispezione_2018.dt_creazione, 
    sigit_t_ispezione_2018.dt_conclusione, sigit_t_ispezione_2018.flg_esito, 
    sigit_t_ispezione_2018.note, sigit_t_allegato.id_allegato, 
    sigit_t_allegato.fk_stato_rapp, sigit_d_stato_rapp.des_stato_rapp, 
    sigit_t_allegato.fk_tipo_documento, 
    sigit_d_tipo_documento.des_tipo_documento, 
    sigit_t_allegato.fk_sigla_bollino, sigit_t_allegato.fk_numero_bollino, 
    sigit_t_allegato.data_controllo, sigit_t_allegato.b_flg_libretto_uso, 
    sigit_t_allegato.b_flg_dichiar_conform, sigit_t_allegato.b_flg_lib_imp, 
    sigit_t_allegato.b_flg_lib_compl, sigit_t_allegato.f_osservazioni, 
    sigit_t_allegato.f_raccomandazioni, sigit_t_allegato.f_prescrizioni, 
    sigit_t_allegato.f_flg_puo_funzionare, sigit_t_allegato.f_intervento_entro, 
    sigit_t_allegato.f_ora_arrivo, sigit_t_allegato.f_ora_partenza, 
    sigit_t_allegato.f_denominaz_tecnico, sigit_t_allegato.f_flg_firma_tecnico, 
    sigit_t_allegato.f_flg_firma_responsabile, sigit_t_allegato.data_invio, 
    sigit_t_allegato.nome_allegato, 
    sigit_t_allegato.data_ult_mod AS data_ult_mod_allegato, 
    sigit_t_allegato.utente_ult_mod AS utente_ult_mod_allegato, 
    sigit_t_allegato.cf_redattore, sigit_t_allegato.uid_index, 
    sigit_t_allegato.f_firma_tecnico, sigit_t_allegato.f_firma_responsabile, 
    sigit_t_allegato.flg_controllo_bozza, 
    sigit_t_allegato.a_potenza_termica_nominale_max, 
    sigit_t_allegato.elenco_combustibili, 
    sigit_t_allegato.elenco_apparecchiature, 
    sigit_t_persona_fisica.id_persona_fisica, sigit_t_persona_fisica.nome, 
    sigit_t_persona_fisica.cognome, sigit_t_persona_fisica.codice_fiscale, 
    sigit_t_ispezione_2018.istat_prov_competenza, 
    sigit_t_ispezione_2018.flg_acc_sostitutivo, 
    sigit_t_ispezione_2018.cf_ispettore_secondario
   FROM sigit_t_ispezione_2018
   LEFT JOIN sigit_r_ispez_ispet ON sigit_t_ispezione_2018.id_ispezione_2018 = sigit_r_ispez_ispet.id_ispezione_2018
   LEFT JOIN sigit_t_persona_fisica ON sigit_r_ispez_ispet.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica
   LEFT JOIN sigit_t_allegato ON sigit_r_ispez_ispet.id_ispez_ispet = sigit_t_allegato.fk_ispez_ispet
   LEFT JOIN sigit_d_tipo_documento ON sigit_t_allegato.fk_tipo_documento = sigit_d_tipo_documento.id_tipo_documento
   LEFT JOIN sigit_d_stato_rapp ON sigit_t_allegato.fk_stato_rapp = sigit_d_stato_rapp.id_stato_rapp
   JOIN sigit_d_stato_ispezione ON sigit_t_ispezione_2018.fk_stato_ispezione = sigit_d_stato_ispezione.id_stato_ispezione
  WHERE sigit_t_ispezione_2018.id_ispezione_2018 <> 0;

ALTER TABLE vista_ricerca_ispezioni
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_ricerca_ispezioni TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_ricerca_ispezioni TO sigit_new_rw;

CREATE OR REPLACE VIEW vista_ricerca_allegati AS 
         SELECT DISTINCT a.id_allegato, a.fk_stato_rapp, srapp.des_stato_rapp, 
            a.fk_ispez_ispet, a.fk_tipo_documento, doc.des_tipo_documento, 
            a.fk_sigla_bollino, a.fk_numero_bollino, a.data_controllo, 
            a.b_flg_libretto_uso, a.b_flg_dichiar_conform, a.b_flg_lib_imp, 
            a.b_flg_lib_compl, a.f_osservazioni, a.f_raccomandazioni, 
            a.f_prescrizioni, a.f_flg_puo_funzionare, a.f_intervento_entro, 
            a.f_ora_arrivo, a.f_ora_partenza, a.f_denominaz_tecnico, 
            a.f_flg_firma_tecnico, a.f_flg_firma_responsabile, a.data_invio, 
            a.data_respinta, a.nome_allegato, a.a_potenza_termica_nominale_max, 
            a.data_ult_mod, a.utente_ult_mod, a.elenco_combustibili, 
            a.elenco_apparecchiature, a.fk_pg_cat, a.altro_descr, ru.des_ruolo, 
            ru.ruolo_funz, pg.id_persona_giuridica, 
            pg.denominazione AS pg_denominazione, 
            pg.codice_fiscale AS pg_codice_fiscale, 
            pg.fk_stato_pg AS pg_fk_stato_pg, pg.sigla_rea AS pg_sigla_rea, 
            pg.numero_rea AS pg_numero_rea, r1.codice_impianto, 
            i.denominazione_comune AS comune_impianto, 
            i.sigla_provincia AS sigla_prov_impianto, 
            COALESCE(u.indirizzo_sitad, u.indirizzo_non_trovato) AS indirizzo_unita_immob, 
            u.civico AS civico_unita_immob, a.flg_controllo_bozza, a.uid_index, 
            tm.id_tipo_manutenzione, tm.des_tipo_manutenzione
           FROM sigit_t_allegato a
      JOIN sigit_r_comp4manut_all ON a.id_allegato = sigit_r_comp4manut_all.id_allegato
   JOIN sigit_r_comp4_manut r1 ON sigit_r_comp4manut_all.id_r_comp4_manut = r1.id_r_comp4_manut
   JOIN sigit_d_ruolo ru ON r1.fk_ruolo = ru.id_ruolo
   JOIN sigit_d_tipo_documento doc ON a.fk_tipo_documento = doc.id_tipo_documento
   JOIN sigit_d_tipo_manutenzione tm ON a.fk_tipo_manutenzione = tm.id_tipo_manutenzione
   JOIN sigit_d_stato_rapp srapp ON a.fk_stato_rapp = srapp.id_stato_rapp
   LEFT JOIN sigit_t_persona_giuridica pg ON r1.fk_persona_giuridica = pg.id_persona_giuridica
   LEFT JOIN sigit_t_impianto i ON r1.codice_impianto = i.codice_impianto
   LEFT JOIN sigit_t_unita_immobiliare u ON r1.codice_impianto = u.codice_impianto
  WHERE u.flg_principale = 1::numeric
UNION 
         SELECT DISTINCT a.id_allegato, a.fk_stato_rapp, srapp.des_stato_rapp, 
            a.fk_ispez_ispet, a.fk_tipo_documento, doc.des_tipo_documento, 
            a.fk_sigla_bollino, a.fk_numero_bollino, a.data_controllo, 
            a.b_flg_libretto_uso, a.b_flg_dichiar_conform, a.b_flg_lib_imp, 
            a.b_flg_lib_compl, a.f_osservazioni, a.f_raccomandazioni, 
            a.f_prescrizioni, a.f_flg_puo_funzionare, a.f_intervento_entro, 
            a.f_ora_arrivo, a.f_ora_partenza, a.f_denominaz_tecnico, 
            a.f_flg_firma_tecnico, a.f_flg_firma_responsabile, a.data_invio, 
            a.data_respinta, a.nome_allegato, a.a_potenza_termica_nominale_max, 
            a.data_ult_mod, a.utente_ult_mod, a.elenco_combustibili, 
            a.elenco_apparecchiature, a.fk_pg_cat, a.altro_descr, ru.des_ruolo, 
            ru.ruolo_funz, pg.id_persona_giuridica, 
            pg.denominazione AS pg_denominazione, 
            pg.codice_fiscale AS pg_codice_fiscale, 
            pg.fk_stato_pg AS pg_fk_stato_pg, pg.sigla_rea AS pg_sigla_rea, 
            pg.numero_rea AS pg_numero_rea, r1.codice_impianto, 
            i.denominazione_comune AS comune_impianto, 
            i.sigla_provincia AS sigla_prov_impianto, 
            COALESCE(u.indirizzo_sitad, u.indirizzo_non_trovato) AS indirizzo_unita_immob, 
            u.civico AS civico_unita_immob, a.flg_controllo_bozza, a.uid_index, 
            tm.id_tipo_manutenzione, tm.des_tipo_manutenzione
           FROM sigit_t_allegato a
      JOIN sigit_r_ispez_ispet r1 ON a.fk_ispez_ispet = r1.id_ispez_ispet
   JOIN sigit_d_ruolo ru ON r1.fk_ruolo = ru.id_ruolo
   JOIN sigit_d_tipo_documento doc ON a.fk_tipo_documento = doc.id_tipo_documento
   JOIN sigit_d_tipo_manutenzione tm ON a.fk_tipo_manutenzione = tm.id_tipo_manutenzione
   JOIN sigit_d_stato_rapp srapp ON a.fk_stato_rapp = srapp.id_stato_rapp
   LEFT JOIN sigit_t_persona_giuridica pg ON r1.fk_persona_giuridica = pg.id_persona_giuridica
   LEFT JOIN sigit_t_impianto i ON r1.codice_impianto = i.codice_impianto
   LEFT JOIN sigit_t_unita_immobiliare u ON r1.codice_impianto = u.codice_impianto
  WHERE u.flg_principale = 1::numeric;

ALTER TABLE vista_ricerca_allegati
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_ricerca_allegati TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_ricerca_allegati TO sigit_new_rw;

CREATE OR REPLACE VIEW vista_ricerca_allegati_storico AS 
         SELECT DISTINCT a.id_allegato, a.fk_stato_rapp, srapp.des_stato_rapp, 
            a.fk_imp_ruolo_pfpg, a.fk_tipo_documento, doc.des_tipo_documento, 
            a.fk_sigla_bollino, a.fk_numero_bollino, a.data_controllo, 
            a.b_flg_libretto_uso, a.b_flg_dichiar_conform, a.b_flg_lib_imp, 
            a.b_flg_lib_compl, a.f_osservazioni, a.f_raccomandazioni, 
            a.f_prescrizioni, a.f_flg_puo_funzionare, a.f_intervento_entro, 
            a.f_ora_arrivo, a.f_ora_partenza, a.f_denominaz_tecnico, 
            a.f_flg_firma_tecnico, a.f_flg_firma_responsabile, a.data_invio, 
            a.data_respinta, a.nome_allegato, a.a_potenza_termica_nominale_max, 
            a.data_ult_mod, a.utente_ult_mod, a.elenco_combustibili, 
            a.elenco_apparecchiature, a.fk_pg_cat, a.altro_descr, ru.des_ruolo, 
            ru.ruolo_funz, pg.id_persona_giuridica, 
            pg.denominazione AS pg_denominazione, 
            pg.codice_fiscale AS pg_codice_fiscale, 
            pg.fk_stato_pg AS pg_fk_stato_pg, pg.sigla_rea AS pg_sigla_rea, 
            pg.numero_rea AS pg_numero_rea, r1.codice_impianto, 
            i.denominazione_comune AS comune_impianto, 
            i.sigla_provincia AS sigla_prov_impianto, 
            COALESCE(u.indirizzo_sitad, u.indirizzo_non_trovato) AS indirizzo_unita_immob, 
            u.civico AS civico_unita_immob, a.flg_controllo_bozza, a.uid_index, 
            tm.id_tipo_manutenzione, tm.des_tipo_manutenzione
           FROM sigit_s_allegato a
      JOIN sigit_r_imp_ruolo_pfpg r1 ON a.fk_imp_ruolo_pfpg = r1.id_imp_ruolo_pfpg
   JOIN sigit_d_ruolo ru ON r1.fk_ruolo = ru.id_ruolo
   JOIN sigit_d_tipo_documento doc ON a.fk_tipo_documento = doc.id_tipo_documento
   JOIN sigit_d_tipo_manutenzione tm ON a.fk_tipo_manutenzione = tm.id_tipo_manutenzione
   JOIN sigit_d_stato_rapp srapp ON a.fk_stato_rapp = srapp.id_stato_rapp
   LEFT JOIN sigit_t_persona_giuridica pg ON r1.fk_persona_giuridica = pg.id_persona_giuridica
   LEFT JOIN sigit_t_impianto i ON r1.codice_impianto = i.codice_impianto
   LEFT JOIN sigit_t_unita_immobiliare u ON r1.codice_impianto = u.codice_impianto
  WHERE u.flg_principale = 1::numeric;

ALTER TABLE vista_ricerca_allegati_storico
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_ricerca_allegati_storico TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_ricerca_allegati_storico TO sigit_new_rw;

----------------------------------------------------------------------------------------
-- 18/10/2018  Lorita
-- Backup prima di eseguire function di migrazione ispezioni
----------------------------------------------------------------------------------------
-- riportare il file Function_MigrazioneIspezioni.sql

create table sigit_t_ispezione_rilascio_2019_11 as
select * from sigit_t_ispezione;

create table sigit_r_imp_ruolo_pfpg_rilascio_2019_11 as
select * from sigit_r_imp_ruolo_pfpg;

create table sigit_t_doc_aggiuntiva_rilascio_2019_11 as
select * from SIGIT_T_DOC_AGGIUNTIVA da;

create table sigit_t_verifica_rilascio_2019_11 as
select * from sigit_t_verifica;

create table sigit_t_ispezione_2018_rilascio_2019_11 as
select * from sigit_t_ispezione_2018;

create table sigit_r_ispez_ispet_rilascio_2019_11 as
select * from sigit_r_ispez_ispet;

create table sigit_t_azione_rilascio_2019_11 as
select * from sigit_t_azione;

create table sigit_t_doc_azione_rilascio_2019_11 as
select * from sigit_t_doc_azione;

create table sigit_r_allegato_comp_gt_rilascio_2019_11 as
select * from sigit_r_allegato_comp_gt;
