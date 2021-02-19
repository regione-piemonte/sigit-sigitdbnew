-----------------------------------------------------------------------------------
-- Modifica richiesta da Verner (via mail), per il rilacio di DICEMBRE, 
-- effettuata  in SVI  - 15/11/2018            in TST - 04/12/2018 
-----------------------------------------------------------------------------------
ALTER TABLE sigit_t_dato_distrib ADD COLUMN flg_pf_pg_fatt character varying(2) CONSTRAINT flg_pf_pg_fatt CHECK (flg_pf_pg::text = ANY (ARRAY['PF'::character varying::text, 'PG'::character varying::text]));
ALTER TABLE sigit_t_dato_distrib ADD COLUMN cognome_denom_fatt character varying(500);
ALTER TABLE sigit_t_dato_distrib ADD COLUMN nome_fatt character varying(100);
ALTER TABLE sigit_t_dato_distrib ADD COLUMN cf_piva_fatt character varying(16);
ALTER TABLE sigit_t_dato_distrib ADD COLUMN dug_fatt character varying(16);
ALTER TABLE sigit_t_dato_distrib ADD COLUMN indirizzo_fatt character varying(100);
ALTER TABLE sigit_t_dato_distrib ADD COLUMN civico_fatt character varying(10);
ALTER TABLE sigit_t_dato_distrib ADD COLUMN cap_fatt character varying(5);
ALTER TABLE sigit_t_dato_distrib ADD COLUMN istat_comune_fatt character varying(6);


-------------------------------------------------------------------------------------------------------------
-- Modifica richiesta da Costa (via mail), effettuata in SVI - 21/11/2018                 in TST - 04/12/2018 
-------------------------------------------------------------------------------------------------------------
CREATE SEQUENCE seq_t_azione
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE seq_t_azione
  OWNER TO sigit_new;
GRANT ALL ON SEQUENCE seq_t_azione TO sigit_new;
GRANT SELECT, UPDATE ON SEQUENCE seq_t_azione TO sigit_new_rw;


CREATE SEQUENCE seq_t_doc_azione
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE seq_t_doc_azione
  OWNER TO sigit_new;
GRANT ALL ON SEQUENCE seq_t_doc_azione TO sigit_new;
GRANT SELECT, UPDATE ON SEQUENCE seq_t_doc_azione TO sigit_new_rw;


CREATE SEQUENCE seq_t_verifica
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE seq_t_verifica
  OWNER TO sigit_new;
GRANT ALL ON SEQUENCE seq_t_verifica TO sigit_new;
GRANT SELECT, UPDATE ON SEQUENCE seq_t_verifica TO sigit_new_rw;



-------------------------------------------------------------------------------------------------
-- Modifica richiesta da Verner (via mail), per constraint mancanti  in SVI e TST  - 21/11/2018
-- già eseguiti in prod
-------------------------------------------------------------------------------------------------
/*ALTER TABLE sigit_t_comp_ag
	ADD CONSTRAINT  fk_sigit_d_marca_06 FOREIGN KEY (fk_marca) REFERENCES sigit_d_marca(id_marca);
ALTER TABLE sigit_t_comp_cg
	ADD CONSTRAINT  fk_sigit_d_marca_05 FOREIGN KEY (fk_marca) REFERENCES sigit_d_marca(id_marca);
ALTER TABLE sigit_t_comp_cs
	ADD CONSTRAINT  fk_sigit_d_marca_03 FOREIGN KEY (fk_marca) REFERENCES sigit_d_marca(id_marca);
ALTER TABLE sigit_t_comp_gf
	ADD CONSTRAINT  fk_sigit_d_marca_04 FOREIGN KEY (fk_marca) REFERENCES sigit_d_marca(id_marca);
ALTER TABLE sigit_t_comp_gt
	ADD CONSTRAINT  fk_sigit_d_marca_07 FOREIGN KEY (fk_marca) REFERENCES sigit_d_marca(id_marca);
ALTER TABLE sigit_t_comp_sc
	ADD CONSTRAINT  fk_sigit_d_marca_08 FOREIGN KEY (fk_marca) REFERENCES sigit_d_marca(id_marca);


ALTER TABLE sigit_t_comp_cg
	ADD CONSTRAINT  fk_sigit_d_combustibile_05 FOREIGN KEY (fk_combustibile) REFERENCES sigit_d_combustibile (id_combustibile);
ALTER TABLE sigit_t_comp_gf
 ADD CONSTRAINT  fk_sigit_d_combustibile_06 FOREIGN KEY (fk_combustibile) REFERENCES sigit_d_combustibile (id_combustibile);
ALTER TABLE sigit_t_comp_gt
	ADD CONSTRAINT  fk_sigit_d_combustibile_07 FOREIGN KEY (fk_combustibile) REFERENCES sigit_d_combustibile (id_combustibile);
*/


---------------------------------------------------------------------------------------
-- Modifica richiesta da Actis (via mail)  in SVI  - 27/11/2018     in TST - 04/12/2018 
-- trattamento dati effettuato in svi tst e prod eliminando ,00
---------------------------------------------------------------------------------------

drop view vista_comp_gt_dett;

alter table sigit_t_dett_tipo1 alter column e_n_modulo_termico type integer using cast(e_n_modulo_termico as integer);

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
   LEFT JOIN sigit_t_persona_fisica ON sigit_r_imp_ruolo_pfpg.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica;

ALTER TABLE vista_comp_gt_dett
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_comp_gt_dett TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_comp_gt_dett TO sigit_new_rw;




----------------------------------------------------------------------------
-- Modifica richiesta da Verner (via mail), per il rilacio di DICEMBRE, 
-- effettuata  in SVI  - 28/11/2018                in TST - 04/12/2018
----------------------------------------------------------------------------

CREATE TABLE sigit_d_tipo_manutenzione
(
	id_tipo_manutenzione  INTEGER  NOT NULL ,
	des_tipo_manutenzione  CHARACTER VARYING(100)  NOT NULL 
);

ALTER TABLE sigit_d_tipo_manutenzione
	ADD CONSTRAINT  PK_sigit_d_tipo_manutenzione PRIMARY KEY (id_tipo_manutenzione);


INSERT INTO sigit_d_tipo_manutenzione(id_tipo_manutenzione, des_tipo_manutenzione) VALUES (0, '-');



ALTER TABLE sigit_t_allegato ADD COLUMN fk_tipo_manutenzione integer not null default 0;
ALTER TABLE sigit_t_allegato ADD COLUMN altro_descr character varying(50);


ALTER TABLE sigit_t_allegato
	ADD CONSTRAINT  fk_sigit_d_tipo_manut_01 FOREIGN KEY (fk_tipo_manutenzione) REFERENCES sigit_d_tipo_manutenzione(id_tipo_manutenzione);
	
	
ALTER TABLE sigit_d_tipo_documento ADD COLUMN flg_visu_elenco_manut numeric(1,0) 
	CONSTRAINT dom_0_1_vem CHECK (flg_visu_elenco_manut = ANY (ARRAY[0::numeric, 1::numeric]));
	
	
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
            a.fk_imp_ruolo_pfpg, a.fk_tipo_documento, doc.des_tipo_documento, 
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
      JOIN sigit_r_imp_ruolo_pfpg r1 ON a.fk_imp_ruolo_pfpg = r1.id_imp_ruolo_pfpg
   JOIN sigit_d_ruolo ru ON r1.fk_ruolo = ru.id_ruolo
   JOIN sigit_d_tipo_documento doc ON a.fk_tipo_documento = doc.id_tipo_documento
   JOIN sigit_d_tipo_manutenzione tm ON a.fk_tipo_manutenzione = tm.id_tipo_manutenzione
   JOIN sigit_d_stato_rapp srapp ON a.fk_stato_rapp = srapp.id_stato_rapp
   LEFT JOIN sigit_t_persona_giuridica pg ON r1.fk_persona_giuridica = pg.id_persona_giuridica
   LEFT JOIN sigit_t_impianto i ON r1.codice_impianto = i.codice_impianto
   LEFT JOIN sigit_t_unita_immobiliare u ON r1.codice_impianto = u.codice_impianto
  WHERE u.flg_principale = 1::numeric;

ALTER TABLE vista_ricerca_allegati
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_ricerca_allegati TO sigit_new;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_ricerca_allegati TO sigit_new_rw;

-- mail di Verner/Actis eseguito solo in test 5/12/2018
create table sigit_t_allegato_20181218 as select * from sigit_t_allegato;
update  sigit_t_allegato set fk_tipo_manutenzione = 99 where fk_tipo_documento in (3,4,5,6);

