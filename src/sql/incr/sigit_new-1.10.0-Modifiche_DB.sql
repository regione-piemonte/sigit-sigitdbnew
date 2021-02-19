------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Richiesta di Todaro: mail 10/05/2016
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ALTER TABLE sigit_wrk_ruolo_funz    ADD COLUMN flg_impresa numeric(1,0);
ALTER TABLE sigit_wrk_ruolo_funz ADD CONSTRAINT impr_0_1 CHECK (flg_impresa = ANY (ARRAY[0::numeric, 1::numeric]));



------------------------------------------------------------
-- Richiesta di Mariuccia calata il 4/05/2016
-- Primo step
------------------------------------------------------------

ALTER TABLE sigit_t_persona_giuridica  ADD COLUMN fk_stato_pg integer;

CREATE TABLE sigit_d_stato_pg
(
	id_stato_pg           INTEGER  NOT NULL ,
	des_stato_pg          CHARACTER VARYING(50)  NULL 
);

ALTER TABLE sigit_d_stato_pg
	ADD CONSTRAINT  PK_sigit_d_stato_pg PRIMARY KEY (id_stato_pg);



insert into sigit_d_stato_pg (id_stato_pg,des_stato_pg) values (1,'ATTIVO');
insert into sigit_d_stato_pg (id_stato_pg,des_stato_pg) values (2,'CESSATO');
insert into sigit_d_stato_pg (id_stato_pg,des_stato_pg) values (3,'SOSPESO');
insert into sigit_d_stato_pg (id_stato_pg,des_stato_pg) values (4,'RADIATO');





CREATE TABLE sigit_t_storico_var_stato_pg
(
	dt_evento             TIMESTAMP  NOT NULL ,
	id_persona_giuridica  NUMERIC(6)  NOT NULL ,
	dt_inizio_variazione  DATE  NULL ,
	motivo                CHARACTER VARYING(500)  NULL ,
	stato_pg_da           INTEGER  NULL ,
	stato_pg_a            INTEGER  NULL 
);

ALTER TABLE sigit_t_storico_var_stato_pg
	ADD CONSTRAINT  PK_sigit_t_storico_var_stato_p PRIMARY KEY (dt_evento,id_persona_giuridica);



ALTER TABLE sigit_t_storico_var_stato_pg
	ADD  CONSTRAINT  FK_sigit_t_pers_giuridica_14 FOREIGN KEY (id_persona_giuridica) REFERENCES sigit_t_persona_giuridica(id_persona_giuridica);



ALTER TABLE sigit_t_persona_giuridica
	ADD CONSTRAINT  fk_sigit_d_stato_pg_01 FOREIGN KEY (fk_stato_pg) REFERENCES sigit_d_stato_pg(id_stato_pg);



ALTER TABLE sigit_t_storico_var_stato_pg
	ADD  CONSTRAINT  fk_sigit_d_stato_pg_02 FOREIGN KEY (stato_pg_da) REFERENCES sigit_d_stato_pg(id_stato_pg);



ALTER TABLE sigit_t_storico_var_stato_pg
	ADD  CONSTRAINT  fk_sigit_d_stato_pg_03 FOREIGN KEY (stato_pg_a) REFERENCES sigit_d_stato_pg(id_stato_pg);

----------------------------------------------------------------------------------------------------------------------------
-- 2.	Aggiornamento dati SFU-05-v01 - 09/06/2016 - SVI e TST
----------------------------------------------------------------------------------------------------------------------------
update sigit_t_persona_giuridica set fk_stato_pg = 1 where data_cessazione is null;
update sigit_t_persona_giuridica set fk_stato_pg = 2 where data_cessazione is not null;

INSERT INTO sigit_t_storico_var_stato_pg ( dt_evento, id_persona_giuridica, dt_inizio_variazione, motivo, stato_pg_a )
SELECT now() AS dt_evento, 
	sigit_t_persona_giuridica.id_persona_giuridica, 
	 case 
	 	when data_inizio_attivita > to_date('2015-10-14','yyyy-mm-dd')  then data_inizio_attivita
	 	when data_inizio_attivita <= to_date('2015-10-14','yyyy-mm-dd')  then to_date('2015-10-14','yyyy-mm-dd')
	 	else to_date('2015-10-14','yyyy-mm-dd')  	
	 end AS dt_inizio_variazione, 
	'Trattamento per prima tracciatura variazione storico PG' AS motivo, 
	sigit_t_persona_giuridica.fk_stato_pg
FROM sigit_t_persona_giuridica;

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Richiesta di Todaro mail  01/06/2016 -  su SVIL  + TEST
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DROP VIEW if exists vista_ricerca_allegati;

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
            a.elenco_apparecchiature, a.fk_pg_cat, ru.des_ruolo, ru.ruolo_funz, 
            pg.id_persona_giuridica, pg.denominazione AS pg_denominazione, 
            pg.codice_fiscale AS pg_codice_fiscale, pg.fk_stato_pg as pg_fk_stato_pg,
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
            a.elenco_apparecchiature, a.fk_pg_cat, ru.des_ruolo, ru.ruolo_funz, 
            pg.id_persona_giuridica, pg.denominazione AS pg_denominazione, 
            pg.codice_fiscale AS pg_codice_fiscale, pg.fk_stato_pg as pg_fk_stato_pg,
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



--------------------------------------------------------------------------------------------------------------
-- Vista eseguita solo in test con la vecchia tbl sigit_r_impianto_contratto e non in sviluppo dove c'è già la nuova
--  versione della vista da rilasciare ad ottobre che punta alla nuova tbl sigit_r_comp4_contratto
--------------------------------------------------------------------------------------------------------------
DROP VIEW if exists vista_ricerca_impianti;

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
    q_pf_ruolo.id_pf_responsabile,  q_pg_ruolo.id_pg_responsabile,  id_pg_3r,  
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
    sigit_r_impianto_contratto.codice_impianto, 
    sigit_r_impianto_contratto.data_revoca, 
    sigit_t_contratto.flg_tacito_rinnovo, sigit_t_contratto.data_inizio, 
    sigit_t_persona_giuridica_1.id_persona_giuridica AS id_pg_3r,   
    sigit_t_persona_giuridica_1.denominazione AS denominazione_3_responsabile, 
    sigit_t_persona_giuridica_1.sigla_rea AS sigla_rea_3r, 
    sigit_t_persona_giuridica_1.numero_rea AS numero_rea_3r, 
    sigit_t_persona_giuridica_1.codice_fiscale AS codice_fiscale_3r
   FROM sigit_d_tipo_contratto
   JOIN (sigit_r_impianto_contratto
   JOIN sigit_t_contratto ON sigit_r_impianto_contratto.id_contratto = sigit_t_contratto.id_contratto
   JOIN sigit_t_persona_giuridica sigit_t_persona_giuridica_1 ON sigit_t_contratto.fk_pg_3_resp = sigit_t_persona_giuridica_1.id_persona_giuridica) ON sigit_d_tipo_contratto.id_tipo_contratto = sigit_t_contratto.fk_tipo_contratto
  WHERE sigit_r_impianto_contratto.data_revoca IS NULL AND (sigit_t_contratto.flg_tacito_rinnovo = 1::numeric OR sigit_t_contratto.flg_tacito_rinnovo = 0::numeric AND sigit_t_contratto.data_fine >= now()::date)) q_contratto ON sigit_t_impianto.codice_impianto = q_contratto.codice_impianto
  WHERE sigit_t_unita_immobiliare.flg_principale = 1::numeric;

GRANT SELECT ON TABLE vista_ricerca_impianti TO sigit_new_ro;

GRANT SELECT,UPDATE,INSERT,DELETE,TRUNCATE ON ALL TABLES IN SCHEMA sigit_new TO sigit_new_rw;
