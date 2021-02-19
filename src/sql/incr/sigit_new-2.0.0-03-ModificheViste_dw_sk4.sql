CREATE OR REPLACE VIEW sigit_new.vista_dw_sk4_cg
AS SELECT DISTINCT sigit_t_comp_cg.codice_impianto,
    sigit_t_comp_cg.id_tipo_componente,
    sigit_t_comp_cg.progressivo,
    sigit_t_comp_cg.data_install,
    sigit_t_comp_cg.data_dismiss,
    sigit_t_comp_cg.matricola,
    sigit_t_comp_cg.fk_marca,
    sigit_d_marca.des_marca,
    sigit_d_combustibile.id_combustibile,
    sigit_d_combustibile.des_combustibile,
    sigit_t_comp_cg.modello,
    sigit_t_comp_cg.potenza_termica_kw,
    sigit_t_comp_cg.data_ult_mod,
    sigit_t_comp_cg.utente_ult_mod,
    sigit_t_comp_cg.tipologia,
    sigit_t_comp_cg.potenza_elettrica_kw,
    sigit_t_comp_cg.temp_h2o_out_min,
    sigit_t_comp_cg.temp_h2o_out_max,
    sigit_t_comp_cg.temp_h2o_in_min,
    sigit_t_comp_cg.temp_h2o_in_max,
    sigit_t_comp_cg.temp_h2o_motore_min,
    sigit_t_comp_cg.temp_h2o_motore_max,
    sigit_t_comp_cg.temp_fumi_valle_min,
    sigit_t_comp_cg.temp_fumi_valle_max,
    sigit_t_comp_cg.temp_fumi_monte_min,
    sigit_t_comp_cg.temp_fumi_monte_max,
    sigit_t_comp_cg.co_min,
    sigit_t_comp_cg.co_max,
    sigit_t_comp_cg.flg_dismissione,
    sigit_t_allegato.data_controllo,
    sigit_t_impianto.istat_comune,
    sigit_t_impianto.denominazione_comune,
    sigit_t_impianto.denominazione_provincia,
    sigit_t_impianto.fk_stato AS stato_impianto,
    sigit_d_stato_imp.des_stato AS des_stato_impianto,
    sigit_t_libretto.data_consolidamento,
    sigit_t_allegato.fk_stato_rapp,
    sigit_d_stato_rapp.des_stato_rapp,
	sigit_t_allegato.f_osservazioni, 
	sigit_t_allegato.f_raccomandazioni,
	sigit_t_allegato.f_prescrizioni,
	sigit_t_allegato.f_flg_puo_funzionare,
	sigit_t_allegato.f_intervento_entro,
	sigit_t_allegato.id_allegato,
	sigit_t_allegato.fk_tipo_documento,
	sigit_d_tipo_documento.des_tipo_documento
   FROM sigit_t_comp_cg
     LEFT JOIN sigit_r_allegato_comp_cg USING (id_tipo_componente, progressivo, codice_impianto, data_install)
     LEFT JOIN sigit_t_allegato ON sigit_t_allegato.id_allegato = sigit_r_allegato_comp_cg.id_allegato AND sigit_t_allegato.fk_stato_rapp = 1::numeric
     LEFT JOIN sigit_t_dett_tipo4 ON sigit_t_dett_tipo4.fk_allegato = sigit_t_allegato.id_allegato AND sigit_t_dett_tipo4.fk_tipo_componente::text = sigit_r_allegato_comp_cg.id_tipo_componente::text AND sigit_t_dett_tipo4.progressivo = sigit_r_allegato_comp_cg.progressivo AND sigit_t_dett_tipo4.codice_impianto = sigit_r_allegato_comp_cg.codice_impianto AND sigit_t_dett_tipo4.data_install = sigit_r_allegato_comp_cg.data_install
     JOIN sigit_t_impianto ON sigit_t_impianto.codice_impianto = sigit_t_comp_cg.codice_impianto
     JOIN sigit_d_stato_imp ON sigit_t_impianto.fk_stato = sigit_d_stato_imp.id_stato
     LEFT JOIN sigit_t_libretto ON sigit_t_impianto.codice_impianto = sigit_t_libretto.codice_impianto AND sigit_t_libretto.fk_stato = 2::numeric
     LEFT JOIN sigit_d_marca ON sigit_t_comp_cg.fk_marca = sigit_d_marca.id_marca
     LEFT JOIN sigit_d_combustibile ON sigit_t_comp_cg.fk_combustibile = sigit_d_combustibile.id_combustibile
     LEFT JOIN sigit_d_stato_rapp ON sigit_d_stato_rapp.id_stato_rapp = sigit_t_allegato.fk_stato_rapp
     LEFT JOIN sigit_d_tipo_documento on sigit_d_tipo_documento.id_tipo_documento = sigit_t_allegato.fk_tipo_documento;

ALTER TABLE sigit_new.vista_dw_sk4_cg OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_new.vista_dw_sk4_cg TO sigit_new;
GRANT INSERT, SELECT, UPDATE, DELETE, TRUNCATE ON TABLE sigit_new.vista_dw_sk4_cg TO sigit_new_rw;

CREATE OR REPLACE VIEW sigit_new.vista_dw_sk4_gf
AS SELECT DISTINCT sigit_t_comp_gf.codice_impianto,
    sigit_t_comp_gf.id_tipo_componente,
    sigit_t_comp_gf.progressivo,
    sigit_t_comp_gf.data_install,
    sigit_t_comp_gf.matricola,
    sigit_t_comp_gf.fk_marca,
    sigit_d_marca.des_marca,
    sigit_d_combustibile.id_combustibile,
    sigit_d_combustibile.des_combustibile,
    sigit_t_comp_gf.fk_dettaglio_gf,
    sigit_d_dettaglio_gf.des_dettaglio_gf,
    sigit_t_comp_gf.modello,
    sigit_t_comp_gf.flg_sorgente_ext,
    sigit_t_comp_gf.flg_fluido_utenze,
    sigit_t_comp_gf.fluido_frigorigeno,
    sigit_t_comp_gf.n_circuiti,
    sigit_t_comp_gf.raffrescamento_eer,
    sigit_t_comp_gf.raff_potenza_kw,
    sigit_t_comp_gf.raff_potenza_ass,
    sigit_t_comp_gf.riscaldamento_cop,
    sigit_t_comp_gf.risc_potenza_kw,
    sigit_t_comp_gf.risc_potenza_ass_kw,
    sigit_t_comp_gf.flg_dismissione,
    sigit_t_comp_gf.data_dismiss,
    sigit_t_comp_gf.data_ult_mod,
    sigit_t_comp_gf.utente_ult_mod,
        CASE
            WHEN sigit_t_comp_gf.raff_potenza_kw > sigit_t_comp_gf.risc_potenza_kw THEN sigit_t_comp_gf.raff_potenza_kw
            ELSE sigit_t_comp_gf.risc_potenza_kw
        END AS potenza_termica_kw,
    sigit_t_allegato.data_controllo,
    sigit_t_impianto.istat_comune,
    sigit_t_impianto.denominazione_comune,
    sigit_t_impianto.denominazione_provincia,
    sigit_t_impianto.fk_stato AS stato_impianto,
    sigit_d_stato_imp.des_stato AS des_stato_impianto,
    sigit_t_libretto.data_consolidamento,
    sigit_t_allegato.fk_stato_rapp,
    sigit_d_stato_rapp.des_stato_rapp,
	sigit_t_allegato.f_osservazioni, 
	sigit_t_allegato.f_raccomandazioni,
	sigit_t_allegato.f_prescrizioni,
	sigit_t_allegato.f_flg_puo_funzionare,
	sigit_t_allegato.f_intervento_entro,
	sigit_t_allegato.id_allegato,
	sigit_t_allegato.fk_tipo_documento,
	sigit_d_tipo_documento.des_tipo_documento
   FROM sigit_t_comp_gf
     LEFT JOIN sigit_r_allegato_comp_gf USING (id_tipo_componente, progressivo, codice_impianto, data_install)
     LEFT JOIN sigit_t_allegato ON sigit_t_allegato.id_allegato = sigit_r_allegato_comp_gf.id_allegato AND sigit_t_allegato.fk_stato_rapp = 1::numeric
     LEFT JOIN sigit_t_dett_tipo2 ON sigit_t_dett_tipo2.fk_allegato = sigit_t_allegato.id_allegato AND sigit_t_dett_tipo2.codice_impianto = sigit_t_comp_gf.codice_impianto AND sigit_t_dett_tipo2.fk_tipo_componente::text = sigit_t_comp_gf.id_tipo_componente::text AND sigit_t_dett_tipo2.progressivo = sigit_t_comp_gf.progressivo AND sigit_t_dett_tipo2.data_install = sigit_t_comp_gf.data_install
     JOIN sigit_t_impianto ON sigit_t_impianto.codice_impianto = sigit_t_comp_gf.codice_impianto
     JOIN sigit_d_stato_imp ON sigit_t_impianto.fk_stato = sigit_d_stato_imp.id_stato
     LEFT JOIN sigit_t_libretto ON sigit_t_impianto.codice_impianto = sigit_t_libretto.codice_impianto AND sigit_t_libretto.fk_stato = 2::numeric
     LEFT JOIN sigit_d_marca ON sigit_t_comp_gf.fk_marca = sigit_d_marca.id_marca
     LEFT JOIN sigit_d_dettaglio_gf ON sigit_t_comp_gf.fk_dettaglio_gf = sigit_d_dettaglio_gf.id_dettaglio_gf
     LEFT JOIN sigit_d_combustibile ON sigit_t_comp_gf.fk_combustibile = sigit_d_combustibile.id_combustibile
     LEFT JOIN sigit_d_stato_rapp ON sigit_d_stato_rapp.id_stato_rapp = sigit_t_allegato.fk_stato_rapp
     LEFT JOIN sigit_d_tipo_documento on sigit_d_tipo_documento.id_tipo_documento = sigit_t_allegato.fk_tipo_documento;

ALTER TABLE sigit_new.vista_dw_sk4_gf OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_new.vista_dw_sk4_gf TO sigit_new;
GRANT INSERT, SELECT, UPDATE, DELETE, TRUNCATE ON TABLE sigit_new.vista_dw_sk4_gf TO sigit_new_rw;

CREATE OR REPLACE VIEW sigit_new.vista_dw_sk4_sc
AS SELECT DISTINCT sigit_t_comp_sc.codice_impianto,
    sigit_t_comp_sc.id_tipo_componente,
    sigit_t_comp_sc.progressivo,
    sigit_t_comp_sc.data_install,
    sigit_t_comp_sc.flg_dismissione,
    sigit_t_comp_sc.data_dismiss,
    sigit_t_comp_sc.data_ult_mod,
    sigit_t_comp_sc.utente_ult_mod,
    sigit_t_comp_sc.matricola,
    sigit_t_comp_sc.modello,
    sigit_t_comp_sc.potenza_termica_kw,
    sigit_t_comp_sc.fk_marca,
    sigit_d_marca.des_marca,
    sigit_t_allegato.data_controllo,
    sigit_t_impianto.istat_comune,
    sigit_t_impianto.denominazione_comune,
    sigit_t_impianto.denominazione_provincia,
    sigit_t_impianto.fk_stato AS stato_impianto,
    sigit_d_stato_imp.des_stato AS des_stato_impianto,
    sigit_t_libretto.data_consolidamento,
    sigit_t_allegato.fk_stato_rapp,
    sigit_d_stato_rapp.des_stato_rapp,
	sigit_t_allegato.f_osservazioni, 
	sigit_t_allegato.f_raccomandazioni,
	sigit_t_allegato.f_prescrizioni,
	sigit_t_allegato.f_flg_puo_funzionare,
	sigit_t_allegato.f_intervento_entro,
	sigit_t_allegato.id_allegato,
	sigit_t_allegato.fk_tipo_documento,
	sigit_d_tipo_documento.des_tipo_documento
   FROM sigit_t_comp_sc
     LEFT JOIN sigit_r_allegato_comp_sc USING (id_tipo_componente, progressivo, codice_impianto, data_install)
     LEFT JOIN sigit_t_allegato ON sigit_t_allegato.id_allegato = sigit_r_allegato_comp_sc.id_allegato AND sigit_t_allegato.fk_stato_rapp = 1::numeric
     LEFT JOIN sigit_t_dett_tipo3 ON sigit_t_dett_tipo3.fk_allegato = sigit_t_allegato.id_allegato AND sigit_t_dett_tipo3.codice_impianto = sigit_t_comp_sc.codice_impianto AND sigit_t_dett_tipo3.fk_tipo_componente::text = sigit_t_comp_sc.id_tipo_componente::text AND sigit_t_dett_tipo3.progressivo = sigit_t_comp_sc.progressivo AND sigit_t_dett_tipo3.data_install = sigit_t_comp_sc.data_install
     JOIN sigit_t_impianto ON sigit_t_impianto.codice_impianto = sigit_t_comp_sc.codice_impianto
     JOIN sigit_d_stato_imp ON sigit_t_impianto.fk_stato = sigit_d_stato_imp.id_stato
     LEFT JOIN sigit_t_libretto ON sigit_t_impianto.codice_impianto = sigit_t_libretto.codice_impianto AND sigit_t_libretto.fk_stato = 2::numeric
     LEFT JOIN sigit_d_marca ON sigit_t_comp_sc.fk_marca = sigit_d_marca.id_marca
     LEFT JOIN sigit_d_stato_rapp ON sigit_d_stato_rapp.id_stato_rapp = sigit_t_allegato.fk_stato_rapp
     LEFT JOIN sigit_d_tipo_documento on sigit_d_tipo_documento.id_tipo_documento = sigit_t_allegato.fk_tipo_documento;

ALTER TABLE sigit_new.vista_dw_sk4_sc OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_new.vista_dw_sk4_sc TO sigit_new;
GRANT INSERT, SELECT, UPDATE, DELETE, TRUNCATE ON TABLE sigit_new.vista_dw_sk4_sc TO sigit_new_rw;


CREATE OR REPLACE VIEW sigit_new.vista_dw_sk4_gt
AS SELECT DISTINCT sigit_t_comp_gt.codice_impianto,
    sigit_t_comp_gt.id_tipo_componente,
    sigit_t_comp_gt.progressivo,
    sigit_t_comp_gt.data_install,
    sigit_t_comp_gt.data_dismiss,
    sigit_t_comp_gt.matricola,
    sigit_t_comp_gt.fk_marca,
    sigit_d_marca.des_marca,
    sigit_d_combustibile.id_combustibile,
    sigit_d_combustibile.des_combustibile,
    sigit_t_comp_gt.fk_fluido,
    sigit_d_fluido.des_fluido,
    sigit_t_comp_gt.fk_dettaglio_gt,
    sigit_d_dettaglio_gt.des_dettaglio_gt,
    sigit_t_comp_gt.modello,
    sigit_t_comp_gt.potenza_termica_kw,
    sigit_t_comp_gt.data_ult_mod,
    sigit_t_comp_gt.utente_ult_mod,
    sigit_t_comp_gt.rendimento_perc,
    sigit_t_comp_gt.n_moduli,
    sigit_t_comp_gt.flg_dismissione,
    sigit_t_allegato.data_controllo,
    sigit_t_impianto.istat_comune,
    sigit_t_impianto.denominazione_comune,
    sigit_t_impianto.denominazione_provincia,
    sigit_t_impianto.fk_stato AS stato_impianto,
    sigit_d_stato_imp.des_stato AS des_stato_impianto,
    sigit_t_libretto.data_consolidamento,
    sigit_t_dett_tipo1.e_nox_ppm,
    sigit_t_dett_tipo1.e_nox_mg_kwh,
    sigit_t_dett_tipo1.e_n_modulo_termico,
    sigit_t_allegato.fk_stato_rapp,
    sigit_d_stato_rapp.des_stato_rapp,
	sigit_t_allegato.f_osservazioni, 
	sigit_t_allegato.f_raccomandazioni,
	sigit_t_allegato.f_prescrizioni,
	sigit_t_allegato.f_flg_puo_funzionare,
	sigit_t_allegato.f_intervento_entro,
	sigit_t_dett_tipo1.e_o2_perc,
	sigit_t_dett_tipo1.e_co2_perc,
	sigit_t_dett_tipo1.e_co_corretto_ppm,
	sigit_t_dett_tipo1.e_rend_comb_perc,
	sigit_t_dett_tipo1.e_rend_min_legge_perc,
	sigit_t_allegato.id_allegato,
	sigit_t_allegato.fk_tipo_documento,
	sigit_d_tipo_documento.des_tipo_documento
   FROM sigit_t_comp_gt
     LEFT JOIN sigit_r_allegato_comp_gt USING (id_tipo_componente, progressivo, codice_impianto, data_install)
     LEFT JOIN sigit_t_allegato ON sigit_t_allegato.id_allegato = sigit_r_allegato_comp_gt.id_allegato AND sigit_t_allegato.fk_stato_rapp = 1::numeric
     LEFT JOIN sigit_t_dett_tipo1 ON sigit_t_dett_tipo1.fk_allegato = sigit_t_allegato.id_allegato AND sigit_t_dett_tipo1.fk_tipo_componente::text = sigit_r_allegato_comp_gt.id_tipo_componente::text AND sigit_t_dett_tipo1.progressivo = sigit_r_allegato_comp_gt.progressivo AND sigit_t_dett_tipo1.codice_impianto = sigit_r_allegato_comp_gt.codice_impianto AND sigit_t_dett_tipo1.data_install = sigit_r_allegato_comp_gt.data_install
     JOIN sigit_t_impianto ON sigit_t_impianto.codice_impianto = sigit_t_comp_gt.codice_impianto
     JOIN sigit_d_stato_imp ON sigit_t_impianto.fk_stato = sigit_d_stato_imp.id_stato
     LEFT JOIN sigit_t_libretto ON sigit_t_impianto.codice_impianto = sigit_t_libretto.codice_impianto AND sigit_t_libretto.fk_stato = 2::numeric
     LEFT JOIN sigit_d_marca ON sigit_t_comp_gt.fk_marca = sigit_d_marca.id_marca
     LEFT JOIN sigit_d_fluido ON sigit_t_comp_gt.fk_fluido = sigit_d_fluido.id_fluido
     LEFT JOIN sigit_d_dettaglio_gt ON sigit_t_comp_gt.fk_dettaglio_gt = sigit_d_dettaglio_gt.id_dettaglio_gt
     LEFT JOIN sigit_d_combustibile ON sigit_t_comp_gt.fk_combustibile = sigit_d_combustibile.id_combustibile
     LEFT JOIN sigit_d_stato_rapp ON sigit_d_stato_rapp.id_stato_rapp = sigit_t_allegato.fk_stato_rapp
     LEFT JOIN sigit_d_tipo_documento on sigit_d_tipo_documento.id_tipo_documento = sigit_t_allegato.fk_tipo_documento;

ALTER TABLE sigit_new.vista_dw_sk4_gt OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_new.vista_dw_sk4_gt TO sigit_new;
GRANT INSERT, SELECT, UPDATE, DELETE, TRUNCATE ON TABLE sigit_new.vista_dw_sk4_gt TO sigit_new_rw;


------------ MV

drop VIEW sigit_new.vmv_od_vista_dettaglio_impianti;
drop materialized VIEW sigit_new.mv_od_vista_dettaglio_impianti;

drop VIEW sigit_new.vmv_vista_dw_sk4_cg;
drop MATERIALIZED VIEW sigit_new.mv_vista_dw_sk4_cg;

drop VIEW sigit_new.vmv_vista_dw_sk4_gf;
drop MATERIALIZED VIEW sigit_new.mv_vista_dw_sk4_gf;

drop VIEW sigit_new.vmv_vista_dw_sk4_sc;
drop MATERIALIZED VIEW sigit_new.mv_vista_dw_sk4_sc;

drop VIEW sigit_new.vmv_vista_dw_sk4_gt;
drop MATERIALIZED VIEW sigit_new.mv_vista_dw_sk4_gt;

CREATE MATERIALIZED VIEW sigit_new.mv_vista_dw_sk4_cg
TABLESPACE pg_default
AS SELECT DISTINCT sigit_t_comp_cg.codice_impianto,
    sigit_t_comp_cg.id_tipo_componente,
    sigit_t_comp_cg.progressivo,
    sigit_t_comp_cg.data_install,
    sigit_t_comp_cg.data_dismiss,
    sigit_t_comp_cg.matricola,
    sigit_t_comp_cg.fk_marca,
    sigit_d_marca.des_marca,
    sigit_d_combustibile.id_combustibile,
    sigit_d_combustibile.des_combustibile,
    sigit_t_comp_cg.modello,
    sigit_t_comp_cg.potenza_termica_kw,
    sigit_t_comp_cg.data_ult_mod,
    sigit_t_comp_cg.utente_ult_mod,
    sigit_t_comp_cg.tipologia,
    sigit_t_comp_cg.potenza_elettrica_kw,
    sigit_t_comp_cg.temp_h2o_out_min,
    sigit_t_comp_cg.temp_h2o_out_max,
    sigit_t_comp_cg.temp_h2o_in_min,
    sigit_t_comp_cg.temp_h2o_in_max,
    sigit_t_comp_cg.temp_h2o_motore_min,
    sigit_t_comp_cg.temp_h2o_motore_max,
    sigit_t_comp_cg.temp_fumi_valle_min,
    sigit_t_comp_cg.temp_fumi_valle_max,
    sigit_t_comp_cg.temp_fumi_monte_min,
    sigit_t_comp_cg.temp_fumi_monte_max,
    sigit_t_comp_cg.co_min,
    sigit_t_comp_cg.co_max,
    sigit_t_comp_cg.flg_dismissione,
    sigit_t_allegato.data_controllo,
    sigit_t_impianto.istat_comune,
    sigit_t_impianto.denominazione_comune,
    sigit_t_impianto.denominazione_provincia,
    sigit_t_impianto.fk_stato AS stato_impianto,
    sigit_d_stato_imp.des_stato AS des_stato_impianto,
    sigit_t_libretto.data_consolidamento,
    sigit_t_allegato.fk_stato_rapp,
    sigit_d_stato_rapp.des_stato_rapp,
	sigit_t_allegato.f_osservazioni, 
	sigit_t_allegato.f_raccomandazioni,
	sigit_t_allegato.f_prescrizioni,
	sigit_t_allegato.f_flg_puo_funzionare,
	sigit_t_allegato.f_intervento_entro,
	sigit_t_allegato.id_allegato,
	sigit_t_allegato.fk_tipo_documento,
	sigit_d_tipo_documento.des_tipo_documento
   FROM sigit_t_comp_cg
     LEFT JOIN sigit_r_allegato_comp_cg USING (id_tipo_componente, progressivo, codice_impianto, data_install)
     LEFT JOIN sigit_t_allegato ON sigit_t_allegato.id_allegato = sigit_r_allegato_comp_cg.id_allegato AND sigit_t_allegato.fk_stato_rapp = 1::numeric
     LEFT JOIN sigit_t_dett_tipo4 ON sigit_t_dett_tipo4.fk_allegato = sigit_t_allegato.id_allegato AND sigit_t_dett_tipo4.fk_tipo_componente::text = sigit_r_allegato_comp_cg.id_tipo_componente::text AND sigit_t_dett_tipo4.progressivo = sigit_r_allegato_comp_cg.progressivo AND sigit_t_dett_tipo4.codice_impianto = sigit_r_allegato_comp_cg.codice_impianto AND sigit_t_dett_tipo4.data_install = sigit_r_allegato_comp_cg.data_install
     JOIN sigit_t_impianto ON sigit_t_impianto.codice_impianto = sigit_t_comp_cg.codice_impianto
     JOIN sigit_d_stato_imp ON sigit_t_impianto.fk_stato = sigit_d_stato_imp.id_stato
     LEFT JOIN sigit_t_libretto ON sigit_t_impianto.codice_impianto = sigit_t_libretto.codice_impianto AND sigit_t_libretto.fk_stato = 2::numeric
     LEFT JOIN sigit_d_marca ON sigit_t_comp_cg.fk_marca = sigit_d_marca.id_marca
     LEFT JOIN sigit_d_combustibile ON sigit_t_comp_cg.fk_combustibile = sigit_d_combustibile.id_combustibile
     LEFT JOIN sigit_d_stato_rapp ON sigit_d_stato_rapp.id_stato_rapp = sigit_t_allegato.fk_stato_rapp
     LEFT JOIN sigit_d_tipo_documento on sigit_d_tipo_documento.id_tipo_documento = sigit_t_allegato.fk_tipo_documento
WITH DATA;

ALTER TABLE sigit_new.mv_vista_dw_sk4_cg OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_new.mv_vista_dw_sk4_cg TO sigit_new;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE sigit_new.mv_vista_dw_sk4_cg TO sigit_new_rw;

CREATE OR REPLACE VIEW sigit_new.vmv_vista_dw_sk4_cg
AS SELECT mv_vista_dw_sk4_cg.codice_impianto,
    mv_vista_dw_sk4_cg.id_tipo_componente,
    mv_vista_dw_sk4_cg.progressivo,
    mv_vista_dw_sk4_cg.data_install,
    mv_vista_dw_sk4_cg.data_dismiss,
    mv_vista_dw_sk4_cg.matricola,
    mv_vista_dw_sk4_cg.fk_marca,
    mv_vista_dw_sk4_cg.des_marca,
    mv_vista_dw_sk4_cg.id_combustibile,
    mv_vista_dw_sk4_cg.des_combustibile,
    mv_vista_dw_sk4_cg.modello,
    mv_vista_dw_sk4_cg.potenza_termica_kw,
    mv_vista_dw_sk4_cg.data_ult_mod,
    mv_vista_dw_sk4_cg.utente_ult_mod,
    mv_vista_dw_sk4_cg.tipologia,
    mv_vista_dw_sk4_cg.potenza_elettrica_kw,
    mv_vista_dw_sk4_cg.temp_h2o_out_min,
    mv_vista_dw_sk4_cg.temp_h2o_out_max,
    mv_vista_dw_sk4_cg.temp_h2o_in_min,
    mv_vista_dw_sk4_cg.temp_h2o_in_max,
    mv_vista_dw_sk4_cg.temp_h2o_motore_min,
    mv_vista_dw_sk4_cg.temp_h2o_motore_max,
    mv_vista_dw_sk4_cg.temp_fumi_valle_min,
    mv_vista_dw_sk4_cg.temp_fumi_valle_max,
    mv_vista_dw_sk4_cg.temp_fumi_monte_min,
    mv_vista_dw_sk4_cg.temp_fumi_monte_max,
    mv_vista_dw_sk4_cg.co_min,
    mv_vista_dw_sk4_cg.co_max,
    mv_vista_dw_sk4_cg.flg_dismissione,
    mv_vista_dw_sk4_cg.data_controllo,
    mv_vista_dw_sk4_cg.istat_comune,
    mv_vista_dw_sk4_cg.denominazione_comune,
    mv_vista_dw_sk4_cg.denominazione_provincia,
    mv_vista_dw_sk4_cg.stato_impianto,
    mv_vista_dw_sk4_cg.des_stato_impianto,
    mv_vista_dw_sk4_cg.data_consolidamento,
    mv_vista_dw_sk4_cg.fk_stato_rapp,
    mv_vista_dw_sk4_cg.des_stato_rapp,
	mv_vista_dw_sk4_cg.f_osservazioni, 
	mv_vista_dw_sk4_cg.f_raccomandazioni,
	mv_vista_dw_sk4_cg.f_prescrizioni,
	mv_vista_dw_sk4_cg.f_flg_puo_funzionare,
	mv_vista_dw_sk4_cg.f_intervento_entro,
	mv_vista_dw_sk4_cg.id_allegato,
	mv_vista_dw_sk4_cg.fk_tipo_documento,
	mv_vista_dw_sk4_cg.des_tipo_documento
   FROM mv_vista_dw_sk4_cg;

ALTER TABLE sigit_new.vmv_vista_dw_sk4_cg OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_new.vmv_vista_dw_sk4_cg TO sigit_new;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE sigit_new.vmv_vista_dw_sk4_cg TO sigit_new_rw;

CREATE MATERIALIZED VIEW sigit_new.mv_vista_dw_sk4_gf
TABLESPACE pg_default
AS SELECT DISTINCT sigit_t_comp_gf.codice_impianto,
    sigit_t_comp_gf.id_tipo_componente,
    sigit_t_comp_gf.progressivo,
    sigit_t_comp_gf.data_install,
    sigit_t_comp_gf.matricola,
    sigit_t_comp_gf.fk_marca,
    sigit_d_marca.des_marca,
    sigit_d_combustibile.id_combustibile,
    sigit_d_combustibile.des_combustibile,
    sigit_t_comp_gf.fk_dettaglio_gf,
    sigit_d_dettaglio_gf.des_dettaglio_gf,
    sigit_t_comp_gf.modello,
    sigit_t_comp_gf.flg_sorgente_ext,
    sigit_t_comp_gf.flg_fluido_utenze,
    sigit_t_comp_gf.fluido_frigorigeno,
    sigit_t_comp_gf.n_circuiti,
    sigit_t_comp_gf.raffrescamento_eer,
    sigit_t_comp_gf.raff_potenza_kw,
    sigit_t_comp_gf.raff_potenza_ass,
    sigit_t_comp_gf.riscaldamento_cop,
    sigit_t_comp_gf.risc_potenza_kw,
    sigit_t_comp_gf.risc_potenza_ass_kw,
    sigit_t_comp_gf.flg_dismissione,
    sigit_t_comp_gf.data_dismiss,
    sigit_t_comp_gf.data_ult_mod,
    sigit_t_comp_gf.utente_ult_mod,
        CASE
            WHEN sigit_t_comp_gf.raff_potenza_kw > sigit_t_comp_gf.risc_potenza_kw THEN sigit_t_comp_gf.raff_potenza_kw
            ELSE sigit_t_comp_gf.risc_potenza_kw
        END AS potenza_termica_kw,
    sigit_t_allegato.data_controllo,
    sigit_t_impianto.istat_comune,
    sigit_t_impianto.denominazione_comune,
    sigit_t_impianto.denominazione_provincia,
    sigit_t_impianto.fk_stato AS stato_impianto,
    sigit_d_stato_imp.des_stato AS des_stato_impianto,
    sigit_t_libretto.data_consolidamento,
    sigit_t_allegato.fk_stato_rapp,
    sigit_d_stato_rapp.des_stato_rapp,
	sigit_t_allegato.f_osservazioni, 
	sigit_t_allegato.f_raccomandazioni,
	sigit_t_allegato.f_prescrizioni,
	sigit_t_allegato.f_flg_puo_funzionare,
	sigit_t_allegato.f_intervento_entro,
	sigit_t_allegato.id_allegato,
	sigit_t_allegato.fk_tipo_documento,
	sigit_d_tipo_documento.des_tipo_documento
   FROM sigit_t_comp_gf
     LEFT JOIN sigit_r_allegato_comp_gf USING (id_tipo_componente, progressivo, codice_impianto, data_install)
     LEFT JOIN sigit_t_allegato ON sigit_t_allegato.id_allegato = sigit_r_allegato_comp_gf.id_allegato AND sigit_t_allegato.fk_stato_rapp = 1::numeric
     LEFT JOIN sigit_t_dett_tipo2 ON sigit_t_dett_tipo2.fk_allegato = sigit_t_allegato.id_allegato AND sigit_t_dett_tipo2.codice_impianto = sigit_t_comp_gf.codice_impianto AND sigit_t_dett_tipo2.fk_tipo_componente::text = sigit_t_comp_gf.id_tipo_componente::text AND sigit_t_dett_tipo2.progressivo = sigit_t_comp_gf.progressivo AND sigit_t_dett_tipo2.data_install = sigit_t_comp_gf.data_install
     JOIN sigit_t_impianto ON sigit_t_impianto.codice_impianto = sigit_t_comp_gf.codice_impianto
     JOIN sigit_d_stato_imp ON sigit_t_impianto.fk_stato = sigit_d_stato_imp.id_stato
     LEFT JOIN sigit_t_libretto ON sigit_t_impianto.codice_impianto = sigit_t_libretto.codice_impianto AND sigit_t_libretto.fk_stato = 2::numeric
     LEFT JOIN sigit_d_marca ON sigit_t_comp_gf.fk_marca = sigit_d_marca.id_marca
     LEFT JOIN sigit_d_dettaglio_gf ON sigit_t_comp_gf.fk_dettaglio_gf = sigit_d_dettaglio_gf.id_dettaglio_gf
     LEFT JOIN sigit_d_combustibile ON sigit_t_comp_gf.fk_combustibile = sigit_d_combustibile.id_combustibile
     LEFT JOIN sigit_d_stato_rapp ON sigit_d_stato_rapp.id_stato_rapp = sigit_t_allegato.fk_stato_rapp
     LEFT JOIN sigit_d_tipo_documento on sigit_d_tipo_documento.id_tipo_documento = sigit_t_allegato.fk_tipo_documento
WITH DATA;

ALTER TABLE sigit_new.mv_vista_dw_sk4_gf OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_new.mv_vista_dw_sk4_gf TO sigit_new;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE sigit_new.mv_vista_dw_sk4_gf TO sigit_new_rw;

CREATE OR REPLACE VIEW sigit_new.vmv_vista_dw_sk4_gf
AS SELECT mv_vista_dw_sk4_gf.codice_impianto,
    mv_vista_dw_sk4_gf.id_tipo_componente,
    mv_vista_dw_sk4_gf.progressivo,
    mv_vista_dw_sk4_gf.data_install,
    mv_vista_dw_sk4_gf.matricola,
    mv_vista_dw_sk4_gf.fk_marca,
    mv_vista_dw_sk4_gf.des_marca,
    mv_vista_dw_sk4_gf.id_combustibile,
    mv_vista_dw_sk4_gf.des_combustibile,
    mv_vista_dw_sk4_gf.fk_dettaglio_gf,
    mv_vista_dw_sk4_gf.des_dettaglio_gf,
    mv_vista_dw_sk4_gf.modello,
    mv_vista_dw_sk4_gf.flg_sorgente_ext,
    mv_vista_dw_sk4_gf.flg_fluido_utenze,
    mv_vista_dw_sk4_gf.fluido_frigorigeno,
    mv_vista_dw_sk4_gf.n_circuiti,
    mv_vista_dw_sk4_gf.raffrescamento_eer,
    mv_vista_dw_sk4_gf.raff_potenza_kw,
    mv_vista_dw_sk4_gf.raff_potenza_ass,
    mv_vista_dw_sk4_gf.riscaldamento_cop,
    mv_vista_dw_sk4_gf.risc_potenza_kw,
    mv_vista_dw_sk4_gf.risc_potenza_ass_kw,
    mv_vista_dw_sk4_gf.flg_dismissione,
    mv_vista_dw_sk4_gf.data_dismiss,
    mv_vista_dw_sk4_gf.data_ult_mod,
    mv_vista_dw_sk4_gf.utente_ult_mod,
    mv_vista_dw_sk4_gf.potenza_termica_kw,
    mv_vista_dw_sk4_gf.data_controllo,
    mv_vista_dw_sk4_gf.istat_comune,
    mv_vista_dw_sk4_gf.denominazione_comune,
    mv_vista_dw_sk4_gf.denominazione_provincia,
    mv_vista_dw_sk4_gf.stato_impianto,
    mv_vista_dw_sk4_gf.des_stato_impianto,
    mv_vista_dw_sk4_gf.data_consolidamento,
    mv_vista_dw_sk4_gf.fk_stato_rapp,
    mv_vista_dw_sk4_gf.des_stato_rapp,
	mv_vista_dw_sk4_gf.f_osservazioni, 
	mv_vista_dw_sk4_gf.f_raccomandazioni,
	mv_vista_dw_sk4_gf.f_prescrizioni,
	mv_vista_dw_sk4_gf.f_flg_puo_funzionare,
	mv_vista_dw_sk4_gf.f_intervento_entro,
	mv_vista_dw_sk4_gf.id_allegato,
	mv_vista_dw_sk4_gf.fk_tipo_documento,
	mv_vista_dw_sk4_gf.des_tipo_documento
   FROM mv_vista_dw_sk4_gf;

ALTER TABLE sigit_new.vmv_vista_dw_sk4_gf OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_new.vmv_vista_dw_sk4_gf TO sigit_new;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE sigit_new.vmv_vista_dw_sk4_gf TO sigit_new_rw;

CREATE MATERIALIZED VIEW sigit_new.mv_vista_dw_sk4_sc
TABLESPACE pg_default
AS SELECT DISTINCT sigit_t_comp_sc.codice_impianto,
    sigit_t_comp_sc.id_tipo_componente,
    sigit_t_comp_sc.progressivo,
    sigit_t_comp_sc.data_install,
    sigit_t_comp_sc.flg_dismissione,
    sigit_t_comp_sc.data_dismiss,
    sigit_t_comp_sc.data_ult_mod,
    sigit_t_comp_sc.utente_ult_mod,
    sigit_t_comp_sc.matricola,
    sigit_t_comp_sc.modello,
    sigit_t_comp_sc.potenza_termica_kw,
    sigit_t_comp_sc.fk_marca,
    sigit_d_marca.des_marca,
    sigit_t_allegato.data_controllo,
    sigit_t_impianto.istat_comune,
    sigit_t_impianto.denominazione_comune,
    sigit_t_impianto.denominazione_provincia,
    sigit_t_impianto.fk_stato AS stato_impianto,
    sigit_d_stato_imp.des_stato AS des_stato_impianto,
    sigit_t_libretto.data_consolidamento,
    sigit_t_allegato.fk_stato_rapp,
    sigit_d_stato_rapp.des_stato_rapp,
	sigit_t_allegato.f_osservazioni, 
	sigit_t_allegato.f_raccomandazioni,
	sigit_t_allegato.f_prescrizioni,
	sigit_t_allegato.f_flg_puo_funzionare,
	sigit_t_allegato.f_intervento_entro,
	sigit_t_allegato.id_allegato,
	sigit_t_allegato.fk_tipo_documento,
	sigit_d_tipo_documento.des_tipo_documento
   FROM sigit_t_comp_sc
     LEFT JOIN sigit_r_allegato_comp_sc USING (id_tipo_componente, progressivo, codice_impianto, data_install)
     LEFT JOIN sigit_t_allegato ON sigit_t_allegato.id_allegato = sigit_r_allegato_comp_sc.id_allegato AND sigit_t_allegato.fk_stato_rapp = 1::numeric
     LEFT JOIN sigit_t_dett_tipo3 ON sigit_t_dett_tipo3.fk_allegato = sigit_t_allegato.id_allegato AND sigit_t_dett_tipo3.codice_impianto = sigit_t_comp_sc.codice_impianto AND sigit_t_dett_tipo3.fk_tipo_componente::text = sigit_t_comp_sc.id_tipo_componente::text AND sigit_t_dett_tipo3.progressivo = sigit_t_comp_sc.progressivo AND sigit_t_dett_tipo3.data_install = sigit_t_comp_sc.data_install
     JOIN sigit_t_impianto ON sigit_t_impianto.codice_impianto = sigit_t_comp_sc.codice_impianto
     JOIN sigit_d_stato_imp ON sigit_t_impianto.fk_stato = sigit_d_stato_imp.id_stato
     LEFT JOIN sigit_t_libretto ON sigit_t_impianto.codice_impianto = sigit_t_libretto.codice_impianto AND sigit_t_libretto.fk_stato = 2::numeric
     LEFT JOIN sigit_d_marca ON sigit_t_comp_sc.fk_marca = sigit_d_marca.id_marca
     LEFT JOIN sigit_d_stato_rapp ON sigit_d_stato_rapp.id_stato_rapp = sigit_t_allegato.fk_stato_rapp
     LEFT JOIN sigit_d_tipo_documento on sigit_d_tipo_documento.id_tipo_documento = sigit_t_allegato.fk_tipo_documento
WITH DATA;

ALTER TABLE sigit_new.mv_vista_dw_sk4_sc OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_new.mv_vista_dw_sk4_sc TO sigit_new;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE sigit_new.mv_vista_dw_sk4_sc TO sigit_new_rw;

CREATE OR REPLACE VIEW sigit_new.vmv_vista_dw_sk4_sc
AS SELECT mv_vista_dw_sk4_sc.codice_impianto,
    mv_vista_dw_sk4_sc.id_tipo_componente,
    mv_vista_dw_sk4_sc.progressivo,
    mv_vista_dw_sk4_sc.data_install,
    mv_vista_dw_sk4_sc.flg_dismissione,
    mv_vista_dw_sk4_sc.data_dismiss,
    mv_vista_dw_sk4_sc.data_ult_mod,
    mv_vista_dw_sk4_sc.utente_ult_mod,
    mv_vista_dw_sk4_sc.matricola,
    mv_vista_dw_sk4_sc.modello,
    mv_vista_dw_sk4_sc.potenza_termica_kw,
    mv_vista_dw_sk4_sc.fk_marca,
    mv_vista_dw_sk4_sc.des_marca,
    mv_vista_dw_sk4_sc.data_controllo,
    mv_vista_dw_sk4_sc.istat_comune,
    mv_vista_dw_sk4_sc.denominazione_comune,
    mv_vista_dw_sk4_sc.denominazione_provincia,
    mv_vista_dw_sk4_sc.stato_impianto,
    mv_vista_dw_sk4_sc.des_stato_impianto,
    mv_vista_dw_sk4_sc.data_consolidamento,
    mv_vista_dw_sk4_sc.fk_stato_rapp,
    mv_vista_dw_sk4_sc.des_stato_rapp,
	mv_vista_dw_sk4_sc.f_osservazioni, 
	mv_vista_dw_sk4_sc.f_raccomandazioni,
	mv_vista_dw_sk4_sc.f_prescrizioni,
	mv_vista_dw_sk4_sc.f_flg_puo_funzionare,
	mv_vista_dw_sk4_sc.f_intervento_entro,
	mv_vista_dw_sk4_sc.id_allegato,
	mv_vista_dw_sk4_sc.fk_tipo_documento,
	mv_vista_dw_sk4_sc.des_tipo_documento
   FROM mv_vista_dw_sk4_sc;

ALTER TABLE sigit_new.vmv_vista_dw_sk4_sc OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_new.vmv_vista_dw_sk4_sc TO sigit_new;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE sigit_new.vmv_vista_dw_sk4_sc TO sigit_new_rw;

CREATE MATERIALIZED VIEW sigit_new.mv_vista_dw_sk4_gt
TABLESPACE pg_default
AS SELECT DISTINCT sigit_t_comp_gt.codice_impianto,
    sigit_t_comp_gt.id_tipo_componente,
    sigit_t_comp_gt.progressivo,
    sigit_t_comp_gt.data_install,
    sigit_t_comp_gt.data_dismiss,
    sigit_t_comp_gt.matricola,
    sigit_t_comp_gt.fk_marca,
    sigit_d_marca.des_marca,
    sigit_d_combustibile.id_combustibile,
    sigit_d_combustibile.des_combustibile,
    sigit_t_comp_gt.fk_fluido,
    sigit_d_fluido.des_fluido,
    sigit_t_comp_gt.fk_dettaglio_gt,
    sigit_d_dettaglio_gt.des_dettaglio_gt,
    sigit_t_comp_gt.modello,
    sigit_t_comp_gt.potenza_termica_kw,
    sigit_t_comp_gt.data_ult_mod,
    sigit_t_comp_gt.utente_ult_mod,
    sigit_t_comp_gt.rendimento_perc,
    sigit_t_comp_gt.n_moduli,
    sigit_t_comp_gt.flg_dismissione,
    sigit_t_allegato.data_controllo,
    sigit_t_impianto.istat_comune,
    sigit_t_impianto.denominazione_comune,
    sigit_t_impianto.denominazione_provincia,
    sigit_t_impianto.fk_stato AS stato_impianto,
    sigit_d_stato_imp.des_stato AS des_stato_impianto,
    sigit_t_libretto.data_consolidamento,
    sigit_t_dett_tipo1.e_nox_ppm,
    sigit_t_dett_tipo1.e_nox_mg_kwh,
    sigit_t_dett_tipo1.e_n_modulo_termico,
    sigit_t_allegato.fk_stato_rapp,
    sigit_d_stato_rapp.des_stato_rapp,
	sigit_t_allegato.f_osservazioni, 
	sigit_t_allegato.f_raccomandazioni,
	sigit_t_allegato.f_prescrizioni,
	sigit_t_allegato.f_flg_puo_funzionare,
	sigit_t_allegato.f_intervento_entro,
	sigit_t_dett_tipo1.e_o2_perc,
	sigit_t_dett_tipo1.e_co2_perc,
	sigit_t_dett_tipo1.e_co_corretto_ppm,
	sigit_t_dett_tipo1.e_rend_comb_perc,
	sigit_t_dett_tipo1.e_rend_min_legge_perc,
	sigit_t_allegato.id_allegato,
	sigit_t_allegato.fk_tipo_documento,
	sigit_d_tipo_documento.des_tipo_documento
   FROM sigit_t_comp_gt
     LEFT JOIN sigit_r_allegato_comp_gt USING (id_tipo_componente, progressivo, codice_impianto, data_install)
     LEFT JOIN sigit_t_allegato ON sigit_t_allegato.id_allegato = sigit_r_allegato_comp_gt.id_allegato AND sigit_t_allegato.fk_stato_rapp = 1::numeric
     LEFT JOIN sigit_t_dett_tipo1 ON sigit_t_dett_tipo1.fk_allegato = sigit_t_allegato.id_allegato AND sigit_t_dett_tipo1.fk_tipo_componente::text = sigit_r_allegato_comp_gt.id_tipo_componente::text AND sigit_t_dett_tipo1.progressivo = sigit_r_allegato_comp_gt.progressivo AND sigit_t_dett_tipo1.codice_impianto = sigit_r_allegato_comp_gt.codice_impianto AND sigit_t_dett_tipo1.data_install = sigit_r_allegato_comp_gt.data_install
     JOIN sigit_t_impianto ON sigit_t_impianto.codice_impianto = sigit_t_comp_gt.codice_impianto
     JOIN sigit_d_stato_imp ON sigit_t_impianto.fk_stato = sigit_d_stato_imp.id_stato
     LEFT JOIN sigit_t_libretto ON sigit_t_impianto.codice_impianto = sigit_t_libretto.codice_impianto AND sigit_t_libretto.fk_stato = 2::numeric
     LEFT JOIN sigit_d_marca ON sigit_t_comp_gt.fk_marca = sigit_d_marca.id_marca
     LEFT JOIN sigit_d_fluido ON sigit_t_comp_gt.fk_fluido = sigit_d_fluido.id_fluido
     LEFT JOIN sigit_d_dettaglio_gt ON sigit_t_comp_gt.fk_dettaglio_gt = sigit_d_dettaglio_gt.id_dettaglio_gt
     LEFT JOIN sigit_d_combustibile ON sigit_t_comp_gt.fk_combustibile = sigit_d_combustibile.id_combustibile
     LEFT JOIN sigit_d_stato_rapp ON sigit_d_stato_rapp.id_stato_rapp = sigit_t_allegato.fk_stato_rapp
     LEFT JOIN sigit_d_tipo_documento on sigit_d_tipo_documento.id_tipo_documento = sigit_t_allegato.fk_tipo_documento
WITH DATA;

ALTER TABLE sigit_new.mv_vista_dw_sk4_gt OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_new.mv_vista_dw_sk4_gt TO sigit_new;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE sigit_new.mv_vista_dw_sk4_gt TO sigit_new_rw;

CREATE OR REPLACE VIEW sigit_new.vmv_vista_dw_sk4_gt
AS SELECT mv_vista_dw_sk4_gt.codice_impianto,
    mv_vista_dw_sk4_gt.id_tipo_componente,
    mv_vista_dw_sk4_gt.progressivo,
    mv_vista_dw_sk4_gt.data_install,
    mv_vista_dw_sk4_gt.data_dismiss,
    mv_vista_dw_sk4_gt.matricola,
    mv_vista_dw_sk4_gt.fk_marca,
    mv_vista_dw_sk4_gt.des_marca,
    mv_vista_dw_sk4_gt.id_combustibile,
    mv_vista_dw_sk4_gt.des_combustibile,
    mv_vista_dw_sk4_gt.fk_fluido,
    mv_vista_dw_sk4_gt.des_fluido,
    mv_vista_dw_sk4_gt.fk_dettaglio_gt,
    mv_vista_dw_sk4_gt.des_dettaglio_gt,
    mv_vista_dw_sk4_gt.modello,
    mv_vista_dw_sk4_gt.potenza_termica_kw,
    mv_vista_dw_sk4_gt.data_ult_mod,
    mv_vista_dw_sk4_gt.utente_ult_mod,
    mv_vista_dw_sk4_gt.rendimento_perc,
    mv_vista_dw_sk4_gt.n_moduli,
    mv_vista_dw_sk4_gt.flg_dismissione,
    mv_vista_dw_sk4_gt.data_controllo,
    mv_vista_dw_sk4_gt.istat_comune,
    mv_vista_dw_sk4_gt.denominazione_comune,
    mv_vista_dw_sk4_gt.denominazione_provincia,
    mv_vista_dw_sk4_gt.stato_impianto,
    mv_vista_dw_sk4_gt.des_stato_impianto,
    mv_vista_dw_sk4_gt.data_consolidamento,
    mv_vista_dw_sk4_gt.e_nox_ppm,
    mv_vista_dw_sk4_gt.e_nox_mg_kwh,
    mv_vista_dw_sk4_gt.e_n_modulo_termico,
    mv_vista_dw_sk4_gt.fk_stato_rapp,
    mv_vista_dw_sk4_gt.des_stato_rapp,
	mv_vista_dw_sk4_gt.f_osservazioni, 
	mv_vista_dw_sk4_gt.f_raccomandazioni,
	mv_vista_dw_sk4_gt.f_prescrizioni,
	mv_vista_dw_sk4_gt.f_flg_puo_funzionare,
	mv_vista_dw_sk4_gt.f_intervento_entro,
	mv_vista_dw_sk4_gt.e_o2_perc,
	mv_vista_dw_sk4_gt.e_co2_perc,
	mv_vista_dw_sk4_gt.e_co_corretto_ppm,
	mv_vista_dw_sk4_gt.e_rend_comb_perc,
	mv_vista_dw_sk4_gt.e_rend_min_legge_perc,
	mv_vista_dw_sk4_gt.id_allegato,
	mv_vista_dw_sk4_gt.fk_tipo_documento,
	mv_vista_dw_sk4_gt.des_tipo_documento
   FROM mv_vista_dw_sk4_gt;

ALTER TABLE sigit_new.vmv_vista_dw_sk4_gt OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_new.vmv_vista_dw_sk4_gt TO sigit_new;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE sigit_new.vmv_vista_dw_sk4_gt TO sigit_new_rw;



-- non si modifica ma si ricrea
CREATE MATERIALIZED VIEW sigit_new.mv_od_vista_dettaglio_impianti
TABLESPACE pg_default
AS SELECT i.codice_impianto,
    i.denominazione_comune,
    i.denominazione_provincia,
    ui.l1_2_fk_categoria,
    ui.l1_2_vol_risc_m3,
    ui.l1_2_vol_raff_m3,
    i.l1_3_pot_h2o_kw,
    i.l1_3_pot_clima_inv_kw,
    i.l1_3_pot_clima_est_kw,
    gt.id_tipo_componente AS tipo_componente,
    gt.progressivo,
    gt.data_install,
    gt.des_marca,
    gt.des_combustibile,
    gt.des_dettaglio_gt AS des_dettaglio,
    gt.potenza_termica_kw AS potenza,
    gt.rendimento_perc,
    gt.data_controllo,
    gt.e_nox_ppm,
    gt.e_nox_mg_kwh,
    gt.e_n_modulo_termico
   FROM sigit_t_impianto i
     JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
     JOIN mv_vista_dw_sk4_gt gt ON i.codice_impianto = gt.codice_impianto
  WHERE gt.data_dismiss IS NULL AND ui.flg_principale = 1::numeric AND i.fk_stato = 1::numeric AND ((i.codice_impianto, gt.id_tipo_componente::text, gt.progressivo, gt.data_controllo) IN ( SELECT i_1.codice_impianto,
            gt_1.id_tipo_componente AS tipo_componente,
            gt_1.progressivo,
            max(gt_1.data_controllo) AS data_controllo
           FROM sigit_t_impianto i_1
             JOIN sigit_t_unita_immobiliare ui_1 ON i_1.codice_impianto = ui_1.codice_impianto
             JOIN mv_vista_dw_sk4_gt gt_1 ON i_1.codice_impianto = gt_1.codice_impianto
          WHERE gt_1.data_dismiss IS NULL AND ui_1.flg_principale = 1::numeric AND i_1.fk_stato = 1::numeric
          GROUP BY i_1.codice_impianto, gt_1.id_tipo_componente, gt_1.progressivo))
  GROUP BY i.codice_impianto, i.denominazione_comune, i.denominazione_provincia, ui.l1_2_fk_categoria, ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, gt.id_tipo_componente, gt.progressivo, gt.data_install, gt.des_marca, gt.des_combustibile, gt.des_dettaglio_gt, gt.potenza_termica_kw, gt.rendimento_perc, gt.data_controllo, gt.e_nox_ppm, gt.e_nox_mg_kwh, gt.e_n_modulo_termico
UNION
 SELECT i.codice_impianto,
    i.denominazione_comune,
    i.denominazione_provincia,
    ui.l1_2_fk_categoria,
    ui.l1_2_vol_risc_m3,
    ui.l1_2_vol_raff_m3,
    i.l1_3_pot_h2o_kw,
    i.l1_3_pot_clima_inv_kw,
    i.l1_3_pot_clima_est_kw,
    gf.id_tipo_componente AS tipo_componente,
    gf.progressivo,
    gf.data_install,
    gf.des_marca,
    gf.des_combustibile,
    NULL::text AS des_dettaglio,
    gf.potenza_termica_kw AS potenza,
    NULL::numeric AS rendimento_perc,
    max(gf.data_controllo) AS data_controllo,
    NULL::numeric AS e_nox_ppm,
    NULL::numeric AS e_nox_mg_kwh,
    NULL::numeric AS e_n_modulo_termico
   FROM sigit_t_impianto i
     JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
     JOIN mv_vista_dw_sk4_gf gf ON i.codice_impianto = gf.codice_impianto
  WHERE gf.data_dismiss IS NULL AND ui.flg_principale = 1::numeric AND i.fk_stato = 1::numeric
  GROUP BY i.codice_impianto, i.denominazione_comune, i.denominazione_provincia, ui.l1_2_fk_categoria, ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, gf.id_tipo_componente, gf.progressivo, gf.data_install, gf.des_marca, gf.des_combustibile, NULL::text, gf.potenza_termica_kw
UNION
 SELECT i.codice_impianto,
    i.denominazione_comune,
    i.denominazione_provincia,
    ui.l1_2_fk_categoria,
    ui.l1_2_vol_risc_m3,
    ui.l1_2_vol_raff_m3,
    i.l1_3_pot_h2o_kw,
    i.l1_3_pot_clima_inv_kw,
    i.l1_3_pot_clima_est_kw,
    sc.id_tipo_componente AS tipo_componente,
    sc.progressivo,
    sc.data_install,
    sc.des_marca,
    NULL::character varying AS des_combustibile,
    NULL::text AS des_dettaglio,
    sc.potenza_termica_kw AS potenza,
    NULL::numeric AS rendimento_perc,
    max(sc.data_controllo) AS data_controllo,
    NULL::numeric AS e_nox_ppm,
    NULL::numeric AS e_nox_mg_kwh,
    NULL::numeric AS e_n_modulo_termico
   FROM sigit_t_impianto i
     JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
     JOIN mv_vista_dw_sk4_sc sc ON i.codice_impianto = sc.codice_impianto
  WHERE sc.data_dismiss IS NULL AND ui.flg_principale = 1::numeric AND i.fk_stato = 1::numeric
  GROUP BY i.codice_impianto, i.denominazione_comune, i.denominazione_provincia, ui.l1_2_fk_categoria, ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, sc.id_tipo_componente, sc.progressivo, sc.data_install, sc.des_marca, NULL::text, sc.potenza_termica_kw
UNION
 SELECT i.codice_impianto,
    i.denominazione_comune,
    i.denominazione_provincia,
    ui.l1_2_fk_categoria,
    ui.l1_2_vol_risc_m3,
    ui.l1_2_vol_raff_m3,
    i.l1_3_pot_h2o_kw,
    i.l1_3_pot_clima_inv_kw,
    i.l1_3_pot_clima_est_kw,
    cg.id_tipo_componente AS tipo_componente,
    cg.progressivo,
    cg.data_install,
    cg.des_marca,
    cg.des_combustibile,
    NULL::character varying AS des_dettaglio,
    cg.potenza_termica_kw AS potenza,
    NULL::numeric AS rendimento_perc,
    max(cg.data_controllo) AS data_controllo,
    NULL::numeric AS e_nox_ppm,
    NULL::numeric AS e_nox_mg_kwh,
    NULL::numeric AS e_n_modulo_termico
   FROM sigit_t_impianto i
     JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
     JOIN mv_vista_dw_sk4_cg cg ON i.codice_impianto = cg.codice_impianto
  WHERE cg.data_dismiss IS NULL AND ui.flg_principale = 1::numeric AND i.fk_stato = 1::numeric
  GROUP BY i.codice_impianto, i.denominazione_comune, i.denominazione_provincia, ui.l1_2_fk_categoria, ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, cg.id_tipo_componente, cg.progressivo, cg.data_install, cg.des_marca, cg.des_combustibile, cg.potenza_termica_kw
WITH DATA;

ALTER TABLE sigit_new.mv_od_vista_dettaglio_impianti OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_new.mv_od_vista_dettaglio_impianti TO sigit_new;
GRANT ALL ON TABLE sigit_new.mv_od_vista_dettaglio_impianti TO sigit_new_rw;

CREATE OR REPLACE VIEW sigit_new.vmv_od_vista_dettaglio_impianti
AS SELECT mv_od_vista_dettaglio_impianti.codice_impianto,
    mv_od_vista_dettaglio_impianti.denominazione_comune,
    mv_od_vista_dettaglio_impianti.denominazione_provincia,
    mv_od_vista_dettaglio_impianti.l1_2_fk_categoria,
    mv_od_vista_dettaglio_impianti.l1_2_vol_risc_m3,
    mv_od_vista_dettaglio_impianti.l1_2_vol_raff_m3,
    mv_od_vista_dettaglio_impianti.l1_3_pot_h2o_kw,
    mv_od_vista_dettaglio_impianti.l1_3_pot_clima_inv_kw,
    mv_od_vista_dettaglio_impianti.l1_3_pot_clima_est_kw,
    mv_od_vista_dettaglio_impianti.tipo_componente,
    mv_od_vista_dettaglio_impianti.progressivo,
    mv_od_vista_dettaglio_impianti.data_install,
    mv_od_vista_dettaglio_impianti.des_marca,
    mv_od_vista_dettaglio_impianti.des_combustibile,
    mv_od_vista_dettaglio_impianti.des_dettaglio,
    mv_od_vista_dettaglio_impianti.potenza,
    mv_od_vista_dettaglio_impianti.rendimento_perc,
    mv_od_vista_dettaglio_impianti.data_controllo,
    mv_od_vista_dettaglio_impianti.e_nox_ppm,
    mv_od_vista_dettaglio_impianti.e_nox_mg_kwh,
    mv_od_vista_dettaglio_impianti.e_n_modulo_termico
   FROM mv_od_vista_dettaglio_impianti;

ALTER TABLE sigit_new.vmv_od_vista_dettaglio_impianti OWNER TO sigit_new;
GRANT ALL ON TABLE sigit_new.vmv_od_vista_dettaglio_impianti TO sigit_new;
GRANT INSERT, SELECT, UPDATE, DELETE ON TABLE sigit_new.vmv_od_vista_dettaglio_impianti TO sigit_new_rw;
