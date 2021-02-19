CREATE OR REPLACE VIEW vista_allegati AS 
 SELECT a.id_allegato, a.fk_imp_ruolo_pfpg, a.fk_tipo_documento, 
    doc.des_tipo_documento, a.fk_sigla_bollino, a.fk_numero_bollino, 
    a.data_controllo, a.f_osservazioni, a.f_raccomandazioni, a.f_prescrizioni, 
    a.f_flg_puo_funzionare, a.f_intervento_entro, 
    r1.codice_impianto
   FROM sigit_t_allegato a
   JOIN sigit_r_imp_ruolo_pfpg r1 ON a.fk_imp_ruolo_pfpg = r1.id_imp_ruolo_pfpg
   JOIN sigit_d_tipo_documento doc ON a.fk_tipo_documento = doc.id_tipo_documento;
   



CREATE OR REPLACE VIEW vista_ricerca_comp AS 
 SELECT DISTINCT comp.codice_impianto, 
    comp.id_tipo_componente, 
    comp.progressivo, comp.fk_marca, comp.fk_combustibile, comp.modello, 
    comp.potenza_termica_kw, comp.data_install, comp.matricola, 
    comp.data_dismiss, comp.flg_dismissione
   FROM  (SELECT a.codice_impianto, a.id_tipo_componente, a.progressivo, 
                    a.data_install, a.fk_marca, a.fk_combustibile, a.modello, 
                        CASE a.id_tipo_componente
                            WHEN 'GF'::text THEN b.risc_potenza_kw
                            ELSE a.potenza_termica_kw
                        END AS potenza_termica_kw, 
                    a.matricola, a.data_dismiss, a.flg_dismissione
                   FROM sigit_t_comp4 a
              LEFT JOIN sigit_t_comp_gf b ON a.codice_impianto = b.codice_impianto AND a.id_tipo_componente::text = b.id_tipo_componente::text AND a.progressivo = b.progressivo AND a.data_install = b.data_install
        UNION 
                 SELECT sigit_t_comp_x.codice_impianto, 
                    sigit_t_comp_x.id_tipo_componente, 
                    sigit_t_comp_x.progressivo, sigit_t_comp_x.data_install, 
                    sigit_t_comp_x.fk_marca, NULL::numeric AS fk_combustibile, 
                    sigit_t_comp_x.modello, NULL::numeric AS potenza_termica_kw, 
                    sigit_t_comp_x.matricola, sigit_t_comp_x.data_dismiss, 
                    sigit_t_comp_x.flg_dismissione
                   FROM sigit_t_comp_x) comp ;


CREATE OR REPLACE VIEW vista_ricerca_3_responsabile AS 
 SELECT sigit_t_contratto.id_contratto, 
    sigit_r_impianto_contratto.codice_impianto, 
    sigit_r_impianto_contratto.data_revoca, 
    sigit_r_impianto_contratto.data_caricamento, 
    sigit_r_impianto_contratto.data_inserimento_revoca, 
    sigit_t_contratto.flg_tacito_rinnovo, sigit_t_contratto.data_inizio, 
    sigit_t_contratto.data_fine, 
    sigit_t_persona_giuridica.denominazione AS denominazione_3_responsabile, 
    sigit_t_persona_giuridica.sigla_rea AS sigla_rea_3r, 
    sigit_t_persona_giuridica.numero_rea AS numero_rea_3r, 
    sigit_t_persona_giuridica.codice_fiscale AS codice_fiscale_3r
   FROM sigit_t_contratto, sigit_r_impianto_contratto, 
    sigit_t_persona_giuridica
  WHERE sigit_r_impianto_contratto.id_contratto = sigit_t_contratto.id_contratto AND sigit_t_contratto.fk_pg_3_resp = sigit_t_persona_giuridica.id_persona_giuridica;
  
  
DROP VIEW vista_ricerca_impianti;

CREATE OR REPLACE VIEW vista_ricerca_impianti AS 
 SELECT DISTINCT sigit_t_impianto.codice_impianto, 
    sigit_t_impianto.istat_comune, sigit_t_impianto.denominazione_comune, 
    sigit_t_impianto.sigla_provincia, sigit_t_impianto.denominazione_provincia, 
    sigit_t_impianto.fk_stato,
    sigit_t_impianto.l1_3_pot_h2o_kw,
    sigit_t_impianto.l1_3_pot_clima_inv_kw,
    sigit_t_impianto.l1_3_pot_clima_est_kw,
    sigit_t_unita_immobiliare.flg_nopdr,
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
  
  
  
  
GRANT SELECT,UPDATE,INSERT,DELETE,TRUNCATE ON ALL TABLES IN SCHEMA sigit_new TO sigit_new_rw;  