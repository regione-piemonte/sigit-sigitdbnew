CREATE OR REPLACE VIEW vista_ricerca_impianti AS 
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
  WHERE (sigit_r_imp_ruolo_pfpg_1.fk_ruolo = ANY (ARRAY[4::numeric, 5::numeric, 10::numeric, 11::numeric, 12::numeric, 13::numeric])) 
  AND sigit_r_imp_ruolo_pfpg_1.data_inizio <= now() 
  AND now() <= COALESCE(sigit_r_imp_ruolo_pfpg_1.data_fine::date, now(), sigit_r_imp_ruolo_pfpg_1.data_fine::date)) q_pf_ruolo ON sigit_t_impianto.codice_impianto = q_pf_ruolo.codice_impianto
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
  WHERE (sigit_r_imp_ruolo_pfpg.fk_ruolo = ANY (ARRAY[4::numeric, 5::numeric, 10::numeric, 11::numeric, 12::numeric, 13::numeric])) AND sigit_r_imp_ruolo_pfpg.data_inizio <= now() AND now() <= COALESCE(sigit_r_imp_ruolo_pfpg.data_fine::date, now(), sigit_r_imp_ruolo_pfpg.data_fine::date)) q_pg_ruolo ON sigit_t_impianto.codice_impianto = q_pg_ruolo.codice_impianto
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
   JOIN sigit_t_persona_giuridica sigit_t_persona_giuridica_1 ON 
   sigit_t_contratto.fk_pg_3_resp = sigit_t_persona_giuridica_1.id_persona_giuridica) 
   ON sigit_d_tipo_contratto.id_tipo_contratto = sigit_t_contratto.fk_tipo_contratto
  WHERE sigit_r_impianto_contratto.data_revoca IS NULL
   AND (sigit_t_contratto.flg_tacito_rinnovo = 1::numeric OR 
   sigit_t_contratto.flg_tacito_rinnovo = 0::numeric AND sigit_t_contratto.data_fine >= now()::date)) q_contratto
   ON sigit_t_impianto.codice_impianto = q_contratto.codice_impianto
  WHERE sigit_t_unita_immobiliare.flg_principale = 1::numeric;
  
  
  
  
  
  



CREATE OR REPLACE VIEW vista_ricerca_comp AS 
 SELECT DISTINCT comp.codice_impianto, comp.id_tipo_componente, 
    comp.progressivo, comp.fk_marca, comp.fk_combustibile, comp.modello, 
    comp.potenza_termica_kw, comp.data_install, comp.matricola, 
    comp.data_dismiss, comp.flg_dismissione
   FROM (        (        (        (        (        (         SELECT sigit_t_comp_gf.codice_impianto, 
                                                            sigit_t_comp_gf.id_tipo_componente, 
                                                            sigit_t_comp_gf.progressivo, 
                                                            sigit_t_comp_gf.data_install, 
                                                            sigit_t_comp_gf.fk_marca, 
                                                            sigit_t_comp_gf.fk_combustibile, 
                                                            sigit_t_comp_gf.modello, 
                                                            sigit_t_comp_gf.risc_potenza_kw AS potenza_termica_kw, 
                                                            sigit_t_comp_gf.matricola, 
                                                            sigit_t_comp_gf.data_dismiss, 
                                                            sigit_t_comp_gf.flg_dismissione
                                                           FROM sigit_t_comp_gf
                                                UNION 
                                                         SELECT sigit_t_comp_cs.codice_impianto, 
                                                            sigit_t_comp_cs.id_tipo_componente, 
                                                            sigit_t_comp_cs.progressivo, 
                                                            sigit_t_comp_cs.data_install, 
                                                            sigit_t_comp_cs.fk_marca, 
                                                            NULL::numeric AS fk_combustibile, 
                                                            NULL::character varying(300) AS modello, 
                                                            NULL::numeric AS potenza_termica_kw, 
                                                            NULL::character varying(30) AS matricola, 
                                                            sigit_t_comp_cs.data_dismiss, 
                                                            sigit_t_comp_cs.flg_dismissione
                                                           FROM sigit_t_comp_cs)
                                        UNION 
                                                 SELECT sigit_t_comp_ag.codice_impianto, 
                                                    sigit_t_comp_ag.id_tipo_componente, 
                                                    sigit_t_comp_ag.progressivo, 
                                                    sigit_t_comp_ag.data_install, 
                                                    sigit_t_comp_ag.fk_marca, 
                                                    NULL::numeric AS fk_combustibile, 
                                                    sigit_t_comp_ag.modello, 
                                                    sigit_t_comp_ag.potenza_termica_kw, 
                                                    sigit_t_comp_ag.matricola, 
                                                    sigit_t_comp_ag.data_dismiss, 
                                                    sigit_t_comp_ag.flg_dismissione
                                                   FROM sigit_t_comp_ag)
                                UNION 
                                         SELECT sigit_t_comp_cg.codice_impianto, 
                                            sigit_t_comp_cg.id_tipo_componente, 
                                            sigit_t_comp_cg.progressivo, 
                                            sigit_t_comp_cg.data_install, 
                                            sigit_t_comp_cg.fk_marca, 
                                            sigit_t_comp_cg.fk_combustibile, 
                                            sigit_t_comp_cg.modello, 
                                            sigit_t_comp_cg.potenza_termica_kw, 
                                            sigit_t_comp_cg.matricola, 
                                            sigit_t_comp_cg.data_dismiss, 
                                            sigit_t_comp_cg.flg_dismissione
                                           FROM sigit_t_comp_cg)
                        UNION 
                                 SELECT sigit_t_comp_sc.codice_impianto, 
                                    sigit_t_comp_sc.id_tipo_componente, 
                                    sigit_t_comp_sc.progressivo, 
                                    sigit_t_comp_sc.data_install, 
                                    sigit_t_comp_sc.fk_marca, 
                                    NULL::numeric AS fk_combustibile, 
                                    sigit_t_comp_sc.modello, 
                                    sigit_t_comp_sc.potenza_termica_kw, 
                                    sigit_t_comp_sc.matricola, 
                                    sigit_t_comp_sc.data_dismiss, 
                                    sigit_t_comp_sc.flg_dismissione
                                   FROM sigit_t_comp_sc)
                UNION 
                         SELECT sigit_t_comp_gt.codice_impianto, 
                            sigit_t_comp_gt.id_tipo_componente, 
                            sigit_t_comp_gt.progressivo, 
                            sigit_t_comp_gt.data_install, 
                            sigit_t_comp_gt.fk_marca, 
                            sigit_t_comp_gt.fk_combustibile, 
                            sigit_t_comp_gt.modello, 
                            sigit_t_comp_gt.potenza_termica_kw, 
                            sigit_t_comp_gt.matricola, 
                            sigit_t_comp_gt.data_dismiss, 
                            sigit_t_comp_gt.flg_dismissione
                           FROM sigit_t_comp_gt)
        UNION 
                 SELECT sigit_t_comp_x.codice_impianto, 
                    sigit_t_comp_x.id_tipo_componente, 
                    sigit_t_comp_x.progressivo, sigit_t_comp_x.data_install, 
                    sigit_t_comp_x.fk_marca, NULL::numeric AS fk_combustibile, 
                    sigit_t_comp_x.modello, NULL::numeric AS potenza_termica_kw, 
                    sigit_t_comp_x.matricola, sigit_t_comp_x.data_dismiss, 
                    sigit_t_comp_x.flg_dismissione
                   FROM sigit_t_comp_x) comp;


CREATE OR REPLACE VIEW vista_allegati AS 
         SELECT a.id_allegato, a.fk_imp_ruolo_pfpg AS fk_tab, 
            a.fk_tipo_documento, doc.des_tipo_documento, a.fk_sigla_bollino, 
            a.fk_numero_bollino, a.data_controllo, a.f_osservazioni, 
            a.f_raccomandazioni, a.f_prescrizioni, a.f_flg_puo_funzionare, 
            a.f_intervento_entro, r1.codice_impianto
           FROM sigit_t_allegato a
      JOIN sigit_r_imp_ruolo_pfpg r1 ON a.fk_imp_ruolo_pfpg = r1.id_imp_ruolo_pfpg
   JOIN sigit_d_tipo_documento doc ON a.fk_tipo_documento = doc.id_tipo_documento
UNION 
         SELECT distinct a.id_allegato, r1.id_r_comp4_manut AS fk_tab, 
            a.fk_tipo_documento, doc.des_tipo_documento, a.fk_sigla_bollino, 
            a.fk_numero_bollino, a.data_controllo, a.f_osservazioni, 
            a.f_raccomandazioni, a.f_prescrizioni, a.f_flg_puo_funzionare, 
            a.f_intervento_entro, r1.codice_impianto
           FROM sigit_t_allegato a
           JOIN sigit_r_comp4manut_all on a.id_allegato = sigit_r_comp4manut_all.id_allegato
      JOIN sigit_r_comp4_manut r1 ON sigit_r_comp4manut_all.id_r_comp4_manut = r1.id_r_comp4_manut
   JOIN sigit_d_tipo_documento doc ON a.fk_tipo_documento = doc.id_tipo_documento;
   




CREATE OR REPLACE VIEW vista_ricerca_allegati AS 
SELECT DISTINCT a.id_allegato, a.fk_stato_rapp, srapp.des_stato_rapp, 
    a.fk_imp_ruolo_pfpg, a.fk_tipo_documento, doc.des_tipo_documento, 
    a.fk_sigla_bollino, a.fk_numero_bollino, a.data_controllo, 
    a.b_flg_libretto_uso, a.b_flg_dichiar_conform, a.b_flg_lib_imp, 
    a.b_flg_lib_compl, a.f_osservazioni, a.f_raccomandazioni, a.f_prescrizioni, 
    a.f_flg_puo_funzionare, a.f_intervento_entro, a.f_ora_arrivo, 
    a.f_ora_partenza, a.f_denominaz_tecnico, a.f_flg_firma_tecnico, 
    a.f_flg_firma_responsabile, a.data_invio, NULL::date AS data_respinta, 
    a.nome_allegato, a.a_potenza_termica_nominale_max, a.data_ult_mod, 
    a.utente_ult_mod, a.elenco_combustibili, a.elenco_apparecchiature, 
    ru.des_ruolo, ru.ruolo_funz, pg.id_persona_giuridica, 
    pg.denominazione AS pg_denominazione, 
    pg.codice_fiscale AS pg_codice_fiscale, pg.sigla_rea AS pg_sigla_rea, 
    pg.numero_rea AS pg_numero_rea, r1.codice_impianto, 
    i.denominazione_comune AS comune_impianto, 
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
  union
  SELECT DISTINCT a.id_allegato, a.fk_stato_rapp, srapp.des_stato_rapp, 
    a.fk_imp_ruolo_pfpg, a.fk_tipo_documento, doc.des_tipo_documento, 
    a.fk_sigla_bollino, a.fk_numero_bollino, a.data_controllo, 
    a.b_flg_libretto_uso, a.b_flg_dichiar_conform, a.b_flg_lib_imp, 
    a.b_flg_lib_compl, a.f_osservazioni, a.f_raccomandazioni, a.f_prescrizioni, 
    a.f_flg_puo_funzionare, a.f_intervento_entro, a.f_ora_arrivo, 
    a.f_ora_partenza, a.f_denominaz_tecnico, a.f_flg_firma_tecnico, 
    a.f_flg_firma_responsabile, a.data_invio, NULL::date AS data_respinta, 
    a.nome_allegato, a.a_potenza_termica_nominale_max, a.data_ult_mod, 
    a.utente_ult_mod, a.elenco_combustibili, a.elenco_apparecchiature, 
    ru.des_ruolo, ru.ruolo_funz, pg.id_persona_giuridica, 
    pg.denominazione AS pg_denominazione, 
    pg.codice_fiscale AS pg_codice_fiscale, pg.sigla_rea AS pg_sigla_rea, 
    pg.numero_rea AS pg_numero_rea, r1.codice_impianto, 
    i.denominazione_comune AS comune_impianto, 
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
    sigit_r_impianto_contratto.codice_impianto, 
    sigit_r_impianto_contratto.data_revoca, 
    sigit_t_contratto.flg_tacito_rinnovo, 
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
   RIGHT JOIN (sigit_t_contratto
   JOIN sigit_r_impianto_contratto ON sigit_t_contratto.id_contratto = sigit_r_impianto_contratto.id_contratto) ON sigit_t_persona_fisica.id_persona_fisica = sigit_t_contratto.fk_pf_responsabile) ON sigit_t_persona_giuridica.id_persona_giuridica = sigit_t_contratto.fk_pg_3_resp
   LEFT JOIN sigit_t_persona_giuridica sigit_t_persona_giuridica_1 ON sigit_t_contratto.fk_pg_responsabile = sigit_t_persona_giuridica_1.id_persona_giuridica
   JOIN sigit_d_tipo_contratto ON sigit_t_contratto.fk_tipo_contratto = sigit_d_tipo_contratto.id_tipo_contratto
  WHERE sigit_r_impianto_contratto.data_revoca IS NULL AND sigit_t_contratto.flg_tacito_rinnovo = 1::numeric OR sigit_r_impianto_contratto.data_revoca IS NULL AND sigit_t_contratto.flg_tacito_rinnovo = 0::numeric AND sigit_t_contratto.data_fine > now()) cont ON sigit_t_impianto.codice_impianto = cont.codice_impianto
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
    sigit_r_impianto_contratto.codice_impianto, 
    sigit_r_impianto_contratto.data_revoca, 
    sigit_t_contratto.flg_tacito_rinnovo, 
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
   RIGHT JOIN (sigit_t_contratto
   JOIN sigit_r_impianto_contratto ON sigit_t_contratto.id_contratto = sigit_r_impianto_contratto.id_contratto) ON sigit_t_persona_fisica.id_persona_fisica = sigit_t_contratto.fk_pf_responsabile) ON sigit_t_persona_giuridica.id_persona_giuridica = sigit_t_contratto.fk_pg_3_resp
   LEFT JOIN sigit_t_persona_giuridica sigit_t_persona_giuridica_1 ON sigit_t_contratto.fk_pg_responsabile = sigit_t_persona_giuridica_1.id_persona_giuridica
   JOIN sigit_d_tipo_contratto ON sigit_t_contratto.fk_tipo_contratto = sigit_d_tipo_contratto.id_tipo_contratto
  WHERE sigit_r_impianto_contratto.data_revoca IS NULL AND sigit_t_contratto.flg_tacito_rinnovo = 1::numeric OR sigit_r_impianto_contratto.data_revoca IS NULL AND sigit_t_contratto.flg_tacito_rinnovo = 0::numeric AND sigit_t_contratto.data_fine > now()) cont ON sigit_t_impianto.codice_impianto = cont.codice_impianto
  WHERE sigit_t_unita_immobiliare.flg_principale = 1::numeric;




CREATE OR REPLACE VIEW vista_comp_ag AS 
 SELECT sigit_t_comp_ag.codice_impianto, sigit_t_comp_ag.id_tipo_componente, 
    sigit_t_comp_ag.progressivo, sigit_t_comp_ag.data_install, 
    sigit_t_comp_ag.data_dismiss, sigit_t_comp_ag.matricola, 
    sigit_t_comp_ag.fk_marca, sigit_d_marca.des_marca, sigit_t_comp_ag.modello, 
    sigit_t_comp_ag.potenza_termica_kw, sigit_t_comp_ag.data_ult_mod, 
    sigit_t_comp_ag.utente_ult_mod, sigit_t_comp_ag.tipologia, 
    sigit_t_comp_ag.flg_dismissione
   FROM sigit_t_comp_ag
   LEFT JOIN sigit_d_marca ON sigit_t_comp_ag.fk_marca = sigit_d_marca.id_marca;




CREATE OR REPLACE VIEW vista_comp_cs AS 
 SELECT sigit_t_comp_cs.codice_impianto, sigit_t_comp_cs.id_tipo_componente, 
    sigit_t_comp_cs.progressivo, sigit_t_comp_cs.data_install, 
    sigit_t_comp_cs.data_dismiss, sigit_t_comp_cs.fk_marca, 
    sigit_d_marca.des_marca, sigit_t_comp_cs.data_ult_mod, 
    sigit_t_comp_cs.utente_ult_mod, sigit_t_comp_cs.num_collettori, 
    sigit_t_comp_cs.sup_apertura, sigit_t_comp_cs.flg_dismissione
   FROM sigit_t_comp_cs
   LEFT JOIN sigit_d_marca ON sigit_t_comp_cs.fk_marca = sigit_d_marca.id_marca;






CREATE OR REPLACE VIEW vista_impianti_imprese AS 
         SELECT DISTINCT sigit_r_comp4_manut.codice_impianto, 
            sigit_t_persona_giuridica.sigla_rea, 
            sigit_t_persona_giuridica.numero_rea, 
            sigit_t_persona_giuridica.codice_fiscale, 
            sigit_r_comp4_manut.fk_ruolo, sigit_d_ruolo.ruolo_funz
           FROM sigit_d_ruolo
      JOIN sigit_r_comp4_manut ON sigit_d_ruolo.id_ruolo = sigit_r_comp4_manut.fk_ruolo
   JOIN sigit_t_persona_giuridica ON sigit_r_comp4_manut.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
  WHERE (sigit_r_comp4_manut.fk_ruolo = ANY (ARRAY[6::numeric, 7::numeric, 8::numeric, 9::numeric])) AND sigit_r_comp4_manut.data_fine IS NULL
UNION 
         SELECT DISTINCT sigit_r_imp_ruolo_pfpg.codice_impianto, 
            sigit_t_persona_giuridica.sigla_rea, 
            sigit_t_persona_giuridica.numero_rea, 
            sigit_t_persona_giuridica.codice_fiscale, 
            sigit_r_imp_ruolo_pfpg.fk_ruolo, sigit_d_ruolo.ruolo_funz
           FROM sigit_d_ruolo
      JOIN sigit_r_imp_ruolo_pfpg ON sigit_d_ruolo.id_ruolo = sigit_r_imp_ruolo_pfpg.fk_ruolo
   JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
  WHERE (sigit_r_imp_ruolo_pfpg.fk_ruolo = ANY (ARRAY[3::numeric])) AND sigit_r_imp_ruolo_pfpg.data_fine IS NULL
  ORDER BY 1;





CREATE OR REPLACE VIEW vista_allegati_ispezione AS 
 SELECT a.id_allegato, a.fk_stato_rapp, srapp.des_stato_rapp, 
    a.fk_imp_ruolo_pfpg, a.fk_tipo_documento, doc.des_tipo_documento, 
    a.fk_sigla_bollino, a.fk_numero_bollino, a.data_controllo, 
    a.b_flg_libretto_uso, a.b_flg_dichiar_conform, a.b_flg_lib_imp, 
    a.b_flg_lib_compl, a.f_osservazioni, a.f_raccomandazioni, a.f_prescrizioni, 
    a.f_flg_puo_funzionare, a.f_intervento_entro, a.f_ora_arrivo, 
    a.f_ora_partenza, a.f_denominaz_tecnico, a.f_flg_firma_tecnico, 
    a.f_flg_firma_responsabile, a.data_invio, NULL::date AS data_respinta, 
    a.nome_allegato, a.a_potenza_termica_nominale_max, a.data_ult_mod, 
    a.utente_ult_mod, a.elenco_combustibili, a.elenco_apparecchiature, 
    ru.des_ruolo, ru.ruolo_funz, pf.nome AS pf_nome, pf.cognome AS pf_cognome, 
    pf.codice_fiscale AS pf_codice_fiscale, 
    pg.denominazione AS pg_denominazione, 
    pg.codice_fiscale AS pg_codice_fiscale, pg.sigla_rea AS pg_sigla_rea, 
    pg.numero_rea AS pg_numero_rea, r1.codice_impianto, 
    i.denominazione_comune AS comune_impianto, 
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
  WHERE u.flg_principale = 1::numeric;





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
  
  
  
  
  

CREATE OR REPLACE VIEW vista_sk4_gt AS
SELECT distinct sigit_t_comp_gt.codice_impianto, sigit_t_comp_gt.id_tipo_componente, 
    sigit_t_comp_gt.progressivo, sigit_t_comp_gt.data_install, 
    sigit_t_comp_gt.data_dismiss, sigit_t_comp_gt.matricola, 
    sigit_t_comp_gt.fk_marca, sigit_d_marca.des_marca, 
    sigit_d_combustibile.id_combustibile, sigit_d_combustibile.des_combustibile,
    sigit_t_comp_gt.fk_fluido, sigit_d_fluido.des_fluido,
     sigit_t_comp_gt.fk_dettaglio_gt, sigit_d_dettaglio_gt.des_dettaglio_gt,
    sigit_t_comp_gt.modello, 
    sigit_t_comp_gt.potenza_termica_kw, sigit_t_comp_gt.data_ult_mod, 
    sigit_t_comp_gt.utente_ult_mod, sigit_t_comp_gt.rendimento_perc, sigit_t_comp_gt.n_moduli,
    sigit_t_comp_gt.flg_dismissione,  data_controllo 
   FROM sigit_t_comp_gt
   LEFT JOIN sigit_d_marca ON sigit_t_comp_gt.fk_marca = sigit_d_marca.id_marca
   LEFT JOIN sigit_d_fluido ON sigit_t_comp_gt.fk_fluido = sigit_d_fluido.id_fluido
   LEFT JOIN sigit_d_dettaglio_gt ON sigit_t_comp_gt.fk_dettaglio_gt = sigit_d_dettaglio_gt.id_dettaglio_gt
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp_gt.fk_combustibile = sigit_d_combustibile.id_combustibile
   LEFT JOIN sigit_t_dett_tipo1  on  sigit_t_dett_tipo1.codice_impianto = sigit_t_comp_gt.codice_impianto
   and  sigit_t_dett_tipo1.fk_tipo_componente = sigit_t_comp_gt.id_tipo_componente
   and sigit_t_dett_tipo1.progressivo = sigit_t_comp_gt.progressivo
   and sigit_t_dett_tipo1.data_install = sigit_t_comp_gt.data_install
   LEFT JOIN sigit_t_allegato on sigit_t_dett_tipo1.fk_allegato = sigit_t_allegato.id_allegato;
   
   
   CREATE OR REPLACE VIEW vista_sk4_gf AS
SELECT distinct sigit_t_comp_gf.codice_impianto, sigit_t_comp_gf.id_tipo_componente, 
    sigit_t_comp_gf.progressivo, sigit_t_comp_gf.data_install, 
    sigit_t_comp_gf.matricola, 
    sigit_t_comp_gf.fk_marca, sigit_d_marca.des_marca, 
    sigit_d_combustibile.id_combustibile, sigit_d_combustibile.des_combustibile,
     sigit_t_comp_gf.fk_dettaglio_gf, sigit_d_dettaglio_gf.des_dettaglio_gf,
    sigit_t_comp_gf.modello, 
    sigit_t_comp_gf.flg_sorgente_ext, sigit_t_comp_gf.flg_fluido_utenze, sigit_t_comp_gf.fluido_frigorigeno, 
    sigit_t_comp_gf.n_circuiti, sigit_t_comp_gf.raffrescamento_eer, sigit_t_comp_gf.raff_potenza_kw,
    sigit_t_comp_gf.raff_potenza_ass, sigit_t_comp_gf.riscaldamento_cop, sigit_t_comp_gf.risc_potenza_kw, 
    sigit_t_comp_gf.risc_potenza_ass_kw, sigit_t_comp_gf.flg_dismissione,sigit_t_comp_gf.data_dismiss,
    sigit_t_comp_gf.data_ult_mod, sigit_t_comp_gf.utente_ult_mod, sigit_t_comp_gf.potenza_termica_kw, 
     sigit_t_allegato.data_controllo 
   FROM sigit_t_comp_gf
   LEFT JOIN sigit_d_marca ON sigit_t_comp_gf.fk_marca = sigit_d_marca.id_marca
   LEFT JOIN sigit_d_dettaglio_gf ON sigit_t_comp_gf.fk_dettaglio_gf = sigit_d_dettaglio_gf.id_dettaglio_gf
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp_gf.fk_combustibile = sigit_d_combustibile.id_combustibile
   LEFT JOIN sigit_t_dett_tipo2  on  sigit_t_dett_tipo2.codice_impianto = sigit_t_comp_gf.codice_impianto
   and  sigit_t_dett_tipo2.fk_tipo_componente = sigit_t_comp_gf.id_tipo_componente
   and sigit_t_dett_tipo2.progressivo = sigit_t_comp_gf.progressivo
   and sigit_t_dett_tipo2.data_install = sigit_t_comp_gf.data_install
   LEFT JOIN sigit_t_allegato on sigit_t_dett_tipo2.fk_allegato = sigit_t_allegato.id_allegato;
   
   
   CREATE OR REPLACE VIEW vista_sk4_cg AS
   SELECT distinct sigit_t_comp_cg.codice_impianto, sigit_t_comp_cg.id_tipo_componente, 
    sigit_t_comp_cg.progressivo, sigit_t_comp_cg.data_install, 
    sigit_t_comp_cg.data_dismiss, sigit_t_comp_cg.matricola, 
    sigit_t_comp_cg.fk_marca, sigit_d_marca.des_marca, 
    sigit_d_combustibile.id_combustibile, sigit_d_combustibile.des_combustibile,
    sigit_t_comp_cg.modello, 
    sigit_t_comp_cg.potenza_termica_kw, sigit_t_comp_cg.data_ult_mod, 
    sigit_t_comp_cg.utente_ult_mod, 
    sigit_t_comp_cg.tipologia, sigit_t_comp_cg.potenza_elettrica_kw,
    sigit_t_comp_cg.temp_h2o_out_min,sigit_t_comp_cg.temp_h2o_out_max,sigit_t_comp_cg.temp_h2o_in_min,
    sigit_t_comp_cg.temp_h2o_in_max, sigit_t_comp_cg.temp_h2o_motore_min,  sigit_t_comp_cg.temp_h2o_motore_max,
    sigit_t_comp_cg.temp_fumi_valle_min,sigit_t_comp_cg.temp_fumi_valle_max,
    sigit_t_comp_cg.temp_fumi_monte_min,sigit_t_comp_cg.temp_fumi_monte_max,
    sigit_t_comp_cg.co_min,sigit_t_comp_cg.co_max,
    sigit_t_comp_cg.flg_dismissione,  sigit_t_allegato.data_controllo 
   FROM sigit_t_comp_cg
   LEFT JOIN sigit_d_marca ON sigit_t_comp_cg.fk_marca = sigit_d_marca.id_marca
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp_cg.fk_combustibile = sigit_d_combustibile.id_combustibile
   LEFT JOIN sigit_t_dett_tipo4  on  sigit_t_dett_tipo4.codice_impianto = sigit_t_comp_cg.codice_impianto
   and  sigit_t_dett_tipo4.fk_tipo_componente = sigit_t_comp_cg.id_tipo_componente
   and sigit_t_dett_tipo4.progressivo = sigit_t_comp_cg.progressivo
   and sigit_t_dett_tipo4.data_install = sigit_t_comp_cg.data_install
   LEFT JOIN sigit_t_allegato on sigit_t_dett_tipo4.fk_allegato = sigit_t_allegato.id_allegato;
   
   
   CREATE OR REPLACE VIEW vista_sk4_sc AS
   SELECT distinct sigit_t_comp_sc.codice_impianto, sigit_t_comp_sc.id_tipo_componente, 
    sigit_t_comp_sc.progressivo, sigit_t_comp_sc.data_install, 
    sigit_t_comp_sc.flg_dismissione, sigit_t_comp_sc.data_dismiss,
    sigit_t_comp_sc.data_ult_mod, sigit_t_comp_sc.utente_ult_mod,
    sigit_t_comp_sc.matricola, sigit_t_comp_sc.modello,sigit_t_comp_sc.potenza_termica_kw, 
    sigit_t_comp_sc.fk_marca, sigit_d_marca.des_marca, 
    sigit_t_allegato.data_controllo 
   FROM sigit_t_comp_sc
   LEFT JOIN sigit_d_marca ON sigit_t_comp_sc.fk_marca = sigit_d_marca.id_marca
   LEFT JOIN sigit_t_dett_tipo3  on  sigit_t_dett_tipo3.codice_impianto = sigit_t_comp_sc.codice_impianto
   and  sigit_t_dett_tipo3.fk_tipo_componente = sigit_t_comp_sc.id_tipo_componente
   and sigit_t_dett_tipo3.progressivo = sigit_t_comp_sc.progressivo
   and sigit_t_dett_tipo3.data_install = sigit_t_comp_sc.data_install
   LEFT JOIN sigit_t_allegato on sigit_t_dett_tipo3.fk_allegato = sigit_t_allegato.id_allegato;
  
   



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
      JOIN sigit_t_allegato ON sigit_t_dett_tipo1.fk_allegato = sigit_t_allegato.id_allegato
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
            coalesce(id_persona_giuridica,  id_persona_fisica,id_persona_giuridica) id_pf_pg,
            sigit_r_imp_ruolo_pfpg.fk_ruolo
           FROM sigit_t_dett_tipo1
      JOIN sigit_t_allegato ON sigit_t_dett_tipo1.fk_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg = sigit_t_allegato.fk_imp_ruolo_pfpg
   left JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
   left JOIN sigit_t_persona_fisica ON sigit_r_imp_ruolo_pfpg.fk_persona_fisica  = sigit_t_persona_fisica .id_persona_fisica ;






CREATE OR REPLACE VIEW vista_comp_cg_dett AS 
 SELECT sigit_t_dett_tipo4.codice_impianto, sigit_t_dett_tipo4.fk_tipo_componente, 
    sigit_t_dett_tipo4.progressivo, sigit_t_dett_tipo4.data_install, 
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
    sigit_t_persona_giuridica.sigla_rea, sigit_t_persona_giuridica.numero_rea, 
    sigit_t_persona_giuridica.id_persona_giuridica, 
    sigit_r_comp4_manut.fk_ruolo,
    sigit_t_comp_cg.co_min,sigit_t_comp_cg.co_max
    FROM sigit_t_comp_cg
   JOIN sigit_t_dett_tipo4 ON sigit_t_dett_tipo4.codice_impianto = sigit_t_comp_cg.codice_impianto 
        and sigit_t_dett_tipo4.fk_tipo_componente = sigit_t_comp_cg.id_tipo_componente 
        and sigit_t_dett_tipo4.progressivo = sigit_t_comp_cg.progressivo
        and sigit_t_dett_tipo4.data_install = sigit_t_comp_cg.data_install
   JOIN sigit_t_allegato ON sigit_t_dett_tipo4.fk_allegato = sigit_t_allegato.id_allegato
   join sigit_r_comp4manut_all on sigit_r_comp4manut_all.id_allegato = sigit_t_allegato.id_allegato 
   JOIN sigit_r_comp4_manut ON sigit_r_comp4_manut.id_r_comp4_manut = sigit_r_comp4manut_all.id_r_comp4_manut 
   JOIN sigit_t_persona_giuridica ON sigit_r_comp4_manut.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
 union
  SELECT sigit_t_dett_tipo4.codice_impianto, sigit_t_dett_tipo4.fk_tipo_componente, 
    sigit_t_dett_tipo4.progressivo, sigit_t_dett_tipo4.data_install, 
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
    sigit_t_persona_giuridica.sigla_rea, sigit_t_persona_giuridica.numero_rea, 
	coalesce(id_persona_giuridica,  id_persona_fisica,id_persona_giuridica) id_pf_pg,
     sigit_r_imp_ruolo_pfpg.fk_ruolo,
    sigit_t_comp_cg.co_min,sigit_t_comp_cg.co_max
   FROM sigit_t_comp_cg
   JOIN sigit_t_dett_tipo4 ON sigit_t_dett_tipo4.codice_impianto = sigit_t_comp_cg.codice_impianto 
        and sigit_t_dett_tipo4.fk_tipo_componente = sigit_t_comp_cg.id_tipo_componente 
        and sigit_t_dett_tipo4.progressivo = sigit_t_comp_cg.progressivo
        and sigit_t_dett_tipo4.data_install = sigit_t_comp_cg.data_install
   JOIN sigit_t_allegato ON sigit_t_dett_tipo4.fk_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg = sigit_t_allegato.fk_imp_ruolo_pfpg
   left JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
   left JOIN sigit_t_persona_fisica ON sigit_r_imp_ruolo_pfpg.fk_persona_fisica  = sigit_t_persona_fisica .id_persona_fisica 
 ;






CREATE OR REPLACE VIEW vista_comp_gf_dett AS 
 SELECT sigit_t_dett_tipo2.codice_impianto, sigit_t_dett_tipo2.fk_tipo_componente, 
    sigit_t_dett_tipo2.progressivo, sigit_t_dett_tipo2.data_install, 
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
    sigit_t_persona_giuridica.sigla_rea, sigit_t_persona_giuridica.numero_rea, 
    sigit_t_persona_giuridica.id_persona_giuridica, 
    sigit_r_comp4_manut.fk_ruolo
    FROM sigit_t_dett_tipo2 
   JOIN sigit_t_allegato ON sigit_t_dett_tipo2.fk_allegato = sigit_t_allegato.id_allegato
   join sigit_r_comp4manut_all on sigit_r_comp4manut_all.id_allegato = sigit_t_allegato.id_allegato 
   JOIN sigit_r_comp4_manut ON sigit_r_comp4_manut.id_r_comp4_manut = sigit_r_comp4manut_all.id_r_comp4_manut 
   JOIN sigit_t_persona_giuridica ON sigit_r_comp4_manut.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
 union
 SELECT sigit_t_dett_tipo2.codice_impianto, sigit_t_dett_tipo2.fk_tipo_componente, 
    sigit_t_dett_tipo2.progressivo, sigit_t_dett_tipo2.data_install, 
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
    sigit_t_persona_giuridica.sigla_rea, sigit_t_persona_giuridica.numero_rea, 
     coalesce(id_persona_giuridica,  id_persona_fisica,id_persona_giuridica) id_pf_pg, 
      sigit_r_imp_ruolo_pfpg.fk_ruolo
   FROM sigit_t_dett_tipo2
  JOIN sigit_t_allegato ON sigit_t_dett_tipo2.fk_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg = sigit_t_allegato.fk_imp_ruolo_pfpg
   left JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
   left JOIN sigit_t_persona_fisica ON sigit_r_imp_ruolo_pfpg.fk_persona_fisica  = sigit_t_persona_fisica .id_persona_fisica ;








CREATE OR REPLACE VIEW vista_comp_sc_dett AS 
 SELECT sigit_t_dett_tipo3.codice_impianto, sigit_t_dett_tipo3.fk_tipo_componente, 
    sigit_t_dett_tipo3.progressivo, sigit_t_dett_tipo3.data_install, 
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
    sigit_t_allegato.data_controllo, 
    sigit_t_persona_giuridica.sigla_rea, sigit_t_persona_giuridica.numero_rea, 
    sigit_t_persona_giuridica.id_persona_giuridica, 
    sigit_r_comp4_manut.fk_ruolo
   FROM sigit_t_dett_tipo3
     JOIN sigit_t_allegato ON sigit_t_dett_tipo3.fk_allegato = sigit_t_allegato.id_allegato
   join sigit_r_comp4manut_all on sigit_r_comp4manut_all.id_allegato = sigit_t_allegato.id_allegato 
   JOIN sigit_r_comp4_manut ON sigit_r_comp4_manut.id_r_comp4_manut = sigit_r_comp4manut_all.id_r_comp4_manut 
   JOIN sigit_t_persona_giuridica ON sigit_r_comp4_manut.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
   union
   SELECT sigit_t_dett_tipo3.codice_impianto, sigit_t_dett_tipo3.fk_tipo_componente, 
    sigit_t_dett_tipo3.progressivo, sigit_t_dett_tipo3.data_install, 
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
    sigit_t_allegato.data_controllo, 
    sigit_t_persona_giuridica.sigla_rea, sigit_t_persona_giuridica.numero_rea, 
    coalesce(id_persona_giuridica,  id_persona_fisica,id_persona_giuridica) id_pf_pg,
    sigit_r_imp_ruolo_pfpg.fk_ruolo
   FROM sigit_t_dett_tipo3
  JOIN sigit_t_allegato ON sigit_t_dett_tipo3.fk_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg = sigit_t_allegato.fk_imp_ruolo_pfpg
    left JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
   left JOIN sigit_t_persona_fisica ON sigit_r_imp_ruolo_pfpg.fk_persona_fisica  = sigit_t_persona_fisica .id_persona_fisica ;
   
   
   
   
   
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
    sigit_t_persona_giuridica.flg_installatore, 
    sigit_t_persona_giuridica.flg_manutentore, 
    sigit_t_persona_giuridica.flg_amministratore, 
    sigit_t_persona_giuridica.data_ult_mod, 
    sigit_t_persona_giuridica.utente_ult_mod, 
    sigit_t_persona_giuridica.flg_terzo_responsabile, 
    sigit_t_persona_giuridica.flg_distributore
   FROM sigit_t_persona_giuridica
  WHERE sigit_t_persona_giuridica.flg_distributore = 1::numeric;
  
  
  
  
  
  

GRANT SELECT,UPDATE,INSERT,DELETE,TRUNCATE ON ALL TABLES IN SCHEMA sigit_new TO sigit_new_rw;

GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA sigit_new TO sigit_new_rw;

GRANT SELECT,UPDATE ON ALL SEQUENCES IN SCHEMA sigit_new TO sigit_new_rw;



   