ALTER TABLE sigit_t_compx_semplice ADD COLUMN data_ult_mod timestamp without time zone;
ALTER TABLE sigit_t_compx_semplice ADD COLUMN  utente_ult_mod character varying(16);

ALTER TABLE sigit_t_consumo_14_4 ADD COLUMN data_ult_mod timestamp without time zone;
ALTER TABLE sigit_t_consumo_14_4 ADD COLUMN  utente_ult_mod character varying(16);

ALTER TABLE sigit_t_storico_var_stato_pg ADD COLUMN data_ult_mod timestamp without time zone;
ALTER TABLE sigit_t_storico_var_stato_pg ADD COLUMN  utente_ult_mod character varying(16);

ALTER TABLE sigit_t_storico_variaz_stato ADD COLUMN data_ult_mod timestamp without time zone;
ALTER TABLE sigit_t_storico_variaz_stato ADD COLUMN  utente_ult_mod character varying(16);





-- BACKUP sigit_r_allegato_comp_xx
create table sigit_r_allegato_comp_gf_20170126 as select * from sigit_r_allegato_comp_gf;
create table sigit_r_allegato_comp_gt_20170126 as select * from sigit_r_allegato_comp_gt;
create table sigit_r_allegato_comp_cg_20170126 as select * from sigit_r_allegato_comp_cg;
create table sigit_r_allegato_comp_sc_20170126 as select * from sigit_r_allegato_comp_sc;



-- RINOMINA campi con butta_
ALTER TABLE sigit_r_allegato_comp_gf RENAME fk_r_pg  TO butta_fk_r_pg;
ALTER TABLE sigit_r_allegato_comp_gf RENAME fk_3r_pg  TO butta_fk_3r_pg;
ALTER TABLE sigit_r_allegato_comp_gf RENAME fk_r_pf  TO butta_fk_r_pf;

ALTER TABLE sigit_r_allegato_comp_gt RENAME fk_r_pg  TO butta_fk_r_pg;
ALTER TABLE sigit_r_allegato_comp_gt RENAME fk_3r_pg  TO butta_fk_3r_pg;
ALTER TABLE sigit_r_allegato_comp_gt RENAME fk_r_pf  TO butta_fk_r_pf;

ALTER TABLE sigit_r_allegato_comp_cg RENAME fk_r_pg  TO butta_fk_r_pg;
ALTER TABLE sigit_r_allegato_comp_cg RENAME fk_3r_pg  TO butta_fk_3r_pg;
ALTER TABLE sigit_r_allegato_comp_cg RENAME fk_r_pf  TO butta_fk_r_pf;

ALTER TABLE sigit_r_allegato_comp_sc RENAME fk_r_pg  TO butta_fk_r_pg;
ALTER TABLE sigit_r_allegato_comp_sc RENAME fk_3r_pg  TO butta_fk_3r_pg;
ALTER TABLE sigit_r_allegato_comp_sc RENAME fk_r_pf  TO butta_fk_r_pf;



-- AGGIUNTA NUOVE COLONNE
ALTER TABLE sigit_r_allegato_comp_gf  ADD COLUMN butta_fk_3resp numeric(6);
ALTER TABLE sigit_r_allegato_comp_gf  ADD COLUMN butta_fk_resp numeric(6);
ALTER TABLE sigit_r_allegato_comp_gf  ADD COLUMN fk_imp_ruolo_pfpg numeric;
ALTER TABLE sigit_r_allegato_comp_gf  ADD COLUMN fk_contratto numeric;

ALTER TABLE sigit_r_allegato_comp_gt  ADD COLUMN butta_fk_3resp numeric(6);
ALTER TABLE sigit_r_allegato_comp_gt  ADD COLUMN butta_fk_resp numeric(6);
ALTER TABLE sigit_r_allegato_comp_gt  ADD COLUMN fk_imp_ruolo_pfpg numeric;
ALTER TABLE sigit_r_allegato_comp_gt  ADD COLUMN fk_contratto numeric;

ALTER TABLE sigit_r_allegato_comp_cg  ADD COLUMN butta_fk_3resp numeric(6);
ALTER TABLE sigit_r_allegato_comp_cg  ADD COLUMN butta_fk_resp numeric(6);
ALTER TABLE sigit_r_allegato_comp_cg  ADD COLUMN fk_imp_ruolo_pfpg numeric;
ALTER TABLE sigit_r_allegato_comp_cg  ADD COLUMN fk_contratto numeric;

ALTER TABLE sigit_r_allegato_comp_sc  ADD COLUMN butta_fk_3resp numeric(6);
ALTER TABLE sigit_r_allegato_comp_sc  ADD COLUMN butta_fk_resp numeric(6);
ALTER TABLE sigit_r_allegato_comp_sc  ADD COLUMN fk_imp_ruolo_pfpg numeric;
ALTER TABLE sigit_r_allegato_comp_sc  ADD COLUMN fk_contratto numeric;



-- AGGIUNTA RELATIVE FK
ALTER TABLE sigit_r_allegato_comp_gf
	ADD CONSTRAINT  FK_sigit_r_imp_ruolo_pfpg_04 FOREIGN KEY (fk_imp_ruolo_pfpg) REFERENCES sigit_r_imp_ruolo_pfpg(id_imp_ruolo_pfpg);
ALTER TABLE sigit_r_allegato_comp_gf
	ADD CONSTRAINT  fk_sigit_t_contratto_04 FOREIGN KEY (fk_contratto) REFERENCES sigit_t_contratto(id_contratto);

ALTER TABLE sigit_r_allegato_comp_gt
	ADD CONSTRAINT  FK_sigit_r_imp_ruolo_pfpg_05 FOREIGN KEY (fk_imp_ruolo_pfpg) REFERENCES sigit_r_imp_ruolo_pfpg(id_imp_ruolo_pfpg);
ALTER TABLE sigit_r_allegato_comp_gt
	ADD CONSTRAINT  fk_sigit_t_contratto_05 FOREIGN KEY (fk_contratto) REFERENCES sigit_t_contratto(id_contratto);

ALTER TABLE sigit_r_allegato_comp_cg
	ADD CONSTRAINT  FK_sigit_r_imp_ruolo_pfpg_06 FOREIGN KEY (fk_imp_ruolo_pfpg) REFERENCES sigit_r_imp_ruolo_pfpg(id_imp_ruolo_pfpg);
ALTER TABLE sigit_r_allegato_comp_cg
	ADD CONSTRAINT  fk_sigit_t_contratto_06 FOREIGN KEY (fk_contratto) REFERENCES sigit_t_contratto(id_contratto);

ALTER TABLE sigit_r_allegato_comp_sc
	ADD CONSTRAINT  FK_sigit_r_imp_ruolo_pfpg_07 FOREIGN KEY (fk_imp_ruolo_pfpg) REFERENCES sigit_r_imp_ruolo_pfpg(id_imp_ruolo_pfpg);
ALTER TABLE sigit_r_allegato_comp_sc
	ADD CONSTRAINT  fk_sigit_t_contratto_07 FOREIGN KEY (fk_contratto) REFERENCES sigit_t_contratto(id_contratto);


DROP VIEW vista_allegati_componenti;

CREATE OR REPLACE VIEW vista_allegati_componenti AS 
        (        (         SELECT sigit_r_allegato_comp_cg.id_allegato, 
                            sigit_r_allegato_comp_cg.id_tipo_componente, 
                            sigit_r_allegato_comp_cg.progressivo, 
                            sigit_r_allegato_comp_cg.codice_impianto, 
                            sigit_r_allegato_comp_cg.data_install, 
                            sigit_r_allegato_comp_cg.fk_imp_ruolo_pfpg, 
                            sigit_r_allegato_comp_cg.fk_contratto, 
                            sigit_t_allegato.fk_stato_rapp, 
                            sigit_d_stato_rapp.des_stato_rapp, 
                            sigit_t_allegato.data_controllo
                           FROM sigit_r_allegato_comp_cg, sigit_t_allegato, 
                            sigit_d_stato_rapp
                          WHERE sigit_r_allegato_comp_cg.id_allegato = sigit_t_allegato.id_allegato AND sigit_t_allegato.fk_stato_rapp = sigit_d_stato_rapp.id_stato_rapp
                UNION 
                         SELECT sigit_r_allegato_comp_gf.id_allegato, 
                            sigit_r_allegato_comp_gf.id_tipo_componente, 
                            sigit_r_allegato_comp_gf.progressivo, 
                            sigit_r_allegato_comp_gf.codice_impianto, 
                            sigit_r_allegato_comp_gf.data_install, 
                            sigit_r_allegato_comp_gf.fk_imp_ruolo_pfpg, 
                            sigit_r_allegato_comp_gf.fk_contratto, 
                            sigit_t_allegato.fk_stato_rapp, 
                            sigit_d_stato_rapp.des_stato_rapp, 
                            sigit_t_allegato.data_controllo
                           FROM sigit_r_allegato_comp_gf, sigit_t_allegato, 
                            sigit_d_stato_rapp
                          WHERE sigit_r_allegato_comp_gf.id_allegato = sigit_t_allegato.id_allegato AND sigit_t_allegato.fk_stato_rapp = sigit_d_stato_rapp.id_stato_rapp)
        UNION 
                 SELECT sigit_r_allegato_comp_gt.id_allegato, 
                    sigit_r_allegato_comp_gt.id_tipo_componente, 
                    sigit_r_allegato_comp_gt.progressivo, 
                    sigit_r_allegato_comp_gt.codice_impianto, 
                    sigit_r_allegato_comp_gt.data_install, 
                            sigit_r_allegato_comp_gt.fk_imp_ruolo_pfpg, 
                            sigit_r_allegato_comp_gt.fk_contratto, 
                    sigit_t_allegato.fk_stato_rapp, 
                    sigit_d_stato_rapp.des_stato_rapp, 
                    sigit_t_allegato.data_controllo
                   FROM sigit_r_allegato_comp_gt, sigit_t_allegato, 
                    sigit_d_stato_rapp
                  WHERE sigit_r_allegato_comp_gt.id_allegato = sigit_t_allegato.id_allegato AND sigit_t_allegato.fk_stato_rapp = sigit_d_stato_rapp.id_stato_rapp)
UNION 
         SELECT sigit_r_allegato_comp_sc.id_allegato, 
            sigit_r_allegato_comp_sc.id_tipo_componente, 
            sigit_r_allegato_comp_sc.progressivo, 
            sigit_r_allegato_comp_sc.codice_impianto, 
            sigit_r_allegato_comp_sc.data_install, 
                            sigit_r_allegato_comp_sc.fk_imp_ruolo_pfpg, 
                            sigit_r_allegato_comp_sc.fk_contratto, 
            sigit_t_allegato.fk_stato_rapp, sigit_d_stato_rapp.des_stato_rapp, 
            sigit_t_allegato.data_controllo
           FROM sigit_r_allegato_comp_sc, sigit_t_allegato, sigit_d_stato_rapp
          WHERE sigit_r_allegato_comp_sc.id_allegato = sigit_t_allegato.id_allegato AND sigit_t_allegato.fk_stato_rapp = sigit_d_stato_rapp.id_stato_rapp;

ALTER TABLE vista_allegati_componenti
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_allegati_componenti TO sigit_new;
GRANT SELECT ON TABLE vista_allegati_componenti TO sigit_new_ro;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_allegati_componenti TO sigit_new_rw;



DROP VIEW vista_ricerca_impianti;

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
    sigit_t_impianto.flg_contabilizzazione,
    sigit_d_stato_imp.des_stato
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
   JOIN sigit_t_contratto ON sigit_r_comp4_contratto.id_contratto = sigit_t_contratto.id_contratto
   JOIN sigit_t_persona_giuridica sigit_t_persona_giuridica_1 ON sigit_t_contratto.fk_pg_3_resp = sigit_t_persona_giuridica_1.id_persona_giuridica) ON sigit_d_tipo_contratto.id_tipo_contratto = sigit_t_contratto.fk_tipo_contratto
  WHERE sigit_r_comp4_contratto.data_revoca IS NULL AND (sigit_t_contratto.flg_tacito_rinnovo = 1::numeric OR sigit_t_contratto.flg_tacito_rinnovo = 0::numeric AND sigit_t_contratto.data_fine >= now()::date)) q_contratto ON sigit_t_impianto.codice_impianto = q_contratto.codice_impianto
  WHERE sigit_t_unita_immobiliare.flg_principale = 1::numeric;

ALTER TABLE vista_ricerca_impianti
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_ricerca_impianti TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_ricerca_impianti TO sigit_new_rw;
