----------------------------------------------------------------------------------------
-- 29/10/2018  Lorita
-- Cancellazione FK non più necessaria
----------------------------------------------------------------------------------------
ALTER TABLE sigit_t_ispezione_2018 DROP COLUMN 
  fk_imp_ruolo_pfpg_ispettore CASCADE;
  
----------------------------------------------------------------------------------------
-- 31/10/2018  Lorita
-- Cancellazione campo codice_impianto non più necessario
----------------------------------------------------------------------------------------
ALTER TABLE sigit_r_ispez_ispet DROP COLUMN 
  codice_impianto CASCADE;

CREATE OR REPLACE VIEW vista_ricerca_ispezioni AS 
 SELECT sigit_t_ispezione_2018.id_ispezione_2018, 
    sigit_t_ispezione_2018.codice_impianto, sigit_r_ispez_ispet.id_ispez_ispet, 
    sigit_t_ispezione_2018.fk_stato_ispezione, 
    sigit_d_stato_ispezione.des_stato_ispezione, 
    sigit_t_ispezione_2018.ente_competente, sigit_t_ispezione_2018.dt_creazione, 
    sigit_t_ispezione_2018.dt_conclusione, sigit_t_ispezione_2018.flg_esito, 
    sigit_t_ispezione_2018.note, sigit_t_allegato.id_allegato, 
    sigit_t_allegato.fk_stato_rapp, sigit_d_stato_rapp.des_stato_rapp, 
    sigit_t_allegato.fk_tipo_documento, 
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
    sigit_t_persona_fisica.cognome, sigit_t_persona_fisica.codice_fiscale, 
    sigit_t_ispezione_2018.istat_prov_competenza, 
    sigit_t_ispezione_2018.flg_acc_sostitutivo, 
    sigit_t_ispezione_2018.cf_ispettore_secondario
   FROM sigit_t_ispezione_2018
   LEFT JOIN sigit_r_ispez_ispet ON sigit_t_ispezione_2018.id_ispezione_2018 = sigit_r_ispez_ispet.id_ispezione_2018
   LEFT JOIN sigit_t_persona_fisica ON sigit_r_ispez_ispet.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica
   LEFT JOIN sigit_t_allegato ON sigit_r_ispez_ispet.id_ispez_ispet = sigit_t_allegato.fk_ispez_ispet
   LEFT JOIN sigit_d_tipo_documento ON sigit_t_allegato.fk_tipo_documento = sigit_d_tipo_documento.id_tipo_documento
   LEFT JOIN sigit_d_stato_rapp ON sigit_t_allegato.fk_stato_rapp = sigit_d_stato_rapp.id_stato_rapp
   JOIN sigit_d_stato_ispezione ON sigit_t_ispezione_2018.fk_stato_ispezione = sigit_d_stato_ispezione.id_stato_ispezione
  WHERE sigit_t_ispezione_2018.id_ispezione_2018 <> 0;

ALTER TABLE vista_ricerca_ispezioni
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_ricerca_ispezioni TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_ricerca_ispezioni TO sigit_new_rw;
  
CREATE OR REPLACE VIEW vista_ricerca_allegati AS 
         SELECT DISTINCT a.id_allegato, a.fk_stato_rapp, srapp.des_stato_rapp, 
            a.fk_ispez_ispet, a.fk_tipo_documento, doc.des_tipo_documento, 
            a.fk_sigla_bollino, a.fk_numero_bollino, a.data_controllo, 
            a.b_flg_libretto_uso, a.b_flg_dichiar_conform, a.b_flg_lib_imp, 
            a.b_flg_lib_compl, a.f_osservazioni, a.f_raccomandazioni, 
            a.f_prescrizioni, a.f_flg_puo_funzionare, a.f_intervento_entro, 
            a.f_ora_arrivo, a.f_ora_partenza, a.f_denominaz_tecnico, 
            a.f_flg_firma_tecnico, a.f_flg_firma_responsabile, a.data_invio, 
            a.data_respinta, a.nome_allegato, a.a_potenza_termica_nominale_max, 
            a.data_ult_mod, a.utente_ult_mod, a.elenco_combustibili, 
            a.elenco_apparecchiature, a.fk_pg_cat, a.altro_descr, ru.des_ruolo, 
            ru.ruolo_funz, pg.id_persona_giuridica, 
            pg.denominazione AS pg_denominazione, 
            pg.codice_fiscale AS pg_codice_fiscale, 
            pg.fk_stato_pg AS pg_fk_stato_pg, pg.sigla_rea AS pg_sigla_rea, 
            pg.numero_rea AS pg_numero_rea, r1.codice_impianto, 
            i.denominazione_comune AS comune_impianto, 
            i.sigla_provincia AS sigla_prov_impianto, 
            COALESCE(u.indirizzo_sitad, u.indirizzo_non_trovato) AS indirizzo_unita_immob, 
            u.civico AS civico_unita_immob, a.flg_controllo_bozza, a.uid_index, 
            tm.id_tipo_manutenzione, tm.des_tipo_manutenzione
           FROM sigit_t_allegato a
      JOIN sigit_r_comp4manut_all ON a.id_allegato = sigit_r_comp4manut_all.id_allegato
   JOIN sigit_r_comp4_manut r1 ON sigit_r_comp4manut_all.id_r_comp4_manut = r1.id_r_comp4_manut
   JOIN sigit_d_ruolo ru ON r1.fk_ruolo = ru.id_ruolo
   JOIN sigit_d_tipo_documento doc ON a.fk_tipo_documento = doc.id_tipo_documento
   JOIN sigit_d_tipo_manutenzione tm ON a.fk_tipo_manutenzione = tm.id_tipo_manutenzione
   JOIN sigit_d_stato_rapp srapp ON a.fk_stato_rapp = srapp.id_stato_rapp
   LEFT JOIN sigit_t_persona_giuridica pg ON r1.fk_persona_giuridica = pg.id_persona_giuridica
   LEFT JOIN sigit_t_impianto i ON r1.codice_impianto = i.codice_impianto
   LEFT JOIN sigit_t_unita_immobiliare u ON r1.codice_impianto = u.codice_impianto
  WHERE u.flg_principale = 1::numeric
UNION 
         SELECT DISTINCT a.id_allegato, a.fk_stato_rapp, srapp.des_stato_rapp, 
            a.fk_ispez_ispet, a.fk_tipo_documento, doc.des_tipo_documento, 
            a.fk_sigla_bollino, a.fk_numero_bollino, a.data_controllo, 
            a.b_flg_libretto_uso, a.b_flg_dichiar_conform, a.b_flg_lib_imp, 
            a.b_flg_lib_compl, a.f_osservazioni, a.f_raccomandazioni, 
            a.f_prescrizioni, a.f_flg_puo_funzionare, a.f_intervento_entro, 
            a.f_ora_arrivo, a.f_ora_partenza, a.f_denominaz_tecnico, 
            a.f_flg_firma_tecnico, a.f_flg_firma_responsabile, a.data_invio, 
            a.data_respinta, a.nome_allegato, a.a_potenza_termica_nominale_max, 
            a.data_ult_mod, a.utente_ult_mod, a.elenco_combustibili, 
            a.elenco_apparecchiature, a.fk_pg_cat, a.altro_descr, ru.des_ruolo, 
            ru.ruolo_funz, pg.id_persona_giuridica, 
            pg.denominazione AS pg_denominazione, 
            pg.codice_fiscale AS pg_codice_fiscale, 
            pg.fk_stato_pg AS pg_fk_stato_pg, pg.sigla_rea AS pg_sigla_rea, 
            pg.numero_rea AS pg_numero_rea, i.codice_impianto, 
            i.denominazione_comune AS comune_impianto, 
            i.sigla_provincia AS sigla_prov_impianto, 
            COALESCE(u.indirizzo_sitad, u.indirizzo_non_trovato) AS indirizzo_unita_immob, 
            u.civico AS civico_unita_immob, a.flg_controllo_bozza, a.uid_index, 
            tm.id_tipo_manutenzione, tm.des_tipo_manutenzione
           FROM sigit_t_allegato a
      JOIN sigit_r_ispez_ispet r1 ON a.fk_ispez_ispet = r1.id_ispez_ispet
   JOIN sigit_d_ruolo ru ON r1.fk_ruolo = ru.id_ruolo
   JOIN sigit_d_tipo_documento doc ON a.fk_tipo_documento = doc.id_tipo_documento
   JOIN sigit_d_tipo_manutenzione tm ON a.fk_tipo_manutenzione = tm.id_tipo_manutenzione
   JOIN sigit_d_stato_rapp srapp ON a.fk_stato_rapp = srapp.id_stato_rapp
   JOIN sigit_t_ispezione_2018 isp ON r1.id_ispezione_2018 = isp.id_ispezione_2018
   LEFT JOIN sigit_t_persona_giuridica pg ON r1.fk_persona_giuridica = pg.id_persona_giuridica
   LEFT JOIN sigit_t_impianto i ON isp.codice_impianto = i.codice_impianto
   LEFT JOIN sigit_t_unita_immobiliare u ON i.codice_impianto = u.codice_impianto
  WHERE u.flg_principale = 1::numeric;

ALTER TABLE vista_ricerca_allegati
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_ricerca_allegati TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_ricerca_allegati TO sigit_new_rw;

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

----------------------------------------------------------------------------------------
-- 04/11/2018  Lorita
-- Eliminazione vecchia tabella sigit_t_ispezione, ormai vuota
-- Prima di farlo si cancellano i legami con la sigit_t_doc_aggiuntiva
----------------------------------------------------------------------------------------
ALTER TABLE sigit_t_doc_aggiuntiva DROP COLUMN 
  fk_imp_ruolo_pfpg CASCADE;

drop table sigit_t_ispezione;

----------------------------------------------------------------------------------------
-- 08/11/2018  Lorita
-- Aggiunta campo flg su tabella sigit_t_ispezione_2018 e sulla vista vista_ricerca_ispezioni
----------------------------------------------------------------------------------------
ALTER TABLE sigit_t_ispezione_2018  ADD
	  flg_isp_pagamento NUMERIC(1) NOT NULL DEFAULT 0 CONSTRAINT isp_pag_0_1 CHECK (flg_isp_pagamento IN (0,1));

CREATE OR REPLACE VIEW vista_ricerca_ispezioni AS 
 SELECT sigit_t_ispezione_2018.id_ispezione_2018, 
    sigit_t_ispezione_2018.codice_impianto, sigit_r_ispez_ispet.id_ispez_ispet, 
    sigit_t_ispezione_2018.fk_stato_ispezione, 
    sigit_d_stato_ispezione.des_stato_ispezione, 
    sigit_t_ispezione_2018.ente_competente, sigit_t_ispezione_2018.dt_creazione, 
    sigit_t_ispezione_2018.dt_conclusione, sigit_t_ispezione_2018.flg_esito, 
    sigit_t_ispezione_2018.note, sigit_t_allegato.id_allegato, 
    sigit_t_allegato.fk_stato_rapp, sigit_d_stato_rapp.des_stato_rapp, 
    sigit_t_allegato.fk_tipo_documento, 
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
    sigit_t_persona_fisica.cognome, sigit_t_persona_fisica.codice_fiscale, 
    sigit_t_ispezione_2018.istat_prov_competenza, 
    sigit_t_ispezione_2018.flg_acc_sostitutivo, 
    sigit_t_ispezione_2018.cf_ispettore_secondario,
    sigit_t_ispezione_2018.flg_isp_pagamento
   FROM sigit_t_ispezione_2018
   LEFT JOIN sigit_r_ispez_ispet ON sigit_t_ispezione_2018.id_ispezione_2018 = sigit_r_ispez_ispet.id_ispezione_2018
   LEFT JOIN sigit_t_persona_fisica ON sigit_r_ispez_ispet.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica
   LEFT JOIN sigit_t_allegato ON sigit_r_ispez_ispet.id_ispez_ispet = sigit_t_allegato.fk_ispez_ispet
   LEFT JOIN sigit_d_tipo_documento ON sigit_t_allegato.fk_tipo_documento = sigit_d_tipo_documento.id_tipo_documento
   LEFT JOIN sigit_d_stato_rapp ON sigit_t_allegato.fk_stato_rapp = sigit_d_stato_rapp.id_stato_rapp
   JOIN sigit_d_stato_ispezione ON sigit_t_ispezione_2018.fk_stato_ispezione = sigit_d_stato_ispezione.id_stato_ispezione
  WHERE sigit_t_ispezione_2018.id_ispezione_2018 <> 0;	  

----------------------------------------------------------------------------------------
-- 21/11/2019  Lorita
-- Aggiuntvi vincoli di NOT NULL
----------------------------------------------------------------------------------------
update SIGIT_R_IMP_RUOLO_PFPG ri
set data_inizio = date(data_ult_mod) 
where DATA_INIZIO IS NULL
and data_fine is null;

update SIGIT_R_IMP_RUOLO_PFPG ri
set data_inizio = date(data_fine - interval '1 day')
where DATA_INIZIO IS NULL
and data_fine is not null;

ALTER TABLE SIGIT_R_IMP_RUOLO_PFPG ALTER COLUMN DATA_INIZIO SET NOT NULL;

update SIGIT_R_COMP4_MANUT ri
set data_inizio = date(data_ult_mod) 
where DATA_INIZIO IS NULL
and data_fine is null;

update SIGIT_R_COMP4_MANUT ri
set data_inizio = date(data_fine - interval '1 day')
where DATA_INIZIO IS NULL
and data_fine is not null;

ALTER TABLE SIGIT_R_COMP4_MANUT ALTER COLUMN DATA_INIZIO SET NOT NULL;
