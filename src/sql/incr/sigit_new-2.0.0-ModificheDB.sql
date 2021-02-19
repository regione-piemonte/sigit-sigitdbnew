----------------------------------------------------------------------------------------
-- 11/06/2020  Lorita
-- Modifiche tabelle sigit_t_persona_giuridica e sigit_t_user_ws
--  come da mail di Mariuccia del 10/6/2020 16:57
----------------------------------------------------------------------------------------
alter TABLE sigit_t_persona_giuridica add column dt_creazione_token    DATE  null;
alter TABLE sigit_t_persona_giuridica add column dt_scadenza_token     DATE  null;

alter TABLE sigit_t_user_ws add column dt_creazione_token    DATE  null;
alter TABLE sigit_t_user_ws add column dt_scadenza_token     DATE  null;
alter TABLE sigit_t_user_ws add column token                 CHARACTER VARYING(500)  NULL;


----------------------------------------------------------------------------------------
-- 10/07/2020  Lorita
-- Inserimento dati nuovi tabelle WS
--  come da mail di Mariuccia del 9/7/2020 17:16
----------------------------------------------------------------------------------------
insert into SIGIT_T_ELENCO_WS (id_elenco_ws, descrizione_ws)
values 
(5,'getLibrettoNow'),
(6,'getXMLLibrettoNow'),
(7,'getXMLLibrettoConsolidato'),
(8,'uploadXMLLibretto'),
(9,'uploadXMLControllo');

insert into SIGIT_T_USER_WS (id_user_ws, user_ws, pwd_ws)
values 
(0,'FRUITORI ','ESTERNI'),
(2,'SICEE','MADBTAR');

delete from SIGIT_R_USER_ELENCO_WS;

insert into SIGIT_R_USER_ELENCO_WS (id_user_ws, id_elenco_ws)
values 
(0,1),
(0,2),
(0,3),
(0,4),
(0,5),
(0,6),
(0,7),
(0,8),
(0,9),
(1,5),
(1,7),
(1,8),
(1,9),
(2,1),
(2,2),
(2,3),
(2,4);


----------------------------------------------------------------------------------------
-- 14/07/2020  Lorita
-- Modifica tabella sigit_t_persona_giuridica
--  come da mail di Mariuccia del 14/7/2020 15:17
----------------------------------------------------------------------------------------
alter TABLE sigit_t_persona_giuridica add column token                 CHARACTER VARYING(500)  NULL;

----------------------------------------------------------------------------------------
-- 07/08/2020  Lorita
-- Crezione tabella log sigit_l_accesso
--  come da mail di Mariuccia del 07/8/2020 09:37
----------------------------------------------------------------------------------------
create table SIGIT_L_ACCESSO (
dt_accesso 		timestamp,
codice_fiscale 	character varying (16),
nome 			character varying (100),
cognome 		character varying (100),
ruolo 			character varying (50),
	CONSTRAINT pk_sigit_l_accesso PRIMARY KEY (dt_accesso)
);

ALTER TABLE sigit_new.sigit_l_accesso OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_new.sigit_l_accesso TO sigit_new;
GRANT INSERT, SELECT, UPDATE, DELETE, TRUNCATE ON TABLE sigit_new.sigit_l_accesso TO sigit_new_rw;

----------------------------------------------------------------------------------------
-- 25/09/2020  Lorita
-- Aggiornate viste vista_dw_sk4* su segnalazione di Mariuccia
--  come da mail di Mariuccia del 31/8/2020 10:34
-- aggiornate anche le viste materializzate mv_vista_dw_sk4*
----------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW vista_dw_sk4_cg AS 
 SELECT DISTINCT sigit_t_comp_cg.codice_impianto,
    sigit_t_comp_cg.id_tipo_componente,
    sigit_t_comp_cg.progressivo,
    sigit_t_comp_cg.data_install,
    sigit_t_comp_cg.data_dismiss,
    sigit_t_comp_cg.matricola,
    sigit_t_comp_cg.fk_marca,
    sigit_d_marca.des_marca,
    sigit_d_combustibile.id_combustibile,
    sigit_d_combustibile.des_combustibile,
    sigit_t_comp_cg.modello,
    sigit_t_comp_cg.potenza_termica_kw,
    sigit_t_comp_cg.data_ult_mod,
    sigit_t_comp_cg.utente_ult_mod,
    sigit_t_comp_cg.tipologia,
    sigit_t_comp_cg.potenza_elettrica_kw,
    sigit_t_comp_cg.temp_h2o_out_min,
    sigit_t_comp_cg.temp_h2o_out_max,
    sigit_t_comp_cg.temp_h2o_in_min,
    sigit_t_comp_cg.temp_h2o_in_max,
    sigit_t_comp_cg.temp_h2o_motore_min,
    sigit_t_comp_cg.temp_h2o_motore_max,
    sigit_t_comp_cg.temp_fumi_valle_min,
    sigit_t_comp_cg.temp_fumi_valle_max,
    sigit_t_comp_cg.temp_fumi_monte_min,
    sigit_t_comp_cg.temp_fumi_monte_max,
    sigit_t_comp_cg.co_min,
    sigit_t_comp_cg.co_max,
    sigit_t_comp_cg.flg_dismissione,
    sigit_t_allegato.data_controllo,
    sigit_t_impianto.istat_comune,
    sigit_t_impianto.denominazione_comune,
    sigit_t_impianto.denominazione_provincia,
    sigit_t_impianto.fk_stato AS stato_impianto,
    sigit_d_stato_imp.des_stato AS des_stato_impianto,
    sigit_t_libretto.data_consolidamento
   FROM sigit_t_comp_cg
     LEFT JOIN sigit_r_allegato_comp_cg USING (id_tipo_componente, progressivo, codice_impianto, data_install)
     LEFT JOIN sigit_t_allegato ON sigit_t_allegato.id_allegato = sigit_r_allegato_comp_cg.id_allegato AND sigit_t_allegato.fk_stato_rapp = 1::numeric
     LEFT JOIN sigit_t_dett_tipo4 ON sigit_t_dett_tipo4.fk_allegato = sigit_t_allegato.id_allegato AND sigit_t_dett_tipo4.fk_tipo_componente::text = sigit_r_allegato_comp_cg.id_tipo_componente::text AND sigit_t_dett_tipo4.progressivo = sigit_r_allegato_comp_cg.progressivo AND sigit_t_dett_tipo4.codice_impianto = sigit_r_allegato_comp_cg.codice_impianto AND sigit_t_dett_tipo4.data_install = sigit_r_allegato_comp_cg.data_install
     JOIN sigit_t_impianto ON sigit_t_impianto.codice_impianto = sigit_t_comp_cg.codice_impianto
     JOIN sigit_d_stato_imp ON sigit_t_impianto.fk_stato = sigit_d_stato_imp.id_stato
     LEFT JOIN sigit_t_libretto ON sigit_t_impianto.codice_impianto = sigit_t_libretto.codice_impianto AND sigit_t_libretto.fk_stato = 2::numeric
     LEFT JOIN sigit_d_marca ON sigit_t_comp_cg.fk_marca = sigit_d_marca.id_marca
     LEFT JOIN sigit_d_combustibile ON sigit_t_comp_cg.fk_combustibile = sigit_d_combustibile.id_combustibile;

--ALTER TABLE vista_dw_sk4_cg
--  OWNER TO sigit_new;
--GRANT ALL ON TABLE vista_dw_sk4_cg TO sigit_new;
--GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_dw_sk4_cg TO sigit_new_rw;
--GRANT SELECT ON TABLE vista_dw_sk4_cg TO sigit_new_ro;

CREATE OR REPLACE VIEW vista_dw_sk4_gf AS 
 SELECT DISTINCT sigit_t_comp_gf.codice_impianto,
    sigit_t_comp_gf.id_tipo_componente,
    sigit_t_comp_gf.progressivo,
    sigit_t_comp_gf.data_install,
    sigit_t_comp_gf.matricola,
    sigit_t_comp_gf.fk_marca,
    sigit_d_marca.des_marca,
    sigit_d_combustibile.id_combustibile,
    sigit_d_combustibile.des_combustibile,
    sigit_t_comp_gf.fk_dettaglio_gf,
    sigit_d_dettaglio_gf.des_dettaglio_gf,
    sigit_t_comp_gf.modello,
    sigit_t_comp_gf.flg_sorgente_ext,
    sigit_t_comp_gf.flg_fluido_utenze,
    sigit_t_comp_gf.fluido_frigorigeno,
    sigit_t_comp_gf.n_circuiti,
    sigit_t_comp_gf.raffrescamento_eer,
    sigit_t_comp_gf.raff_potenza_kw,
    sigit_t_comp_gf.raff_potenza_ass,
    sigit_t_comp_gf.riscaldamento_cop,
    sigit_t_comp_gf.risc_potenza_kw,
    sigit_t_comp_gf.risc_potenza_ass_kw,
    sigit_t_comp_gf.flg_dismissione,
    sigit_t_comp_gf.data_dismiss,
    sigit_t_comp_gf.data_ult_mod,
    sigit_t_comp_gf.utente_ult_mod,
        CASE
            WHEN sigit_t_comp_gf.raff_potenza_kw > sigit_t_comp_gf.risc_potenza_kw THEN sigit_t_comp_gf.raff_potenza_kw
            ELSE sigit_t_comp_gf.risc_potenza_kw
        END AS potenza_termica_kw,
    sigit_t_allegato.data_controllo,
    sigit_t_impianto.istat_comune,
    sigit_t_impianto.denominazione_comune,
    sigit_t_impianto.denominazione_provincia,
    sigit_t_impianto.fk_stato AS stato_impianto,
    sigit_d_stato_imp.des_stato AS des_stato_impianto,
    sigit_t_libretto.data_consolidamento
   FROM sigit_t_comp_gf
     LEFT JOIN sigit_r_allegato_comp_gf USING (id_tipo_componente, progressivo, codice_impianto, data_install)
     LEFT JOIN sigit_t_allegato ON sigit_t_allegato.id_allegato = sigit_r_allegato_comp_gf.id_allegato AND sigit_t_allegato.fk_stato_rapp = 1::numeric
     LEFT JOIN sigit_t_dett_tipo2 ON sigit_t_dett_tipo2.fk_allegato = sigit_t_allegato.id_allegato AND sigit_t_dett_tipo2.codice_impianto = sigit_t_comp_gf.codice_impianto AND sigit_t_dett_tipo2.fk_tipo_componente::text = sigit_t_comp_gf.id_tipo_componente::text AND sigit_t_dett_tipo2.progressivo = sigit_t_comp_gf.progressivo AND sigit_t_dett_tipo2.data_install = sigit_t_comp_gf.data_install
     JOIN sigit_t_impianto ON sigit_t_impianto.codice_impianto = sigit_t_comp_gf.codice_impianto
     JOIN sigit_d_stato_imp ON sigit_t_impianto.fk_stato = sigit_d_stato_imp.id_stato
     LEFT JOIN sigit_t_libretto ON sigit_t_impianto.codice_impianto = sigit_t_libretto.codice_impianto AND sigit_t_libretto.fk_stato = 2::numeric
     LEFT JOIN sigit_d_marca ON sigit_t_comp_gf.fk_marca = sigit_d_marca.id_marca
     LEFT JOIN sigit_d_dettaglio_gf ON sigit_t_comp_gf.fk_dettaglio_gf = sigit_d_dettaglio_gf.id_dettaglio_gf
     LEFT JOIN sigit_d_combustibile ON sigit_t_comp_gf.fk_combustibile = sigit_d_combustibile.id_combustibile;

--ALTER TABLE vista_dw_sk4_gf
--  OWNER TO sigit_new;
--GRANT ALL ON TABLE vista_dw_sk4_gf TO sigit_new;
--GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_dw_sk4_gf TO sigit_new_rw;
--GRANT SELECT ON TABLE vista_dw_sk4_gf TO sigit_new_ro;

CREATE OR REPLACE VIEW vista_dw_sk4_gt AS 
 SELECT DISTINCT sigit_t_comp_gt.codice_impianto,
    sigit_t_comp_gt.id_tipo_componente,
    sigit_t_comp_gt.progressivo,
    sigit_t_comp_gt.data_install,
    sigit_t_comp_gt.data_dismiss,
    sigit_t_comp_gt.matricola,
    sigit_t_comp_gt.fk_marca,
    sigit_d_marca.des_marca,
    sigit_d_combustibile.id_combustibile,
    sigit_d_combustibile.des_combustibile,
    sigit_t_comp_gt.fk_fluido,
    sigit_d_fluido.des_fluido,
    sigit_t_comp_gt.fk_dettaglio_gt,
    sigit_d_dettaglio_gt.des_dettaglio_gt,
    sigit_t_comp_gt.modello,
    sigit_t_comp_gt.potenza_termica_kw,
    sigit_t_comp_gt.data_ult_mod,
    sigit_t_comp_gt.utente_ult_mod,
    sigit_t_comp_gt.rendimento_perc,
    sigit_t_comp_gt.n_moduli,
    sigit_t_comp_gt.flg_dismissione,
    sigit_t_allegato.data_controllo,
    sigit_t_impianto.istat_comune,
    sigit_t_impianto.denominazione_comune,
    sigit_t_impianto.denominazione_provincia,
    sigit_t_impianto.fk_stato AS stato_impianto,
    sigit_d_stato_imp.des_stato AS des_stato_impianto,
    sigit_t_libretto.data_consolidamento,
    sigit_t_dett_tipo1.e_nox_ppm,
    sigit_t_dett_tipo1.e_nox_mg_kwh,
    sigit_t_dett_tipo1.e_n_modulo_termico
   FROM sigit_t_comp_gt
     LEFT JOIN sigit_r_allegato_comp_gt USING (id_tipo_componente, progressivo, codice_impianto, data_install)
     LEFT JOIN sigit_t_allegato ON sigit_t_allegato.id_allegato = sigit_r_allegato_comp_gt.id_allegato AND sigit_t_allegato.fk_stato_rapp = 1::numeric
     LEFT JOIN sigit_t_dett_tipo1 ON sigit_t_dett_tipo1.fk_allegato = sigit_t_allegato.id_allegato AND sigit_t_dett_tipo1.fk_tipo_componente::text = sigit_r_allegato_comp_gt.id_tipo_componente::text AND sigit_t_dett_tipo1.progressivo = sigit_r_allegato_comp_gt.progressivo AND sigit_t_dett_tipo1.codice_impianto = sigit_r_allegato_comp_gt.codice_impianto AND sigit_t_dett_tipo1.data_install = sigit_r_allegato_comp_gt.data_install
     JOIN sigit_t_impianto ON sigit_t_impianto.codice_impianto = sigit_t_comp_gt.codice_impianto
     JOIN sigit_d_stato_imp ON sigit_t_impianto.fk_stato = sigit_d_stato_imp.id_stato
     LEFT JOIN sigit_t_libretto ON sigit_t_impianto.codice_impianto = sigit_t_libretto.codice_impianto AND sigit_t_libretto.fk_stato = 2::numeric
     LEFT JOIN sigit_d_marca ON sigit_t_comp_gt.fk_marca = sigit_d_marca.id_marca
     LEFT JOIN sigit_d_fluido ON sigit_t_comp_gt.fk_fluido = sigit_d_fluido.id_fluido
     LEFT JOIN sigit_d_dettaglio_gt ON sigit_t_comp_gt.fk_dettaglio_gt = sigit_d_dettaglio_gt.id_dettaglio_gt
     LEFT JOIN sigit_d_combustibile ON sigit_t_comp_gt.fk_combustibile = sigit_d_combustibile.id_combustibile;

--ALTER TABLE vista_dw_sk4_gt
--  OWNER TO sigit_new;
--GRANT ALL ON TABLE vista_dw_sk4_gt TO sigit_new;
--GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_dw_sk4_gt TO sigit_new_rw;
--GRANT SELECT ON TABLE vista_dw_sk4_gt TO sigit_new_ro;

CREATE OR REPLACE VIEW vista_dw_sk4_sc AS 
 SELECT DISTINCT sigit_t_comp_sc.codice_impianto,
    sigit_t_comp_sc.id_tipo_componente,
    sigit_t_comp_sc.progressivo,
    sigit_t_comp_sc.data_install,
    sigit_t_comp_sc.flg_dismissione,
    sigit_t_comp_sc.data_dismiss,
    sigit_t_comp_sc.data_ult_mod,
    sigit_t_comp_sc.utente_ult_mod,
    sigit_t_comp_sc.matricola,
    sigit_t_comp_sc.modello,
    sigit_t_comp_sc.potenza_termica_kw,
    sigit_t_comp_sc.fk_marca,
    sigit_d_marca.des_marca,
    sigit_t_allegato.data_controllo,
    sigit_t_impianto.istat_comune,
    sigit_t_impianto.denominazione_comune,
    sigit_t_impianto.denominazione_provincia,
    sigit_t_impianto.fk_stato AS stato_impianto,
    sigit_d_stato_imp.des_stato AS des_stato_impianto,
    sigit_t_libretto.data_consolidamento
   FROM sigit_t_comp_sc
     LEFT JOIN sigit_r_allegato_comp_sc USING (id_tipo_componente, progressivo, codice_impianto, data_install)
     LEFT JOIN sigit_t_allegato ON sigit_t_allegato.id_allegato = sigit_r_allegato_comp_sc.id_allegato AND sigit_t_allegato.fk_stato_rapp = 1::numeric
     LEFT JOIN sigit_t_dett_tipo3 ON sigit_t_dett_tipo3.fk_allegato = sigit_t_allegato.id_allegato AND sigit_t_dett_tipo3.codice_impianto = sigit_t_comp_sc.codice_impianto AND sigit_t_dett_tipo3.fk_tipo_componente::text = sigit_t_comp_sc.id_tipo_componente::text AND sigit_t_dett_tipo3.progressivo = sigit_t_comp_sc.progressivo AND sigit_t_dett_tipo3.data_install = sigit_t_comp_sc.data_install
     JOIN sigit_t_impianto ON sigit_t_impianto.codice_impianto = sigit_t_comp_sc.codice_impianto
     JOIN sigit_d_stato_imp ON sigit_t_impianto.fk_stato = sigit_d_stato_imp.id_stato
     LEFT JOIN sigit_t_libretto ON sigit_t_impianto.codice_impianto = sigit_t_libretto.codice_impianto AND sigit_t_libretto.fk_stato = 2::numeric
     LEFT JOIN sigit_d_marca ON sigit_t_comp_sc.fk_marca = sigit_d_marca.id_marca;

--ALTER TABLE vista_dw_sk4_sc
--  OWNER TO sigit_new;
--GRANT ALL ON TABLE vista_dw_sk4_sc TO sigit_new;
--GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_dw_sk4_sc TO sigit_new_rw;
--GRANT SELECT ON TABLE vista_dw_sk4_sc TO sigit_new_ro;

--DROP MATERIALIZED VIEW mv_od_vista_dettaglio_impianti;

--DROP MATERIALIZED VIEW mv_vista_dw_sk4_cg;

CREATE MATERIALIZED VIEW mv_vista_dw_sk4_cg AS 
 SELECT DISTINCT sigit_t_comp_cg.codice_impianto,
    sigit_t_comp_cg.id_tipo_componente,
    sigit_t_comp_cg.progressivo,
    sigit_t_comp_cg.data_install,
    sigit_t_comp_cg.data_dismiss,
    sigit_t_comp_cg.matricola,
    sigit_t_comp_cg.fk_marca,
    sigit_d_marca.des_marca,
    sigit_d_combustibile.id_combustibile,
    sigit_d_combustibile.des_combustibile,
    sigit_t_comp_cg.modello,
    sigit_t_comp_cg.potenza_termica_kw,
    sigit_t_comp_cg.data_ult_mod,
    sigit_t_comp_cg.utente_ult_mod,
    sigit_t_comp_cg.tipologia,
    sigit_t_comp_cg.potenza_elettrica_kw,
    sigit_t_comp_cg.temp_h2o_out_min,
    sigit_t_comp_cg.temp_h2o_out_max,
    sigit_t_comp_cg.temp_h2o_in_min,
    sigit_t_comp_cg.temp_h2o_in_max,
    sigit_t_comp_cg.temp_h2o_motore_min,
    sigit_t_comp_cg.temp_h2o_motore_max,
    sigit_t_comp_cg.temp_fumi_valle_min,
    sigit_t_comp_cg.temp_fumi_valle_max,
    sigit_t_comp_cg.temp_fumi_monte_min,
    sigit_t_comp_cg.temp_fumi_monte_max,
    sigit_t_comp_cg.co_min,
    sigit_t_comp_cg.co_max,
    sigit_t_comp_cg.flg_dismissione,
    sigit_t_allegato.data_controllo,
    sigit_t_impianto.istat_comune,
    sigit_t_impianto.denominazione_comune,
    sigit_t_impianto.denominazione_provincia,
    sigit_t_impianto.fk_stato AS stato_impianto,
    sigit_d_stato_imp.des_stato AS des_stato_impianto,
    sigit_t_libretto.data_consolidamento
   FROM sigit_t_comp_cg
     LEFT JOIN sigit_r_allegato_comp_cg USING (id_tipo_componente, progressivo, codice_impianto, data_install)
     LEFT JOIN sigit_t_allegato ON sigit_t_allegato.id_allegato = sigit_r_allegato_comp_cg.id_allegato AND sigit_t_allegato.fk_stato_rapp = 1::numeric
     LEFT JOIN sigit_t_dett_tipo4 ON sigit_t_dett_tipo4.fk_allegato = sigit_t_allegato.id_allegato AND sigit_t_dett_tipo4.fk_tipo_componente::text = sigit_r_allegato_comp_cg.id_tipo_componente::text AND sigit_t_dett_tipo4.progressivo = sigit_r_allegato_comp_cg.progressivo AND sigit_t_dett_tipo4.codice_impianto = sigit_r_allegato_comp_cg.codice_impianto AND sigit_t_dett_tipo4.data_install = sigit_r_allegato_comp_cg.data_install
     JOIN sigit_t_impianto ON sigit_t_impianto.codice_impianto = sigit_t_comp_cg.codice_impianto
     JOIN sigit_d_stato_imp ON sigit_t_impianto.fk_stato = sigit_d_stato_imp.id_stato
     LEFT JOIN sigit_t_libretto ON sigit_t_impianto.codice_impianto = sigit_t_libretto.codice_impianto AND sigit_t_libretto.fk_stato = 2::numeric
     LEFT JOIN sigit_d_marca ON sigit_t_comp_cg.fk_marca = sigit_d_marca.id_marca
     LEFT JOIN sigit_d_combustibile ON sigit_t_comp_cg.fk_combustibile = sigit_d_combustibile.id_combustibile
WITH DATA;

ALTER TABLE mv_vista_dw_sk4_cg
  OWNER TO sigit_new;
GRANT ALL ON TABLE mv_vista_dw_sk4_cg TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE mv_vista_dw_sk4_cg TO sigit_new_rw;
--GRANT SELECT ON TABLE mv_vista_dw_sk4_cg TO sigit_new_ro;

--DROP MATERIALIZED VIEW mv_vista_dw_sk4_gf;

CREATE MATERIALIZED VIEW mv_vista_dw_sk4_gf AS 
 SELECT DISTINCT sigit_t_comp_gf.codice_impianto,
    sigit_t_comp_gf.id_tipo_componente,
    sigit_t_comp_gf.progressivo,
    sigit_t_comp_gf.data_install,
    sigit_t_comp_gf.matricola,
    sigit_t_comp_gf.fk_marca,
    sigit_d_marca.des_marca,
    sigit_d_combustibile.id_combustibile,
    sigit_d_combustibile.des_combustibile,
    sigit_t_comp_gf.fk_dettaglio_gf,
    sigit_d_dettaglio_gf.des_dettaglio_gf,
    sigit_t_comp_gf.modello,
    sigit_t_comp_gf.flg_sorgente_ext,
    sigit_t_comp_gf.flg_fluido_utenze,
    sigit_t_comp_gf.fluido_frigorigeno,
    sigit_t_comp_gf.n_circuiti,
    sigit_t_comp_gf.raffrescamento_eer,
    sigit_t_comp_gf.raff_potenza_kw,
    sigit_t_comp_gf.raff_potenza_ass,
    sigit_t_comp_gf.riscaldamento_cop,
    sigit_t_comp_gf.risc_potenza_kw,
    sigit_t_comp_gf.risc_potenza_ass_kw,
    sigit_t_comp_gf.flg_dismissione,
    sigit_t_comp_gf.data_dismiss,
    sigit_t_comp_gf.data_ult_mod,
    sigit_t_comp_gf.utente_ult_mod,
        CASE
            WHEN sigit_t_comp_gf.raff_potenza_kw > sigit_t_comp_gf.risc_potenza_kw THEN sigit_t_comp_gf.raff_potenza_kw
            ELSE sigit_t_comp_gf.risc_potenza_kw
        END AS potenza_termica_kw,
    sigit_t_allegato.data_controllo,
    sigit_t_impianto.istat_comune,
    sigit_t_impianto.denominazione_comune,
    sigit_t_impianto.denominazione_provincia,
    sigit_t_impianto.fk_stato AS stato_impianto,
    sigit_d_stato_imp.des_stato AS des_stato_impianto,
    sigit_t_libretto.data_consolidamento
   FROM sigit_t_comp_gf
     LEFT JOIN sigit_r_allegato_comp_gf USING (id_tipo_componente, progressivo, codice_impianto, data_install)
     LEFT JOIN sigit_t_allegato ON sigit_t_allegato.id_allegato = sigit_r_allegato_comp_gf.id_allegato AND sigit_t_allegato.fk_stato_rapp = 1::numeric
     LEFT JOIN sigit_t_dett_tipo2 ON sigit_t_dett_tipo2.fk_allegato = sigit_t_allegato.id_allegato AND sigit_t_dett_tipo2.codice_impianto = sigit_t_comp_gf.codice_impianto AND sigit_t_dett_tipo2.fk_tipo_componente::text = sigit_t_comp_gf.id_tipo_componente::text AND sigit_t_dett_tipo2.progressivo = sigit_t_comp_gf.progressivo AND sigit_t_dett_tipo2.data_install = sigit_t_comp_gf.data_install
     JOIN sigit_t_impianto ON sigit_t_impianto.codice_impianto = sigit_t_comp_gf.codice_impianto
     JOIN sigit_d_stato_imp ON sigit_t_impianto.fk_stato = sigit_d_stato_imp.id_stato
     LEFT JOIN sigit_t_libretto ON sigit_t_impianto.codice_impianto = sigit_t_libretto.codice_impianto AND sigit_t_libretto.fk_stato = 2::numeric
     LEFT JOIN sigit_d_marca ON sigit_t_comp_gf.fk_marca = sigit_d_marca.id_marca
     LEFT JOIN sigit_d_dettaglio_gf ON sigit_t_comp_gf.fk_dettaglio_gf = sigit_d_dettaglio_gf.id_dettaglio_gf
     LEFT JOIN sigit_d_combustibile ON sigit_t_comp_gf.fk_combustibile = sigit_d_combustibile.id_combustibile
WITH DATA;

ALTER TABLE mv_vista_dw_sk4_gf
  OWNER TO sigit_new;
GRANT ALL ON TABLE mv_vista_dw_sk4_gf TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE mv_vista_dw_sk4_gf TO sigit_new_rw;
--GRANT SELECT ON TABLE mv_vista_dw_sk4_gf TO sigit_new_ro;

--DROP MATERIALIZED VIEW mv_vista_dw_sk4_gt;

CREATE MATERIALIZED VIEW mv_vista_dw_sk4_gt AS 
 SELECT DISTINCT sigit_t_comp_gt.codice_impianto,
    sigit_t_comp_gt.id_tipo_componente,
    sigit_t_comp_gt.progressivo,
    sigit_t_comp_gt.data_install,
    sigit_t_comp_gt.data_dismiss,
    sigit_t_comp_gt.matricola,
    sigit_t_comp_gt.fk_marca,
    sigit_d_marca.des_marca,
    sigit_d_combustibile.id_combustibile,
    sigit_d_combustibile.des_combustibile,
    sigit_t_comp_gt.fk_fluido,
    sigit_d_fluido.des_fluido,
    sigit_t_comp_gt.fk_dettaglio_gt,
    sigit_d_dettaglio_gt.des_dettaglio_gt,
    sigit_t_comp_gt.modello,
    sigit_t_comp_gt.potenza_termica_kw,
    sigit_t_comp_gt.data_ult_mod,
    sigit_t_comp_gt.utente_ult_mod,
    sigit_t_comp_gt.rendimento_perc,
    sigit_t_comp_gt.n_moduli,
    sigit_t_comp_gt.flg_dismissione,
    sigit_t_allegato.data_controllo,
    sigit_t_impianto.istat_comune,
    sigit_t_impianto.denominazione_comune,
    sigit_t_impianto.denominazione_provincia,
    sigit_t_impianto.fk_stato AS stato_impianto,
    sigit_d_stato_imp.des_stato AS des_stato_impianto,
    sigit_t_libretto.data_consolidamento,
    sigit_t_dett_tipo1.e_nox_ppm,
    sigit_t_dett_tipo1.e_nox_mg_kwh,
    sigit_t_dett_tipo1.e_n_modulo_termico
   FROM sigit_t_comp_gt
     LEFT JOIN sigit_r_allegato_comp_gt USING (id_tipo_componente, progressivo, codice_impianto, data_install)
     LEFT JOIN sigit_t_allegato ON sigit_t_allegato.id_allegato = sigit_r_allegato_comp_gt.id_allegato AND sigit_t_allegato.fk_stato_rapp = 1::numeric
     LEFT JOIN sigit_t_dett_tipo1 ON sigit_t_dett_tipo1.fk_allegato = sigit_t_allegato.id_allegato AND sigit_t_dett_tipo1.fk_tipo_componente::text = sigit_r_allegato_comp_gt.id_tipo_componente::text AND sigit_t_dett_tipo1.progressivo = sigit_r_allegato_comp_gt.progressivo AND sigit_t_dett_tipo1.codice_impianto = sigit_r_allegato_comp_gt.codice_impianto AND sigit_t_dett_tipo1.data_install = sigit_r_allegato_comp_gt.data_install
     JOIN sigit_t_impianto ON sigit_t_impianto.codice_impianto = sigit_t_comp_gt.codice_impianto
     JOIN sigit_d_stato_imp ON sigit_t_impianto.fk_stato = sigit_d_stato_imp.id_stato
     LEFT JOIN sigit_t_libretto ON sigit_t_impianto.codice_impianto = sigit_t_libretto.codice_impianto AND sigit_t_libretto.fk_stato = 2::numeric
     LEFT JOIN sigit_d_marca ON sigit_t_comp_gt.fk_marca = sigit_d_marca.id_marca
     LEFT JOIN sigit_d_fluido ON sigit_t_comp_gt.fk_fluido = sigit_d_fluido.id_fluido
     LEFT JOIN sigit_d_dettaglio_gt ON sigit_t_comp_gt.fk_dettaglio_gt = sigit_d_dettaglio_gt.id_dettaglio_gt
     LEFT JOIN sigit_d_combustibile ON sigit_t_comp_gt.fk_combustibile = sigit_d_combustibile.id_combustibile
WITH DATA;

ALTER TABLE mv_vista_dw_sk4_gt
  OWNER TO sigit_new;
GRANT ALL ON TABLE mv_vista_dw_sk4_gt TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE mv_vista_dw_sk4_gt TO sigit_new_rw;
--GRANT SELECT ON TABLE mv_vista_dw_sk4_gt TO sigit_new_ro;

--DROP MATERIALIZED VIEW mv_vista_dw_sk4_sc;

CREATE MATERIALIZED VIEW mv_vista_dw_sk4_sc AS 
 SELECT DISTINCT sigit_t_comp_sc.codice_impianto,
    sigit_t_comp_sc.id_tipo_componente,
    sigit_t_comp_sc.progressivo,
    sigit_t_comp_sc.data_install,
    sigit_t_comp_sc.flg_dismissione,
    sigit_t_comp_sc.data_dismiss,
    sigit_t_comp_sc.data_ult_mod,
    sigit_t_comp_sc.utente_ult_mod,
    sigit_t_comp_sc.matricola,
    sigit_t_comp_sc.modello,
    sigit_t_comp_sc.potenza_termica_kw,
    sigit_t_comp_sc.fk_marca,
    sigit_d_marca.des_marca,
    sigit_t_allegato.data_controllo,
    sigit_t_impianto.istat_comune,
    sigit_t_impianto.denominazione_comune,
    sigit_t_impianto.denominazione_provincia,
    sigit_t_impianto.fk_stato AS stato_impianto,
    sigit_d_stato_imp.des_stato AS des_stato_impianto,
    sigit_t_libretto.data_consolidamento
   FROM sigit_t_comp_sc
     LEFT JOIN sigit_r_allegato_comp_sc USING (id_tipo_componente, progressivo, codice_impianto, data_install)
     LEFT JOIN sigit_t_allegato ON sigit_t_allegato.id_allegato = sigit_r_allegato_comp_sc.id_allegato AND sigit_t_allegato.fk_stato_rapp = 1::numeric
     LEFT JOIN sigit_t_dett_tipo3 ON sigit_t_dett_tipo3.fk_allegato = sigit_t_allegato.id_allegato AND sigit_t_dett_tipo3.codice_impianto = sigit_t_comp_sc.codice_impianto AND sigit_t_dett_tipo3.fk_tipo_componente::text = sigit_t_comp_sc.id_tipo_componente::text AND sigit_t_dett_tipo3.progressivo = sigit_t_comp_sc.progressivo AND sigit_t_dett_tipo3.data_install = sigit_t_comp_sc.data_install
     JOIN sigit_t_impianto ON sigit_t_impianto.codice_impianto = sigit_t_comp_sc.codice_impianto
     JOIN sigit_d_stato_imp ON sigit_t_impianto.fk_stato = sigit_d_stato_imp.id_stato
     LEFT JOIN sigit_t_libretto ON sigit_t_impianto.codice_impianto = sigit_t_libretto.codice_impianto AND sigit_t_libretto.fk_stato = 2::numeric
     LEFT JOIN sigit_d_marca ON sigit_t_comp_sc.fk_marca = sigit_d_marca.id_marca
WITH DATA;

ALTER TABLE mv_vista_dw_sk4_sc
  OWNER TO sigit_new;
GRANT ALL ON TABLE mv_vista_dw_sk4_sc TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE mv_vista_dw_sk4_sc TO sigit_new_rw;
--GRANT SELECT ON TABLE mv_vista_dw_sk4_sc TO sigit_new_ro;

CREATE MATERIALIZED VIEW mv_od_vista_dettaglio_impianti AS 
 SELECT i.codice_impianto,
    i.denominazione_comune,
    i.denominazione_provincia,
    ui.l1_2_fk_categoria,
    ui.l1_2_vol_risc_m3,
    ui.l1_2_vol_raff_m3,
    i.l1_3_pot_h2o_kw,
    i.l1_3_pot_clima_inv_kw,
    i.l1_3_pot_clima_est_kw,
    gt.id_tipo_componente AS tipo_componente,
    gt.progressivo,
    gt.data_install,
    gt.des_marca,
    gt.des_combustibile,
    gt.des_dettaglio_gt AS des_dettaglio,
    gt.potenza_termica_kw AS potenza,
    gt.rendimento_perc,
    gt.data_controllo,
    gt.e_nox_ppm,
    gt.e_nox_mg_kwh,
    gt.e_n_modulo_termico
   FROM sigit_t_impianto i
     JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
     JOIN mv_vista_dw_sk4_gt gt ON i.codice_impianto = gt.codice_impianto
  WHERE gt.data_dismiss IS NULL AND ui.flg_principale = 1::numeric AND i.fk_stato = 1::numeric AND ((i.codice_impianto, gt.id_tipo_componente::text, gt.progressivo, gt.data_controllo) IN ( SELECT i_1.codice_impianto,
            gt_1.id_tipo_componente AS tipo_componente,
            gt_1.progressivo,
            max(gt_1.data_controllo) AS data_controllo
           FROM sigit_t_impianto i_1
             JOIN sigit_t_unita_immobiliare ui_1 ON i_1.codice_impianto = ui_1.codice_impianto
             JOIN mv_vista_dw_sk4_gt gt_1 ON i_1.codice_impianto = gt_1.codice_impianto
          WHERE gt_1.data_dismiss IS NULL AND ui_1.flg_principale = 1::numeric AND i_1.fk_stato = 1::numeric
          GROUP BY i_1.codice_impianto, gt_1.id_tipo_componente, gt_1.progressivo))
  GROUP BY i.codice_impianto, i.denominazione_comune, i.denominazione_provincia, ui.l1_2_fk_categoria, ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, gt.id_tipo_componente, gt.progressivo, gt.data_install, gt.des_marca, gt.des_combustibile, gt.des_dettaglio_gt, gt.potenza_termica_kw, gt.rendimento_perc, gt.data_controllo, gt.e_nox_ppm, gt.e_nox_mg_kwh, gt.e_n_modulo_termico
UNION
 SELECT i.codice_impianto,
    i.denominazione_comune,
    i.denominazione_provincia,
    ui.l1_2_fk_categoria,
    ui.l1_2_vol_risc_m3,
    ui.l1_2_vol_raff_m3,
    i.l1_3_pot_h2o_kw,
    i.l1_3_pot_clima_inv_kw,
    i.l1_3_pot_clima_est_kw,
    gf.id_tipo_componente AS tipo_componente,
    gf.progressivo,
    gf.data_install,
    gf.des_marca,
    gf.des_combustibile,
    NULL::text AS des_dettaglio,
    gf.potenza_termica_kw AS potenza,
    NULL::numeric AS rendimento_perc,
    max(gf.data_controllo) AS data_controllo,
    NULL::numeric AS e_nox_ppm,
    NULL::numeric AS e_nox_mg_kwh,
    NULL::numeric AS e_n_modulo_termico
   FROM sigit_t_impianto i
     JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
     JOIN mv_vista_dw_sk4_gf gf ON i.codice_impianto = gf.codice_impianto
  WHERE gf.data_dismiss IS NULL AND ui.flg_principale = 1::numeric AND i.fk_stato = 1::numeric
  GROUP BY i.codice_impianto, i.denominazione_comune, i.denominazione_provincia, ui.l1_2_fk_categoria, ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, gf.id_tipo_componente, gf.progressivo, gf.data_install, gf.des_marca, gf.des_combustibile, NULL::text, gf.potenza_termica_kw
UNION
 SELECT i.codice_impianto,
    i.denominazione_comune,
    i.denominazione_provincia,
    ui.l1_2_fk_categoria,
    ui.l1_2_vol_risc_m3,
    ui.l1_2_vol_raff_m3,
    i.l1_3_pot_h2o_kw,
    i.l1_3_pot_clima_inv_kw,
    i.l1_3_pot_clima_est_kw,
    sc.id_tipo_componente AS tipo_componente,
    sc.progressivo,
    sc.data_install,
    sc.des_marca,
    NULL::character varying AS des_combustibile,
    NULL::text AS des_dettaglio,
    sc.potenza_termica_kw AS potenza,
    NULL::numeric AS rendimento_perc,
    max(sc.data_controllo) AS data_controllo,
    NULL::numeric AS e_nox_ppm,
    NULL::numeric AS e_nox_mg_kwh,
    NULL::numeric AS e_n_modulo_termico
   FROM sigit_t_impianto i
     JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
     JOIN mv_vista_dw_sk4_sc sc ON i.codice_impianto = sc.codice_impianto
  WHERE sc.data_dismiss IS NULL AND ui.flg_principale = 1::numeric AND i.fk_stato = 1::numeric
  GROUP BY i.codice_impianto, i.denominazione_comune, i.denominazione_provincia, ui.l1_2_fk_categoria, ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, sc.id_tipo_componente, sc.progressivo, sc.data_install, sc.des_marca, NULL::text, sc.potenza_termica_kw
UNION
 SELECT i.codice_impianto,
    i.denominazione_comune,
    i.denominazione_provincia,
    ui.l1_2_fk_categoria,
    ui.l1_2_vol_risc_m3,
    ui.l1_2_vol_raff_m3,
    i.l1_3_pot_h2o_kw,
    i.l1_3_pot_clima_inv_kw,
    i.l1_3_pot_clima_est_kw,
    cg.id_tipo_componente AS tipo_componente,
    cg.progressivo,
    cg.data_install,
    cg.des_marca,
    cg.des_combustibile,
    NULL::character varying AS des_dettaglio,
    cg.potenza_termica_kw AS potenza,
    NULL::numeric AS rendimento_perc,
    max(cg.data_controllo) AS data_controllo,
    NULL::numeric AS e_nox_ppm,
    NULL::numeric AS e_nox_mg_kwh,
    NULL::numeric AS e_n_modulo_termico
   FROM sigit_t_impianto i
     JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
     JOIN mv_vista_dw_sk4_cg cg ON i.codice_impianto = cg.codice_impianto
  WHERE cg.data_dismiss IS NULL AND ui.flg_principale = 1::numeric AND i.fk_stato = 1::numeric
  GROUP BY i.codice_impianto, i.denominazione_comune, i.denominazione_provincia, ui.l1_2_fk_categoria, ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, cg.id_tipo_componente, cg.progressivo, cg.data_install, cg.des_marca, cg.des_combustibile, cg.potenza_termica_kw
WITH DATA;

ALTER TABLE mv_od_vista_dettaglio_impianti
  OWNER TO sigit_new;
GRANT ALL ON TABLE mv_od_vista_dettaglio_impianti TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE mv_od_vista_dettaglio_impianti TO sigit_new_rw;
--GRANT SELECT ON TABLE mv_od_vista_dettaglio_impianti TO sigit_new_ro;

----------------------------------------------------------------------------------------
-- 01/10/2020  Lorita
-- Inserite viste materializzate e viste di viste ad uso del DWH già realizzate a luglio
----------------------------------------------------------------------------------------
CREATE materialized VIEW mv_vista_dati_import_distributori
AS SELECT vista_elenco_distributori.codice_fiscale AS cf_distributore,
    vista_elenco_distributori.denominazione AS denominazione_distributore,
    vista_elenco_distributori.sigla_rea AS sigla_rea_distributore,
    vista_elenco_distributori.numero_rea AS numero_rea_distributore,
    sigit_t_import_distrib.fk_persona_giuridica,
    sigit_d_stato_distrib.des_stato_distrib,
    sigit_t_dato_distrib.fk_import_distrib,
    sigit_t_import_distrib.id_import_distrib,
    sigit_t_import_distrib.data_inizio_elab,
    sigit_t_import_distrib.data_fine_elab,
    sigit_t_import_distrib.nome_file_import,
    sigit_t_import_distrib.data_annullamento,
    sigit_t_import_distrib.anno_riferimento,
    sigit_t_import_distrib.tot_record_elaborati,
    sigit_t_import_distrib.tot_record_scartati,
    sigit_t_import_distrib.data_ult_mod,
    sigit_t_dato_distrib.fk_tipo_contratto,
    sigit_d_tipo_contratto_distrib.des_tipo_contratto_distrib,
    sigit_t_dato_distrib.fk_combustibile,
    sigit_d_combustibile.des_combustibile,
    sigit_t_dato_distrib.fk_unita_misura,
    sigit_d_unita_misura.des_unita_misura,
    sigit_t_dato_distrib.id_dato_distrib,
    sigit_t_dato_distrib.fk_categoria_util,
    sigit_d_categoria_util.des_categoria_util,
    sigit_t_dato_distrib.flg_pf_pg,
    sigit_t_dato_distrib.cognome_denom AS cognome_denom_cliente,
    sigit_t_dato_distrib.nome AS nome_cliente,
    sigit_t_dato_distrib.cf_piva AS cf_cliente,
    sigit_t_dato_distrib.anno_rif,
    sigit_t_dato_distrib.nr_mesi_fattur,
    sigit_t_dato_distrib.dug AS dug_cliente,
    sigit_t_dato_distrib.indirizzo AS indirizzo_cliente,
    sigit_t_dato_distrib.civico AS civico_cliente,
    sigit_t_dato_distrib.cap AS cap_cliente,
    sigit_t_dato_distrib.istat_comune AS istat_comune_cliente,
    sigit_t_dato_distrib.codice_assenza_catast,
    sigit_t_rif_catast.sezione,
    sigit_t_rif_catast.foglio,
    sigit_t_rif_catast.particella,
    sigit_t_rif_catast.subalterno,
    sigit_t_dato_distrib.pod_pdr,
    sigit_t_dato_distrib.consumo_anno,
    sigit_t_dato_distrib.consumo_mensile,
    sigit_t_dato_distrib.mese_riferimento,
    sigit_t_dato_distrib.consumo_giornaliero,
    sigit_t_dato_distrib.giorno_riferimento,
    sigit_t_dato_distrib.volumetria,
    sigit_t_dato_distrib.flg_pf_pg_fatt,
    sigit_t_dato_distrib.cognome_denom_fatt,
    sigit_t_dato_distrib.nome_fatt,
    sigit_t_dato_distrib.cf_piva_fatt,
    sigit_t_dato_distrib.dug_fatt,
    sigit_t_dato_distrib.indirizzo_fatt,
    sigit_t_dato_distrib.civico_fatt,
    sigit_t_dato_distrib.cap_fatt,
    sigit_t_dato_distrib.istat_comune_fatt
   FROM sigit_t_dato_distrib
     JOIN sigit_d_tipo_contratto_distrib ON sigit_t_dato_distrib.fk_tipo_contratto = sigit_d_tipo_contratto_distrib.id_tipo_contratto_distrib
     JOIN sigit_d_combustibile ON sigit_t_dato_distrib.fk_combustibile = sigit_d_combustibile.id_combustibile
     JOIN sigit_d_unita_misura ON sigit_t_dato_distrib.fk_unita_misura::text = sigit_d_unita_misura.id_unita_misura::text
     JOIN sigit_d_categoria_util ON sigit_d_categoria_util.id_categoria_util::text = sigit_t_dato_distrib.fk_categoria_util::text
     JOIN sigit_t_import_distrib ON sigit_t_dato_distrib.fk_import_distrib = sigit_t_import_distrib.id_import_distrib
     JOIN vista_elenco_distributori ON sigit_t_import_distrib.fk_persona_giuridica = vista_elenco_distributori.id_persona_giuridica
     JOIN sigit_d_stato_distrib ON sigit_t_import_distrib.fk_stato_distrib = sigit_d_stato_distrib.id_stato_distrib
     LEFT JOIN sigit_t_rif_catast ON sigit_t_dato_distrib.id_dato_distrib = sigit_t_rif_catast.fk_dato_distrib;

ALTER TABLE mv_vista_dati_import_distributori
  OWNER TO sigit_new;
GRANT ALL ON TABLE mv_vista_dati_import_distributori TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE mv_vista_dati_import_distributori TO sigit_new_rw;

CREATE materialized VIEW sigit_new.mv_vista_impianti_imprese
AS SELECT DISTINCT sigit_r_comp4_manut.codice_impianto,
    sigit_t_persona_giuridica.sigla_rea,
    sigit_t_persona_giuridica.numero_rea,
    sigit_t_persona_giuridica.codice_fiscale,
    sigit_r_comp4_manut.fk_ruolo,
    sigit_d_ruolo.ruolo_funz
   FROM sigit_d_ruolo
     JOIN sigit_r_comp4_manut ON sigit_d_ruolo.id_ruolo = sigit_r_comp4_manut.fk_ruolo
     JOIN sigit_t_persona_giuridica ON sigit_r_comp4_manut.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
  WHERE (sigit_r_comp4_manut.fk_ruolo = ANY (ARRAY[6::numeric, 7::numeric, 8::numeric, 9::numeric])) AND sigit_r_comp4_manut.data_fine IS NULL
UNION
 SELECT DISTINCT sigit_r_imp_ruolo_pfpg.codice_impianto,
    sigit_t_persona_giuridica.sigla_rea,
    sigit_t_persona_giuridica.numero_rea,
    sigit_t_persona_giuridica.codice_fiscale,
    sigit_r_imp_ruolo_pfpg.fk_ruolo,
    sigit_d_ruolo.ruolo_funz
   FROM sigit_d_ruolo
     JOIN sigit_r_imp_ruolo_pfpg ON sigit_d_ruolo.id_ruolo = sigit_r_imp_ruolo_pfpg.fk_ruolo
     JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
  WHERE (sigit_r_imp_ruolo_pfpg.fk_ruolo = ANY (ARRAY[3::numeric])) AND sigit_r_imp_ruolo_pfpg.data_fine IS NULL
  ORDER BY 1;

ALTER TABLE mv_vista_impianti_imprese
  OWNER TO sigit_new;
GRANT ALL ON TABLE mv_vista_impianti_imprese TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE mv_vista_impianti_imprese TO sigit_new_rw;

CREATE materialized VIEW sigit_new.mv_vista_ricerca_impianti
AS SELECT DISTINCT sigit_t_impianto.codice_impianto,
    sigit_t_impianto.istat_comune,
    sigit_t_impianto.denominazione_comune,
    sigit_t_impianto.sigla_provincia,
    sigit_t_impianto.denominazione_provincia,
    sigit_t_impianto.fk_stato,
    sigit_t_impianto.l1_3_pot_h2o_kw,
    sigit_t_impianto.l1_3_pot_clima_inv_kw,
    sigit_t_impianto.l1_3_pot_clima_est_kw,
    sigit_t_unita_immobiliare.flg_nopdr,
    COALESCE(sigit_t_unita_immobiliare.indirizzo_sitad, sigit_t_unita_immobiliare.indirizzo_non_trovato) AS indirizzo_unita_immob,
    sigit_t_unita_immobiliare.civico,
    sigit_t_unita_immobiliare.sezione,
    sigit_t_unita_immobiliare.foglio,
    sigit_t_unita_immobiliare.particella,
    sigit_t_unita_immobiliare.subalterno,
    sigit_t_unita_immobiliare.pod_elettrico,
    sigit_t_unita_immobiliare.pdr_gas,
    q_pf_ruolo.id_pf_responsabile,
    q_pg_ruolo.id_pg_responsabile,
    q_contratto.id_pg_3r,
    COALESCE(q_pf_ruolo.denominazione_resp, q_pg_ruolo.denominazione_resp::text, q_pf_ruolo.denominazione_resp) AS denominazione_responsabile,
    q_contratto.denominazione_3_responsabile,
    q_contratto.sigla_rea_3r,
    q_contratto.numero_rea_3r,
    q_contratto.codice_fiscale_3r,
    COALESCE(q_pf_ruolo.codice_fisc, q_pg_ruolo.codice_fisc, q_pf_ruolo.codice_fisc) AS codice_fiscale,
    COALESCE(q_pf_ruolo.data_fine_pfpg, q_pg_ruolo.data_fine_pfpg, q_pf_ruolo.data_fine_pfpg) AS data_fine_pfpg,
    COALESCE(q_pf_ruolo.ruolo_resp, q_pg_ruolo.ruolo_resp, q_pf_ruolo.ruolo_resp) AS ruolo_responsabile,
    COALESCE(q_pf_ruolo.ruolo_funz1, q_pg_ruolo.ruolo_funz1, q_pf_ruolo.ruolo_funz1) AS ruolo_funz,
    COALESCE(q_pf_ruolo.des_ruolo1, q_pg_ruolo.des_ruolo1, q_pf_ruolo.des_ruolo1) AS des_ruolo,
    sigit_t_impianto.flg_tipo_impianto,
    sigit_t_impianto.flg_apparecc_ui_ext,
    sigit_t_impianto.flg_contabilizzazione,
    sigit_d_stato_imp.des_stato,
    sigit_t_unita_immobiliare.fk_l2,
    sigit_t_impianto.flg_visu_proprietario
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
            sigit_d_ruolo.ruolo_funz AS ruolo_funz1,
            sigit_d_ruolo.des_ruolo AS des_ruolo1,
            now() AS data_validita,
            sigit_r_imp_ruolo_pfpg_1.data_inizio,
            sigit_r_imp_ruolo_pfpg_1.data_fine
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
            sigit_d_ruolo.ruolo_funz AS ruolo_funz1,
            sigit_d_ruolo.des_ruolo AS des_ruolo1,
            now() AS data_validita,
            sigit_r_imp_ruolo_pfpg.data_inizio,
            sigit_r_imp_ruolo_pfpg.data_fine
           FROM sigit_d_ruolo
             JOIN sigit_r_imp_ruolo_pfpg ON sigit_d_ruolo.id_ruolo = sigit_r_imp_ruolo_pfpg.fk_ruolo
             JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
          WHERE (sigit_r_imp_ruolo_pfpg.fk_ruolo = ANY (ARRAY[4::numeric, 5::numeric, 10::numeric, 11::numeric, 12::numeric, 13::numeric])) AND sigit_r_imp_ruolo_pfpg.data_inizio <= now() AND now() <= COALESCE(sigit_r_imp_ruolo_pfpg.data_fine::timestamp with time zone, now(), sigit_r_imp_ruolo_pfpg.data_fine::timestamp with time zone)) q_pg_ruolo ON sigit_t_impianto.codice_impianto = q_pg_ruolo.codice_impianto
     LEFT JOIN ( SELECT sigit_t_contratto_2019.id_contratto,
            sigit_t_contratto_2019.codice_impianto,
            sigit_t_contratto_2019.data_cessazione,
            sigit_t_contratto_2019.flg_tacito_rinnovo,
            sigit_t_contratto_2019.data_inizio,
            sigit_t_persona_giuridica_1.id_persona_giuridica AS id_pg_3r,
            sigit_t_persona_giuridica_1.denominazione AS denominazione_3_responsabile,
            sigit_t_persona_giuridica_1.sigla_rea AS sigla_rea_3r,
            sigit_t_persona_giuridica_1.numero_rea AS numero_rea_3r,
            sigit_t_persona_giuridica_1.codice_fiscale AS codice_fiscale_3r
           FROM sigit_t_contratto_2019
             JOIN sigit_t_persona_giuridica sigit_t_persona_giuridica_1 ON sigit_t_contratto_2019.fk_pg_3_resp = sigit_t_persona_giuridica_1.id_persona_giuridica
          WHERE sigit_t_contratto_2019.data_cessazione IS NULL AND (sigit_t_contratto_2019.flg_tacito_rinnovo = 1::numeric OR sigit_t_contratto_2019.flg_tacito_rinnovo = 0::numeric AND sigit_t_contratto_2019.data_fine >= now()::date)) q_contratto ON sigit_t_impianto.codice_impianto = q_contratto.codice_impianto
  WHERE sigit_t_unita_immobiliare.flg_principale = 1::numeric;

ALTER TABLE mv_vista_ricerca_impianti
  OWNER TO sigit_new;
GRANT ALL ON TABLE mv_vista_ricerca_impianti TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE mv_vista_ricerca_impianti TO sigit_new_rw;

CREATE materialized VIEW sigit_new.mv_vista_elenco_distributori
AS SELECT sigit_t_persona_giuridica.id_persona_giuridica,
    sigit_t_persona_giuridica.denominazione,
    sigit_t_persona_giuridica.codice_fiscale,
    sigit_t_persona_giuridica.fk_l2,
    sigit_t_persona_giuridica.indirizzo_sitad,
    sigit_t_persona_giuridica.indirizzo_non_trovato,
    sigit_t_persona_giuridica.sigla_prov,
    sigit_t_persona_giuridica.istat_comune,
    sigit_t_persona_giuridica.comune,
    sigit_t_persona_giuridica.provincia,
    sigit_t_persona_giuridica.civico,
    sigit_t_persona_giuridica.cap,
    sigit_t_persona_giuridica.email,
    sigit_t_persona_giuridica.data_inizio_attivita,
    sigit_t_persona_giuridica.data_cessazione,
    sigit_t_persona_giuridica.sigla_rea,
    sigit_t_persona_giuridica.numero_rea,
    sigit_t_persona_giuridica.flg_amministratore,
    sigit_t_persona_giuridica.data_ult_mod,
    sigit_t_persona_giuridica.utente_ult_mod,
    sigit_t_persona_giuridica.flg_terzo_responsabile,
    sigit_t_persona_giuridica.flg_distributore
   FROM sigit_t_persona_giuridica
  WHERE sigit_t_persona_giuridica.flg_distributore = 1::numeric;

ALTER TABLE mv_vista_elenco_distributori
  OWNER TO sigit_new;
GRANT ALL ON TABLE mv_vista_elenco_distributori TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE mv_vista_elenco_distributori TO sigit_new_rw;

--
CREATE VIEW sigit_new.vmv_od_vista_dettaglio_impianti as 
select * from mv_od_vista_dettaglio_impianti;

GRANT SELECT ON TABLE sigit_new.vmv_od_vista_dettaglio_impianti TO sigit_new_ro;

CREATE VIEW sigit_new.vmv_VISTA_DATI_IMPORT_DISTRIBUTORI as 
select * from mv_VISTA_DATI_IMPORT_DISTRIBUTORI;

GRANT SELECT ON TABLE sigit_new.vmv_VISTA_DATI_IMPORT_DISTRIBUTORI TO sigit_new_ro;

CREATE VIEW sigit_new.vmv_VISTA_DW_SK4_CG as 
select * from mv_VISTA_DW_SK4_CG;

GRANT SELECT ON TABLE sigit_new.vmv_VISTA_DW_SK4_CG TO sigit_new_ro;

CREATE VIEW sigit_new.vmv_VISTA_DW_SK4_GF as 
select * from mv_VISTA_DW_SK4_GF;

GRANT SELECT ON TABLE sigit_new.vmv_VISTA_DW_SK4_GF TO sigit_new_ro;

CREATE VIEW sigit_new.vmv_VISTA_DW_SK4_GT as 
select * from mv_VISTA_DW_SK4_GT;

GRANT SELECT ON TABLE sigit_new.vmv_VISTA_DW_SK4_GT TO sigit_new_ro;

CREATE VIEW sigit_new.vmv_VISTA_DW_SK4_SC as 
select * from mv_VISTA_DW_SK4_SC;

GRANT SELECT ON TABLE sigit_new.vmv_VISTA_DW_SK4_SC TO sigit_new_ro;

CREATE VIEW sigit_new.vmv_VISTA_IMPIANTI_IMPRESE as 
select * from mv_VISTA_IMPIANTI_IMPRESE;

GRANT SELECT ON TABLE sigit_new.vmv_VISTA_IMPIANTI_IMPRESE TO sigit_new_ro;

CREATE VIEW sigit_new.vmv_VISTA_RICERCA_IMPIANTI as 
select * from mv_VISTA_RICERCA_IMPIANTI;

GRANT SELECT ON TABLE sigit_new.vmv_VISTA_RICERCA_IMPIANTI TO sigit_new_ro;

CREATE VIEW sigit_new.vmv_vista_elenco_distributori as 
select * from mv_vista_elenco_distributori;

GRANT SELECT ON TABLE sigit_new.vmv_vista_elenco_distributori TO sigit_new_ro;

----------------------------------------------------------------------------------------
-- 01/10/2020  Lorita
-- Inserita function per gli aggiornamenti automatici e usata, per il momento, solo per
-- il refresh delle viste materializzate. Da richiamare dal nuovo batch RPITAU000-1
----------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION sigit_new.fnc_aggiornamenti_automatici()
 RETURNS bigint LANGUAGE plpgsql SECURITY DEFINER
as
 $function$
DECLARE

 -- *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
 -- *** 
 -- *** funzione che esegue processi di aggiornamento schedulati da batch
 -- *** prima versione con le operazioni giornaliere 
 -- *** 
 -- *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
 
 v_return bigint := 0; -- N.B.: Pentaho necessita che il valore restituito sia di tipo bigint !!! 
 --
 v_messaggio_inizio character varying(200);
 v_nome_funzione character varying(200);
 v_sqlerrm character varying(1000);
 --
  
BEGIN

 v_messaggio_inizio := 'Aggiornamenti Automatici';
 v_nome_funzione := 'fnc_aggiornamenti_automatici';

 RAISE NOTICE '*** * * * * * * * * * * * * * * * * * * * * * * * * ***';
 RAISE NOTICE '%', v_messaggio_inizio;
 RAISE NOTICE '*** * * * * * * * * * * * * * * * * * * * * * * * * ***';

 RAISE NOTICE '*** FUNZIONE % ***', v_nome_funzione;
 
 v_return := 0;

 RAISE NOTICE '*** Aggiorna viste materializzate tutti i giorni ***';

	RAISE NOTICE '*** Aggiorna vista mv_od_vista_dettaglio_impianti ***';
		
	BEGIN
		
 		REFRESH MATERIALIZED VIEW sigit_new.mv_od_vista_dettaglio_impianti;

	EXCEPTION
		WHEN OTHERS
		then
		  RAISE NOTICE '!!! ERRORE su refresh vista mv_od_vista_dettaglio_impianti!!!';
		  RAISE NOTICE 'SQLERRM = %', SQLERRM; 
		  --v_sqlerrm := SQLERRM;
		  v_return = 1;
	END;

 	IF v_return = 0 THEN
      
		RAISE NOTICE '*** Aggiorna vista mv_vista_dati_import_distributori ***';
			
		BEGIN
			
	 		REFRESH MATERIALIZED VIEW sigit_new.mv_vista_dati_import_distributori;
	
		EXCEPTION
			WHEN OTHERS
			then
			  RAISE NOTICE '!!! ERRORE su refresh vista mv_vista_dati_import_distributori!!!';
			  RAISE NOTICE 'SQLERRM = %', SQLERRM; 
			  --v_sqlerrm := SQLERRM;
			  v_return = 1;
		END;

 	END IF; 

 	IF v_return = 0 THEN
      
		RAISE NOTICE '*** Aggiorna vista mv_vista_dw_sk4_cg ***';
			
		BEGIN
			
	 		REFRESH MATERIALIZED VIEW sigit_new.mv_vista_dw_sk4_cg;
	
		EXCEPTION
			WHEN OTHERS
			then
			  RAISE NOTICE '!!! ERRORE su refresh vista mv_vista_dw_sk4_cg!!!';
			  RAISE NOTICE 'SQLERRM = %', SQLERRM; 
			  --v_sqlerrm := SQLERRM;
			  v_return = 1;
		END;

 	END IF; 

  	IF v_return = 0 THEN
      
		RAISE NOTICE '*** Aggiorna vista mv_vista_dw_sk4_gf ***';
			
		BEGIN
			
	 		REFRESH MATERIALIZED VIEW sigit_new.mv_vista_dw_sk4_gf;
	
		EXCEPTION
			WHEN OTHERS
			then
			  RAISE NOTICE '!!! ERRORE su refresh vista mv_vista_dw_sk4_gf!!!';
			  RAISE NOTICE 'SQLERRM = %', SQLERRM; 
			  --v_sqlerrm := SQLERRM;
			  v_return = 1;
		END;

 	END IF; 

  	IF v_return = 0 THEN
      
		RAISE NOTICE '*** Aggiorna vista mv_vista_dw_sk4_gt ***';
			
		BEGIN
			
	 		REFRESH MATERIALIZED VIEW sigit_new.mv_vista_dw_sk4_gt;
	
		EXCEPTION
			WHEN OTHERS
			then
			  RAISE NOTICE '!!! ERRORE su refresh vista mv_vista_dw_sk4_gt!!!';
			  RAISE NOTICE 'SQLERRM = %', SQLERRM; 
			  --v_sqlerrm := SQLERRM;
			  v_return = 1;
		END;

 	END IF; 

  	IF v_return = 0 THEN
      
		RAISE NOTICE '*** Aggiorna vista mv_vista_dw_sk4_sc ***';
			
		BEGIN
			
	 		REFRESH MATERIALIZED VIEW sigit_new.mv_vista_dw_sk4_sc;
	
		EXCEPTION
			WHEN OTHERS
			then
			  RAISE NOTICE '!!! ERRORE su refresh vista mv_vista_dw_sk4_sc!!!';
			  RAISE NOTICE 'SQLERRM = %', SQLERRM; 
			  --v_sqlerrm := SQLERRM;
			  v_return = 1;
		END;

 	END IF; 

  	IF v_return = 0 THEN
      
		RAISE NOTICE '*** Aggiorna vista mv_vista_elenco_distributori ***';
			
		BEGIN
			
	 		REFRESH MATERIALIZED VIEW sigit_new.mv_vista_elenco_distributori;
	
		EXCEPTION
			WHEN OTHERS
			then
			  RAISE NOTICE '!!! ERRORE su refresh vista mv_vista_elenco_distributori!!!';
			  RAISE NOTICE 'SQLERRM = %', SQLERRM; 
			  --v_sqlerrm := SQLERRM;
			  v_return = 1;
		END;

 	END IF; 

  	IF v_return = 0 THEN
      
		RAISE NOTICE '*** Aggiorna vista mv_vista_impianti_imprese ***';
			
		BEGIN
			
	 		REFRESH MATERIALIZED VIEW sigit_new.mv_vista_impianti_imprese;
	
		EXCEPTION
			WHEN OTHERS
			then
			  RAISE NOTICE '!!! ERRORE su refresh vista mv_vista_impianti_imprese!!!';
			  RAISE NOTICE 'SQLERRM = %', SQLERRM; 
			  --v_sqlerrm := SQLERRM;
			  v_return = 1;
		END;

 	END IF; 

  	IF v_return = 0 THEN
      
		RAISE NOTICE '*** Aggiorna vista mv_vista_ricerca_impianti ***';
			
		BEGIN
			
	 		REFRESH MATERIALIZED VIEW sigit_new.mv_vista_ricerca_impianti;
	
		EXCEPTION
			WHEN OTHERS
			then
			  RAISE NOTICE '!!! ERRORE su refresh vista mv_vista_ricerca_impianti!!!';
			  RAISE NOTICE 'SQLERRM = %', SQLERRM; 
			  --v_sqlerrm := SQLERRM;
			  v_return = 1;
		END;

 	END IF; 

 RAISE NOTICE '*** * * * * * * * * * * * * * * * * * * * * * * * * ***';
 RAISE NOTICE '% FINE ', v_messaggio_inizio;
 RAISE NOTICE '*** * * * * * * * * * * * * * * * * * * * * * * * * ***';

-- ROLLBACK;

IF v_return != 0 THEN
   ROLLBACK;
END IF;

RETURN v_return;  
 
EXCEPTION
when OTHERS 
then 
   RAISE NOTICE 'SQLERRM = %', SQLERRM; 
   v_sqlerrm := SQLERRM;

   ROLLBACK;
   RETURN 9;
    
END;
$function$
;


ALTER FUNCTION fnc_aggiornamenti_automatici() SET search_path = admin, pg_temp;

revoke execute on function sigit_new.fnc_aggiornamenti_automatici() from public;

GRANT execute ON function sigit_new.fnc_aggiornamenti_automatici() TO sigit_new_rw;
