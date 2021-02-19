
CREATE TABLE sigit_d_categoria
(
	id_categoria          CHARACTER VARYING(10)  NOT NULL ,
	des_categoria         CHARACTER VARYING(200)  NULL 
);



ALTER TABLE sigit_d_categoria
	ADD CONSTRAINT  PK_sigit_d_categoria PRIMARY KEY (id_categoria);



CREATE TABLE sigit_d_combustibile
(
	id_combustibile       NUMERIC  NOT NULL ,
	des_combustibile      CHARACTER VARYING(100)  NOT NULL 
);



ALTER TABLE sigit_d_combustibile
	ADD CONSTRAINT  PK_sigit_d_combustibile PRIMARY KEY (id_combustibile);



CREATE TABLE sigit_d_dettaglio_gf
(
	id_dettaglio_gf       NUMERIC(3)  NOT NULL ,
	des_dettaglio_gf      CHARACTER VARYING(100)  NULL 
);



ALTER TABLE sigit_d_dettaglio_gf
	ADD CONSTRAINT  PK_sigit_d_dettaglio_gf PRIMARY KEY (id_dettaglio_gf);



CREATE TABLE sigit_d_dettaglio_gt
(
	id_dettaglio_gt       NUMERIC(3)  NOT NULL ,
	des_dettaglio_gt      CHARACTER VARYING(100)  NULL 
);



ALTER TABLE sigit_d_dettaglio_gt
	ADD CONSTRAINT  PK_sigit_d_dettaglio_gt PRIMARY KEY (id_dettaglio_gt);



CREATE TABLE sigit_d_dm37_2008
(
	tipo_dm37_2008        CHARACTER VARYING(1)  NOT NULL  CONSTRAINT  dom_a_b_c_d CHECK (tipo_dm37_2008 IN ('A','B', 'C', 'D')),
	des_tipo_dm37_2008    CHARACTER VARYING(100)  NULL 
);



ALTER TABLE sigit_d_dm37_2008
	ADD CONSTRAINT  PK_sigit_d_dm37_2008 PRIMARY KEY (tipo_dm37_2008);



CREATE TABLE sigit_d_fluido
(
	id_fluido             NUMERIC  NOT NULL ,
	des_fluido            CHARACTER VARYING(100)  NOT NULL 
);



ALTER TABLE sigit_d_fluido
	ADD CONSTRAINT  PK_sigit_d_fluido PRIMARY KEY (id_fluido);



CREATE TABLE sigit_d_marca
(
	id_marca              NUMERIC  NOT NULL ,
	des_marca             CHARACTER VARYING(100)  NOT NULL 
);



ALTER TABLE sigit_d_marca
	ADD CONSTRAINT  PK_sigit_d_marca PRIMARY KEY (id_marca);



CREATE TABLE sigit_d_motivo_consolid
(
	id_motivo_consolid    NUMERIC  NOT NULL ,
	des_motivo_consolid   CHARACTER VARYING(100)  NOT NULL 
);



ALTER TABLE sigit_d_motivo_consolid
	ADD CONSTRAINT  PK_sigit_d_motivo_consolid PRIMARY KEY (id_motivo_consolid);



CREATE TABLE sigit_d_potenza_imp
(
	id_potenza            NUMERIC(2)  NOT NULL ,
	des_potenza           CHARACTER VARYING(50)  NULL ,
	limite_inferiore      NUMERIC(5,2)  NULL ,
	limite_superiore      NUMERIC(5,2)  NULL 
);



ALTER TABLE sigit_d_potenza_imp
	ADD CONSTRAINT  PK_sigit_d_potenza_imp PRIMARY KEY (id_potenza);



CREATE TABLE sigit_d_prezzo_potenza
(
	id_prezzo             NUMERIC(3)  NOT NULL ,
	prezzo                NUMERIC(8,2)  NULL 
);



ALTER TABLE sigit_d_prezzo_potenza
	ADD CONSTRAINT  PK_sigit_d_prezzo_potenza PRIMARY KEY (id_prezzo);



CREATE TABLE sigit_d_ruolo
(
	id_ruolo              NUMERIC  NOT NULL ,
	des_ruolo             CHARACTER VARYING(50)  NOT NULL ,
	ruolo_funz            CHARACTER VARYING(50)  NULL 
);



ALTER TABLE sigit_d_ruolo
	ADD CONSTRAINT  PK_sigit_d_ruolo PRIMARY KEY (id_ruolo);



CREATE TABLE sigit_d_ruolo_accred
(
	id_ruolo_accred       NUMERIC(2)  NOT NULL ,
	des_ruolo_accred      CHARACTER VARYING(100)  NOT NULL 
);



ALTER TABLE sigit_d_ruolo_accred
	ADD CONSTRAINT  PK_sigit_d_ruolo_accred PRIMARY KEY (id_ruolo_accred);



CREATE TABLE sigit_d_stato
(
	id_stato              NUMERIC  NOT NULL ,
	des_stato             CHARACTER VARYING(100)  NOT NULL 
);



ALTER TABLE sigit_d_stato
	ADD CONSTRAINT  PK_sigit_d_stato PRIMARY KEY (id_stato);



CREATE TABLE sigit_d_stato_imp
(
	id_stato              NUMERIC  NOT NULL ,
	des_stato             CHARACTER VARYING(100)  NULL 
);



ALTER TABLE sigit_d_stato_imp
	ADD CONSTRAINT  PK_sigit_d_stato_imp PRIMARY KEY (ID_STATO);



CREATE TABLE sigit_d_stato_mdp
(
	id_stato_mdp          NUMERIC(3)  NOT NULL ,
	des_stato_mdp         CHARACTER VARYING(100)  NULL 
);



ALTER TABLE sigit_d_stato_mdp
	ADD CONSTRAINT  PK_sigit_d_stato_mdp PRIMARY KEY (id_stato_mdp);



CREATE TABLE sigit_d_stato_rapp
(
	id_stato_rapp         NUMERIC(2)  NOT NULL ,
	des_stato_rapp        CHARACTER VARYING(100)  NULL 
);



ALTER TABLE sigit_d_stato_rapp
	ADD CONSTRAINT  PK_sigit_d_stato_rapp PRIMARY KEY (ID_STATO_RAPP);



CREATE TABLE sigit_d_tipo_componente
(
	id_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	des_tipo_componente   CHARACTER VARYING(100)  NULL 
);



ALTER TABLE sigit_d_tipo_componente
	ADD CONSTRAINT  PK_sigit_d_tipo_componente PRIMARY KEY (id_tipo_componente);



CREATE TABLE sigit_d_tipo_documento
(
	id_tipo_documento     NUMERIC  NOT NULL ,
	des_tipo_documento    CHARACTER VARYING(100)  NOT NULL ,
	flg_visu_elenco_all   NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_a1 CHECK (flg_visu_elenco_all IN (0,1))
);



ALTER TABLE sigit_d_tipo_documento
	ADD CONSTRAINT  PK_sigit_d_tipo_documento PRIMARY KEY (id_tipo_documento);



CREATE TABLE sigit_d_tipo_intervento
(
	id_tipo_intervento    NUMERIC  NOT NULL ,
	des_tipo_intervento   CHARACTER VARYING(100)  NOT NULL 
);



ALTER TABLE sigit_d_tipo_intervento
	ADD CONSTRAINT  PK_sigit_d_tipo_intervento PRIMARY KEY (id_tipo_intervento);



CREATE TABLE sigit_d_tipo_pagamento
(
	id_tipo_pagamento     NUMERIC(3)  NOT NULL ,
	des_tipo_pagamento    CHARACTER VARYING(50)  NULL ,
	flg_pagam_attivo      CHARACTER VARYING(1)  NULL 
);



ALTER TABLE sigit_d_tipo_pagamento
	ADD CONSTRAINT  PK_sigit_d_tipo_pagamento PRIMARY KEY (id_tipo_pagamento);



CREATE TABLE sigit_r_imp_ruolo_pfpg
(
	id_imp_ruolo_pfpg     NUMERIC  NOT NULL ,
	fk_ruolo              NUMERIC  NOT NULL ,
	codice_impianto       NUMERIC  NOT NULL ,
	data_inizio           DATE  NULL ,
	data_fine             DATE  NULL ,
	fk_persona_fisica     NUMERIC(6)  NULL ,
	fk_persona_giuridica  NUMERIC(6)  NULL ,
	data_ult_mod          TIMESTAMP  NOT NULL ,
	utente_ult_mod        CHARACTER VARYING(16)  NOT NULL 
);



ALTER TABLE sigit_r_imp_ruolo_pfpg
	ADD CONSTRAINT  PK_sigit_r_imp_ruolo_pfpg PRIMARY KEY (id_imp_ruolo_pfpg);



ALTER TABLE sigit_r_imp_ruolo_pfpg
ADD CONSTRAINT  AK1_sigit_r_imp_ruolo_pfpg UNIQUE (fk_ruolo,codice_impianto,data_inizio);



CREATE TABLE sigit_r_pf_pg_delega
(
	id_persona_fisica     NUMERIC(6)  NOT NULL ,
	id_persona_giuridica  NUMERIC(6)  NOT NULL ,
	data_inizio           DATE  NOT NULL ,
	fk_ruolo_accred       NUMERIC(2)  NULL ,
	fk_tipo_dm            CHARACTER VARYING(1)  NULL ,
	flg_delega            CHARACTER VARYING(1)  NULL  CONSTRAINT  dom_a_d CHECK (flg_delega IN ('A','D')),
	data_fine             DATE  NULL ,
	data_ult_mod          TIMESTAMP  NOT NULL ,
	utente_ult_mod        CHARACTER VARYING(16)  NOT NULL 
);



ALTER TABLE sigit_r_pf_pg_delega
	ADD CONSTRAINT  PK_sigit_r_pf_pg_delega PRIMARY KEY (id_persona_fisica,id_persona_giuridica,data_inizio);



CREATE TABLE sigit_r_potenza_prezzo
(
	id_potenza            NUMERIC(2)  NOT NULL ,
	id_prezzo             NUMERIC(3)  NOT NULL ,
	dt_inizio_acquisto    DATE  NOT NULL ,
	dt_fine_acquisto      DATE  NULL ,
	dt_inizio_uso         DATE  NULL ,
	dt_fine_uso           DATE  NULL 
);



ALTER TABLE sigit_r_potenza_prezzo
	ADD CONSTRAINT  PK_sigit_r_potenza_prezzo PRIMARY KEY (id_potenza,id_prezzo,dt_inizio_acquisto);



CREATE TABLE sigit_r_ruolo_tipodoc
(
	id_ruolo              NUMERIC  NOT NULL ,
	id_tipo_documento     NUMERIC  NOT NULL 
);



ALTER TABLE sigit_r_ruolo_tipodoc
	ADD CONSTRAINT  PK_sigit_r_ruolo_tipodoc PRIMARY KEY (id_ruolo,id_tipo_documento);



CREATE TABLE sigit_r_trans_acq_boll_qta
(
	id_transazione_boll   NUMERIC  NOT NULL ,
	id_potenza            NUMERIC(2)  NOT NULL ,
	id_prezzo             NUMERIC(3)  NOT NULL ,
	dt_inizio_acquisto    DATE  NOT NULL ,
	quantita              NUMERIC(6)  NULL ,
	data_ult_mod          TIMESTAMP  NULL ,
	utente_ult_mod        CHARACTER VARYING(16)  NULL 
);



ALTER TABLE sigit_r_trans_acq_boll_qta
	ADD CONSTRAINT  PK_sigit_r_trans_acq_boll_qta PRIMARY KEY (id_transazione_boll,id_potenza,id_prezzo,dt_inizio_acquisto);



CREATE TABLE sigit_t_all_respinto
(
	data_controllo        DATE  NOT NULL ,
	id_imp_ruolo_pfpg     NUMERIC  NOT NULL ,
	fk_tipo_documento     NUMERIC  NULL ,
	sigla_bollino         CHARACTER VARYING(2)  NOT NULL ,
	numero_bollino        NUMERIC(11)  NULL ,
	xml_allegato          bytea  NULL ,
	nome_allegato         CHARACTER VARYING(50)  NULL ,
	data_ult_mod          TIMESTAMP  NOT NULL ,
	utente_ult_mod        CHARACTER VARYING(16)  NOT NULL ,
	data_respinta         DATE  NULL ,
	data_invio            DATE  NULL ,
	f_osservazioni        CHARACTER VARYING(1000)  NULL ,
	f_raccomandazioni     CHARACTER VARYING(1000)  NULL ,
	f_prescrizioni        CHARACTER VARYING(1000)  NULL ,
	f_intervento_entro    DATE  NULL 
);



ALTER TABLE sigit_t_all_respinto
	ADD CONSTRAINT  PK_sigit_t_all_respinto PRIMARY KEY (data_controllo,id_imp_ruolo_pfpg);



CREATE TABLE sigit_t_allegato
(
	id_allegato           NUMERIC  NOT NULL ,
	fk_stato_rapp         NUMERIC(2)  NOT NULL ,
	fk_imp_ruolo_pfpg     NUMERIC  NOT NULL ,
	fk_tipo_documento     NUMERIC  NOT NULL ,
	fk_sigla_bollino      CHARACTER VARYING(2)  NULL ,
	fk_numero_bollino     NUMERIC(11)  NULL ,
	data_controllo        DATE  NOT NULL ,
	b_flg_libretto_uso    NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_lib_uso CHECK (b_flg_libretto_uso IN (0,1)),
	b_flg_dichiar_conform  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_dic_conf CHECK (b_flg_dichiar_conform IN (0,1)),
	b_flg_lib_imp         NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_lib_imp CHECK (b_flg_lib_imp IN (0,1)),
	b_flg_lib_compl       NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_lib_compl CHECK (b_flg_lib_compl IN (0,1)),
	f_osservazioni        CHARACTER VARYING(1000)  NULL ,
	f_raccomandazioni     CHARACTER VARYING(1000)  NULL ,
	f_prescrizioni        CHARACTER VARYING(1000)  NULL ,
	f_flg_puo_funzionare  NUMERIC(1)  NULL ,
	f_intervento_entro    DATE  NULL ,
	f_ora_arrivo          CHARACTER VARYING(10)  NULL ,
	f_ora_partenza        CHARACTER VARYING(10)  NULL ,
	f_denominaz_tecnico   CHARACTER VARYING(100)  NULL ,
	f_flg_firma_tecnico   NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_70 CHECK (f_flg_firma_tecnico IN (0,1)),
	f_flg_firma_responsabile  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_71 CHECK (f_flg_firma_responsabile IN (0,1)),
	data_invio            DATE  NULL ,
	xml_allegato          bytea  NULL ,
	nome_allegato         CHARACTER VARYING(50)  NULL ,
	data_ult_mod          TIMESTAMP  NOT NULL ,
	utente_ult_mod        CHARACTER VARYING(16)  NOT NULL ,
	cf_redattore          CHARACTER VARYING(16)  NULL ,
	uid_index             CHARACTER VARYING(50)  NULL 
);



ALTER TABLE sigit_t_allegato
	ADD CONSTRAINT  PK_sigit_t_allegato PRIMARY KEY (id_allegato);



CREATE TABLE sigit_t_codice_boll
(
	sigla_bollino         CHARACTER VARYING(2)  NOT NULL ,
	numero_bollino        NUMERIC(11)  NOT NULL ,
	fk_transazione_boll   NUMERIC  NOT NULL ,
	fk_potenza            NUMERIC(2)  NOT NULL ,
	fk_prezzo             NUMERIC(3)  NOT NULL ,
	fk_dt_inizio_acquisto  DATE  NOT NULL ,
	flg_pregresso         NUMERIC(1)  NULL 
);



ALTER TABLE sigit_t_codice_boll
	ADD CONSTRAINT  PK_sigit_t_codice_boll PRIMARY KEY (sigla_bollino,numero_bollino);



CREATE TABLE sigit_t_codice_imp
(
	codice_impianto       NUMERIC  NOT NULL ,
	fk_transazione        NUMERIC  NOT NULL ,
	flg_pregresso         NUMERIC(1)  NULL 
);



ALTER TABLE sigit_t_codice_imp
	ADD CONSTRAINT  PK_sigit_t_codice_imp PRIMARY KEY (codice_impianto);



CREATE TABLE sigit_t_comp4
(
	codice_impianto       NUMERIC  NOT NULL ,
	id_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	progressivo           CHARACTER VARYING(2)  NOT NULL ,
	data_install          DATE  NOT NULL ,
	data_dismiss          DATE  NULL ,
	matricola             CHARACTER VARYING(20)  NULL ,
	fk_combustibile       NUMERIC  NULL ,
	fk_marca              NUMERIC  NULL ,
	modello               CHARACTER VARYING(100)  NULL ,
	potenza_termica_kw    NUMERIC  NULL ,
	data_ult_mod          TIMESTAMP  NOT NULL ,
	utente_ult_mod        CHARACTER VARYING(16)  NOT NULL 
);



ALTER TABLE sigit_t_comp4
	ADD CONSTRAINT  PK_sigit_t_comp4 PRIMARY KEY (codice_impianto,id_tipo_componente,progressivo,data_install);



CREATE TABLE sigit_t_comp_ag
(
	id_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	progressivo           CHARACTER VARYING(2)  NOT NULL ,
	data_install          DATE  NOT NULL ,
	codice_impianto       NUMERIC  NOT NULL ,
	tipologia             CHARACTER VARYING(100)  NULL 
);



ALTER TABLE sigit_t_comp_ag
	ADD CONSTRAINT  PK_sigit_t_comp_ag PRIMARY KEY (id_tipo_componente,progressivo,data_install,codice_impianto);



CREATE TABLE sigit_t_comp_br_rc
(
	id_comp_br_rc         NUMERIC  NOT NULL ,
	tipologia_br_rc       CHARACTER VARYING(2)  NOT NULL  CONSTRAINT  dom_br_rc CHECK (tipologia_br_rc IN ('BR','RC')),
	progressivo_br_rc     CHARACTER VARYING(2)  NOT NULL ,
	fk_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	fk_progressivo        CHARACTER VARYING(2)  NOT NULL ,
	fk_data_install       DATE  NOT NULL ,
	codice_impianto       NUMERIC  NOT NULL ,
	tipologia             CHARACTER VARYING(100)  NULL ,
	pot_term_max_kw       NUMERIC  NULL ,
	pot_term_min_kw       NUMERIC  NULL ,
	data_install          DATE  NULL ,
	data_dismiss          DATE  NULL ,
	fk_marca              NUMERIC  NULL ,
	modello               CHARACTER VARYING(100)  NULL ,
	matricola             CHARACTER VARYING(20)  NULL ,
	fk_combustibile       NUMERIC  NULL 
);



ALTER TABLE sigit_t_comp_br_rc
	ADD CONSTRAINT  PK_sigit_t_comp_br_rc PRIMARY KEY (id_comp_br_rc);



CREATE TABLE sigit_t_comp_cg
(
	id_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	progressivo           CHARACTER VARYING(2)  NOT NULL ,
	data_install          DATE  NOT NULL ,
	codice_impianto       NUMERIC  NOT NULL ,
	tipologia             CHARACTER VARYING(100)  NULL ,
	potenza_elettrica_kw  NUMERIC  NULL ,
	temp_h2o_out_min      NUMERIC  NULL ,
	temp_h2o_out_max      NUMERIC  NULL ,
	temp_h2o_in_min       NUMERIC  NULL ,
	temp_h2o_in_max       NUMERIC  NULL ,
	temp_h2o_motore_min   NUMERIC  NULL ,
	temp_h2o_motore_max   NUMERIC  NULL ,
	temp_fumi_valle_min   NUMERIC  NULL ,
	temp_fumi_valle_max   NUMERIC  NULL ,
	temp_fumi_monte_min   NUMERIC  NULL ,
	temp_fumi_monte_max   NUMERIC  NULL ,
	co_min                NUMERIC  NULL ,
	co_max                NUMERIC  NULL 
);



ALTER TABLE sigit_t_comp_cg
	ADD CONSTRAINT  PK_sigit_t_comp_cg PRIMARY KEY (id_tipo_componente,progressivo,data_install,codice_impianto);



CREATE TABLE sigit_t_comp_cs
(
	id_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	progressivo           CHARACTER VARYING(2)  NOT NULL ,
	data_install          DATE  NOT NULL ,
	codice_impianto       NUMERIC  NOT NULL ,
	num_collettori        NUMERIC(3)  NULL ,
	sup_apertura          NUMERIC  NULL 
);



ALTER TABLE sigit_t_comp_cs
	ADD CONSTRAINT  PK_sigit_t_comp_cs PRIMARY KEY (id_tipo_componente,progressivo,data_install,codice_impianto);



CREATE TABLE sigit_t_comp_gf
(
	id_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	progressivo           CHARACTER VARYING(2)  NOT NULL ,
	data_install          DATE  NOT NULL ,
	codice_impianto       NUMERIC  NOT NULL ,
	fk_dettaglio_gf       NUMERIC(3)  NULL ,
	flg_sorgente_ext      CHARACTER VARYING(10)  NULL ,
	flg_fluido_utenze     CHARACTER VARYING(10)  NULL ,
	fluido_frigorigeno    CHARACTER VARYING(100)  NULL ,
	n_circuiti            NUMERIC(3)  NULL ,
	raffrescamento_eer    CHARACTER VARYING(10)  NULL ,
	raff_potenza_kw       NUMERIC  NULL ,
	raff_potenza_ass      NUMERIC  NULL ,
	riscaldamento_cop     CHARACTER VARYING(10)  NULL ,
	risc_potenza_kw       NUMERIC  NULL ,
	risc_potenza_ass_kw   NUMERIC  NULL 
);



ALTER TABLE sigit_t_comp_gf
	ADD CONSTRAINT  PK_sigit_t_comp_gf PRIMARY KEY (id_tipo_componente,progressivo,data_install,codice_impianto);



CREATE TABLE sigit_t_comp_gt
(
	id_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	progressivo           CHARACTER VARYING(2)  NOT NULL ,
	data_install          DATE  NOT NULL ,
	codice_impianto       NUMERIC  NOT NULL ,
	fk_fluido             NUMERIC  NULL ,
	fk_dettaglio_gt       NUMERIC(3)  NULL ,
	rendimento_perc       NUMERIC  NULL ,
	n_moduli              NUMERIC(3)  NULL 
);



ALTER TABLE sigit_t_comp_gt
	ADD CONSTRAINT  PK_sigit_t_comp_gt PRIMARY KEY (id_tipo_componente,progressivo,data_install,codice_impianto);



CREATE TABLE sigit_t_comp_sc
(
	id_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	progressivo           CHARACTER VARYING(2)  NOT NULL ,
	data_install          DATE  NOT NULL ,
	codice_impianto       NUMERIC  NOT NULL 
);



ALTER TABLE sigit_t_comp_sc
	ADD CONSTRAINT  PK_sigit_t_comp_sc PRIMARY KEY (id_tipo_componente,progressivo,data_install,codice_impianto);



CREATE TABLE sigit_t_dett_tipo1
(
	id_dett_tipo1         NUMERIC  NOT NULL ,
	fk_allegato           NUMERIC  NOT NULL ,
	codice_impianto       NUMERIC  NOT NULL ,
	fk_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	progressivo           CHARACTER VARYING(2)  NOT NULL ,
	data_install          DATE  NOT NULL ,
	e_n_modulo_termico    CHARACTER VARYING(20)  NULL ,
	e_pot_term_focol_kw   NUMERIC  NULL ,
	e_flg_clima_inverno   NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_450 CHECK (e_flg_clima_inverno IN (0,1)),
	e_flg_produz_acs      NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_451 CHECK (e_flg_produz_acs IN (0,1)),
	e_flg_dispos_comando  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_452 CHECK (e_flg_dispos_comando IN (0,1,2)),
	e_flg_dispos_sicurezza  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_453 CHECK (e_flg_dispos_sicurezza IN (0,1,2)),
	e_flg_valvola_sicurezza  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_455 CHECK (e_flg_valvola_sicurezza IN (0,1,2)),
	e_flg_scambiatore_fumi  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_456 CHECK (e_flg_scambiatore_fumi IN (0,1,2)),
	e_flg_riflusso        NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_457 CHECK (e_flg_riflusso IN (0,1,2)),
	e_flg_uni_10389_1     NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_458 CHECK (e_flg_uni_10389_1 IN (0,1,2)),
	e_flg_evacu_fumi      CHARACTER VARYING(1)  NULL  CONSTRAINT  dom_n_f CHECK (e_flg_evacu_fumi IN ('N','F')),
	e_depr_canale_fumo_pa  NUMERIC  NULL ,
	e_temp_fumi_c         NUMERIC  NULL ,
	e_temp_aria_c         NUMERIC  NULL ,
	e_o2_perc             NUMERIC  NULL ,
	e_co2_perc            NUMERIC  NULL ,
	e_bacharach           CHARACTER VARYING(50)  NULL ,
	e_co_corretto_ppm     NUMERIC  NULL ,
	e_rend_comb_perc      NUMERIC  NULL ,
	e_rend_min_legge_perc  NUMERIC  NULL ,
	e_nox_ppm             NUMERIC  NULL ,
	data_ult_mod          TIMESTAMP  NOT NULL ,
	utente_ult_mod        CHARACTER VARYING(16)  NOT NULL 
);



ALTER TABLE sigit_t_dett_tipo1
	ADD CONSTRAINT  PK_sigit_t_dett_tipo1 PRIMARY KEY (id_dett_tipo1);



CREATE TABLE sigit_t_dett_tipo2
(
	id_dett_tipo2         NUMERIC  NOT NULL ,
	fk_allegato           NUMERIC  NOT NULL ,
	codice_impianto       NUMERIC  NOT NULL ,
	fk_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	progressivo           CHARACTER VARYING(2)  NOT NULL ,
	data_install          DATE  NOT NULL ,
	e_n_circuito          CHARACTER VARYING(20)  NULL ,
	e_flg_mod_prova       CHARACTER VARYING(3)  NULL  CONSTRAINT  dom_raf_ris CHECK (e_flg_mod_prova IN ('RAF','RIS')),
	e_flg_perdita_gas     NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_350 CHECK (e_flg_perdita_gas IN (0,1,2)),
	e_flg_leak_detector   NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_351 CHECK (e_flg_leak_detector IN (0,1,2)),
	e_flg_param_termodinam  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_352 CHECK (e_flg_param_termodinam IN (0,1,2)),
	e_flg_incrostazioni   NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_353 CHECK (e_flg_incrostazioni IN (0,1,2)),
	e_t_suttisc_c         NUMERIC  NULL ,
	e_t_sottoraf_c        NUMERIC  NULL ,
	e_t_condensazione_c   NUMERIC  NULL ,
	e_t_evaporazione_c    NUMERIC  NULL ,
	e_t_in_ext_c          NUMERIC  NULL ,
	e_t_out_ext_c         NUMERIC  NULL ,
	e_t_in_utenze_c       NUMERIC  NULL ,
	e_t_out_utenze_c      NUMERIC  NULL ,
	data_ult_mod          TIMESTAMP  NOT NULL ,
	utente_ult_mod        CHARACTER VARYING(16)  NOT NULL 
);



ALTER TABLE sigit_t_dett_tipo2
	ADD CONSTRAINT  PK_sigit_t_dett_tipo2 PRIMARY KEY (id_dett_tipo2);



CREATE TABLE sigit_t_dett_tipo3
(
	id_dett_tipo3         NUMERIC  NOT NULL ,
	fk_allegato           NUMERIC  NOT NULL ,
	codice_impianto       NUMERIC  NOT NULL ,
	fk_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	progressivo           CHARACTER VARYING(2)  NOT NULL ,
	data_install          DATE  NOT NULL ,
	fk_fluido             NUMERIC  NULL ,
	fk_fluido_alimentaz   NUMERIC  NULL ,
	e_fluido_altro        CHARACTER VARYING(100)  NULL ,
	e_alimentazione_altro  CHARACTER VARYING(100)  NULL ,
	e_flg_clima_inverno   NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_650 CHECK (e_flg_clima_inverno IN (0,1)),
	e_flg_produz_acs      NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_651 CHECK (e_flg_produz_acs IN (0,1)),
	e_flg_potenza_compatibile  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_800 CHECK (e_flg_potenza_compatibile IN (0,1,2)),
	e_flg_coib_idonea     NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_801 CHECK (e_flg_coib_idonea IN (0,1,2)),
	e_flg_disp_funzionanti  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_803 CHECK (e_flg_disp_funzionanti IN (0,1,2)),
	e_temp_ext_c          NUMERIC  NULL ,
	e_temp_mand_primario_c  NUMERIC  NULL ,
	e_temp_ritor_primario_c  NUMERIC  NULL ,
	e_temp_mand_secondario_c  NUMERIC  NULL ,
	e_temp_rit_secondario_c  NUMERIC  NULL ,
	e_potenza_term_kw     NUMERIC  NULL ,
	e_port_fluido_m3_h    NUMERIC  NULL ,
	data_ult_mod          TIMESTAMP  NOT NULL ,
	utente_ult_mod        CHARACTER VARYING(16)  NOT NULL 
);



ALTER TABLE sigit_t_dett_tipo3
	ADD CONSTRAINT  PK_sigit_t_dett_tipo3 PRIMARY KEY (id_dett_tipo3);



CREATE TABLE sigit_t_dett_tipo4
(
	id_dett_tipo4         NUMERIC  NOT NULL ,
	fk_allegato           NUMERIC  NOT NULL ,
	codice_impianto       NUMERIC  NOT NULL ,
	fk_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	progressivo           CHARACTER VARYING(2)  NOT NULL ,
	data_install          DATE  NOT NULL ,
	fk_fluido             NUMERIC  NULL ,
	e_potenza_assorb_comb_kw  NUMERIC  NULL ,
	e_potenza_term_bypass_kw  NUMERIC  NULL ,
	e_temp_aria_c         NUMERIC  NULL ,
	e_temp_h2o_out_c      NUMERIC  NULL ,
	e_temp_h2o_in_c       NUMERIC  NULL ,
	e_potenza_morsetti_kw  NUMERIC  NULL ,
	e_temp_h2o_motore_c   NUMERIC  NULL ,
	e_temp_fumi_valle_c   NUMERIC  NULL ,
	e_temp_fumi_monte_c   NUMERIC  NULL ,
	data_ult_mod          TIMESTAMP  NOT NULL ,
	utente_ult_mod        CHARACTER VARYING(16)  NOT NULL 
);



ALTER TABLE sigit_t_dett_tipo4
	ADD CONSTRAINT  PK_sigit_t_dett_tipo4 PRIMARY KEY (id_dett_tipo4);



CREATE TABLE sigit_t_formazione
(
	data_corso            DATE  NOT NULL ,
	id_persona_fisica     NUMERIC(6)  NOT NULL ,
	des_corso             CHARACTER VARYING(1000)  NULL 
);



ALTER TABLE sigit_t_formazione
	ADD CONSTRAINT  PK_sigit_t_formazione PRIMARY KEY (data_corso,id_persona_fisica);



CREATE TABLE sigit_t_impianto
(
	codice_impianto       NUMERIC  NOT NULL ,
	istat_comune          CHARACTER VARYING(6)  NULL ,
	fk_stato              NUMERIC(2)  NOT NULL ,
	data_assegnazione     DATE  NULL ,
	data_dismissione      DATE  NULL ,
	denominazione_comune  CHARACTER VARYING(100)  NULL ,
	sigla_provincia       CHARACTER VARYING(5)  NULL ,
	denominazione_provincia  CHARACTER VARYING(100)  NULL ,
	l1_3_pot_h2o_kw       NUMERIC  NULL ,
	l1_3_pot_clima_inv_kw  NUMERIC  NULL ,
	l1_3_pot_clima_est_kw  NUMERIC  NULL ,
	l1_3_altro            CHARACTER VARYING(100)  NULL ,
	l1_4_flg_h2o          NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_50 CHECK (l1_4_flg_h2o IN (0,1)),
	l1_4_flg_aria         NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_51 CHECK (l1_4_flg_aria IN (0,1)),
	l1_4_altro            CHARACTER VARYING(100)  NULL ,
	l1_5_flg_generatore   NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_52 CHECK (l1_5_flg_generatore IN (0,1)),
	l1_5_flg_pompa        NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_53 CHECK (l1_5_flg_pompa IN (0,1)),
	l1_5_flg_frigo        NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_54 CHECK (l1_5_flg_frigo IN (0,1)),
	l1_5_flg_telerisc     NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_55 CHECK (l1_5_flg_telerisc IN (0,1)),
	l1_5_flg_teleraffr    NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_56 CHECK (l1_5_flg_teleraffr IN (0,1)),
	l1_5_flg_cogeneratore  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1 CHECK (l1_5_flg_cogeneratore IN (0,1)),
	l1_5_altro            CHARACTER VARYING(100)  NULL ,
	l1_5_sup_pannelli_sol_m2  NUMERIC  NULL ,
	l1_5_altro_integrazione  CHARACTER VARYING(100)  NULL ,
	l1_5_altro_integr_pot_kw  NUMERIC  NULL ,
	l1_5_flg_altro_clima_inv  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_57 CHECK (l1_5_flg_altro_clima_inv IN (0,1)),
	l1_5_flg_altro_clima_estate  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_58 CHECK (l1_5_flg_altro_clima_estate IN (0,1)),
	l1_5_flg_altro_acs    NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_461 CHECK (l1_5_flg_altro_acs IN (0,1)),
	l1_5_altro_desc       CHARACTER VARYING(100)  NULL ,
	data_ult_mod          TIMESTAMP  NOT NULL ,
	utente_ult_mod        CHARACTER VARYING(16)  NOT NULL ,
	motivazione           CHARACTER VARYING(500)  NULL 
);



ALTER TABLE sigit_t_impianto
	ADD CONSTRAINT  PK_sigit_t_impianto PRIMARY KEY (codice_impianto);



CREATE TABLE sigit_t_libretto
(
	id_libretto           NUMERIC  NOT NULL ,
	fk_stato              NUMERIC  NOT NULL ,
	fk_tipo_intervento    NUMERIC  NOT NULL ,
	fk_motivo_consolid    NUMERIC  NULL ,
	fk_tipo_documento     NUMERIC  NOT NULL ,
	data_intervento       DATE  NULL ,
	data_consolidamento   DATE  NULL ,
	file_index            CHARACTER VARYING(100)  NULL ,
	uid_index             CHARACTER VARYING(50)  NULL ,
	cf_redattore          CHARACTER VARYING(16)  NULL ,
	xml_libretto          bytea  NULL ,
	flg_controllo_bozza   NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_462 CHECK (flg_controllo_bozza IN (0,1)),
	data_ult_mod          TIMESTAMP  NOT NULL ,
	utente_ult_mod        CHARACTER VARYING(16)  NOT NULL ,
	codice_impianto       NUMERIC  NOT NULL 
);



ALTER TABLE sigit_t_libretto
	ADD CONSTRAINT  PK_sigit_t_libretto PRIMARY KEY (id_libretto);



CREATE TABLE sigit_t_persona_fisica
(
	id_persona_fisica     NUMERIC(6)  NOT NULL ,
	nome                  CHARACTER VARYING(100)  NULL ,
	cognome               CHARACTER VARYING(100)  NULL ,
	codice_fiscale        CHARACTER VARYING(16)  NULL ,
	fk_l2                 NUMERIC(6)  NULL ,
	indirizzo_sitad       CHARACTER VARYING(200)  NULL ,
	indirizzo_non_trovato  CHARACTER VARYING(100)  NULL ,
	istat_comune          CHARACTER VARYING(6)  NULL ,
	sigla_prov            CHARACTER VARYING(2)  NULL ,
	comune                CHARACTER VARYING(100)  NULL ,
	provincia             CHARACTER VARYING(100)  NULL ,
	civico                CHARACTER VARYING(10)  NULL ,
	cap                   CHARACTER VARYING(5)  NULL ,
	email                 CHARACTER VARYING(100)  NULL ,
	flg_accreditato       CHARACTER VARYING(1)  NULL  CONSTRAINT  dom_a_d_2 CHECK (flg_accreditato IN ('A','D')),
	data_ult_mod          TIMESTAMP  NOT NULL ,
	utente_ult_mod        CHARACTER VARYING(16)  NOT NULL 
);



ALTER TABLE sigit_t_persona_fisica
	ADD CONSTRAINT  PK_sigit_t_persona_fisica PRIMARY KEY (id_persona_fisica);



CREATE TABLE sigit_t_persona_giuridica
(
	id_persona_giuridica  NUMERIC(6)  NOT NULL ,
	denominazione         CHARACTER VARYING(500)  NULL ,
	codice_fiscale        CHARACTER VARYING(16)  NULL ,
	fk_l2                 NUMERIC(6)  NULL ,
	indirizzo_sitad       CHARACTER VARYING(200)  NULL ,
	indirizzo_non_trovato  CHARACTER VARYING(100)  NULL ,
	sigla_prov            CHARACTER VARYING(2)  NULL ,
	istat_comune          CHARACTER VARYING(6)  NULL ,
	comune                CHARACTER VARYING(100)  NULL ,
	provincia             CHARACTER VARYING(100)  NULL ,
	civico                CHARACTER VARYING(10)  NULL ,
	cap                   CHARACTER VARYING(5)  NULL ,
	email                 CHARACTER VARYING(100)  NULL ,
	data_inizio_attivita  DATE  NULL ,
	data_cessazione       DATE  NULL ,
	sigla_rea             CHARACTER VARYING(2)  NULL ,
	numero_rea            NUMERIC(11)  NULL ,
	flg_installatore      NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_pg4 CHECK (flg_installatore IN (0,1)),
	flg_manutentore       NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_pg3 CHECK (flg_manutentore IN (0,1)),
	flg_amministratore    NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_pg2 CHECK (flg_amministratore IN (0,1)),
	data_ult_mod          TIMESTAMP  NOT NULL ,
	utente_ult_mod        CHARACTER VARYING(16)  NOT NULL ,
	flg_terzo_responsabile  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_pg1 CHECK (flg_terzo_responsabile IN (0,1))
);



ALTER TABLE sigit_t_persona_giuridica
	ADD CONSTRAINT  PK_sigit_t_persona_giuridica PRIMARY KEY (id_persona_giuridica);



CREATE TABLE sigit_t_rapp_tipo1
(
	id_allegato           NUMERIC  NOT NULL ,
	d_flg_locale_int_idoneo  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2 CHECK (d_flg_locale_int_idoneo IN (0,1,2)),
	d_flg_gen_ext_idoneo  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_101 CHECK (d_flg_gen_ext_idoneo IN (0,1,2)),
	d_flg_aperture_libere  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_102 CHECK (d_flg_aperture_libere IN (0,1,2)),
	d_flg_aperture_adeg   NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_103 CHECK (d_flg_aperture_adeg IN (0,1,2)),
	d_flg_scarico_idoneo  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_104 CHECK (d_flg_scarico_idoneo IN (0,1,2)),
	d_flg_temp_amb_funz   NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_105 CHECK (d_flg_temp_amb_funz IN (0,1,2)),
	d_flg_assenza_perd_comb  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_106 CHECK (d_flg_assenza_perd_comb IN (0,1,2)),
	d_flg_ido_ten_imp_int  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_107 CHECK (d_flg_ido_ten_imp_int IN (0,1,2)),
	f_flg_adozione_valvole_term  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_930 CHECK (f_flg_adozione_valvole_term IN (0,1)),
	f_flg_isolamente_rete  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_931 CHECK (f_flg_isolamente_rete IN (0,1)),
	f_flg_adoz_sist_trattam_h2o  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_932 CHECK (f_flg_adoz_sist_trattam_h2o IN (0,1)),
	f_flg_sostituz_sist_regolaz  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_933 CHECK (f_flg_sostituz_sist_regolaz IN (0,1))
);



ALTER TABLE sigit_t_rapp_tipo1
	ADD CONSTRAINT  PK_sigit_t_rapp_tipo1 PRIMARY KEY (id_allegato);



CREATE TABLE sigit_t_rapp_tipo2
(
	id_allegato           NUMERIC  NOT NULL ,
	d_flg_locale_idoneo   NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_110 CHECK (d_flg_locale_idoneo IN (0,1,2)),
	d_flg_aperture_libere  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_111 CHECK (d_flg_aperture_libere IN (0,1,2)),
	d_flg_aperture_adeg   NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_112 CHECK (d_flg_aperture_adeg IN (0,1,2)),
	d_flg_linea_elett_idonea  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_2_113 CHECK (d_flg_linea_elett_idonea IN (0,1,2)),
	f_flg_sostituz_generatori  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_580 CHECK (f_flg_sostituz_generatori IN (0,1)),
	f_flg_sostituz_sistemi_reg  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_581 CHECK (f_flg_sostituz_sistemi_reg IN (0,1)),
	f_flg_isol_distribuz_h2o  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_582 CHECK (f_flg_isol_distribuz_h2o IN (0,1)),
	f_flg_isol_distribuz_aria  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_583 CHECK (f_flg_isol_distribuz_aria IN (0,1))
);



ALTER TABLE sigit_t_rapp_tipo2
	ADD CONSTRAINT  PK_sigit_t_rapp_tipo2 PRIMARY KEY (id_allegato);



CREATE TABLE sigit_t_rapp_tipo3
(
	id_allegato           NUMERIC  NOT NULL ,
	d_flg_locale_idoneo   NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_230 CHECK (d_flg_locale_idoneo IN (0,1)),
	d_flg_linea_elett_idonea  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_231 CHECK (d_flg_linea_elett_idonea IN (0,1)),
	d_flg_coib_idonea     NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_232 CHECK (d_flg_coib_idonea IN (0,1)),
	d_flg_assenza_perdite  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_233 CHECK (d_flg_assenza_perdite IN (0,1)),
	f_flg_valvole_termost  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_550 CHECK (f_flg_valvole_termost IN (0,1)),
	f_flg_verifica_param  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_551 CHECK (f_flg_verifica_param IN (0,1)),
	f_flg_perdite_h2o     NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_552 CHECK (f_flg_perdite_h2o IN (0,1)),
	f_flg_install_involucro  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_554 CHECK (f_flg_install_involucro IN (0,1))
);



ALTER TABLE sigit_t_rapp_tipo3
	ADD CONSTRAINT  PK_sigit_t_rapp_tipo3 PRIMARY KEY (id_allegato);



CREATE TABLE sigit_t_rapp_tipo4
(
	id_allegato           NUMERIC  NOT NULL ,
	d_flg_luogo_idoneo    NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_250 CHECK (d_flg_luogo_idoneo IN (0,1)),
	d_flg_ventilaz_adeg   NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_251 CHECK (d_flg_ventilaz_adeg IN (0,1)),
	d_flg_ventilaz_libera  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_252 CHECK (d_flg_ventilaz_libera IN (0,1)),
	d_flg_linea_elett_idonea  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_253 CHECK (d_flg_linea_elett_idonea IN (0,1)),
	d_flg_camino_idoneo   NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_254 CHECK (d_flg_camino_idoneo IN (0,1)),
	d_flg_capsula_idonea  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_255 CHECK (d_flg_capsula_idonea IN (0,1)),
	d_flg_circ_idr_idoneo  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_256 CHECK (d_flg_circ_idr_idoneo IN (0,1)),
	d_flg_circ_olio_idoneo  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_257 CHECK (d_flg_circ_olio_idoneo IN (0,1)),
	d_flg_circ_comb_idoneo  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_258 CHECK (d_flg_circ_comb_idoneo IN (0,1)),
	d_flg_funz_scamb_idonea  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_259 CHECK (d_flg_funz_scamb_idonea IN (0,1)),
	f_flg_adozione_valvole  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_620 CHECK (f_flg_adozione_valvole IN (0,1)),
	f_flg_isolamento_rete  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_621 CHECK (f_flg_isolamento_rete IN (0,1)),
	f_flg_sistema_tratt_h2o  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_622 CHECK (f_flg_sistema_tratt_h2o IN (0,1)),
	f_flg_sost_sistema_regolaz  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_623 CHECK (f_flg_sost_sistema_regolaz IN (0,1))
);



ALTER TABLE sigit_t_rapp_tipo4
	ADD CONSTRAINT  PK_sigit_t_rapp_tipo4 PRIMARY KEY (id_allegato);



CREATE TABLE sigit_t_terzo_responsabile
(
	id_imp_ruolo_pfpg     NUMERIC  NOT NULL ,
	id_persona_giuridica  NUMERIC(6)  NOT NULL ,
	data_inizio           DATE  NULL ,
	data_fine             DATE  NULL ,
	rif_index_contratto   CHARACTER VARYING(100)  NULL ,
	data_ult_mod          TIMESTAMP  NOT NULL ,
	utente_ult_mod        CHARACTER VARYING(16)  NOT NULL 
);



ALTER TABLE sigit_t_terzo_responsabile
	ADD CONSTRAINT  PK_sigit_t_terzo_responsabile PRIMARY KEY (id_imp_ruolo_pfpg,id_persona_giuridica);



CREATE TABLE sigit_t_transazione_boll
(
	id_transazione_boll   NUMERIC  NOT NULL ,
	id_stato_transazione  NUMERIC(3)  NOT NULL ,
	fk_tipo_pagamento     NUMERIC(3)  NOT NULL ,
	cf_utente             CHARACTER VARYING(16)  NOT NULL ,
	data_transazione      DATE  NOT NULL ,
	sigla_bollino         CHARACTER VARYING(2)  NULL ,
	bollino_da            NUMERIC  NULL ,
	bollino_a             NUMERIC  NULL ,
	fk_persona_giuridica  NUMERIC(6)  NULL ,
	data_ult_mod          TIMESTAMP  NOT NULL ,
	utente_ult_mod        CHARACTER VARYING(16)  NOT NULL ,
	num_transazione       CHARACTER VARYING(70)  NULL ,
	note                  CHARACTER VARYING(1000)  NULL 
);



ALTER TABLE sigit_t_transazione_boll
	ADD CONSTRAINT  PK_sigit_t_transazione_boll PRIMARY KEY (id_transazione_boll);



CREATE TABLE sigit_t_transazione_imp
(
	id_transazione        NUMERIC  NOT NULL ,
	fk_persona_giuridica  NUMERIC(6)  NOT NULL ,
	cf_utente             CHARACTER VARYING(16)  NOT NULL ,
	data_transazione      DATE  NOT NULL ,
	impianto_da           NUMERIC  NULL ,
	impianto_a            NUMERIC  NULL ,
	data_ult_mod          TIMESTAMP  NOT NULL ,
	utente_ult_mod        CHARACTER VARYING(16)  NOT NULL ,
	note                  CHARACTER VARYING(1000)  NULL 
);



ALTER TABLE sigit_t_transazione_imp
	ADD CONSTRAINT  PK_sigit_t_transazione_imp PRIMARY KEY (id_transazione);



CREATE TABLE sigit_t_tratt_h2o
(
	codice_impianto       NUMERIC  NOT NULL ,
	l2_1_h2o_clima_m3     NUMERIC  NULL ,
	l2_2_durezza_h2o_fr   NUMERIC  NULL ,
	l2_3_flg_tratt_risc_non_rich  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_971 CHECK (l2_3_flg_tratt_risc_non_rich IN (0,1)),
	l2_3_flg_tratt_clima_assente  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_970 CHECK (l2_3_flg_tratt_clima_assente IN (0,1)),
	l2_3_durezza_tot_h2o_fr  NUMERIC  NULL ,
	l2_3_flg_tratt_clima_filtr  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_969 CHECK (l2_3_flg_tratt_clima_filtr IN (0,1)),
	l2_3_flg_tratt_clima_addolc  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_968 CHECK (l2_3_flg_tratt_clima_addolc IN (0,1)),
	l2_3_flg_tratt_clima_chimico  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_967 CHECK (l2_3_flg_tratt_clima_chimico IN (0,1)),
	l2_3_flg_tratt_gelo_assente  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_966 CHECK (l2_3_flg_tratt_gelo_assente IN (0,1)),
	l2_3_flg_tratt_gelo_gli_etil  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_965 CHECK (l2_3_flg_tratt_gelo_gli_etil IN (0,1)),
	l2_3_perc_gli_etil    NUMERIC  NULL ,
	l2_3_ph_gli_etil      NUMERIC  NULL ,
	l2_3_flg_tratt_gelo_gli_prop  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_964 CHECK (l2_3_flg_tratt_gelo_gli_prop IN (0,1)),
	l2_3_perc_gli_prop    NUMERIC  NULL ,
	l2_3_ph_gli_prop      NUMERIC  NULL ,
	l2_4_flg_tratt_acs_non_rich  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_963 CHECK (l2_4_flg_tratt_acs_non_rich IN (0,1)),
	l2_4_flg_tratt_acs_assente  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_962 CHECK (l2_4_flg_tratt_acs_assente IN (0,1)),
	l2_4_flg_tratt_acs_filtr  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_961 CHECK (l2_4_flg_tratt_acs_filtr IN (0,1)),
	l2_4_flg_tratt_acs_addolc  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_960 CHECK (l2_4_flg_tratt_acs_addolc IN (0,1)),
	l2_4_durezza_addolc_fr  NUMERIC  NULL ,
	l2_4_flg_tratt_acs_chimico  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_958 CHECK (l2_4_flg_tratt_acs_chimico IN (0,1)),
	l2_5_flg_tratt_raff_assente  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_957 CHECK (l2_5_flg_tratt_raff_assente IN (0,1)),
	l2_5_flg_tratt_raff_no_rt  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_956 CHECK (l2_5_flg_tratt_raff_no_rt IN (0,1)),
	l2_5_flg_tratt_raff_rtp  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_955 CHECK (l2_5_flg_tratt_raff_rtp IN (0,1)),
	l2_5_flg_tratt_raff_rtt  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_954 CHECK (l2_5_flg_tratt_raff_rtt IN (0,1)),
	l2_5_flg_tratt_raff_acq  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_953 CHECK (l2_5_flg_tratt_raff_acq IN (0,1)),
	l2_5_flg_tratt_raff_pzz  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_952 CHECK (l2_5_flg_tratt_raff_pzz IN (0,1)),
	l2_5_flg_tratt_raff_h2o_sup  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_951 CHECK (l2_5_flg_tratt_raff_h2o_sup IN (0,1)),
	l2_5_flg_tratt_f_filt_sic  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_950 CHECK (l2_5_flg_tratt_f_filt_sic IN (0,1)),
	l2_5_flg_tratt_f_filt_mas  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_710 CHECK (l2_5_flg_tratt_f_filt_mas IN (0,1)),
	l2_5_flg_tratt_f_no_tratt  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_709 CHECK (l2_5_flg_tratt_f_no_tratt IN (0,1)),
	l2_5_tratt_f_altro    CHARACTER VARYING(100)  NULL ,
	l2_5_flg_tratt_t_addolc  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_708 CHECK (l2_5_flg_tratt_t_addolc IN (0,1)),
	l2_5_flg_tratt_t_osmosi  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_707 CHECK (l2_5_flg_tratt_t_osmosi IN (0,1)),
	l2_5_flg_tratt_t_demin  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_706 CHECK (l2_5_flg_tratt_t_demin IN (0,1)),
	l2_5_flg_tratt_t_no_tratt  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_705 CHECK (l2_5_flg_tratt_t_no_tratt IN (0,1)),
	l2_5_tratt_t_altro    CHARACTER VARYING(100)  NULL ,
	l2_5_flg_tratt_c_paantincro  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_704 CHECK (l2_5_flg_tratt_c_paantincro IN (0,1)),
	l2_5_flg_tratt_c_paanticorr  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_703 CHECK (l2_5_flg_tratt_c_paanticorr IN (0,1)),
	l2_5_flg_tratt_c_aaa  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_700 CHECK (l2_5_flg_tratt_c_aaa IN (0,1)),
	l2_5_flg_tratt_c_biocida  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_701 CHECK (l2_5_flg_tratt_c_biocida IN (0,1)),
	l2_5_flg_tratt_c_no_tratt  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_702 CHECK (l2_5_flg_tratt_c_no_tratt IN (0,1)),
	l2_5_tratt_c_altro    CHARACTER VARYING(100)  NULL ,
	l2_5_flg_spurgo_autom  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_460 CHECK (l2_5_flg_spurgo_autom IN (0,1)),
	l2_5_conduc_h2o_ing   NUMERIC  NULL ,
	l2_5_taratura         NUMERIC  NULL 
);



ALTER TABLE sigit_t_tratt_h2o
	ADD CONSTRAINT  PK_sigit_t_tratt_h2o PRIMARY KEY (codice_impianto);



CREATE TABLE sigit_t_unita_immobiliare
(
	id_unita_imm          NUMERIC(11)   DEFAULT  0 NOT NULL ,
	codice_impianto       NUMERIC  NOT NULL ,
	fk_l2                 NUMERIC(8)  NULL ,
	indirizzo_sitad       CHARACTER VARYING(200)  NULL ,
	indirizzo_non_trovato  CHARACTER VARYING(200)  NULL ,
	civico                CHARACTER VARYING(10)  NULL ,
	cap                   CHARACTER VARYING(5)  NULL ,
	scala                 CHARACTER VARYING(4)  NULL ,
	palazzo               CHARACTER VARYING(20)  NULL ,
	interno               CHARACTER VARYING(10)  NULL ,
	note                  CHARACTER VARYING(2000)  NULL ,
	flg_principale        NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_33 CHECK (flg_principale IN (0,1)),
	sezione               CHARACTER VARYING(5)  NULL ,
	foglio                CHARACTER VARYING(5)  NULL ,
	particella            CHARACTER VARYING(9)  NULL ,
	subalterno            CHARACTER VARYING(4)  NULL ,
	pod_elettrico         CHARACTER VARYING(20)  NULL ,
	pdr_gas               CHARACTER VARYING(20)  NULL ,
	data_ult_mod          TIMESTAMP  NOT NULL ,
	utente_ult_mod        CHARACTER VARYING(16)  NOT NULL ,
	l1_2_flg_singola_unita  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_su CHECK (l1_2_flg_singola_unita IN (0,1)),
	l1_2_fk_categoria     CHARACTER VARYING(10)  NULL ,
	l1_2_vol_risc_m3      NUMERIC  NULL ,
	l1_2_vol_raff_m3      NUMERIC  NULL 
);



ALTER TABLE sigit_t_unita_immobiliare
	ADD CONSTRAINT  PK_sigit_t_unita_immobiliare PRIMARY KEY (ID_UNITA_IMM);



CREATE TABLE sigit_w_email_newsl_tot
(
	email                 CHARACTER VARYING(70)  NULL ,
	categ_desc            CHARACTER VARYING(100)  NULL ,
	categ_id              NUMERIC(11)  NULL ,
	flg_canc              CHARACTER VARYING(1)  NULL ,
	dt_insert_nl          DATE  NULL ,
	dt_canc_nl            DATE  NULL 
);



CREATE TABLE sigit_wrk_config
(
	id_config             NUMERIC(3)  NOT NULL ,
	chiave_config         CHARACTER VARYING(50)  NULL ,
	valore_config_num     NUMERIC(6)  NULL ,
	valore_config_char    CHARACTER VARYING(50)  NULL ,
	valore_flag           CHARACTER VARYING(1)  NULL 
);



ALTER TABLE sigit_wrk_config
	ADD CONSTRAINT  PK_SIGIT_T_CONFIG PRIMARY KEY (id_config);



CREATE TABLE sigit_wrk_log
(
	codice_fiscale        CHARACTER VARYING(16)  NULL ,
	data_operazione       TIMESTAMP  NULL ,
	tbl_impattata         CHARACTER VARYING(30)  NULL ,
	id_record             CHARACTER VARYING(500)  NULL ,
	tipo_operazione       CHARACTER VARYING(20)  NULL,
	id_log                SERIAL  NOT NULL 
);



ALTER TABLE sigit_wrk_log
	ADD CONSTRAINT  PK_sigit_wrk_log PRIMARY KEY (id_log);



CREATE TABLE sigit_wrk_ruolo_funz
(
  ruolo character varying(50) NOT NULL,
  flg_acq_bollino numeric(1,0),
  flg_acq_cod_imp numeric(1,0),
  flg_acq_boll_trans numeric(1,0),
  flg_impianto numeric(1,0),
  flg_allegato numeric(1,0),
  flg_consultazione numeric(1,0),
  flg_ispezione numeric(1,0),
  flg_import_mass_allegato numeric(1,0),
  flg_subentro numeric(1,0),
  flg_delega numeric(1,0),
  flg_3responsabile numeric(1,0),
  CONSTRAINT dom_0_1_080 CHECK (flg_acq_bollino = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT dom_0_1_081 CHECK (flg_acq_cod_imp = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT dom_0_1_082 CHECK (flg_acq_boll_trans = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT dom_0_1_083 CHECK (flg_impianto = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT dom_0_1_084 CHECK (flg_allegato = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT dom_0_1_085 CHECK (flg_consultazione = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT dom_0_1_086 CHECK (flg_ispezione = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT dom_0_1_087 CHECK (flg_import_mass_allegato = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT dom_0_1_088 CHECK (flg_subentro = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT dom_0_1_089 CHECK (flg_delega = ANY (ARRAY[0::numeric, 1::numeric])),
  CONSTRAINT dom_0_1_090 CHECK (flg_3responsabile = ANY (ARRAY[0::numeric, 1::numeric]))
);




ALTER TABLE sigit_wrk_ruolo_funz
	ADD CONSTRAINT  PK_sigit_wrk_ruolo_funz PRIMARY KEY (ruolo);


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
            sigit_t_terzo_responsabile.data_inizio AS data_inizio_3r, 
            sigit_t_terzo_responsabile.data_fine AS data_fine_3r, 
            sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg, 
            sigit_t_terzo_responsabile.id_persona_giuridica AS id_persona_giuridica_3r, 
            sigit_t_persona_giuridica.denominazione AS denominazione_3r, 
            sigit_t_persona_giuridica.codice_fiscale AS codice_fiscale_3r, 
            sigit_t_comp4.matricola, sigit_t_comp4.id_tipo_componente, 
            sigit_t_comp4.progressivo, sigit_t_comp4.data_install, 
            sigit_r_imp_ruolo_pfpg.data_inizio AS data_inizio_pfpg, 
            sigit_r_imp_ruolo_pfpg.data_fine AS data_fine_pfpg
           FROM sigit_t_impianto
      JOIN sigit_t_unita_immobiliare ON sigit_t_impianto.codice_impianto = sigit_t_unita_immobiliare.codice_impianto
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_t_unita_immobiliare.codice_impianto = sigit_r_imp_ruolo_pfpg.codice_impianto
   JOIN sigit_t_persona_fisica ON sigit_r_imp_ruolo_pfpg.fk_persona_fisica = sigit_t_persona_fisica.id_persona_fisica
   JOIN sigit_d_ruolo ON sigit_r_imp_ruolo_pfpg.fk_ruolo = sigit_d_ruolo.id_ruolo
   LEFT JOIN sigit_t_terzo_responsabile ON sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg = sigit_t_terzo_responsabile.id_imp_ruolo_pfpg
   LEFT JOIN sigit_t_persona_giuridica ON sigit_t_terzo_responsabile.id_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
   LEFT JOIN sigit_t_comp4 ON sigit_t_impianto.codice_impianto = sigit_t_comp4.codice_impianto
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
            sigit_t_terzo_responsabile.data_inizio AS data_inizio_3r, 
            sigit_t_terzo_responsabile.data_fine AS data_fine_3r, 
            sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg, 
            sigit_t_terzo_responsabile.id_persona_giuridica AS id_persona_giuridica_3r, 
            sigit_t_persona_giuridica_1.denominazione AS denominazione_3r, 
            sigit_t_persona_giuridica_1.codice_fiscale AS codice_fiscale_3r, 
            sigit_t_comp4.matricola, sigit_t_comp4.id_tipo_componente, 
            sigit_t_comp4.progressivo, sigit_t_comp4.data_install, 
            sigit_r_imp_ruolo_pfpg.data_inizio AS data_inizio_pfpg, 
            sigit_r_imp_ruolo_pfpg.data_fine AS data_fine_pfpg
           FROM sigit_t_impianto
      JOIN sigit_t_unita_immobiliare ON sigit_t_impianto.codice_impianto = sigit_t_unita_immobiliare.codice_impianto
   JOIN sigit_r_imp_ruolo_pfpg ON sigit_t_unita_immobiliare.codice_impianto = sigit_r_imp_ruolo_pfpg.codice_impianto
   JOIN sigit_t_persona_giuridica ON sigit_r_imp_ruolo_pfpg.fk_persona_giuridica = sigit_t_persona_giuridica.id_persona_giuridica
   JOIN sigit_d_ruolo ON sigit_r_imp_ruolo_pfpg.fk_ruolo = sigit_d_ruolo.id_ruolo
   LEFT JOIN sigit_t_terzo_responsabile ON sigit_r_imp_ruolo_pfpg.id_imp_ruolo_pfpg = sigit_t_terzo_responsabile.id_imp_ruolo_pfpg
   LEFT JOIN sigit_t_persona_giuridica sigit_t_persona_giuridica_1 ON sigit_t_terzo_responsabile.id_persona_giuridica = sigit_t_persona_giuridica_1.id_persona_giuridica
   LEFT JOIN sigit_t_comp4 ON sigit_t_impianto.codice_impianto = sigit_t_comp4.codice_impianto
  WHERE sigit_t_unita_immobiliare.flg_principale = 1::numeric;




CREATE OR REPLACE VIEW vista_pf_pg AS 
         SELECT sigit_t_persona_giuridica.id_persona_giuridica AS id_persona, 
            'PG'::character varying(2) AS pf_pg, 
            NULL::character varying(100) AS nome, 
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
            sigit_t_persona_giuridica.data_cessazione
           FROM sigit_t_persona_giuridica
UNION 
         SELECT sigit_t_persona_fisica.id_persona_fisica AS id_persona, 
            'PF'::character varying(2) AS pf_pg, sigit_t_persona_fisica.nome, 
            sigit_t_persona_fisica.cognome::character varying(500) AS denominazione, 
            sigit_t_persona_fisica.codice_fiscale, sigit_t_persona_fisica.fk_l2, 
            sigit_t_persona_fisica.indirizzo_sitad, 
            sigit_t_persona_fisica.indirizzo_non_trovato, 
            sigit_t_persona_fisica.sigla_prov, 
            sigit_t_persona_fisica.istat_comune, sigit_t_persona_fisica.comune, 
            sigit_t_persona_fisica.provincia, sigit_t_persona_fisica.civico, 
            sigit_t_persona_fisica.cap, sigit_t_persona_fisica.email, 
            NULL::date AS data_inizio_attivita, NULL::date AS data_cessazione
           FROM sigit_t_persona_fisica;




CREATE OR REPLACE VIEW vista_bollini AS 
 SELECT sigit_t_codice_boll.sigla_bollino, sigit_t_codice_boll.numero_bollino, 
    sigit_t_codice_boll.fk_transazione_boll, sigit_t_codice_boll.fk_potenza, 
    sigit_t_codice_boll.fk_prezzo, 
    sigit_t_codice_boll.fk_dt_inizio_acquisto AS fk_dt_inizio, 
    sigit_d_potenza_imp.des_potenza, sigit_d_potenza_imp.limite_inferiore, 
    sigit_d_potenza_imp.limite_superiore, sigit_d_prezzo_potenza.prezzo
   FROM sigit_t_codice_boll, sigit_d_potenza_imp, sigit_r_potenza_prezzo, 
    sigit_d_prezzo_potenza
  WHERE sigit_t_codice_boll.fk_potenza = sigit_r_potenza_prezzo.id_potenza 
  AND sigit_t_codice_boll.fk_prezzo = sigit_r_potenza_prezzo.id_prezzo 
  AND sigit_t_codice_boll.fk_dt_inizio_acquisto = sigit_r_potenza_prezzo.dt_inizio_acquisto 
  AND sigit_r_potenza_prezzo.id_potenza = sigit_d_potenza_imp.id_potenza 
  AND sigit_r_potenza_prezzo.id_prezzo = sigit_d_prezzo_potenza.id_prezzo 
  AND (now() >= sigit_r_potenza_prezzo.dt_inizio_acquisto 
  AND now() <= sigit_r_potenza_prezzo.dt_fine_acquisto OR sigit_r_potenza_prezzo.dt_inizio_acquisto <= now() 
  AND sigit_r_potenza_prezzo.dt_fine_acquisto IS NULL);


CREATE OR REPLACE VIEW vista_potenza_prezzo AS 
 SELECT sigit_d_potenza_imp.id_potenza, sigit_d_potenza_imp.des_potenza, 
    sigit_d_potenza_imp.limite_inferiore, sigit_d_potenza_imp.limite_superiore, 
    sigit_d_prezzo_potenza.id_prezzo, sigit_d_prezzo_potenza.prezzo, 
    sigit_r_potenza_prezzo.dt_inizio_acquisto AS dt_inizio, 
    sigit_r_potenza_prezzo.dt_fine_acquisto AS dt_fine
   FROM sigit_d_potenza_imp, sigit_r_potenza_prezzo, sigit_d_prezzo_potenza
  WHERE sigit_r_potenza_prezzo.id_potenza = sigit_d_potenza_imp.id_potenza AND sigit_r_potenza_prezzo.id_prezzo = sigit_d_prezzo_potenza.id_prezzo AND (now() >= sigit_r_potenza_prezzo.dt_inizio_acquisto AND now() <= sigit_r_potenza_prezzo.dt_fine_acquisto OR sigit_r_potenza_prezzo.dt_inizio_acquisto <= now() AND sigit_r_potenza_prezzo.dt_fine_acquisto IS NULL);


CREATE OR REPLACE VIEW vista_ricerca_allegati AS 
         SELECT a.id_allegato, a.fk_stato_rapp, a.fk_imp_ruolo_pfpg, 
            a.fk_tipo_documento, a.fk_sigla_bollino, a.fk_numero_bollino, 
            a.data_controllo, a.b_flg_libretto_uso, a.b_flg_dichiar_conform, 
            a.b_flg_lib_imp, a.b_flg_lib_compl, a.f_osservazioni, 
            a.f_raccomandazioni, a.f_prescrizioni, a.f_flg_puo_funzionare, 
            a.f_intervento_entro, a.f_ora_arrivo, a.f_ora_partenza, 
            a.f_denominaz_tecnico, a.f_flg_firma_tecnico, 
            a.f_flg_firma_responsabile, a.data_invio, 
            NULL::date AS data_respinta, a.xml_allegato, a.nome_allegato, 
            a.data_ult_mod, a.utente_ult_mod, ru.des_ruolo, ru.ruolo_funz, 
            pf.nome AS pf_nome, pf.cognome AS pf_cognome, 
            pf.codice_fiscale AS pf_codice_fiscale, 
            pg.denominazione AS pg_denominazione, 
            pg.codice_fiscale AS pg_codice_fiscale, 
            pg.sigla_rea AS pg_sigla_rea, pg.numero_rea AS pg_numero_rea, 
            r1.codice_impianto, i.denominazione_comune AS comune_impianto, 
            i.sigla_provincia AS sigla_prov_impianto, 
            COALESCE(u.indirizzo_sitad, u.indirizzo_non_trovato) AS indirizzo_unita_immob, 
            u.civico AS civico_unita_immob
           FROM sigit_t_allegato a
      JOIN sigit_r_imp_ruolo_pfpg r1 ON a.fk_imp_ruolo_pfpg = r1.id_imp_ruolo_pfpg
   JOIN sigit_d_ruolo ru ON r1.fk_ruolo = ru.id_ruolo
   LEFT JOIN sigit_t_persona_fisica pf ON r1.fk_persona_fisica = pf.id_persona_fisica
   LEFT JOIN sigit_t_persona_giuridica pg ON r1.fk_persona_giuridica = pg.id_persona_giuridica
   LEFT JOIN sigit_t_impianto i ON r1.codice_impianto = i.codice_impianto
   LEFT JOIN sigit_t_unita_immobiliare u ON r1.codice_impianto = u.codice_impianto
  WHERE u.flg_principale = 1::numeric
UNION 
         SELECT NULL::numeric AS id_allegato, 2::numeric(2,0) AS fk_stato_rapp, 
            a.id_imp_ruolo_pfpg AS fk_imp_ruolo_pfpg, a.fk_tipo_documento, 
            a.sigla_bollino AS fk_sigla_bollino, 
            a.numero_bollino AS fk_numero_bollino, a.data_controllo, 
            NULL::numeric(1,0) AS b_flg_libretto_uso, 
            NULL::numeric(1,0) AS b_flg_dichiar_conform, 
            NULL::numeric(1,0) AS b_flg_lib_imp, 
            NULL::numeric(1,0) AS b_flg_lib_compl, a.f_osservazioni, 
            a.f_raccomandazioni, a.f_prescrizioni, 
            NULL::numeric(1,0) AS f_flg_puo_funzionare, a.f_intervento_entro, 
            NULL::character varying(10) AS f_ora_arrivo, 
            NULL::character varying(10) AS f_ora_partenza, 
            NULL::character varying(100) AS f_denominaz_tecnico, 
            NULL::numeric(1,0) AS f_flg_firma_tecnico, 
            NULL::numeric(1,0) AS f_flg_firma_responsabile, a.data_invio, 
            a.data_respinta, a.xml_allegato, a.nome_allegato, a.data_ult_mod, 
            a.utente_ult_mod, ru.des_ruolo, ru.ruolo_funz, pf.nome AS pf_nome, 
            pf.cognome AS pf_cognome, pf.codice_fiscale AS pf_codice_fiscale, 
            pg.denominazione AS pg_denominazione, 
            pg.codice_fiscale AS pg_codice_fiscale, 
            pg.sigla_rea AS pg_sigla_rea, pg.numero_rea AS pg_numero_rea, 
            r1.codice_impianto, i.denominazione_comune AS comune_impianto, 
            i.sigla_provincia AS sigla_prov_impianto, 
            COALESCE(u.indirizzo_sitad, u.indirizzo_non_trovato) AS indirizzo_unita_immob, 
            u.civico AS civico_unita_immob
           FROM sigit_t_all_respinto a
      JOIN sigit_r_imp_ruolo_pfpg r1 ON a.id_imp_ruolo_pfpg = r1.id_imp_ruolo_pfpg
   JOIN sigit_d_ruolo ru ON r1.fk_ruolo = ru.id_ruolo
   LEFT JOIN sigit_t_persona_fisica pf ON r1.fk_persona_fisica = pf.id_persona_fisica
   LEFT JOIN sigit_t_persona_giuridica pg ON r1.fk_persona_giuridica = pg.id_persona_giuridica
   LEFT JOIN sigit_t_impianto i ON r1.codice_impianto = i.codice_impianto
   LEFT JOIN sigit_t_unita_immobiliare u ON r1.codice_impianto = u.codice_impianto
  WHERE u.flg_principale = 1::numeric;



CREATE OR REPLACE VIEW vista_comp_gt_dett AS 
 SELECT sigit_t_comp4.codice_impianto, sigit_t_comp4.id_tipo_componente, 
    sigit_t_comp4.progressivo, sigit_t_comp4.data_install, 
    sigit_t_comp4.data_dismiss, sigit_t_comp4.matricola, sigit_t_comp4.modello, 
    sigit_t_comp4.fk_combustibile, sigit_t_comp4.fk_marca, 
    sigit_t_comp4.potenza_termica_kw, sigit_t_comp4.data_ult_mod, 
    sigit_t_comp4.utente_ult_mod, sigit_t_comp_gt.fk_fluido, 
    sigit_t_comp_gt.fk_dettaglio_gt, sigit_t_comp_gt.rendimento_perc, 
    sigit_t_comp_gt.n_moduli, sigit_t_dett_tipo1.id_dett_tipo1, 
    sigit_t_dett_tipo1.fk_allegato, sigit_t_dett_tipo1.e_n_modulo_termico, 
    sigit_t_dett_tipo1.e_pot_term_focol_kw, 
    sigit_t_dett_tipo1.e_flg_clima_inverno, sigit_t_dett_tipo1.e_flg_produz_acs, 
    sigit_t_dett_tipo1.e_flg_dispos_comando, 
    sigit_t_dett_tipo1.e_flg_dispos_sicurezza, 
    sigit_t_dett_tipo1.e_flg_valvola_sicurezza, 
    sigit_t_dett_tipo1.e_flg_scambiatore_fumi, 
    sigit_t_dett_tipo1.e_flg_riflusso, sigit_t_dett_tipo1.e_flg_uni_10389_1, 
    sigit_t_dett_tipo1.e_flg_evacu_fumi, 
    sigit_t_dett_tipo1.e_depr_canale_fumo_pa, sigit_t_dett_tipo1.e_temp_fumi_c, 
    sigit_t_dett_tipo1.e_temp_aria_c, sigit_t_dett_tipo1.e_o2_perc, 
    sigit_t_dett_tipo1.e_co2_perc, sigit_t_dett_tipo1.e_bacharach, 
    sigit_t_dett_tipo1.e_co_corretto_ppm, sigit_t_dett_tipo1.e_rend_comb_perc, 
    sigit_t_dett_tipo1.e_rend_min_legge_perc, sigit_t_dett_tipo1.e_nox_ppm, 
    sigit_t_dett_tipo1.data_ult_mod AS data_ult_mod_dett, 
    sigit_t_dett_tipo1.utente_ult_mod AS utente_ult_mod_dett
   FROM sigit_t_comp4
   JOIN sigit_t_comp_gt ON sigit_t_comp4.codice_impianto = sigit_t_comp_gt.codice_impianto AND sigit_t_comp4.data_install = sigit_t_comp_gt.data_install AND sigit_t_comp4.progressivo::text = sigit_t_comp_gt.progressivo::text AND sigit_t_comp4.id_tipo_componente::text = sigit_t_comp_gt.id_tipo_componente::text
   LEFT JOIN sigit_t_dett_tipo1 ON sigit_t_comp_gt.codice_impianto = sigit_t_dett_tipo1.codice_impianto AND sigit_t_comp_gt.data_install = sigit_t_dett_tipo1.data_install AND sigit_t_comp_gt.progressivo::text = sigit_t_dett_tipo1.progressivo::text AND sigit_t_comp_gt.id_tipo_componente::text = sigit_t_dett_tipo1.fk_tipo_componente::text;



CREATE OR REPLACE VIEW vista_comp_gf_dett AS 
 SELECT sigit_t_comp4.codice_impianto, sigit_t_comp4.id_tipo_componente, 
    sigit_t_comp4.progressivo, sigit_t_comp4.data_install, 
    sigit_t_comp4.data_dismiss, sigit_t_comp4.matricola, 
    sigit_t_comp4.fk_combustibile, sigit_t_comp4.fk_marca, 
    sigit_t_comp4.modello, sigit_t_comp4.potenza_termica_kw, 
    sigit_t_comp4.data_ult_mod, sigit_t_comp4.utente_ult_mod, 
    sigit_t_comp_gf.fk_dettaglio_gf, sigit_t_comp_gf.flg_sorgente_ext, 
    sigit_t_comp_gf.flg_fluido_utenze, sigit_t_comp_gf.fluido_frigorigeno, 
    sigit_t_comp_gf.n_circuiti, sigit_t_comp_gf.raffrescamento_eer, 
    sigit_t_comp_gf.raff_potenza_kw, sigit_t_comp_gf.raff_potenza_ass, 
    sigit_t_comp_gf.riscaldamento_cop, sigit_t_comp_gf.risc_potenza_kw, 
    sigit_t_comp_gf.risc_potenza_ass_kw, sigit_t_dett_tipo2.id_dett_tipo2, 
    sigit_t_dett_tipo2.fk_allegato, sigit_t_dett_tipo2.e_n_circuito, 
    sigit_t_dett_tipo2.e_flg_mod_prova, sigit_t_dett_tipo2.e_flg_perdita_gas, 
    sigit_t_dett_tipo2.e_flg_leak_detector, 
    sigit_t_dett_tipo2.e_flg_param_termodinam, 
    sigit_t_dett_tipo2.e_flg_incrostazioni, sigit_t_dett_tipo2.e_t_suttisc_c, 
    sigit_t_dett_tipo2.e_t_sottoraf_c, sigit_t_dett_tipo2.e_t_condensazione_c, 
    sigit_t_dett_tipo2.e_t_evaporazione_c, sigit_t_dett_tipo2.e_t_in_ext_c, 
    sigit_t_dett_tipo2.e_t_out_ext_c, sigit_t_dett_tipo2.e_t_in_utenze_c, 
    sigit_t_dett_tipo2.e_t_out_utenze_c, 
    sigit_t_dett_tipo2.data_ult_mod AS data_ult_mod_dett, 
    sigit_t_dett_tipo2.utente_ult_mod AS utente_ult_mod_dett
   FROM sigit_t_comp4
   JOIN sigit_t_comp_gf ON sigit_t_comp4.data_install = sigit_t_comp_gf.data_install AND sigit_t_comp4.progressivo::text = sigit_t_comp_gf.progressivo::text AND sigit_t_comp4.codice_impianto = sigit_t_comp_gf.codice_impianto AND sigit_t_comp4.id_tipo_componente::text = sigit_t_comp_gf.id_tipo_componente::text
   LEFT JOIN sigit_t_dett_tipo2 ON sigit_t_comp_gf.codice_impianto = sigit_t_dett_tipo2.codice_impianto AND sigit_t_comp_gf.data_install = sigit_t_dett_tipo2.data_install AND sigit_t_comp_gf.progressivo::text = sigit_t_dett_tipo2.progressivo::text AND sigit_t_comp_gf.id_tipo_componente::text = sigit_t_dett_tipo2.fk_tipo_componente::text;



CREATE OR REPLACE VIEW vista_comp_sc_dett AS 
 SELECT sigit_t_comp4.codice_impianto, sigit_t_comp4.id_tipo_componente, 
    sigit_t_comp4.progressivo, sigit_t_comp4.data_install, 
    sigit_t_comp4.data_dismiss, sigit_t_comp4.matricola, 
    sigit_t_comp4.fk_combustibile, sigit_t_comp4.fk_marca, 
    sigit_t_comp4.modello, sigit_t_comp4.potenza_termica_kw, 
    sigit_t_comp4.data_ult_mod, sigit_t_comp4.utente_ult_mod, 
    sigit_t_dett_tipo3.id_dett_tipo3, sigit_t_dett_tipo3.fk_allegato, 
    sigit_t_dett_tipo3.fk_fluido, sigit_t_dett_tipo3.fk_fluido_alimentaz, 
    sigit_t_dett_tipo3.e_fluido_altro, sigit_t_dett_tipo3.e_alimentazione_altro, 
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
    sigit_t_dett_tipo3.utente_ult_mod AS utente_ult_mod_dett
   FROM sigit_t_comp4
   JOIN sigit_t_comp_sc ON sigit_t_comp4.data_install = sigit_t_comp_sc.data_install AND sigit_t_comp4.progressivo::text = sigit_t_comp_sc.progressivo::text AND sigit_t_comp4.codice_impianto = sigit_t_comp_sc.codice_impianto AND sigit_t_comp4.id_tipo_componente::text = sigit_t_comp_sc.id_tipo_componente::text
   LEFT JOIN sigit_t_dett_tipo3 ON sigit_t_comp_sc.codice_impianto = sigit_t_dett_tipo3.codice_impianto AND sigit_t_comp_sc.data_install = sigit_t_dett_tipo3.data_install AND sigit_t_comp_sc.progressivo::text = sigit_t_dett_tipo3.progressivo::text AND sigit_t_comp_sc.id_tipo_componente::text = sigit_t_dett_tipo3.fk_tipo_componente::text;


CREATE OR REPLACE VIEW vista_comp_cg_dett AS 
 SELECT sigit_t_comp4.codice_impianto, sigit_t_comp4.id_tipo_componente, 
    sigit_t_comp4.progressivo, sigit_t_comp4.data_install, 
    sigit_t_comp4.data_dismiss, sigit_t_comp4.matricola, 
    sigit_t_comp4.fk_combustibile, sigit_t_comp4.fk_marca, 
    sigit_t_comp4.modello, sigit_t_comp4.potenza_termica_kw, 
    sigit_t_comp4.data_ult_mod, sigit_t_comp4.utente_ult_mod, 
    sigit_t_comp_cg.tipologia, sigit_t_comp_cg.potenza_elettrica_kw, 
    sigit_t_comp_cg.temp_h2o_out_min, sigit_t_comp_cg.temp_h2o_out_max, 
    sigit_t_comp_cg.temp_h2o_in_min, sigit_t_comp_cg.temp_h2o_in_max, 
    sigit_t_comp_cg.temp_h2o_motore_min, sigit_t_comp_cg.temp_h2o_motore_max, 
    sigit_t_comp_cg.temp_fumi_valle_min, sigit_t_comp_cg.temp_fumi_valle_max, 
    sigit_t_comp_cg.temp_fumi_monte_min, sigit_t_comp_cg.temp_fumi_monte_max, 
    sigit_t_comp_cg.co_min, sigit_t_comp_cg.co_max, 
    sigit_t_dett_tipo4.id_dett_tipo4, sigit_t_dett_tipo4.fk_allegato, 
    sigit_t_dett_tipo4.fk_fluido, sigit_t_dett_tipo4.e_potenza_assorb_comb_kw, 
    sigit_t_dett_tipo4.e_potenza_term_bypass_kw, 
    sigit_t_dett_tipo4.e_temp_aria_c, sigit_t_dett_tipo4.e_temp_h2o_out_c, 
    sigit_t_dett_tipo4.e_temp_h2o_in_c, 
    sigit_t_dett_tipo4.e_potenza_morsetti_kw, 
    sigit_t_dett_tipo4.e_temp_h2o_motore_c, 
    sigit_t_dett_tipo4.e_temp_fumi_valle_c, 
    sigit_t_dett_tipo4.e_temp_fumi_monte_c, 
    sigit_t_dett_tipo4.data_ult_mod AS data_ult_mod_dett, 
    sigit_t_dett_tipo4.utente_ult_mod AS utente_ult_mod_dett
   FROM sigit_t_comp4
   JOIN sigit_t_comp_cg ON sigit_t_comp4.data_install = sigit_t_comp_cg.data_install AND sigit_t_comp4.progressivo::text = sigit_t_comp_cg.progressivo::text AND sigit_t_comp4.id_tipo_componente::text = sigit_t_comp_cg.id_tipo_componente::text AND sigit_t_comp4.codice_impianto = sigit_t_comp_cg.codice_impianto
   LEFT JOIN sigit_t_dett_tipo4 ON sigit_t_comp_cg.codice_impianto = sigit_t_dett_tipo4.codice_impianto AND sigit_t_comp_cg.data_install = sigit_t_dett_tipo4.data_install AND sigit_t_comp_cg.progressivo::text = sigit_t_dett_tipo4.progressivo::text AND sigit_t_comp_cg.id_tipo_componente::text = sigit_t_dett_tipo4.fk_tipo_componente::text;


CREATE OR REPLACE VIEW vista_comp_cs AS 
 SELECT sigit_t_comp4.codice_impianto, sigit_t_comp4.id_tipo_componente, 
    sigit_t_comp4.progressivo, sigit_t_comp4.data_install, 
    sigit_t_comp4.data_dismiss, sigit_t_comp4.matricola, 
    sigit_t_comp4.fk_combustibile, sigit_t_comp4.fk_marca, 
    sigit_t_comp4.modello, sigit_t_comp4.potenza_termica_kw, 
    sigit_t_comp4.data_ult_mod, sigit_t_comp4.utente_ult_mod, 
    sigit_t_comp_cs.num_collettori, sigit_t_comp_cs.sup_apertura
   FROM sigit_t_comp4
   JOIN sigit_t_comp_cs ON sigit_t_comp4.data_install = sigit_t_comp_cs.data_install AND sigit_t_comp4.progressivo::text = sigit_t_comp_cs.progressivo::text AND sigit_t_comp4.id_tipo_componente::text = sigit_t_comp_cs.id_tipo_componente::text AND sigit_t_comp4.codice_impianto = sigit_t_comp_cs.codice_impianto;



CREATE OR REPLACE VIEW vista_comp_ag AS 
 SELECT sigit_t_comp4.codice_impianto, sigit_t_comp4.id_tipo_componente, 
    sigit_t_comp4.progressivo, sigit_t_comp4.data_install, 
    sigit_t_comp4.data_dismiss, sigit_t_comp4.matricola, 
    sigit_t_comp4.fk_combustibile, sigit_t_comp4.fk_marca, 
    sigit_t_comp4.modello, sigit_t_comp4.potenza_termica_kw, 
    sigit_t_comp4.data_ult_mod, sigit_t_comp4.utente_ult_mod, 
    sigit_t_comp_ag.tipologia
   FROM sigit_t_comp4
   JOIN sigit_t_comp_ag ON sigit_t_comp4.data_install = sigit_t_comp_ag.data_install AND sigit_t_comp4.progressivo::text = sigit_t_comp_ag.progressivo::text AND sigit_t_comp4.id_tipo_componente::text = sigit_t_comp_ag.id_tipo_componente::text AND sigit_t_comp4.codice_impianto = sigit_t_comp_ag.codice_impianto;

