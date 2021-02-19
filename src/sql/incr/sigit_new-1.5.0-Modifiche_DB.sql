
CREATE TABLE sigit_d_stato_ispezione
(
	id_stato_ispezione    NUMERIC  NOT NULL ,
	des_stato_ispezione   CHARACTER VARYING(100)  NOT NULL 
);

ALTER TABLE sigit_d_stato_ispezione
	ADD CONSTRAINT  PK_sigit_d_stato_ispezione PRIMARY KEY (id_stato_ispezione);



CREATE TABLE sigit_t_ispezione
(
	id_imp_ruolo_pfpg     NUMERIC  NOT NULL ,
	fk_stato_ispezione    NUMERIC  NOT NULL ,
	ente_competente       CHARACTER VARYING(100)  NULL ,
	data_ispezione        TIMESTAMP  NULL ,
	flg_esito             NUMERIC(1)  NULL  CONSTRAINT  flg_esito_0_1 CHECK (flg_esito IN (0,1)),
	data_ult_mod          TIMESTAMP  NOT NULL ,
	utente_ult_mod        CHARACTER VARYING(16)  NOT NULL ,
	note                  text  NULL 
);

ALTER TABLE sigit_t_ispezione
	ADD CONSTRAINT  PK_sigit_t_ispezione PRIMARY KEY (id_imp_ruolo_pfpg);



ALTER TABLE sigit_t_ispezione
	ADD CONSTRAINT  fk_sigit_d_stato_ispezione_01 FOREIGN KEY (fk_stato_ispezione) REFERENCES sigit_d_stato_ispezione(id_stato_ispezione);



ALTER TABLE sigit_t_ispezione
	ADD CONSTRAINT  FK_sigit_r_imp_ruolo_pfpg_03 FOREIGN KEY (id_imp_ruolo_pfpg) REFERENCES sigit_r_imp_ruolo_pfpg(id_imp_ruolo_pfpg);


ALTER TABLE sigit_t_allegato  ADD COLUMN elenco_combustibili character varying(1000);
ALTER TABLE sigit_t_allegato  ADD COLUMN elenco_apparecchiature character varying(1000);



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
  FROM (((((sigit_t_ispezione INNER JOIN sigit_r_imp_ruolo_pfpg 
 ON sigit_t_ispezione.id_imp_ruolo_pfpg = sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg) 
 INNER JOIN sigit_t_persona_fisica ON sigit_r_imp_ruolo_pfpg.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica)
 LEFT JOIN sigit_t_allegato ON sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg = sigit_t_allegato.fk_imp_ruolo_pfpg) 
 LEFT JOIN sigit_d_tipo_documento ON sigit_t_allegato.fk_tipo_documento = sigit_d_tipo_documento.id_tipo_documento) 
 LEFT JOIN sigit_d_stato_rapp ON sigit_t_allegato.fk_stato_rapp = sigit_d_stato_rapp.id_stato_rapp) 
 INNER JOIN sigit_d_stato_ispezione ON sigit_t_ispezione.fk_stato_ispezione = sigit_d_stato_ispezione.id_stato_ispezione
WHERE (((sigit_r_imp_ruolo_pfpg.fk_ruolo)=2));

 

DROP VIEW vista_ricerca_allegati;

CREATE OR REPLACE VIEW vista_ricerca_allegati AS 
         SELECT a.id_allegato, a.fk_stato_rapp, srapp.des_stato_rapp, 
            a.fk_imp_ruolo_pfpg, a.fk_tipo_documento, doc.des_tipo_documento, 
            a.fk_sigla_bollino, a.fk_numero_bollino, a.data_controllo, 
            a.b_flg_libretto_uso, a.b_flg_dichiar_conform, a.b_flg_lib_imp, 
            a.b_flg_lib_compl, a.f_osservazioni, a.f_raccomandazioni, 
            a.f_prescrizioni, a.f_flg_puo_funzionare, a.f_intervento_entro, 
            a.f_ora_arrivo, a.f_ora_partenza, a.f_denominaz_tecnico, 
            a.f_flg_firma_tecnico, a.f_flg_firma_responsabile, a.data_invio, 
            NULL::date AS data_respinta, a.nome_allegato, 
            a.a_potenza_termica_nominale_max, a.data_ult_mod, a.utente_ult_mod, 
            a.elenco_combustibili, a.elenco_apparecchiature, ru.des_ruolo, 
            ru.ruolo_funz, pf.nome AS pf_nome, pf.cognome AS pf_cognome, 
            pf.codice_fiscale AS pf_codice_fiscale, 
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
            a.data_respinta, a.nome_allegato, 
            NULL::numeric AS a_potenza_termica_nominale_max, a.data_ult_mod, 
            a.utente_ult_mod, NULL::character varying AS elenco_combustibili, 
            NULL::character varying AS elenco_apparecchiature, ru.des_ruolo, 
            ru.ruolo_funz, pf.nome AS pf_nome, pf.cognome AS pf_cognome, 
            pf.codice_fiscale AS pf_codice_fiscale, 
            pg.denominazione AS pg_denominazione, 
            pg.codice_fiscale AS pg_codice_fiscale, 
            pg.sigla_rea AS pg_sigla_rea, pg.numero_rea AS pg_numero_rea, 
            r1.codice_impianto, i.denominazione_comune AS comune_impianto, 
            i.sigla_provincia AS sigla_prov_impianto, 
            COALESCE(u.indirizzo_sitad, u.indirizzo_non_trovato) AS indirizzo_unita_immob, 
            u.civico AS civico_unita_immob, 
            NULL::numeric(1,0) AS flg_controllo_bozza, a.uid_index
           FROM sigit_t_all_respinto a
      JOIN sigit_r_imp_ruolo_pfpg r1 ON a.id_imp_ruolo_pfpg = r1.id_imp_ruolo_pfpg
   JOIN sigit_d_ruolo ru ON r1.fk_ruolo = ru.id_ruolo
   JOIN sigit_d_tipo_documento doc ON a.fk_tipo_documento = doc.id_tipo_documento
   LEFT JOIN sigit_t_persona_fisica pf ON r1.fk_persona_fisica = pf.id_persona_fisica
   LEFT JOIN sigit_t_persona_giuridica pg ON r1.fk_persona_giuridica = pg.id_persona_giuridica
   LEFT JOIN sigit_t_impianto i ON r1.codice_impianto = i.codice_impianto
   LEFT JOIN sigit_t_unita_immobiliare u ON r1.codice_impianto = u.codice_impianto
  WHERE u.flg_principale = 1::numeric;



 DROP VIEW vista_comp_cg_dett;

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
    sigit_t_persona_giuridica.sigla_rea, sigit_t_persona_giuridica.numero_rea, 
    sigit_r_imp_ruolo_pfpg.fk_ruolo
   FROM sigit_t_comp4
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp4.fk_combustibile = sigit_d_combustibile.id_combustibile
   LEFT JOIN sigit_d_marca ON sigit_t_comp4.fk_marca = sigit_d_marca.id_marca
   JOIN sigit_t_comp_cg ON sigit_t_comp4.data_install = sigit_t_comp_cg.data_install AND sigit_t_comp4.progressivo = sigit_t_comp_cg.progressivo AND sigit_t_comp4.id_tipo_componente::text = sigit_t_comp_cg.id_tipo_componente::text AND sigit_t_comp4.codice_impianto = sigit_t_comp_cg.codice_impianto
   LEFT JOIN sigit_t_dett_tipo4 ON sigit_t_comp_cg.progressivo = sigit_t_dett_tipo4.progressivo AND sigit_t_comp_cg.data_install = sigit_t_dett_tipo4.data_install AND sigit_t_comp_cg.id_tipo_componente::text = sigit_t_dett_tipo4.fk_tipo_componente::text AND sigit_t_comp_cg.codice_impianto = sigit_t_dett_tipo4.codice_impianto
   LEFT JOIN sigit_t_allegato ON sigit_t_dett_tipo4.fk_allegato = sigit_t_allegato.id_allegato
   LEFT JOIN sigit_r_imp_ruolo_pfpg ON sigit_t_allegato.fk_imp_ruolo_pfpg = sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg
   LEFT JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica;



DROP VIEW vista_comp_gf_dett;

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
    sigit_t_persona_giuridica.sigla_rea, sigit_t_persona_giuridica.numero_rea, 
    sigit_r_imp_ruolo_pfpg.fk_ruolo
   FROM sigit_t_comp4
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp4.fk_combustibile = sigit_d_combustibile.id_combustibile
   LEFT JOIN sigit_d_marca ON sigit_t_comp4.fk_marca = sigit_d_marca.id_marca
   JOIN sigit_t_comp_gf ON sigit_t_comp4.data_install = sigit_t_comp_gf.data_install AND sigit_t_comp4.progressivo = sigit_t_comp_gf.progressivo AND sigit_t_comp4.id_tipo_componente::text = sigit_t_comp_gf.id_tipo_componente::text AND sigit_t_comp4.codice_impianto = sigit_t_comp_gf.codice_impianto
   LEFT JOIN sigit_t_dett_tipo2 ON sigit_t_comp_gf.progressivo = sigit_t_dett_tipo2.progressivo AND sigit_t_comp_gf.data_install = sigit_t_dett_tipo2.data_install AND sigit_t_comp_gf.id_tipo_componente::text = sigit_t_dett_tipo2.fk_tipo_componente::text AND sigit_t_comp_gf.codice_impianto = sigit_t_dett_tipo2.codice_impianto
   LEFT JOIN sigit_t_allegato ON sigit_t_dett_tipo2.fk_allegato = sigit_t_allegato.id_allegato
   LEFT JOIN sigit_r_imp_ruolo_pfpg ON sigit_t_allegato.fk_imp_ruolo_pfpg = sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg
   LEFT JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica;



DROP VIEW vista_comp_gt_dett;

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
    sigit_t_persona_giuridica.sigla_rea, sigit_t_persona_giuridica.numero_rea, 
    sigit_r_imp_ruolo_pfpg.fk_ruolo
   FROM sigit_t_comp4
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp4.fk_combustibile = sigit_d_combustibile.id_combustibile
   LEFT JOIN sigit_d_marca ON sigit_t_comp4.fk_marca = sigit_d_marca.id_marca
   JOIN sigit_t_comp_gt ON sigit_t_comp4.data_install = sigit_t_comp_gt.data_install AND sigit_t_comp4.progressivo = sigit_t_comp_gt.progressivo AND sigit_t_comp4.id_tipo_componente::text = sigit_t_comp_gt.id_tipo_componente::text AND sigit_t_comp4.codice_impianto = sigit_t_comp_gt.codice_impianto
   LEFT JOIN sigit_t_dett_tipo1 ON sigit_t_comp_gt.progressivo = sigit_t_dett_tipo1.progressivo AND sigit_t_comp_gt.data_install = sigit_t_dett_tipo1.data_install AND sigit_t_comp_gt.id_tipo_componente::text = sigit_t_dett_tipo1.fk_tipo_componente::text AND sigit_t_comp_gt.codice_impianto = sigit_t_dett_tipo1.codice_impianto
   LEFT JOIN sigit_t_allegato ON sigit_t_dett_tipo1.fk_allegato = sigit_t_allegato.id_allegato
   LEFT JOIN sigit_r_imp_ruolo_pfpg ON sigit_t_allegato.fk_imp_ruolo_pfpg = sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg
   LEFT JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica;



DROP VIEW vista_comp_sc_dett;

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
    sigit_t_persona_giuridica.sigla_rea, sigit_t_persona_giuridica.numero_rea, 
    sigit_r_imp_ruolo_pfpg.fk_ruolo
   FROM sigit_t_comp4
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp4.fk_combustibile = sigit_d_combustibile.id_combustibile
   LEFT JOIN sigit_d_marca ON sigit_t_comp4.fk_marca = sigit_d_marca.id_marca
   JOIN sigit_t_comp_sc ON sigit_t_comp4.data_install = sigit_t_comp_sc.data_install AND sigit_t_comp4.progressivo = sigit_t_comp_sc.progressivo AND sigit_t_comp4.id_tipo_componente::text = sigit_t_comp_sc.id_tipo_componente::text AND sigit_t_comp4.codice_impianto = sigit_t_comp_sc.codice_impianto
   LEFT JOIN sigit_t_dett_tipo3 ON sigit_t_comp_sc.progressivo = sigit_t_dett_tipo3.progressivo AND sigit_t_comp_sc.data_install = sigit_t_dett_tipo3.data_install AND sigit_t_comp_sc.id_tipo_componente::text = sigit_t_dett_tipo3.fk_tipo_componente::text AND sigit_t_comp_sc.codice_impianto = sigit_t_dett_tipo3.codice_impianto
   LEFT JOIN sigit_t_allegato ON sigit_t_dett_tipo3.fk_allegato = sigit_t_allegato.id_allegato
   LEFT JOIN sigit_r_imp_ruolo_pfpg ON sigit_t_allegato.fk_imp_ruolo_pfpg = sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg
   LEFT JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica;





 GRANT SELECT,UPDATE,INSERT,DELETE,TRUNCATE ON ALL TABLES IN SCHEMA sigit_new TO sigit_new_rw;

GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA sigit_new TO sigit_new_rw;

GRANT SELECT,UPDATE ON ALL SEQUENCES IN SCHEMA sigit_new TO sigit_new_rw;


INSERT INTO sigit_d_stato_ispezione(
            id_stato_ispezione, des_stato_ispezione)
    VALUES (1, 'BOZZA');

INSERT INTO sigit_d_stato_ispezione(
            id_stato_ispezione, des_stato_ispezione)
    VALUES (2, 'CONSOLIDATO');


INSERT INTO sigit_d_stato_ispezione(
            id_stato_ispezione, des_stato_ispezione)
    VALUES (3, 'ANNULLATO');