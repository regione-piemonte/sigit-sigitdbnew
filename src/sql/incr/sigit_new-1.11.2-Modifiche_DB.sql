-- Modifica richiesta da Todaro, effettuata in SVI e TST - 04/07/2017
ALTER TABLE sigit_wrk_ruolo_funz ADD COLUMN flg_exp_xml_modol numeric(1,0)  CONSTRAINT dom_0_1_101 CHECK (flg_exp_xml_modol = ANY (ARRAY[0::numeric, 1::numeric]));


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
    sigit_t_libretto.data_consolidamento
   FROM sigit_t_comp_gt
   JOIN sigit_t_impianto ON sigit_t_impianto.codice_impianto = sigit_t_comp_gt.codice_impianto
   JOIN sigit_d_stato_imp ON sigit_t_impianto.fk_stato = sigit_d_stato_imp.id_stato
   LEFT JOIN sigit_t_libretto ON sigit_t_impianto.codice_impianto = sigit_t_libretto.codice_impianto AND sigit_t_libretto.fk_stato = 2::numeric
   LEFT JOIN sigit_d_marca ON sigit_t_comp_gt.fk_marca = sigit_d_marca.id_marca
   LEFT JOIN sigit_d_fluido ON sigit_t_comp_gt.fk_fluido = sigit_d_fluido.id_fluido
   LEFT JOIN sigit_d_dettaglio_gt ON sigit_t_comp_gt.fk_dettaglio_gt = sigit_d_dettaglio_gt.id_dettaglio_gt
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp_gt.fk_combustibile = sigit_d_combustibile.id_combustibile
   LEFT JOIN sigit_t_dett_tipo1 ON sigit_t_dett_tipo1.codice_impianto = sigit_t_comp_gt.codice_impianto AND sigit_t_dett_tipo1.fk_tipo_componente::text = sigit_t_comp_gt.id_tipo_componente::text AND sigit_t_dett_tipo1.progressivo = sigit_t_comp_gt.progressivo AND sigit_t_dett_tipo1.data_install = sigit_t_comp_gt.data_install
   LEFT JOIN sigit_t_allegato ON sigit_t_dett_tipo1.fk_allegato = sigit_t_allegato.id_allegato and sigit_t_allegato.fk_stato_rapp=1;

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
   LEFT JOIN sigit_t_allegato ON sigit_t_dett_tipo4.fk_allegato = sigit_t_allegato.id_allegato and sigit_t_allegato.fk_stato_rapp=1;   


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
   LEFT JOIN sigit_t_allegato ON sigit_t_dett_tipo2.fk_allegato = sigit_t_allegato.id_allegato and sigit_t_allegato.fk_stato_rapp=1;   


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
   LEFT JOIN sigit_t_allegato ON sigit_t_dett_tipo3.fk_allegato = sigit_t_allegato.id_allegato and sigit_t_allegato.fk_stato_rapp=1;   
  
