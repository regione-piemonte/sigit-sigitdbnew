-------------------------------------------------------------------------------------
-- Aggiornato TEST in toto il 27/02/2018 (gli altri commenti restano solo promemoria
--------------------------------------------------------------------------------------


-----------------------------------------------------------------------
-- Modifica richiesta da Actis, effettuata solo in SVI  - 16/10/2017
-----------------------------------------------------------------------
ALTER TABLE sigit_t_consumo_14_4 DROP COLUMN esercizio;

ALTER TABLE sigit_t_consumo ADD COLUMN data_ult_mod timestamp without time zone;
ALTER TABLE sigit_t_consumo ADD COLUMN utente_ult_mod character varying(16);






-----------------------------------------------------------------------
-- Modifica richiesta da Actis, effettuata solo in SVI  - 10/11/2017
-----------------------------------------------------------------------
CREATE TABLE sigit_t_libretto_20171110 as select * from sigit_t_libretto;

ALTER TABLE sigit_t_impianto ADD COLUMN data_intervento date;
ALTER TABLE sigit_t_impianto ADD COLUMN fk_tipo_intervento numeric;

------------------------------------------------------------------------------------
-- Aggiunta ultimi 3 campi richiesta da Actis, effettuata solo in SVI  - 01/01/2018
------------------------------------------------------------------------------------

CREATE TABLE sigit_t_controllo_libretto
(
	codice_impianto       NUMERIC  NOT NULL ,
	flg_l1_controlloweb   NUMERIC(1)  NULL  CONSTRAINT flg_l1_0_1 CHECK (flg_l1_controlloweb IN (0,1)),
	flg_l5_controlloweb   NUMERIC(1)  NULL  CONSTRAINT flg_l5_0_1 CHECK (flg_l5_controlloweb IN (0,1)),
	flg_l6_controlloweb   NUMERIC(1)  NULL  CONSTRAINT flg_l6_0_1 CHECK (flg_l6_controlloweb IN (0,1)),
	flg_l7_controlloweb   NUMERIC(1)  NULL  CONSTRAINT flg_l7_0_1 CHECK (flg_l7_controlloweb IN (0,1))
);
ALTER TABLE sigit_t_controllo_libretto
	ADD CONSTRAINT  PK_sigit_t_controllo_libretto PRIMARY KEY (codice_impianto);

ALTER TABLE sigit_t_controllo_libretto
	ADD CONSTRAINT  fk_sigit_t_impianto_14 FOREIGN KEY (codice_impianto) REFERENCES sigit_t_impianto(codice_impianto);


--- trattamento dati
UPDATE sigit_t_impianto a SET (fk_tipo_intervento,data_intervento)  = (z.fk_tipo_intervento, z.data_intervento) 
from  (select fk_tipo_intervento, data_intervento, codice_impianto from sigit_t_libretto ) z
where a.codice_impianto = z.codice_impianto;


--- da fare dopo ok di Actis

ALTER TABLE sigit_t_libretto DROP COLUMN fk_tipo_intervento;
ALTER TABLE sigit_t_libretto DROP COLUMN data_intervento;




-----------------------------------------------------------------------
-- Modifica richiesta da Todaro, effettuata solo in SVI  - 11/12/2017
-----------------------------------------------------------------------
CREATE TABLE sigit_t_libretto_20171211 as select * from sigit_t_libretto;

ALTER TABLE sigit_t_impianto ADD COLUMN l11_1_flg_norma_uni_10389_1 NUMERIC(1) CONSTRAINT  dom_l11_0_1 CHECK (l11_1_flg_norma_uni_10389_1 IN (0,1));
ALTER TABLE sigit_t_impianto ADD COLUMN l11_1_altra_norma CHARACTER VARYING(100);

--- trattamento dati
UPDATE sigit_t_impianto a SET (l11_1_flg_norma_uni_10389_1,l11_1_altra_norma)  = (z.l11_1_flg_norma_uni_10389_1, z.l11_1_altra_norma) 
from  (select l11_1_flg_norma_uni_10389_1, l11_1_altra_norma, codice_impianto from sigit_t_libretto ) z
where a.codice_impianto = z.codice_impianto;

--- da fare dopo ok di Actis

ALTER TABLE sigit_t_libretto DROP COLUMN l11_1_flg_norma_uni_10389_1;
ALTER TABLE sigit_t_libretto DROP COLUMN l11_1_altra_norma;


/*---------------------------------------------------------------------
-- Modifica richiesta da Actis, effettuata solo in TST  - 20/12/2017
-- In SVI il 10/01/2018
-----------------------------------------------------------------------

CREATE TABLE sigit_t_hd_dati_trattati
(
	id_hd_dati_trattati   integer  NOT NULL ,
	codice_impianto       NUMERIC  NULL ,
	dato_distributore     CHARACTER VARYING(100)  NULL ,
	id_pf                 INTEGER  NULL ,
	id_pg                 INTEGER  NULL ,
	dt_trattamento        DATE  NULL ,
	id_remedy             CHARACTER VARYING(30)  NULL ,
	descrizione           CHARACTER VARYING(1000)  NULL 
);


ALTER TABLE sigit_t_hd_dati_trattati
	ADD CONSTRAINT  PK_sigit_t_hd_dati_trattati PRIMARY KEY (id_hd_dati_trattati);

GRANT DELETE, INSERT, SELECT, UPDATE ON sigit_t_hd_dati_trattati TO sigit_new_rw; */



CREATE OR REPLACE VIEW od_vista_aggregata_impianto_combustibile_gt AS 
 SELECT elenco.denominazione_comune AS key_classe, 
    sum(elenco.tot_gasnat) AS gas_naturale, sum(elenco.tot_gasolio) AS gasolio, 
    sum(elenco.tot_gpl) AS gpl, 
    sum(elenco.tot_pellet_tronchetti_cippato) AS pellet_tronchetti_cippato, 
    sum(elenco.tot_oliocomb) AS olio_combustibile, 
    sum(elenco.tot_altrabiomassa) AS biomassa, 
    sum(elenco.tot_carbone) AS carbone, 
    sum(elenco.tot_policombustibile) AS policombustibile, 
    sum(elenco.tot_termica) AS termica, sum(elenco.tot_altro) AS altro
   FROM ( SELECT vista_dw_sk4_gt.codice_impianto, 
            vista_dw_sk4_gt.des_combustibile, 
                CASE
                    WHEN vista_dw_sk4_gt.des_combustibile::text ~~ 'Gas naturale'::text THEN 1
                    ELSE 0
                END AS tot_gasnat, 
                CASE
                    WHEN vista_dw_sk4_gt.des_combustibile::text ~~ 'Gasolio'::text THEN 1
                    ELSE 0
                END AS tot_gasolio, 
                CASE
                    WHEN vista_dw_sk4_gt.des_combustibile::text ~~ 'Gpl'::text THEN 1
                    ELSE 0
                END AS tot_gpl, 
                CASE
                    WHEN vista_dw_sk4_gt.des_combustibile::text ~~ 'Pellet'::text OR vista_dw_sk4_gt.des_combustibile::text ~~ 'Tronchetti'::text OR vista_dw_sk4_gt.des_combustibile::text ~~ 'Cippato'::text OR vista_dw_sk4_gt.des_combustibile::text ~~ 'Tronchetti/Pellet'::text OR vista_dw_sk4_gt.des_combustibile::text ~~ 'Cippato/Pellet'::text THEN 1
                    ELSE 0
                END AS tot_pellet_tronchetti_cippato, 
                CASE
                    WHEN vista_dw_sk4_gt.des_combustibile::text ~~ 'Olio combustibile'::text THEN 1
                    ELSE 0
                END AS tot_oliocomb, 
                CASE
                    WHEN vista_dw_sk4_gt.des_combustibile::text ~~ 'Altra biomassa solida'::text OR vista_dw_sk4_gt.des_combustibile::text ~~ 'Biomassa liquida'::text OR vista_dw_sk4_gt.des_combustibile::text ~~ 'Biomassa gassosa'::text THEN 1
                    ELSE 0
                END AS tot_altrabiomassa, 
                CASE
                    WHEN vista_dw_sk4_gt.des_combustibile::text ~~ 'Carbone'::text THEN 1
                    ELSE 0
                END AS tot_carbone, 
                CASE
                    WHEN vista_dw_sk4_gt.des_combustibile::text ~~ 'Energia Termica'::text THEN 1
                    ELSE 0
                END AS tot_termica, 
                CASE
                    WHEN vista_dw_sk4_gt.des_combustibile::text ~~ 'Policombustibile (biomassa-gas/gasolio)'::text THEN 1
                    ELSE 0
                END AS tot_policombustibile, 
                CASE
                    WHEN vista_dw_sk4_gt.des_combustibile::text ~~ 'Altro'::text THEN 1
                    ELSE 0
                END AS tot_altro, 
            vista_dw_sk4_gt.denominazione_comune, count(*) AS count
           FROM vista_dw_sk4_gt
          WHERE vista_dw_sk4_gt.des_stato_impianto::text ~~ 'Attivo'::text AND vista_dw_sk4_gt.data_dismiss IS NULL AND vista_dw_sk4_gt.data_consolidamento IS NOT NULL
          GROUP BY vista_dw_sk4_gt.codice_impianto, vista_dw_sk4_gt.des_combustibile, vista_dw_sk4_gt.denominazione_comune
          ORDER BY vista_dw_sk4_gt.denominazione_comune, vista_dw_sk4_gt.codice_impianto, vista_dw_sk4_gt.des_combustibile) elenco
  GROUP BY elenco.denominazione_comune
  ORDER BY elenco.denominazione_comune;

ALTER TABLE od_vista_aggregata_impianto_combustibile_gt
  OWNER TO sigit_new;
GRANT ALL ON TABLE od_vista_aggregata_impianto_combustibile_gt TO sigit_new;
GRANT SELECT ON TABLE od_vista_aggregata_impianto_combustibile_gt TO sigit_new_ro;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE od_vista_aggregata_impianto_combustibile_gt TO sigit_new_rw;


CREATE OR REPLACE VIEW od_vista_aggregata_impianto_potenza AS 
 SELECT elenco.denominazione_comune AS key_classe, 
    sum(elenco.tot_35) AS pot_clima_inv_fino_al_35, 
    sum(elenco.tot_100) AS pot_clima_inv_dal_36_al_100, 
    sum(elenco.tot_250) AS pot_clima_inv_dal_101_al_250, 
    sum(elenco.tot_350) AS pot_clima_inv_dal_251_al_350, 
    sum(elenco.tot_351) AS pot_clima_inv_oltre_350, 
    sum(elenco.tot_e_35) AS pot_clima_est_fino_al_35, 
    sum(elenco.tot_e_100) AS pot_clima_est_dal_36_al_100, 
    sum(elenco.tot_e_250) AS pot_clima_est_dal_101_al_250, 
    sum(elenco.tot_e_350) AS pot_clima_est_dal_251_al_350, 
    sum(elenco.tot_e_351) AS pot_clima_iest_oltre_350
   FROM ( SELECT vista_ricerca_impianti.denominazione_comune, 
            vista_ricerca_impianti.l1_3_pot_clima_inv_kw, 
                CASE
                    WHEN vista_ricerca_impianti.l1_3_pot_clima_inv_kw <= 35::numeric THEN 1
                    ELSE 0
                END AS tot_35, 
                CASE
                    WHEN vista_ricerca_impianti.l1_3_pot_clima_inv_kw >= 36::numeric AND vista_ricerca_impianti.l1_3_pot_clima_inv_kw <= 100::numeric THEN 1
                    ELSE 0
                END AS tot_100, 
                CASE
                    WHEN vista_ricerca_impianti.l1_3_pot_clima_inv_kw >= 101::numeric AND vista_ricerca_impianti.l1_3_pot_clima_inv_kw <= 250::numeric THEN 1
                    ELSE 0
                END AS tot_250, 
                CASE
                    WHEN vista_ricerca_impianti.l1_3_pot_clima_inv_kw >= 251::numeric AND vista_ricerca_impianti.l1_3_pot_clima_inv_kw <= 350::numeric THEN 1
                    ELSE 0
                END AS tot_350, 
                CASE
                    WHEN vista_ricerca_impianti.l1_3_pot_clima_inv_kw > 350::numeric THEN 1
                    ELSE 0
                END AS tot_351, 
            vista_ricerca_impianti.l1_3_pot_clima_est_kw, 
                CASE
                    WHEN vista_ricerca_impianti.l1_3_pot_clima_est_kw <= 35::numeric THEN 1
                    ELSE 0
                END AS tot_e_35, 
                CASE
                    WHEN vista_ricerca_impianti.l1_3_pot_clima_est_kw >= 36::numeric AND vista_ricerca_impianti.l1_3_pot_clima_est_kw <= 100::numeric THEN 1
                    ELSE 0
                END AS tot_e_100, 
                CASE
                    WHEN vista_ricerca_impianti.l1_3_pot_clima_est_kw >= 101::numeric AND vista_ricerca_impianti.l1_3_pot_clima_est_kw <= 250::numeric THEN 1
                    ELSE 0
                END AS tot_e_250, 
                CASE
                    WHEN vista_ricerca_impianti.l1_3_pot_clima_est_kw >= 251::numeric AND vista_ricerca_impianti.l1_3_pot_clima_est_kw <= 350::numeric THEN 1
                    ELSE 0
                END AS tot_e_350, 
                CASE
                    WHEN vista_ricerca_impianti.l1_3_pot_clima_est_kw > 350::numeric THEN 1
                    ELSE 0
                END AS tot_e_351
           FROM vista_ricerca_impianti
          WHERE vista_ricerca_impianti.des_stato::text ~~ 'Attivo'::text) elenco
  GROUP BY elenco.denominazione_comune
  ORDER BY elenco.denominazione_comune;

ALTER TABLE od_vista_aggregata_impianto_potenza
  OWNER TO sigit_new;
GRANT ALL ON TABLE od_vista_aggregata_impianto_potenza TO sigit_new;
GRANT SELECT ON TABLE od_vista_aggregata_impianto_potenza TO sigit_new_ro;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE od_vista_aggregata_impianto_potenza TO sigit_new_rw;



CREATE OR REPLACE VIEW od_vista_aggregata_stato_impianto AS 
 SELECT elenco.denominazione_comune AS key_classe, elenco.sigla_provincia, 
    sum(elenco.tot_attivo) AS attivo, sum(elenco.tot_cancellato) AS cancellato, 
    sum(elenco.tot_dismesso) AS dismesso, 
    sum(elenco.tot_sospeso) AS inattivabile_sospeso
   FROM ( SELECT vista_ricerca_impianti.sigla_provincia, 
            vista_ricerca_impianti.denominazione_comune, 
            vista_ricerca_impianti.des_stato, 
                CASE
                    WHEN vista_ricerca_impianti.des_stato::text ~~ 'Attivo'::text THEN 1
                    ELSE 0
                END AS tot_attivo, 
                CASE
                    WHEN vista_ricerca_impianti.des_stato::text ~~ 'Cancellato'::text THEN 1
                    ELSE 0
                END AS tot_cancellato, 
                CASE
                    WHEN vista_ricerca_impianti.des_stato::text ~~ 'Dismesso'::text THEN 1
                    ELSE 0
                END AS tot_dismesso, 
                CASE
                    WHEN vista_ricerca_impianti.des_stato::text ~~ 'Inattivabile/Sospeso'::text THEN 1
                    ELSE 0
                END AS tot_sospeso
           FROM vista_ricerca_impianti) elenco
  GROUP BY elenco.denominazione_comune, elenco.sigla_provincia
  ORDER BY elenco.denominazione_comune;

ALTER TABLE od_vista_aggregata_stato_impianto
  OWNER TO sigit_new;
GRANT ALL ON TABLE od_vista_aggregata_stato_impianto TO sigit_new;
GRANT SELECT ON TABLE od_vista_aggregata_stato_impianto TO sigit_new_ro;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE od_vista_aggregata_stato_impianto TO sigit_new_rw;




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
                            max(gt.data_controllo) AS data_controllo
                           FROM sigit_t_impianto i
                      JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
                 LEFT JOIN vista_dw_sk4_gt gt ON i.codice_impianto = gt.codice_impianto
                WHERE gt.data_dismiss IS NULL
                GROUP BY i.codice_impianto, COALESCE(ui.indirizzo_sitad, ui.indirizzo_non_trovato), ui.civico, i.denominazione_comune, i.denominazione_provincia, ui.l1_2_fk_categoria, ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, gt.id_tipo_componente, gt.progressivo, gt.data_install, gt.des_marca, gt.des_combustibile, gt.des_dettaglio_gt, gt.potenza_termica_kw, gt.rendimento_perc
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
                            max(gf.data_controllo) AS data_controllo
                           FROM sigit_t_impianto i
                      JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
                 LEFT JOIN vista_dw_sk4_gf gf ON i.codice_impianto = gf.codice_impianto
                WHERE gf.data_dismiss IS NULL
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
                    max(sc.data_controllo) AS data_controllo
                   FROM sigit_t_impianto i
              JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
         LEFT JOIN vista_dw_sk4_sc sc ON i.codice_impianto = sc.codice_impianto
        WHERE sc.data_dismiss IS NULL
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
            max(cg.data_controllo) AS data_controllo
           FROM sigit_t_impianto i
      JOIN sigit_t_unita_immobiliare ui ON i.codice_impianto = ui.codice_impianto
   LEFT JOIN vista_dw_sk4_cg cg ON i.codice_impianto = cg.codice_impianto
  WHERE cg.data_dismiss IS NULL
  GROUP BY i.codice_impianto, COALESCE(ui.indirizzo_sitad, ui.indirizzo_non_trovato), ui.civico, i.denominazione_comune, i.denominazione_provincia, ui.l1_2_fk_categoria, ui.l1_2_vol_risc_m3, ui.l1_2_vol_raff_m3, i.l1_3_pot_h2o_kw, i.l1_3_pot_clima_inv_kw, i.l1_3_pot_clima_est_kw, cg.id_tipo_componente, cg.progressivo, cg.data_install, cg.des_marca, cg.des_combustibile, cg.potenza_termica_kw;

ALTER TABLE od_vista_dettaglio_impianti
  OWNER TO sigit_new;
GRANT ALL ON TABLE od_vista_dettaglio_impianti TO sigit_new;
GRANT SELECT ON TABLE od_vista_dettaglio_impianti TO sigit_new_ro;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE od_vista_dettaglio_impianti TO sigit_new_rw;



CREATE OR REPLACE VIEW vista_dati_distributori_forniti AS 
 SELECT pg.denominazione, d.anno_riferimento, 
    sum(d.tot_record_elaborati) AS numero_record
   FROM sigit_t_import_distrib d, sigit_t_persona_giuridica pg
  WHERE pg.id_persona_giuridica = d.fk_persona_giuridica AND d.fk_stato_distrib = 2
  GROUP BY pg.denominazione, d.anno_riferimento
  ORDER BY pg.denominazione, d.anno_riferimento;

ALTER TABLE vista_dati_distributori_forniti
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_dati_distributori_forniti TO sigit_new;
GRANT SELECT ON TABLE vista_dati_distributori_forniti TO sigit_new_ro;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_dati_distributori_forniti TO sigit_new_rw;



CREATE OR REPLACE VIEW vista_dettaglio_dati_distributori AS 
 SELECT DISTINCT sigit_d_combustibile.id_combustibile, 
    sigit_t_dato_distrib.id_dato_distrib, 
    sigit_t_dato_distrib.fk_tipo_contratto, 
    sigit_d_tipo_contratto_distrib.des_tipo_contratto_distrib, 
    sigit_t_dato_distrib.fk_import_distrib, 
    sigit_t_persona_giuridica.denominazione, 
    sigit_t_persona_giuridica.codice_fiscale, 
    sigit_d_stato_distrib.des_stato_distrib, 
    sigit_t_import_distrib.data_inizio_elab, 
    sigit_t_import_distrib.data_fine_elab, 
    sigit_t_import_distrib.data_annullamento, 
    sigit_t_import_distrib.anno_riferimento, 
    sigit_t_import_distrib.tot_record_elaborati, 
    sigit_t_import_distrib.tot_record_scartati, 
    sigit_t_dato_distrib.fk_categoria_util, 
    sigit_d_categoria_util.des_categoria_util, 
    sigit_t_dato_distrib.fk_combustibile, sigit_d_combustibile.des_combustibile, 
    sigit_t_dato_distrib.codice_assenza_catast, 
    sigit_t_dato_distrib.fk_unita_misura, sigit_d_unita_misura.des_unita_misura, 
    sigit_t_dato_distrib.flg_pf_pg, sigit_t_dato_distrib.cognome_denom, 
    sigit_t_dato_distrib.nome, sigit_t_dato_distrib.cf_piva, 
    sigit_t_dato_distrib.anno_rif, sigit_t_dato_distrib.nr_mesi_fattur, 
    sigit_t_dato_distrib.dug, sigit_t_dato_distrib.indirizzo, 
    sigit_t_dato_distrib.civico, sigit_t_dato_distrib.cap, 
    sigit_t_dato_distrib.istat_comune, sigit_t_dato_distrib.pod_pdr, 
    sigit_t_dato_distrib.consumo_anno, sigit_t_dato_distrib.consumo_mensile, 
    sigit_t_dato_distrib.mese_riferimento, 
    sigit_t_dato_distrib.consumo_giornaliero, 
    sigit_t_dato_distrib.giorno_riferimento, sigit_t_dato_distrib.volumetria
   FROM sigit_t_import_distrib, sigit_t_persona_giuridica, sigit_t_dato_distrib, 
    sigit_d_tipo_contratto_distrib, sigit_d_categoria_util, 
    sigit_d_combustibile, sigit_d_unita_misura, sigit_d_stato_distrib
  WHERE sigit_t_import_distrib.id_import_distrib = sigit_t_dato_distrib.fk_import_distrib 
  AND sigit_t_persona_giuridica.id_persona_giuridica = sigit_t_import_distrib.fk_persona_giuridica 
  AND sigit_d_tipo_contratto_distrib.id_tipo_contratto_distrib = sigit_t_dato_distrib.fk_tipo_contratto 
  AND sigit_d_categoria_util.id_categoria_util::text = sigit_t_dato_distrib.fk_categoria_util::text 
  AND sigit_d_combustibile.id_combustibile = sigit_t_dato_distrib.fk_combustibile 
  AND sigit_d_unita_misura.id_unita_misura::text = sigit_t_dato_distrib.fk_unita_misura::text 
  AND sigit_d_stato_distrib.id_stato_distrib = sigit_t_import_distrib.fk_stato_distrib;

ALTER TABLE vista_dettaglio_dati_distributori
  OWNER TO sigit_new;
GRANT ALL ON TABLE vista_dettaglio_dati_distributori TO sigit_new;
GRANT SELECT ON TABLE vista_dettaglio_dati_distributori TO sigit_new_ro;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE vista_dettaglio_dati_distributori TO sigit_new_rw;


