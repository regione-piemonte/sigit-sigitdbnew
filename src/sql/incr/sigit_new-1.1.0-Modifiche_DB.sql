DROP VIEW vista_bollini;
DROP VIEW vista_comp_ac;
DROP VIEW vista_comp_ag;
DROP VIEW vista_comp_cg_dett;
DROP VIEW vista_comp_ci;
DROP VIEW vista_comp_cs;
DROP VIEW vista_comp_gf_dett;
DROP VIEW vista_comp_gt_dett;
DROP VIEW vista_comp_po;
DROP VIEW vista_comp_rc;
DROP VIEW vista_comp_rv;
DROP VIEW vista_comp_sc_dett;
DROP VIEW vista_comp_scx;
DROP VIEW vista_comp_sr;
DROP VIEW vista_comp_te;
DROP VIEW vista_comp_ut;
DROP VIEW vista_comp_vm;
DROP VIEW vista_comp_vr;
DROP VIEW vista_pf_pg;
DROP VIEW vista_potenza_prezzo;
DROP VIEW vista_ricerca_allegati;
DROP VIEW vista_tot_impianto;


ALTER TABLE sigit_t_comp4 	DROP  CONSTRAINT  FK_sigit_d_combustibile_02 ;    

ALTER TABLE sigit_t_comp4 	DROP  CONSTRAINT  FK_sigit_d_marca_03 ;

ALTER TABLE sigit_t_comp4 	DROP  CONSTRAINT  FK_sigit_d_tipo_componente_02;

ALTER TABLE sigit_t_comp4 	DROP  CONSTRAINT  FK_sigit_t_impianto_03 ;    

ALTER TABLE sigit_t_comp_ag 	DROP  CONSTRAINT  FK_sigit_t_comp4_01 ;    

ALTER TABLE sigit_t_comp_br_rc 	DROP  CONSTRAINT  FK_sigit_t_comp_gt_01 ;          

ALTER TABLE sigit_t_comp_br_rc 	DROP  CONSTRAINT  FK_sigit_d_marca_01 ;          

ALTER TABLE sigit_t_comp_br_rc 	DROP  CONSTRAINT  FK_sigit_d_combustibile_01 ;        

ALTER TABLE sigit_t_comp_cg 	DROP  CONSTRAINT  FK_sigit_t_comp4_02 ;      

ALTER TABLE sigit_t_comp_cs 	DROP  CONSTRAINT  FK_sigit_t_comp4_03 ;      

ALTER TABLE sigit_t_comp_gf 	DROP  CONSTRAINT  FK_sigit_t_comp4_05 ;         

ALTER TABLE sigit_t_comp_gf 	DROP  CONSTRAINT  FK_sigit_d_dettaglio_gf_01 ;       

ALTER TABLE sigit_t_comp_gt 	DROP  CONSTRAINT  FK_sigit_t_comp4_04 ;         

ALTER TABLE sigit_t_comp_gt 	DROP  CONSTRAINT  FK_sigit_d_fluido_01 ;         

ALTER TABLE sigit_t_comp_gt 	DROP  CONSTRAINT  FK_sigit_d_dettaglio_gt_01 ;        

ALTER TABLE sigit_t_comp_sc 	DROP  CONSTRAINT  FK_sigit_t_comp4_06 ;      

ALTER TABLE sigit_t_dett_tipo1 	DROP  CONSTRAINT  FK_sigit_t_rapp_tipo1_01 ;         

ALTER TABLE sigit_t_dett_tipo1 	DROP  CONSTRAINT  FK_sigit_t_comp_gt_02 ;         

ALTER TABLE sigit_t_dett_tipo2 	DROP  CONSTRAINT  FK_sigit_t_rapp_tipo2_01 ;       

ALTER TABLE sigit_t_dett_tipo2   DROP  CONSTRAINT  FK_sigit_t_comp_gf_01 ;         

ALTER TABLE sigit_t_dett_tipo3 	DROP  CONSTRAINT  FK_sigit_t_rapp_tipo3_01 ;        

ALTER TABLE sigit_t_dett_tipo3 	DROP  CONSTRAINT  FK_sigit_t_comp_sc_01 ;         

ALTER TABLE sigit_t_dett_tipo3 	DROP  CONSTRAINT  FK_sigit_d_fluido_03 ;          

ALTER TABLE sigit_t_dett_tipo3 	DROP  CONSTRAINT  FK_sigit_d_fluido_02 ;         

ALTER TABLE sigit_t_dett_tipo4 	DROP  CONSTRAINT  FK_sigit_t_rapp_tipo4_01 ;        

ALTER TABLE sigit_t_dett_tipo4 	DROP  CONSTRAINT  FK_sigit_t_comp_cg_01 ;          

ALTER TABLE sigit_t_dett_tipo4 	DROP  CONSTRAINT  FK_sigit_d_fluido_04 ;  


ALTER TABLE sigit_t_comp_br_rc alter COLUMN progressivo_br_rc type numeric(2) using progressivo_br_rc::numeric(2);
ALTER TABLE sigit_t_comp4 alter COLUMN progressivo type numeric(2) using progressivo::numeric(2);
ALTER TABLE sigit_t_comp_gf alter COLUMN progressivo type numeric(2) using progressivo::numeric(2);
ALTER TABLE sigit_t_comp_ag alter COLUMN progressivo type numeric(2) using progressivo::numeric(2);
ALTER TABLE sigit_t_comp_cs alter COLUMN progressivo type numeric(2) using progressivo::numeric(2);
ALTER TABLE sigit_t_comp_cg alter COLUMN progressivo type numeric(2) using progressivo::numeric(2);
ALTER TABLE sigit_t_comp_sc alter COLUMN progressivo type numeric(2) using progressivo::numeric(2);
ALTER TABLE sigit_t_comp_gt alter COLUMN progressivo type numeric(2) using progressivo::numeric(2);
ALTER TABLE sigit_t_comp_br_rc alter COLUMN fk_progressivo type numeric(2) using fk_progressivo::numeric(2);

ALTER TABLE sigit_t_dett_tipo1 alter COLUMN progressivo type numeric(2) using progressivo::numeric(2);
ALTER TABLE sigit_t_dett_tipo2 alter COLUMN progressivo type numeric(2) using progressivo::numeric(2);
ALTER TABLE sigit_t_dett_tipo3 alter COLUMN progressivo type numeric(2) using progressivo::numeric(2);
ALTER TABLE sigit_t_dett_tipo4 alter COLUMN progressivo type numeric(2) using progressivo::numeric(2);

ALTER TABLE sigit_t_comp4 	ADD  CONSTRAINT  FK_sigit_d_combustibile_02 FOREIGN KEY (fk_combustibile) REFERENCES sigit_d_combustibile(id_combustibile);

ALTER TABLE sigit_t_comp4 	ADD  CONSTRAINT  FK_sigit_d_marca_03 FOREIGN KEY (fk_marca) REFERENCES sigit_d_marca(id_marca);

ALTER TABLE sigit_t_comp4 	ADD  CONSTRAINT  FK_sigit_d_tipo_componente_02 FOREIGN KEY (id_tipo_componente) REFERENCES sigit_d_tipo_componente(id_tipo_componente);

ALTER TABLE sigit_t_comp4 	ADD  CONSTRAINT  FK_sigit_t_impianto_03 FOREIGN KEY (codice_impianto) REFERENCES sigit_t_impianto(codice_impianto);

ALTER TABLE sigit_t_comp_ag 	ADD  CONSTRAINT  FK_sigit_t_comp4_01 FOREIGN KEY (codice_impianto,id_tipo_componente,progressivo,data_install) REFERENCES sigit_t_comp4(codice_impianto,id_tipo_componente,progressivo,data_install);

ALTER TABLE sigit_t_comp_br_rc 	ADD  CONSTRAINT  FK_sigit_t_comp_gt_01 FOREIGN KEY (fk_tipo_componente,fk_progressivo,fk_data_install,codice_impianto) REFERENCES sigit_t_comp_gt(id_tipo_componente,progressivo,data_install,codice_impianto);

ALTER TABLE sigit_t_comp_br_rc 	ADD  CONSTRAINT  FK_sigit_d_marca_01 FOREIGN KEY (fk_marca) REFERENCES sigit_d_marca(id_marca);

ALTER TABLE sigit_t_comp_br_rc 	ADD  CONSTRAINT  FK_sigit_d_combustibile_01 FOREIGN KEY (fk_combustibile) REFERENCES sigit_d_combustibile(id_combustibile);

ALTER TABLE sigit_t_comp_cg 	ADD  CONSTRAINT  FK_sigit_t_comp4_02 FOREIGN KEY (codice_impianto,id_tipo_componente,progressivo,data_install) REFERENCES sigit_t_comp4(codice_impianto,id_tipo_componente,progressivo,data_install);

ALTER TABLE sigit_t_comp_cs 	ADD  CONSTRAINT  FK_sigit_t_comp4_03 FOREIGN KEY (codice_impianto,id_tipo_componente,progressivo,data_install) REFERENCES sigit_t_comp4(codice_impianto,id_tipo_componente,progressivo,data_install);

ALTER TABLE sigit_t_comp_gf 	ADD  CONSTRAINT  FK_sigit_t_comp4_05 FOREIGN KEY (codice_impianto,id_tipo_componente,progressivo,data_install) REFERENCES sigit_t_comp4(codice_impianto,id_tipo_componente,progressivo,data_install);

ALTER TABLE sigit_t_comp_gf 	ADD  CONSTRAINT  FK_sigit_d_dettaglio_gf_01 FOREIGN KEY (fk_dettaglio_gf) REFERENCES sigit_d_dettaglio_gf(id_dettaglio_gf);

ALTER TABLE sigit_t_comp_gt 	ADD  CONSTRAINT  FK_sigit_t_comp4_04 FOREIGN KEY (codice_impianto,id_tipo_componente,progressivo,data_install) REFERENCES sigit_t_comp4(codice_impianto,id_tipo_componente,progressivo,data_install);

ALTER TABLE sigit_t_comp_gt 	ADD  CONSTRAINT  FK_sigit_d_fluido_01 FOREIGN KEY (fk_fluido) REFERENCES sigit_d_fluido(id_fluido);

ALTER TABLE sigit_t_comp_gt 	ADD  CONSTRAINT  FK_sigit_d_dettaglio_gt_01 FOREIGN KEY (fk_dettaglio_gt) REFERENCES sigit_d_dettaglio_gt(id_dettaglio_gt);

ALTER TABLE sigit_t_comp_sc 	ADD  CONSTRAINT  FK_sigit_t_comp4_06 FOREIGN KEY (codice_impianto,id_tipo_componente,progressivo,data_install) REFERENCES sigit_t_comp4(codice_impianto,id_tipo_componente,progressivo,data_install);

ALTER TABLE sigit_t_dett_tipo1 	ADD  CONSTRAINT  FK_sigit_t_rapp_tipo1_01 FOREIGN KEY (fk_allegato) REFERENCES sigit_t_rapp_tipo1(id_allegato);

ALTER TABLE sigit_t_dett_tipo1 	ADD  CONSTRAINT  FK_sigit_t_comp_gt_02 FOREIGN KEY (fk_tipo_componente,progressivo,data_install,codice_impianto) REFERENCES sigit_t_comp_gt(id_tipo_componente,progressivo,data_install,codice_impianto);

ALTER TABLE sigit_t_dett_tipo2 	ADD  CONSTRAINT  FK_sigit_t_rapp_tipo2_01 FOREIGN KEY (fk_allegato) REFERENCES sigit_t_rapp_tipo2(id_allegato);

ALTER TABLE sigit_t_dett_tipo2  ADD  CONSTRAINT  FK_sigit_t_comp_gf_01 FOREIGN KEY (fk_tipo_componente,progressivo,data_install,codice_impianto) REFERENCES sigit_t_comp_gf(id_tipo_componente,progressivo,data_install,codice_impianto);

ALTER TABLE sigit_t_dett_tipo3 	ADD  CONSTRAINT  FK_sigit_t_rapp_tipo3_01 FOREIGN KEY (fk_allegato) REFERENCES sigit_t_rapp_tipo3(id_allegato);

ALTER TABLE sigit_t_dett_tipo3 	ADD  CONSTRAINT  FK_sigit_t_comp_sc_01 FOREIGN KEY (fk_tipo_componente,progressivo,data_install,codice_impianto) REFERENCES sigit_t_comp_sc(id_tipo_componente,progressivo,data_install,codice_impianto);

ALTER TABLE sigit_t_dett_tipo3 	ADD  CONSTRAINT  FK_sigit_d_fluido_03 FOREIGN KEY (fk_fluido_alimentaz) REFERENCES sigit_d_fluido(id_fluido);

ALTER TABLE sigit_t_dett_tipo3 	ADD  CONSTRAINT  FK_sigit_d_fluido_02 FOREIGN KEY (fk_fluido) REFERENCES sigit_d_fluido(id_fluido);

ALTER TABLE sigit_t_dett_tipo4 	ADD  CONSTRAINT  FK_sigit_t_rapp_tipo4_01 FOREIGN KEY (fk_allegato) REFERENCES sigit_t_rapp_tipo4(id_allegato);

ALTER TABLE sigit_t_dett_tipo4 	ADD  CONSTRAINT  FK_sigit_t_comp_cg_01 FOREIGN KEY (fk_tipo_componente,progressivo,data_install,codice_impianto) REFERENCES sigit_t_comp_cg(id_tipo_componente,progressivo,data_install,codice_impianto);

ALTER TABLE sigit_t_dett_tipo4 	ADD  CONSTRAINT  FK_sigit_d_fluido_04 FOREIGN KEY (fk_fluido) REFERENCES sigit_d_fluido(id_fluido);









ALTER TABLE sigit_t_all_respinto DROP CONSTRAINT pk_sigit_t_all_respinto;

ALTER TABLE sigit_t_all_respinto ADD CONSTRAINT pk_sigit_t_all_respinto PRIMARY KEY(data_controllo, id_imp_ruolo_pfpg,id_allegato);


alter table sigit_d_tipo_documento add flg_ricerca_all NUMERIC(1) CONSTRAINT  dom_0_1_all CHECK (flg_ricerca_all IN (0,1));

ALTER TABLE sigit_t_all_respinto ALTER COLUMN sigla_bollino DROP NOT NULL;

ALTER TABLE sigit_t_allegato  ADD COLUMN f_firma_tecnico character varying(50);
ALTER TABLE sigit_t_allegato  ADD COLUMN f_firma_responsabile character varying(50);


ALTER TABLE sigit_t_dett_tipo2 RENAME e_t_suttisc_c  TO e_t_surrisc_c;

ALTER TABLE sigit_t_unita_immobiliare  ALTER COLUMN indirizzo_non_trovato TYPE character varying(300);
ALTER TABLE sigit_t_unita_immobiliare ADD COLUMN flg_nopdr NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_pdr CHECK (flg_nopdr IN (0,1));

ALTER TABLE sigit_t_impianto ADD COLUMN proprietario character varying(100);

ALTER TABLE sigit_t_all_respinto ADD COLUMN id_allegato numeric not null;

ALTER TABLE sigit_t_all_respinto  ADD COLUMN uid_index character varying(50);

CREATE TABLE sigit_t_storico_variaz_stato
(
	codice_impianto       NUMERIC  NOT NULL ,
	data_variazione       TIMESTAMP  NOT NULL ,
	old_data_dismissione  DATE  NULL ,
	old_motivazione       CHARACTER VARYING(500)  NULL ,
	stato_da              NUMERIC  NULL ,
	stato_a               NUMERIC  NULL 
);


ALTER TABLE sigit_t_allegato ADD COLUMN flg_controllo_bozza numeric(1,0) CONSTRAINT  dom_0_1_cball CHECK (flg_controllo_bozza IN (0,1));


ALTER TABLE sigit_t_storico_variaz_stato
	ADD CONSTRAINT  PK_sigit_t_storico_variaz_stat PRIMARY KEY (codice_impianto,data_variazione);
	
	
	
ALTER TABLE sigit_t_storico_variaz_stato
	ADD CONSTRAINT  FK_sigit_t_impianto_10 FOREIGN KEY (codice_impianto) REFERENCES sigit_t_impianto(codice_impianto);



ALTER TABLE sigit_t_storico_variaz_stato
	ADD CONSTRAINT  fk_sigit_d_statoimp_01 FOREIGN KEY (stato_da) REFERENCES sigit_d_stato_imp(id_stato);



ALTER TABLE sigit_t_storico_variaz_stato
	ADD CONSTRAINT  fk_sigit_d_statoimp_02 FOREIGN KEY (stato_a) REFERENCES sigit_d_stato_imp(id_stato);	
	
	
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

ALTER TABLE sigit_t_terzo_responsabile ADD COLUMN flg_tacito_rinnovo NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_tr CHECK (flg_tacito_rinnovo IN (0,1));

ALTER TABLE sigit_t_terzo_responsabile ADD COLUMN data_revoca date;





ALTER TABLE sigit_t_libretto ADD COLUMN l11_1_flg_norma_uni_10389_1 NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_aa CHECK (l11_1_flg_norma_uni_10389_1 IN (0,1));

ALTER TABLE sigit_t_libretto ADD COLUMN l11_1_altra_norma character varying(100);


ALTER TABLE sigit_t_all_respinto  ALTER COLUMN id_allegato SET NOT NULL;


ALTER TABLE sigit_t_dett_tipo1 ADD COLUMN l11_1_portata_combustibile NUMERIC;

ALTER TABLE sigit_t_dett_tipo1 ADD COLUMN l11_1_co_no_aria_ppm NUMERIC;

ALTER TABLE sigit_t_dett_tipo1 ADD COLUMN l11_1_flg_rispetta_bacharach NUMERIC(1)   CONSTRAINT  dom_0_1_aa  CHECK (l11_1_flg_rispetta_bacharach IN (0,1));

ALTER TABLE sigit_t_dett_tipo1 ADD COLUMN l11_1_flg_co_min_1000 NUMERIC(1)   CONSTRAINT  dom_0_1_ac  CHECK (l11_1_flg_co_min_1000 IN (0,1));

ALTER TABLE sigit_t_dett_tipo1 ADD COLUMN l11_1_flg_rend_mag_rend_min NUMERIC(1)   CONSTRAINT  dom_0_1_ad  CHECK (l11_1_flg_rend_mag_rend_min IN (0,1));

ALTER TABLE sigit_t_dett_tipo1   DROP COLUMN e_bacharach;
ALTER TABLE sigit_t_dett_tipo1 ADD COLUMN e_bacharach_min character varying(50);
ALTER TABLE sigit_t_dett_tipo1 ADD COLUMN e_bacharach_med character varying(50);
ALTER TABLE sigit_t_dett_tipo1 ADD COLUMN e_bacharach_max character varying(50);


ALTER TABLE sigit_t_dett_tipo2 ADD COLUMN l11_2_torre_t_out_fluido NUMERIC;

ALTER TABLE sigit_t_dett_tipo2 ADD COLUMN l11_2_torre_t_bulbo_umido NUMERIC;

ALTER TABLE sigit_t_dett_tipo2 ADD COLUMN l11_2_scambiatore_t_in_ext NUMERIC;

ALTER TABLE sigit_t_dett_tipo2 ADD COLUMN l11_2_scambiatore_t_out_ext NUMERIC;

ALTER TABLE sigit_t_dett_tipo2 ADD COLUMN l11_2_scambiat_t_in_macchina NUMERIC;

ALTER TABLE sigit_t_dett_tipo2 ADD COLUMN l11_2_scambiat_t_out_macchina NUMERIC;

ALTER TABLE sigit_t_dett_tipo2 ADD COLUMN l11_2_potenza_assorbita_kw NUMERIC;

ALTER TABLE sigit_t_dett_tipo2 ADD COLUMN l11_2_flg_pulizia_filtri NUMERIC(1)   CONSTRAINT  dom_0_1_ae  CHECK (l11_2_flg_pulizia_filtri IN (0,1));

ALTER TABLE sigit_t_dett_tipo2 ADD COLUMN l11_2_flg_verifica_superata NUMERIC(1)   CONSTRAINT  dom_0_1_af  CHECK (l11_2_flg_verifica_superata IN (0,1));

ALTER TABLE sigit_t_dett_tipo2 ADD COLUMN l11_2_data_ripristino date;



ALTER TABLE sigit_t_dett_tipo4 ADD COLUMN l11_4_sovrafreq_soglia_hz_min NUMERIC;

ALTER TABLE sigit_t_dett_tipo4 ADD COLUMN l11_4_sovrafreq_soglia_hz_med NUMERIC;

ALTER TABLE sigit_t_dett_tipo4 ADD COLUMN l11_4_sovrafreq_soglia_hz_max NUMERIC;

ALTER TABLE sigit_t_dett_tipo4 ADD COLUMN l11_4_sovrafreq_tempo_s_min NUMERIC;

ALTER TABLE sigit_t_dett_tipo4 ADD COLUMN l11_4_sovrafreq_tempo_s_med NUMERIC;

ALTER TABLE sigit_t_dett_tipo4 ADD COLUMN l11_4_sovrafreq_tempo_s_max NUMERIC;

ALTER TABLE sigit_t_dett_tipo4 ADD COLUMN l11_4_sottofreq_soglia_hz_min NUMERIC;

ALTER TABLE sigit_t_dett_tipo4 ADD COLUMN l11_4_sottofreq_soglia_hz_med NUMERIC;

ALTER TABLE sigit_t_dett_tipo4 ADD COLUMN l11_4_sottofreq_soglia_hz_max NUMERIC;

ALTER TABLE sigit_t_dett_tipo4 ADD COLUMN l11_4_sottofreq_tempo_s_min NUMERIC;

ALTER TABLE sigit_t_dett_tipo4 ADD COLUMN l11_4_sottofreq_tempo_s_med NUMERIC;

ALTER TABLE sigit_t_dett_tipo4 ADD COLUMN l11_4_sottofreq_tempo_s_max NUMERIC;

ALTER TABLE sigit_t_dett_tipo4 ADD COLUMN l11_4_sovratens_soglia_v_min NUMERIC;

ALTER TABLE sigit_t_dett_tipo4 ADD COLUMN l11_4_sovratens_soglia_v_med NUMERIC;

ALTER TABLE sigit_t_dett_tipo4 ADD COLUMN l11_4_sovratens_soglia_v_max NUMERIC;

ALTER TABLE sigit_t_dett_tipo4 ADD COLUMN l11_4_sovratens_tempo_s_min NUMERIC;

ALTER TABLE sigit_t_dett_tipo4 ADD COLUMN l11_4_sovratens_tempo_s_med NUMERIC;

ALTER TABLE sigit_t_dett_tipo4 ADD COLUMN l11_4_sovratens_tempo_s_max NUMERIC;

ALTER TABLE sigit_t_dett_tipo4 ADD COLUMN l11_4_sottotens_soglia_v_min NUMERIC;

ALTER TABLE sigit_t_dett_tipo4 ADD COLUMN l11_4_sottotens_soglia_v_med NUMERIC;

ALTER TABLE sigit_t_dett_tipo4 ADD COLUMN l11_4_sottotens_soglia_v_max NUMERIC;

ALTER TABLE sigit_t_dett_tipo4 ADD COLUMN l11_4_sottotens_tempo_s_min NUMERIC;

ALTER TABLE sigit_t_dett_tipo4 ADD COLUMN l11_4_sottotens_tempo_s_med NUMERIC;

ALTER TABLE sigit_t_dett_tipo4 ADD COLUMN l11_4_sottotens_tempo_s_max NUMERIC;




-- creazione nuove tavole 

CREATE TABLE sigit_d_dettaglio_vm
(
	id_dettaglio_vm       NUMERIC(3)  NOT NULL ,
	des_dettaglio_vm      CHARACTER VARYING(200)  NULL 
);

ALTER TABLE sigit_d_dettaglio_vm
	ADD CONSTRAINT  PK_sigit_d_dettaglio_vm PRIMARY KEY (id_dettaglio_vm);


CREATE TABLE sigit_d_tipo_consumo
(
	id_tipo_consumo       CHARACTER VARYING(10)  NOT NULL ,
	des_tipo_consumo      CHARACTER VARYING(100)  NULL 
);

ALTER TABLE sigit_d_tipo_consumo
	ADD CONSTRAINT  PK_sigit_d_tipo_consumo PRIMARY KEY (id_tipo_consumo);


CREATE TABLE sigit_d_unita_misura
(
	id_unita_misura       CHARACTER VARYING(10)  NOT NULL ,
	des_unita_misura      CHARACTER VARYING(100)  NULL 
);

ALTER TABLE sigit_d_unita_misura
	ADD CONSTRAINT  PK_sigit_d_unita_misura PRIMARY KEY (id_unita_misura);


CREATE TABLE sigit_t_comp_ac
(
	codice_impianto       NUMERIC  NOT NULL ,
	id_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	progressivo           NUMERIC(2)  NOT NULL ,
	data_install          DATE  NOT NULL ,
	capacita              NUMERIC  NULL ,
	flg_acs               NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_ac1 CHECK (flg_acs IN (0,1)),
	flg_risc              NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_ac2 CHECK (flg_risc IN (0,1)),
	flg_raff              NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_c3 CHECK (flg_raff IN (0,1)),
	flg_coib              CHARACTER VARYING(1)  NULL  CONSTRAINT  dom_a_p_coib CHECK (flg_coib IN ('A','P'))
);

ALTER TABLE sigit_t_comp_ac
	ADD CONSTRAINT  PK_sigit_t_comp_ac PRIMARY KEY (codice_impianto,id_tipo_componente,progressivo,data_install);


CREATE TABLE sigit_t_comp_ci
(
	codice_impianto       NUMERIC  NOT NULL ,
	id_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	progressivo           NUMERIC(2)  NOT NULL ,
	data_install          DATE  NOT NULL ,
	lunghezza_circ_m      NUMERIC  NULL ,
	superf_scamb_m2       NUMERIC  NULL ,
	prof_install_m        NUMERIC  NULL 
);

ALTER TABLE sigit_t_comp_ci
	ADD CONSTRAINT  PK_sigit_t_comp_ci PRIMARY KEY (codice_impianto,id_tipo_componente,progressivo,data_install);


CREATE TABLE sigit_t_comp_po
(
	codice_impianto       NUMERIC  NOT NULL ,
	id_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	progressivo           NUMERIC(2)  NOT NULL ,
	data_install          DATE  NOT NULL ,
	flg_giri_variabili    NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_giri CHECK (flg_giri_variabili IN (0,1)),
	pot_nominale_kw       NUMERIC  NULL 
);

ALTER TABLE sigit_t_comp_po
	ADD CONSTRAINT  PK_sigit_t_comp_po PRIMARY KEY (codice_impianto,id_tipo_componente,progressivo,data_install);


CREATE TABLE sigit_t_comp_rc
(
	codice_impianto       NUMERIC  NOT NULL ,
	id_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	progressivo           NUMERIC(2)  NOT NULL ,
	data_install          DATE  NOT NULL ,
	tipologia             CHARACTER VARYING(100)  NULL ,
	flg_installato        NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_uta CHECK (flg_installato IN (0,1)),
	flg_indipendente      NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_ind CHECK (flg_indipendente IN (0,1)),
	portata_mandata_ls    NUMERIC  NULL ,
	portata_ripresa_ls    NUMERIC  NULL ,
	potenza_mandata_kw    NUMERIC  NULL ,
	potenza_ripresa_kw    NUMERIC  NULL 
);

ALTER TABLE sigit_t_comp_rc
	ADD CONSTRAINT  PK_sigit_t_comp_rc PRIMARY KEY (codice_impianto,id_tipo_componente,progressivo,data_install);


CREATE TABLE sigit_t_comp_rv
(
	codice_impianto       NUMERIC  NOT NULL ,
	id_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	progressivo           NUMERIC(2)  NOT NULL ,
	data_install          DATE  NOT NULL ,
	num_ventilatori       NUMERIC(3)  NULL ,
	tipo_ventilatori      CHARACTER VARYING(100)  NULL 
);

ALTER TABLE sigit_t_comp_rv
	ADD CONSTRAINT  PK_sigit_t_comp_rv PRIMARY KEY (codice_impianto,id_tipo_componente,progressivo,data_install);


CREATE TABLE sigit_t_comp_scx
(
	codice_impianto       NUMERIC  NOT NULL ,
	id_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	progressivo           NUMERIC(2)  NOT NULL ,
	data_install          DATE  NOT NULL 
);

ALTER TABLE sigit_t_comp_scx
	ADD CONSTRAINT  PK_sigit_t_comp_scx PRIMARY KEY (codice_impianto,id_tipo_componente,progressivo,data_install);


CREATE TABLE sigit_t_comp_sr
(
	codice_impianto       NUMERIC  NOT NULL ,
	id_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	progressivo           NUMERIC(2)  NOT NULL ,
	data_install          DATE  NOT NULL ,
	num_pti_regolazione   NUMERIC(3)  NULL ,
	num_liv_temp          NUMERIC(3)  NULL 
);

ALTER TABLE sigit_t_comp_sr
	ADD CONSTRAINT  PK_sigit_t_comp_sr PRIMARY KEY (codice_impianto,id_tipo_componente,progressivo,data_install);


CREATE TABLE sigit_t_comp_te
(
	codice_impianto       NUMERIC  NOT NULL ,
	id_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	progressivo           NUMERIC(2)  NOT NULL ,
	data_install          DATE  NOT NULL ,
	capacita_l            NUMERIC  NULL ,
	num_ventilatori       NUMERIC(3)  NULL ,
	tipo_ventilatori      CHARACTER VARYING(100)  NULL 
);

ALTER TABLE sigit_t_comp_te
	ADD CONSTRAINT  PK_sigit_t_comp_te PRIMARY KEY (codice_impianto,id_tipo_componente,progressivo,data_install);


CREATE TABLE sigit_t_comp_ut
(
	codice_impianto       NUMERIC  NOT NULL ,
	id_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	progressivo           NUMERIC(2)  NOT NULL ,
	data_install          DATE  NOT NULL ,
	portata_mandata_ls    NUMERIC  NULL ,
	portata_ripresa_ls    NUMERIC  NULL ,
	potenza_mandata_kw    NUMERIC  NULL ,
	potenza_ripresa_kw    NUMERIC  NULL 
);

ALTER TABLE sigit_t_comp_ut
	ADD CONSTRAINT  PK_sigit_t_comp_ut PRIMARY KEY (codice_impianto,id_tipo_componente,progressivo,data_install);


CREATE TABLE sigit_t_comp_vm
(
	codice_impianto       NUMERIC  NOT NULL ,
	id_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	progressivo           NUMERIC(2)  NOT NULL ,
	data_install          DATE  NOT NULL ,
	fk_dettaglio_vm       NUMERIC(3)  NULL ,
	altro_tipologia       CHARACTER VARYING(100)  NULL ,
	portata_max_aria_m3h  NUMERIC  NULL ,
	rendimento_COP        CHARACTER VARYING(100)  NULL 
);

ALTER TABLE sigit_t_comp_vm
	ADD CONSTRAINT  PK_sigit_t_comp_vm PRIMARY KEY (codice_impianto,id_tipo_componente,progressivo,data_install);


CREATE TABLE sigit_t_comp_vr
(
	codice_impianto       NUMERIC  NOT NULL ,
	id_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	progressivo           NUMERIC(2)  NOT NULL ,
	data_install          DATE  NOT NULL ,
	num_vie               NUMERIC(3)  NULL ,
	servomotore           CHARACTER VARYING(100)  NULL 
);

ALTER TABLE sigit_t_comp_vr
	ADD CONSTRAINT  PK_sigit_t_comp_vr PRIMARY KEY (codice_impianto,id_tipo_componente,progressivo,data_install);


CREATE TABLE sigit_t_comp_vx
(
	codice_impianto       NUMERIC  NOT NULL ,
	id_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	progressivo           NUMERIC(2)  NOT NULL ,
	data_install          DATE  NOT NULL ,
	capacita_l            NUMERIC  NULL ,
	flg_vaso              CHARACTER VARYING(1)  NULL  CONSTRAINT  dom_a_c CHECK (flg_vaso IN ('A','C')),
	pressione_bar         CHARACTER VARYING(100)  NULL 
);

ALTER TABLE sigit_t_comp_vx
	ADD CONSTRAINT  PK_sigit_t_comp_vx PRIMARY KEY (codice_impianto,id_tipo_componente,progressivo,data_install);


CREATE TABLE sigit_t_comp_x
(
	codice_impianto       NUMERIC  NOT NULL ,
	id_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	progressivo           NUMERIC(2)  NOT NULL ,
	data_install          DATE  NOT NULL ,
	data_dismiss          DATE  NULL ,
	matricola             CHARACTER VARYING(30)  NULL ,
	fk_marca              NUMERIC  NULL ,
	modello               CHARACTER VARYING(300)  NULL,
	data_ult_mod timestamp without time zone,
  utente_ult_mod character varying(16) 
);

ALTER TABLE sigit_t_comp_x
	ADD CONSTRAINT  PK_sigit_t_comp_x PRIMARY KEY (codice_impianto,id_tipo_componente,progressivo,data_install);


CREATE TABLE sigit_t_compx_semplice
(
	codice_impianto       NUMERIC  NOT NULL ,
	l5_1_flg_sr_onoff     NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_sr1 CHECK (l5_1_flg_sr_onoff IN (0,1)),
	l5_1_flg_sr_generatore  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_sr2 CHECK (l5_1_flg_sr_generatore IN (0,1)),
	l5_1_flg_sr_indipendente  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_sr3 CHECK (l5_1_flg_sr_indipendente IN (0,1)),
	l5_1_flg_valvole_regolazione  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_sr4 CHECK (l5_1_flg_valvole_regolazione IN (0,1)),
	l5_1_flg_sr_multigradino  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_sr5 CHECK (l5_1_flg_sr_multigradino IN (0,1)),
	l5_1_flg_sr_inverter  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_sr6 CHECK (l5_1_flg_sr_inverter IN (0,1)),
	l5_1_flg_sr_altri     NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_sr7 CHECK (l5_1_flg_sr_altri IN (0,1)),
	l5_1_sr_descrizione   CHARACTER VARYING(1000)  NULL ,
	l5_2_flg_termo_onoff  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_t1 CHECK (l5_2_flg_termo_onoff IN (0,1)),
	l5_2_flg_termo_proporzionale  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_t2 CHECK (l5_2_flg_termo_proporzionale IN (0,1)),
	l5_2_flg_contr_entalpico  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_c1 CHECK (l5_2_flg_contr_entalpico IN (0,1)),
	l5_2_flg_contr_portata  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_c2 CHECK (l5_2_flg_contr_portata IN (0,1)),
	l5_2_flg_valvole_termo  CHARACTER VARYING(1)  NULL  CONSTRAINT  dom_a_p_vt1 CHECK (l5_2_flg_valvole_termo IN ('A','P')),
	l5_2_flg_valvole_2    CHARACTER VARYING(1)  NULL  CONSTRAINT  dom_a_p_vt2 CHECK (l5_2_flg_valvole_2 IN ('A','P')),
	l5_2_flg_valvole_3    CHARACTER VARYING(1)  NULL  CONSTRAINT  dom_a_p_vt3 CHECK (l5_2_flg_valvole_3 IN ('A','P')),
	l5_2_note             CHARACTER VARYING(1000)  NULL ,
	l5_3_flg_telelettura  CHARACTER VARYING(1)  NULL  CONSTRAINT  dom_a_p_tl1 CHECK (l5_3_flg_telelettura IN ('A','P')),
	l5_3_flg_telegestione  CHARACTER VARYING(1)  NULL  CONSTRAINT  dom_a_p_tl2 CHECK (l5_3_flg_telegestione IN ('A','P')),
	l5_3_des_sistema_installaz  CHARACTER VARYING(1000)  NULL ,
	l5_3_data_sostituz    DATE  NULL ,
	l5_3_des_sistema_sostituz  CHARACTER VARYING(1000)  NULL ,
	l5_4_flg_uic          NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_uic CHECK (l5_4_flg_uic IN (0,1)),
	l5_4_flg_risc         NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_ris CHECK (l5_4_flg_risc IN (0,1)),
	l5_4_flg_raff         NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_rf CHECK (l5_4_flg_raff IN (0,1)),
	l5_4_flg_acs          NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_acs CHECK (l5_4_flg_acs IN (0,1)),
	l5_4_flg_tipologia    CHARACTER VARYING(1)  NULL  CONSTRAINT  dom_d_i CHECK (l5_4_flg_tipologia IN ('D','I')),
	l5_4_des_sistema_installaz  CHARACTER VARYING(1000)  NULL ,
	l5_4_data_sostituz    DATE  NULL ,
	l5_4_des_sistema_sostituz  CHARACTER VARYING(1000)  NULL ,
	l6_1_flg_verticale    NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_ver CHECK (l6_1_flg_verticale IN (0,1)),
	l6_1_flg_orizzontale  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_ori CHECK (l6_1_flg_orizzontale IN (0,1)),
	l6_1_flg_can          NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_can CHECK (l6_1_flg_can IN (0,1)),
	l6_1_altro            CHARACTER VARYING(1000)  NULL ,
	l6_2_flg_coibent      CHARACTER VARYING(1)  NULL  CONSTRAINT  dom_a_p_coi CHECK (l6_2_flg_coibent IN ('A','P')),
	l6_2_note             CHARACTER VARYING(1000)  NULL ,
	l7_0_flg_radiatori    NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_rad CHECK (l7_0_flg_radiatori IN (0,1)),
	l7_0_flg_termoconvettori  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_tmc CHECK (l7_0_flg_termoconvettori IN (0,1)),
	l7_0_flg_ventilconvettori  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_vcv CHECK (l7_0_flg_ventilconvettori IN (0,1)),
	l7_0_flg_pannelli     NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_pan CHECK (l7_0_flg_pannelli IN (0,1)),
	l7_0_flg_bocchette    NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_boc CHECK (l7_0_flg_bocchette IN (0,1)),
	l7_0_flg_strisce      NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_str CHECK (l7_0_flg_strisce IN (0,1)),
	l7_0_flg_travi        NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_tra CHECK (l7_0_flg_travi IN (0,1)),
	l7_0_altro            CHARACTER VARYING(1000)  NULL 
);

ALTER TABLE sigit_t_compx_semplice
	ADD CONSTRAINT  PK_sigit_t_compx_semplice PRIMARY KEY (codice_impianto);


CREATE TABLE sigit_t_consumo
(
	id_consumo            NUMERIC  NOT NULL ,
	codice_impianto       NUMERIC  NOT NULL ,
	fk_tipo_consumo       CHARACTER VARYING(10)  NOT NULL ,
	fk_combustibile       NUMERIC  NULL ,
	fk_unita_misura       CHARACTER VARYING(10)  NULL ,
	acquisti              CHARACTER VARYING(100)  NULL ,
	lettura_iniziale      NUMERIC  NULL ,
	lettura_finale        NUMERIC  NULL ,
	consumo               NUMERIC  NULL ,
	esercizio_da          NUMERIC  NULL ,
	esercizio_a           NUMERIC  NULL 
);

ALTER TABLE sigit_t_consumo
	ADD CONSTRAINT  PK_sigit_t_consumo PRIMARY KEY (id_consumo);


CREATE TABLE sigit_t_consumo_14_4
(
	id_consumo_h2o        NUMERIC  NOT NULL ,
	codice_impianto       NUMERIC  NOT NULL ,
	esercizio             CHARACTER VARYING(100)  NULL ,
	flg_circuito_it       NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_it_crc1 CHECK (flg_circuito_it IN (0,1)),
	flg_circuito_acs      NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_crc2 CHECK (flg_circuito_acs IN (0,1)),
	flg_aca               NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_crc3 CHECK (flg_aca IN (0,1)),
	nome_prodotto         CHARACTER VARYING(100)  NULL ,
	qta_consumata         NUMERIC  NULL ,
	fk_unita_misura       CHARACTER VARYING(10)  NULL ,
	esercizio_da          NUMERIC  NULL ,
	esercizio_a           NUMERIC  NULL 
);

ALTER TABLE sigit_t_consumo_14_4
	ADD CONSTRAINT  PK_sigit_t_consumo_14_4 PRIMARY KEY (id_consumo_h2o);


ALTER TABLE sigit_t_comp_ac
	ADD  CONSTRAINT  FK_sigit_t_comp_x_01 FOREIGN KEY (codice_impianto,id_tipo_componente,progressivo,data_install) REFERENCES sigit_t_comp_x(codice_impianto,id_tipo_componente,progressivo,data_install);

ALTER TABLE sigit_t_comp_ci
	ADD  CONSTRAINT  FK_sigit_t_comp_x_02 FOREIGN KEY (codice_impianto,id_tipo_componente,progressivo,data_install) REFERENCES sigit_t_comp_x(codice_impianto,id_tipo_componente,progressivo,data_install);

ALTER TABLE sigit_t_comp_po
	ADD  CONSTRAINT  FK_sigit_t_comp_x_03 FOREIGN KEY (codice_impianto,id_tipo_componente,progressivo,data_install) REFERENCES sigit_t_comp_x(codice_impianto,id_tipo_componente,progressivo,data_install);

ALTER TABLE sigit_t_comp_rc
	ADD  CONSTRAINT  FK_sigit_t_comp_x_04 FOREIGN KEY (codice_impianto,id_tipo_componente,progressivo,data_install) REFERENCES sigit_t_comp_x(codice_impianto,id_tipo_componente,progressivo,data_install);

ALTER TABLE sigit_t_comp_rv
	ADD  CONSTRAINT  FK_sigit_t_comp_x_05 FOREIGN KEY (codice_impianto,id_tipo_componente,progressivo,data_install) REFERENCES sigit_t_comp_x(codice_impianto,id_tipo_componente,progressivo,data_install);

ALTER TABLE sigit_t_comp_scx
	ADD  CONSTRAINT  FK_sigit_t_comp_x_06 FOREIGN KEY (codice_impianto,id_tipo_componente,progressivo,data_install) REFERENCES sigit_t_comp_x(codice_impianto,id_tipo_componente,progressivo,data_install);

ALTER TABLE sigit_t_comp_sr
	ADD  CONSTRAINT  FK_sigit_t_comp_x_07 FOREIGN KEY (codice_impianto,id_tipo_componente,progressivo,data_install) REFERENCES sigit_t_comp_x(codice_impianto,id_tipo_componente,progressivo,data_install);

ALTER TABLE sigit_t_comp_te
	ADD  CONSTRAINT  FK_sigit_t_comp_x_08 FOREIGN KEY (codice_impianto,id_tipo_componente,progressivo,data_install) REFERENCES sigit_t_comp_x(codice_impianto,id_tipo_componente,progressivo,data_install);

ALTER TABLE sigit_t_comp_ut
	ADD  CONSTRAINT  FK_sigit_t_comp_x_09 FOREIGN KEY (codice_impianto,id_tipo_componente,progressivo,data_install) REFERENCES sigit_t_comp_x(codice_impianto,id_tipo_componente,progressivo,data_install);

ALTER TABLE sigit_t_comp_vm
	ADD  CONSTRAINT  FK_sigit_t_comp_x_10 FOREIGN KEY (codice_impianto,id_tipo_componente,progressivo,data_install) REFERENCES sigit_t_comp_x(codice_impianto,id_tipo_componente,progressivo,data_install);

ALTER TABLE sigit_t_comp_vm
	ADD  CONSTRAINT  FK_sigit_d_dettaglio_vm_01 FOREIGN KEY (fk_dettaglio_vm) REFERENCES sigit_d_dettaglio_vm(id_dettaglio_vm);

ALTER TABLE sigit_t_comp_vr
	ADD  CONSTRAINT  FK_sigit_t_comp_x_11 FOREIGN KEY (codice_impianto,id_tipo_componente,progressivo,data_install) REFERENCES sigit_t_comp_x(codice_impianto,id_tipo_componente,progressivo,data_install);

ALTER TABLE sigit_t_comp_vx
	ADD  CONSTRAINT  FK_sigit_t_comp_x_12 FOREIGN KEY (codice_impianto,id_tipo_componente,progressivo,data_install) REFERENCES sigit_t_comp_x(codice_impianto,id_tipo_componente,progressivo,data_install);

ALTER TABLE sigit_t_comp_x
	ADD  CONSTRAINT  FK_sigit_t_impianto_02 FOREIGN KEY (codice_impianto) REFERENCES sigit_t_impianto(codice_impianto);

ALTER TABLE sigit_t_comp_x
	ADD  CONSTRAINT  FK_sigit_d_tipo_componente_01 FOREIGN KEY (id_tipo_componente) REFERENCES sigit_d_tipo_componente(id_tipo_componente);

ALTER TABLE sigit_t_comp_x
	ADD  CONSTRAINT  FK_sigit_d_marca_02 FOREIGN KEY (fk_marca) REFERENCES sigit_d_marca(id_marca);

ALTER TABLE sigit_t_compx_semplice
	ADD  CONSTRAINT  FK_sigit_t_impianto_04 FOREIGN KEY (codice_impianto) REFERENCES sigit_t_impianto(codice_impianto);

ALTER TABLE sigit_t_consumo
	ADD  CONSTRAINT  FK_sigit_t_impianto_05 FOREIGN KEY (codice_impianto) REFERENCES sigit_t_impianto(codice_impianto);

ALTER TABLE sigit_t_consumo
	ADD  CONSTRAINT  FK_sigit_d_combustibile_03 FOREIGN KEY (fk_combustibile) REFERENCES sigit_d_combustibile(id_combustibile);

ALTER TABLE sigit_t_consumo
	ADD  CONSTRAINT  FK_sigit_d_unita_misura_01 FOREIGN KEY (fk_unita_misura) REFERENCES sigit_d_unita_misura(id_unita_misura);

ALTER TABLE sigit_t_consumo
	ADD  CONSTRAINT  FK_sigit_d_tipo_consumo_01 FOREIGN KEY (fk_tipo_consumo) REFERENCES sigit_d_tipo_consumo(id_tipo_consumo);

ALTER TABLE sigit_t_consumo_14_4
	ADD  CONSTRAINT  FK_sigit_t_impianto_06 FOREIGN KEY (codice_impianto) REFERENCES sigit_t_impianto(codice_impianto);

ALTER TABLE sigit_t_consumo_14_4
	ADD  CONSTRAINT  FK_sigit_d_unita_misura_02 FOREIGN KEY (fk_unita_misura) REFERENCES sigit_d_unita_misura(id_unita_misura);

ALTER TABLE sigit_t_impianto
	ADD  CONSTRAINT  FK_sigit_d_stato_imp_03 FOREIGN KEY (fk_stato) REFERENCES sigit_d_stato_imp(id_stato);


ALTER TABLE sigit_r_imp_ruolo_pfpg drop CONSTRAINT  AK1_sigit_r_imp_ruolo_pfpg;


alter table sigit_t_comp4 add flg_dismissione NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_dismiss CHECK (flg_dismissione IN (0,1));

alter table sigit_t_comp_br_rc add flg_dismissione NUMERIC(1) NULL  CONSTRAINT  dom_0_1_dis2 CHECK (flg_dismissione IN (0,1));


alter table SIGIT_t_RAPP_TIPO1 add c_flg_tratt_clima_non_rich NUMERIC(1) CONSTRAINT dom_0_1_tclima_01 CHECK (c_flg_tratt_clima_non_rich IN (0,1));
alter table SIGIT_t_RAPP_TIPO1 add c_flg_tratt_acs_non_richiesto NUMERIC(1) CONSTRAINT  dom_0_1_acs01 CHECK (c_flg_tratt_acs_non_richiesto IN (0,1));

alter table SIGIT_t_RAPP_TIPO2 add c_flg_tratt_clima_non_richiest NUMERIC(1) CONSTRAINT dom_0_1_clima01 CHECK (c_flg_tratt_clima_non_richiest IN (0,1));

alter table SIGIT_t_RAPP_TIPO3 add c_flg_tratt_clima_non_richiest  NUMERIC(1) CONSTRAINT dom_0_1_clima02 CHECK (c_flg_tratt_clima_non_richiest IN (0,1));
alter table SIGIT_t_RAPP_TIPO3 add c_flg_tratt_acs_non_richiesto  NUMERIC(1) CONSTRAINT  dom_0_1_acs05 CHECK (c_flg_tratt_acs_non_richiesto IN (0,1));

alter table SIGIT_t_RAPP_TIPO4 add c_flg_tratt_clima_non_richiest NUMERIC(1) CONSTRAINT  dom_0_1_clima06 CHECK (c_flg_tratt_clima_non_richiest IN (0,1));

alter table SIGIT_t_RAPP_TIPO2 add d_flg_coib_idonea NUMERIC(1) CONSTRAINT  dom_0_1_2_coib CHECK (d_flg_coib_idonea IN (0,1,2));


alter table sigit_t_dett_tipo1 add l11_1_portata_combustibile_um  CHARACTER VARYING(6);
alter table sigit_t_dett_tipo1 add l11_1_altro_riferimento  CHARACTER VARYING(100); 

alter table sigit_t_allegato add a_potenza_termica_nominale_max  NUMERIC;

alter table sigit_t_comp4 ALTER COLUMN matricola TYPE character varying(30);
alter table sigit_t_comp4 ALTER COLUMN modello TYPE character varying(300);





CREATE TABLE sigit_t_rapp_controllo
(
	id_rapporto_controllo  NUMERIC  NOT NULL ,
	fk_allegato           NUMERIC  NOT NULL ,
	note_ufficio          CHARACTER VARYING(500)  NULL ,
	flg_locale_ok         NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_loc CHECK (flg_locale_ok IN (0,1)),
	flg_aerazione_ok      NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_aer CHECK (flg_aerazione_ok IN (0,1)),
	flg_aerazione_libera  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_lib CHECK (flg_aerazione_libera IN (0,1)),
	flg_assenza_fughe_gas  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_gas CHECK (flg_assenza_fughe_gas IN (0,1)),
	flg_evacuazione_fumi  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_fumi CHECK (flg_evacuazione_fumi IN (0,1)),
	flg_rapporto_controllo  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_rapp CHECK (flg_rapporto_controllo IN (0,1)),
	flg_certificazione    NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_cert CHECK (flg_certificazione IN (0,1)),
	flg_pratica_ispesl    NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_isp CHECK (flg_pratica_ispesl IN (0,1)),
	flg_cert_prev_incendi  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_prev CHECK (flg_cert_prev_incendi IN (0,1)),
	flg_centraletermica   NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_ev CHECK (flg_centraletermica IN (0,1))
);



ALTER TABLE sigit_t_rapp_controllo
	ADD CONSTRAINT  PK_SIGIT_T_RAPP_CONTROLLO PRIMARY KEY (ID_RAPPORTO_CONTROLLO);



CREATE TABLE sigit_t_rapp_dettaglio
(
	id_rapporto_dettaglio  NUMERIC   DEFAULT  0 NOT NULL ,
	fk_rapporto_controllo  NUMERIC  NOT NULL ,
	flg_pendenze          NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_pend CHECK (flg_pendenze IN (0,1)),
	flg_sezioni           NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_sez CHECK (flg_sezioni IN (0,1)),
	flg_curve             NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_curve CHECK (flg_curve IN (0,1)),
	flg_lunghezza         NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_lun CHECK (flg_lunghezza IN (0,1)),
	flg_stato_ok          NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_stato CHECK (flg_stato_ok IN (0,1)),
	flg_singolo           NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_sing CHECK (flg_singolo IN (0,1)),
	flg_a_parete          NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_par CHECK (flg_a_parete IN (0,1)),
	flg_no_riflusso       NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_rifl CHECK (flg_no_riflusso IN (0,1)),
	flg_coibentazioni     NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_coib CHECK (flg_coibentazioni IN (0,1)),
	flg_no_perdite        NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_noperd CHECK (flg_no_perdite IN (0,1)),
	flg_cannafumaria_collettiva  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_cann CHECK (flg_cannafumaria_collettiva IN (0,1)),
	flg_ugelli_puliti     NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_uge CHECK (flg_ugelli_puliti IN (0,1)),
	flg_rompitiraggio_ok  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_romp CHECK (flg_rompitiraggio_ok IN (0,1)),
	flg_scambiatore_pulito  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_scpul CHECK (flg_scambiatore_pulito IN (0,1)),
	flg_funzionamento_ok  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_funz CHECK (flg_funzionamento_ok IN (0,1)),
	flg_dispositivi_ok    NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_disp CHECK (flg_dispositivi_ok IN (0,1)),
	flg_assenza_perdite_acqua  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_ass CHECK (flg_assenza_perdite_acqua IN (0,1)),
	flg_valvola_sicur_libera  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_valv CHECK (flg_valvola_sicur_libera IN (0,1)),
	flg_vaso_esp_carico   NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_esp CHECK (flg_vaso_esp_carico IN (0,1)),
	flg_sicurezza_ok      NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_sic CHECK (flg_sicurezza_ok IN (0,1)),
	flg_no_usure_deformazioni  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_nousu CHECK (flg_no_usure_deformazioni IN (0,1)),
	flg_circuito_aria_libero  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_circ CHECK (flg_circuito_aria_libero IN (0,1)),
	flg_accopp_gen_ok     NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_accop CHECK (flg_accopp_gen_ok IN (0,1)),
	flg_funzionamento_corretto  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_fcorr CHECK (flg_funzionamento_corretto IN (0,1)),
	temp_fumi             NUMERIC(6,2)  NULL ,
	temp_aria             NUMERIC(6,2)  NULL ,
	o2                    NUMERIC(6,2)  NULL ,
	co2                   NUMERIC(6,2)  NULL ,
	bacharach             NUMERIC(6,2)  NULL ,
	co                    NUMERIC(6,2)  NULL ,
	rend_comb             NUMERIC(6,2)  NULL ,
	flg_libretto_bruciatore  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_libbr CHECK (flg_libretto_bruciatore IN (0,1)),
	nox                   NUMERIC(6,2)  NULL ,
	flg_libretto_caldaia  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_libcald CHECK (flg_libretto_caldaia IN (0,1)),
	note_documentazione   CHARACTER VARYING(500)  NULL ,
	flg_ev_linee_elettriche  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_evlele CHECK (flg_ev_linee_elettriche IN (0,1)),
	flg_ev_bruciatore     NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_evbr CHECK (flg_ev_bruciatore IN (0,1)),
	flg_ev_generatore_calore  NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_evgen CHECK (flg_ev_generatore_calore IN (0,1)),
	flg_ev_canali_fumo    NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_evfumo CHECK (flg_ev_canali_fumo IN (0,1)),
	flg_controllo_rend    NUMERIC(1)  NULL  CONSTRAINT  dom_0_1_cont CHECK (flg_controllo_rend IN (0,1)),
	tiraggio              NUMERIC(6,2)  NULL ,
	note                  CHARACTER VARYING(500)  NULL 
);



ALTER TABLE sigit_t_rapp_dettaglio
	ADD CONSTRAINT  PK_SIGIT_T_RAPP_DETTAGLIO PRIMARY KEY (ID_RAPPORTO_DETTAGLIO);





ALTER TABLE sigit_t_rapp_controllo
	ADD CONSTRAINT  FK_sigit_t_allegato_01 FOREIGN KEY (fk_allegato) REFERENCES sigit_t_allegato(id_allegato);



ALTER TABLE sigit_t_rapp_dettaglio
	ADD CONSTRAINT  FK_sigit_t_rapp_controllo_01 FOREIGN KEY (fk_rapporto_controllo) REFERENCES sigit_t_rapp_controllo(id_rapporto_controllo);





ALTER TABLE sigit_t_rapp_controllo DROP CONSTRAINT dom_0_1_gas;
ALTER TABLE sigit_t_rapp_controllo
  ADD CONSTRAINT dom_0_1_2_gas CHECK (flg_assenza_fughe_gas = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));

ALTER TABLE sigit_t_rapp_controllo DROP CONSTRAINT dom_0_1_loc;

ALTER TABLE sigit_t_rapp_controllo
  ADD CONSTRAINT dom_0_1_2_loc CHECK (flg_locale_ok = ANY (ARRAY[0::numeric, 1::numeric,2::numeric]));

ALTER TABLE sigit_t_rapp_controllo DROP CONSTRAINT dom_0_1_lib;

ALTER TABLE sigit_t_rapp_controllo
  ADD CONSTRAINT dom_0_1_2_lib CHECK (flg_aerazione_libera = ANY (ARRAY[0::numeric, 1::numeric,2::numeric]));

ALTER TABLE sigit_t_rapp_controllo DROP CONSTRAINT dom_0_1_aer;

ALTER TABLE sigit_t_rapp_controllo
  ADD CONSTRAINT dom_0_1_2_aer CHECK (flg_aerazione_ok = ANY (ARRAY[0::numeric, 1::numeric,2::numeric]));

ALTER TABLE sigit_t_rapp_controllo DROP CONSTRAINT dom_0_1_fumi;

ALTER TABLE sigit_t_rapp_controllo
  ADD CONSTRAINT dom_0_1_2_fumi CHECK (flg_evacuazione_fumi = ANY (ARRAY[0::numeric, 1::numeric,2::numeric]));
  
  
  





ALTER TABLE sigit_t_rapp_dettaglio DROP CONSTRAINT dom_0_1_accop;

ALTER TABLE sigit_t_rapp_dettaglio
  ADD CONSTRAINT dom_0_1_2_accop CHECK (flg_accopp_gen_ok = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));

 ALTER TABLE sigit_t_rapp_dettaglio DROP CONSTRAINT dom_0_1_ass;

ALTER TABLE sigit_t_rapp_dettaglio
  ADD CONSTRAINT dom_0_1_2_ass CHECK (flg_assenza_perdite_acqua = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));


ALTER TABLE sigit_t_rapp_dettaglio DROP CONSTRAINT dom_0_1_cann;

ALTER TABLE sigit_t_rapp_dettaglio
  ADD CONSTRAINT dom_0_1_2_cann CHECK (flg_cannafumaria_collettiva = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));


ALTER TABLE sigit_t_rapp_dettaglio DROP CONSTRAINT dom_0_1_circ;

ALTER TABLE sigit_t_rapp_dettaglio
  ADD CONSTRAINT dom_0_1_2_circ CHECK (flg_circuito_aria_libero = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));

ALTER TABLE sigit_t_rapp_dettaglio DROP CONSTRAINT dom_0_1_coib;

ALTER TABLE sigit_t_rapp_dettaglio
  ADD CONSTRAINT dom_0_1_2_coib CHECK (flg_coibentazioni = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));

ALTER TABLE sigit_t_rapp_dettaglio DROP CONSTRAINT dom_0_1_cont;

ALTER TABLE sigit_t_rapp_dettaglio
  ADD CONSTRAINT dom_0_1_2_cont CHECK (flg_controllo_rend = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));


ALTER TABLE sigit_t_rapp_dettaglio DROP CONSTRAINT dom_0_1_curve;

ALTER TABLE sigit_t_rapp_dettaglio
  ADD CONSTRAINT dom_0_1_2_curve CHECK (flg_curve = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));


ALTER TABLE sigit_t_rapp_dettaglio DROP CONSTRAINT dom_0_1_disp;

ALTER TABLE sigit_t_rapp_dettaglio
  ADD CONSTRAINT dom_0_1_2_disp CHECK (flg_dispositivi_ok = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));


ALTER TABLE sigit_t_rapp_dettaglio DROP CONSTRAINT dom_0_1_esp;

ALTER TABLE sigit_t_rapp_dettaglio
  ADD CONSTRAINT dom_0_1_2_esp CHECK (flg_vaso_esp_carico = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));


ALTER TABLE sigit_t_rapp_dettaglio DROP CONSTRAINT dom_0_1_evbr;

ALTER TABLE sigit_t_rapp_dettaglio
  ADD CONSTRAINT dom_0_1_2_evbr CHECK (flg_ev_bruciatore = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));

ALTER TABLE sigit_t_rapp_dettaglio DROP CONSTRAINT dom_0_1_evfumo;

ALTER TABLE sigit_t_rapp_dettaglio
  ADD CONSTRAINT dom_0_1_2_evfumo CHECK (flg_ev_canali_fumo = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));

ALTER TABLE sigit_t_rapp_dettaglio DROP CONSTRAINT dom_0_1_evgen;

ALTER TABLE sigit_t_rapp_dettaglio
  ADD CONSTRAINT dom_0_1_2_evgen CHECK (flg_ev_generatore_calore = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));

ALTER TABLE sigit_t_rapp_dettaglio DROP CONSTRAINT dom_0_1_evlele;

ALTER TABLE sigit_t_rapp_dettaglio
  ADD CONSTRAINT dom_0_1_2_evlele CHECK (flg_ev_linee_elettriche = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));


ALTER TABLE sigit_t_rapp_dettaglio DROP CONSTRAINT dom_0_1_fcorr;

ALTER TABLE sigit_t_rapp_dettaglio
  ADD CONSTRAINT dom_0_1_2_fcorr CHECK (flg_funzionamento_corretto = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));


ALTER TABLE sigit_t_rapp_dettaglio DROP CONSTRAINT dom_0_1_funz;

ALTER TABLE sigit_t_rapp_dettaglio
  ADD CONSTRAINT dom_0_1_2_funz CHECK (flg_funzionamento_ok = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));

ALTER TABLE sigit_t_rapp_dettaglio DROP CONSTRAINT dom_0_1_libbr;

ALTER TABLE sigit_t_rapp_dettaglio
  ADD CONSTRAINT dom_0_1_2_libbr CHECK (flg_libretto_bruciatore = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));


ALTER TABLE sigit_t_rapp_dettaglio DROP CONSTRAINT dom_0_1_libcald;

ALTER TABLE sigit_t_rapp_dettaglio
  ADD CONSTRAINT dom_0_1_2_libcald CHECK (flg_libretto_caldaia = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));


ALTER TABLE sigit_t_rapp_dettaglio DROP CONSTRAINT dom_0_1_lun;

ALTER TABLE sigit_t_rapp_dettaglio
  ADD CONSTRAINT dom_0_1_2_lun CHECK (flg_lunghezza = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));


ALTER TABLE sigit_t_rapp_dettaglio DROP CONSTRAINT dom_0_1_noperd;

ALTER TABLE sigit_t_rapp_dettaglio
  ADD CONSTRAINT dom_0_1_2_noperd CHECK (flg_no_perdite = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));  
  
ALTER TABLE sigit_t_rapp_dettaglio DROP CONSTRAINT dom_0_1_nousu;

ALTER TABLE sigit_t_rapp_dettaglio
  ADD CONSTRAINT dom_0_1_2_nousu CHECK (flg_no_usure_deformazioni = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));

ALTER TABLE sigit_t_rapp_dettaglio DROP CONSTRAINT dom_0_1_par;

ALTER TABLE sigit_t_rapp_dettaglio
  ADD CONSTRAINT dom_0_1_2_par CHECK (flg_a_parete = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));

ALTER TABLE sigit_t_rapp_dettaglio DROP CONSTRAINT dom_0_1_pend;

ALTER TABLE sigit_t_rapp_dettaglio
  ADD CONSTRAINT dom_0_1_2_pend CHECK (flg_pendenze = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));

ALTER TABLE sigit_t_rapp_dettaglio DROP CONSTRAINT dom_0_1_rifl;

ALTER TABLE sigit_t_rapp_dettaglio
  ADD CONSTRAINT dom_0_1_2_rifl CHECK (flg_no_riflusso = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));

ALTER TABLE sigit_t_rapp_dettaglio DROP CONSTRAINT dom_0_1_romp;

ALTER TABLE sigit_t_rapp_dettaglio
  ADD CONSTRAINT dom_0_1_2_romp CHECK (flg_rompitiraggio_ok = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));

ALTER TABLE sigit_t_rapp_dettaglio DROP CONSTRAINT dom_0_1_scpul;

ALTER TABLE sigit_t_rapp_dettaglio
  ADD CONSTRAINT dom_0_1_2_scpul CHECK (flg_scambiatore_pulito = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));

ALTER TABLE sigit_t_rapp_dettaglio DROP CONSTRAINT dom_0_1_sez;

ALTER TABLE sigit_t_rapp_dettaglio
  ADD CONSTRAINT dom_0_1_2_sez CHECK (flg_sezioni = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));

ALTER TABLE sigit_t_rapp_dettaglio DROP CONSTRAINT dom_0_1_sic;

ALTER TABLE sigit_t_rapp_dettaglio
  ADD CONSTRAINT dom_0_1_2_sic CHECK (flg_sicurezza_ok = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));

ALTER TABLE sigit_t_rapp_dettaglio DROP CONSTRAINT dom_0_1_sing;

ALTER TABLE sigit_t_rapp_dettaglio
  ADD CONSTRAINT dom_0_1_2_sing CHECK (flg_singolo = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));

ALTER TABLE sigit_t_rapp_dettaglio DROP CONSTRAINT dom_0_1_stato;

ALTER TABLE sigit_t_rapp_dettaglio
  ADD CONSTRAINT dom_0_1_2_stato CHECK (flg_stato_ok = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));

ALTER TABLE sigit_t_rapp_dettaglio DROP CONSTRAINT dom_0_1_uge;

ALTER TABLE sigit_t_rapp_dettaglio
  ADD CONSTRAINT dom_0_1_2_uge CHECK (flg_ugelli_puliti = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));

ALTER TABLE sigit_t_rapp_dettaglio DROP CONSTRAINT dom_0_1_valv;

ALTER TABLE sigit_t_rapp_dettaglio
  ADD CONSTRAINT dom_0_1_2_valv CHECK (flg_valvola_sicur_libera = ANY (ARRAY[0::numeric, 1::numeric, 2::numeric]));
  
  
  
  
  
  

  
  
  

DROP VIEW vista_comp_ac;
DROP VIEW vista_comp_ci;
DROP VIEW vista_comp_po;
DROP VIEW vista_comp_rc;
DROP VIEW vista_comp_rv;
DROP VIEW vista_comp_scx;
DROP VIEW vista_comp_sr;
DROP VIEW vista_comp_te;
DROP VIEW vista_comp_ut;
DROP VIEW vista_comp_vm;
DROP VIEW vista_comp_vr;




alter table sigit_t_comp_x add column flg_dismissione NUMERIC(1) CONSTRAINT dom_0_1_dism CHECK (flg_dismissione IN (0,1));


CREATE OR REPLACE VIEW vista_comp_ac AS 
 SELECT sigit_t_comp_x.codice_impianto, sigit_t_comp_x.id_tipo_componente, 
    sigit_t_comp_x.progressivo, sigit_t_comp_x.data_install, 
    sigit_t_comp_x.data_dismiss, sigit_t_comp_x.matricola, 
    sigit_t_comp_x.fk_marca, sigit_d_marca.des_marca, sigit_t_comp_x.modello, 
    sigit_t_comp_x.flg_dismissione,
    sigit_t_comp_x.data_ult_mod, sigit_t_comp_x.utente_ult_mod, 
    sigit_t_comp_ac.flg_acs, sigit_t_comp_ac.flg_risc, sigit_t_comp_ac.flg_raff, 
    sigit_t_comp_ac.flg_coib, sigit_t_comp_ac.capacita
   FROM sigit_t_comp_x
   JOIN sigit_t_comp_ac ON sigit_t_comp_x.data_install = sigit_t_comp_ac.data_install AND sigit_t_comp_x.progressivo = sigit_t_comp_ac.progressivo AND sigit_t_comp_x.id_tipo_componente::text = sigit_t_comp_ac.id_tipo_componente::text AND sigit_t_comp_x.codice_impianto = sigit_t_comp_ac.codice_impianto
   LEFT JOIN sigit_d_marca ON sigit_t_comp_x.fk_marca = sigit_d_marca.id_marca;




CREATE OR REPLACE VIEW vista_comp_ci AS 
 SELECT sigit_t_comp_x.codice_impianto, sigit_t_comp_x.id_tipo_componente, 
    sigit_t_comp_x.progressivo, sigit_t_comp_x.data_install, 
    sigit_t_comp_x.data_dismiss, sigit_t_comp_x.matricola, 
    sigit_t_comp_x.fk_marca, sigit_d_marca.des_marca, sigit_t_comp_x.modello, 
    sigit_t_comp_x.flg_dismissione,
    sigit_t_comp_x.data_ult_mod, sigit_t_comp_x.utente_ult_mod, 
    sigit_t_comp_ci.lunghezza_circ_m, sigit_t_comp_ci.superf_scamb_m2, 
    sigit_t_comp_ci.prof_install_m
   FROM sigit_t_comp_x
   JOIN sigit_t_comp_ci ON sigit_t_comp_x.data_install = sigit_t_comp_ci.data_install AND sigit_t_comp_x.progressivo = sigit_t_comp_ci.progressivo AND sigit_t_comp_x.id_tipo_componente::text = sigit_t_comp_ci.id_tipo_componente::text AND sigit_t_comp_x.codice_impianto = sigit_t_comp_ci.codice_impianto
   LEFT JOIN sigit_d_marca ON sigit_t_comp_x.fk_marca = sigit_d_marca.id_marca;



CREATE OR REPLACE VIEW vista_comp_po AS 
 SELECT sigit_t_comp_x.codice_impianto, sigit_t_comp_x.id_tipo_componente, 
    sigit_t_comp_x.progressivo, sigit_t_comp_x.data_install, 
    sigit_t_comp_x.data_dismiss, sigit_t_comp_x.matricola, 
    sigit_t_comp_x.fk_marca, sigit_d_marca.des_marca, sigit_t_comp_x.modello, 
    sigit_t_comp_x.flg_dismissione,
    sigit_t_comp_x.data_ult_mod, sigit_t_comp_x.utente_ult_mod, 
    sigit_t_comp_po.flg_giri_variabili, sigit_t_comp_po.pot_nominale_kw
   FROM sigit_t_comp_x
   JOIN sigit_t_comp_po ON sigit_t_comp_x.data_install = sigit_t_comp_po.data_install AND sigit_t_comp_x.progressivo = sigit_t_comp_po.progressivo AND sigit_t_comp_x.id_tipo_componente::text = sigit_t_comp_po.id_tipo_componente::text AND sigit_t_comp_x.codice_impianto = sigit_t_comp_po.codice_impianto
   LEFT JOIN sigit_d_marca ON sigit_t_comp_x.fk_marca = sigit_d_marca.id_marca;



  
CREATE OR REPLACE VIEW vista_comp_rc AS 
 SELECT sigit_t_comp_x.codice_impianto, sigit_t_comp_x.id_tipo_componente, 
    sigit_t_comp_x.progressivo, sigit_t_comp_x.data_install, 
    sigit_t_comp_x.data_dismiss, sigit_t_comp_x.matricola, 
    sigit_t_comp_x.fk_marca, sigit_d_marca.des_marca, sigit_t_comp_x.modello, 
    sigit_t_comp_x.flg_dismissione,
    sigit_t_comp_x.data_ult_mod, sigit_t_comp_x.utente_ult_mod, 
    sigit_t_comp_rc.tipologia, sigit_t_comp_rc.flg_installato, 
    sigit_t_comp_rc.flg_indipendente, sigit_t_comp_rc.portata_mandata_ls, 
    sigit_t_comp_rc.portata_ripresa_ls, sigit_t_comp_rc.potenza_mandata_kw, 
    sigit_t_comp_rc.potenza_ripresa_kw
   FROM sigit_t_comp_x
   JOIN sigit_t_comp_rc ON sigit_t_comp_x.data_install = sigit_t_comp_rc.data_install AND sigit_t_comp_x.progressivo = sigit_t_comp_rc.progressivo AND sigit_t_comp_x.id_tipo_componente::text = sigit_t_comp_rc.id_tipo_componente::text AND sigit_t_comp_x.codice_impianto = sigit_t_comp_rc.codice_impianto
   LEFT JOIN sigit_d_marca ON sigit_t_comp_x.fk_marca = sigit_d_marca.id_marca;
   



CREATE OR REPLACE VIEW vista_comp_rv AS 
 SELECT sigit_t_comp_x.codice_impianto, sigit_t_comp_x.id_tipo_componente, 
    sigit_t_comp_x.progressivo, sigit_t_comp_x.data_install, 
    sigit_t_comp_x.data_dismiss, sigit_t_comp_x.matricola, 
    sigit_t_comp_x.fk_marca, sigit_d_marca.des_marca, sigit_t_comp_x.modello, 
    sigit_t_comp_x.flg_dismissione,
    sigit_t_comp_x.data_ult_mod, sigit_t_comp_x.utente_ult_mod, 
    sigit_t_comp_rv.num_ventilatori, sigit_t_comp_rv.tipo_ventilatori
   FROM sigit_t_comp_x
   JOIN sigit_t_comp_rv ON sigit_t_comp_x.data_install = sigit_t_comp_rv.data_install AND sigit_t_comp_x.progressivo = sigit_t_comp_rv.progressivo AND sigit_t_comp_x.id_tipo_componente::text = sigit_t_comp_rv.id_tipo_componente::text AND sigit_t_comp_x.codice_impianto = sigit_t_comp_rv.codice_impianto
   LEFT JOIN sigit_d_marca ON sigit_t_comp_x.fk_marca = sigit_d_marca.id_marca;




CREATE OR REPLACE VIEW vista_comp_scx AS 
 SELECT sigit_t_comp_x.codice_impianto, sigit_t_comp_x.id_tipo_componente, 
    sigit_t_comp_x.progressivo, sigit_t_comp_x.data_install, 
    sigit_t_comp_x.data_dismiss, sigit_t_comp_x.matricola, 
    sigit_t_comp_x.fk_marca, sigit_d_marca.des_marca, sigit_t_comp_x.modello, 
    sigit_t_comp_x.flg_dismissione,
    sigit_t_comp_x.data_ult_mod, sigit_t_comp_x.utente_ult_mod
   FROM sigit_t_comp_x
   JOIN sigit_t_comp_scx ON sigit_t_comp_x.data_install = sigit_t_comp_scx.data_install AND sigit_t_comp_x.progressivo = sigit_t_comp_scx.progressivo AND sigit_t_comp_x.id_tipo_componente::text = sigit_t_comp_scx.id_tipo_componente::text AND sigit_t_comp_x.codice_impianto = sigit_t_comp_scx.codice_impianto
   LEFT JOIN sigit_d_marca ON sigit_t_comp_x.fk_marca = sigit_d_marca.id_marca;




CREATE OR REPLACE VIEW vista_comp_sr AS 
 SELECT sigit_t_comp_x.codice_impianto, sigit_t_comp_x.id_tipo_componente, 
    sigit_t_comp_x.progressivo, sigit_t_comp_x.data_install, 
    sigit_t_comp_x.data_dismiss, sigit_t_comp_x.matricola, 
    sigit_t_comp_x.fk_marca, sigit_d_marca.des_marca, sigit_t_comp_x.modello, 
    sigit_t_comp_x.flg_dismissione,
    sigit_t_comp_x.data_ult_mod, sigit_t_comp_x.utente_ult_mod, 
    sigit_t_comp_sr.num_pti_regolazione, sigit_t_comp_sr.num_liv_temp
   FROM sigit_t_comp_x
   JOIN sigit_t_comp_sr ON sigit_t_comp_x.data_install = sigit_t_comp_sr.data_install AND sigit_t_comp_x.progressivo = sigit_t_comp_sr.progressivo AND sigit_t_comp_x.id_tipo_componente::text = sigit_t_comp_sr.id_tipo_componente::text AND sigit_t_comp_x.codice_impianto = sigit_t_comp_sr.codice_impianto
   LEFT JOIN sigit_d_marca ON sigit_t_comp_x.fk_marca = sigit_d_marca.id_marca;





CREATE OR REPLACE VIEW vista_comp_te AS 
 SELECT sigit_t_comp_x.codice_impianto, sigit_t_comp_x.id_tipo_componente, 
    sigit_t_comp_x.progressivo, sigit_t_comp_x.data_install, 
    sigit_t_comp_x.data_dismiss, sigit_t_comp_x.matricola, 
    sigit_t_comp_x.fk_marca, sigit_d_marca.des_marca, sigit_t_comp_x.modello, 
    sigit_t_comp_x.flg_dismissione,
    sigit_t_comp_x.data_ult_mod, sigit_t_comp_x.utente_ult_mod, 
    sigit_t_comp_te.capacita_l, sigit_t_comp_te.num_ventilatori, 
    sigit_t_comp_te.tipo_ventilatori
   FROM sigit_t_comp_x
   JOIN sigit_t_comp_te ON sigit_t_comp_x.data_install = sigit_t_comp_te.data_install AND sigit_t_comp_x.progressivo = sigit_t_comp_te.progressivo AND sigit_t_comp_x.id_tipo_componente::text = sigit_t_comp_te.id_tipo_componente::text AND sigit_t_comp_x.codice_impianto = sigit_t_comp_te.codice_impianto
   LEFT JOIN sigit_d_marca ON sigit_t_comp_x.fk_marca = sigit_d_marca.id_marca;
   
   


CREATE OR REPLACE VIEW vista_comp_ut AS 
 SELECT sigit_t_comp_x.codice_impianto, sigit_t_comp_x.id_tipo_componente, 
    sigit_t_comp_x.progressivo, sigit_t_comp_x.data_install, 
    sigit_t_comp_x.data_dismiss, sigit_t_comp_x.matricola, 
    sigit_t_comp_x.fk_marca, sigit_d_marca.des_marca, sigit_t_comp_x.modello, 
    sigit_t_comp_x.flg_dismissione,
    sigit_t_comp_x.data_ult_mod, sigit_t_comp_x.utente_ult_mod, 
    sigit_t_comp_ut.portata_mandata_ls, sigit_t_comp_ut.portata_ripresa_ls, 
    sigit_t_comp_ut.potenza_mandata_kw, sigit_t_comp_ut.potenza_ripresa_kw
   FROM sigit_t_comp_x
   JOIN sigit_t_comp_ut ON sigit_t_comp_x.data_install = sigit_t_comp_ut.data_install AND sigit_t_comp_x.progressivo = sigit_t_comp_ut.progressivo AND sigit_t_comp_x.id_tipo_componente::text = sigit_t_comp_ut.id_tipo_componente::text AND sigit_t_comp_x.codice_impianto = sigit_t_comp_ut.codice_impianto
   LEFT JOIN sigit_d_marca ON sigit_t_comp_x.fk_marca = sigit_d_marca.id_marca;




CREATE OR REPLACE VIEW vista_comp_vm AS 
 SELECT sigit_t_comp_x.codice_impianto, sigit_t_comp_x.id_tipo_componente, 
    sigit_t_comp_x.progressivo, sigit_t_comp_x.data_install, 
    sigit_t_comp_x.data_dismiss, sigit_t_comp_x.matricola, 
    sigit_t_comp_x.fk_marca, sigit_d_marca.des_marca, sigit_t_comp_x.modello, 
    sigit_t_comp_x.flg_dismissione,
    sigit_t_comp_x.data_ult_mod, sigit_t_comp_x.utente_ult_mod, 
    sigit_t_comp_vm.fk_dettaglio_vm, sigit_d_dettaglio_vm.des_dettaglio_vm, 
    sigit_t_comp_vm.altro_tipologia, sigit_t_comp_vm.portata_max_aria_m3h, 
    sigit_t_comp_vm.rendimento_cop
   FROM sigit_t_comp_x
   JOIN sigit_t_comp_vm ON sigit_t_comp_x.data_install = sigit_t_comp_vm.data_install AND sigit_t_comp_x.progressivo = sigit_t_comp_vm.progressivo AND sigit_t_comp_x.id_tipo_componente::text = sigit_t_comp_vm.id_tipo_componente::text AND sigit_t_comp_x.codice_impianto = sigit_t_comp_vm.codice_impianto
   LEFT JOIN sigit_d_marca ON sigit_t_comp_x.fk_marca = sigit_d_marca.id_marca
   LEFT JOIN sigit_d_dettaglio_vm ON sigit_t_comp_vm.fk_dettaglio_vm = sigit_d_dettaglio_vm.id_dettaglio_vm;




CREATE OR REPLACE VIEW vista_comp_vr AS 
 SELECT sigit_t_comp_x.codice_impianto, sigit_t_comp_x.id_tipo_componente, 
    sigit_t_comp_x.progressivo, sigit_t_comp_x.data_install, 
    sigit_t_comp_x.data_dismiss, sigit_t_comp_x.matricola, 
    sigit_t_comp_x.fk_marca, sigit_d_marca.des_marca, sigit_t_comp_x.modello, 
    sigit_t_comp_x.flg_dismissione,
    sigit_t_comp_x.data_ult_mod, sigit_t_comp_x.utente_ult_mod, 
    sigit_t_comp_vr.num_vie, sigit_t_comp_vr.servomotore
   FROM sigit_t_comp_x
   JOIN sigit_t_comp_vr ON sigit_t_comp_x.data_install = sigit_t_comp_vr.data_install AND sigit_t_comp_x.progressivo = sigit_t_comp_vr.progressivo AND sigit_t_comp_x.id_tipo_componente::text = sigit_t_comp_vr.id_tipo_componente::text AND sigit_t_comp_x.codice_impianto = sigit_t_comp_vr.codice_impianto
   LEFT JOIN sigit_d_marca ON sigit_t_comp_x.fk_marca = sigit_d_marca.id_marca;
   
   
        