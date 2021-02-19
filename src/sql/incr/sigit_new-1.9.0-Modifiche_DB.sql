---------------------------------------------------------------------------------------------------------------------
-- Richiesta di Mariuccia il 13/04/2016
---------------------------------------------------------------------------------------------------------------------
ALTER TABLE sigit_t_import ADD COLUMN fk_pg_cat numeric(6,0);
ALTER TABLE sigit_t_import ADD CONSTRAINT  FK_sigit_t_pers_giuridica_13 FOREIGN KEY (fk_pg_cat) REFERENCES sigit_t_persona_giuridica(id_persona_giuridica);



---------------------------------------------------------------------------------------------------------------------
-- Richiesta di Todaro il 12/04/2016
---------------------------------------------------------------------------------------------------------------------
DROP VIEW vista_ricerca_3_responsabile;

CREATE OR REPLACE VIEW vista_ricerca_3_responsabile AS 
 SELECT sigit_t_contratto.id_contratto, 
    sigit_r_impianto_contratto.codice_impianto, 
    sigit_r_impianto_contratto.data_revoca, 
    sigit_r_impianto_contratto.data_caricamento, 
    sigit_r_impianto_contratto.data_inserimento_revoca, 
    sigit_t_contratto.flg_tacito_rinnovo, sigit_t_contratto.fk_pg_responsabile,sigit_t_contratto.fk_pf_responsabile,
    sigit_t_contratto.data_inizio, sigit_t_contratto.data_fine, 
    sigit_t_persona_giuridica.denominazione AS denominazione_3_responsabile, 
    sigit_t_persona_giuridica.sigla_rea AS sigla_rea_3r, 
    sigit_t_persona_giuridica.numero_rea AS numero_rea_3r, 
    sigit_t_persona_giuridica.codice_fiscale AS codice_fiscale_3r
   FROM sigit_t_contratto, sigit_r_impianto_contratto, 
    sigit_t_persona_giuridica
  WHERE sigit_r_impianto_contratto.id_contratto = sigit_t_contratto.id_contratto AND sigit_t_contratto.fk_pg_3_resp = sigit_t_persona_giuridica.id_persona_giuridica;

ALTER TABLE vista_ricerca_3_responsabile
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_ricerca_3_responsabile TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_ricerca_3_responsabile TO sigit_new_rw;
GRANT SELECT ON TABLE vista_ricerca_3_responsabile TO sigit_new_ro;



---------------------------------------------------------------------------------------------------------------------
-- Richiesta di Todaro il 07/04/2016
---------------------------------------------------------------------------------------------------------------------

CREATE TABLE sigit_t_import_xml_lib
(
	codice_impianto       NUMERIC  NOT NULL ,
	xml_libretto          text  NULL ,
	data_ult_mod          DATE  NULL ,
	utente_ult_mod        CHARACTER VARYING(16)  NULL 
);



ALTER TABLE sigit_t_import_xml_lib
	ADD CONSTRAINT  PK_sigit_t_import_xml_lib PRIMARY KEY (codice_impianto);



ALTER TABLE sigit_t_import_xml_lib
	ADD CONSTRAINT  FK_sigit_t_impianto_12 FOREIGN KEY (codice_impianto) REFERENCES sigit_t_impianto(codice_impianto);


ALTER TABLE sigit_t_import_xml_lib OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_t_import_xml_lib TO sigit_new;
GRANT SELECT ON TABLE sigit_t_import_xml_lib TO sigit_new_ro;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE sigit_t_import_xml_lib TO sigit_new_rw;



---------------------------------------------------------------------------------------------------------------------
-- Richiesta di Mariuccia il 30/03/2016
---------------------------------------------------------------------------------------------------------------------
ALTER TABLE sigit_t_allegato ADD COLUMN fk_pg_cat numeric(6,0);
ALTER TABLE sigit_t_allegato ADD CONSTRAINT  FK_sigit_t_pers_giuridica_12 FOREIGN KEY (fk_pg_cat) REFERENCES sigit_t_persona_giuridica(id_persona_giuridica);


---------------------------------------------------------------------------------------------------------------------
-- Verificare con Todaro che si possa eliminare il campo, aggiunto direttam in collaudo e produzione per risolvere errore rilascio 23/7 
-- 26/04/2016  - Todaro conferma
---------------------------------------------------------------------------------------------------------------------

ALTER TABLE sigit_t_import DROP COLUMN data_invio_mail_distrib;
------------------------------------------------------------------------------------


-- Modifiche 11/3/2016 fatte su svil e test ---

alter table sigit_t_persona_fisica add column flg_indirizzo_estero  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_ie1 CHECK (flg_indirizzo_estero IN (0,1));
alter table sigit_t_persona_fisica add column	stato_estero CHARACTER VARYING(50);
alter table sigit_t_persona_fisica add column	citta_estero CHARACTER VARYING(50);
alter table sigit_t_persona_fisica add column	indirizzo_estero CHARACTER VARYING(100);
alter table sigit_t_persona_fisica add column	cap_estero CHARACTER VARYING(10);
	
alter table sigit_t_persona_giuridica add column flg_indirizzo_estero  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_ie CHECK (flg_indirizzo_estero IN (0,1));
alter table sigit_t_persona_giuridica add column	stato_estero CHARACTER VARYING(50);
alter table sigit_t_persona_giuridica add column	citta_estero CHARACTER VARYING(50);
alter table sigit_t_persona_giuridica add column	indirizzo_estero CHARACTER VARYING(100);
alter table sigit_t_persona_giuridica add column	cap_estero CHARACTER VARYING(10);




-- Modifiche 21/3/2016 fatte su svil e test ---
ALTER TABLE sigit_t_comp_br_rc ALTER COLUMN modello TYPE character varying(300);
	
		




-- Modifiche 23/3/2016 effettuate su svil e test, richieste da Todaro ---

DROP VIEW vista_pf_pg;

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
            sigit_t_persona_giuridica.data_cessazione, 
            sigit_t_persona_giuridica.flg_indirizzo_estero,
            sigit_t_persona_giuridica.stato_estero, 
            sigit_t_persona_giuridica.citta_estero, 
            sigit_t_persona_giuridica.indirizzo_estero, 
            sigit_t_persona_giuridica.cap_estero
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
            NULL::date AS data_inizio_attivita, NULL::date AS data_cessazione, 
            sigit_t_persona_fisica.flg_indirizzo_estero,
            sigit_t_persona_fisica.stato_estero, 
            sigit_t_persona_fisica.citta_estero, 
            sigit_t_persona_fisica.indirizzo_estero, 
            sigit_t_persona_fisica.cap_estero
           FROM sigit_t_persona_fisica;

ALTER TABLE vista_pf_pg
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_pf_pg TO sigit_new;
GRANT SELECT ON TABLE vista_pf_pg TO sigit_new_ro;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_pf_pg TO sigit_new_rw;






-- Modifiche 04/04/2016 per Mariuccia - attendiamo modifiche per il sigit_t_dett_tipo2

ALTER TABLE sigit_t_dett_tipo1  ALTER COLUMN e_n_modulo_termico SET NOT NULL;






-- Modifiche 04/04/2016 effettuate su svil e test, richieste da Todaro ---

DROP VIEW vista_ricerca_allegati;

CREATE OR REPLACE VIEW vista_ricerca_allegati AS 
         SELECT DISTINCT a.id_allegato, a.fk_stato_rapp, srapp.des_stato_rapp, 
            a.fk_imp_ruolo_pfpg, a.fk_tipo_documento, doc.des_tipo_documento, 
            a.fk_sigla_bollino, a.fk_numero_bollino, a.data_controllo, 
            a.b_flg_libretto_uso, a.b_flg_dichiar_conform, a.b_flg_lib_imp, 
            a.b_flg_lib_compl, a.f_osservazioni, a.f_raccomandazioni, 
            a.f_prescrizioni, a.f_flg_puo_funzionare, a.f_intervento_entro, 
            a.f_ora_arrivo, a.f_ora_partenza, a.f_denominaz_tecnico, 
            a.f_flg_firma_tecnico, a.f_flg_firma_responsabile, a.data_invio, 
            a.data_respinta, a.nome_allegato, a.a_potenza_termica_nominale_max, 
            a.data_ult_mod, a.utente_ult_mod, a.elenco_combustibili, 
            a.elenco_apparecchiature, a.fk_pg_cat,
            ru.des_ruolo, ru.ruolo_funz, 
            pg.id_persona_giuridica, pg.denominazione AS pg_denominazione, 
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
            a.data_respinta, a.nome_allegato, a.a_potenza_termica_nominale_max, 
            a.data_ult_mod, a.utente_ult_mod, a.elenco_combustibili, 
            a.elenco_apparecchiature, a.fk_pg_cat,
            ru.des_ruolo, ru.ruolo_funz, 
            pg.id_persona_giuridica, pg.denominazione AS pg_denominazione, 
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

ALTER TABLE vista_ricerca_allegati
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_ricerca_allegati TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_ricerca_allegati TO sigit_new_rw;
GRANT SELECT ON TABLE vista_ricerca_allegati TO sigit_new_ro;
