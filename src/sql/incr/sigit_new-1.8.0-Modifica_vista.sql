DROP VIEW  IF EXISTS  vista_allegati;

CREATE OR REPLACE VIEW vista_allegati AS 
         SELECT a.id_allegato, a.fk_stato_rapp, a.fk_imp_ruolo_pfpg AS fk_tab, 
            a.fk_tipo_documento, doc.des_tipo_documento, a.fk_sigla_bollino, 
            a.fk_numero_bollino, a.data_controllo, a.f_osservazioni, 
            a.f_raccomandazioni, a.f_prescrizioni, a.f_flg_puo_funzionare, 
            a.f_intervento_entro, r1.codice_impianto
           FROM sigit_t_allegato a
      JOIN sigit_r_imp_ruolo_pfpg r1 ON a.fk_imp_ruolo_pfpg = r1.id_imp_ruolo_pfpg
   JOIN sigit_d_tipo_documento doc ON a.fk_tipo_documento = doc.id_tipo_documento
UNION 
         SELECT DISTINCT a.id_allegato, a.fk_stato_rapp, r1.id_r_comp4_manut AS fk_tab, 
            a.fk_tipo_documento, doc.des_tipo_documento, a.fk_sigla_bollino, 
            a.fk_numero_bollino, a.data_controllo, a.f_osservazioni, 
            a.f_raccomandazioni, a.f_prescrizioni, a.f_flg_puo_funzionare, 
            a.f_intervento_entro, r1.codice_impianto
           FROM sigit_t_allegato a
      JOIN sigit_r_comp4manut_all ON a.id_allegato = sigit_r_comp4manut_all.id_allegato
   JOIN sigit_r_comp4_manut r1 ON sigit_r_comp4manut_all.id_r_comp4_manut = r1.id_r_comp4_manut
   JOIN sigit_d_tipo_documento doc ON a.fk_tipo_documento = doc.id_tipo_documento;

ALTER TABLE vista_allegati
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_allegati TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_allegati TO sigit_new_rw;
GRANT SELECT ON TABLE vista_allegati TO sigit_new_ro;



DROP VIEW  IF EXISTS vista_ricerca_allegati;

CREATE OR REPLACE VIEW vista_ricerca_allegati AS 
         SELECT DISTINCT a.id_allegato, a.fk_stato_rapp, srapp.des_stato_rapp, 
            a.fk_imp_ruolo_pfpg, a.fk_tipo_documento, doc.des_tipo_documento, 
            a.fk_sigla_bollino, a.fk_numero_bollino, a.data_controllo, 
            a.b_flg_libretto_uso, a.b_flg_dichiar_conform, a.b_flg_lib_imp, 
            a.b_flg_lib_compl, a.f_osservazioni, a.f_raccomandazioni, 
            a.f_prescrizioni, a.f_flg_puo_funzionare, a.f_intervento_entro, 
            a.f_ora_arrivo, a.f_ora_partenza, a.f_denominaz_tecnico, 
            a.f_flg_firma_tecnico, a.f_flg_firma_responsabile, a.data_invio, 
            a.data_respinta, a.nome_allegato, 
            a.a_potenza_termica_nominale_max, a.data_ult_mod, a.utente_ult_mod, 
            a.elenco_combustibili, a.elenco_apparecchiature, ru.des_ruolo, 
            ru.ruolo_funz, pg.id_persona_giuridica, 
            pg.denominazione AS pg_denominazione, 
            pg.codice_fiscale AS pg_codice_fiscale, 
            pg.sigla_rea AS pg_sigla_rea, pg.numero_rea AS pg_numero_rea, 
            r1.codice_impianto, i.denominazione_comune AS comune_impianto, 
            i.sigla_provincia AS sigla_prov_impianto, 
            COALESCE(u.indirizzo_sitad, u.indirizzo_non_trovato) AS indirizzo_unita_immob, 
            u.civico AS civico_unita_immob, a.flg_controllo_bozza, a.uid_index
           FROM sigit_t_allegato a
      JOIN sigit_r_comp4manut_all ON a.id_allegato = sigit_r_comp4manut_all.id_allegato
   JOIN sigit_r_comp4_manut r1 ON sigit_r_comp4manut_all.id_r_comp4_manut = r1.id_r_comp4_manut
   JOIN sigit_d_ruolo ru ON r1.fk_ruolo = ru.id_ruolo
   JOIN sigit_d_tipo_documento doc ON a.fk_tipo_documento = doc.id_tipo_documento
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
            a.data_respinta, a.nome_allegato, 
            a.a_potenza_termica_nominale_max, a.data_ult_mod, a.utente_ult_mod, 
            a.elenco_combustibili, a.elenco_apparecchiature, ru.des_ruolo, 
            ru.ruolo_funz, pg.id_persona_giuridica, 
            pg.denominazione AS pg_denominazione, 
            pg.codice_fiscale AS pg_codice_fiscale, 
            pg.sigla_rea AS pg_sigla_rea, pg.numero_rea AS pg_numero_rea, 
            r1.codice_impianto, i.denominazione_comune AS comune_impianto, 
            i.sigla_provincia AS sigla_prov_impianto, 
            COALESCE(u.indirizzo_sitad, u.indirizzo_non_trovato) AS indirizzo_unita_immob, 
            u.civico AS civico_unita_immob, a.flg_controllo_bozza, a.uid_index
           FROM sigit_t_allegato a
      JOIN sigit_r_imp_ruolo_pfpg r1 ON a.fk_imp_ruolo_pfpg = r1.id_imp_ruolo_pfpg
   JOIN sigit_d_ruolo ru ON r1.fk_ruolo = ru.id_ruolo
   JOIN sigit_d_tipo_documento doc ON a.fk_tipo_documento = doc.id_tipo_documento
   JOIN sigit_d_stato_rapp srapp ON a.fk_stato_rapp = srapp.id_stato_rapp
   LEFT JOIN sigit_t_persona_giuridica pg ON r1.fk_persona_giuridica = pg.id_persona_giuridica
   LEFT JOIN sigit_t_impianto i ON r1.codice_impianto = i.codice_impianto
   LEFT JOIN sigit_t_unita_immobiliare u ON r1.codice_impianto = u.codice_impianto
  WHERE u.flg_principale = 1::numeric;





---------------------------------------------------------------------------------------------
-- Viste per il DWH, richieste da Mariuccia e lanciate in tst e prod
---------------------------------------------------------------------------------------------

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
    sigit_t_allegato.data_controllo, 
    sigit_t_impianto.istat_comune, sigit_t_impianto.denominazione_comune,  sigit_t_impianto.denominazione_provincia,sigit_t_impianto.fk_stato as stato_impianto,
    sigit_d_stato_imp.des_stato as des_stato_impianto,
    sigit_t_libretto.data_consolidamento
FROM 
   sigit_t_comp_gt
   join   sigit_t_impianto on sigit_t_impianto.codice_impianto = sigit_t_comp_gt.codice_impianto  
   join   sigit_d_stato_imp  on sigit_t_impianto.fk_stato = sigit_d_stato_imp.id_stato  
   LEFT JOIN sigit_t_libretto on sigit_t_impianto.codice_impianto = sigit_t_libretto.codice_impianto  and sigit_t_libretto.fk_stato = 2
   LEFT JOIN sigit_d_marca ON sigit_t_comp_gt.fk_marca = sigit_d_marca.id_marca
   LEFT JOIN sigit_d_fluido ON sigit_t_comp_gt.fk_fluido = sigit_d_fluido.id_fluido
   LEFT JOIN sigit_d_dettaglio_gt ON sigit_t_comp_gt.fk_dettaglio_gt = sigit_d_dettaglio_gt.id_dettaglio_gt
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp_gt.fk_combustibile = sigit_d_combustibile.id_combustibile
   LEFT JOIN sigit_t_dett_tipo1 ON sigit_t_dett_tipo1.codice_impianto = sigit_t_comp_gt.codice_impianto 
     AND sigit_t_dett_tipo1.fk_tipo_componente::text = sigit_t_comp_gt.id_tipo_componente::text 
     AND sigit_t_dett_tipo1.progressivo = sigit_t_comp_gt.progressivo 
     AND sigit_t_dett_tipo1.data_install = sigit_t_comp_gt.data_install
   LEFT JOIN sigit_t_allegato ON sigit_t_dett_tipo1.fk_allegato = sigit_t_allegato.id_allegato;

ALTER TABLE vista_dw_sk4_gt
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_dw_sk4_gt TO sigit_new;
GRANT SELECT ON TABLE vista_dw_sk4_gt TO sigit_new_ro;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_dw_sk4_gt TO sigit_new_rw;




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
   LEFT JOIN sigit_t_allegato ON sigit_t_dett_tipo4.fk_allegato = sigit_t_allegato.id_allegato;

ALTER TABLE vista_dw_sk4_cg
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_dw_sk4_cg TO sigit_new;
GRANT SELECT ON TABLE vista_dw_sk4_cg TO sigit_new_ro;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_dw_sk4_cg TO sigit_new_rw;




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
    sigit_t_comp_gf.utente_ult_mod, sigit_t_comp_gf.potenza_termica_kw, 
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
   LEFT JOIN sigit_t_allegato ON sigit_t_dett_tipo2.fk_allegato = sigit_t_allegato.id_allegato;

ALTER TABLE vista_dw_sk4_gf
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_dw_sk4_gf TO sigit_new;
GRANT SELECT ON TABLE vista_dw_sk4_gf TO sigit_new_ro;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_dw_sk4_gf TO sigit_new_rw;




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
   LEFT JOIN sigit_t_allegato ON sigit_t_dett_tipo3.fk_allegato = sigit_t_allegato.id_allegato;

ALTER TABLE vista_dw_sk4_sc
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_dw_sk4_sc TO sigit_new;
GRANT SELECT ON TABLE vista_dw_sk4_sc TO sigit_new_ro;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_dw_sk4_sc TO sigit_new_rw;





DROP VIEW IF EXISTS vista_comp_gt_dett;

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
            sigit_t_dett_tipo1.data_ult_mod AS data_ult_mod_dett, 
            sigit_t_dett_tipo1.utente_ult_mod AS utente_ult_mod_dett, 
            sigit_t_allegato.data_controllo, 
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
    JOIN sigit_t_allegato ON sigit_t_dett_tipo1.fk_allegato = sigit_t_allegato.id_allegato and fk_stato_rapp<>2
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
            sigit_t_dett_tipo1.data_ult_mod AS data_ult_mod_dett, 
            sigit_t_dett_tipo1.utente_ult_mod AS utente_ult_mod_dett, 
            sigit_t_allegato.data_controllo, 
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
    JOIN sigit_t_allegato ON sigit_t_dett_tipo1.fk_allegato = sigit_t_allegato.id_allegato and fk_stato_rapp<>2
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg = sigit_t_allegato.fk_imp_ruolo_pfpg
   LEFT JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
   LEFT JOIN sigit_t_persona_fisica ON sigit_r_imp_ruolo_pfpg.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica;


ALTER TABLE vista_comp_gt_dett
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_comp_gt_dett TO sigit_new;
GRANT SELECT ON TABLE vista_comp_gt_dett TO sigit_new_ro;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_comp_gt_dett TO sigit_new_rw;
   



DROP VIEW IF EXISTS vista_comp_cg_dett;

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
   JOIN sigit_t_allegato ON sigit_t_dett_tipo4.fk_allegato = sigit_t_allegato.id_allegato and fk_stato_rapp<>2
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
   JOIN sigit_t_allegato ON sigit_t_dett_tipo4.fk_allegato = sigit_t_allegato.id_allegato and fk_stato_rapp<>2
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg = sigit_t_allegato.fk_imp_ruolo_pfpg
   LEFT JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
   LEFT JOIN sigit_t_persona_fisica ON sigit_r_imp_ruolo_pfpg.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica;

ALTER TABLE vista_comp_cg_dett
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_comp_cg_dett TO sigit_new;
GRANT SELECT ON TABLE vista_comp_cg_dett TO sigit_new_ro;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_comp_cg_dett TO sigit_new_rw;



DROP VIEW IF EXISTS vista_comp_gf_dett;

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
      JOIN sigit_t_allegato ON sigit_t_dett_tipo2.fk_allegato = sigit_t_allegato.id_allegato and fk_stato_rapp<>2
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
      JOIN sigit_t_allegato ON sigit_t_dett_tipo2.fk_allegato = sigit_t_allegato.id_allegato and fk_stato_rapp<>2
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg = sigit_t_allegato.fk_imp_ruolo_pfpg
   LEFT JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
   LEFT JOIN sigit_t_persona_fisica ON sigit_r_imp_ruolo_pfpg.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica;

ALTER TABLE vista_comp_gf_dett
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_comp_gf_dett TO sigit_new;
GRANT SELECT ON TABLE vista_comp_gf_dett TO sigit_new_ro;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_comp_gf_dett TO sigit_new_rw;




DROP VIEW IF EXISTS vista_comp_sc_dett;

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
            sigit_t_persona_giuridica.sigla_rea, 
            sigit_t_persona_giuridica.numero_rea, 
            sigit_t_persona_giuridica.id_persona_giuridica, 
            sigit_r_comp4_manut.fk_ruolo
           FROM sigit_t_dett_tipo3
      JOIN sigit_t_allegato ON sigit_t_dett_tipo3.fk_allegato = sigit_t_allegato.id_allegato and fk_stato_rapp<>2
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
            sigit_t_persona_giuridica.sigla_rea, 
            sigit_t_persona_giuridica.numero_rea, 
            COALESCE(sigit_t_persona_giuridica.id_persona_giuridica, sigit_t_persona_fisica.id_persona_fisica, sigit_t_persona_giuridica.id_persona_giuridica) AS id_persona_giuridica, 
            sigit_r_imp_ruolo_pfpg.fk_ruolo
           FROM sigit_t_dett_tipo3
      JOIN sigit_t_allegato ON sigit_t_dett_tipo3.fk_allegato = sigit_t_allegato.id_allegato and fk_stato_rapp<>2
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg = sigit_t_allegato.fk_imp_ruolo_pfpg
   LEFT JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
   LEFT JOIN sigit_t_persona_fisica ON sigit_r_imp_ruolo_pfpg.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica;

ALTER TABLE vista_comp_sc_dett
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_comp_sc_dett TO sigit_new;
GRANT SELECT ON TABLE vista_comp_sc_dett TO sigit_new_ro;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_comp_sc_dett TO sigit_new_rw;





CREATE INDEX ie1_sigit_t_transazione_boll
  ON sigit_t_transazione_boll
  USING btree
  (data_transazione);
  
  CREATE INDEX ie1_sigit_t_transazione_imp
  ON sigit_t_transazione_imp
  USING btree
  (data_transazione);

CREATE INDEX ie2_sigit_t_transazione_imp
  ON sigit_t_transazione_imp
  USING btree
  (fk_persona_giuridica);
  
  CREATE INDEX ie2_sigit_t_transazione_boll
  ON sigit_t_transazione_boll
  USING btree
  (fk_persona_giuridica); 

CREATE INDEX ie1_sigit_t_codice_imp
  ON sigit_t_codice_imp
  USING btree
  (fk_transazione); 
  
  