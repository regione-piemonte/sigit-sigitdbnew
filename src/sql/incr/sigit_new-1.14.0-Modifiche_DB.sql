-----------------------------------------------------------------------------------
-- Modifiche primo rilascio 2019 - Terzo responsabile
-- effettuata  in SVI  - 08/01/2019   
-----------------------------------------------------------------------------------


CREATE TABLE sigit_d_autodichiarazione
(
	id_autodichiarazione  INTEGER NOT NULL ,
	des_autodichiarazione  CHARACTER VARYING(200)  NULL 
);

ALTER TABLE sigit_d_autodichiarazione
	ADD CONSTRAINT  PK_sigit_d_autodichiarazione PRIMARY KEY (id_autodichiarazione);


/*
CREATE TABLE sigit_d_ruolo_pa
(
	id_ruolo_pa           INTEGER  NOT NULL ,
	des_ruolo_pa          CHARACTER VARYING(50)  NOT NULL 
);

ALTER TABLE sigit_d_ruolo_pa
	ADD CONSTRAINT  PK_sigit_d_ruolo_pa PRIMARY KEY (id_ruolo_pa);
*/


CREATE TABLE sigit_d_tipo_cessazione
(
	id_tipo_cessazione    INTEGER  NOT NULL ,
	des_tipo_cessazione   CHARACTER VARYING(200)  NULL 
);

ALTER TABLE sigit_d_tipo_cessazione
	ADD CONSTRAINT  PK_sigit_d_tipo_cessazione PRIMARY KEY (id_tipo_cessazione);



CREATE TABLE sigit_r_contr2019_autodichiar
(
	id_contratto          INTEGER  NOT NULL ,
	id_autodichiarazione  INTEGER  NOT NULL ,
	flg_nomina_cessa      CHARACTER VARYING(1)  NOT NULL  CONSTRAINT  dom_n_c CHECK (flg_nomina_cessa IN ('N','C'))
);

ALTER TABLE sigit_r_contr2019_autodichiar
	ADD CONSTRAINT  PK_sigit_r_contr2019_autodichi PRIMARY KEY (id_contratto,id_autodichiarazione,flg_nomina_cessa);


/*
CREATE TABLE sigit_r_pf_ruolo_pa
(
	id_persona_fisica     NUMERIC(6)  NOT NULL ,
	id_ruolo_pa           INTEGER  NOT NULL ,
	istat_abilitazione    CHARACTER VARYING(8)  NOT NULL ,
	data_inizio           DATE  NOT NULL ,
	data_fine             DATE  NULL,
	note									character varying(500) 
);

ALTER TABLE sigit_r_pf_ruolo_pa
	ADD CONSTRAINT  PK_sigit_r_pf_ruolo_pa PRIMARY KEY (id_persona_fisica,id_ruolo_pa,istat_abilitazione, data_inizio);
*/

/*
CREATE TABLE sigit_t_abilitazione
(
	id_ruolo_pa           INTEGER  NOT NULL ,
	istat_abilitazione    CHARACTER VARYING(8)  NOT NULL ,
	mail_comunicazione    CHARACTER VARYING(100)  NULL 
);

ALTER TABLE sigit_t_abilitazione
	ADD CONSTRAINT  PK_sigit_t_abilitazione PRIMARY KEY (id_ruolo_pa,istat_abilitazione);
*/


CREATE TABLE sigit_t_azione_contratto
(
	id_contratto          INTEGER  NOT NULL ,
	dt_azione             TIMESTAMP  NOT NULL ,
	cf_utente_azione      CHARACTER VARYING(16)  NULL ,
	descrizione_azione    CHARACTER VARYING(1000)  NULL ,
	old_data_fine         DATE  NULL 
);

ALTER TABLE sigit_t_azione_contratto
	ADD CONSTRAINT  PK_sigit_t_azione_contratto PRIMARY KEY (id_contratto,dt_azione);



CREATE TABLE sigit_t_contratto_2019
(
	id_contratto          NUMERIC  NOT NULL ,
	fk_pg_3_resp          NUMERIC(6)  NOT NULL ,
	fk_imp_ruolo_pfpg_resp  NUMERIC  NOT NULL ,
	codice_impianto       NUMERIC  NOT NULL ,
	data_inizio           DATE  NOT NULL ,
	data_fine             DATE  NULL ,
	flg_tacito_rinnovo    NUMERIC(1)  NOT NULL  CONSTRAINT  dom_0_1 CHECK (flg_tacito_rinnovo IN (0,1)),
	data_caricamento      TIMESTAMP  NOT NULL ,
	data_ult_mod          TIMESTAMP  NOT NULL ,
	utente_ult_mod        CHARACTER VARYING(16)  NOT NULL ,
	data_cessazione       DATE  NULL ,
	data_inserimento_cessazione  TIMESTAMP  NULL ,
	motivo_cessazione     CHARACTER VARYING(1000)  NULL ,
	fk_tipo_cessazione    INTEGER  NOT NULL ,
	note                  CHARACTER VARYING(1000)  NULL 
);

ALTER TABLE sigit_t_contratto_2019
	ADD CONSTRAINT  PK_sigit_t_contratto_2019 PRIMARY KEY (id_contratto);



CREATE TABLE sigit_t_doc_contratto
(
	id_doc_contratto      INTEGER  NOT NULL ,
	fk_contratto          INTEGER  NOT NULL ,
	nome_doc_originale    CHARACTER VARYING(100)  NULL ,
	nome_doc              CHARACTER VARYING(100)  NULL ,
	descrizione           CHARACTER VARYING(100)  NULL ,
	data_upload           TIMESTAMP  NULL ,
	data_delete           TIMESTAMP  NULL ,
	uid_index             CHARACTER VARYING(50)  NULL ,
	data_ult_mod          DATE  NULL ,
	utente_ult_mod        CHARACTER VARYING(16)  NULL 
);

ALTER TABLE sigit_t_doc_contratto
	ADD CONSTRAINT  PK_sigit_t_doc_contratto PRIMARY KEY (id_doc_contratto);



ALTER TABLE sigit_r_contr2019_autodichiar
	ADD CONSTRAINT  fk_sigit_t_contratto_2019_03 FOREIGN KEY (id_contratto) REFERENCES sigit_t_contratto_2019(id_contratto);

ALTER TABLE sigit_r_contr2019_autodichiar
	ADD CONSTRAINT  fk_sigit_d_autodichiaraz_01 FOREIGN KEY (id_autodichiarazione) REFERENCES sigit_d_autodichiarazione(id_autodichiarazione);
--zz
ALTER TABLE sigit_r_pf_ruolo_pa
	ADD CONSTRAINT  fk_sigit_t_abilitazione_01 FOREIGN KEY (id_ruolo_pa,istat_abilitazione) REFERENCES sigit_t_abilitazione(id_ruolo_pa,istat_abilitazione);

ALTER TABLE sigit_t_abilitazione
	ADD CONSTRAINT  fk_sigit_d_ruolo_pa_01 FOREIGN KEY (id_ruolo_pa) REFERENCES sigit_d_ruolo_pa(id_ruolo_pa);

ALTER TABLE sigit_t_azione_contratto
	ADD CONSTRAINT  fk_sigit_t_contratto_2019_02 FOREIGN KEY (id_contratto) REFERENCES sigit_t_contratto_2019(id_contratto);

ALTER TABLE sigit_t_contratto_2019
	ADD CONSTRAINT  fk_sigit_r_imp_ruolo_pfpg_08 FOREIGN KEY (fk_imp_ruolo_pfpg_resp) REFERENCES sigit_r_imp_ruolo_pfpg(id_imp_ruolo_pfpg);

ALTER TABLE sigit_t_contratto_2019
	ADD CONSTRAINT  fk_sigit_t_impianto_18 FOREIGN KEY (codice_impianto) REFERENCES sigit_t_impianto(codice_impianto);

ALTER TABLE sigit_t_contratto_2019
	ADD CONSTRAINT  FK_sigit_t_pers_giuridica_24 FOREIGN KEY (fk_pg_3_resp) REFERENCES sigit_t_persona_giuridica(id_persona_giuridica);

ALTER TABLE sigit_t_contratto_2019
	ADD CONSTRAINT  fk_sigit_d_tipo_cessazione_01 FOREIGN KEY (fk_tipo_cessazione) REFERENCES sigit_d_tipo_cessazione(id_tipo_cessazione);

ALTER TABLE sigit_t_doc_contratto
	ADD CONSTRAINT  fk_sigit_t_contratto_2019_01 FOREIGN KEY (fk_contratto) REFERENCES sigit_t_contratto_2019(id_contratto);
	
	
	
	
-- Popolamento nuove tavole di decodifica
INSERT INTO sigit_d_tipo_cessazione(id_tipo_cessazione, des_tipo_cessazione) VALUES (0, 'Non cessata');
INSERT INTO sigit_d_tipo_cessazione(id_tipo_cessazione, des_tipo_cessazione) VALUES (1, 'Decadenza');
INSERT INTO sigit_d_tipo_cessazione(id_tipo_cessazione, des_tipo_cessazione) VALUES (2, 'Revoca');
INSERT INTO sigit_d_tipo_cessazione(id_tipo_cessazione, des_tipo_cessazione) VALUES (3, 'Rinuncia');

/*
INSERT INTO sigit_d_ruolo_pa(id_ruolo_pa, des_ruolo_pa) VALUES (1, 'Consultatore');
INSERT INTO sigit_d_ruolo_pa(id_ruolo_pa, des_ruolo_pa) VALUES (2, 'Ispettore');
INSERT INTO sigit_d_ruolo_pa(id_ruolo_pa, des_ruolo_pa) VALUES (3, 'Superuser');
INSERT INTO sigit_d_ruolo_pa(id_ruolo_pa, des_ruolo_pa) VALUES (4, 'Validatore');
*/


INSERT INTO sigit_d_autodichiarazione(id_autodichiarazione, des_autodichiarazione)
    VALUES (1, 'Manca dichiarazione conformità (13/03/90)');
INSERT INTO sigit_d_autodichiarazione(id_autodichiarazione, des_autodichiarazione)
    VALUES (2, 'Manca pratica ISPESL');
INSERT INTO sigit_d_autodichiarazione(id_autodichiarazione, des_autodichiarazione)
    VALUES (3, 'Manca C.P.I. (P>116kW)');
INSERT INTO sigit_d_autodichiarazione(id_autodichiarazione, des_autodichiarazione)
    VALUES (4, 'Manutenzione annuale non effettuata');
INSERT INTO sigit_d_autodichiarazione(id_autodichiarazione, des_autodichiarazione)
    VALUES (5, 'Prova di combustione non effettuata');
INSERT INTO sigit_d_autodichiarazione(id_autodichiarazione, des_autodichiarazione)
    VALUES (6, 'Manca il foro per l’analisi fumi');
INSERT INTO sigit_d_autodichiarazione(id_autodichiarazione, des_autodichiarazione)
    VALUES (7, 'Rendimento di combustione non a norma');
INSERT INTO sigit_d_autodichiarazione(id_autodichiarazione, des_autodichiarazione)
    VALUES (8, 'Eccesso di CO');
INSERT INTO sigit_d_autodichiarazione(id_autodichiarazione, des_autodichiarazione)
    VALUES (9, 'Indice di bacharach superiore a 2 (o a 6)');
INSERT INTO sigit_d_autodichiarazione(id_autodichiarazione, des_autodichiarazione)
    VALUES (10, 'Ventilazione insufficiente');
INSERT INTO sigit_d_autodichiarazione(id_autodichiarazione, des_autodichiarazione)
    VALUES (11, 'Ventilazione non a norma');
INSERT INTO sigit_d_autodichiarazione(id_autodichiarazione, des_autodichiarazione)
    VALUES (12, 'Canale da fumo non a norma');
INSERT INTO sigit_d_autodichiarazione(id_autodichiarazione, des_autodichiarazione)
    VALUES (13, 'Canna fumaria non a norma');
INSERT INTO sigit_d_autodichiarazione(id_autodichiarazione, des_autodichiarazione)
    VALUES (14, 'Impianto a vaso chiuso');
INSERT INTO sigit_d_autodichiarazione(id_autodichiarazione, des_autodichiarazione)
    VALUES (15, 'Impianto elettrico non a norma e/o pericoloso');
INSERT INTO sigit_d_autodichiarazione(id_autodichiarazione, des_autodichiarazione)
    VALUES (16, 'Installazione non conforme a UNI-CIG 7129-7131');
INSERT INTO sigit_d_autodichiarazione(id_autodichiarazione, des_autodichiarazione)
    VALUES (17, 'Rampa gas non conforme a UNI-CIG 8042');
INSERT INTO sigit_d_autodichiarazione(id_autodichiarazione, des_autodichiarazione)
    VALUES (18, 'Impianto da adeguare al DM 01/12/75 (ISPESL)');
INSERT INTO sigit_d_autodichiarazione(id_autodichiarazione, des_autodichiarazione)
    VALUES (19, 'Assenza intercettazione manuale comb. all’esterno');
INSERT INTO sigit_d_autodichiarazione(id_autodichiarazione, des_autodichiarazione)
    VALUES (20, 'Assenza intercettazione elettrica all’esterno');
INSERT INTO sigit_d_autodichiarazione(id_autodichiarazione, des_autodichiarazione)
    VALUES (21, 'Locale caldaia non a norma');
INSERT INTO sigit_d_autodichiarazione(id_autodichiarazione, des_autodichiarazione)
    VALUES (22, 'Locale caldaia sotto il piano di campagna');
INSERT INTO sigit_d_autodichiarazione(id_autodichiarazione, des_autodichiarazione)
    VALUES (23, 'Accesso alla centrale termica non a norma');
INSERT INTO sigit_d_autodichiarazione(id_autodichiarazione, des_autodichiarazione)
    VALUES (24, 'Cartellonistica insufficiente');
INSERT INTO sigit_d_autodichiarazione(id_autodichiarazione, des_autodichiarazione)
    VALUES (25, 'Assenza estintore');
INSERT INTO sigit_d_autodichiarazione(id_autodichiarazione, des_autodichiarazione)
    VALUES (26, 'MManca modello H (DPR 551/99 – 6 aprile 2000)');
INSERT INTO sigit_d_autodichiarazione(id_autodichiarazione, des_autodichiarazione)
    VALUES (27, 'Mancato rispetto dei limiti emissivi');
INSERT INTO sigit_d_autodichiarazione(id_autodichiarazione, des_autodichiarazione)
    VALUES (28, 'Mancato rispetto del DLGS 102/2014');






-- modifiche ricordarsi di aggiungere i constraint di fk
--ALTER TABLE sigit_t_ispezione_2018 ALTER COLUMN note_sveglia SET NULL;
ALTER TABLE sigit_t_ispezione_2018 RENAME cf_ispettore  TO cf_ispettore_secondario;
ALTER TABLE sigit_t_ispezione_2018 ADD COLUMN fk_imp_ruolo_pfpg_ispettore numeric;

--ALTER TABLE sigit_t_allegato ADD COLUMN fk_ispezione_2018 integer NOT NULL DEFAULT 0;

ALTER TABLE sigit_t_accertamento RENAME cf_creazione  TO cf_utente_assegn;
ALTER TABLE sigit_t_accertamento ADD COLUMN sigla_prov_competenza character varying(3);
ALTER TABLE sigit_t_accertamento ADD COLUMN istat_prov_competenza character varying(3);
ALTER TABLE sigit_t_accertamento ADD COLUMN denom_utente_assegn character varying(50);

ALTER TABLE sigit_r_allegato_comp_gt ADD COLUMN fk_imp_ruolo_pfpg_ispettore numeric;

ALTER TABLE sigit_t_impianto ADD COLUMN flg_blocco_nomina_3r numeric(1) CONSTRAINT dom_0_1_blocco3r CHECK (flg_blocco_nomina_3r = ANY (ARRAY[0::numeric, 1::numeric]));



-- vanno aggiunti i record 0 di tutte le altre tavole !!!!!!!!!!!!!!!


/*
INSERT INTO sigit_t_verifica( id_verifica, fk_tipo_verifica, fk_allegato, fk_dato_distrib, codice_impianto, sigla_bollino, numero_bollino)
    VALUES (0,0,0,0,0,'-',0);


INSERT INTO sigit_t_accertamento(
            id_accertamento, fk_verifica, fk_stato_accertamento, codice_impianto, fk_tipo_conclusione, fk_tipo_anomalia)
    VALUES (0,0,0,0,0,0)


INSERT INTO sigit_t_ispezione_2018(
            id_ispezione_2018, fk_stato_ispezione, fk_verifica, fk_accertamento, 
            codice_impianto, cf_ispettore_secondario, data_ispezione, ente_competente, 
            flg_esito, dt_sveglia, note_sveglia, note)
    VALUES (0, 0, 0, 0, 
            0, null, null, null, 
            null, null, null, null);
*/            
            
            
            
            
-- VISTE

DROP VIEW vista_ricerca_3_responsabile;

CREATE OR REPLACE VIEW vista_ricerca_3_responsabile AS 
 SELECT a.codice_impianto, a.fk_ruolo, dr.des_ruolo, c.id_contratto, 
    c.data_caricamento, c.data_cessazione, c.data_inserimento_cessazione, 
    c.fk_pg_3_resp, c.fk_imp_ruolo_pfpg_resp, 
    c.data_inizio AS data_inizio_contratto, c.data_fine AS data_fine_contratto, 
    c.flg_tacito_rinnovo, 
    COALESCE(pg.codice_fiscale, pf.codice_fiscale) AS resp_codice_fiscale, 
    COALESCE(pg.denominazione, pf.cognome) AS resp_denominazione, 
    pf.nome AS resp_nome, pg3r.denominazione AS terzo_resp_denominazione, 
    pg3r.sigla_rea AS terzo_resp_sigla_rea, 
    pg3r.numero_rea AS terzo_resp_numero_rea, 
    pg3r.codice_fiscale AS codice_fiscale_3_resp, 
    pg3r.comune AS denom_comune_3_resp, pg3r.sigla_prov AS sigla_prov_3_resp, 
    pg3r.provincia AS denom_provincia_3_resp, 
    imp.denominazione_comune AS denom_comune_impianto, 
    imp.denominazione_provincia AS denom_prov_impianto, 
    imp.sigla_provincia AS sigla_prov_impianto
   FROM sigit_t_contratto_2019 c
   JOIN sigit_r_imp_ruolo_pfpg a ON a.id_imp_ruolo_pfpg = c.fk_imp_ruolo_pfpg_resp
   JOIN sigit_t_impianto imp ON imp.codice_impianto = c.codice_impianto
   JOIN sigit_d_ruolo dr ON dr.id_ruolo = a.fk_ruolo
   JOIN sigit_t_persona_giuridica pg3r ON pg3r.id_persona_giuridica = c.fk_pg_3_resp
   LEFT JOIN sigit_t_persona_fisica pf ON pf.id_persona_fisica = a.fk_persona_fisica
   LEFT JOIN sigit_t_persona_giuridica pg ON pg.id_persona_giuridica = a.fk_persona_giuridica;

ALTER TABLE vista_ricerca_3_responsabile
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_ricerca_3_responsabile TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_ricerca_3_responsabile TO sigit_new_rw;

  
  
 

--DROP VIEW c;

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
    sigit_t_impianto.flg_contabilizzazione, sigit_d_stato_imp.des_stato
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
  WHERE (sigit_r_imp_ruolo_pfpg_1.fk_ruolo = ANY (ARRAY[4::numeric, 5::numeric, 10::numeric, 11::numeric, 12::numeric, 13::numeric])) 
  AND sigit_r_imp_ruolo_pfpg_1.data_inizio <= now() 
  AND now() <= COALESCE(sigit_r_imp_ruolo_pfpg_1.data_fine::timestamp with time zone, now(), sigit_r_imp_ruolo_pfpg_1.data_fine::timestamp with time zone)) q_pf_ruolo ON sigit_t_impianto.codice_impianto = q_pf_ruolo.codice_impianto
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
  WHERE (sigit_r_imp_ruolo_pfpg.fk_ruolo = ANY (ARRAY[4::numeric, 5::numeric, 10::numeric, 11::numeric, 12::numeric, 13::numeric])) AND 
  sigit_r_imp_ruolo_pfpg.data_inizio <= now() AND 
  now() <= COALESCE(sigit_r_imp_ruolo_pfpg.data_fine::timestamp with time zone, now(), sigit_r_imp_ruolo_pfpg.data_fine::timestamp with time zone)) q_pg_ruolo ON sigit_t_impianto.codice_impianto = q_pg_ruolo.codice_impianto
   LEFT JOIN ( SELECT sigit_t_contratto_2019.id_contratto, 
    sigit_t_contratto_2019.codice_impianto, 
    sigit_t_contratto_2019.data_cessazione, 
    sigit_t_contratto_2019.flg_tacito_rinnovo, 
    sigit_t_contratto_2019.data_inizio, 
    sigit_t_persona_giuridica_1.id_persona_giuridica AS id_pg_3r, 
    sigit_t_persona_giuridica_1.denominazione AS denominazione_3_responsabile, 
    sigit_t_persona_giuridica_1.sigla_rea AS sigla_rea_3r, 
    sigit_t_persona_giuridica_1.numero_rea AS numero_rea_3r, 
    sigit_t_persona_giuridica_1.codice_fiscale AS codice_fiscale_3r
   FROM sigit_t_contratto_2019
   JOIN sigit_t_persona_giuridica sigit_t_persona_giuridica_1 ON sigit_t_contratto_2019.fk_pg_3_resp = sigit_t_persona_giuridica_1.id_persona_giuridica
  WHERE sigit_t_contratto_2019.data_cessazione IS NULL AND 
  (sigit_t_contratto_2019.flg_tacito_rinnovo = 1::numeric OR sigit_t_contratto_2019.flg_tacito_rinnovo = 0::numeric AND sigit_t_contratto_2019.data_fine >= now()::date)) q_contratto ON sigit_t_impianto.codice_impianto = q_contratto.codice_impianto
  WHERE sigit_t_unita_immobiliare.flg_principale = 1::numeric;

ALTER TABLE vista_ricerca_impianti
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_ricerca_impianti TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_ricerca_impianti TO sigit_new_rw;





DROP VIEW vista_tot_impianto;

CREATE OR REPLACE VIEW vista_tot_impianto AS 
         SELECT sigit_t_impianto.codice_impianto, 
            sigit_t_impianto.denominazione_provincia, 
            sigit_t_impianto.sigla_provincia, sigit_t_impianto.istat_comune, 
            sigit_t_impianto.denominazione_comune, 
            COALESCE(sigit_t_unita_immobiliare.indirizzo_sitad, sigit_t_unita_immobiliare.indirizzo_non_trovato) AS indirizzo_sitad, 
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
            sigit_r_imp_ruolo_pfpg.data_inizio AS data_inizio_pfpg, 
            sigit_r_imp_ruolo_pfpg.data_fine AS data_fine_pfpg
           FROM sigit_d_ruolo
      JOIN (sigit_t_persona_fisica
      JOIN (sigit_t_impianto
      JOIN sigit_t_unita_immobiliare ON sigit_t_impianto.codice_impianto = sigit_t_unita_immobiliare.codice_impianto
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_t_impianto.codice_impianto = sigit_r_imp_ruolo_pfpg.codice_impianto) ON sigit_t_persona_fisica.id_persona_fisica = sigit_r_imp_ruolo_pfpg.fk_persona_fisica) ON sigit_d_ruolo.id_ruolo = sigit_r_imp_ruolo_pfpg.fk_ruolo
  WHERE sigit_t_unita_immobiliare.flg_principale = 1::numeric
UNION 
         SELECT sigit_t_impianto.codice_impianto, 
            sigit_t_impianto.denominazione_provincia, 
            sigit_t_impianto.sigla_provincia, sigit_t_impianto.istat_comune, 
            sigit_t_impianto.denominazione_comune, 
            COALESCE(sigit_t_unita_immobiliare.indirizzo_sitad, sigit_t_unita_immobiliare.indirizzo_non_trovato) AS indirizzo_sitad, 
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
            sigit_r_imp_ruolo_pfpg.data_inizio AS data_inizio_pfpg, 
            sigit_r_imp_ruolo_pfpg.data_fine AS data_fine_pfpg
           FROM sigit_d_ruolo
      JOIN (sigit_t_persona_giuridica
      JOIN (sigit_t_impianto
      JOIN sigit_t_unita_immobiliare ON sigit_t_impianto.codice_impianto = sigit_t_unita_immobiliare.codice_impianto
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_t_impianto.codice_impianto = sigit_r_imp_ruolo_pfpg.codice_impianto) ON sigit_t_persona_giuridica.id_persona_giuridica = sigit_r_imp_ruolo_pfpg.fk_persona_giuridica) ON sigit_d_ruolo.id_ruolo = sigit_r_imp_ruolo_pfpg.fk_ruolo
  WHERE sigit_t_unita_immobiliare.flg_principale = 1::numeric;

ALTER TABLE vista_tot_impianto
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_tot_impianto TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_tot_impianto TO sigit_new_rw;



-----------------------------------------------------------------------------------
-- Modifiche effettuate  in SVI  - 21/02/2019   
-----------------------------------------------------------------------------------
CREATE SEQUENCE seq_t_accertamento
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE seq_t_accertamento
  OWNER TO sigit_new;
GRANT ALL ON SEQUENCE seq_t_accertamento TO sigit_new;
GRANT ALL ON SEQUENCE seq_t_accertamento TO sigit_new_rw;

CREATE SEQUENCE seq_t_ispezione_2018
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE seq_t_ispezione_2018
  OWNER TO sigit_new;
GRANT ALL ON SEQUENCE seq_t_ispezione_2018 TO sigit_new;
GRANT ALL ON SEQUENCE seq_t_ispezione_2018 TO sigit_new_rw;

CREATE SEQUENCE seq_t_sanzione
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE seq_t_sanzione
  OWNER TO sigit_new;
GRANT ALL ON SEQUENCE seq_t_sanzione TO sigit_new;
GRANT ALL ON SEQUENCE seq_t_sanzione TO sigit_new_rw;


-------------------------------------------------------------------------------------
-- Modifiche effettuate  in SVIL, TEST, COLL e PROD  - 25/02/2019  (mail Actis 18/02) 
-------------------------------------------------------------------------------------

--DROP VIEW vista_dw_sk4_gt;
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
    sigit_t_libretto.data_consolidamento,
    sigit_t_dett_tipo1.e_nox_ppm, sigit_t_dett_tipo1.e_nox_mg_kwh, sigit_t_dett_tipo1.e_n_modulo_termico
   FROM sigit_t_comp_gt
   JOIN sigit_t_impianto ON sigit_t_impianto.codice_impianto = sigit_t_comp_gt.codice_impianto
   JOIN sigit_d_stato_imp ON sigit_t_impianto.fk_stato = sigit_d_stato_imp.id_stato
   LEFT JOIN sigit_t_libretto ON sigit_t_impianto.codice_impianto = sigit_t_libretto.codice_impianto AND sigit_t_libretto.fk_stato = 2::numeric
   LEFT JOIN sigit_d_marca ON sigit_t_comp_gt.fk_marca = sigit_d_marca.id_marca
   LEFT JOIN sigit_d_fluido ON sigit_t_comp_gt.fk_fluido = sigit_d_fluido.id_fluido
   LEFT JOIN sigit_d_dettaglio_gt ON sigit_t_comp_gt.fk_dettaglio_gt = sigit_d_dettaglio_gt.id_dettaglio_gt
   LEFT JOIN sigit_d_combustibile ON sigit_t_comp_gt.fk_combustibile = sigit_d_combustibile.id_combustibile
   LEFT JOIN sigit_t_dett_tipo1 ON sigit_t_dett_tipo1.codice_impianto = sigit_t_comp_gt.codice_impianto AND sigit_t_dett_tipo1.fk_tipo_componente::text = sigit_t_comp_gt.id_tipo_componente::text AND sigit_t_dett_tipo1.progressivo = sigit_t_comp_gt.progressivo AND sigit_t_dett_tipo1.data_install = sigit_t_comp_gt.data_install
   LEFT JOIN sigit_t_allegato ON sigit_t_dett_tipo1.fk_allegato = sigit_t_allegato.id_allegato AND sigit_t_allegato.fk_stato_rapp = 1::numeric;

ALTER TABLE vista_dw_sk4_gt
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_dw_sk4_gt TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_dw_sk4_gt TO sigit_new_rw;



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
    sigit_t_comp_gf.utente_ult_mod, 
    --sigit_t_comp_gf.potenza_termica_kw,
    case 
			when  sigit_t_comp_gf.raff_potenza_kw > sigit_t_comp_gf.risc_potenza_kw then sigit_t_comp_gf.raff_potenza_kw
			else sigit_t_comp_gf.risc_potenza_kw
		end as	potenza_termica_kw, 
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
   LEFT JOIN sigit_t_allegato ON sigit_t_dett_tipo2.fk_allegato = sigit_t_allegato.id_allegato AND sigit_t_allegato.fk_stato_rapp = 1::numeric;

ALTER TABLE vista_dw_sk4_gf
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_dw_sk4_gf TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_dw_sk4_gf TO sigit_new_rw;



DROP VIEW od_vista_dettaglio_impianti;

CREATE OR REPLACE VIEW od_vista_dettaglio_impianti AS 
        (        (         SELECT i.codice_impianto, 
                            COALESCE(ui.indirizzo_sitad, ui.indirizzo_non_trovato) AS indirizzo_unita_immob, 
                            ui.civico, i.denominazione_comune, 
                            i.denominazione_provincia, ui.l1_2_fk_categoria, 
                            ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, 
                            i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, 
                            i.l1_3_pot_clima_est_kw, 
                            gt.id_tipo_componente AS tipo_componente, 
                            gt.progressivo, gt.data_install, gt.des_marca, 
                            gt.des_combustibile, 
                            gt.des_dettaglio_gt AS des_dettaglio, 
                            gt.potenza_termica_kw AS potenza, 
                            gt.rendimento_perc, 
                            max(gt.data_controllo) AS data_controllo,
                            gt.e_nox_ppm, 
                            gt.e_nox_mg_kwh,
                            gt.e_n_modulo_termico
                           FROM sigit_t_impianto i
                      JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
                 LEFT JOIN vista_dw_sk4_gt gt ON i.codice_impianto = gt.codice_impianto
                WHERE gt.data_dismiss IS NULL and ui.flg_principale=1 and i.fk_stato=1 
                GROUP BY i.codice_impianto, COALESCE(ui.indirizzo_sitad, ui.indirizzo_non_trovato), ui.civico, i.denominazione_comune, i.denominazione_provincia, 
                ui.l1_2_fk_categoria, ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, gt.id_tipo_componente, 
                gt.progressivo, gt.data_install, gt.des_marca, gt.des_combustibile, gt.des_dettaglio_gt, gt.potenza_termica_kw, gt.rendimento_perc, gt.e_nox_ppm, gt.e_nox_mg_kwh, gt.e_n_modulo_termico
                UNION 
                         SELECT i.codice_impianto, 
                            COALESCE(ui.indirizzo_sitad, ui.indirizzo_non_trovato) AS indirizzo_unita_immob, 
                            ui.civico, i.denominazione_comune, 
                            i.denominazione_provincia, ui.l1_2_fk_categoria, 
                            ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, 
                            i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, 
                            i.l1_3_pot_clima_est_kw, 
                            gf.id_tipo_componente AS tipo_componente, 
                            gf.progressivo, gf.data_install, gf.des_marca, 
                            gf.des_combustibile, NULL::text AS des_dettaglio, 
                            gf.potenza_termica_kw AS potenza, 
                            NULL::numeric AS rendimento_perc, 
                            max(gf.data_controllo) AS data_controllo,
                            NULL::numeric AS e_nox_ppm ,
                            NULL::numeric AS e_nox_mg_kwh,
                            NULL::numeric AS e_n_modulo_termico
                           FROM sigit_t_impianto i
                      JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
                 LEFT JOIN vista_dw_sk4_gf gf ON i.codice_impianto = gf.codice_impianto
                WHERE gf.data_dismiss IS NULL and ui.flg_principale=1 and i.fk_stato=1 
                GROUP BY i.codice_impianto, COALESCE(ui.indirizzo_sitad, ui.indirizzo_non_trovato), ui.civico, i.denominazione_comune, i.denominazione_provincia, ui.l1_2_fk_categoria, ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, gf.id_tipo_componente, gf.progressivo, gf.data_install, gf.des_marca, gf.des_combustibile, NULL::text, gf.potenza_termica_kw)
        UNION 
                 SELECT i.codice_impianto, 
                    COALESCE(ui.indirizzo_sitad, ui.indirizzo_non_trovato) AS indirizzo_unita_immob, 
                    ui.civico, i.denominazione_comune, 
                    i.denominazione_provincia, ui.l1_2_fk_categoria, 
                    ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, 
                    i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, 
                    sc.id_tipo_componente AS tipo_componente, sc.progressivo, 
                    sc.data_install, sc.des_marca, 
                    NULL::character varying AS des_combustibile, 
                    NULL::text AS des_dettaglio, 
                    sc.potenza_termica_kw AS potenza, 
                    NULL::numeric AS rendimento_perc, 
                    max(sc.data_controllo) AS data_controllo,
                    NULL::numeric AS e_nox_ppm ,
                    NULL::numeric AS e_nox_mg_kwh,
                    NULL::numeric AS e_n_modulo_termico
              FROM sigit_t_impianto i
              JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
         LEFT JOIN vista_dw_sk4_sc sc ON i.codice_impianto = sc.codice_impianto
        WHERE sc.data_dismiss IS NULL and ui.flg_principale=1 and i.fk_stato=1 
        GROUP BY i.codice_impianto, COALESCE(ui.indirizzo_sitad, ui.indirizzo_non_trovato), ui.civico, i.denominazione_comune, i.denominazione_provincia, ui.l1_2_fk_categoria, ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, sc.id_tipo_componente, sc.progressivo, sc.data_install, sc.des_marca, NULL::text, sc.potenza_termica_kw)
UNION 
         SELECT i.codice_impianto, 
            COALESCE(ui.indirizzo_sitad, ui.indirizzo_non_trovato) AS indirizzo_unita_immob, 
            ui.civico, i.denominazione_comune, i.denominazione_provincia, 
            ui.l1_2_fk_categoria, ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, 
            i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, 
            cg.id_tipo_componente AS tipo_componente, cg.progressivo, 
            cg.data_install, cg.des_marca, cg.des_combustibile, 
            NULL::character varying AS des_dettaglio, 
            cg.potenza_termica_kw AS potenza, NULL::numeric AS rendimento_perc, 
            max(cg.data_controllo) AS data_controllo,
            NULL::numeric AS e_nox_ppm ,
            NULL::numeric AS e_nox_mg_kwh,
            NULL::numeric AS e_n_modulo_termico
           FROM sigit_t_impianto i
      JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
   LEFT JOIN vista_dw_sk4_cg cg ON i.codice_impianto = cg.codice_impianto
   WHERE cg.data_dismiss IS NULL and ui.flg_principale=1 and i.fk_stato=1 
  GROUP BY i.codice_impianto, COALESCE(ui.indirizzo_sitad, ui.indirizzo_non_trovato), ui.civico, i.denominazione_comune, i.denominazione_provincia, ui.l1_2_fk_categoria, ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, cg.id_tipo_componente, cg.progressivo, cg.data_install, cg.des_marca, cg.des_combustibile, cg.potenza_termica_kw;

ALTER TABLE od_vista_dettaglio_impianti
  OWNER TO sigit_new;
GRANT ALL ON TABLE od_vista_dettaglio_impianti TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE od_vista_dettaglio_impianti TO sigit_new_rw;



-----------------------------------------------------------------------------------
-- Modifiche effettuate  in SVI  - 28/02/2019   
-----------------------------------------------------------------------------------
CREATE SEQUENCE seq_t_doc_contratto
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 32
  CACHE 1;
ALTER TABLE seq_t_doc_contratto
  OWNER TO sigit_new;
GRANT ALL ON SEQUENCE seq_t_doc_contratto TO sigit_new;
GRANT ALL ON SEQUENCE seq_t_doc_contratto TO sigit_new_rw;




CREATE OR REPLACE VIEW vista_abilitazione_pf_ruolo_pa AS 
select p.nome, p.cognome,p.codice_fiscale, p.email as email_personale,
  d.des_ruolo_pa,
  a.istat_abilitazione, a.mail_comunicazione,
  r.data_inizio, r.data_fine, r.note
from sigit_r_pf_ruolo_pa r, sigit_t_abilitazione a, sigit_d_ruolo_pa d, sigit_t_persona_fisica p
where r.id_ruolo_pa=d.id_ruolo_pa
  and r.id_ruolo_pa=a.id_ruolo_pa
  and r.istat_abilitazione=a.istat_abilitazione
  and r.id_persona_fisica= p.id_persona_fisica;
  
  
  
-----------------------------------------------------------------------------------
-- Modifiche effettuate  in SVI  - 01/03/2019   
-----------------------------------------------------------------------------------
  
DROP VIEW vista_ricerca_comp;
CREATE OR REPLACE VIEW vista_ricerca_comp AS 
 SELECT DISTINCT comp.codice_impianto, comp.id_tipo_componente, 
    comp.progressivo, comp.fk_marca, comp.fk_combustibile, comp.modello, 
    comp.potenza_termica_kw, comp.data_install, comp.matricola, 
    comp.data_dismiss, comp.flg_dismissione, comp.rendimento_perc 
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
                                                            sigit_t_comp_gf.flg_dismissione,
							    NULL::numeric AS rendimento_perc 
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
                                                            sigit_t_comp_cs.flg_dismissione,
							    NULL::numeric AS rendimento_perc 
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
                                                    sigit_t_comp_ag.flg_dismissione,
						    NULL::numeric AS rendimento_perc 
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
                                            sigit_t_comp_cg.flg_dismissione,
					    NULL::numeric AS rendimento_perc 
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
                                    sigit_t_comp_sc.flg_dismissione,
				    NULL::numeric AS rendimento_perc 
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
                            sigit_t_comp_gt.flg_dismissione,
			    sigit_t_comp_gt.rendimento_perc 
                           FROM sigit_t_comp_gt)
        UNION 
                 SELECT sigit_t_comp_x.codice_impianto, 
                    sigit_t_comp_x.id_tipo_componente, 
                    sigit_t_comp_x.progressivo, sigit_t_comp_x.data_install, 
                    sigit_t_comp_x.fk_marca, NULL::numeric AS fk_combustibile, 
                    sigit_t_comp_x.modello, NULL::numeric AS potenza_termica_kw, 
                    sigit_t_comp_x.matricola, sigit_t_comp_x.data_dismiss, 
                    sigit_t_comp_x.flg_dismissione,
		    NULL::numeric AS rendimento_perc 
                   FROM sigit_t_comp_x) comp;

ALTER TABLE vista_ricerca_comp
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_ricerca_comp TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_ricerca_comp TO sigit_new_rw;



-----------------------------------------------------------------------------------
-- Modifiche effettuate  in SVI  - 07/03/2019  
-- Sganciamo sigit_r_allegato_comp_gf/gt/cg/sc da sigit_t_contratto e, dopo
-- aver effettuato il porting dei dati, li agganciamo a sigit_t_contratto_2019
-----------------------------------------------------------------------------------
ALTER TABLE sigit_r_allegato_comp_gf DROP CONSTRAINT fk_sigit_t_contratto_04;
ALTER TABLE sigit_r_allegato_comp_gt DROP CONSTRAINT fk_sigit_t_contratto_05;
ALTER TABLE sigit_r_allegato_comp_cg DROP CONSTRAINT fk_sigit_t_contratto_06;
ALTER TABLE sigit_r_allegato_comp_sc DROP CONSTRAINT fk_sigit_t_contratto_07;




-- porting contratti (da fare dopo)
/*
--insert into sigit_t_contratto_2019  select * from v_chk_migrazione_contratti_vers2_pfpg


-- Creazione nuovi constraint
ALTER TABLE sigit_r_allegato_comp_gf
  ADD CONSTRAINT fk_sigit_t_contratto_04 FOREIGN KEY (fk_contratto)
      REFERENCES sigit_t_contratto_2019 (id_contratto) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE sigit_r_allegato_comp_gt
  ADD CONSTRAINT fk_sigit_t_contratto_05 FOREIGN KEY (fk_contratto)
      REFERENCES sigit_t_contratto_2019 (id_contratto) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;
      
ALTER TABLE sigit_r_allegato_comp_cg
  ADD CONSTRAINT fk_sigit_t_contratto_06 FOREIGN KEY (fk_contratto)
      REFERENCES sigit_t_contratto (id_contratto) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;

ALTER TABLE sigit_r_allegato_comp_sc
  ADD CONSTRAINT fk_sigit_t_contratto_07 FOREIGN KEY (fk_contratto)
      REFERENCES sigit_t_contratto_2019 (id_contratto) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;            	
*/


-----------------------------------------------------------------------------------
-- Modifiche effettuate  in SVI  - 19/03/2019  - mail Todaro 
-----------------------------------------------------------------------------------
ALTER TABLE sigit_t_import_distrib
   ADD COLUMN data_ult_mod timestamp without time zone NOT NULL DEFAULT now();

ALTER TABLE sigit_t_import_distrib
   ADD COLUMN utente_ult_mod character varying(16) NOT NULL DEFAULT 'TRATTAMENTO DATI';

ALTER TABLE sigit_t_import_distrib
   ADD COLUMN utente_caricamento character varying(16) NOT NULL DEFAULT 'TRATTAMENTO DATI';


------------------------------------------------------------------------
-- Modifiche effettuate  in SVI  - 26/03/2019  - mail Todaro 
------------------------------------------------------------------------
ALTER TABLE sigit_t_dato_distrib
   ALTER COLUMN indirizzo_fatt TYPE character varying(250);
   
   
-- vista per la migrazione dei contratti 
CREATE OR REPLACE VIEW v_chk_migrazione_contratti_vers2_pfpg AS 
         SELECT sigit_t_contratto.id_contratto, sigit_t_contratto.fk_pg_3_resp, 
            sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg, 
            sigit_r_comp4_contratto.codice_impianto, 
            sigit_t_contratto.data_inizio, sigit_t_contratto.data_fine, 
            sigit_t_contratto.flg_tacito_rinnovo, 
            max(sigit_r_comp4_contratto.data_caricamento) AS data_caricamento, 
            sigit_t_contratto.data_ult_mod, sigit_t_contratto.utente_ult_mod, 
            sigit_r_comp4_contratto.data_revoca AS data_cessazione, 
            max(sigit_r_comp4_contratto.data_inserimento_revoca) AS data_inserimento_cessazione, 
            NULL::text AS motivo_cessazione, 
                CASE
                    WHEN sigit_r_comp4_contratto.data_revoca IS NULL THEN 0
                    ELSE 3
                END AS fk_tipo_cessazione
           FROM sigit_t_contratto
      JOIN sigit_r_comp4_contratto ON sigit_t_contratto.id_contratto = sigit_r_comp4_contratto.id_contratto
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_t_contratto.fk_pf_responsabile = sigit_r_imp_ruolo_pfpg.fk_persona_fisica AND sigit_r_comp4_contratto.codice_impianto = sigit_r_imp_ruolo_pfpg.codice_impianto
  WHERE sigit_r_imp_ruolo_pfpg.data_inizio <= sigit_t_contratto.data_inizio AND sigit_r_imp_ruolo_pfpg.data_fine IS NULL OR sigit_r_imp_ruolo_pfpg.data_inizio <= sigit_t_contratto.data_inizio AND sigit_r_imp_ruolo_pfpg.data_fine >= sigit_t_contratto.data_inizio
  GROUP BY sigit_t_contratto.id_contratto, sigit_t_contratto.fk_pg_3_resp, sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg, sigit_r_comp4_contratto.codice_impianto, sigit_t_contratto.data_inizio, sigit_t_contratto.data_fine, sigit_t_contratto.flg_tacito_rinnovo, sigit_t_contratto.data_ult_mod, sigit_t_contratto.utente_ult_mod, sigit_r_comp4_contratto.data_revoca, NULL::text, 
      CASE
          WHEN sigit_r_comp4_contratto.data_revoca IS NULL THEN 0
          ELSE 3
      END
 HAVING sigit_r_imp_ruolo_pfpg.fk_ruolo = ANY (ARRAY[4::numeric, 5::numeric, 10::numeric, 11::numeric, 12::numeric, 13::numeric])
UNION 
         SELECT sigit_t_contratto.id_contratto, sigit_t_contratto.fk_pg_3_resp, 
            sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg, 
            sigit_r_comp4_contratto.codice_impianto, 
            sigit_t_contratto.data_inizio, sigit_t_contratto.data_fine, 
            sigit_t_contratto.flg_tacito_rinnovo, 
            max(sigit_r_comp4_contratto.data_caricamento) AS data_caricamento, 
            sigit_t_contratto.data_ult_mod, sigit_t_contratto.utente_ult_mod, 
            sigit_r_comp4_contratto.data_revoca AS data_cessazione, 
            max(sigit_r_comp4_contratto.data_inserimento_revoca) AS data_inserimento_cessazione, 
            NULL::text AS motivo_cessazione, 
                CASE
                    WHEN sigit_r_comp4_contratto.data_revoca IS NULL THEN 0
                    ELSE 3
                END AS fk_tipo_cessazione
           FROM sigit_t_contratto
      JOIN sigit_r_comp4_contratto ON sigit_t_contratto.id_contratto = sigit_r_comp4_contratto.id_contratto
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_t_contratto.fk_pg_responsabile = sigit_r_imp_ruolo_pfpg.fk_persona_giuridica AND sigit_r_comp4_contratto.codice_impianto = sigit_r_imp_ruolo_pfpg.codice_impianto
  WHERE sigit_r_imp_ruolo_pfpg.data_inizio <= sigit_t_contratto.data_inizio AND sigit_r_imp_ruolo_pfpg.data_fine IS NULL OR sigit_r_imp_ruolo_pfpg.data_inizio <= sigit_t_contratto.data_inizio AND sigit_r_imp_ruolo_pfpg.data_fine >= sigit_t_contratto.data_inizio
  GROUP BY sigit_t_contratto.id_contratto, sigit_t_contratto.fk_pg_3_resp, sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg, sigit_r_comp4_contratto.codice_impianto, sigit_t_contratto.data_inizio, sigit_t_contratto.data_fine, sigit_t_contratto.flg_tacito_rinnovo, sigit_t_contratto.data_ult_mod, sigit_t_contratto.utente_ult_mod, sigit_r_comp4_contratto.data_revoca, NULL::text, 
      CASE
          WHEN sigit_r_comp4_contratto.data_revoca IS NULL THEN 0
          ELSE 3
      END
 HAVING sigit_r_imp_ruolo_pfpg.fk_ruolo = ANY (ARRAY[4::numeric, 5::numeric, 10::numeric, 11::numeric, 12::numeric, 13::numeric])
  ORDER BY 1;

ALTER TABLE v_chk_migrazione_contratti_vers2_pfpg
  OWNER TO sigit_new;
GRANT ALL ON TABLE v_chk_migrazione_contratti_vers2_pfpg TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE v_chk_migrazione_contratti_vers2_pfpg TO sigit_new_rw;



-----------------------------------------------------------------------------------
-- Modifiche effettuate  in SVI  - 01/04/2019  - mail Actis 
-----------------------------------------------------------------------------------
DROP VIEW vista_comp_sr;

ALTER TABLE sigit_t_comp_sr ALTER COLUMN num_pti_regolazione TYPE numeric(4,0);

CREATE OR REPLACE VIEW vista_comp_sr AS 
 SELECT sigit_t_comp_x.codice_impianto, sigit_t_comp_x.id_tipo_componente, 
    sigit_t_comp_x.progressivo, sigit_t_comp_x.data_install, 
    sigit_t_comp_x.data_dismiss, sigit_t_comp_x.matricola, 
    sigit_t_comp_x.fk_marca, sigit_d_marca.des_marca, sigit_t_comp_x.modello, 
    sigit_t_comp_x.flg_dismissione, sigit_t_comp_x.data_ult_mod, 
    sigit_t_comp_x.utente_ult_mod, sigit_t_comp_sr.num_pti_regolazione, 
    sigit_t_comp_sr.num_liv_temp
   FROM sigit_t_comp_x
   JOIN sigit_t_comp_sr ON sigit_t_comp_x.data_install = sigit_t_comp_sr.data_install AND sigit_t_comp_x.progressivo = sigit_t_comp_sr.progressivo AND sigit_t_comp_x.id_tipo_componente::text = sigit_t_comp_sr.id_tipo_componente::text AND sigit_t_comp_x.codice_impianto = sigit_t_comp_sr.codice_impianto
   LEFT JOIN sigit_d_marca ON sigit_t_comp_x.fk_marca = sigit_d_marca.id_marca;

ALTER TABLE vista_comp_sr
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_comp_sr TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_comp_sr TO sigit_new_rw;



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
            sigit_t_dett_tipo1.e_nox_ppm, sigit_t_dett_tipo1.e_nox_mg_kwh, 
            sigit_t_dett_tipo1.data_ult_mod AS data_ult_mod_dett, 
            sigit_t_dett_tipo1.utente_ult_mod AS utente_ult_mod_dett, 
            sigit_t_allegato.data_controllo, sigit_t_allegato.fk_stato_rapp, 
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
      JOIN sigit_t_allegato ON sigit_t_dett_tipo1.fk_allegato = sigit_t_allegato.id_allegato AND sigit_t_allegato.fk_stato_rapp <> 2::numeric
   JOIN sigit_r_comp4manut_all ON sigit_r_comp4manut_all.id_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_comp4_manut ON sigit_r_comp4_manut.id_r_comp4_manut = sigit_r_comp4manut_all.id_r_comp4_manut
   JOIN sigit_t_persona_giuridica ON sigit_r_comp4_manut.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
  where sigit_t_allegato.fk_tipo_documento = 3
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
            sigit_t_dett_tipo1.e_nox_ppm, sigit_t_dett_tipo1.e_nox_mg_kwh, 
            sigit_t_dett_tipo1.data_ult_mod AS data_ult_mod_dett, 
            sigit_t_dett_tipo1.utente_ult_mod AS utente_ult_mod_dett, 
            sigit_t_allegato.data_controllo, sigit_t_allegato.fk_stato_rapp, 
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
      JOIN sigit_t_allegato ON sigit_t_dett_tipo1.fk_allegato = sigit_t_allegato.id_allegato AND sigit_t_allegato.fk_stato_rapp <> 2::numeric
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg = sigit_t_allegato.fk_imp_ruolo_pfpg
   LEFT JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
   LEFT JOIN sigit_t_persona_fisica ON sigit_r_imp_ruolo_pfpg.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica
   where sigit_t_allegato.fk_tipo_documento = 3;




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
            sigit_t_allegato.data_controllo, sigit_t_allegato.fk_stato_rapp, 
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
      JOIN sigit_t_allegato ON sigit_t_dett_tipo2.fk_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_comp4manut_all ON sigit_r_comp4manut_all.id_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_comp4_manut ON sigit_r_comp4_manut.id_r_comp4_manut = sigit_r_comp4manut_all.id_r_comp4_manut
   JOIN sigit_t_persona_giuridica ON sigit_r_comp4_manut.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
   where sigit_t_allegato.fk_tipo_documento = 4
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
            sigit_t_allegato.data_controllo, sigit_t_allegato.fk_stato_rapp, 
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
      JOIN sigit_t_allegato ON sigit_t_dett_tipo2.fk_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg = sigit_t_allegato.fk_imp_ruolo_pfpg
   LEFT JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
   LEFT JOIN sigit_t_persona_fisica ON sigit_r_imp_ruolo_pfpg.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica
   where sigit_t_allegato.fk_tipo_documento = 4;
    
    
    
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
            sigit_t_allegato.data_controllo, sigit_t_allegato.fk_stato_rapp, 
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
   JOIN sigit_t_allegato ON sigit_t_dett_tipo4.fk_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_comp4manut_all ON sigit_r_comp4manut_all.id_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_comp4_manut ON sigit_r_comp4_manut.id_r_comp4_manut = sigit_r_comp4manut_all.id_r_comp4_manut
   JOIN sigit_t_persona_giuridica ON sigit_r_comp4_manut.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
   where sigit_t_allegato.fk_tipo_documento = 6
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
            sigit_t_allegato.data_controllo, sigit_t_allegato.fk_stato_rapp, 
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
   JOIN sigit_t_allegato ON sigit_t_dett_tipo4.fk_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg = sigit_t_allegato.fk_imp_ruolo_pfpg
   LEFT JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
   LEFT JOIN sigit_t_persona_fisica ON sigit_r_imp_ruolo_pfpg.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica
   where sigit_t_allegato.fk_tipo_documento = 6;



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
            sigit_t_allegato.data_controllo, sigit_t_allegato.fk_stato_rapp, 
            sigit_t_persona_giuridica.sigla_rea, 
            sigit_t_persona_giuridica.numero_rea, 
            sigit_t_persona_giuridica.id_persona_giuridica, 
            sigit_r_comp4_manut.fk_ruolo
           FROM sigit_t_dett_tipo3
      JOIN sigit_t_allegato ON sigit_t_dett_tipo3.fk_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_comp4manut_all ON sigit_r_comp4manut_all.id_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_comp4_manut ON sigit_r_comp4_manut.id_r_comp4_manut = sigit_r_comp4manut_all.id_r_comp4_manut
   JOIN sigit_t_persona_giuridica ON sigit_r_comp4_manut.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
   where sigit_t_allegato.fk_tipo_documento = 5
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
            sigit_t_allegato.data_controllo, sigit_t_allegato.fk_stato_rapp, 
            sigit_t_persona_giuridica.sigla_rea, 
            sigit_t_persona_giuridica.numero_rea, 
            COALESCE(sigit_t_persona_giuridica.id_persona_giuridica, sigit_t_persona_fisica.id_persona_fisica, sigit_t_persona_giuridica.id_persona_giuridica) AS id_persona_giuridica, 
            sigit_r_imp_ruolo_pfpg.fk_ruolo
           FROM sigit_t_dett_tipo3
      JOIN sigit_t_allegato ON sigit_t_dett_tipo3.fk_allegato = sigit_t_allegato.id_allegato
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg = sigit_t_allegato.fk_imp_ruolo_pfpg
   LEFT JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
   LEFT JOIN sigit_t_persona_fisica ON sigit_r_imp_ruolo_pfpg.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica
   where sigit_t_allegato.fk_tipo_documento = 5;
    
    
    
INSERT INTO sigit_d_tipo_azione(id_tipo_azione, des_tipo_azione) VALUES (1, 'VERIFICA');
INSERT INTO sigit_d_tipo_azione(id_tipo_azione, des_tipo_azione) VALUES (2, 'ACCERTAMENTO');
INSERT INTO sigit_d_tipo_azione(id_tipo_azione, des_tipo_azione) VALUES (3, 'ISPEZIONE');
INSERT INTO sigit_d_tipo_azione(id_tipo_azione, des_tipo_azione) VALUES (4, 'SANZIONE');


--INSERT INTO sigit_d_tipo_verifica(id_tipo_verifica, des_tipo_verifica) VALUES (0, 'Dato non presente');
INSERT INTO sigit_d_tipo_verifica(id_tipo_verifica, des_tipo_verifica) VALUES (1, 'Impianto');
INSERT INTO sigit_d_tipo_verifica(id_tipo_verifica, des_tipo_verifica) VALUES (2, 'Rapporto Efficienza Energetica (REE)');
INSERT INTO sigit_d_tipo_verifica(id_tipo_verifica, des_tipo_verifica) VALUES (3, 'Relazione Esimente');
INSERT INTO sigit_d_tipo_verifica(id_tipo_verifica, des_tipo_verifica) VALUES (4, 'Dato distributore');
INSERT INTO sigit_d_tipo_verifica(id_tipo_verifica, des_tipo_verifica) VALUES (5, 'Segnalazione');
INSERT INTO sigit_d_tipo_verifica(id_tipo_verifica, des_tipo_verifica) VALUES (6, 'Decadenza 3 Responsabile');
INSERT INTO sigit_d_tipo_verifica(id_tipo_verifica, des_tipo_verifica) VALUES (7, 'Altro');


--INSERT INTO sigit_d_tipo_conclusione(id_tipo_conclusione, des_tipo_conclusione) VALUES (0, 'Dato non presente');    
INSERT INTO sigit_d_tipo_conclusione(id_tipo_conclusione, des_tipo_conclusione) VALUES (1, 'Positivo');    
INSERT INTO sigit_d_tipo_conclusione(id_tipo_conclusione, des_tipo_conclusione) VALUES (2, 'Negativo');    


INSERT INTO sigit_d_stato_sanzione(id_stato_sanzione, des_stato_sanzione) VALUES (1, 'BOZZA');
INSERT INTO sigit_d_stato_sanzione(id_stato_sanzione, des_stato_sanzione) VALUES (2, 'COMUNICATA');
INSERT INTO sigit_d_stato_sanzione(id_stato_sanzione, des_stato_sanzione) VALUES (3, 'PAGATA');
INSERT INTO sigit_d_stato_sanzione(id_stato_sanzione, des_stato_sanzione) VALUES (4, 'ANNULLATA');


INSERT INTO sigit_t_sanzione(id_sanzione, fk_stato_sanzione, fk_ispezione_2018, fk_accertamento, 
            fk_pf_sanzionata, fk_pg_sanzionata)
    VALUES (0, 0, 0, 0, 0, -2);
    
    
CREATE INDEX IE1_sigit_t_libretto ON sigit_t_libretto (codice_impianto  ASC);
    