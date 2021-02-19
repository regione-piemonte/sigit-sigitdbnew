------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Fare il partizionamento su t_impianto, t_allegato, t_comp4, t_dett_tipo_xx,  t_rapp_tipo_xx, t_dato_distrib, t_libretto, t_unita_immobiliare,
--                                             r_comp4_manut, r_comp4_manut_all
-- Valutare se partizionare su tutto tranne le decodifiche
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Richiesta di Mariuccia: mail 24/05/2016 - solo e soltanto su SVIL   :)
-- Fatto anche in TST il 21/09/2016  -- OK
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE sigit_r_comp4_contratto
(
	id_contratto          NUMERIC  NOT NULL ,
	codice_impianto       NUMERIC  NOT NULL ,
	id_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	progressivo           NUMERIC(3)  NOT NULL ,
	data_caricamento      TIMESTAMP  NULL ,
	data_revoca           TIMESTAMP  NULL ,
	data_inserimento_revoca  TIMESTAMP  NULL );

ALTER TABLE sigit_r_comp4_contratto
	ADD CONSTRAINT  PK_sigit_r_comp4_contratto PRIMARY KEY (id_contratto,codice_impianto,id_tipo_componente,progressivo);


ALTER TABLE sigit_r_comp4_contratto
	ADD CONSTRAINT  fk_sigit_t_comp4_08 FOREIGN KEY (codice_impianto,id_tipo_componente,progressivo) REFERENCES sigit_t_comp4(codice_impianto,id_tipo_componente,progressivo);

ALTER TABLE sigit_r_comp4_contratto
	ADD CONSTRAINT  fk_sigit_t_contratto_01 FOREIGN KEY (id_contratto) REFERENCES sigit_t_contratto(id_contratto);





----------------------------------------------------------------------------------------------------------------------------
-- Richiesta di Mariuccia e Todaro calati giù il 08/06/2016   + Viarengo per le tempistiche
----------------------------------------------------------------------------------------------------------------------------
--													SOLO IN SVILUPPO
-- Fatto anche in TST il 21/09/2016  -- OK
---------------------------------------------------------------------------------------------------------------------------
alter table sigit_t_dett_tipo1 drop constraint FK_sigit_t_comp_gt_02;
ALTER TABLE sigit_t_dett_tipo1 DROP CONSTRAINT fk_sigit_t_rapp_tipo1_01;

alter table sigit_t_dett_tipo2 drop constraint FK_sigit_t_comp_gf_01;
ALTER TABLE sigit_t_dett_tipo2 DROP CONSTRAINT fk_sigit_t_rapp_tipo2_01;

alter table sigit_t_dett_tipo3 drop constraint FK_sigit_t_comp_sc_01;
ALTER TABLE sigit_t_dett_tipo3 DROP CONSTRAINT fk_sigit_t_rapp_tipo3_01;

alter table sigit_t_dett_tipo4 drop constraint FK_sigit_t_comp_cg_01;
ALTER TABLE sigit_t_dett_tipo4 DROP CONSTRAINT fk_sigit_t_rapp_tipo4_01;


CREATE TABLE sigit_r_allegato_comp_cg
(
	id_allegato           NUMERIC  NOT NULL ,
	id_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	progressivo           NUMERIC(3)  NOT NULL ,
	codice_impianto       NUMERIC  NOT NULL ,
	data_install          DATE  NOT NULL 
);

ALTER TABLE sigit_r_allegato_comp_cg
	ADD CONSTRAINT  PK_sigit_r_allegato_comp_cg PRIMARY KEY (id_allegato,id_tipo_componente,progressivo,codice_impianto,data_install);



CREATE TABLE sigit_r_allegato_comp_gf
(
	id_allegato           NUMERIC  NOT NULL ,
	id_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	progressivo           NUMERIC(3)  NOT NULL ,
	codice_impianto       NUMERIC  NOT NULL ,
	data_install          DATE  NOT NULL 
);

ALTER TABLE sigit_r_allegato_comp_gf
	ADD CONSTRAINT  PK_sigit_r_allegato_comp_gf PRIMARY KEY (id_allegato,id_tipo_componente,progressivo,codice_impianto,data_install);



CREATE TABLE sigit_r_allegato_comp_gt
(
	id_allegato           NUMERIC  NOT NULL ,
	id_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	progressivo           NUMERIC(3)  NOT NULL ,
	codice_impianto       NUMERIC  NOT NULL ,
	data_install          DATE  NOT NULL 
);



ALTER TABLE sigit_r_allegato_comp_gt
	ADD CONSTRAINT  PK_sigit_r_allegato_comp_gt PRIMARY KEY (id_allegato,id_tipo_componente,progressivo,codice_impianto,data_install);



CREATE TABLE sigit_r_allegato_comp_sc
(
	id_allegato           NUMERIC  NOT NULL ,
	id_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	progressivo           NUMERIC(3)  NOT NULL ,
	codice_impianto       NUMERIC  NOT NULL ,
	data_install          DATE  NOT NULL 
);

ALTER TABLE sigit_r_allegato_comp_sc
	ADD CONSTRAINT  PK_sigit_r_allegato_comp_sc PRIMARY KEY (id_allegato,id_tipo_componente,progressivo,codice_impianto,data_install);



ALTER TABLE sigit_r_allegato_comp_cg
	ADD CONSTRAINT  FK_sigit_t_allegato_14 FOREIGN KEY (id_allegato) REFERENCES sigit_t_allegato(id_allegato);

ALTER TABLE sigit_r_allegato_comp_cg
	ADD CONSTRAINT  FK_sigit_t_comp_cg_01 FOREIGN KEY (id_tipo_componente,progressivo,codice_impianto,data_install) REFERENCES sigit_t_comp_cg(id_tipo_componente,progressivo,codice_impianto,data_install);

ALTER TABLE sigit_r_allegato_comp_gf
	ADD CONSTRAINT  FK_sigit_t_allegato_13 FOREIGN KEY (id_allegato) REFERENCES sigit_t_allegato(id_allegato);

ALTER TABLE sigit_r_allegato_comp_gf
	ADD CONSTRAINT  FK_sigit_t_comp_gf_02 FOREIGN KEY (id_tipo_componente,progressivo,codice_impianto,data_install) REFERENCES sigit_t_comp_gf(id_tipo_componente,progressivo,codice_impianto,data_install);

ALTER TABLE sigit_r_allegato_comp_gt
	ADD CONSTRAINT  FK_sigit_t_allegato_12 FOREIGN KEY (id_allegato) REFERENCES sigit_t_allegato(id_allegato);

ALTER TABLE sigit_r_allegato_comp_gt
	ADD CONSTRAINT  FK_sigit_t_comp_gt_03 FOREIGN KEY (id_tipo_componente,progressivo,codice_impianto,data_install) REFERENCES sigit_t_comp_gt(id_tipo_componente,progressivo,codice_impianto,data_install);

ALTER TABLE sigit_r_allegato_comp_sc
	ADD CONSTRAINT  FK_sigit_t_allegato_14 FOREIGN KEY (id_allegato) REFERENCES sigit_t_allegato(id_allegato);

ALTER TABLE sigit_r_allegato_comp_sc
	ADD CONSTRAINT  FK_sigit_t_comp_sc_02 FOREIGN KEY (id_tipo_componente,progressivo,codice_impianto,data_install) REFERENCES sigit_t_comp_sc(id_tipo_componente,progressivo,codice_impianto,data_install);




-- trattamento dati
insert into sigit_r_allegato_comp_gt (id_allegato, id_tipo_componente, progressivo, codice_impianto,data_install) 
 select  distinct fk_allegato, fk_tipo_componente,progressivo,codice_impianto,data_install from sigit_t_dett_tipo1;

insert into sigit_r_allegato_comp_gf (id_allegato, id_tipo_componente, progressivo,codice_impianto,data_install) 
 select  distinct fk_allegato, fk_tipo_componente,progressivo,codice_impianto,data_install from sigit_t_dett_tipo2;

insert into sigit_r_allegato_comp_sc (id_allegato, id_tipo_componente,progressivo,codice_impianto,data_install) 
 select distinct fk_allegato, fk_tipo_componente,progressivo,codice_impianto,data_install from sigit_t_dett_tipo3;


insert into sigit_r_allegato_comp_cg (id_allegato, id_tipo_componente,progressivo,codice_impianto,data_install) 
 select distinct fk_allegato, fk_tipo_componente,progressivo,codice_impianto,data_install from sigit_t_dett_tipo4;



ALTER TABLE sigit_t_dett_tipo1
	ADD CONSTRAINT  fk_sigit_t_allegato_comp_gt_01 FOREIGN KEY (fk_allegato,fk_tipo_componente,progressivo,codice_impianto,data_install) REFERENCES sigit_r_allegato_comp_gt(id_allegato,id_tipo_componente,progressivo,codice_impianto,data_install);


ALTER TABLE sigit_t_dett_tipo2
	ADD CONSTRAINT  fk_sigit_t_allegato_comp_gf_01 FOREIGN KEY (fk_allegato,fk_tipo_componente,progressivo,codice_impianto,data_install) REFERENCES sigit_r_allegato_comp_gf(id_allegato,id_tipo_componente,progressivo,codice_impianto,data_install);


ALTER TABLE sigit_t_dett_tipo3
	ADD CONSTRAINT  fk_sigit_t_allegato_comp_sc_01 FOREIGN KEY (fk_allegato,fk_tipo_componente,progressivo,codice_impianto,data_install) REFERENCES sigit_r_allegato_comp_sc(id_allegato,id_tipo_componente,progressivo,codice_impianto,data_install);

ALTER TABLE sigit_t_dett_tipo4
	ADD CONSTRAINT  fk_sigit_t_allegato_comp_cg_01 FOREIGN KEY (fk_allegato,fk_tipo_componente,progressivo,codice_impianto,data_install) REFERENCES sigit_r_allegato_comp_cg(id_allegato,id_tipo_componente,progressivo,codice_impianto,data_install);




----------------------------------------------------------------------------------------------------------------------------------
---  Richiesta Todaro, Actis calati giù il 6/7/2016 
---  Eseguito in sviluppo 
---  Fatto anche in TST il 21/09/2016  -- OK
----------------------------------------------------------------------------------------------------------------------------------

alter table sigit_r_allegato_comp_cg add column fk_r_pg NUMERIC(6)  NULL;
alter table sigit_r_allegato_comp_cg add column fk_3r_pg NUMERIC(6)  NULL;
alter table sigit_r_allegato_comp_cg add column fk_r_pf NUMERIC(6)  NULL;


alter table sigit_r_allegato_comp_gf add column fk_r_pg NUMERIC(6)  NULL;
alter table sigit_r_allegato_comp_gf add column fk_3r_pg NUMERIC(6)  NULL;
alter table sigit_r_allegato_comp_gf add column fk_r_pf NUMERIC(6)  NULL;


alter table sigit_r_allegato_comp_gt add column fk_r_pg NUMERIC(6)  NULL;
alter table sigit_r_allegato_comp_gt add column fk_3r_pg NUMERIC(6)  NULL;
alter table sigit_r_allegato_comp_gt add column fk_r_pf NUMERIC(6)  NULL;


alter table sigit_r_allegato_comp_sc add column fk_r_pg NUMERIC(6)  NULL;
alter table sigit_r_allegato_comp_sc add column fk_3r_pg NUMERIC(6)  NULL;
alter table sigit_r_allegato_comp_sc add column fk_r_pf NUMERIC(6)  NULL;



ALTER TABLE sigit_r_allegato_comp_cg
	ADD CONSTRAINT
  FK_sigit_t_pers_giuridica_18 FOREIGN KEY (fk_r_pg) REFERENCES sigit_t_persona_giuridica(id_persona_giuridica);



ALTER TABLE sigit_r_allegato_comp_cg
	ADD CONSTRAINT
  FK_sigit_t_pers_giuridica_17 FOREIGN KEY (fk_3r_pg) REFERENCES sigit_t_persona_giuridica(id_persona_giuridica);



ALTER TABLE sigit_r_allegato_comp_cg
	ADD CONSTRAINT
  FK_sigit_t_persona_fisica_07 FOREIGN KEY (fk_r_pf) REFERENCES sigit_t_persona_fisica(id_persona_fisica);



ALTER TABLE sigit_r_allegato_comp_gf
	ADD CONSTRAINT
  FK_sigit_t_pers_giuridica_21 FOREIGN KEY (fk_r_pg) REFERENCES sigit_t_persona_giuridica(id_persona_giuridica);



ALTER TABLE sigit_r_allegato_comp_gf
	ADD CONSTRAINT
  FK_sigit_t_pers_giuridica_22 FOREIGN KEY (fk_3r_pg) REFERENCES sigit_t_persona_giuridica(id_persona_giuridica);



ALTER TABLE sigit_r_allegato_comp_gf
	ADD CONSTRAINT
  FK_sigit_t_persona_fisica_09 FOREIGN KEY (fk_r_pf) REFERENCES sigit_t_persona_fisica(id_persona_fisica);



ALTER TABLE sigit_r_allegato_comp_gt
	ADD CONSTRAINT
  FK_sigit_t_pers_giuridica_15 FOREIGN KEY (fk_r_pg) REFERENCES sigit_t_persona_giuridica(id_persona_giuridica);



ALTER TABLE sigit_r_allegato_comp_gt
	ADD CONSTRAINT
  FK_sigit_t_pers_giuridica_16 FOREIGN KEY (fk_3r_pg) REFERENCES sigit_t_persona_giuridica(id_persona_giuridica);



ALTER TABLE sigit_r_allegato_comp_gt
	ADD CONSTRAINT
  FK_sigit_t_persona_fisica_06 FOREIGN KEY (fk_r_pf) REFERENCES sigit_t_persona_fisica(id_persona_fisica);


ALTER TABLE sigit_r_allegato_comp_sc
	ADD CONSTRAINT
  FK_sigit_t_pers_giuridica_19 FOREIGN KEY (fk_r_pg) REFERENCES sigit_t_persona_giuridica(id_persona_giuridica);



ALTER TABLE sigit_r_allegato_comp_sc
	ADD CONSTRAINT
  FK_sigit_t_persona_fisica_08 FOREIGN KEY (fk_r_pf) REFERENCES sigit_t_persona_fisica(id_persona_fisica);



ALTER TABLE sigit_r_allegato_comp_sc
	ADD CONSTRAINT
  FK_sigit_t_pers_giuridica_20 FOREIGN KEY (fk_3r_pg) REFERENCES sigit_t_persona_giuridica(id_persona_giuridica);
  
  
  

-----------------------------------------------------------------------------------------
-- Richiesta di Mariuccia calata giù il  17/07/2016 - solo  su SVIL  
--  Fatto anche in TST il 21/09/2016  -- OK 
-----------------------------------------------------------------------------------------

CREATE TABLE sigit_d_ragg_doc_agg
(
	id_ragg_doc_agg       NUMERIC(3)  NOT NULL ,
	des_ragg_doc_agg      CHARACTER VARYING(100)  NULL 
);



ALTER TABLE sigit_d_ragg_doc_agg
	ADD CONSTRAINT  PK_sigit_d_ragg_doc_agg PRIMARY KEY (id_ragg_doc_agg);



CREATE TABLE sigit_d_tipo_doc_agg
(
	id_tipo_doc_agg       NUMERIC(3)  NOT NULL ,
	fk_ragg_doc_agg       NUMERIC(3)  NOT NULL ,
	des_tipo_doc_agg      CHARACTER VARYING(100)  NULL 
);



ALTER TABLE sigit_d_tipo_doc_agg
	ADD CONSTRAINT  PK_sigit_d_tipo_doc_agg PRIMARY KEY (id_tipo_doc_agg);



CREATE TABLE sigit_t_doc_aggiuntiva
(
	id_doc_aggiuntiva     INTEGER  NOT NULL ,
	codice_impianto       NUMERIC  NOT NULL ,
	fk_tipo_docagg        NUMERIC(3)  NOT NULL ,
	fk_imp_ruolo_pfpg     NUMERIC  NULL ,
	nome_doc_originale    CHARACTER VARYING(100)  NULL ,
	nome_doc              CHARACTER VARYING(100)  NULL ,
	uid_index             CHARACTER VARYING(50)  NULL ,
	des_altro_tipodoc     CHARACTER VARYING(100)  NULL ,
	data_ult_mod          TIMESTAMP  NULL ,
	utente_ult_mod        CHARACTER VARYING(16)  NULL,
	data_upload           TIMESTAMP  NULL ,
	data_delete           TIMESTAMP  NULL 
);



ALTER TABLE sigit_t_doc_aggiuntiva
	ADD CONSTRAINT  PK_sigit_t_doc_aggiuntiva PRIMARY KEY (id_doc_aggiuntiva);

ALTER TABLE sigit_d_tipo_doc_agg
	ADD CONSTRAINT  fk_sigit_d_ragg_docagg_01 FOREIGN KEY (fk_ragg_doc_agg) REFERENCES sigit_d_ragg_doc_agg(id_ragg_doc_agg);

ALTER TABLE sigit_t_doc_aggiuntiva
	ADD CONSTRAINT  FK_sigit_t_impianto_13 FOREIGN KEY (codice_impianto) REFERENCES sigit_t_impianto(codice_impianto);

ALTER TABLE sigit_t_doc_aggiuntiva
	ADD CONSTRAINT  fk_sigit_d_tipo_docagg_01 FOREIGN KEY (fk_tipo_docagg) REFERENCES sigit_d_tipo_doc_agg(id_tipo_doc_agg);

ALTER TABLE sigit_t_doc_aggiuntiva
	ADD CONSTRAINT  fk_sigit_t_ispezione_01 FOREIGN KEY (fk_imp_ruolo_pfpg) REFERENCES sigit_t_ispezione(id_imp_ruolo_pfpg);

  
  
  
  
  ----------------------------------------------------------------------------------------------------------------------------------
---  Richiesta Todaroe Mariuccia  calati giù il 23/08/2016 
---  Eseguito in sviluppo 
---  Fatto anche in TST il 21/09/2016  -- OK 
----------------------------------------------------------------------------------------------------------------------------------

 alter TABLE sigit_t_impianto add column flg_tipo_impianto CHARACTER VARYING(1)  NULL  CONSTRAINT  flg_imp_a_c CHECK (flg_tipo_impianto IN ('A','C'));

alter TABLE sigit_t_impianto  add column	flg_apparecc_ui_ext   NUMERIC(1)  NULL  CONSTRAINT  flg_ui_ext_0_1 CHECK (flg_apparecc_ui_ext IN (0,1));
  
  


----------------------------------------------------------------------------------------------------------------------------------
---  Richiesta di Mariuccia a Katia 31/08/2016 
---  Eseguito in sviluppo 
---  Fatto anche in TST il 21/09/2016  -- OK 
----------------------------------------------------------------------------------------------------------------------------------

  CREATE SEQUENCE seq_t_doc_aggiuntiva
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE seq_t_doc_aggiuntiva
  OWNER TO sigit_new;
GRANT ALL ON TABLE seq_t_doc_aggiuntiva TO sigit_new;
GRANT ALL ON TABLE seq_t_doc_aggiuntiva TO sigit_new_rw;


----------------------------------------------------------------------------------------------------------------------------------
---  Richiesta di Mariuccia mail 22/9
---  Eseguito in sviluppo, test
----------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE sigit_t_impianto ADD COLUMN flg_contabilizzazione numeric(1,0) NULL  CONSTRAINT  flg_contab CHECK (flg_contabilizzazione IN (0,1));






----------------------------------------------------------------------------------------------------------------------------------
---  Richiesta Todaro calato giù il 8/7/2016 
---  Eseguito in sviluppo 
---  Fatto anche in TST il 21/09/2016  -- OK
----------------------------------------------------------------------------------------------------------------------------------

create or replace view vista_allegati_componenti
as
select sigit_r_allegato_comp_cg.id_allegato,
  id_tipo_componente, 
  progressivo,
  codice_impianto, 
  data_install,
  fk_r_pg,
  fk_3r_pg,
  fk_r_pf,
  fk_stato_rapp,
  des_stato_rapp,
  data_controllo
from sigit_r_allegato_comp_cg,sigit_t_allegato,sigit_d_stato_rapp
where sigit_r_allegato_comp_cg.id_allegato=sigit_t_allegato.id_allegato
  and sigit_t_allegato.fk_stato_rapp=sigit_d_stato_rapp.id_stato_rapp
union
select sigit_r_allegato_comp_gf.id_allegato,
  id_tipo_componente, 
  progressivo,
  codice_impianto, 
  data_install,
  fk_r_pg,
  fk_3r_pg,
  fk_r_pf,
  fk_stato_rapp,
  des_stato_rapp,
  data_controllo
from sigit_r_allegato_comp_gf,sigit_t_allegato,sigit_d_stato_rapp
where sigit_r_allegato_comp_gf.id_allegato=sigit_t_allegato.id_allegato
  and sigit_t_allegato.fk_stato_rapp=sigit_d_stato_rapp.id_stato_rapp
union
select sigit_r_allegato_comp_gt.id_allegato,
  id_tipo_componente, 
  progressivo,
  codice_impianto, 
  data_install,
  fk_r_pg,
  fk_3r_pg,
  fk_r_pf,
  fk_stato_rapp,
  des_stato_rapp,
  data_controllo
from sigit_r_allegato_comp_gt,sigit_t_allegato,sigit_d_stato_rapp
where sigit_r_allegato_comp_gt.id_allegato=sigit_t_allegato.id_allegato
  and sigit_t_allegato.fk_stato_rapp=sigit_d_stato_rapp.id_stato_rapp  
union
select sigit_r_allegato_comp_sc.id_allegato,
  id_tipo_componente, 
  progressivo,
  codice_impianto, 
  data_install,
  fk_r_pg,
  fk_3r_pg,
  fk_r_pf,
  fk_stato_rapp,
  des_stato_rapp,
  data_controllo
from sigit_r_allegato_comp_sc,sigit_t_allegato,sigit_d_stato_rapp
where sigit_r_allegato_comp_sc.id_allegato=sigit_t_allegato.id_allegato
  and sigit_t_allegato.fk_stato_rapp=sigit_d_stato_rapp.id_stato_rapp;  
  


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Richiesta di Mariuccia + Todaro calati giù il  31/05/2016 - solo e soltanto su SVIL   :)
-- sostituzione sigit_r_impianto_contratto (da eliminare) con sigit_r_comp4_contratto
--
-- Fatto anche in TST il 21/09/2016  -- OK
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DROP VIEW vista_tot_impianto;

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
    sigit_r_comp4_contratto.codice_impianto, 
    sigit_r_comp4_contratto.data_revoca, 
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
   JOIN sigit_r_comp4_contratto ON sigit_t_contratto.id_contratto = sigit_r_comp4_contratto.id_contratto) ON sigit_t_persona_fisica.id_persona_fisica = sigit_t_contratto.fk_pf_responsabile) ON sigit_t_persona_giuridica.id_persona_giuridica = sigit_t_contratto.fk_pg_3_resp
   LEFT JOIN sigit_t_persona_giuridica sigit_t_persona_giuridica_1 ON sigit_t_contratto.fk_pg_responsabile = sigit_t_persona_giuridica_1.id_persona_giuridica
   JOIN sigit_d_tipo_contratto ON sigit_t_contratto.fk_tipo_contratto = sigit_d_tipo_contratto.id_tipo_contratto
  WHERE sigit_r_comp4_contratto.data_revoca IS NULL AND sigit_t_contratto.flg_tacito_rinnovo = 1::numeric OR sigit_r_comp4_contratto.data_revoca IS NULL AND sigit_t_contratto.flg_tacito_rinnovo = 0::numeric AND sigit_t_contratto.data_fine > now()) cont ON sigit_t_impianto.codice_impianto = cont.codice_impianto
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
    sigit_r_comp4_contratto.codice_impianto, 
    sigit_r_comp4_contratto.data_revoca, 
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
   JOIN sigit_r_comp4_contratto ON sigit_t_contratto.id_contratto = sigit_r_comp4_contratto.id_contratto) ON sigit_t_persona_fisica.id_persona_fisica = sigit_t_contratto.fk_pf_responsabile) ON sigit_t_persona_giuridica.id_persona_giuridica = sigit_t_contratto.fk_pg_3_resp
   LEFT JOIN sigit_t_persona_giuridica sigit_t_persona_giuridica_1 ON sigit_t_contratto.fk_pg_responsabile = sigit_t_persona_giuridica_1.id_persona_giuridica
   JOIN sigit_d_tipo_contratto ON sigit_t_contratto.fk_tipo_contratto = sigit_d_tipo_contratto.id_tipo_contratto
  WHERE sigit_r_comp4_contratto.data_revoca IS NULL AND sigit_t_contratto.flg_tacito_rinnovo = 1::numeric OR sigit_r_comp4_contratto.data_revoca IS NULL AND sigit_t_contratto.flg_tacito_rinnovo = 0::numeric AND sigit_t_contratto.data_fine > now()) cont ON sigit_t_impianto.codice_impianto = cont.codice_impianto
  WHERE sigit_t_unita_immobiliare.flg_principale = 1::numeric;

ALTER TABLE vista_tot_impianto
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_tot_impianto TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_tot_impianto TO sigit_new_rw;




----------------------------------------------------------------------------------------------------------------------------------
-- Richiesta Todaro 26/9/2016 - aggiunta campo fk_pg_cat
----------------------------------------------------------------------------------------------------------------------------------

DROP VIEW vista_allegati;

CREATE OR REPLACE VIEW vista_allegati AS 
         SELECT a.id_allegato, a.fk_stato_rapp, a.fk_imp_ruolo_pfpg AS fk_tab, 
            a.fk_tipo_documento, doc.des_tipo_documento, a.fk_sigla_bollino, 
            a.fk_numero_bollino, a.data_controllo, a.f_osservazioni, 
            a.f_raccomandazioni, a.f_prescrizioni, a.f_flg_puo_funzionare, 
            a.f_intervento_entro, r1.codice_impianto,fk_pg_cat
           FROM sigit_t_allegato a
      JOIN sigit_r_imp_ruolo_pfpg r1 ON a.fk_imp_ruolo_pfpg = r1.id_imp_ruolo_pfpg
   JOIN sigit_d_tipo_documento doc ON a.fk_tipo_documento = doc.id_tipo_documento
UNION 
         SELECT DISTINCT a.id_allegato, a.fk_stato_rapp, 
            r1.id_r_comp4_manut AS fk_tab, a.fk_tipo_documento, 
            doc.des_tipo_documento, a.fk_sigla_bollino, a.fk_numero_bollino, 
            a.data_controllo, a.f_osservazioni, a.f_raccomandazioni, 
            a.f_prescrizioni, a.f_flg_puo_funzionare, a.f_intervento_entro, 
            r1.codice_impianto,fk_pg_cat
           FROM sigit_t_allegato a
      JOIN sigit_r_comp4manut_all ON a.id_allegato = sigit_r_comp4manut_all.id_allegato
   JOIN sigit_r_comp4_manut r1 ON sigit_r_comp4manut_all.id_r_comp4_manut = r1.id_r_comp4_manut
   JOIN sigit_d_tipo_documento doc ON a.fk_tipo_documento = doc.id_tipo_documento;

ALTER TABLE vista_allegati
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_allegati TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_allegati TO sigit_new_rw;



----------------------------------------------------------------------------------------------------------------------------------
-- Richiesta Todaro 26/9/2016 - aggiunta campi flg_tipo_impianto, flg_apparecc_ui_ext,flg_contabilizzazione
----------------------------------------------------------------------------------------------------------------------------------

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
    flg_tipo_impianto, flg_apparecc_ui_ext,flg_contabilizzazione
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


DROP VIEW vista_ricerca_3_responsabile;

CREATE OR REPLACE VIEW vista_ricerca_3_responsabile AS 
 SELECT a.codice_impianto, ic.id_tipo_componente,ic.progressivo,a.fk_ruolo, dr.des_ruolo, ic.id_contratto, 
    ic.data_caricamento, ic.data_revoca, ic.data_inserimento_revoca, 
    c.fk_pg_3_resp, c.fk_pg_responsabile, c.fk_pf_responsabile, 
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
   FROM sigit_r_imp_ruolo_pfpg a
   JOIN sigit_t_impianto imp ON imp.codice_impianto = a.codice_impianto
   JOIN sigit_r_comp4_contratto ic ON a.codice_impianto = ic.codice_impianto
   JOIN sigit_t_contratto c ON ic.id_contratto = c.id_contratto
   JOIN sigit_d_ruolo dr ON dr.id_ruolo = a.fk_ruolo
   LEFT JOIN sigit_t_persona_giuridica pg ON pg.id_persona_giuridica = c.fk_pg_responsabile
   LEFT JOIN sigit_t_persona_fisica pf ON pf.id_persona_fisica = c.fk_pf_responsabile
   JOIN sigit_t_persona_giuridica pg3r ON pg3r.id_persona_giuridica = c.fk_pg_3_resp
  WHERE a.fk_persona_fisica = c.fk_pf_responsabile OR a.fk_persona_giuridica = c.fk_pg_responsabile;


ALTER TABLE vista_ricerca_3_responsabile
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_ricerca_3_responsabile TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_ricerca_3_responsabile TO sigit_new_rw;

GRANT SELECT,UPDATE,INSERT,DELETE,TRUNCATE ON ALL TABLES IN SCHEMA sigit_new TO sigit_new_rw;


GRANT SELECT,UPDATE ON ALL SEQUENCES IN SCHEMA sigit_new TO sigit_new_rw;