DROP VIEW vista_ricerca_impianti;

CREATE OR REPLACE VIEW vista_ricerca_impianti AS 
 SELECT DISTINCT sigit_t_impianto.codice_impianto, 
    sigit_t_impianto.istat_comune, sigit_t_impianto.denominazione_comune, 
    sigit_t_impianto.sigla_provincia, sigit_t_impianto.denominazione_provincia, 
    COALESCE(sigit_t_unita_immobiliare.indirizzo_sitad, sigit_t_unita_immobiliare.indirizzo_non_trovato) AS indirizzo_unita_immob, 
    sigit_t_unita_immobiliare.civico, 
    COALESCE(q_pf_ruolo.denominazione_resp, q_pg_ruolo.denominazione_resp::text, q_pf_ruolo.denominazione_resp) AS denominazione_responsabile, 
    q_contratto.denominazione_3_responsabile, q_contratto.sigla_rea_3r, 
    q_contratto.numero_rea_3r, q_contratto.codice_fiscale_3r,
    COALESCE(q_pf_ruolo.codice_fisc, q_pg_ruolo.codice_fisc, q_pf_ruolo.codice_fisc) AS codice_fiscale, 
    COALESCE(q_pf_ruolo.data_fine_pfpg, q_pg_ruolo.data_fine_pfpg, q_pf_ruolo.data_fine_pfpg) AS data_fine_pfpg, 
    COALESCE(q_pf_ruolo.ruolo_resp, q_pg_ruolo.ruolo_resp, q_pf_ruolo.ruolo_resp) AS ruolo_responsabile, 
    COALESCE(q_pf_ruolo.ruolo_funz1, q_pg_ruolo.ruolo_funz1, q_pf_ruolo.ruolo_funz1) AS ruolo_funz
   FROM sigit_t_impianto
   JOIN sigit_t_unita_immobiliare ON sigit_t_impianto.codice_impianto = sigit_t_unita_immobiliare.codice_impianto
   LEFT JOIN ( SELECT sigit_r_imp_ruolo_pfpg_1.id_imp_ruolo_pfpg, 
       sigit_r_imp_ruolo_pfpg_1.codice_impianto, 
       sigit_r_imp_ruolo_pfpg_1.data_fine AS data_fine_pfpg, 
       sigit_t_persona_fisica.codice_fiscale AS codice_fisc, 
       (sigit_t_persona_fisica.cognome::text || ' '::text) || sigit_t_persona_fisica.nome::text AS denominazione_resp, 
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
    sigit_r_impianto_contratto.codice_impianto, 
    sigit_r_impianto_contratto.data_revoca, 
    sigit_t_contratto.flg_tacito_rinnovo, sigit_t_contratto.data_inizio, 
    sigit_t_persona_giuridica_1.denominazione AS denominazione_3_responsabile, 
    sigit_t_persona_giuridica_1.sigla_rea AS sigla_rea_3r, 
    sigit_t_persona_giuridica_1.numero_rea AS numero_rea_3r, 
    sigit_t_persona_giuridica_1.codice_fiscale AS codice_fiscale_3r
   FROM sigit_d_tipo_contratto
   JOIN (sigit_r_impianto_contratto
   JOIN sigit_t_contratto ON sigit_r_impianto_contratto.id_contratto = sigit_t_contratto.id_contratto
   JOIN sigit_t_persona_giuridica sigit_t_persona_giuridica_1 ON sigit_t_contratto.fk_pg_3_resp = sigit_t_persona_giuridica_1.id_persona_giuridica) ON sigit_d_tipo_contratto.id_tipo_contratto = sigit_t_contratto.fk_tipo_contratto
  WHERE sigit_r_impianto_contratto.data_revoca IS NULL AND (sigit_t_contratto.flg_tacito_rinnovo = 1::numeric OR sigit_t_contratto.flg_tacito_rinnovo = 0::numeric AND sigit_t_contratto.data_fine > 'now'::text::date)) q_contratto ON sigit_t_impianto.codice_impianto = q_contratto.codice_impianto
  WHERE sigit_t_unita_immobiliare.flg_principale = 1::numeric;
  
  
 CREATE OR REPLACE VIEW vista_impianti_imprese AS 
 SELECT DISTINCT sigit_r_imp_ruolo_pfpg.codice_impianto, 
    sigit_t_persona_giuridica.sigla_rea, sigit_t_persona_giuridica.numero_rea, 
    sigit_t_persona_giuridica.codice_fiscale, sigit_r_imp_ruolo_pfpg.fk_ruolo, 
    sigit_d_ruolo.ruolo_funz
   FROM sigit_d_ruolo
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_d_ruolo.id_ruolo = sigit_r_imp_ruolo_pfpg.fk_ruolo
   JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
  WHERE (sigit_r_imp_ruolo_pfpg.fk_ruolo = ANY (ARRAY[3::numeric, 6::numeric, 7::numeric, 8::numeric, 9::numeric])) AND sigit_r_imp_ruolo_pfpg.data_fine IS NULL
  ORDER BY sigit_r_imp_ruolo_pfpg.codice_impianto;
  
  
  
  drop view vista_ricerca_allegati;

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
            ru.des_ruolo, ru.ruolo_funz, pf.nome AS pf_nome, 
            pf.cognome AS pf_cognome, pf.codice_fiscale AS pf_codice_fiscale, 
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
            a.utente_ult_mod, ru.des_ruolo, ru.ruolo_funz, pf.nome AS pf_nome, 
            pf.cognome AS pf_cognome, pf.codice_fiscale AS pf_codice_fiscale, 
            pg.denominazione AS pg_denominazione, 
            pg.codice_fiscale AS pg_codice_fiscale, 
            pg.sigla_rea AS pg_sigla_rea, pg.numero_rea AS pg_numero_rea, 
            r1.codice_impianto, i.denominazione_comune AS comune_impianto, 
            i.sigla_provincia AS sigla_prov_impianto, 
            COALESCE(u.indirizzo_sitad, u.indirizzo_non_trovato) AS indirizzo_unita_immob, 
            u.civico AS civico_unita_immob, 
            NULL::numeric(1,0) AS flg_controllo_bozza,a.uid_index
           FROM sigit_t_all_respinto a
      JOIN sigit_r_imp_ruolo_pfpg r1 ON a.id_imp_ruolo_pfpg = r1.id_imp_ruolo_pfpg
   JOIN sigit_d_ruolo ru ON r1.fk_ruolo = ru.id_ruolo
   JOIN sigit_d_tipo_documento doc ON a.fk_tipo_documento = doc.id_tipo_documento
   LEFT JOIN sigit_t_persona_fisica pf ON r1.fk_persona_fisica = pf.id_persona_fisica
   LEFT JOIN sigit_t_persona_giuridica pg ON r1.fk_persona_giuridica = pg.id_persona_giuridica
   LEFT JOIN sigit_t_impianto i ON r1.codice_impianto = i.codice_impianto
   LEFT JOIN sigit_t_unita_immobiliare u ON r1.codice_impianto = u.codice_impianto
  WHERE u.flg_principale = 1::numeric;
 