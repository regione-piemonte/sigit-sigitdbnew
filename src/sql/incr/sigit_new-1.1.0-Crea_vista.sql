CREATE OR REPLACE VIEW vista_bollini AS 
 SELECT sigit_t_codice_boll.sigla_bollino, sigit_t_codice_boll.numero_bollino, 
    sigit_t_codice_boll.fk_transazione_boll, sigit_t_codice_boll.fk_potenza, 
    sigit_t_codice_boll.fk_prezzo, 
    sigit_t_codice_boll.fk_dt_inizio_acquisto AS fk_dt_inizio, 
    sigit_d_potenza_imp.des_potenza, sigit_d_potenza_imp.limite_inferiore, 
    sigit_d_potenza_imp.limite_superiore, sigit_d_prezzo_potenza.prezzo
   FROM sigit_t_codice_boll, sigit_d_potenza_imp, sigit_r_potenza_prezzo, 
    sigit_d_prezzo_potenza
  WHERE sigit_t_codice_boll.fk_potenza = sigit_r_potenza_prezzo.id_potenza AND sigit_t_codice_boll.fk_prezzo = sigit_r_potenza_prezzo.id_prezzo 
  AND sigit_t_codice_boll.fk_dt_inizio_acquisto = sigit_r_potenza_prezzo.dt_inizio_acquisto 
  AND sigit_r_potenza_prezzo.id_potenza = sigit_d_potenza_imp.id_potenza AND sigit_r_potenza_prezzo.id_prezzo = sigit_d_prezzo_potenza.id_prezzo 
  AND (now() >= sigit_r_potenza_prezzo.dt_inizio_acquisto 
  AND now() <= sigit_r_potenza_prezzo.dt_fine_acquisto OR sigit_r_potenza_prezzo.dt_inizio_acquisto <= now() 
  AND sigit_r_potenza_prezzo.dt_fine_acquisto IS NULL);

CREATE OR REPLACE VIEW vista_comp_ac AS 
 SELECT sigit_t_comp_x.codice_impianto, sigit_t_comp_x.id_tipo_componente, 
    sigit_t_comp_x.progressivo, sigit_t_comp_x.data_install, 
    sigit_t_comp_x.data_dismiss, sigit_t_comp_x.matricola, 
    sigit_t_comp_x.fk_marca, sigit_d_marca.des_marca, sigit_t_comp_x.modello, 
    sigit_t_comp_x.data_ult_mod, sigit_t_comp_x.utente_ult_mod, 
    sigit_t_comp_ac.flg_acs, sigit_t_comp_ac.flg_risc, sigit_t_comp_ac.flg_raff, 
    sigit_t_comp_ac.flg_coib, sigit_t_comp_ac.capacita
   FROM sigit_t_comp_x
   JOIN sigit_t_comp_ac ON sigit_t_comp_x.data_install = sigit_t_comp_ac.data_install AND sigit_t_comp_x.progressivo::numeric(2) = sigit_t_comp_ac.progressivo::numeric(2) AND sigit_t_comp_x.id_tipo_componente::text = sigit_t_comp_ac.id_tipo_componente::text AND sigit_t_comp_x.codice_impianto = sigit_t_comp_ac.codice_impianto
   LEFT JOIN sigit_d_marca ON sigit_t_comp_x.fk_marca = sigit_d_marca.id_marca;
   
CREATE OR REPLACE VIEW vista_comp_ag AS 
 SELECT sigit_t_comp4.codice_impianto, sigit_t_comp4.id_tipo_componente, 
    sigit_t_comp4.progressivo, sigit_t_comp4.data_install, 
    sigit_t_comp4.data_dismiss, sigit_t_comp4.matricola, 
    sigit_t_comp4.fk_combustibile, sigit_d_combustibile.des_combustibile, 
    sigit_t_comp4.fk_marca, sigit_d_marca.des_marca, sigit_t_comp4.modello, 
    sigit_t_comp4.potenza_termica_kw, sigit_t_comp4.data_ult_mod, 
    sigit_t_comp4.utente_ult_mod, sigit_t_comp_ag.tipologia, 
    sigit_t_comp4.flg_dismissione
   FROM sigit_t_comp4
   JOIN sigit_t_comp_ag ON sigit_t_comp4.data_install = sigit_t_comp_ag.data_install AND sigit_t_comp4.progressivo::numeric(2) = sigit_t_comp_ag.progressivo::numeric(2) AND sigit_t_comp4.id_tipo_componente::text = sigit_t_comp_ag.id_tipo_componente::text AND sigit_t_comp4.codice_impianto = sigit_t_comp_ag.codice_impianto
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp4.fk_combustibile = sigit_d_combustibile.id_combustibile
   LEFT JOIN sigit_d_marca ON sigit_t_comp4.fk_marca = sigit_d_marca.id_marca;

CREATE OR REPLACE VIEW vista_comp_cg_dett AS 
 SELECT sigit_t_comp4.codice_impianto, sigit_t_comp4.id_tipo_componente, 
    sigit_t_comp4.progressivo, sigit_t_comp4.data_install, 
    sigit_t_comp4.data_dismiss, sigit_t_comp4.matricola, 
    sigit_t_comp4.fk_combustibile, sigit_d_combustibile.des_combustibile, 
    sigit_t_comp4.fk_marca, sigit_d_marca.des_marca, sigit_t_comp4.modello, 
    sigit_t_comp4.potenza_termica_kw, sigit_t_comp4.data_ult_mod, 
    sigit_t_comp4.utente_ult_mod, sigit_t_comp_cg.tipologia, 
    sigit_t_comp_cg.potenza_elettrica_kw, sigit_t_comp_cg.temp_h2o_out_min, 
    sigit_t_comp_cg.temp_h2o_out_max, sigit_t_comp_cg.temp_h2o_in_min, 
    sigit_t_comp_cg.temp_h2o_in_max, sigit_t_comp_cg.temp_h2o_motore_min, 
    sigit_t_comp_cg.temp_h2o_motore_max, sigit_t_comp_cg.temp_fumi_valle_min, 
    sigit_t_comp_cg.temp_fumi_valle_max, sigit_t_comp_cg.temp_fumi_monte_min, 
    sigit_t_comp_cg.temp_fumi_monte_max, sigit_t_comp_cg.co_min, 
    sigit_t_comp_cg.co_max, sigit_t_dett_tipo4.id_dett_tipo4, 
    sigit_t_dett_tipo4.fk_allegato, sigit_t_dett_tipo4.fk_fluido, 
    sigit_t_dett_tipo4.e_potenza_assorb_comb_kw, 
    sigit_t_dett_tipo4.e_potenza_term_bypass_kw, 
    sigit_t_dett_tipo4.e_temp_aria_c, sigit_t_dett_tipo4.e_temp_h2o_out_c, 
    sigit_t_dett_tipo4.e_temp_h2o_in_c, 
    sigit_t_dett_tipo4.e_potenza_morsetti_kw, 
    sigit_t_dett_tipo4.e_temp_h2o_motore_c, 
    sigit_t_dett_tipo4.e_temp_fumi_valle_c, 
    sigit_t_dett_tipo4.e_temp_fumi_monte_c, 
    sigit_t_dett_tipo4.data_ult_mod AS data_ult_mod_dett, 
    sigit_t_dett_tipo4.utente_ult_mod AS utente_ult_mod_dett, 
    sigit_t_allegato.data_controllo, sigit_t_comp4.flg_dismissione, 
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
    sigit_t_persona_giuridica.sigla_rea, sigit_t_persona_giuridica.numero_rea
   FROM sigit_t_comp4
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp4.fk_combustibile = sigit_d_combustibile.id_combustibile
   LEFT JOIN sigit_d_marca ON sigit_t_comp4.fk_marca = sigit_d_marca.id_marca
   JOIN sigit_t_comp_cg ON sigit_t_comp4.data_install = sigit_t_comp_cg.data_install AND sigit_t_comp4.progressivo::numeric(2) = sigit_t_comp_cg.progressivo::numeric(2) AND sigit_t_comp4.id_tipo_componente::text = sigit_t_comp_cg.id_tipo_componente::text AND sigit_t_comp4.codice_impianto = sigit_t_comp_cg.codice_impianto
   LEFT JOIN sigit_t_dett_tipo4 ON sigit_t_comp_cg.progressivo::numeric(2) = sigit_t_dett_tipo4.progressivo::numeric(2) AND sigit_t_comp_cg.data_install = sigit_t_dett_tipo4.data_install AND sigit_t_comp_cg.id_tipo_componente::text = sigit_t_dett_tipo4.fk_tipo_componente::text AND sigit_t_comp_cg.codice_impianto = sigit_t_dett_tipo4.codice_impianto
   LEFT JOIN sigit_t_allegato ON sigit_t_dett_tipo4.fk_allegato = sigit_t_allegato.id_allegato
   LEFT JOIN sigit_r_imp_ruolo_pfpg ON sigit_t_allegato.fk_imp_ruolo_pfpg = sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg
   LEFT JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica;


CREATE OR REPLACE VIEW vista_comp_ci AS 
 SELECT sigit_t_comp_x.codice_impianto, sigit_t_comp_x.id_tipo_componente, 
    sigit_t_comp_x.progressivo, sigit_t_comp_x.data_install, 
    sigit_t_comp_x.data_dismiss, sigit_t_comp_x.matricola, 
    sigit_t_comp_x.fk_marca, sigit_d_marca.des_marca, sigit_t_comp_x.modello, 
    sigit_t_comp_x.data_ult_mod, sigit_t_comp_x.utente_ult_mod, 
    sigit_t_comp_ci.lunghezza_circ_m, sigit_t_comp_ci.superf_scamb_m2, 
    sigit_t_comp_ci.prof_install_m
   FROM sigit_t_comp_x
   JOIN sigit_t_comp_ci ON sigit_t_comp_x.data_install = sigit_t_comp_ci.data_install AND sigit_t_comp_x.progressivo::numeric(2) = sigit_t_comp_ci.progressivo::numeric(2) AND sigit_t_comp_x.id_tipo_componente::text = sigit_t_comp_ci.id_tipo_componente::text AND sigit_t_comp_x.codice_impianto = sigit_t_comp_ci.codice_impianto
   LEFT JOIN sigit_d_marca ON sigit_t_comp_x.fk_marca = sigit_d_marca.id_marca;


CREATE OR REPLACE VIEW vista_comp_cs AS 
 SELECT sigit_t_comp4.codice_impianto, sigit_t_comp4.id_tipo_componente, 
    sigit_t_comp4.progressivo, sigit_t_comp4.data_install, 
    sigit_t_comp4.data_dismiss, sigit_t_comp4.matricola, 
    sigit_t_comp4.fk_combustibile, sigit_d_combustibile.des_combustibile, 
    sigit_t_comp4.fk_marca, sigit_d_marca.des_marca, sigit_t_comp4.modello, 
    sigit_t_comp4.potenza_termica_kw, sigit_t_comp4.data_ult_mod, 
    sigit_t_comp4.utente_ult_mod, sigit_t_comp_cs.num_collettori, 
    sigit_t_comp_cs.sup_apertura, sigit_t_comp4.flg_dismissione
   FROM sigit_t_comp4
   JOIN sigit_t_comp_cs ON sigit_t_comp4.data_install = sigit_t_comp_cs.data_install AND sigit_t_comp4.progressivo::numeric(2) = sigit_t_comp_cs.progressivo::numeric(2) AND sigit_t_comp4.id_tipo_componente::text = sigit_t_comp_cs.id_tipo_componente::text AND sigit_t_comp4.codice_impianto = sigit_t_comp_cs.codice_impianto
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp4.fk_combustibile = sigit_d_combustibile.id_combustibile
   LEFT JOIN sigit_d_marca ON sigit_t_comp4.fk_marca = sigit_d_marca.id_marca;
   
   
CREATE OR REPLACE VIEW vista_comp_gf_dett AS 
 SELECT sigit_t_comp4.codice_impianto, sigit_t_comp4.id_tipo_componente, 
    sigit_t_comp4.progressivo, sigit_t_comp4.data_install, 
    sigit_t_comp4.data_dismiss, sigit_t_comp4.matricola, 
    sigit_t_comp4.fk_combustibile, sigit_d_combustibile.des_combustibile, 
    sigit_t_comp4.fk_marca, sigit_d_marca.des_marca, sigit_t_comp4.modello, 
    sigit_t_comp4.potenza_termica_kw, sigit_t_comp4.data_ult_mod, 
    sigit_t_comp4.utente_ult_mod, sigit_t_comp_gf.fk_dettaglio_gf, 
    sigit_t_comp_gf.flg_sorgente_ext, sigit_t_comp_gf.flg_fluido_utenze, 
    sigit_t_comp_gf.fluido_frigorigeno, sigit_t_comp_gf.n_circuiti, 
    sigit_t_comp_gf.raffrescamento_eer, sigit_t_comp_gf.raff_potenza_kw, 
    sigit_t_comp_gf.raff_potenza_ass, sigit_t_comp_gf.riscaldamento_cop, 
    sigit_t_comp_gf.risc_potenza_kw, sigit_t_comp_gf.risc_potenza_ass_kw, 
    sigit_t_dett_tipo2.id_dett_tipo2, sigit_t_dett_tipo2.fk_allegato, 
    sigit_t_dett_tipo2.e_n_circuito, sigit_t_dett_tipo2.e_flg_mod_prova, 
    sigit_t_dett_tipo2.e_flg_perdita_gas, 
    sigit_t_dett_tipo2.e_flg_leak_detector, 
    sigit_t_dett_tipo2.e_flg_param_termodinam, 
    sigit_t_dett_tipo2.e_flg_incrostazioni, sigit_t_dett_tipo2.e_t_surrisc_c, 
    sigit_t_dett_tipo2.e_t_sottoraf_c, sigit_t_dett_tipo2.e_t_condensazione_c, 
    sigit_t_dett_tipo2.e_t_evaporazione_c, sigit_t_dett_tipo2.e_t_in_ext_c, 
    sigit_t_dett_tipo2.e_t_out_ext_c, sigit_t_dett_tipo2.e_t_in_utenze_c, 
    sigit_t_dett_tipo2.e_t_out_utenze_c, 
    sigit_t_dett_tipo2.data_ult_mod AS data_ult_mod_dett, 
    sigit_t_dett_tipo2.utente_ult_mod AS utente_ult_mod_dett, 
    sigit_t_allegato.data_controllo, sigit_t_comp4.flg_dismissione, 
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
    sigit_t_persona_giuridica.sigla_rea, sigit_t_persona_giuridica.numero_rea
   FROM sigit_t_comp4
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp4.fk_combustibile = sigit_d_combustibile.id_combustibile
   LEFT JOIN sigit_d_marca ON sigit_t_comp4.fk_marca = sigit_d_marca.id_marca
   JOIN sigit_t_comp_gf ON sigit_t_comp4.data_install = sigit_t_comp_gf.data_install AND sigit_t_comp4.progressivo::numeric(2) = sigit_t_comp_gf.progressivo::numeric(2) AND sigit_t_comp4.id_tipo_componente::text = sigit_t_comp_gf.id_tipo_componente::text AND sigit_t_comp4.codice_impianto = sigit_t_comp_gf.codice_impianto
   LEFT JOIN sigit_t_dett_tipo2 ON sigit_t_comp_gf.progressivo::numeric(2) = sigit_t_dett_tipo2.progressivo::numeric(2) AND sigit_t_comp_gf.data_install = sigit_t_dett_tipo2.data_install AND sigit_t_comp_gf.id_tipo_componente::text = sigit_t_dett_tipo2.fk_tipo_componente::text AND sigit_t_comp_gf.codice_impianto = sigit_t_dett_tipo2.codice_impianto
   LEFT JOIN sigit_t_allegato ON sigit_t_dett_tipo2.fk_allegato = sigit_t_allegato.id_allegato
   LEFT JOIN sigit_r_imp_ruolo_pfpg ON sigit_t_allegato.fk_imp_ruolo_pfpg = sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg
   LEFT JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica;

 CREATE OR REPLACE VIEW vista_comp_gt_dett AS 
 SELECT sigit_t_comp4.codice_impianto, sigit_t_comp4.id_tipo_componente, 
    sigit_t_comp4.progressivo, sigit_t_comp4.data_install, 
    sigit_t_comp4.data_dismiss, sigit_t_comp4.matricola, sigit_t_comp4.modello, 
    sigit_t_comp4.fk_combustibile, sigit_d_combustibile.des_combustibile, 
    sigit_t_comp4.fk_marca, sigit_d_marca.des_marca, 
    sigit_t_comp4.potenza_termica_kw, sigit_t_comp4.data_ult_mod, 
    sigit_t_comp4.utente_ult_mod, sigit_t_comp_gt.fk_fluido, 
    sigit_t_comp_gt.fk_dettaglio_gt, sigit_t_comp_gt.rendimento_perc, 
    sigit_t_comp_gt.n_moduli, sigit_t_dett_tipo1.id_dett_tipo1, 
    sigit_t_dett_tipo1.fk_allegato, sigit_t_dett_tipo1.e_n_modulo_termico, 
    sigit_t_dett_tipo1.e_pot_term_focol_kw, 
    sigit_t_dett_tipo1.e_flg_clima_inverno, sigit_t_dett_tipo1.e_flg_produz_acs, 
    sigit_t_dett_tipo1.e_flg_dispos_comando, 
    sigit_t_dett_tipo1.e_flg_dispos_sicurezza, 
    sigit_t_dett_tipo1.e_flg_valvola_sicurezza, 
    sigit_t_dett_tipo1.e_flg_scambiatore_fumi, 
    sigit_t_dett_tipo1.e_flg_riflusso, sigit_t_dett_tipo1.e_flg_uni_10389_1, 
    sigit_t_dett_tipo1.e_flg_evacu_fumi, 
    sigit_t_dett_tipo1.e_depr_canale_fumo_pa, sigit_t_dett_tipo1.e_temp_fumi_c, 
    sigit_t_dett_tipo1.e_temp_aria_c, sigit_t_dett_tipo1.e_o2_perc, 
    sigit_t_dett_tipo1.e_co2_perc, sigit_t_dett_tipo1.e_bacharach_min, 
    sigit_t_dett_tipo1.e_bacharach_med, sigit_t_dett_tipo1.e_bacharach_max, 
    sigit_t_dett_tipo1.e_co_corretto_ppm, sigit_t_dett_tipo1.e_rend_comb_perc, 
    sigit_t_dett_tipo1.e_rend_min_legge_perc, sigit_t_dett_tipo1.e_nox_ppm, 
    sigit_t_dett_tipo1.data_ult_mod AS data_ult_mod_dett, 
    sigit_t_dett_tipo1.utente_ult_mod AS utente_ult_mod_dett, 
    sigit_t_allegato.data_controllo, sigit_t_comp4.flg_dismissione, 
    sigit_t_dett_tipo1.l11_1_portata_combustibile, 
    sigit_t_dett_tipo1.l11_1_portata_combustibile_um, 
    sigit_t_dett_tipo1.l11_1_altro_riferimento, 
    sigit_t_dett_tipo1.l11_1_co_no_aria_ppm, 
    sigit_t_dett_tipo1.l11_1_flg_rispetta_bacharach, 
    sigit_t_dett_tipo1.l11_1_flg_co_min_1000, 
    sigit_t_dett_tipo1.l11_1_flg_rend_mag_rend_min, 
    sigit_t_persona_giuridica.sigla_rea, sigit_t_persona_giuridica.numero_rea
   FROM sigit_t_comp4
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp4.fk_combustibile = sigit_d_combustibile.id_combustibile
   LEFT JOIN sigit_d_marca ON sigit_t_comp4.fk_marca = sigit_d_marca.id_marca
   JOIN sigit_t_comp_gt ON sigit_t_comp4.data_install = sigit_t_comp_gt.data_install AND sigit_t_comp4.progressivo::numeric(2) = sigit_t_comp_gt.progressivo::numeric(2) AND sigit_t_comp4.id_tipo_componente::text = sigit_t_comp_gt.id_tipo_componente::text AND sigit_t_comp4.codice_impianto = sigit_t_comp_gt.codice_impianto
   LEFT JOIN sigit_t_dett_tipo1 ON sigit_t_comp_gt.progressivo::numeric(2) = sigit_t_dett_tipo1.progressivo::numeric(2) AND sigit_t_comp_gt.data_install = sigit_t_dett_tipo1.data_install AND sigit_t_comp_gt.id_tipo_componente::text = sigit_t_dett_tipo1.fk_tipo_componente::text AND sigit_t_comp_gt.codice_impianto = sigit_t_dett_tipo1.codice_impianto
   LEFT JOIN sigit_t_allegato ON sigit_t_dett_tipo1.fk_allegato = sigit_t_allegato.id_allegato
   LEFT JOIN sigit_r_imp_ruolo_pfpg ON sigit_t_allegato.fk_imp_ruolo_pfpg = sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg
   LEFT JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica;

CREATE OR REPLACE VIEW vista_comp_po AS 
 SELECT sigit_t_comp_x.codice_impianto, sigit_t_comp_x.id_tipo_componente, 
    sigit_t_comp_x.progressivo, sigit_t_comp_x.data_install, 
    sigit_t_comp_x.data_dismiss, sigit_t_comp_x.matricola, 
    sigit_t_comp_x.fk_marca, sigit_d_marca.des_marca, sigit_t_comp_x.modello, 
    sigit_t_comp_x.data_ult_mod, sigit_t_comp_x.utente_ult_mod, 
    sigit_t_comp_po.flg_giri_variabili, sigit_t_comp_po.pot_nominale_kw
   FROM sigit_t_comp_x
   JOIN sigit_t_comp_po ON sigit_t_comp_x.data_install = sigit_t_comp_po.data_install AND sigit_t_comp_x.progressivo::numeric(2) = sigit_t_comp_po.progressivo::numeric(2) AND sigit_t_comp_x.id_tipo_componente::text = sigit_t_comp_po.id_tipo_componente::text AND sigit_t_comp_x.codice_impianto = sigit_t_comp_po.codice_impianto
   LEFT JOIN sigit_d_marca ON sigit_t_comp_x.fk_marca = sigit_d_marca.id_marca;


CREATE OR REPLACE VIEW vista_comp_rc AS 
 SELECT sigit_t_comp_x.codice_impianto, sigit_t_comp_x.id_tipo_componente, 
    sigit_t_comp_x.progressivo, sigit_t_comp_x.data_install, 
    sigit_t_comp_x.data_dismiss, sigit_t_comp_x.matricola, 
    sigit_t_comp_x.fk_marca, sigit_d_marca.des_marca, sigit_t_comp_x.modello, 
    sigit_t_comp_x.data_ult_mod, sigit_t_comp_x.utente_ult_mod, 
    sigit_t_comp_rc.tipologia, sigit_t_comp_rc.flg_installato, 
    sigit_t_comp_rc.flg_indipendente, sigit_t_comp_rc.portata_mandata_ls, 
    sigit_t_comp_rc.portata_ripresa_ls, sigit_t_comp_rc.potenza_mandata_kw, 
    sigit_t_comp_rc.potenza_ripresa_kw
   FROM sigit_t_comp_x
   JOIN sigit_t_comp_rc ON sigit_t_comp_x.data_install = sigit_t_comp_rc.data_install AND sigit_t_comp_x.progressivo::numeric(2) = sigit_t_comp_rc.progressivo::numeric(2) AND sigit_t_comp_x.id_tipo_componente::text = sigit_t_comp_rc.id_tipo_componente::text AND sigit_t_comp_x.codice_impianto = sigit_t_comp_rc.codice_impianto
   LEFT JOIN sigit_d_marca ON sigit_t_comp_x.fk_marca = sigit_d_marca.id_marca;

CREATE OR REPLACE VIEW vista_comp_rv AS 
 SELECT sigit_t_comp_x.codice_impianto, sigit_t_comp_x.id_tipo_componente, 
    sigit_t_comp_x.progressivo, sigit_t_comp_x.data_install, 
    sigit_t_comp_x.data_dismiss, sigit_t_comp_x.matricola, 
    sigit_t_comp_x.fk_marca, sigit_d_marca.des_marca, sigit_t_comp_x.modello, 
    sigit_t_comp_x.data_ult_mod, sigit_t_comp_x.utente_ult_mod, 
    sigit_t_comp_rv.num_ventilatori, sigit_t_comp_rv.tipo_ventilatori
   FROM sigit_t_comp_x
   JOIN sigit_t_comp_rv ON sigit_t_comp_x.data_install = sigit_t_comp_rv.data_install AND sigit_t_comp_x.progressivo::numeric(2) = sigit_t_comp_rv.progressivo::numeric(2) AND sigit_t_comp_x.id_tipo_componente::text = sigit_t_comp_rv.id_tipo_componente::text AND sigit_t_comp_x.codice_impianto = sigit_t_comp_rv.codice_impianto
   LEFT JOIN sigit_d_marca ON sigit_t_comp_x.fk_marca = sigit_d_marca.id_marca;

CREATE OR REPLACE VIEW vista_comp_sc_dett AS 
 SELECT sigit_t_comp4.codice_impianto, sigit_t_comp4.id_tipo_componente, 
    sigit_t_comp4.progressivo, sigit_t_comp4.data_install, 
    sigit_t_comp4.data_dismiss, sigit_t_comp4.matricola, 
    sigit_t_comp4.fk_combustibile, sigit_d_combustibile.des_combustibile, 
    sigit_t_comp4.fk_marca, sigit_d_marca.des_marca, sigit_t_comp4.modello, 
    sigit_t_comp4.potenza_termica_kw, sigit_t_comp4.data_ult_mod, 
    sigit_t_comp4.utente_ult_mod, sigit_t_dett_tipo3.id_dett_tipo3, 
    sigit_t_dett_tipo3.fk_allegato, sigit_t_dett_tipo3.fk_fluido, 
    sigit_t_dett_tipo3.fk_fluido_alimentaz, sigit_t_dett_tipo3.e_fluido_altro, 
    sigit_t_dett_tipo3.e_alimentazione_altro, 
    sigit_t_dett_tipo3.e_flg_clima_inverno, sigit_t_dett_tipo3.e_flg_produz_acs, 
    sigit_t_dett_tipo3.e_flg_potenza_compatibile, 
    sigit_t_dett_tipo3.e_flg_coib_idonea, 
    sigit_t_dett_tipo3.e_flg_disp_funzionanti, sigit_t_dett_tipo3.e_temp_ext_c, 
    sigit_t_dett_tipo3.e_temp_mand_primario_c, 
    sigit_t_dett_tipo3.e_temp_ritor_primario_c, 
    sigit_t_dett_tipo3.e_temp_mand_secondario_c, 
    sigit_t_dett_tipo3.e_temp_rit_secondario_c, 
    sigit_t_dett_tipo3.e_potenza_term_kw, sigit_t_dett_tipo3.e_port_fluido_m3_h, 
    sigit_t_dett_tipo3.data_ult_mod AS data_ult_mod_dett, 
    sigit_t_dett_tipo3.utente_ult_mod AS utente_ult_mod_dett, 
    sigit_t_allegato.data_controllo, sigit_t_comp4.flg_dismissione, 
    sigit_t_persona_giuridica.sigla_rea, sigit_t_persona_giuridica.numero_rea
   FROM sigit_t_comp4
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp4.fk_combustibile = sigit_d_combustibile.id_combustibile
   LEFT JOIN sigit_d_marca ON sigit_t_comp4.fk_marca = sigit_d_marca.id_marca
   JOIN sigit_t_comp_sc ON sigit_t_comp4.data_install = sigit_t_comp_sc.data_install AND sigit_t_comp4.progressivo::numeric(2) = sigit_t_comp_sc.progressivo::numeric(2) AND sigit_t_comp4.id_tipo_componente::text = sigit_t_comp_sc.id_tipo_componente::text AND sigit_t_comp4.codice_impianto = sigit_t_comp_sc.codice_impianto
   LEFT JOIN sigit_t_dett_tipo3 ON sigit_t_comp_sc.progressivo::numeric(2) = sigit_t_dett_tipo3.progressivo::numeric(2) AND sigit_t_comp_sc.data_install = sigit_t_dett_tipo3.data_install AND sigit_t_comp_sc.id_tipo_componente::text = sigit_t_dett_tipo3.fk_tipo_componente::text AND sigit_t_comp_sc.codice_impianto = sigit_t_dett_tipo3.codice_impianto
   LEFT JOIN sigit_t_allegato ON sigit_t_dett_tipo3.fk_allegato = sigit_t_allegato.id_allegato
   LEFT JOIN sigit_r_imp_ruolo_pfpg ON sigit_t_allegato.fk_imp_ruolo_pfpg = sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg
   LEFT JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica;

CREATE OR REPLACE VIEW vista_comp_scx AS 
 SELECT sigit_t_comp_x.codice_impianto, sigit_t_comp_x.id_tipo_componente, 
    sigit_t_comp_x.progressivo, sigit_t_comp_x.data_install, 
    sigit_t_comp_x.data_dismiss, sigit_t_comp_x.matricola, 
    sigit_t_comp_x.fk_marca, sigit_d_marca.des_marca, sigit_t_comp_x.modello, 
    sigit_t_comp_x.data_ult_mod, sigit_t_comp_x.utente_ult_mod
   FROM sigit_t_comp_x
   JOIN sigit_t_comp_scx ON sigit_t_comp_x.data_install = sigit_t_comp_scx.data_install AND sigit_t_comp_x.progressivo::numeric(2) = sigit_t_comp_scx.progressivo::numeric(2) AND sigit_t_comp_x.id_tipo_componente::text = sigit_t_comp_scx.id_tipo_componente::text AND sigit_t_comp_x.codice_impianto = sigit_t_comp_scx.codice_impianto
   LEFT JOIN sigit_d_marca ON sigit_t_comp_x.fk_marca = sigit_d_marca.id_marca;


CREATE OR REPLACE VIEW vista_comp_sr AS 
 SELECT sigit_t_comp_x.codice_impianto, sigit_t_comp_x.id_tipo_componente, 
    sigit_t_comp_x.progressivo, sigit_t_comp_x.data_install, 
    sigit_t_comp_x.data_dismiss, sigit_t_comp_x.matricola, 
    sigit_t_comp_x.fk_marca, sigit_d_marca.des_marca, sigit_t_comp_x.modello, 
    sigit_t_comp_x.data_ult_mod, sigit_t_comp_x.utente_ult_mod, 
    sigit_t_comp_sr.num_pti_regolazione, sigit_t_comp_sr.num_liv_temp
   FROM sigit_t_comp_x
   JOIN sigit_t_comp_sr ON sigit_t_comp_x.data_install = sigit_t_comp_sr.data_install AND sigit_t_comp_x.progressivo::numeric(2) = sigit_t_comp_sr.progressivo::numeric(2) AND sigit_t_comp_x.id_tipo_componente::text = sigit_t_comp_sr.id_tipo_componente::text AND sigit_t_comp_x.codice_impianto = sigit_t_comp_sr.codice_impianto
   LEFT JOIN sigit_d_marca ON sigit_t_comp_x.fk_marca = sigit_d_marca.id_marca;

CREATE OR REPLACE VIEW vista_comp_te AS 
 SELECT sigit_t_comp_x.codice_impianto, sigit_t_comp_x.id_tipo_componente, 
    sigit_t_comp_x.progressivo, sigit_t_comp_x.data_install, 
    sigit_t_comp_x.data_dismiss, sigit_t_comp_x.matricola, 
    sigit_t_comp_x.fk_marca, sigit_d_marca.des_marca, sigit_t_comp_x.modello, 
    sigit_t_comp_x.data_ult_mod, sigit_t_comp_x.utente_ult_mod, 
    sigit_t_comp_te.capacita_l, sigit_t_comp_te.num_ventilatori, 
    sigit_t_comp_te.tipo_ventilatori
   FROM sigit_t_comp_x
   JOIN sigit_t_comp_te ON sigit_t_comp_x.data_install = sigit_t_comp_te.data_install AND sigit_t_comp_x.progressivo::numeric(2) = sigit_t_comp_te.progressivo::numeric(2) AND sigit_t_comp_x.id_tipo_componente::text = sigit_t_comp_te.id_tipo_componente::text AND sigit_t_comp_x.codice_impianto = sigit_t_comp_te.codice_impianto
   LEFT JOIN sigit_d_marca ON sigit_t_comp_x.fk_marca = sigit_d_marca.id_marca;


CREATE OR REPLACE VIEW vista_comp_ut AS 
 SELECT sigit_t_comp_x.codice_impianto, sigit_t_comp_x.id_tipo_componente, 
    sigit_t_comp_x.progressivo, sigit_t_comp_x.data_install, 
    sigit_t_comp_x.data_dismiss, sigit_t_comp_x.matricola, 
    sigit_t_comp_x.fk_marca, sigit_d_marca.des_marca, sigit_t_comp_x.modello, 
    sigit_t_comp_x.data_ult_mod, sigit_t_comp_x.utente_ult_mod, 
    sigit_t_comp_ut.portata_mandata_ls, sigit_t_comp_ut.portata_ripresa_ls, 
    sigit_t_comp_ut.potenza_mandata_kw, sigit_t_comp_ut.potenza_ripresa_kw
   FROM sigit_t_comp_x
   JOIN sigit_t_comp_ut ON sigit_t_comp_x.data_install = sigit_t_comp_ut.data_install AND sigit_t_comp_x.progressivo::numeric(2) = sigit_t_comp_ut.progressivo::numeric(2) AND sigit_t_comp_x.id_tipo_componente::text = sigit_t_comp_ut.id_tipo_componente::text AND sigit_t_comp_x.codice_impianto = sigit_t_comp_ut.codice_impianto
   LEFT JOIN sigit_d_marca ON sigit_t_comp_x.fk_marca = sigit_d_marca.id_marca;

CREATE OR REPLACE VIEW vista_comp_vm AS 
 SELECT sigit_t_comp_x.codice_impianto, sigit_t_comp_x.id_tipo_componente, 
    sigit_t_comp_x.progressivo, sigit_t_comp_x.data_install, 
    sigit_t_comp_x.data_dismiss, sigit_t_comp_x.matricola, 
    sigit_t_comp_x.fk_marca, sigit_d_marca.des_marca, sigit_t_comp_x.modello, 
    sigit_t_comp_x.data_ult_mod, sigit_t_comp_x.utente_ult_mod, 
    sigit_t_comp_vm.fk_dettaglio_vm, sigit_d_dettaglio_vm.des_dettaglio_vm, 
    sigit_t_comp_vm.altro_tipologia, sigit_t_comp_vm.portata_max_aria_m3h, 
    sigit_t_comp_vm.rendimento_cop
   FROM sigit_t_comp_x
   JOIN sigit_t_comp_vm ON sigit_t_comp_x.data_install = sigit_t_comp_vm.data_install AND sigit_t_comp_x.progressivo::numeric(2) = sigit_t_comp_vm.progressivo::numeric(2) AND sigit_t_comp_x.id_tipo_componente::text = sigit_t_comp_vm.id_tipo_componente::text AND sigit_t_comp_x.codice_impianto = sigit_t_comp_vm.codice_impianto
   LEFT JOIN sigit_d_marca ON sigit_t_comp_x.fk_marca = sigit_d_marca.id_marca
   LEFT JOIN sigit_d_dettaglio_vm ON sigit_t_comp_vm.fk_dettaglio_vm = sigit_d_dettaglio_vm.id_dettaglio_vm;

CREATE OR REPLACE VIEW vista_comp_vr AS 
 SELECT sigit_t_comp_x.codice_impianto, sigit_t_comp_x.id_tipo_componente, 
    sigit_t_comp_x.progressivo, sigit_t_comp_x.data_install, 
    sigit_t_comp_x.data_dismiss, sigit_t_comp_x.matricola, 
    sigit_t_comp_x.fk_marca, sigit_d_marca.des_marca, sigit_t_comp_x.modello, 
    sigit_t_comp_x.data_ult_mod, sigit_t_comp_x.utente_ult_mod, 
    sigit_t_comp_vr.num_vie, sigit_t_comp_vr.servomotore
   FROM sigit_t_comp_x
   JOIN sigit_t_comp_vr ON sigit_t_comp_x.data_install = sigit_t_comp_vr.data_install AND sigit_t_comp_x.progressivo::numeric(2) = sigit_t_comp_vr.progressivo::numeric(2) AND sigit_t_comp_x.id_tipo_componente::text = sigit_t_comp_vr.id_tipo_componente::text AND sigit_t_comp_x.codice_impianto = sigit_t_comp_vr.codice_impianto
   LEFT JOIN sigit_d_marca ON sigit_t_comp_x.fk_marca = sigit_d_marca.id_marca;

CREATE OR REPLACE VIEW vista_pf_pg AS 
         SELECT sigit_t_persona_giuridica.id_persona_giuridica AS id_persona, 
            'PG'::character varying(2) AS pf_pg, 
            NULL::character varying(100) AS nome, 
            sigit_t_persona_giuridica.sigla_rea, 
            sigit_t_persona_giuridica.numero_rea, 
            sigit_t_persona_giuridica.denominazione, 
            sigit_t_persona_giuridica.codice_fiscale, 
            sigit_t_persona_giuridica.fk_l2, 
            sigit_t_persona_giuridica.indirizzo_sitad, 
            sigit_t_persona_giuridica.indirizzo_non_trovato, 
            sigit_t_persona_giuridica.sigla_prov, 
            sigit_t_persona_giuridica.istat_comune, 
            sigit_t_persona_giuridica.comune, 
            sigit_t_persona_giuridica.provincia, 
            sigit_t_persona_giuridica.civico, sigit_t_persona_giuridica.cap, 
            sigit_t_persona_giuridica.email, 
            sigit_t_persona_giuridica.data_inizio_attivita, 
            sigit_t_persona_giuridica.data_cessazione
           FROM sigit_t_persona_giuridica
UNION 
         SELECT sigit_t_persona_fisica.id_persona_fisica AS id_persona, 
            'PF'::character varying(2) AS pf_pg, sigit_t_persona_fisica.nome, 
            NULL::character varying(2) AS sigla_rea, 
            NULL::numeric(11,0) AS numero_rea, 
            sigit_t_persona_fisica.cognome::character varying(500) AS denominazione, 
            sigit_t_persona_fisica.codice_fiscale, sigit_t_persona_fisica.fk_l2, 
            sigit_t_persona_fisica.indirizzo_sitad, 
            sigit_t_persona_fisica.indirizzo_non_trovato, 
            sigit_t_persona_fisica.sigla_prov, 
            sigit_t_persona_fisica.istat_comune, sigit_t_persona_fisica.comune, 
            sigit_t_persona_fisica.provincia, sigit_t_persona_fisica.civico, 
            sigit_t_persona_fisica.cap, sigit_t_persona_fisica.email, 
            NULL::date AS data_inizio_attivita, NULL::date AS data_cessazione
           FROM sigit_t_persona_fisica;
           
CREATE OR REPLACE VIEW vista_potenza_prezzo AS 
 SELECT sigit_d_potenza_imp.id_potenza, sigit_d_potenza_imp.des_potenza, 
    sigit_d_potenza_imp.limite_inferiore, sigit_d_potenza_imp.limite_superiore, 
    sigit_d_prezzo_potenza.id_prezzo, sigit_d_prezzo_potenza.prezzo, 
    sigit_r_potenza_prezzo.dt_inizio_acquisto AS dt_inizio, 
    sigit_r_potenza_prezzo.dt_fine_acquisto AS dt_fine
   FROM sigit_d_potenza_imp, sigit_r_potenza_prezzo, sigit_d_prezzo_potenza
  WHERE sigit_r_potenza_prezzo.id_potenza = sigit_d_potenza_imp.id_potenza AND sigit_r_potenza_prezzo.id_prezzo = sigit_d_prezzo_potenza.id_prezzo AND (now() >= sigit_r_potenza_prezzo.dt_inizio_acquisto AND now() <= sigit_r_potenza_prezzo.dt_fine_acquisto OR sigit_r_potenza_prezzo.dt_inizio_acquisto <= now() AND sigit_r_potenza_prezzo.dt_fine_acquisto IS NULL);

CREATE OR REPLACE VIEW vista_ricerca_allegati AS 
         SELECT a.id_allegato, a.fk_stato_rapp, srapp.des_stato_rapp, 
            a.fk_imp_ruolo_pfpg, a.fk_tipo_documento, doc.des_tipo_documento, 
            a.fk_sigla_bollino, a.fk_numero_bollino, a.data_controllo, 
            a.b_flg_libretto_uso, a.b_flg_dichiar_conform, a.b_flg_lib_imp, 
            a.b_flg_lib_compl, a.f_osservazioni, a.f_raccomandazioni, 
            a.f_prescrizioni, a.f_flg_puo_funzionare, a.f_intervento_entro, 
            a.f_ora_arrivo, a.f_ora_partenza, a.f_denominaz_tecnico, 
            a.f_flg_firma_tecnico, a.f_flg_firma_responsabile, a.data_invio, 
            NULL::date AS data_respinta, a.xml_allegato, a.nome_allegato, 
            a.a_potenza_termica_nominale_max, a.data_ult_mod, a.utente_ult_mod, 
            ru.des_ruolo, ru.ruolo_funz, pf.nome AS pf_nome, 
            pf.cognome AS pf_cognome, pf.codice_fiscale AS pf_codice_fiscale, 
            pg.denominazione AS pg_denominazione, 
            pg.codice_fiscale AS pg_codice_fiscale, 
            pg.sigla_rea AS pg_sigla_rea, pg.numero_rea AS pg_numero_rea, 
            r1.codice_impianto, i.denominazione_comune AS comune_impianto, 
            i.sigla_provincia AS sigla_prov_impianto, 
            COALESCE(u.indirizzo_sitad, u.indirizzo_non_trovato) AS indirizzo_unita_immob, 
            u.civico AS civico_unita_immob, a.flg_controllo_bozza
           FROM sigit_t_allegato a
      JOIN sigit_r_imp_ruolo_pfpg r1 ON a.fk_imp_ruolo_pfpg = r1.id_imp_ruolo_pfpg
   JOIN sigit_d_ruolo ru ON r1.fk_ruolo = ru.id_ruolo
   JOIN sigit_d_tipo_documento doc ON a.fk_tipo_documento = doc.id_tipo_documento
   JOIN sigit_d_stato_rapp srapp ON a.fk_stato_rapp = srapp.id_stato_rapp
   LEFT JOIN sigit_t_persona_fisica pf ON r1.fk_persona_fisica = pf.id_persona_fisica
   LEFT JOIN sigit_t_persona_giuridica pg ON r1.fk_persona_giuridica = pg.id_persona_giuridica
   LEFT JOIN sigit_t_impianto i ON r1.codice_impianto = i.codice_impianto
   LEFT JOIN sigit_t_unita_immobiliare u ON r1.codice_impianto = u.codice_impianto
  WHERE u.flg_principale = 1::numeric
UNION 
         SELECT a.id_allegato, 2::numeric(2,0) AS fk_stato_rapp, 
            'Respinto'::character varying(100) AS des_stato_rapp, 
            a.id_imp_ruolo_pfpg AS fk_imp_ruolo_pfpg, a.fk_tipo_documento, 
            doc.des_tipo_documento, a.sigla_bollino AS fk_sigla_bollino, 
            a.numero_bollino AS fk_numero_bollino, a.data_controllo, 
            NULL::numeric(1,0) AS b_flg_libretto_uso, 
            NULL::numeric(1,0) AS b_flg_dichiar_conform, 
            NULL::numeric(1,0) AS b_flg_lib_imp, 
            NULL::numeric(1,0) AS b_flg_lib_compl, a.f_osservazioni, 
            a.f_raccomandazioni, a.f_prescrizioni, 
            NULL::numeric(1,0) AS f_flg_puo_funzionare, a.f_intervento_entro, 
            NULL::character varying(10) AS f_ora_arrivo, 
            NULL::character varying(10) AS f_ora_partenza, 
            NULL::character varying(100) AS f_denominaz_tecnico, 
            NULL::numeric(1,0) AS f_flg_firma_tecnico, 
            NULL::numeric(1,0) AS f_flg_firma_responsabile, a.data_invio, 
            a.data_respinta, a.xml_allegato, a.nome_allegato, 
            NULL::numeric AS a_potenza_termica_nominale_max, a.data_ult_mod, 
            a.utente_ult_mod, ru.des_ruolo, ru.ruolo_funz, pf.nome AS pf_nome, 
            pf.cognome AS pf_cognome, pf.codice_fiscale AS pf_codice_fiscale, 
            pg.denominazione AS pg_denominazione, 
            pg.codice_fiscale AS pg_codice_fiscale, 
            pg.sigla_rea AS pg_sigla_rea, pg.numero_rea AS pg_numero_rea, 
            r1.codice_impianto, i.denominazione_comune AS comune_impianto, 
            i.sigla_provincia AS sigla_prov_impianto, 
            COALESCE(u.indirizzo_sitad, u.indirizzo_non_trovato) AS indirizzo_unita_immob, 
            u.civico AS civico_unita_immob, 
            NULL::numeric(1,0) AS flg_controllo_bozza
           FROM sigit_t_all_respinto a
      JOIN sigit_r_imp_ruolo_pfpg r1 ON a.id_imp_ruolo_pfpg = r1.id_imp_ruolo_pfpg
   JOIN sigit_d_ruolo ru ON r1.fk_ruolo = ru.id_ruolo
   JOIN sigit_d_tipo_documento doc ON a.fk_tipo_documento = doc.id_tipo_documento
   LEFT JOIN sigit_t_persona_fisica pf ON r1.fk_persona_fisica = pf.id_persona_fisica
   LEFT JOIN sigit_t_persona_giuridica pg ON r1.fk_persona_giuridica = pg.id_persona_giuridica
   LEFT JOIN sigit_t_impianto i ON r1.codice_impianto = i.codice_impianto
   LEFT JOIN sigit_t_unita_immobiliare u ON r1.codice_impianto = u.codice_impianto
  WHERE u.flg_principale = 1::numeric;

CREATE OR REPLACE VIEW vista_tot_impianto AS 
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
            sigit_t_terzo_responsabile.data_inizio AS data_inizio_3r, 
            sigit_t_terzo_responsabile.data_fine AS data_fine_3r, 
            sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg, 
            sigit_t_terzo_responsabile.id_persona_giuridica AS id_persona_giuridica_3r, 
            sigit_t_persona_giuridica.denominazione AS denominazione_3r, 
            sigit_t_persona_giuridica.codice_fiscale AS codice_fiscale_3r, 
            sigit_t_comp4.matricola, sigit_t_comp4.id_tipo_componente, 
            sigit_t_comp4.progressivo, sigit_t_comp4.data_install, 
            sigit_r_imp_ruolo_pfpg.data_inizio AS data_inizio_pfpg, 
            sigit_r_imp_ruolo_pfpg.data_fine AS data_fine_pfpg
           FROM sigit_t_impianto
      JOIN sigit_t_unita_immobiliare ON sigit_t_impianto.codice_impianto = sigit_t_unita_immobiliare.codice_impianto
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_t_unita_immobiliare.codice_impianto = sigit_r_imp_ruolo_pfpg.codice_impianto
   JOIN sigit_t_persona_fisica ON sigit_r_imp_ruolo_pfpg.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica
   JOIN sigit_d_ruolo ON sigit_r_imp_ruolo_pfpg.fk_ruolo = sigit_d_ruolo.id_ruolo
   LEFT JOIN sigit_t_terzo_responsabile ON sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg = sigit_t_terzo_responsabile.id_imp_ruolo_pfpg
   LEFT JOIN sigit_t_persona_giuridica ON sigit_t_terzo_responsabile.id_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
   LEFT JOIN sigit_t_comp4 ON sigit_t_impianto.codice_impianto = sigit_t_comp4.codice_impianto
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
            sigit_t_terzo_responsabile.data_inizio AS data_inizio_3r, 
            sigit_t_terzo_responsabile.data_fine AS data_fine_3r, 
            sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg, 
            sigit_t_terzo_responsabile.id_persona_giuridica AS id_persona_giuridica_3r, 
            sigit_t_persona_giuridica_1.denominazione AS denominazione_3r, 
            sigit_t_persona_giuridica_1.codice_fiscale AS codice_fiscale_3r, 
            sigit_t_comp4.matricola, sigit_t_comp4.id_tipo_componente, 
            sigit_t_comp4.progressivo, sigit_t_comp4.data_install, 
            sigit_r_imp_ruolo_pfpg.data_inizio AS data_inizio_pfpg, 
            sigit_r_imp_ruolo_pfpg.data_fine AS data_fine_pfpg
           FROM sigit_t_impianto
      JOIN sigit_t_unita_immobiliare ON sigit_t_impianto.codice_impianto = sigit_t_unita_immobiliare.codice_impianto
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_t_unita_immobiliare.codice_impianto = sigit_r_imp_ruolo_pfpg.codice_impianto
   JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
   JOIN sigit_d_ruolo ON sigit_r_imp_ruolo_pfpg.fk_ruolo = sigit_d_ruolo.id_ruolo
   LEFT JOIN sigit_t_terzo_responsabile ON sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg = sigit_t_terzo_responsabile.id_imp_ruolo_pfpg
   LEFT JOIN sigit_t_persona_giuridica sigit_t_persona_giuridica_1 ON sigit_t_terzo_responsabile.id_persona_giuridica = sigit_t_persona_giuridica_1.id_persona_giuridica
   LEFT JOIN sigit_t_comp4 ON sigit_t_impianto.codice_impianto = sigit_t_comp4.codice_impianto
  WHERE sigit_t_unita_immobiliare.flg_principale = 1::numeric;
           
  