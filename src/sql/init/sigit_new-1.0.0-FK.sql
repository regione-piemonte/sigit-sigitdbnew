
ALTER TABLE sigit_r_imp_ruolo_pfpg
	ADD CONSTRAINT  FK_sigit_d_ruolo_01 FOREIGN KEY (fk_ruolo) REFERENCES sigit_d_ruolo(id_ruolo);



ALTER TABLE sigit_r_imp_ruolo_pfpg
	ADD CONSTRAINT  FK_sigit_t_impianto_01 FOREIGN KEY (codice_impianto) REFERENCES sigit_t_impianto(codice_impianto);



ALTER TABLE sigit_r_imp_ruolo_pfpg
	ADD CONSTRAINT  FK_sigit_t_persona_fisica_02 FOREIGN KEY (fk_persona_fisica) REFERENCES sigit_t_persona_fisica(id_persona_fisica);



ALTER TABLE sigit_r_imp_ruolo_pfpg
	ADD CONSTRAINT  FK_sigit_t_per_giuridica_01 FOREIGN KEY (fk_persona_giuridica) REFERENCES sigit_t_persona_giuridica(id_persona_giuridica);



ALTER TABLE sigit_r_pf_pg_delega
	ADD CONSTRAINT  FK_sigit_t_pers_giuridica_02 FOREIGN KEY (id_persona_giuridica) REFERENCES sigit_t_persona_giuridica(id_persona_giuridica);



ALTER TABLE sigit_r_pf_pg_delega
	ADD CONSTRAINT  FK_sigit_t_persona_fisica_03 FOREIGN KEY (id_persona_fisica) REFERENCES sigit_t_persona_fisica(id_persona_fisica);



ALTER TABLE sigit_r_pf_pg_delega
	ADD CONSTRAINT  FK_sigit_d_ruolo_accred_01 FOREIGN KEY (fk_ruolo_accred) REFERENCES sigit_d_ruolo_accred(id_ruolo_accred);



ALTER TABLE sigit_r_pf_pg_delega
	ADD CONSTRAINT  FK_sigit_d_dm37_2008_01 FOREIGN KEY (fk_tipo_dm) REFERENCES sigit_d_dm37_2008(tipo_dm37_2008);



ALTER TABLE sigit_r_potenza_prezzo
	ADD CONSTRAINT  FK_sigit_d_potenza_imp_01 FOREIGN KEY (id_potenza) REFERENCES sigit_d_potenza_imp(id_potenza);



ALTER TABLE sigit_r_potenza_prezzo
	ADD CONSTRAINT  FK_sigit_d_prezzo_potenza_01 FOREIGN KEY (id_prezzo) REFERENCES sigit_d_prezzo_potenza(id_prezzo);



ALTER TABLE sigit_r_ruolo_tipodoc
	ADD CONSTRAINT  FK_sigit_d_ruolo_02 FOREIGN KEY (id_ruolo) REFERENCES sigit_d_ruolo(id_ruolo);



ALTER TABLE sigit_r_ruolo_tipodoc
	ADD CONSTRAINT  FK_sigit_d_tipo_documento_01 FOREIGN KEY (id_tipo_documento) REFERENCES sigit_d_tipo_documento(id_tipo_documento);



ALTER TABLE sigit_r_trans_acq_boll_qta
	ADD CONSTRAINT  FK_sigit_t_transazione_boll_01 FOREIGN KEY (id_transazione_boll) REFERENCES sigit_t_transazione_boll(id_transazione_boll);



ALTER TABLE sigit_r_trans_acq_boll_qta
	ADD CONSTRAINT  FK_sigit_r_potenza_prezzo_01 FOREIGN KEY (id_potenza,id_prezzo,dt_inizio_acquisto) REFERENCES sigit_r_potenza_prezzo(id_potenza,id_prezzo,dt_inizio_acquisto);



ALTER TABLE sigit_t_all_respinto
	ADD CONSTRAINT  FK_sigit_r_imp_ruolo_pfpg_01 FOREIGN KEY (id_imp_ruolo_pfpg) REFERENCES sigit_r_imp_ruolo_pfpg(id_imp_ruolo_pfpg);



ALTER TABLE sigit_t_allegato
	ADD CONSTRAINT  FK_sigit_d_tipo_documento_02 FOREIGN KEY (fk_tipo_documento) REFERENCES sigit_d_tipo_documento(id_tipo_documento);



ALTER TABLE sigit_t_allegato
	ADD CONSTRAINT  FK_sigit_d_stato_rapp_01 FOREIGN KEY (fk_stato_rapp) REFERENCES sigit_d_stato_rapp(id_stato_rapp);



ALTER TABLE sigit_t_allegato
	ADD CONSTRAINT  FK_sigit_r_imp_ruolo_pfpg_02 FOREIGN KEY (fk_imp_ruolo_pfpg) REFERENCES sigit_r_imp_ruolo_pfpg(id_imp_ruolo_pfpg);



ALTER TABLE sigit_t_allegato
	ADD CONSTRAINT  FK_sigit_t_codice_boll_01 FOREIGN KEY (fk_sigla_bollino,fk_numero_bollino) REFERENCES sigit_t_codice_boll(sigla_bollino,numero_bollino);



ALTER TABLE sigit_t_codice_boll
	ADD CONSTRAINT  FK_sigit_r_tr_acq_boll_qta_01 FOREIGN KEY (fk_transazione_boll,fk_potenza,fk_prezzo,fk_dt_inizio_acquisto) REFERENCES sigit_r_trans_acq_boll_qta(id_transazione_boll,id_potenza,id_prezzo,dt_inizio_acquisto);



ALTER TABLE sigit_t_codice_imp
	ADD CONSTRAINT  FK_sigit_t_transazione_imp_01 FOREIGN KEY (fk_transazione) REFERENCES sigit_t_transazione_imp(id_transazione);



ALTER TABLE sigit_t_comp4
	ADD CONSTRAINT  FK_sigit_d_combustibile_02 FOREIGN KEY (fk_combustibile) REFERENCES sigit_d_combustibile(id_combustibile);



ALTER TABLE sigit_t_comp4
	ADD CONSTRAINT  FK_sigit_d_marca_03 FOREIGN KEY (fk_marca) REFERENCES sigit_d_marca(id_marca);



ALTER TABLE sigit_t_comp4
	ADD CONSTRAINT  FK_sigit_d_tipo_componente_02 FOREIGN KEY (id_tipo_componente) REFERENCES sigit_d_tipo_componente(id_tipo_componente);



ALTER TABLE sigit_t_comp4
	ADD CONSTRAINT  FK_sigit_t_impianto_03 FOREIGN KEY (codice_impianto) REFERENCES sigit_t_impianto(codice_impianto);



ALTER TABLE sigit_t_comp_ag
	ADD CONSTRAINT  FK_sigit_t_comp4_01 FOREIGN KEY (codice_impianto,id_tipo_componente,progressivo,data_install) REFERENCES sigit_t_comp4(codice_impianto,id_tipo_componente,progressivo,data_install);



ALTER TABLE sigit_t_comp_br_rc
	ADD CONSTRAINT  FK_sigit_t_comp_gt_01 FOREIGN KEY (fk_tipo_componente,fk_progressivo,fk_data_install,codice_impianto) REFERENCES sigit_t_comp_gt(id_tipo_componente,progressivo,data_install,codice_impianto);



ALTER TABLE sigit_t_comp_br_rc
	ADD CONSTRAINT  FK_sigit_d_marca_01 FOREIGN KEY (fk_marca) REFERENCES sigit_d_marca(id_marca);



ALTER TABLE sigit_t_comp_br_rc
	ADD CONSTRAINT  FK_sigit_d_combustibile_01 FOREIGN KEY (fk_combustibile) REFERENCES sigit_d_combustibile(id_combustibile);



ALTER TABLE sigit_t_comp_cg
	ADD CONSTRAINT  FK_sigit_t_comp4_02 FOREIGN KEY (codice_impianto,id_tipo_componente,progressivo,data_install) REFERENCES sigit_t_comp4(codice_impianto,id_tipo_componente,progressivo,data_install);



ALTER TABLE sigit_t_comp_cs
	ADD CONSTRAINT  FK_sigit_t_comp4_03 FOREIGN KEY (codice_impianto,id_tipo_componente,progressivo,data_install) REFERENCES sigit_t_comp4(codice_impianto,id_tipo_componente,progressivo,data_install);



ALTER TABLE sigit_t_comp_gf
	ADD CONSTRAINT  FK_sigit_t_comp4_05 FOREIGN KEY (codice_impianto,id_tipo_componente,progressivo,data_install) REFERENCES sigit_t_comp4(codice_impianto,id_tipo_componente,progressivo,data_install);



ALTER TABLE sigit_t_comp_gf
	ADD CONSTRAINT  FK_sigit_d_dettaglio_gf_01 FOREIGN KEY (fk_dettaglio_gf) REFERENCES sigit_d_dettaglio_gf(id_dettaglio_gf);



ALTER TABLE sigit_t_comp_gt
	ADD CONSTRAINT  FK_sigit_t_comp4_04 FOREIGN KEY (codice_impianto,id_tipo_componente,progressivo,data_install) REFERENCES sigit_t_comp4(codice_impianto,id_tipo_componente,progressivo,data_install);



ALTER TABLE sigit_t_comp_gt
	ADD CONSTRAINT  FK_sigit_d_fluido_01 FOREIGN KEY (fk_fluido) REFERENCES sigit_d_fluido(id_fluido);



ALTER TABLE sigit_t_comp_gt
	ADD CONSTRAINT  FK_sigit_d_dettaglio_gt_01 FOREIGN KEY (fk_dettaglio_gt) REFERENCES sigit_d_dettaglio_gt(id_dettaglio_gt);



ALTER TABLE sigit_t_comp_sc
	ADD CONSTRAINT  FK_sigit_t_comp4_06 FOREIGN KEY (codice_impianto,id_tipo_componente,progressivo,data_install) REFERENCES sigit_t_comp4(codice_impianto,id_tipo_componente,progressivo,data_install);



ALTER TABLE sigit_t_dett_tipo1
	ADD CONSTRAINT  FK_sigit_t_rapp_tipo1_01 FOREIGN KEY (fk_allegato) REFERENCES sigit_t_rapp_tipo1(id_allegato);



ALTER TABLE sigit_t_dett_tipo1
	ADD CONSTRAINT  FK_sigit_t_comp_gt_02 FOREIGN KEY (fk_tipo_componente,progressivo,data_install,codice_impianto) REFERENCES sigit_t_comp_gt(id_tipo_componente,progressivo,data_install,codice_impianto);



ALTER TABLE sigit_t_dett_tipo2
	ADD CONSTRAINT  FK_sigit_t_rapp_tipo2_01 FOREIGN KEY (fk_allegato) REFERENCES sigit_t_rapp_tipo2(id_allegato);



ALTER TABLE sigit_t_dett_tipo2
	ADD CONSTRAINT  FK_sigit_t_comp_gf_01 FOREIGN KEY (fk_tipo_componente,progressivo,data_install,codice_impianto) REFERENCES sigit_t_comp_gf(id_tipo_componente,progressivo,data_install,codice_impianto);



ALTER TABLE sigit_t_dett_tipo3
	ADD CONSTRAINT  FK_sigit_t_rapp_tipo3_01 FOREIGN KEY (fk_allegato) REFERENCES sigit_t_rapp_tipo3(id_allegato);



ALTER TABLE sigit_t_dett_tipo3
	ADD CONSTRAINT  FK_sigit_t_comp_sc_01 FOREIGN KEY (fk_tipo_componente,progressivo,data_install,codice_impianto) REFERENCES sigit_t_comp_sc(id_tipo_componente,progressivo,data_install,codice_impianto);



ALTER TABLE sigit_t_dett_tipo3
	ADD CONSTRAINT  FK_sigit_d_fluido_03 FOREIGN KEY (fk_fluido_alimentaz) REFERENCES sigit_d_fluido(id_fluido);



ALTER TABLE sigit_t_dett_tipo3
	ADD CONSTRAINT  FK_sigit_d_fluido_02 FOREIGN KEY (fk_fluido) REFERENCES sigit_d_fluido(id_fluido);



ALTER TABLE sigit_t_dett_tipo4
	ADD CONSTRAINT  FK_sigit_t_rapp_tipo4_01 FOREIGN KEY (fk_allegato) REFERENCES sigit_t_rapp_tipo4(id_allegato);



ALTER TABLE sigit_t_dett_tipo4
	ADD CONSTRAINT  FK_sigit_t_comp_cg_01 FOREIGN KEY (fk_tipo_componente,progressivo,data_install,codice_impianto) REFERENCES sigit_t_comp_cg(id_tipo_componente,progressivo,data_install,codice_impianto);



ALTER TABLE sigit_t_dett_tipo4
	ADD CONSTRAINT  FK_sigit_d_fluido_04 FOREIGN KEY (fk_fluido) REFERENCES sigit_d_fluido(id_fluido);



ALTER TABLE sigit_t_formazione
	ADD CONSTRAINT  FK_sigit_t_persona_fisica_01 FOREIGN KEY (id_persona_fisica) REFERENCES sigit_t_persona_fisica(id_persona_fisica);



ALTER TABLE sigit_t_impianto
	ADD CONSTRAINT  FK_sigit_t_codice_imp_01 FOREIGN KEY (codice_impianto) REFERENCES sigit_t_codice_imp(codice_impianto);



ALTER TABLE sigit_t_impianto
	ADD CONSTRAINT  FK_sigit_d_stato_imp_01 FOREIGN KEY (fk_stato) REFERENCES sigit_d_stato_imp(id_stato);



ALTER TABLE sigit_t_libretto
	ADD CONSTRAINT  FK_sigit_d_stato_01 FOREIGN KEY (fk_stato) REFERENCES sigit_d_stato(id_stato);



ALTER TABLE sigit_t_libretto
	ADD CONSTRAINT  FK_sigit_d_tipo_intervento_01 FOREIGN KEY (fk_tipo_intervento) REFERENCES sigit_d_tipo_intervento(id_tipo_intervento);



ALTER TABLE sigit_t_libretto
	ADD CONSTRAINT  FK_sigit_d_motivo_consolid_01 FOREIGN KEY (fk_motivo_consolid) REFERENCES sigit_d_motivo_consolid(id_motivo_consolid);



ALTER TABLE sigit_t_libretto
	ADD CONSTRAINT  FK_sigit_d_tipo_documento_03 FOREIGN KEY (fk_tipo_documento) REFERENCES sigit_d_tipo_documento(id_tipo_documento);



ALTER TABLE sigit_t_libretto
	ADD CONSTRAINT  FK_sigit_t_impianto_07 FOREIGN KEY (codice_impianto) REFERENCES sigit_t_impianto(codice_impianto);



ALTER TABLE sigit_t_rapp_tipo1
	ADD CONSTRAINT  FK_sigit_t_allegato_02 FOREIGN KEY (id_allegato) REFERENCES sigit_t_allegato(id_allegato);



ALTER TABLE sigit_t_rapp_tipo2
	ADD CONSTRAINT  FK_sigit_t_allegato_03 FOREIGN KEY (id_allegato) REFERENCES sigit_t_allegato(id_allegato);



ALTER TABLE sigit_t_rapp_tipo3
	ADD CONSTRAINT  FK_sigit_t_allegato_04 FOREIGN KEY (id_allegato) REFERENCES sigit_t_allegato(id_allegato);



ALTER TABLE sigit_t_rapp_tipo4
	ADD CONSTRAINT  FK_sigit_t_allegato_05 FOREIGN KEY (id_allegato) REFERENCES sigit_t_allegato(id_allegato);



ALTER TABLE sigit_t_terzo_responsabile
	ADD CONSTRAINT  FK_sigit_r_imp_ruolo_pfpg_03 FOREIGN KEY (id_imp_ruolo_pfpg) REFERENCES sigit_r_imp_ruolo_pfpg(id_imp_ruolo_pfpg);



ALTER TABLE sigit_t_terzo_responsabile
	ADD CONSTRAINT  FK_sigit_t_pers_giuridica_03 FOREIGN KEY (id_persona_giuridica) REFERENCES sigit_t_persona_giuridica(id_persona_giuridica);



ALTER TABLE sigit_t_transazione_boll
	ADD CONSTRAINT  FK_sigit_t_pers_giuridica_04 FOREIGN KEY (fk_persona_giuridica) REFERENCES sigit_t_persona_giuridica(id_persona_giuridica);



ALTER TABLE sigit_t_transazione_boll
	ADD CONSTRAINT  FK_sigit_d_tipo_pagamento_01 FOREIGN KEY (fk_tipo_pagamento) REFERENCES sigit_d_tipo_pagamento(id_tipo_pagamento);



ALTER TABLE sigit_t_transazione_boll
	ADD CONSTRAINT  FK_sigit_d_stato_mdp_01 FOREIGN KEY (id_stato_transazione) REFERENCES sigit_d_stato_mdp(id_stato_mdp);



ALTER TABLE sigit_t_transazione_imp
	ADD CONSTRAINT  FK_sigit_t_pers_giuridica_05 FOREIGN KEY (fk_persona_giuridica) REFERENCES sigit_t_persona_giuridica(id_persona_giuridica);



ALTER TABLE sigit_t_tratt_h2o
	ADD CONSTRAINT  FK_sigit_t_impianto_08 FOREIGN KEY (codice_impianto) REFERENCES sigit_t_impianto(codice_impianto);



ALTER TABLE sigit_t_unita_immobiliare
	ADD CONSTRAINT  FK_sigit_t_impianto_09 FOREIGN KEY (codice_impianto) REFERENCES sigit_t_impianto(codice_impianto);



ALTER TABLE sigit_t_unita_immobiliare
	ADD CONSTRAINT  FK_sigit_d_categoria_01 FOREIGN KEY (l1_2_fk_categoria) REFERENCES sigit_d_categoria(id_categoria);


