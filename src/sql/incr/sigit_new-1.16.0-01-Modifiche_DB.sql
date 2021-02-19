----------------------------------------------------------------------------------------
-- 22/11/2018  Lorita
-- Creazione nuova tabella in sviluppo come da mail di Mariuccia del 13/11/2019
----------------------------------------------------------------------------------------
CREATE TABLE sigit_wrk_log_memo
(
	id_log_memo           NUMERIC  NOT NULL ,
	dt_log_memo           TIMESTAMP  NULL ,
	desc_log_memo         character varying(1000)  NULL 
);

ALTER TABLE sigit_wrk_log_memo
	ADD CONSTRAINT  PK_sigit_wrk_log_memo PRIMARY KEY (id_log_memo);

GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE sigit_wrk_log_memo TO sigit_new_rw;

CREATE SEQUENCE sigit_wrk_log_memo_id
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE sigit_wrk_log_memo_id
  OWNER TO sigit_new;
GRANT ALL ON SEQUENCE sigit_wrk_log_memo_id TO sigit_new;
GRANT SELECT, UPDATE ON SEQUENCE sigit_wrk_log_memo_id TO sigit_new_rw;


----------------------------------------------------------------------------------------
-- 13/12/2018  Lorita
-- Aggiunta nuovi campi in sviluppo su allegato come da mail di Mariuccia del 13/12/2019
----------------------------------------------------------------------------------------
ALTER TABLE sigit_t_allegato ADD COLUMN dt_invio_memo TIMESTAMP without time zone;
ALTER TABLE sigit_t_allegato ADD COLUMN mail_invio_memo CHARACTER VARYING(100);

ALTER TABLE sigit_s_allegato ADD COLUMN dt_invio_memo TIMESTAMP without time zone;
ALTER TABLE sigit_s_allegato ADD COLUMN mail_invio_memo CHARACTER VARYING(100);

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
            tm.id_tipo_manutenzione, tm.des_tipo_manutenzione,
            a.dt_invio_memo, a.mail_invio_memo
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
            pg.numero_rea AS pg_numero_rea, i.codice_impianto, 
            i.denominazione_comune AS comune_impianto, 
            i.sigla_provincia AS sigla_prov_impianto, 
            COALESCE(u.indirizzo_sitad, u.indirizzo_non_trovato) AS indirizzo_unita_immob, 
            u.civico AS civico_unita_immob, a.flg_controllo_bozza, a.uid_index, 
            tm.id_tipo_manutenzione, tm.des_tipo_manutenzione,
            a.dt_invio_memo, a.mail_invio_memo
           FROM sigit_t_allegato a
      JOIN sigit_r_ispez_ispet r1 ON a.fk_ispez_ispet = r1.id_ispez_ispet
   JOIN sigit_d_ruolo ru ON r1.fk_ruolo = ru.id_ruolo
   JOIN sigit_d_tipo_documento doc ON a.fk_tipo_documento = doc.id_tipo_documento
   JOIN sigit_d_tipo_manutenzione tm ON a.fk_tipo_manutenzione = tm.id_tipo_manutenzione
   JOIN sigit_d_stato_rapp srapp ON a.fk_stato_rapp = srapp.id_stato_rapp
   JOIN sigit_t_ispezione_2018 isp ON r1.id_ispezione_2018 = isp.id_ispezione_2018
   LEFT JOIN sigit_t_persona_giuridica pg ON r1.fk_persona_giuridica = pg.id_persona_giuridica
   LEFT JOIN sigit_t_impianto i ON isp.codice_impianto = i.codice_impianto
   LEFT JOIN sigit_t_unita_immobiliare u ON i.codice_impianto = u.codice_impianto
  WHERE u.flg_principale = 1::numeric;


----------------------------------------------------------------------------------------
-- 13/01/2020  Lorita
-- Revisione gestione bollini ed eliminazione tabelle come da mail di Mariuccia del 10/01/2020
----------------------------------------------------------------------------------------
ALTER TABLE sigit_t_impianto DROP CONSTRAINT fk_sigit_t_codice_imp_01;

ALTER TABLE SIGIT_T_TRANSAZIONE_IMP RENAME TO OLD_SIGIT_T_TRANSAZIONE_IMP;

ALTER TABLE SIGIT_T_CODICE_IMP RENAME TO OLD_SIGIT_T_CODICE_IMP;

ALTER TABLE SIGIT_D_POTENZA_IMP RENAME TO OLD_SIGIT_D_POTENZA_IMP;

ALTER TABLE SIGIT_D_PREZZO_POTENZA RENAME TO OLD_SIGIT_D_PREZZO_POTENZA;

ALTER TABLE SIGIT_R_POTENZA_PREZZO RENAME TO OLD_SIGIT_R_POTENZA_PREZZO;

ALTER TABLE SIGIT_T_TRANSAZIONE_BOLL RENAME TO OLD_SIGIT_T_TRANSAZIONE_BOLL;

ALTER TABLE SIGIT_R_TRANS_ACQ_BOLL_QTA RENAME TO OLD_SIGIT_R_TRANS_ACQ_BOLL_QTA;

DROP VIEW vista_bollini;

/* backup
CREATE OR REPLACE VIEW vista_bollini AS 
 SELECT sigit_t_codice_boll.sigla_bollino, sigit_t_codice_boll.numero_bollino, 
    sigit_t_codice_boll.fk_transazione_boll, sigit_t_codice_boll.fk_potenza, 
    sigit_t_codice_boll.fk_prezzo, 
    sigit_t_codice_boll.fk_dt_inizio_acquisto AS fk_dt_inizio, 
    sigit_d_potenza_imp.des_potenza, sigit_d_potenza_imp.limite_inferiore, 
    sigit_d_potenza_imp.limite_superiore, sigit_d_prezzo_potenza.prezzo
   FROM sigit_t_codice_boll, sigit_d_potenza_imp, sigit_r_potenza_prezzo, 
    sigit_d_prezzo_potenza
  WHERE sigit_t_codice_boll.fk_potenza = sigit_r_potenza_prezzo.id_potenza AND sigit_t_codice_boll.fk_prezzo = sigit_r_potenza_prezzo.id_prezzo AND sigit_t_codice_boll.fk_dt_inizio_acquisto = sigit_r_potenza_prezzo.dt_inizio_acquisto AND sigit_r_potenza_prezzo.id_potenza = sigit_d_potenza_imp.id_potenza AND sigit_r_potenza_prezzo.id_prezzo = sigit_d_prezzo_potenza.id_prezzo AND (now() >= sigit_r_potenza_prezzo.dt_inizio_acquisto AND now() <= sigit_r_potenza_prezzo.dt_fine_acquisto OR sigit_r_potenza_prezzo.dt_inizio_acquisto <= now() AND sigit_r_potenza_prezzo.dt_fine_acquisto IS NULL);

ALTER TABLE vista_bollini
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_bollini TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_bollini TO sigit_new_rw;
*/

ALTER TABLE sigit_t_codice_boll ALTER COLUMN fk_transazione_boll DROP NOT NULL;
ALTER TABLE sigit_t_codice_boll ALTER COLUMN fk_potenza DROP NOT NULL;
ALTER TABLE sigit_t_codice_boll ALTER COLUMN fk_prezzo DROP NOT NULL;
ALTER TABLE sigit_t_codice_boll ALTER COLUMN fk_dt_inizio_acquisto DROP NOT NULL;

ALTER TABLE sigit_t_codice_boll ADD COLUMN dt_inserimento timestamp;

ALTER TABLE sigit_t_persona_giuridica ADD COLUMN dt_agg_dichiarazione  TIMESTAMP;

UPDATE sigit_t_persona_giuridica
SET dt_agg_dichiarazione = data_ult_mod;

ALTER TABLE sigit_t_persona_giuridica ALTER COLUMN dt_agg_dichiarazione SET NOT NULL;


----------------------------------------------------------------------------------------
-- 22/01/2020  Lorita
-- Inserimento configurazione ruoli, come da mail di Beppe del 22/01/2020
----------------------------------------------------------------------------------------
insert into sigit_d_ruolo (id_ruolo, des_ruolo, ruolo_funz) values (15,'Proprietario','PROPRIETARIO');
insert into sigit_d_ruolo (id_ruolo, des_ruolo, ruolo_funz) values (16,'Proprietario','PROPRIETARIO IMPRESA/ENTE');


----------------------------------------------------------------------------------------
-- 04/02/2020  Lorita
-- Modifica configurazione ruoli, come da mail di Mariuccia del 23/01/2020
-- id=3 INSTALLATORE diventa  CARICATORE (sia per des_ruolo sia ruolo_funz)
-- id=6,7,8,9 MANUTENTORE diventa IMPRESA (Solo per ruolo_funz)
----------------------------------------------------------------------------------------
update sigit_d_ruolo
set des_ruolo = 'Caricatore', ruolo_funz = 'CARICATORE'
where id_ruolo = 3;

update sigit_d_ruolo
set ruolo_funz = 'IMPRESA'
where id_ruolo IN (6,7,8,9);


----------------------------------------------------------------------------------------
-- 04/02/2020  Lorita
-- Modifica SIGIT_T_PERSONA_GIURIDICA aggiunta nuovi campi - mail Mariuccia del 23/01/2020
-- duplicato campo flg_manutentore che diventa flg_dm37_letterac
-- alla fine dello sviluppo sarà cancellato flg_manutentore
-- alla fine dello sviluppo sarà cancellato flg_installatore
----------------------------------------------------------------------------------------
ALTER TABLE sigit_t_persona_giuridica ADD COLUMN 
	flg_dm37_letterac     NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_dm37c CHECK (flg_dm37_letterac IN (0,1));
ALTER TABLE sigit_t_persona_giuridica ADD COLUMN 
	flg_dm37_letterad     NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_dm37d CHECK (flg_dm37_letterad IN (0,1));
ALTER TABLE sigit_t_persona_giuridica ADD COLUMN 
	flg_dm37_letterae     NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_dm37e CHECK (flg_dm37_letterae IN (0,1));
ALTER TABLE sigit_t_persona_giuridica ADD COLUMN 
	flg_dm37_letterag     NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_dm37g CHECK (flg_dm37_letterag IN (0,1));
ALTER TABLE sigit_t_persona_giuridica ADD COLUMN 
	flg_fgas              NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_gas CHECK (flg_fgas IN (0,1));
ALTER TABLE sigit_t_persona_giuridica ADD COLUMN 
	flg_conduttore        NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_cond CHECK (flg_conduttore IN (0,1));
ALTER TABLE sigit_t_persona_giuridica ADD COLUMN 
	flg_sogg_incaricato   NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_sogg_inc CHECK (flg_sogg_incaricato IN (0,1));
ALTER TABLE sigit_t_persona_giuridica ADD COLUMN 
	delega_sogg_incaricato  CHARACTER VARYING(200)  NULL;

UPDATE sigit_t_persona_giuridica
SET flg_dm37_letterac = flg_manutentore;


----------------------------------------------------------------------------------------
-- 04/02/2020  Lorita
-- Modifica SIGIT_T_PERSONA_FISICA aggiunta nuovi campi - mail Mariuccia del 28/01/2020
----------------------------------------------------------------------------------------
ALTER TABLE sigit_t_persona_fisica ADD COLUMN 
	flg_newsletter        NUMERIC(1)  NULL  CONSTRAINT  flg_newsl CHECK (flg_newsletter IN (0,1));
	
UPDATE sigit_t_persona_fisica
SET flg_newsletter = 1;	


----------------------------------------------------------------------------------------
-- 04/02/2020  Lorita
-- Modifica SIGIT_R_PF_RUOLO_PA aggiunta nuovi campi - mail Mariuccia del 29/01/2020
----------------------------------------------------------------------------------------
ALTER TABLE sigit_r_pf_ruolo_pa ADD COLUMN 
	desc_abilitazione     CHARACTER VARYING(100)  NULL;

----------------------------------------------------------------------------------------
-- 06/04/2020  Lorita
-- dell'attività del 4/2 mancavano 2 cancellazioni
-- alla fine dello sviluppo sarà cancellato flg_manutentore
-- alla fine dello sviluppo sarà cancellato flg_installatore
----------------------------------------------------------------------------------------
DROP VIEW vista_elenco_distributori;

CREATE OR REPLACE VIEW vista_elenco_distributori AS 
 SELECT sigit_t_persona_giuridica.id_persona_giuridica, 
    sigit_t_persona_giuridica.denominazione, 
    sigit_t_persona_giuridica.codice_fiscale, sigit_t_persona_giuridica.fk_l2, 
    sigit_t_persona_giuridica.indirizzo_sitad, 
    sigit_t_persona_giuridica.indirizzo_non_trovato, 
    sigit_t_persona_giuridica.sigla_prov, 
    sigit_t_persona_giuridica.istat_comune, sigit_t_persona_giuridica.comune, 
    sigit_t_persona_giuridica.provincia, sigit_t_persona_giuridica.civico, 
    sigit_t_persona_giuridica.cap, sigit_t_persona_giuridica.email, 
    sigit_t_persona_giuridica.data_inizio_attivita, 
    sigit_t_persona_giuridica.data_cessazione, 
    sigit_t_persona_giuridica.sigla_rea, sigit_t_persona_giuridica.numero_rea, 
    sigit_t_persona_giuridica.flg_amministratore, 
    sigit_t_persona_giuridica.data_ult_mod, 
    sigit_t_persona_giuridica.utente_ult_mod, 
    sigit_t_persona_giuridica.flg_terzo_responsabile, 
    sigit_t_persona_giuridica.flg_distributore
   FROM sigit_t_persona_giuridica
  WHERE sigit_t_persona_giuridica.flg_distributore = 1::numeric;

ALTER TABLE vista_elenco_distributori
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_elenco_distributori TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_elenco_distributori TO sigit_new_rw;

ALTER TABLE sigit_t_persona_giuridica DROP COLUMN flg_manutentore;
ALTER TABLE sigit_t_persona_giuridica DROP COLUMN flg_installatore;

----------------------------------------------------------------------------------------
-- 07/04/2020  Lorita
-- Mail di Mariuccia del 6/4 per modifiche e ottimizzazione vista od_vista_dettaglio_impianti
-- creata vista nuova per testare modifiche, da sostituire all'originale se corretta
----------------------------------------------------------------------------------------
/*
CREATE OR REPLACE VIEW od_vista_dettaglio_impianti_v2 AS
(        (         SELECT i.codice_impianto, 
                            --COALESCE(ui.indirizzo_sitad, ui.indirizzo_non_trovato) AS indirizzo_unita_immob, 
                            --ui.civico, 
                            i.denominazione_comune, 
                            i.denominazione_provincia, ui.l1_2_fk_categoria, 
                            ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, 
                            i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, 
                            i.l1_3_pot_clima_est_kw, 
                            gt.id_tipo_componente AS tipo_componente, 
                            gt.progressivo, gt.data_install, gt.des_marca, 
                            gt.des_combustibile, 
                            gt.des_dettaglio_gt AS des_dettaglio, 
                            gt.potenza_termica_kw AS potenza, 
                            gt.rendimento_perc, 
                            max(gt.data_controllo) AS data_controllo, 
                            gt.e_nox_ppm, gt.e_nox_mg_kwh, 
                            gt.e_n_modulo_termico
                           FROM sigit_t_impianto i
                      JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
                 --LEFT 
                 JOIN vista_dw_sk4_gt gt ON i.codice_impianto = gt.codice_impianto
                WHERE gt.data_dismiss IS NULL AND ui.flg_principale = 1::numeric AND i.fk_stato = 1::numeric
                GROUP BY i.codice_impianto, COALESCE(ui.indirizzo_sitad, ui.indirizzo_non_trovato), ui.civico, i.denominazione_comune, i.denominazione_provincia, ui.l1_2_fk_categoria, ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, gt.id_tipo_componente, gt.progressivo, gt.data_install, gt.des_marca, gt.des_combustibile, gt.des_dettaglio_gt, gt.potenza_termica_kw, gt.rendimento_perc, gt.e_nox_ppm, gt.e_nox_mg_kwh, gt.e_n_modulo_termico
                UNION 
                         SELECT i.codice_impianto, 
                            --COALESCE(ui.indirizzo_sitad, ui.indirizzo_non_trovato) AS indirizzo_unita_immob, 
                            --ui.civico, 
                            i.denominazione_comune, 
                            i.denominazione_provincia, ui.l1_2_fk_categoria, 
                            ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, 
                            i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, 
                            i.l1_3_pot_clima_est_kw, 
                            gf.id_tipo_componente AS tipo_componente, 
                            gf.progressivo, gf.data_install, gf.des_marca, 
                            gf.des_combustibile, NULL::text AS des_dettaglio, 
                            gf.potenza_termica_kw AS potenza, 
                            NULL::numeric AS rendimento_perc, 
                            max(gf.data_controllo) AS data_controllo, 
                            NULL::numeric AS e_nox_ppm, 
                            NULL::numeric AS e_nox_mg_kwh, 
                            NULL::numeric AS e_n_modulo_termico
                           FROM sigit_t_impianto i
                      JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
                 --LEFT 
                 JOIN vista_dw_sk4_gf gf ON i.codice_impianto = gf.codice_impianto
                WHERE gf.data_dismiss IS NULL AND ui.flg_principale = 1::numeric AND i.fk_stato = 1::numeric
                GROUP BY i.codice_impianto, COALESCE(ui.indirizzo_sitad, ui.indirizzo_non_trovato), ui.civico, i.denominazione_comune, i.denominazione_provincia, ui.l1_2_fk_categoria, ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, gf.id_tipo_componente, gf.progressivo, gf.data_install, gf.des_marca, gf.des_combustibile, NULL::text, gf.potenza_termica_kw)
        UNION 
                 SELECT i.codice_impianto, 
                    --COALESCE(ui.indirizzo_sitad, ui.indirizzo_non_trovato) AS indirizzo_unita_immob, 
                    --ui.civico, 
                    i.denominazione_comune, 
                    i.denominazione_provincia, ui.l1_2_fk_categoria, 
                    ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, 
                    i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, 
                    sc.id_tipo_componente AS tipo_componente, sc.progressivo, 
                    sc.data_install, sc.des_marca, 
                    NULL::character varying AS des_combustibile, 
                    NULL::text AS des_dettaglio, 
                    sc.potenza_termica_kw AS potenza, 
                    NULL::numeric AS rendimento_perc, 
                    max(sc.data_controllo) AS data_controllo, 
                    NULL::numeric AS e_nox_ppm, NULL::numeric AS e_nox_mg_kwh, 
                    NULL::numeric AS e_n_modulo_termico
                   FROM sigit_t_impianto i
              JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
         --LEFT 
         JOIN vista_dw_sk4_sc sc ON i.codice_impianto = sc.codice_impianto
        WHERE sc.data_dismiss IS NULL AND ui.flg_principale = 1::numeric AND i.fk_stato = 1::numeric
        GROUP BY i.codice_impianto, COALESCE(ui.indirizzo_sitad, ui.indirizzo_non_trovato), ui.civico, i.denominazione_comune, i.denominazione_provincia, ui.l1_2_fk_categoria, ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, sc.id_tipo_componente, sc.progressivo, sc.data_install, sc.des_marca, NULL::text, sc.potenza_termica_kw)
UNION 
         SELECT i.codice_impianto, 
            --COALESCE(ui.indirizzo_sitad, ui.indirizzo_non_trovato) AS indirizzo_unita_immob, 
            --ui.civico, 
            i.denominazione_comune, i.denominazione_provincia, 
            ui.l1_2_fk_categoria, ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, 
            i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, 
            cg.id_tipo_componente AS tipo_componente, cg.progressivo, 
            cg.data_install, cg.des_marca, cg.des_combustibile, 
            NULL::character varying AS des_dettaglio, 
            cg.potenza_termica_kw AS potenza, NULL::numeric AS rendimento_perc, 
            max(cg.data_controllo) AS data_controllo, 
            NULL::numeric AS e_nox_ppm, NULL::numeric AS e_nox_mg_kwh, 
            NULL::numeric AS e_n_modulo_termico
           FROM sigit_t_impianto i
      JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
   --LEFT    
   JOIN vista_dw_sk4_cg cg ON i.codice_impianto = cg.codice_impianto
  WHERE cg.data_dismiss IS NULL AND ui.flg_principale = 1::numeric AND i.fk_stato = 1::numeric
  GROUP BY i.codice_impianto, COALESCE(ui.indirizzo_sitad, ui.indirizzo_non_trovato), ui.civico, i.denominazione_comune, i.denominazione_provincia, ui.l1_2_fk_categoria, ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, cg.id_tipo_componente, cg.progressivo, cg.data_install, cg.des_marca, cg.des_combustibile, cg.potenza_termica_kw;
*/ 
 
----------------------------------------------------------------------------------------
-- 10/04/2020  Lorita
-- Dalla ottimizzazione vista od_vista_dettaglio_impianti emerge un baco di logica
-- sulle 4 viste usate da questa per aggregare i dati
-- Riviste le 4 viste prima di risolvere la od_vista_dettaglio_impianti
----------------------------------------------------------------------------------------
-- backup vista
/* 
 CREATE OR REPLACE VIEW vista_dw_sk4_gt AS 
 SELECT DISTINCT sigit_t_comp_gt.codice_impianto, 
    sigit_t_comp_gt.id_tipo_componente, sigit_t_comp_gt.progressivo, 
    sigit_t_comp_gt.data_install, sigit_t_comp_gt.data_dismiss, 
    sigit_t_comp_gt.matricola, sigit_t_comp_gt.fk_marca, 
    sigit_d_marca.des_marca, sigit_d_combustibile.id_combustibile, 
    sigit_d_combustibile.des_combustibile, sigit_t_comp_gt.fk_fluido, 
    sigit_d_fluido.des_fluido, sigit_t_comp_gt.fk_dettaglio_gt, 
    sigit_d_dettaglio_gt.des_dettaglio_gt, sigit_t_comp_gt.modello, 
    sigit_t_comp_gt.potenza_termica_kw, sigit_t_comp_gt.data_ult_mod, 
    sigit_t_comp_gt.utente_ult_mod, sigit_t_comp_gt.rendimento_perc, 
    sigit_t_comp_gt.n_moduli, sigit_t_comp_gt.flg_dismissione, 
    sigit_t_allegato.data_controllo, sigit_t_impianto.istat_comune, 
    sigit_t_impianto.denominazione_comune, 
    sigit_t_impianto.denominazione_provincia, 
    sigit_t_impianto.fk_stato AS stato_impianto, 
    sigit_d_stato_imp.des_stato AS des_stato_impianto, 
    sigit_t_libretto.data_consolidamento, sigit_t_dett_tipo1.e_nox_ppm, 
    sigit_t_dett_tipo1.e_nox_mg_kwh, sigit_t_dett_tipo1.e_n_modulo_termico
   FROM sigit_t_comp_gt
   JOIN sigit_t_impianto ON sigit_t_impianto.codice_impianto = sigit_t_comp_gt.codice_impianto
   JOIN sigit_d_stato_imp ON sigit_t_impianto.fk_stato = sigit_d_stato_imp.id_stato
   LEFT JOIN sigit_t_libretto ON sigit_t_impianto.codice_impianto = sigit_t_libretto.codice_impianto AND sigit_t_libretto.fk_stato = 2::numeric
   LEFT JOIN sigit_d_marca ON sigit_t_comp_gt.fk_marca = sigit_d_marca.id_marca
   LEFT JOIN sigit_d_fluido ON sigit_t_comp_gt.fk_fluido = sigit_d_fluido.id_fluido
   LEFT JOIN sigit_d_dettaglio_gt ON sigit_t_comp_gt.fk_dettaglio_gt = sigit_d_dettaglio_gt.id_dettaglio_gt
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp_gt.fk_combustibile = sigit_d_combustibile.id_combustibile
   LEFT JOIN sigit_t_dett_tipo1 ON sigit_t_dett_tipo1.codice_impianto = sigit_t_comp_gt.codice_impianto AND sigit_t_dett_tipo1.fk_tipo_componente::text = sigit_t_comp_gt.id_tipo_componente::text AND sigit_t_dett_tipo1.progressivo = sigit_t_comp_gt.progressivo AND sigit_t_dett_tipo1.data_install = sigit_t_comp_gt.data_install
   LEFT JOIN sigit_t_allegato ON sigit_t_dett_tipo1.fk_allegato = sigit_t_allegato.id_allegato AND sigit_t_allegato.fk_stato_rapp = 1::numeric;
*/

drop view vista_dw_sk4_gt;

create or replace view vista_dw_sk4_gt as
select DISTINCT sigit_t_comp_gt.codice_impianto, 
    sigit_t_comp_gt.id_tipo_componente, sigit_t_comp_gt.progressivo, 
    sigit_t_comp_gt.data_install, sigit_t_comp_gt.data_dismiss, 
    sigit_t_comp_gt.matricola, sigit_t_comp_gt.fk_marca, 
    sigit_d_marca.des_marca, sigit_d_combustibile.id_combustibile, 
    sigit_d_combustibile.des_combustibile, sigit_t_comp_gt.fk_fluido, 
    sigit_d_fluido.des_fluido, sigit_t_comp_gt.fk_dettaglio_gt, 
    sigit_d_dettaglio_gt.des_dettaglio_gt, sigit_t_comp_gt.modello, 
    sigit_t_comp_gt.potenza_termica_kw, sigit_t_comp_gt.data_ult_mod, 
    sigit_t_comp_gt.utente_ult_mod, sigit_t_comp_gt.rendimento_perc, 
    sigit_t_comp_gt.n_moduli, sigit_t_comp_gt.flg_dismissione, 
    sigit_t_allegato.data_controllo, sigit_t_impianto.istat_comune, 
    sigit_t_impianto.denominazione_comune, 
    sigit_t_impianto.denominazione_provincia, 
    sigit_t_impianto.fk_stato AS stato_impianto, 
    sigit_d_stato_imp.des_stato AS des_stato_impianto, 
    sigit_t_libretto.data_consolidamento, sigit_t_dett_tipo1.e_nox_ppm, 
sigit_t_dett_tipo1.e_nox_mg_kwh, sigit_t_dett_tipo1.e_n_modulo_termico
FROM sigit_t_comp_gt
JOIN sigit_r_allegato_comp_gt USING (id_tipo_componente, progressivo, codice_impianto, data_install)
JOIN sigit_t_allegato ON (sigit_t_allegato.id_allegato = sigit_r_allegato_comp_gt.id_allegato AND sigit_t_allegato.fk_stato_rapp = 1::numeric)
JOIN sigit_t_dett_tipo1 ON sigit_t_dett_tipo1.fk_allegato = sigit_t_allegato.id_allegato
	AND sigit_t_dett_tipo1.fk_tipo_componente = sigit_r_allegato_comp_gt.id_tipo_componente
	AND sigit_t_dett_tipo1.progressivo = sigit_r_allegato_comp_gt.progressivo
	AND sigit_t_dett_tipo1.codice_impianto = sigit_r_allegato_comp_gt.codice_impianto
	AND sigit_t_dett_tipo1.data_install = sigit_r_allegato_comp_gt.data_install
JOIN sigit_t_impianto ON sigit_t_impianto.codice_impianto = sigit_t_comp_gt.codice_impianto
JOIN sigit_d_stato_imp ON sigit_t_impianto.fk_stato = sigit_d_stato_imp.id_stato
LEFT JOIN sigit_t_libretto ON sigit_t_impianto.codice_impianto = sigit_t_libretto.codice_impianto AND sigit_t_libretto.fk_stato = 2::numeric
LEFT JOIN sigit_d_marca ON sigit_t_comp_gt.fk_marca = sigit_d_marca.id_marca
LEFT JOIN sigit_d_fluido ON sigit_t_comp_gt.fk_fluido = sigit_d_fluido.id_fluido
LEFT JOIN sigit_d_dettaglio_gt ON sigit_t_comp_gt.fk_dettaglio_gt = sigit_d_dettaglio_gt.id_dettaglio_gt
LEFT JOIN sigit_d_combustibile ON sigit_t_comp_gt.fk_combustibile = sigit_d_combustibile.id_combustibile;

ALTER TABLE vista_dw_sk4_gt
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_dw_sk4_gt TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_dw_sk4_gt TO sigit_new_rw;

-- backup vista
/* 
CREATE OR REPLACE VIEW vista_dw_sk4_cg AS 
 SELECT DISTINCT sigit_t_comp_cg.codice_impianto, 
    sigit_t_comp_cg.id_tipo_componente, sigit_t_comp_cg.progressivo, 
    sigit_t_comp_cg.data_install, sigit_t_comp_cg.data_dismiss, 
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
    sigit_t_allegato.data_controllo, sigit_t_impianto.istat_comune, 
    sigit_t_impianto.denominazione_comune, 
    sigit_t_impianto.denominazione_provincia, 
    sigit_t_impianto.fk_stato AS stato_impianto, 
    sigit_d_stato_imp.des_stato AS des_stato_impianto, 
    sigit_t_libretto.data_consolidamento
   FROM sigit_t_comp_cg
   JOIN sigit_t_impianto ON sigit_t_impianto.codice_impianto = sigit_t_comp_cg.codice_impianto
   JOIN sigit_d_stato_imp ON sigit_t_impianto.fk_stato = sigit_d_stato_imp.id_stato
   LEFT JOIN sigit_t_libretto ON sigit_t_impianto.codice_impianto = sigit_t_libretto.codice_impianto AND sigit_t_libretto.fk_stato = 2::numeric
   LEFT JOIN sigit_d_marca ON sigit_t_comp_cg.fk_marca = sigit_d_marca.id_marca
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp_cg.fk_combustibile = sigit_d_combustibile.id_combustibile
   LEFT JOIN sigit_t_dett_tipo4 ON sigit_t_dett_tipo4.codice_impianto = sigit_t_comp_cg.codice_impianto AND sigit_t_dett_tipo4.fk_tipo_componente::text = sigit_t_comp_cg.id_tipo_componente::text AND sigit_t_dett_tipo4.progressivo = sigit_t_comp_cg.progressivo AND sigit_t_dett_tipo4.data_install = sigit_t_comp_cg.data_install
   LEFT JOIN sigit_t_allegato ON sigit_t_dett_tipo4.fk_allegato = sigit_t_allegato.id_allegato AND sigit_t_allegato.fk_stato_rapp = 1::numeric;
*/

drop VIEW vista_dw_sk4_cg;

CREATE OR REPLACE VIEW vista_dw_sk4_cg AS
 SELECT DISTINCT sigit_t_comp_cg.codice_impianto, 
    sigit_t_comp_cg.id_tipo_componente, sigit_t_comp_cg.progressivo, 
    sigit_t_comp_cg.data_install, sigit_t_comp_cg.data_dismiss, 
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
    sigit_t_allegato.data_controllo, sigit_t_impianto.istat_comune, 
    sigit_t_impianto.denominazione_comune, 
    sigit_t_impianto.denominazione_provincia, 
    sigit_t_impianto.fk_stato AS stato_impianto, 
    sigit_d_stato_imp.des_stato AS des_stato_impianto, 
    sigit_t_libretto.data_consolidamento
   FROM sigit_t_comp_cg
   JOIN sigit_r_allegato_comp_cg USING (id_tipo_componente, progressivo, codice_impianto, data_install)
   JOIN sigit_t_allegato ON (sigit_t_allegato.id_allegato = sigit_r_allegato_comp_cg.id_allegato AND sigit_t_allegato.fk_stato_rapp = 1::numeric)
   JOIN sigit_t_dett_tipo4 ON sigit_t_dett_tipo4.fk_allegato = sigit_t_allegato.id_allegato
	AND sigit_t_dett_tipo4.fk_tipo_componente = sigit_r_allegato_comp_cg.id_tipo_componente
	AND sigit_t_dett_tipo4.progressivo = sigit_r_allegato_comp_cg.progressivo
	AND sigit_t_dett_tipo4.codice_impianto = sigit_r_allegato_comp_cg.codice_impianto
	AND sigit_t_dett_tipo4.data_install = sigit_r_allegato_comp_cg.data_install
   JOIN sigit_t_impianto ON sigit_t_impianto.codice_impianto = sigit_t_comp_cg.codice_impianto
   JOIN sigit_d_stato_imp ON sigit_t_impianto.fk_stato = sigit_d_stato_imp.id_stato
   LEFT JOIN sigit_t_libretto ON sigit_t_impianto.codice_impianto = sigit_t_libretto.codice_impianto AND sigit_t_libretto.fk_stato = 2::numeric
   LEFT JOIN sigit_d_marca ON sigit_t_comp_cg.fk_marca = sigit_d_marca.id_marca
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp_cg.fk_combustibile = sigit_d_combustibile.id_combustibile;

ALTER TABLE vista_dw_sk4_cg
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_dw_sk4_cg TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_dw_sk4_cg TO sigit_new_rw;

-- backup 
/*
CREATE OR REPLACE VIEW vista_dw_sk4_gf AS 
 SELECT DISTINCT sigit_t_comp_gf.codice_impianto, 
    sigit_t_comp_gf.id_tipo_componente, sigit_t_comp_gf.progressivo, 
    sigit_t_comp_gf.data_install, sigit_t_comp_gf.matricola, 
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
    sigit_t_comp_gf.utente_ult_mod, 
        CASE
            WHEN sigit_t_comp_gf.raff_potenza_kw > sigit_t_comp_gf.risc_potenza_kw THEN sigit_t_comp_gf.raff_potenza_kw
            ELSE sigit_t_comp_gf.risc_potenza_kw
        END AS potenza_termica_kw, 
    sigit_t_allegato.data_controllo, sigit_t_impianto.istat_comune, 
    sigit_t_impianto.denominazione_comune, 
    sigit_t_impianto.denominazione_provincia, 
    sigit_t_impianto.fk_stato AS stato_impianto, 
    sigit_d_stato_imp.des_stato AS des_stato_impianto, 
    sigit_t_libretto.data_consolidamento
   FROM sigit_t_comp_gf
   JOIN sigit_t_impianto ON sigit_t_impianto.codice_impianto = sigit_t_comp_gf.codice_impianto
   JOIN sigit_d_stato_imp ON sigit_t_impianto.fk_stato = sigit_d_stato_imp.id_stato
   LEFT JOIN sigit_t_libretto ON sigit_t_impianto.codice_impianto = sigit_t_libretto.codice_impianto AND sigit_t_libretto.fk_stato = 2::numeric
   LEFT JOIN sigit_d_marca ON sigit_t_comp_gf.fk_marca = sigit_d_marca.id_marca
   LEFT JOIN sigit_d_dettaglio_gf ON sigit_t_comp_gf.fk_dettaglio_gf = sigit_d_dettaglio_gf.id_dettaglio_gf
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp_gf.fk_combustibile = sigit_d_combustibile.id_combustibile
   LEFT JOIN sigit_t_dett_tipo2 ON sigit_t_dett_tipo2.codice_impianto = sigit_t_comp_gf.codice_impianto AND sigit_t_dett_tipo2.fk_tipo_componente::text = sigit_t_comp_gf.id_tipo_componente::text AND sigit_t_dett_tipo2.progressivo = sigit_t_comp_gf.progressivo AND sigit_t_dett_tipo2.data_install = sigit_t_comp_gf.data_install
   LEFT JOIN sigit_t_allegato ON sigit_t_dett_tipo2.fk_allegato = sigit_t_allegato.id_allegato AND sigit_t_allegato.fk_stato_rapp = 1::numeric;
*/

drop VIEW vista_dw_sk4_gf;

CREATE OR REPLACE VIEW vista_dw_sk4_gf AS 
 SELECT DISTINCT sigit_t_comp_gf.codice_impianto, 
    sigit_t_comp_gf.id_tipo_componente, sigit_t_comp_gf.progressivo, 
    sigit_t_comp_gf.data_install, sigit_t_comp_gf.matricola, 
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
    sigit_t_comp_gf.utente_ult_mod, 
        CASE
            WHEN sigit_t_comp_gf.raff_potenza_kw > sigit_t_comp_gf.risc_potenza_kw THEN sigit_t_comp_gf.raff_potenza_kw
            ELSE sigit_t_comp_gf.risc_potenza_kw
        END AS potenza_termica_kw, 
    sigit_t_allegato.data_controllo, sigit_t_impianto.istat_comune, 
    sigit_t_impianto.denominazione_comune, 
    sigit_t_impianto.denominazione_provincia, 
    sigit_t_impianto.fk_stato AS stato_impianto, 
    sigit_d_stato_imp.des_stato AS des_stato_impianto, 
    sigit_t_libretto.data_consolidamento
   FROM sigit_t_comp_gf
   JOIN sigit_r_allegato_comp_gf USING (id_tipo_componente, progressivo, codice_impianto, data_install)
   JOIN sigit_t_allegato ON (sigit_t_allegato.id_allegato = sigit_r_allegato_comp_gf.id_allegato AND sigit_t_allegato.fk_stato_rapp = 1::numeric)
   JOIN sigit_t_dett_tipo2 ON sigit_t_dett_tipo2.fk_allegato = sigit_t_allegato.id_allegato
	AND sigit_t_dett_tipo2.codice_impianto = sigit_t_comp_gf.codice_impianto 
	AND sigit_t_dett_tipo2.fk_tipo_componente::text = sigit_t_comp_gf.id_tipo_componente::text 
	AND sigit_t_dett_tipo2.progressivo = sigit_t_comp_gf.progressivo 
	AND sigit_t_dett_tipo2.data_install = sigit_t_comp_gf.data_install
   JOIN sigit_t_impianto ON sigit_t_impianto.codice_impianto = sigit_t_comp_gf.codice_impianto
   JOIN sigit_d_stato_imp ON sigit_t_impianto.fk_stato = sigit_d_stato_imp.id_stato
   LEFT JOIN sigit_t_libretto ON sigit_t_impianto.codice_impianto = sigit_t_libretto.codice_impianto AND sigit_t_libretto.fk_stato = 2::numeric
   LEFT JOIN sigit_d_marca ON sigit_t_comp_gf.fk_marca = sigit_d_marca.id_marca
   LEFT JOIN sigit_d_dettaglio_gf ON sigit_t_comp_gf.fk_dettaglio_gf = sigit_d_dettaglio_gf.id_dettaglio_gf
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp_gf.fk_combustibile = sigit_d_combustibile.id_combustibile;

ALTER TABLE vista_dw_sk4_gf
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_dw_sk4_gf TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_dw_sk4_gf TO sigit_new_rw;


-- backup
/*
CREATE OR REPLACE VIEW vista_dw_sk4_sc AS 
 SELECT DISTINCT sigit_t_comp_sc.codice_impianto, 
    sigit_t_comp_sc.id_tipo_componente, sigit_t_comp_sc.progressivo, 
    sigit_t_comp_sc.data_install, sigit_t_comp_sc.flg_dismissione, 
    sigit_t_comp_sc.data_dismiss, sigit_t_comp_sc.data_ult_mod, 
    sigit_t_comp_sc.utente_ult_mod, sigit_t_comp_sc.matricola, 
    sigit_t_comp_sc.modello, sigit_t_comp_sc.potenza_termica_kw, 
    sigit_t_comp_sc.fk_marca, sigit_d_marca.des_marca, 
    sigit_t_allegato.data_controllo, sigit_t_impianto.istat_comune, 
    sigit_t_impianto.denominazione_comune, 
    sigit_t_impianto.denominazione_provincia, 
    sigit_t_impianto.fk_stato AS stato_impianto, 
    sigit_d_stato_imp.des_stato AS des_stato_impianto, 
    sigit_t_libretto.data_consolidamento
   FROM sigit_t_comp_sc
   JOIN sigit_t_impianto ON sigit_t_impianto.codice_impianto = sigit_t_comp_sc.codice_impianto
   JOIN sigit_d_stato_imp ON sigit_t_impianto.fk_stato = sigit_d_stato_imp.id_stato
   LEFT JOIN sigit_t_libretto ON sigit_t_impianto.codice_impianto = sigit_t_libretto.codice_impianto AND sigit_t_libretto.fk_stato = 2::numeric
   LEFT JOIN sigit_d_marca ON sigit_t_comp_sc.fk_marca = sigit_d_marca.id_marca
   LEFT JOIN sigit_t_dett_tipo3 ON sigit_t_dett_tipo3.codice_impianto = sigit_t_comp_sc.codice_impianto AND sigit_t_dett_tipo3.fk_tipo_componente::text = sigit_t_comp_sc.id_tipo_componente::text AND sigit_t_dett_tipo3.progressivo = sigit_t_comp_sc.progressivo AND sigit_t_dett_tipo3.data_install = sigit_t_comp_sc.data_install
   LEFT JOIN sigit_t_allegato ON sigit_t_dett_tipo3.fk_allegato = sigit_t_allegato.id_allegato AND sigit_t_allegato.fk_stato_rapp = 1::numeric;
*/

drop VIEW vista_dw_sk4_sc;

CREATE OR REPLACE VIEW vista_dw_sk4_sc AS 
 SELECT DISTINCT sigit_t_comp_sc.codice_impianto, 
    sigit_t_comp_sc.id_tipo_componente, sigit_t_comp_sc.progressivo, 
    sigit_t_comp_sc.data_install, sigit_t_comp_sc.flg_dismissione, 
    sigit_t_comp_sc.data_dismiss, sigit_t_comp_sc.data_ult_mod, 
    sigit_t_comp_sc.utente_ult_mod, sigit_t_comp_sc.matricola, 
    sigit_t_comp_sc.modello, sigit_t_comp_sc.potenza_termica_kw, 
    sigit_t_comp_sc.fk_marca, sigit_d_marca.des_marca, 
    sigit_t_allegato.data_controllo, sigit_t_impianto.istat_comune, 
    sigit_t_impianto.denominazione_comune, 
    sigit_t_impianto.denominazione_provincia, 
    sigit_t_impianto.fk_stato AS stato_impianto, 
    sigit_d_stato_imp.des_stato AS des_stato_impianto, 
    sigit_t_libretto.data_consolidamento
   FROM sigit_t_comp_sc
   JOIN sigit_r_allegato_comp_sc USING (id_tipo_componente, progressivo, codice_impianto, data_install)
   JOIN sigit_t_allegato ON (sigit_t_allegato.id_allegato = sigit_r_allegato_comp_sc.id_allegato AND sigit_t_allegato.fk_stato_rapp = 1::numeric)
   JOIN sigit_t_dett_tipo3 ON sigit_t_dett_tipo3.fk_allegato = sigit_t_allegato.id_allegato
	AND sigit_t_dett_tipo3.codice_impianto = sigit_t_comp_sc.codice_impianto 
	AND sigit_t_dett_tipo3.fk_tipo_componente::text = sigit_t_comp_sc.id_tipo_componente::text 
	AND sigit_t_dett_tipo3.progressivo = sigit_t_comp_sc.progressivo 
	AND sigit_t_dett_tipo3.data_install = sigit_t_comp_sc.data_install
   JOIN sigit_t_impianto ON sigit_t_impianto.codice_impianto = sigit_t_comp_sc.codice_impianto
   JOIN sigit_d_stato_imp ON sigit_t_impianto.fk_stato = sigit_d_stato_imp.id_stato
   LEFT JOIN sigit_t_libretto ON sigit_t_impianto.codice_impianto = sigit_t_libretto.codice_impianto AND sigit_t_libretto.fk_stato = 2::numeric
   LEFT JOIN sigit_d_marca ON sigit_t_comp_sc.fk_marca = sigit_d_marca.id_marca;

ALTER TABLE vista_dw_sk4_sc
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_dw_sk4_sc TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_dw_sk4_sc TO sigit_new_rw;

/* backup
CREATE OR REPLACE VIEW od_vista_dettaglio_impianti AS 
        (        (         SELECT i.codice_impianto, 
                            COALESCE(ui.indirizzo_sitad, ui.indirizzo_non_trovato) AS indirizzo_unita_immob, 
                            ui.civico, i.denominazione_comune, 
                            i.denominazione_provincia, ui.l1_2_fk_categoria, 
                            ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, 
                            i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, 
                            i.l1_3_pot_clima_est_kw, 
                            gt.id_tipo_componente AS tipo_componente, 
                            gt.progressivo, gt.data_install, gt.des_marca, 
                            gt.des_combustibile, 
                            gt.des_dettaglio_gt AS des_dettaglio, 
                            gt.potenza_termica_kw AS potenza, 
                            gt.rendimento_perc, 
                            max(gt.data_controllo) AS data_controllo, 
                            gt.e_nox_ppm, gt.e_nox_mg_kwh, 
                            gt.e_n_modulo_termico
                           FROM sigit_t_impianto i
                      JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
                 LEFT JOIN vista_dw_sk4_gt gt ON i.codice_impianto = gt.codice_impianto
                WHERE gt.data_dismiss IS NULL AND ui.flg_principale = 1::numeric AND i.fk_stato = 1::numeric
                GROUP BY i.codice_impianto, COALESCE(ui.indirizzo_sitad, ui.indirizzo_non_trovato), ui.civico, i.denominazione_comune, i.denominazione_provincia, ui.l1_2_fk_categoria, ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, gt.id_tipo_componente, gt.progressivo, gt.data_install, gt.des_marca, gt.des_combustibile, gt.des_dettaglio_gt, gt.potenza_termica_kw, gt.rendimento_perc, gt.e_nox_ppm, gt.e_nox_mg_kwh, gt.e_n_modulo_termico
                UNION 
                         SELECT i.codice_impianto, 
                            COALESCE(ui.indirizzo_sitad, ui.indirizzo_non_trovato) AS indirizzo_unita_immob, 
                            ui.civico, i.denominazione_comune, 
                            i.denominazione_provincia, ui.l1_2_fk_categoria, 
                            ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, 
                            i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, 
                            i.l1_3_pot_clima_est_kw, 
                            gf.id_tipo_componente AS tipo_componente, 
                            gf.progressivo, gf.data_install, gf.des_marca, 
                            gf.des_combustibile, NULL::text AS des_dettaglio, 
                            gf.potenza_termica_kw AS potenza, 
                            NULL::numeric AS rendimento_perc, 
                            max(gf.data_controllo) AS data_controllo, 
                            NULL::numeric AS e_nox_ppm, 
                            NULL::numeric AS e_nox_mg_kwh, 
                            NULL::numeric AS e_n_modulo_termico
                           FROM sigit_t_impianto i
                      JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
                 LEFT JOIN vista_dw_sk4_gf gf ON i.codice_impianto = gf.codice_impianto
                WHERE gf.data_dismiss IS NULL AND ui.flg_principale = 1::numeric AND i.fk_stato = 1::numeric
                GROUP BY i.codice_impianto, COALESCE(ui.indirizzo_sitad, ui.indirizzo_non_trovato), ui.civico, i.denominazione_comune, i.denominazione_provincia, ui.l1_2_fk_categoria, ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, gf.id_tipo_componente, gf.progressivo, gf.data_install, gf.des_marca, gf.des_combustibile, NULL::text, gf.potenza_termica_kw)
        UNION 
                 SELECT i.codice_impianto, 
                    COALESCE(ui.indirizzo_sitad, ui.indirizzo_non_trovato) AS indirizzo_unita_immob, 
                    ui.civico, i.denominazione_comune, 
                    i.denominazione_provincia, ui.l1_2_fk_categoria, 
                    ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, 
                    i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, 
                    sc.id_tipo_componente AS tipo_componente, sc.progressivo, 
                    sc.data_install, sc.des_marca, 
                    NULL::character varying AS des_combustibile, 
                    NULL::text AS des_dettaglio, 
                    sc.potenza_termica_kw AS potenza, 
                    NULL::numeric AS rendimento_perc, 
                    max(sc.data_controllo) AS data_controllo, 
                    NULL::numeric AS e_nox_ppm, NULL::numeric AS e_nox_mg_kwh, 
                    NULL::numeric AS e_n_modulo_termico
                   FROM sigit_t_impianto i
              JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
         LEFT JOIN vista_dw_sk4_sc sc ON i.codice_impianto = sc.codice_impianto
        WHERE sc.data_dismiss IS NULL AND ui.flg_principale = 1::numeric AND i.fk_stato = 1::numeric
        GROUP BY i.codice_impianto, COALESCE(ui.indirizzo_sitad, ui.indirizzo_non_trovato), ui.civico, i.denominazione_comune, i.denominazione_provincia, ui.l1_2_fk_categoria, ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, sc.id_tipo_componente, sc.progressivo, sc.data_install, sc.des_marca, NULL::text, sc.potenza_termica_kw)
UNION 
         SELECT i.codice_impianto, 
            COALESCE(ui.indirizzo_sitad, ui.indirizzo_non_trovato) AS indirizzo_unita_immob, 
            ui.civico, i.denominazione_comune, i.denominazione_provincia, 
            ui.l1_2_fk_categoria, ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, 
            i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, 
            cg.id_tipo_componente AS tipo_componente, cg.progressivo, 
            cg.data_install, cg.des_marca, cg.des_combustibile, 
            NULL::character varying AS des_dettaglio, 
            cg.potenza_termica_kw AS potenza, NULL::numeric AS rendimento_perc, 
            max(cg.data_controllo) AS data_controllo, 
            NULL::numeric AS e_nox_ppm, NULL::numeric AS e_nox_mg_kwh, 
            NULL::numeric AS e_n_modulo_termico
           FROM sigit_t_impianto i
      JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
   LEFT JOIN vista_dw_sk4_cg cg ON i.codice_impianto = cg.codice_impianto
  WHERE cg.data_dismiss IS NULL AND ui.flg_principale = 1::numeric AND i.fk_stato = 1::numeric
  GROUP BY i.codice_impianto, COALESCE(ui.indirizzo_sitad, ui.indirizzo_non_trovato), ui.civico, i.denominazione_comune, i.denominazione_provincia, ui.l1_2_fk_categoria, ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, cg.id_tipo_componente, cg.progressivo, cg.data_install, cg.des_marca, cg.des_combustibile, cg.potenza_termica_kw;
*/

drop VIEW od_vista_dettaglio_impianti;

CREATE OR REPLACE VIEW od_vista_dettaglio_impianti as
(        (         SELECT i.codice_impianto, 
                            i.denominazione_comune, 
                            i.denominazione_provincia, ui.l1_2_fk_categoria, 
                            ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, 
                            i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, 
                            i.l1_3_pot_clima_est_kw, 
                            gt.id_tipo_componente AS tipo_componente, 
                            gt.progressivo, gt.data_install, gt.des_marca, 
                            gt.des_combustibile, 
                            gt.des_dettaglio_gt AS des_dettaglio, 
                            gt.potenza_termica_kw AS potenza, 
                            gt.rendimento_perc, 
                            max(gt.data_controllo) AS data_controllo, 
                            gt.e_nox_ppm, gt.e_nox_mg_kwh, 
                            gt.e_n_modulo_termico
                           FROM sigit_t_impianto i
                    JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
                 	JOIN vista_dw_sk4_gt gt ON i.codice_impianto = gt.codice_impianto
                WHERE gt.data_dismiss IS NULL AND ui.flg_principale = 1::numeric AND i.fk_stato = 1::numeric
                GROUP BY i.codice_impianto, COALESCE(ui.indirizzo_sitad, ui.indirizzo_non_trovato), ui.civico, i.denominazione_comune, i.denominazione_provincia, ui.l1_2_fk_categoria, ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, gt.id_tipo_componente, gt.progressivo, gt.data_install, gt.des_marca, gt.des_combustibile, gt.des_dettaglio_gt, gt.potenza_termica_kw, gt.rendimento_perc, gt.e_nox_ppm, gt.e_nox_mg_kwh, gt.e_n_modulo_termico
                UNION 
                         SELECT i.codice_impianto, 
                            i.denominazione_comune, 
                            i.denominazione_provincia, ui.l1_2_fk_categoria, 
                            ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, 
                            i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, 
                            i.l1_3_pot_clima_est_kw, 
                            gf.id_tipo_componente AS tipo_componente, 
                            gf.progressivo, gf.data_install, gf.des_marca, 
                            gf.des_combustibile, NULL::text AS des_dettaglio, 
                            gf.potenza_termica_kw AS potenza, 
                            NULL::numeric AS rendimento_perc, 
                            max(gf.data_controllo) AS data_controllo, 
                            NULL::numeric AS e_nox_ppm, 
                            NULL::numeric AS e_nox_mg_kwh, 
                            NULL::numeric AS e_n_modulo_termico
                           FROM sigit_t_impianto i
                    JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
                 	JOIN vista_dw_sk4_gf gf ON i.codice_impianto = gf.codice_impianto
                WHERE gf.data_dismiss IS NULL AND ui.flg_principale = 1::numeric AND i.fk_stato = 1::numeric
                GROUP BY i.codice_impianto, COALESCE(ui.indirizzo_sitad, ui.indirizzo_non_trovato), ui.civico, i.denominazione_comune, i.denominazione_provincia, ui.l1_2_fk_categoria, ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, gf.id_tipo_componente, gf.progressivo, gf.data_install, gf.des_marca, gf.des_combustibile, NULL::text, gf.potenza_termica_kw)
        UNION 
                 SELECT i.codice_impianto, 
                    i.denominazione_comune, 
                    i.denominazione_provincia, ui.l1_2_fk_categoria, 
                    ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, 
                    i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, 
                    sc.id_tipo_componente AS tipo_componente, sc.progressivo, 
                    sc.data_install, sc.des_marca, 
                    NULL::character varying AS des_combustibile, 
                    NULL::text AS des_dettaglio, 
                    sc.potenza_termica_kw AS potenza, 
                    NULL::numeric AS rendimento_perc, 
                    max(sc.data_controllo) AS data_controllo, 
                    NULL::numeric AS e_nox_ppm, NULL::numeric AS e_nox_mg_kwh, 
                    NULL::numeric AS e_n_modulo_termico
                   FROM sigit_t_impianto i
            	JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
         		JOIN vista_dw_sk4_sc sc ON i.codice_impianto = sc.codice_impianto
        WHERE sc.data_dismiss IS NULL AND ui.flg_principale = 1::numeric AND i.fk_stato = 1::numeric
        GROUP BY i.codice_impianto, COALESCE(ui.indirizzo_sitad, ui.indirizzo_non_trovato), ui.civico, i.denominazione_comune, i.denominazione_provincia, ui.l1_2_fk_categoria, ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, sc.id_tipo_componente, sc.progressivo, sc.data_install, sc.des_marca, NULL::text, sc.potenza_termica_kw)
UNION 
         SELECT i.codice_impianto, 
            i.denominazione_comune, i.denominazione_provincia, 
            ui.l1_2_fk_categoria, ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, 
            i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, 
            cg.id_tipo_componente AS tipo_componente, cg.progressivo, 
            cg.data_install, cg.des_marca, cg.des_combustibile, 
            NULL::character varying AS des_dettaglio, 
            cg.potenza_termica_kw AS potenza, NULL::numeric AS rendimento_perc, 
            max(cg.data_controllo) AS data_controllo, 
            NULL::numeric AS e_nox_ppm, NULL::numeric AS e_nox_mg_kwh, 
            NULL::numeric AS e_n_modulo_termico
           FROM sigit_t_impianto i
      	JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
   		JOIN vista_dw_sk4_cg cg ON i.codice_impianto = cg.codice_impianto
  WHERE cg.data_dismiss IS NULL AND ui.flg_principale = 1::numeric AND i.fk_stato = 1::numeric
  GROUP BY i.codice_impianto, COALESCE(ui.indirizzo_sitad, ui.indirizzo_non_trovato), ui.civico, i.denominazione_comune, i.denominazione_provincia, ui.l1_2_fk_categoria, ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, cg.id_tipo_componente, cg.progressivo, cg.data_install, cg.des_marca, cg.des_combustibile, cg.potenza_termica_kw;
 
 ALTER TABLE od_vista_dettaglio_impianti
  OWNER TO sigit_new;
GRANT ALL ON TABLE od_vista_dettaglio_impianti TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE od_vista_dettaglio_impianti TO sigit_new_rw;
GRANT SELECT ON TABLE od_vista_dettaglio_impianti TO sigit_new_ro;

 
----------------------------------------------------------------------------------------
-- 20/04/2020  Lorita
-- Aggiunta nuovo campo su sigit_t_persona_fisica
----------------------------------------------------------------------------------------
ALTER TABLE sigit_t_persona_fisica ADD COLUMN flg_GDPR NUMERIC(1) CONSTRAINT  flg_pfGDPR_0_1 CHECK (flg_GDPR IN (0,1));

----------------------------------------------------------------------------------------
-- 21/04/2020  Lorita
-- Richiesta aggiunta indici su sigit_wrk_log
-- attività lenta, in test circa 1 ora
----------------------------------------------------------------------------------------
create index ie1_sigit_wrk_log on sigit_wrk_log USING btree (codice_fiscale, tbl_impattata, tipo_operazione);

create index ie2_sigit_wrk_log on sigit_wrk_log USING btree (data_operazione, codice_fiscale, tbl_impattata);

create index ie1_sigit_wrk_log_prec on sigit_wrk_log_prec USING btree (codice_fiscale, tbl_impattata, tipo_operazione);

create index ie2_sigit_wrk_log_prec on sigit_wrk_log_prec USING btree (data_operazione, codice_fiscale, tbl_impattata);

----------------------------------------------------------------------------------------
-- 22/04/2020  Lorita
-- Richiesta nuova vista SDP grant verso l'utente RO
----------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW vista_dati_import_distributori AS 
SELECT
vista_elenco_distributori.codice_fiscale AS cf_distributore, 
vista_elenco_distributori.denominazione AS denominazione_distributore,
vista_elenco_distributori.sigla_rea AS sigla_rea_distributore, 
vista_elenco_distributori.numero_rea AS numero_rea_distributore,
sigit_d_stato_distrib.des_stato_distrib, sigit_t_import_distrib.data_inizio_elab, sigit_t_import_distrib.data_fine_elab,
sigit_t_import_distrib.nome_file_import, sigit_t_import_distrib.data_annullamento, sigit_t_import_distrib.anno_riferimento,
sigit_t_import_distrib.tot_record_elaborati, sigit_t_import_distrib.tot_record_scartati, sigit_t_import_distrib.data_ult_mod,
sigit_d_tipo_contratto_distrib.des_tipo_contratto_distrib, sigit_d_combustibile.des_combustibile, sigit_d_unita_misura.des_unita_misura,
sigit_d_categoria_util.des_categoria_util, sigit_t_dato_distrib.flg_pf_pg, sigit_t_dato_distrib.cognome_denom AS cognome_denom_cliente,
sigit_t_dato_distrib.nome AS nome_cliente, sigit_t_dato_distrib.cf_piva AS cf_cliente, sigit_t_dato_distrib.anno_rif,
sigit_t_dato_distrib.nr_mesi_fattur, sigit_t_dato_distrib.dug AS dug_cliente, sigit_t_dato_distrib.indirizzo AS indirizzo_cliente,
sigit_t_dato_distrib.civico AS civico_cliente, sigit_t_dato_distrib.cap AS cap_cliente, sigit_t_dato_distrib.istat_comune AS istat_comune_cliente,
sigit_t_rif_catast.sezione, sigit_t_rif_catast.foglio, sigit_t_rif_catast.particella, sigit_t_rif_catast.subalterno,
sigit_t_dato_distrib.pod_pdr, sigit_t_dato_distrib.consumo_anno, sigit_t_dato_distrib.consumo_mensile, sigit_t_dato_distrib.mese_riferimento,
sigit_t_dato_distrib.consumo_giornaliero, sigit_t_dato_distrib.giorno_riferimento, sigit_t_dato_distrib.volumetria, sigit_t_dato_distrib.flg_pf_pg_fatt,
sigit_t_dato_distrib.cognome_denom_fatt, sigit_t_dato_distrib.nome_fatt, sigit_t_dato_distrib.cf_piva_fatt, sigit_t_dato_distrib.dug_fatt,
sigit_t_dato_distrib.indirizzo_fatt, sigit_t_dato_distrib.civico_fatt, sigit_t_dato_distrib.cap_fatt, sigit_t_dato_distrib.istat_comune_fatt
FROM sigit_t_dato_distrib
 JOIN sigit_d_tipo_contratto_distrib ON sigit_t_dato_distrib.fk_tipo_contratto = sigit_d_tipo_contratto_distrib.id_tipo_contratto_distrib
 JOIN sigit_d_combustibile ON sigit_t_dato_distrib.fk_combustibile = sigit_d_combustibile.id_combustibile
 JOIN sigit_d_unita_misura ON sigit_t_dato_distrib.fk_unita_misura = sigit_d_unita_misura.id_unita_misura
 JOIN sigit_d_categoria_util ON sigit_d_categoria_util.id_categoria_util = sigit_t_dato_distrib.fk_categoria_util
 JOIN sigit_t_import_distrib ON sigit_t_dato_distrib.fk_import_distrib = sigit_t_import_distrib.id_import_distrib
 JOIN vista_elenco_distributori ON sigit_t_import_distrib.fk_persona_giuridica = vista_elenco_distributori.id_persona_giuridica
 JOIN sigit_d_stato_distrib ON sigit_t_import_distrib.fk_stato_distrib = sigit_d_stato_distrib.id_stato_distrib
 LEFT JOIN sigit_t_rif_catast ON sigit_t_dato_distrib.id_dato_distrib = sigit_t_rif_catast.fk_dato_distrib;
 
----------------------------------------------------------------------------------------
-- 23/04/2020  Lorita
-- Richiesta aggionrnamento vista_ricerca_impianti con l'aggiunta di sigit_t_unita_immobiliare.fk_l2
-- Mail di Mariuccia del 22/4/2020 h 16:37
----------------------------------------------------------------------------------------
CREATE OR REPLACE VIEW sigit_new.vista_ricerca_impianti	
AS SELECT DISTINCT sigit_t_impianto.codice_impianto, 
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
    sigit_t_impianto.flg_contabilizzazione, sigit_d_stato_imp.des_stato,
    sigit_t_unita_immobiliare.fk_l2
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
			  WHERE (sigit_r_imp_ruolo_pfpg_1.fk_ruolo = ANY (ARRAY[4::numeric, 5::numeric, 10::numeric, 11::numeric, 12::numeric, 13::numeric])) AND sigit_r_imp_ruolo_pfpg_1.data_inizio <= now() AND now() <= COALESCE(sigit_r_imp_ruolo_pfpg_1.data_fine::timestamp with time zone, now(), sigit_r_imp_ruolo_pfpg_1.data_fine::timestamp with time zone)
			  ) q_pf_ruolo ON sigit_t_impianto.codice_impianto = q_pf_ruolo.codice_impianto
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
			  WHERE (sigit_r_imp_ruolo_pfpg.fk_ruolo = ANY (ARRAY[4::numeric, 5::numeric, 10::numeric, 11::numeric, 12::numeric, 13::numeric])) AND sigit_r_imp_ruolo_pfpg.data_inizio <= now() AND now() <= COALESCE(sigit_r_imp_ruolo_pfpg.data_fine::timestamp with time zone, now(), sigit_r_imp_ruolo_pfpg.data_fine::timestamp with time zone)
			  ) q_pg_ruolo ON sigit_t_impianto.codice_impianto = q_pg_ruolo.codice_impianto
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
	  WHERE sigit_t_contratto_2019.data_cessazione IS NULL AND (sigit_t_contratto_2019.flg_tacito_rinnovo = 1::numeric OR sigit_t_contratto_2019.flg_tacito_rinnovo = 0::numeric AND sigit_t_contratto_2019.data_fine >= now()::date)
	  ) q_contratto ON sigit_t_impianto.codice_impianto = q_contratto.codice_impianto
  WHERE sigit_t_unita_immobiliare.flg_principale = 1::numeric;

----------------------------------------------------------------------------------------
-- 07/05/2020  Lorita
-- Richiesta modifica logica sigit_t_persona_giuridica perchè non si spiega la modifica del 10/1
-- Mail di Mariuccia del 07/05/2020 h 9:45
----------------------------------------------------------------------------------------
ALTER TABLE sigit_t_persona_giuridica ALTER COLUMN dt_agg_dichiarazione drop not null;

UPDATE sigit_t_persona_giuridica
SET dt_agg_dichiarazione = NULL;

----------------------------------------------------------------------------------------
-- 11/05/2020  Lorita
-- Aggiornamento vista SDP grant verso l'utente RO come da mail di Andrea Posadino del 24/4/2020
----------------------------------------------------------------------------------------
drop VIEW vista_dati_import_distributori;

CREATE OR REPLACE VIEW vista_dati_import_distributori AS 
SELECT
vista_elenco_distributori.codice_fiscale AS cf_distributore, vista_elenco_distributori.denominazione AS denominazione_distributore,
vista_elenco_distributori.sigla_rea AS sigla_rea_distributore, vista_elenco_distributori.numero_rea AS numero_rea_distributore,
sigit_t_import_distrib.fk_persona_giuridica,
sigit_d_stato_distrib.des_stato_distrib, sigit_t_import_distrib.data_inizio_elab, sigit_t_import_distrib.data_fine_elab,
sigit_t_import_distrib.nome_file_import, sigit_t_import_distrib.data_annullamento, sigit_t_import_distrib.anno_riferimento,
sigit_t_import_distrib.tot_record_elaborati, sigit_t_import_distrib.tot_record_scartati, sigit_t_import_distrib.data_ult_mod,
sigit_d_tipo_contratto_distrib.des_tipo_contratto_distrib, sigit_d_combustibile.des_combustibile, sigit_d_unita_misura.des_unita_misura,
sigit_d_categoria_util.des_categoria_util, sigit_t_dato_distrib.flg_pf_pg, sigit_t_dato_distrib.cognome_denom AS cognome_denom_cliente,
sigit_t_dato_distrib.nome AS nome_cliente, sigit_t_dato_distrib.cf_piva AS cf_cliente, sigit_t_dato_distrib.anno_rif,
sigit_t_dato_distrib.nr_mesi_fattur, sigit_t_dato_distrib.dug AS dug_cliente, sigit_t_dato_distrib.indirizzo AS indirizzo_cliente,
sigit_t_dato_distrib.civico AS civico_cliente, sigit_t_dato_distrib.cap AS cap_cliente, sigit_t_dato_distrib.istat_comune AS istat_comune_cliente,
sigit_t_rif_catast.sezione, sigit_t_rif_catast.foglio, sigit_t_rif_catast.particella, sigit_t_rif_catast.subalterno,
sigit_t_dato_distrib.pod_pdr, sigit_t_dato_distrib.consumo_anno, sigit_t_dato_distrib.consumo_mensile, sigit_t_dato_distrib.mese_riferimento,
sigit_t_dato_distrib.consumo_giornaliero, sigit_t_dato_distrib.giorno_riferimento, sigit_t_dato_distrib.volumetria, sigit_t_dato_distrib.flg_pf_pg_fatt,
sigit_t_dato_distrib.cognome_denom_fatt, sigit_t_dato_distrib.nome_fatt, sigit_t_dato_distrib.cf_piva_fatt, sigit_t_dato_distrib.dug_fatt,
sigit_t_dato_distrib.indirizzo_fatt, sigit_t_dato_distrib.civico_fatt, sigit_t_dato_distrib.cap_fatt, sigit_t_dato_distrib.istat_comune_fatt
FROM sigit_t_dato_distrib 
 JOIN sigit_d_tipo_contratto_distrib ON sigit_t_dato_distrib.fk_tipo_contratto = sigit_d_tipo_contratto_distrib.id_tipo_contratto_distrib
 JOIN sigit_d_combustibile ON sigit_t_dato_distrib.fk_combustibile = sigit_d_combustibile.id_combustibile
 JOIN sigit_d_unita_misura ON sigit_t_dato_distrib.fk_unita_misura = sigit_d_unita_misura.id_unita_misura
 JOIN sigit_d_categoria_util ON sigit_d_categoria_util.id_categoria_util = sigit_t_dato_distrib.fk_categoria_util
 JOIN sigit_t_import_distrib ON sigit_t_dato_distrib.fk_import_distrib = sigit_t_import_distrib.id_import_distrib
 JOIN vista_elenco_distributori ON sigit_t_import_distrib.fk_persona_giuridica = vista_elenco_distributori.id_persona_giuridica
 JOIN sigit_d_stato_distrib ON sigit_t_import_distrib.fk_stato_distrib = sigit_d_stato_distrib.id_stato_distrib
 LEFT JOIN sigit_t_rif_catast ON sigit_t_dato_distrib.id_dato_distrib = sigit_t_rif_catast.fk_dato_distrib;

GRANT SELECT ON TABLE sigit_new.vista_dati_import_distributori TO sigit_new_ro;

----------------------------------------------------------------------------------------
-- 11/05/2020  Lorita
-- Script aggiornamento SIGIT_WRK_RUOLO_FUNZ come da mail di Mariuccia del 27/4/2020
----------------------------------------------------------------------------------------
update SIGIT_WRK_RUOLO_FUNZ
set ruolo = 'IMPRESA'
where ruolo = 'MANUTENTORE';

update SIGIT_WRK_RUOLO_FUNZ
set ruolo = 'CARICATORE'
where ruolo = 'INSTALLATORE';

update SIGIT_WRK_RUOLO_FUNZ
set ruolo = 'SUPERUSER'
where ruolo = 'SUPER';

INSERT INTO SIGIT_WRK_RUOLO_FUNZ (ruolo,flg_acq_bollino,flg_acq_cod_imp,flg_acq_boll_trans,flg_impianto,flg_allegato,flg_consultazione,flg_ispezione,flg_import_mass_allegato,flg_subentro,flg_delega,flg_3responsabile,flg_ric_avz_impianti,flg_distributori,flg_incarichi_cat,flg_impresa,flg_exp_xml_modol) VALUES 
('PROPRIETARIO',0,0,0,1,1,0,0,0,1,0,0,0,0,0,0,0)
,('PROPRIETARIO IMPRESA/ENTE',0,0,0,1,1,0,0,0,1,1,0,0,0,0,0,0)
;

----------------------------------------------------------------------------------------
-- 11/05/2020  Lorita
-- Rinominata tabella sigit_d_tipo_contratto come da mail di Mariuccia del 8/5/2020
----------------------------------------------------------------------------------------
ALTER TABLE sigit_d_tipo_contratto RENAME TO old_sigit_d_tipo_contratto;

----------------------------------------------------------------------------------------
-- 11/05/2020  Lorita
-- Eliminato campo SIGIT_T_PERSONA_GIURIDICA.flg_dm37_letterag come da mail di Mariuccia del 11/5/2020
----------------------------------------------------------------------------------------
ALTER TABLE sigit_t_persona_giuridica DROP COLUMN flg_dm37_letterag;


----------------------------------------------------------------------------------------
-- 12/05/2020  Lorita
-- Aggiornamento  vista_dati_import_distributori come da mail di Andrea Posadino del 12/5/2020
----------------------------------------------------------------------------------------
drop VIEW sigit_new.vista_dati_import_distributori;

CREATE OR REPLACE VIEW sigit_new.vista_dati_import_distributori
AS SELECT
vista_elenco_distributori.codice_fiscale AS cf_distributore, 
vista_elenco_distributori.denominazione AS denominazione_distributore,
vista_elenco_distributori.sigla_rea AS sigla_rea_distributore, 
vista_elenco_distributori.numero_rea AS numero_rea_distributore,
sigit_t_import_distrib.fk_persona_giuridica, sigit_d_stato_distrib.des_stato_distrib, 
sigit_t_dato_distrib.fk_import_distrib, sigit_t_import_distrib.id_import_distrib, 
sigit_t_import_distrib.data_inizio_elab, sigit_t_import_distrib.data_fine_elab, 
sigit_t_import_distrib.nome_file_import, sigit_t_import_distrib.data_annullamento, 
sigit_t_import_distrib.anno_riferimento, sigit_t_import_distrib.tot_record_elaborati, 
sigit_t_import_distrib.tot_record_scartati, sigit_t_import_distrib.data_ult_mod, 
sigit_t_dato_distrib.fk_tipo_contratto, sigit_d_tipo_contratto_distrib.des_tipo_contratto_distrib, 
sigit_t_dato_distrib.fk_combustibile, sigit_d_combustibile.des_combustibile, sigit_t_dato_distrib.fk_unita_misura, 
sigit_d_unita_misura.des_unita_misura, sigit_t_dato_distrib.id_dato_distrib, 
sigit_t_dato_distrib.fk_categoria_util, sigit_d_categoria_util.des_categoria_util, 
sigit_t_dato_distrib.flg_pf_pg, sigit_t_dato_distrib.cognome_denom AS cognome_denom_cliente,
sigit_t_dato_distrib.nome AS nome_cliente, sigit_t_dato_distrib.cf_piva AS cf_cliente, 
sigit_t_dato_distrib.anno_rif, sigit_t_dato_distrib.nr_mesi_fattur, sigit_t_dato_distrib.dug AS dug_cliente, 
sigit_t_dato_distrib.indirizzo AS indirizzo_cliente, sigit_t_dato_distrib.civico AS civico_cliente, 
sigit_t_dato_distrib.cap AS cap_cliente, sigit_t_dato_distrib.istat_comune AS istat_comune_cliente, 
sigit_t_dato_distrib.codice_assenza_catast, sigit_t_rif_catast.sezione, sigit_t_rif_catast.foglio, 
sigit_t_rif_catast.particella, sigit_t_rif_catast.subalterno, sigit_t_dato_distrib.pod_pdr, 
sigit_t_dato_distrib.consumo_anno, sigit_t_dato_distrib.consumo_mensile, sigit_t_dato_distrib.mese_riferimento,
sigit_t_dato_distrib.consumo_giornaliero, sigit_t_dato_distrib.giorno_riferimento, 
sigit_t_dato_distrib.volumetria, sigit_t_dato_distrib.flg_pf_pg_fatt, sigit_t_dato_distrib.cognome_denom_fatt, 
sigit_t_dato_distrib.nome_fatt, sigit_t_dato_distrib.cf_piva_fatt, sigit_t_dato_distrib.dug_fatt, 
sigit_t_dato_distrib.indirizzo_fatt, sigit_t_dato_distrib.civico_fatt, sigit_t_dato_distrib.cap_fatt, 
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

-- Permissions

ALTER TABLE sigit_new.vista_dati_import_distributori OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_new.vista_dati_import_distributori TO sigit_new;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE sigit_new.vista_dati_import_distributori TO sigit_new_rw;
GRANT SELECT ON TABLE sigit_new.vista_dati_import_distributori TO sigit_new_ro;


----------------------------------------------------------------------------------------
-- 18/05/2020  Lorita
-- Modifica campo flg_GDPR su sigit_t_persona_fisica
----------------------------------------------------------------------------------------
UPDATE sigit_t_persona_fisica
set flg_GDPR = 1
where flg_GDPR is NULL;

ALTER TABLE sigit_t_persona_fisica ALTER COLUMN flg_GDPR SET DEFAULT 1;
ALTER TABLE sigit_t_persona_fisica ALTER COLUMN flg_GDPR SET NOT NULL;


----------------------------------------------------------------------------------------
-- 28/05/2020  Lorita
-- Aggiunta campo sigit_d_ruolo.ruolo_funz su vista_ricerca_impianti e tabelle collegate
-- come da mail di Mariuccia del 22/5/2020 16:03
----------------------------------------------------------------------------------------
drop VIEW sigit_new.od_vista_aggregata_impianto_potenza;

drop VIEW od_vista_aggregata_stato_impianto;

drop VIEW sigit_new.v_srv_ricerca_nox_al;

drop VIEW sigit_new.v_srv_ricerca_nox_to;

drop VIEW sigit_new.vista_ricerca_impianti;

CREATE OR REPLACE VIEW sigit_new.vista_ricerca_impianti
AS 
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
    COALESCE(q_pf_ruolo.des_ruolo1, q_pg_ruolo.des_ruolo1, q_pf_ruolo.des_ruolo1) AS des_ruolo, 
    sigit_t_impianto.flg_tipo_impianto, sigit_t_impianto.flg_apparecc_ui_ext, 
    sigit_t_impianto.flg_contabilizzazione, sigit_d_stato_imp.des_stato, 
    sigit_t_unita_immobiliare.fk_l2
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
		    sigit_d_ruolo.ruolo_funz AS ruolo_funz1, sigit_d_ruolo.des_ruolo as des_ruolo1,
		    now() AS data_validita, 
		    sigit_r_imp_ruolo_pfpg_1.data_inizio, sigit_r_imp_ruolo_pfpg_1.data_fine
		   FROM sigit_d_ruolo
		   JOIN (sigit_r_imp_ruolo_pfpg sigit_r_imp_ruolo_pfpg_1
		   JOIN sigit_t_persona_fisica ON sigit_r_imp_ruolo_pfpg_1.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica) ON sigit_d_ruolo.id_ruolo = sigit_r_imp_ruolo_pfpg_1.fk_ruolo
		  WHERE (sigit_r_imp_ruolo_pfpg_1.fk_ruolo = ANY (ARRAY[4::numeric, 5::numeric, 10::numeric, 11::numeric, 12::numeric, 13::numeric])) AND sigit_r_imp_ruolo_pfpg_1.data_inizio <= now() AND now() <= COALESCE(sigit_r_imp_ruolo_pfpg_1.data_fine::timestamp with time zone, now(), sigit_r_imp_ruolo_pfpg_1.data_fine::timestamp with time zone)
  		) q_pf_ruolo ON sigit_t_impianto.codice_impianto = q_pf_ruolo.codice_impianto
   LEFT JOIN ( SELECT sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg, 
		    sigit_r_imp_ruolo_pfpg.codice_impianto, 
		    sigit_r_imp_ruolo_pfpg.data_fine AS data_fine_pfpg, 
		    sigit_t_persona_giuridica.id_persona_giuridica AS id_pg_responsabile, 
		    sigit_t_persona_giuridica.codice_fiscale AS codice_fisc, 
		    sigit_t_persona_giuridica.denominazione AS denominazione_resp, 
		    sigit_r_imp_ruolo_pfpg.fk_ruolo AS ruolo_resp, 
		    sigit_d_ruolo.ruolo_funz AS ruolo_funz1, sigit_d_ruolo.des_ruolo as des_ruolo1,
		    now() AS data_validita, 
		    sigit_r_imp_ruolo_pfpg.data_inizio, sigit_r_imp_ruolo_pfpg.data_fine
		   FROM sigit_d_ruolo
		   JOIN sigit_r_imp_ruolo_pfpg ON sigit_d_ruolo.id_ruolo = sigit_r_imp_ruolo_pfpg.fk_ruolo
		   JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
		  WHERE (sigit_r_imp_ruolo_pfpg.fk_ruolo = ANY (ARRAY[4::numeric, 5::numeric, 10::numeric, 11::numeric, 12::numeric, 13::numeric])) AND sigit_r_imp_ruolo_pfpg.data_inizio <= now() AND now() <= COALESCE(sigit_r_imp_ruolo_pfpg.data_fine::timestamp with time zone, now(), sigit_r_imp_ruolo_pfpg.data_fine::timestamp with time zone)
  		) q_pg_ruolo ON sigit_t_impianto.codice_impianto = q_pg_ruolo.codice_impianto
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
		  WHERE sigit_t_contratto_2019.data_cessazione IS NULL AND (sigit_t_contratto_2019.flg_tacito_rinnovo = 1::numeric OR sigit_t_contratto_2019.flg_tacito_rinnovo = 0::numeric AND sigit_t_contratto_2019.data_fine >= now()::date)
  		) q_contratto ON sigit_t_impianto.codice_impianto = q_contratto.codice_impianto
  WHERE sigit_t_unita_immobiliare.flg_principale = 1::numeric;

-- Permissions

ALTER TABLE sigit_new.vista_ricerca_impianti OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_new.vista_ricerca_impianti TO sigit_new;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE sigit_new.vista_ricerca_impianti TO sigit_new_rw;


CREATE OR REPLACE VIEW sigit_new.od_vista_aggregata_impianto_potenza
AS SELECT elenco.denominazione_comune AS key_classe, 
    sum(elenco.tot_35) AS pot_clima_inv_fino_al_35, 
    sum(elenco.tot_100) AS pot_clima_inv_dal_36_al_100, 
    sum(elenco.tot_250) AS pot_clima_inv_dal_101_al_250, 
    sum(elenco.tot_350) AS pot_clima_inv_dal_251_al_350, 
    sum(elenco.tot_351) AS pot_clima_inv_oltre_350, 
    sum(elenco.tot_e_35) AS pot_clima_est_fino_al_35, 
    sum(elenco.tot_e_100) AS pot_clima_est_dal_36_al_100, 
    sum(elenco.tot_e_250) AS pot_clima_est_dal_101_al_250, 
    sum(elenco.tot_e_350) AS pot_clima_est_dal_251_al_350, 
    sum(elenco.tot_e_351) AS pot_clima_iest_oltre_350
   FROM ( SELECT vista_ricerca_impianti.denominazione_comune, 
            vista_ricerca_impianti.l1_3_pot_clima_inv_kw, 
                CASE
                    WHEN vista_ricerca_impianti.l1_3_pot_clima_inv_kw <= 35::numeric THEN 1
                    ELSE 0
                END AS tot_35, 
                CASE
                    WHEN vista_ricerca_impianti.l1_3_pot_clima_inv_kw >= 36::numeric AND vista_ricerca_impianti.l1_3_pot_clima_inv_kw <= 100::numeric THEN 1
                    ELSE 0
                END AS tot_100, 
                CASE
                    WHEN vista_ricerca_impianti.l1_3_pot_clima_inv_kw >= 101::numeric AND vista_ricerca_impianti.l1_3_pot_clima_inv_kw <= 250::numeric THEN 1
                    ELSE 0
                END AS tot_250, 
                CASE
                    WHEN vista_ricerca_impianti.l1_3_pot_clima_inv_kw >= 251::numeric AND vista_ricerca_impianti.l1_3_pot_clima_inv_kw <= 350::numeric THEN 1
                    ELSE 0
                END AS tot_350, 
                CASE
                    WHEN vista_ricerca_impianti.l1_3_pot_clima_inv_kw > 350::numeric THEN 1
                    ELSE 0
                END AS tot_351, 
            vista_ricerca_impianti.l1_3_pot_clima_est_kw, 
                CASE
                    WHEN vista_ricerca_impianti.l1_3_pot_clima_est_kw <= 35::numeric THEN 1
                    ELSE 0
                END AS tot_e_35, 
                CASE
                    WHEN vista_ricerca_impianti.l1_3_pot_clima_est_kw >= 36::numeric AND vista_ricerca_impianti.l1_3_pot_clima_est_kw <= 100::numeric THEN 1
                    ELSE 0
                END AS tot_e_100, 
                CASE
                    WHEN vista_ricerca_impianti.l1_3_pot_clima_est_kw >= 101::numeric AND vista_ricerca_impianti.l1_3_pot_clima_est_kw <= 250::numeric THEN 1
                    ELSE 0
                END AS tot_e_250, 
                CASE
                    WHEN vista_ricerca_impianti.l1_3_pot_clima_est_kw >= 251::numeric AND vista_ricerca_impianti.l1_3_pot_clima_est_kw <= 350::numeric THEN 1
                    ELSE 0
                END AS tot_e_350, 
                CASE
                    WHEN vista_ricerca_impianti.l1_3_pot_clima_est_kw > 350::numeric THEN 1
                    ELSE 0
                END AS tot_e_351
           FROM vista_ricerca_impianti
          WHERE vista_ricerca_impianti.des_stato::text ~~ 'Attivo'::text) elenco
  GROUP BY elenco.denominazione_comune
  ORDER BY elenco.denominazione_comune;

-- Permissions

ALTER TABLE sigit_new.od_vista_aggregata_impianto_potenza OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_new.od_vista_aggregata_impianto_potenza TO sigit_new;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE sigit_new.od_vista_aggregata_impianto_potenza TO sigit_new_rw;

CREATE OR REPLACE VIEW sigit_new.od_vista_aggregata_stato_impianto
AS SELECT elenco.denominazione_comune AS key_classe, elenco.sigla_provincia, 
    sum(elenco.tot_attivo) AS attivo, sum(elenco.tot_cancellato) AS cancellato, 
    sum(elenco.tot_dismesso) AS dismesso, 
    sum(elenco.tot_sospeso) AS inattivabile_sospeso
   FROM ( SELECT vista_ricerca_impianti.sigla_provincia, 
            vista_ricerca_impianti.denominazione_comune, 
            vista_ricerca_impianti.des_stato, 
                CASE
                    WHEN vista_ricerca_impianti.des_stato::text ~~ 'Attivo'::text THEN 1
                    ELSE 0
                END AS tot_attivo, 
                CASE
                    WHEN vista_ricerca_impianti.des_stato::text ~~ 'Cancellato'::text THEN 1
                    ELSE 0
                END AS tot_cancellato, 
                CASE
                    WHEN vista_ricerca_impianti.des_stato::text ~~ 'Dismesso'::text THEN 1
                    ELSE 0
                END AS tot_dismesso, 
                CASE
                    WHEN vista_ricerca_impianti.des_stato::text ~~ 'Inattivabile/Sospeso'::text THEN 1
                    ELSE 0
                END AS tot_sospeso
           FROM vista_ricerca_impianti) elenco
  GROUP BY elenco.denominazione_comune, elenco.sigla_provincia
  ORDER BY elenco.denominazione_comune;

-- Permissions

ALTER TABLE sigit_new.od_vista_aggregata_stato_impianto OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_new.od_vista_aggregata_stato_impianto TO sigit_new;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE sigit_new.od_vista_aggregata_stato_impianto TO sigit_new_rw;

CREATE OR REPLACE VIEW sigit_new.v_srv_ricerca_nox_al
AS SELECT vista_ricerca_impianti.id_pf_responsabile, 
    vista_ricerca_impianti.id_pg_responsabile, sigit_t_allegato.data_controllo, 
    sigit_t_comp_gt.fk_combustibile, 
    sigit_t_impianto.denominazione_comune AS comune_impianto, 
    sigit_t_impianto.codice_impianto, sigit_t_comp_gt.id_tipo_componente, 
    sigit_t_comp_gt.progressivo, 
    sigit_t_unita_immobiliare.indirizzo_sitad AS indirizzo_sitad_impianto, 
    sigit_t_unita_immobiliare.indirizzo_non_trovato AS indirizzo_nn_trovato_impianto, 
    sigit_t_unita_immobiliare.civico AS civico_impianto, 
    sigit_t_unita_immobiliare.cap AS cap_impianto, 
    vista_ricerca_impianti.denominazione_responsabile, 
    vista_ricerca_impianti.denominazione_3_responsabile, 
    vista_ricerca_impianti.id_pg_3r, sigit_d_ruolo.des_ruolo, 
    vista_ricerca_impianti.ruolo_funz, sigit_d_combustibile.des_combustibile, 
    sigit_t_dett_tipo1.e_nox_ppm, sigit_t_comp_gt.rendimento_perc, 
    sigit_t_comp_gt.potenza_termica_kw, sigit_t_allegato.f_osservazioni, 
    sigit_t_allegato.f_raccomandazioni, sigit_t_allegato.f_prescrizioni, 
    sigit_t_allegato.f_flg_puo_funzionare, sigit_t_dett_tipo1.e_nox_mg_kwh
   FROM sigit_r_comp4manut_all
   JOIN (sigit_r_comp4_manut
   JOIN (sigit_t_impianto
   JOIN sigit_t_comp_gt ON sigit_t_impianto.codice_impianto = sigit_t_comp_gt.codice_impianto) ON sigit_r_comp4_manut.progressivo = sigit_t_comp_gt.progressivo AND sigit_t_comp_gt.id_tipo_componente::text = sigit_r_comp4_manut.id_tipo_componente::text AND sigit_r_comp4_manut.codice_impianto = sigit_t_comp_gt.codice_impianto) ON sigit_r_comp4manut_all.id_r_comp4_manut = sigit_r_comp4_manut.id_r_comp4_manut
   JOIN sigit_t_allegato ON sigit_r_comp4manut_all.id_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_t_unita_immobiliare ON sigit_t_impianto.codice_impianto = sigit_t_unita_immobiliare.codice_impianto AND sigit_t_unita_immobiliare.flg_principale = 1::numeric AND sigit_t_impianto.sigla_provincia::text = 'AL'::text
   JOIN sigit_t_dett_tipo1 ON sigit_t_allegato.id_allegato = sigit_t_dett_tipo1.fk_allegato
   JOIN sigit_d_combustibile ON sigit_t_comp_gt.fk_combustibile = sigit_d_combustibile.id_combustibile
   JOIN vista_ricerca_impianti ON sigit_t_impianto.codice_impianto = vista_ricerca_impianti.codice_impianto
   JOIN sigit_d_ruolo ON vista_ricerca_impianti.ruolo_responsabile = sigit_d_ruolo.id_ruolo
  ORDER BY sigit_t_impianto.denominazione_comune, sigit_t_impianto.codice_impianto;

-- Permissions

ALTER TABLE sigit_new.v_srv_ricerca_nox_al OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_new.v_srv_ricerca_nox_al TO sigit_new;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE sigit_new.v_srv_ricerca_nox_al TO sigit_new_rw;

CREATE OR REPLACE VIEW sigit_new.v_srv_ricerca_nox_to
AS SELECT vista_ricerca_impianti.id_pf_responsabile, 
    vista_ricerca_impianti.id_pg_responsabile, sigit_t_allegato.data_controllo, 
    sigit_t_comp_gt.fk_combustibile, 
    sigit_t_impianto.denominazione_comune AS comune_impianto, 
    sigit_t_impianto.codice_impianto, sigit_t_comp_gt.id_tipo_componente, 
    sigit_t_comp_gt.progressivo, 
    sigit_t_unita_immobiliare.indirizzo_sitad AS indirizzo_sitad_impianto, 
    sigit_t_unita_immobiliare.indirizzo_non_trovato AS indirizzo_nn_trovato_impianto, 
    sigit_t_unita_immobiliare.civico AS civico_impianto, 
    sigit_t_unita_immobiliare.cap AS cap_impianto, 
    vista_ricerca_impianti.denominazione_responsabile, 
    vista_ricerca_impianti.denominazione_3_responsabile, 
    vista_ricerca_impianti.id_pg_3r, sigit_d_ruolo.des_ruolo, 
    vista_ricerca_impianti.ruolo_funz, sigit_d_combustibile.des_combustibile, 
    sigit_t_dett_tipo1.e_nox_ppm, sigit_t_comp_gt.rendimento_perc, 
    sigit_t_comp_gt.potenza_termica_kw, sigit_t_allegato.f_osservazioni, 
    sigit_t_allegato.f_raccomandazioni, sigit_t_allegato.f_prescrizioni, 
    sigit_t_allegato.f_flg_puo_funzionare, sigit_t_dett_tipo1.e_nox_mg_kwh
   FROM sigit_r_comp4manut_all
   JOIN (sigit_r_comp4_manut
   JOIN (sigit_t_impianto
   JOIN sigit_t_comp_gt ON sigit_t_impianto.codice_impianto = sigit_t_comp_gt.codice_impianto) ON sigit_r_comp4_manut.progressivo = sigit_t_comp_gt.progressivo AND sigit_t_comp_gt.id_tipo_componente::text = sigit_r_comp4_manut.id_tipo_componente::text AND sigit_r_comp4_manut.codice_impianto = sigit_t_comp_gt.codice_impianto) ON sigit_r_comp4manut_all.id_r_comp4_manut = sigit_r_comp4_manut.id_r_comp4_manut
   JOIN sigit_t_allegato ON sigit_r_comp4manut_all.id_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_t_unita_immobiliare ON sigit_t_impianto.codice_impianto = sigit_t_unita_immobiliare.codice_impianto AND sigit_t_unita_immobiliare.flg_principale = 1::numeric AND (sigit_t_impianto.istat_comune::text = ANY (ARRAY['001156'::character varying::text, '001090'::character varying::text, '001164'::character varying::text, '001272'::character varying::text, '001265'::character varying::text, '001120'::character varying::text, '001292'::character varying::text, '001171'::character varying::text, '001063'::character varying::text, '001024'::character varying::text, '001130'::character varying::text, '001314'::character varying::text, '001028'::character varying::text, '001316'::character varying::text, '001219'::character varying::text, '001078'::character varying::text, '001214'::character varying::text, '001249'::character varying::text, '001189'::character varying::text, '001008'::character varying::text, '001309'::character varying::text, '001280'::character varying::text, '001257'::character varying::text, '001058'::character varying::text, '001127'::character varying::text, '001099'::character varying::text, '001192'::character varying::text, '001048'::character varying::text, '001051'::character varying::text, '001183'::character varying::text, '001059'::character varying::text, '001082'::character varying::text, '001125'::character varying::text]))
   JOIN sigit_t_dett_tipo1 ON sigit_t_allegato.id_allegato = sigit_t_dett_tipo1.fk_allegato
   JOIN sigit_d_combustibile ON sigit_t_comp_gt.fk_combustibile = sigit_d_combustibile.id_combustibile
   JOIN vista_ricerca_impianti ON sigit_t_impianto.codice_impianto = vista_ricerca_impianti.codice_impianto
   JOIN sigit_d_ruolo ON vista_ricerca_impianti.ruolo_responsabile = sigit_d_ruolo.id_ruolo
  ORDER BY sigit_t_impianto.denominazione_comune, sigit_t_impianto.codice_impianto;

-- Permissions

ALTER TABLE sigit_new.v_srv_ricerca_nox_to OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_new.v_srv_ricerca_nox_to TO sigit_new;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE sigit_new.v_srv_ricerca_nox_to TO sigit_new_rw;


----------------------------------------------------------------------------------------
-- 28/05/2020  Lorita
-- Aggiunta campo SIGIT_T_IMPIANTO.flg_visu_proprietario
-- come da mail di Mariuccia del 28/5/2020 12:35
----------------------------------------------------------------------------------------
alter table SIGIT_T_IMPIANTO  ADD COLUMN 
	flg_visu_proprietario     NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_visup CHECK (flg_visu_proprietario IN (0,1));

update SIGIT_T_IMPIANTO
set flg_visu_proprietario = 1
where 1 = 1;

-- dura almeno 20 minuti

----------------------------------------------------------------------------------------
-- 04/06/2020  Lorita
-- Modifica viste vista_ricerca_impianti e vista_tot_impianto
-- x aggiunta SIGIT_T_IMPIANTO.flg_visu_proprietario
-- come da mail di Mariuccia del 4/6/2020 10:25
----------------------------------------------------------------------------------------

drop VIEW sigit_new.od_vista_aggregata_impianto_potenza;

drop VIEW sigit_new.od_vista_aggregata_stato_impianto;

drop VIEW sigit_new.v_srv_ricerca_nox_al;

drop VIEW sigit_new.v_srv_ricerca_nox_to;

drop VIEW sigit_new.vista_ricerca_impianti;

CREATE OR REPLACE VIEW sigit_new.vista_ricerca_impianti
AS SELECT DISTINCT sigit_t_impianto.codice_impianto, 
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
    COALESCE(q_pf_ruolo.des_ruolo1, q_pg_ruolo.des_ruolo1, q_pf_ruolo.des_ruolo1) AS des_ruolo, 
    sigit_t_impianto.flg_tipo_impianto, sigit_t_impianto.flg_apparecc_ui_ext, 
    sigit_t_impianto.flg_contabilizzazione, sigit_d_stato_imp.des_stato, 
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
    sigit_d_ruolo.des_ruolo AS des_ruolo1, now() AS data_validita, 
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
    sigit_d_ruolo.ruolo_funz AS ruolo_funz1, 
    sigit_d_ruolo.des_ruolo AS des_ruolo1, now() AS data_validita, 
    sigit_r_imp_ruolo_pfpg.data_inizio, sigit_r_imp_ruolo_pfpg.data_fine
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

-- Permissions

ALTER TABLE sigit_new.vista_ricerca_impianti OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_new.vista_ricerca_impianti TO sigit_new;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE sigit_new.vista_ricerca_impianti TO sigit_new_rw;

CREATE OR REPLACE VIEW sigit_new.od_vista_aggregata_impianto_potenza
AS SELECT elenco.denominazione_comune AS key_classe, 
    sum(elenco.tot_35) AS pot_clima_inv_fino_al_35, 
    sum(elenco.tot_100) AS pot_clima_inv_dal_36_al_100, 
    sum(elenco.tot_250) AS pot_clima_inv_dal_101_al_250, 
    sum(elenco.tot_350) AS pot_clima_inv_dal_251_al_350, 
    sum(elenco.tot_351) AS pot_clima_inv_oltre_350, 
    sum(elenco.tot_e_35) AS pot_clima_est_fino_al_35, 
    sum(elenco.tot_e_100) AS pot_clima_est_dal_36_al_100, 
    sum(elenco.tot_e_250) AS pot_clima_est_dal_101_al_250, 
    sum(elenco.tot_e_350) AS pot_clima_est_dal_251_al_350, 
    sum(elenco.tot_e_351) AS pot_clima_iest_oltre_350
   FROM ( SELECT vista_ricerca_impianti.denominazione_comune, 
            vista_ricerca_impianti.l1_3_pot_clima_inv_kw, 
                CASE
                    WHEN vista_ricerca_impianti.l1_3_pot_clima_inv_kw <= 35::numeric THEN 1
                    ELSE 0
                END AS tot_35, 
                CASE
                    WHEN vista_ricerca_impianti.l1_3_pot_clima_inv_kw >= 36::numeric AND vista_ricerca_impianti.l1_3_pot_clima_inv_kw <= 100::numeric THEN 1
                    ELSE 0
                END AS tot_100, 
                CASE
                    WHEN vista_ricerca_impianti.l1_3_pot_clima_inv_kw >= 101::numeric AND vista_ricerca_impianti.l1_3_pot_clima_inv_kw <= 250::numeric THEN 1
                    ELSE 0
                END AS tot_250, 
                CASE
                    WHEN vista_ricerca_impianti.l1_3_pot_clima_inv_kw >= 251::numeric AND vista_ricerca_impianti.l1_3_pot_clima_inv_kw <= 350::numeric THEN 1
                    ELSE 0
                END AS tot_350, 
                CASE
                    WHEN vista_ricerca_impianti.l1_3_pot_clima_inv_kw > 350::numeric THEN 1
                    ELSE 0
                END AS tot_351, 
            vista_ricerca_impianti.l1_3_pot_clima_est_kw, 
                CASE
                    WHEN vista_ricerca_impianti.l1_3_pot_clima_est_kw <= 35::numeric THEN 1
                    ELSE 0
                END AS tot_e_35, 
                CASE
                    WHEN vista_ricerca_impianti.l1_3_pot_clima_est_kw >= 36::numeric AND vista_ricerca_impianti.l1_3_pot_clima_est_kw <= 100::numeric THEN 1
                    ELSE 0
                END AS tot_e_100, 
                CASE
                    WHEN vista_ricerca_impianti.l1_3_pot_clima_est_kw >= 101::numeric AND vista_ricerca_impianti.l1_3_pot_clima_est_kw <= 250::numeric THEN 1
                    ELSE 0
                END AS tot_e_250, 
                CASE
                    WHEN vista_ricerca_impianti.l1_3_pot_clima_est_kw >= 251::numeric AND vista_ricerca_impianti.l1_3_pot_clima_est_kw <= 350::numeric THEN 1
                    ELSE 0
                END AS tot_e_350, 
                CASE
                    WHEN vista_ricerca_impianti.l1_3_pot_clima_est_kw > 350::numeric THEN 1
                    ELSE 0
                END AS tot_e_351
           FROM vista_ricerca_impianti
          WHERE vista_ricerca_impianti.des_stato::text ~~ 'Attivo'::text) elenco
  GROUP BY elenco.denominazione_comune
  ORDER BY elenco.denominazione_comune;

-- Permissions

ALTER TABLE sigit_new.od_vista_aggregata_impianto_potenza OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_new.od_vista_aggregata_impianto_potenza TO sigit_new;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE sigit_new.od_vista_aggregata_impianto_potenza TO sigit_new_rw;

CREATE OR REPLACE VIEW sigit_new.od_vista_aggregata_stato_impianto
AS SELECT elenco.denominazione_comune AS key_classe, elenco.sigla_provincia, 
    sum(elenco.tot_attivo) AS attivo, sum(elenco.tot_cancellato) AS cancellato, 
    sum(elenco.tot_dismesso) AS dismesso, 
    sum(elenco.tot_sospeso) AS inattivabile_sospeso
   FROM ( SELECT vista_ricerca_impianti.sigla_provincia, 
            vista_ricerca_impianti.denominazione_comune, 
            vista_ricerca_impianti.des_stato, 
                CASE
                    WHEN vista_ricerca_impianti.des_stato::text ~~ 'Attivo'::text THEN 1
                    ELSE 0
                END AS tot_attivo, 
                CASE
                    WHEN vista_ricerca_impianti.des_stato::text ~~ 'Cancellato'::text THEN 1
                    ELSE 0
                END AS tot_cancellato, 
                CASE
                    WHEN vista_ricerca_impianti.des_stato::text ~~ 'Dismesso'::text THEN 1
                    ELSE 0
                END AS tot_dismesso, 
                CASE
                    WHEN vista_ricerca_impianti.des_stato::text ~~ 'Inattivabile/Sospeso'::text THEN 1
                    ELSE 0
                END AS tot_sospeso
           FROM vista_ricerca_impianti) elenco
  GROUP BY elenco.denominazione_comune, elenco.sigla_provincia
  ORDER BY elenco.denominazione_comune;

-- Permissions

ALTER TABLE sigit_new.od_vista_aggregata_stato_impianto OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_new.od_vista_aggregata_stato_impianto TO sigit_new;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE sigit_new.od_vista_aggregata_stato_impianto TO sigit_new_rw;

CREATE OR REPLACE VIEW sigit_new.v_srv_ricerca_nox_al
AS SELECT vista_ricerca_impianti.id_pf_responsabile, 
    vista_ricerca_impianti.id_pg_responsabile, sigit_t_allegato.data_controllo, 
    sigit_t_comp_gt.fk_combustibile, 
    sigit_t_impianto.denominazione_comune AS comune_impianto, 
    sigit_t_impianto.codice_impianto, sigit_t_comp_gt.id_tipo_componente, 
    sigit_t_comp_gt.progressivo, 
    sigit_t_unita_immobiliare.indirizzo_sitad AS indirizzo_sitad_impianto, 
    sigit_t_unita_immobiliare.indirizzo_non_trovato AS indirizzo_nn_trovato_impianto, 
    sigit_t_unita_immobiliare.civico AS civico_impianto, 
    sigit_t_unita_immobiliare.cap AS cap_impianto, 
    vista_ricerca_impianti.denominazione_responsabile, 
    vista_ricerca_impianti.denominazione_3_responsabile, 
    vista_ricerca_impianti.id_pg_3r, sigit_d_ruolo.des_ruolo, 
    vista_ricerca_impianti.ruolo_funz, sigit_d_combustibile.des_combustibile, 
    sigit_t_dett_tipo1.e_nox_ppm, sigit_t_comp_gt.rendimento_perc, 
    sigit_t_comp_gt.potenza_termica_kw, sigit_t_allegato.f_osservazioni, 
    sigit_t_allegato.f_raccomandazioni, sigit_t_allegato.f_prescrizioni, 
    sigit_t_allegato.f_flg_puo_funzionare, sigit_t_dett_tipo1.e_nox_mg_kwh
   FROM sigit_r_comp4manut_all
   JOIN (sigit_r_comp4_manut
   JOIN (sigit_t_impianto
   JOIN sigit_t_comp_gt ON sigit_t_impianto.codice_impianto = sigit_t_comp_gt.codice_impianto) ON sigit_r_comp4_manut.progressivo = sigit_t_comp_gt.progressivo AND sigit_t_comp_gt.id_tipo_componente::text = sigit_r_comp4_manut.id_tipo_componente::text AND sigit_r_comp4_manut.codice_impianto = sigit_t_comp_gt.codice_impianto) ON sigit_r_comp4manut_all.id_r_comp4_manut = sigit_r_comp4_manut.id_r_comp4_manut
   JOIN sigit_t_allegato ON sigit_r_comp4manut_all.id_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_t_unita_immobiliare ON sigit_t_impianto.codice_impianto = sigit_t_unita_immobiliare.codice_impianto AND sigit_t_unita_immobiliare.flg_principale = 1::numeric AND sigit_t_impianto.sigla_provincia::text = 'AL'::text
   JOIN sigit_t_dett_tipo1 ON sigit_t_allegato.id_allegato = sigit_t_dett_tipo1.fk_allegato
   JOIN sigit_d_combustibile ON sigit_t_comp_gt.fk_combustibile = sigit_d_combustibile.id_combustibile
   JOIN vista_ricerca_impianti ON sigit_t_impianto.codice_impianto = vista_ricerca_impianti.codice_impianto
   JOIN sigit_d_ruolo ON vista_ricerca_impianti.ruolo_responsabile = sigit_d_ruolo.id_ruolo
  ORDER BY sigit_t_impianto.denominazione_comune, sigit_t_impianto.codice_impianto;

-- Permissions

ALTER TABLE sigit_new.v_srv_ricerca_nox_al OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_new.v_srv_ricerca_nox_al TO sigit_new;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE sigit_new.v_srv_ricerca_nox_al TO sigit_new_rw;

CREATE OR REPLACE VIEW sigit_new.v_srv_ricerca_nox_to
AS SELECT vista_ricerca_impianti.id_pf_responsabile, 
    vista_ricerca_impianti.id_pg_responsabile, sigit_t_allegato.data_controllo, 
    sigit_t_comp_gt.fk_combustibile, 
    sigit_t_impianto.denominazione_comune AS comune_impianto, 
    sigit_t_impianto.codice_impianto, sigit_t_comp_gt.id_tipo_componente, 
    sigit_t_comp_gt.progressivo, 
    sigit_t_unita_immobiliare.indirizzo_sitad AS indirizzo_sitad_impianto, 
    sigit_t_unita_immobiliare.indirizzo_non_trovato AS indirizzo_nn_trovato_impianto, 
    sigit_t_unita_immobiliare.civico AS civico_impianto, 
    sigit_t_unita_immobiliare.cap AS cap_impianto, 
    vista_ricerca_impianti.denominazione_responsabile, 
    vista_ricerca_impianti.denominazione_3_responsabile, 
    vista_ricerca_impianti.id_pg_3r, sigit_d_ruolo.des_ruolo, 
    vista_ricerca_impianti.ruolo_funz, sigit_d_combustibile.des_combustibile, 
    sigit_t_dett_tipo1.e_nox_ppm, sigit_t_comp_gt.rendimento_perc, 
    sigit_t_comp_gt.potenza_termica_kw, sigit_t_allegato.f_osservazioni, 
    sigit_t_allegato.f_raccomandazioni, sigit_t_allegato.f_prescrizioni, 
    sigit_t_allegato.f_flg_puo_funzionare, sigit_t_dett_tipo1.e_nox_mg_kwh
   FROM sigit_r_comp4manut_all
   JOIN (sigit_r_comp4_manut
   JOIN (sigit_t_impianto
   JOIN sigit_t_comp_gt ON sigit_t_impianto.codice_impianto = sigit_t_comp_gt.codice_impianto) ON sigit_r_comp4_manut.progressivo = sigit_t_comp_gt.progressivo AND sigit_t_comp_gt.id_tipo_componente::text = sigit_r_comp4_manut.id_tipo_componente::text AND sigit_r_comp4_manut.codice_impianto = sigit_t_comp_gt.codice_impianto) ON sigit_r_comp4manut_all.id_r_comp4_manut = sigit_r_comp4_manut.id_r_comp4_manut
   JOIN sigit_t_allegato ON sigit_r_comp4manut_all.id_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_t_unita_immobiliare ON sigit_t_impianto.codice_impianto = sigit_t_unita_immobiliare.codice_impianto AND sigit_t_unita_immobiliare.flg_principale = 1::numeric AND (sigit_t_impianto.istat_comune::text = ANY (ARRAY['001156'::character varying::text, '001090'::character varying::text, '001164'::character varying::text, '001272'::character varying::text, '001265'::character varying::text, '001120'::character varying::text, '001292'::character varying::text, '001171'::character varying::text, '001063'::character varying::text, '001024'::character varying::text, '001130'::character varying::text, '001314'::character varying::text, '001028'::character varying::text, '001316'::character varying::text, '001219'::character varying::text, '001078'::character varying::text, '001214'::character varying::text, '001249'::character varying::text, '001189'::character varying::text, '001008'::character varying::text, '001309'::character varying::text, '001280'::character varying::text, '001257'::character varying::text, '001058'::character varying::text, '001127'::character varying::text, '001099'::character varying::text, '001192'::character varying::text, '001048'::character varying::text, '001051'::character varying::text, '001183'::character varying::text, '001059'::character varying::text, '001082'::character varying::text, '001125'::character varying::text]))
   JOIN sigit_t_dett_tipo1 ON sigit_t_allegato.id_allegato = sigit_t_dett_tipo1.fk_allegato
   JOIN sigit_d_combustibile ON sigit_t_comp_gt.fk_combustibile = sigit_d_combustibile.id_combustibile
   JOIN vista_ricerca_impianti ON sigit_t_impianto.codice_impianto = vista_ricerca_impianti.codice_impianto
   JOIN sigit_d_ruolo ON vista_ricerca_impianti.ruolo_responsabile = sigit_d_ruolo.id_ruolo
  ORDER BY sigit_t_impianto.denominazione_comune, sigit_t_impianto.codice_impianto;

-- Permissions

ALTER TABLE sigit_new.v_srv_ricerca_nox_to OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_new.v_srv_ricerca_nox_to TO sigit_new;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE sigit_new.v_srv_ricerca_nox_to TO sigit_new_rw;

--------
drop VIEW sigit_new.vista_tot_impianto;

CREATE OR REPLACE VIEW sigit_new.vista_tot_impianto
AS 
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
            sigit_r_imp_ruolo_pfpg.data_fine AS data_fine_pfpg,
            sigit_t_impianto.flg_visu_proprietario
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
            sigit_r_imp_ruolo_pfpg.data_fine AS data_fine_pfpg,
            sigit_t_impianto.flg_visu_proprietario
           FROM sigit_d_ruolo
      JOIN (sigit_t_persona_giuridica
      JOIN (sigit_t_impianto
      JOIN sigit_t_unita_immobiliare ON sigit_t_impianto.codice_impianto = sigit_t_unita_immobiliare.codice_impianto
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_t_impianto.codice_impianto = sigit_r_imp_ruolo_pfpg.codice_impianto) ON sigit_t_persona_giuridica.id_persona_giuridica = sigit_r_imp_ruolo_pfpg.fk_persona_giuridica) ON sigit_d_ruolo.id_ruolo = sigit_r_imp_ruolo_pfpg.fk_ruolo
  WHERE sigit_t_unita_immobiliare.flg_principale = 1::numeric;

-- Permissions

ALTER TABLE sigit_new.vista_tot_impianto OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_new.vista_tot_impianto TO sigit_new;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE sigit_new.vista_tot_impianto TO sigit_new_rw;

----------------------------------------------------------------------------------------
-- 05/06/2020  Lorita
-- Richiesta aggiunta indici per migliorare performance 
-- come da teams di Mariuccia del pomeriggio
----------------------------------------------------------------------------------------
CREATE INDEX sigit_t_impianto_prov_comune ON sigit_t_impianto USING btree (sigla_provincia,istat_comune);

CREATE INDEX IE1_sigit_t_persona_giuridica ON sigit_t_persona_giuridica USING btree (codice_fiscale);


----------------------------------------------------------------------------------------
-- 05/06/2020  Lorita
-- Veriica corretto funzionamento vista od_vista_dettaglio_impianti
-- segnaltato da Viviane con mail di assistenza.energia@csi.it del 1/6/2020 h 14:52
----------------------------------------------------------------------------------------
drop VIEW sigit_new.od_vista_dettaglio_impianti;

CREATE OR REPLACE VIEW sigit_new.od_vista_dettaglio_impianti
AS (        
		(
		SELECT i.codice_impianto, i.denominazione_comune, i.denominazione_provincia, ui.l1_2_fk_categoria, 
				ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, 
				i.l1_3_pot_clima_est_kw, 
	            gt.id_tipo_componente AS tipo_componente, gt.progressivo, gt.data_install, gt.des_marca, 
	            gt.des_combustibile, gt.des_dettaglio_gt AS des_dettaglio, 
	            gt.potenza_termica_kw AS potenza, gt.rendimento_perc, 
	            gt.data_controllo,
	            gt.e_nox_ppm, gt.e_nox_mg_kwh, gt.e_n_modulo_termico
	   	FROM sigit_t_impianto i
		JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
	    JOIN vista_dw_sk4_gt gt ON i.codice_impianto = gt.codice_impianto
	    WHERE gt.data_dismiss IS NULL AND ui.flg_principale = 1::numeric AND i.fk_stato = 1::numeric
	    and (i.codice_impianto, gt.id_tipo_componente, gt.progressivo, gt.data_controllo) in 
	        (SELECT i.codice_impianto, gt.id_tipo_componente AS tipo_componente, 
	               	gt.progressivo, max(gt.data_controllo) AS data_controllo
	         FROM sigit_t_impianto i
	         JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
	         JOIN vista_dw_sk4_gt gt ON i.codice_impianto = gt.codice_impianto
	        WHERE gt.data_dismiss IS NULL AND ui.flg_principale = 1::numeric AND i.fk_stato = 1::numeric
	        group by i.codice_impianto, gt.id_tipo_componente, gt.progressivo
	        )
	    GROUP BY i.codice_impianto, i.denominazione_comune, i.denominazione_provincia, ui.l1_2_fk_categoria, 
	    		ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, 
	    		i.l1_3_pot_clima_est_kw, 
	    		gt.id_tipo_componente, gt.progressivo, gt.data_install, gt.des_marca, gt.des_combustibile, 
	    		gt.des_dettaglio_gt, gt.potenza_termica_kw, gt.rendimento_perc, 
	    		gt.data_controllo, 
	    		gt.e_nox_ppm, gt.e_nox_mg_kwh, gt.e_n_modulo_termico
		UNION 
	    SELECT i.codice_impianto, i.denominazione_comune, 
	        i.denominazione_provincia, ui.l1_2_fk_categoria, 
	        ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, 
	        i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, 
	        i.l1_3_pot_clima_est_kw, 
	        gf.id_tipo_componente AS tipo_componente, 
	        gf.progressivo, gf.data_install, gf.des_marca, 
	        gf.des_combustibile, NULL::text AS des_dettaglio, 
	        gf.potenza_termica_kw AS potenza, 
	        NULL::numeric AS rendimento_perc, 
	        max(gf.data_controllo) AS data_controllo, 
	        NULL::numeric AS e_nox_ppm, 
	        NULL::numeric AS e_nox_mg_kwh, 
	        NULL::numeric AS e_n_modulo_termico
		FROM sigit_t_impianto i
	    JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
	    JOIN vista_dw_sk4_gf gf ON i.codice_impianto = gf.codice_impianto
	    WHERE gf.data_dismiss IS NULL AND ui.flg_principale = 1::numeric AND i.fk_stato = 1::numeric
	    GROUP BY i.codice_impianto, i.denominazione_comune, i.denominazione_provincia, ui.l1_2_fk_categoria, 
	    		ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, 
	    		i.l1_3_pot_clima_est_kw, gf.id_tipo_componente, gf.progressivo, gf.data_install, 
	    		gf.des_marca, gf.des_combustibile, NULL::text, gf.potenza_termica_kw
		)
		UNION 
	     SELECT i.codice_impianto, i.denominazione_comune, 
	        i.denominazione_provincia, ui.l1_2_fk_categoria, 
	        ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, 
	        i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, 
	        sc.id_tipo_componente AS tipo_componente, sc.progressivo, 
	        sc.data_install, sc.des_marca, 
	        NULL::character varying AS des_combustibile, 
	        NULL::text AS des_dettaglio, 
	        sc.potenza_termica_kw AS potenza, 
	        NULL::numeric AS rendimento_perc, 
	        max(sc.data_controllo) AS data_controllo, 
	        NULL::numeric AS e_nox_ppm, NULL::numeric AS e_nox_mg_kwh, 
	        NULL::numeric AS e_n_modulo_termico
	       FROM sigit_t_impianto i
	      JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
	     JOIN vista_dw_sk4_sc sc ON i.codice_impianto = sc.codice_impianto
	    WHERE sc.data_dismiss IS NULL AND ui.flg_principale = 1::numeric AND i.fk_stato = 1::numeric
	    GROUP BY i.codice_impianto, i.denominazione_comune, i.denominazione_provincia, ui.l1_2_fk_categoria, 
	    		ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, 
	    		i.l1_3_pot_clima_est_kw, sc.id_tipo_componente, sc.progressivo, sc.data_install, 
	    		sc.des_marca, NULL::text, sc.potenza_termica_kw
	    )
UNION 
     SELECT i.codice_impianto, i.denominazione_comune, 
        i.denominazione_provincia, ui.l1_2_fk_categoria, 
        ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, 
        i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, 
        cg.id_tipo_componente AS tipo_componente, cg.progressivo, 
        cg.data_install, cg.des_marca, cg.des_combustibile, 
        NULL::character varying AS des_dettaglio, 
        cg.potenza_termica_kw AS potenza, NULL::numeric AS rendimento_perc, 
        max(cg.data_controllo) AS data_controllo, 
        NULL::numeric AS e_nox_ppm, NULL::numeric AS e_nox_mg_kwh, 
        NULL::numeric AS e_n_modulo_termico
       FROM sigit_t_impianto i
      JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
   JOIN vista_dw_sk4_cg cg ON i.codice_impianto = cg.codice_impianto
  WHERE cg.data_dismiss IS NULL AND ui.flg_principale = 1::numeric AND i.fk_stato = 1::numeric
  GROUP BY i.codice_impianto, i.denominazione_comune, i.denominazione_provincia, ui.l1_2_fk_categoria, 
 		ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, 
 		i.l1_3_pot_clima_est_kw, cg.id_tipo_componente, cg.progressivo, cg.data_install, 
 	cg.des_marca, cg.des_combustibile, cg.potenza_termica_kw;

-- Permissions

ALTER TABLE sigit_new.od_vista_dettaglio_impianti OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_new.od_vista_dettaglio_impianti TO sigit_new;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE sigit_new.od_vista_dettaglio_impianti TO sigit_new_rw;


----------------------------------------------------------------------------------------
-- 08/06/2020  Lorita
-- Errore FK tra sigit_r_allegato_comp_cg e sigit_t_contratto_2019, puntava ancora a sigit_t_contratto
-- segnaltato da Mariuccia con mail 8/6/2020 h 10:19
----------------------------------------------------------------------------------------
alter table sigit_r_allegato_comp_cg 
drop CONSTRAINT fk_sigit_t_contratto_06;

alter table sigit_r_allegato_comp_cg 
add CONSTRAINT fk_sigit_t_contratto_06 FOREIGN KEY (fk_contratto) REFERENCES sigit_t_contratto_2019 (id_contratto);