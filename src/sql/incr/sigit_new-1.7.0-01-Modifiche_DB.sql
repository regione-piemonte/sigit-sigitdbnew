CREATE TABLE sigit_t_comp4_16_12_2015 as select * from  sigit_t_comp4;


ALTER TABLE sigit_t_comp4 DROP CONSTRAINT fk_sigit_d_marca_03;

ALTER TABLE sigit_t_comp4 DROP CONSTRAINT fk_sigit_d_combustibile_02;

ALTER TABLE sigit_t_comp_gf DROP CONSTRAINT fk_sigit_t_comp4_05;
ALTER TABLE sigit_t_comp_cs DROP CONSTRAINT fk_sigit_t_comp4_03;
ALTER TABLE sigit_t_comp_ag DROP CONSTRAINT fk_sigit_t_comp4_01;
ALTER TABLE sigit_t_comp_cg DROP CONSTRAINT fk_sigit_t_comp4_02;
ALTER TABLE sigit_t_comp_sc DROP CONSTRAINT fk_sigit_t_comp4_06;
ALTER TABLE sigit_t_comp_gt DROP CONSTRAINT fk_sigit_t_comp4_04;


ALTER TABLE sigit_t_comp4 DROP CONSTRAINT pk_sigit_t_comp4;


ALTER TABLE sigit_t_comp_gt    ADD COLUMN data_dismiss date;
ALTER TABLE sigit_t_comp_gt    ADD COLUMN flg_dismissione numeric(1);
ALTER TABLE sigit_t_comp_gt    ADD COLUMN data_ult_mod timestamp;
ALTER TABLE sigit_t_comp_gt    ADD COLUMN utente_ult_mod CHARACTER VARYING(16);
ALTER TABLE sigit_t_comp_gt    ADD COLUMN fk_marca numeric;
ALTER TABLE sigit_t_comp_gt    ADD COLUMN fk_combustibile numeric;
ALTER TABLE sigit_t_comp_gt    ADD COLUMN matricola CHARACTER VARYING(30);
ALTER TABLE sigit_t_comp_gt    ADD COLUMN modello CHARACTER VARYING(300);
ALTER TABLE sigit_t_comp_gt    ADD COLUMN potenza_termica_kw numeric;



ALTER TABLE sigit_t_comp_gf    ADD COLUMN data_dismiss date;
ALTER TABLE sigit_t_comp_gf    ADD COLUMN flg_dismissione numeric(1);
ALTER TABLE sigit_t_comp_gf    ADD COLUMN data_ult_mod timestamp;
ALTER TABLE sigit_t_comp_gf    ADD COLUMN utente_ult_mod CHARACTER VARYING(16);
ALTER TABLE sigit_t_comp_gf    ADD COLUMN fk_marca numeric;
ALTER TABLE sigit_t_comp_gf    ADD COLUMN fk_combustibile numeric;
ALTER TABLE sigit_t_comp_gf    ADD COLUMN matricola CHARACTER VARYING(30);
ALTER TABLE sigit_t_comp_gf    ADD COLUMN modello CHARACTER VARYING(300);
ALTER TABLE sigit_t_comp_gf    ADD COLUMN potenza_termica_kw numeric;



ALTER TABLE sigit_t_comp_cs    ADD COLUMN data_dismiss date;
ALTER TABLE sigit_t_comp_cs    ADD COLUMN flg_dismissione numeric(1);
ALTER TABLE sigit_t_comp_cs    ADD COLUMN data_ult_mod timestamp;
ALTER TABLE sigit_t_comp_cs    ADD COLUMN utente_ult_mod CHARACTER VARYING(16);
ALTER TABLE sigit_t_comp_cs    ADD COLUMN fk_marca numeric;



ALTER TABLE sigit_t_comp_ag    ADD COLUMN data_dismiss date;
ALTER TABLE sigit_t_comp_ag    ADD COLUMN flg_dismissione numeric(1);
ALTER TABLE sigit_t_comp_ag    ADD COLUMN data_ult_mod timestamp;
ALTER TABLE sigit_t_comp_ag    ADD COLUMN utente_ult_mod CHARACTER VARYING(16);
ALTER TABLE sigit_t_comp_ag    ADD COLUMN fk_marca numeric;
ALTER TABLE sigit_t_comp_ag    ADD COLUMN matricola CHARACTER VARYING(30);
ALTER TABLE sigit_t_comp_ag    ADD COLUMN modello CHARACTER VARYING(300);
ALTER TABLE sigit_t_comp_ag    ADD COLUMN potenza_termica_kw numeric;



ALTER TABLE sigit_t_comp_cg    ADD COLUMN data_dismiss date;
ALTER TABLE sigit_t_comp_cg    ADD COLUMN flg_dismissione numeric(1);
ALTER TABLE sigit_t_comp_cg    ADD COLUMN data_ult_mod timestamp;
ALTER TABLE sigit_t_comp_cg    ADD COLUMN utente_ult_mod CHARACTER VARYING(16);
ALTER TABLE sigit_t_comp_cg    ADD COLUMN fk_marca numeric;
ALTER TABLE sigit_t_comp_cg    ADD COLUMN fk_combustibile numeric;
ALTER TABLE sigit_t_comp_cg    ADD COLUMN matricola CHARACTER VARYING(30);
ALTER TABLE sigit_t_comp_cg    ADD COLUMN modello CHARACTER VARYING(300);
ALTER TABLE sigit_t_comp_cg    ADD COLUMN potenza_termica_kw numeric;




ALTER TABLE sigit_t_comp_sc    ADD COLUMN data_dismiss date;
ALTER TABLE sigit_t_comp_sc    ADD COLUMN flg_dismissione numeric(1);
ALTER TABLE sigit_t_comp_sc    ADD COLUMN data_ult_mod timestamp;
ALTER TABLE sigit_t_comp_sc    ADD COLUMN utente_ult_mod CHARACTER VARYING(16);
ALTER TABLE sigit_t_comp_sc    ADD COLUMN fk_marca numeric;
ALTER TABLE sigit_t_comp_sc    ADD COLUMN matricola CHARACTER VARYING(30);
ALTER TABLE sigit_t_comp_sc    ADD COLUMN modello CHARACTER VARYING(300);
ALTER TABLE sigit_t_comp_sc    ADD COLUMN potenza_termica_kw numeric;




update sigit_t_comp_gf a set (data_dismiss,data_ult_mod, utente_ult_mod,matricola,modello,potenza_termica_kw,fk_combustibile,fk_marca) = (b.data_dismiss,b.data_ult_mod, b.utente_ult_mod,b.matricola,b.modello,b.potenza_termica_kw,b.fk_combustibile,b.fk_marca) 
from (select codice_impianto, id_tipo_componente, progressivo, data_install, data_dismiss,data_ult_mod, utente_ult_mod,matricola,modello,potenza_termica_kw,fk_combustibile,fk_marca  from sigit_t_comp4) b 
where a.codice_impianto= b.codice_impianto and
a.id_tipo_componente = b.id_tipo_componente and
a.progressivo =   b.progressivo and a.data_install= b.data_install;

update sigit_t_comp_cs a set (data_dismiss,data_ult_mod, utente_ult_mod,fk_marca) = (b.data_dismiss,b.data_ult_mod, b.utente_ult_mod,b.fk_marca) 
from (select codice_impianto, id_tipo_componente, progressivo, data_install, data_dismiss,data_ult_mod, utente_ult_mod,fk_marca  from sigit_t_comp4) b 
where a.codice_impianto= b.codice_impianto and
a.id_tipo_componente = b.id_tipo_componente and
a.progressivo =   b.progressivo and a.data_install= b.data_install;

update sigit_t_comp_ag a set (data_dismiss,data_ult_mod, utente_ult_mod,matricola,modello,potenza_termica_kw,fk_marca) = (b.data_dismiss,b.data_ult_mod, b.utente_ult_mod,b.matricola,b.modello,b.potenza_termica_kw,b.fk_marca) 
from (select codice_impianto, id_tipo_componente, progressivo, data_install, data_dismiss,data_ult_mod, utente_ult_mod,matricola,modello,potenza_termica_kw,fk_marca  from sigit_t_comp4) b 
where a.codice_impianto= b.codice_impianto and
a.id_tipo_componente = b.id_tipo_componente and
a.progressivo =   b.progressivo and a.data_install= b.data_install;

update sigit_t_comp_cg a set (data_dismiss,data_ult_mod, utente_ult_mod,matricola,modello,potenza_termica_kw,fk_combustibile,fk_marca) = (b.data_dismiss,b.data_ult_mod, b.utente_ult_mod,b.matricola,b.modello,b.potenza_termica_kw,b.fk_combustibile,b.fk_marca) 
from (select codice_impianto, id_tipo_componente, progressivo, data_install, data_dismiss,data_ult_mod, utente_ult_mod,matricola,modello,potenza_termica_kw,fk_combustibile,fk_marca  from sigit_t_comp4) b 
where a.codice_impianto= b.codice_impianto and
a.id_tipo_componente = b.id_tipo_componente and
a.progressivo =   b.progressivo and a.data_install= b.data_install;

update sigit_t_comp_sc a set (data_dismiss,data_ult_mod, utente_ult_mod,matricola,modello,potenza_termica_kw,fk_marca) = (b.data_dismiss,b.data_ult_mod, b.utente_ult_mod,b.matricola,b.modello,b.potenza_termica_kw,b.fk_marca) 
from (select codice_impianto, id_tipo_componente, progressivo, data_install, data_dismiss,data_ult_mod, utente_ult_mod,matricola,modello,potenza_termica_kw,fk_marca  from sigit_t_comp4) b 
where a.codice_impianto= b.codice_impianto and
a.id_tipo_componente = b.id_tipo_componente and
a.progressivo =   b.progressivo and a.data_install= b.data_install;

update sigit_t_comp_gt a set (data_dismiss,data_ult_mod, utente_ult_mod,matricola,modello,potenza_termica_kw,fk_combustibile,fk_marca) = (b.data_dismiss,b.data_ult_mod, b.utente_ult_mod,b.matricola,b.modello,b.potenza_termica_kw,b.fk_combustibile,b.fk_marca) 
from (select codice_impianto, id_tipo_componente, progressivo, data_install, data_dismiss,data_ult_mod, utente_ult_mod,matricola,modello,potenza_termica_kw,fk_combustibile,fk_marca  from sigit_t_comp4) b 
where a.codice_impianto= b.codice_impianto and
a.id_tipo_componente = b.id_tipo_componente and
a.progressivo =   b.progressivo and a.data_install= b.data_install;

drop view  vista_ricerca_impianti ;
drop view  vista_ricerca_comp  ;
drop VIEW vista_allegati;
drop VIEW vista_ricerca_allegati;
drop view  vista_tot_impianto ;
drop view  vista_tot_impianto_prova ;
drop view  vista_comp_ag  ;
drop view  vista_comp_cs  ;
drop view  vista_impianti_imprese;
drop VIEW vista_ricerca_ispezioni;
drop view  vista_comp_gt_dett  ;
drop view  vista_comp_sc_dett ;
drop view  vista_comp_cg_dett  ;
drop view  vista_comp_gf_dett  ;




ALTER TABLE sigit_t_allegato  ALTER COLUMN elenco_apparecchiature TYPE character varying(5000);


ALTER TABLE sigit_t_comp4 DROP COLUMN data_install;
ALTER TABLE sigit_t_comp4 DROP COLUMN data_dismiss;
ALTER TABLE sigit_t_comp4 DROP COLUMN matricola;
ALTER TABLE sigit_t_comp4 DROP COLUMN fk_combustibile;
ALTER TABLE sigit_t_comp4 DROP COLUMN fk_marca;
ALTER TABLE sigit_t_comp4 DROP COLUMN modello;
ALTER TABLE sigit_t_comp4 DROP COLUMN potenza_termica_kw;
ALTER TABLE sigit_t_comp4 DROP COLUMN data_ult_mod;
ALTER TABLE sigit_t_comp4 DROP COLUMN utente_ult_mod;
ALTER TABLE sigit_t_comp4 DROP COLUMN flg_dismissione;


DROP TRIGGER sigit_wrk_log_comp4 ON sigit_t_comp4;

DROP FUNCTION process_sigit_wrk_log_comp4();

delete from sigit_t_comp4;

insert into sigit_t_comp4 (codice_impianto,id_tipo_componente,progressivo) select distinct codice_impianto,id_tipo_componente,progressivo from sigit_t_comp4_16_12_2015;





DROP TRIGGER sigit_wrk_log_comp4;
DROP FUNCTION process_sigit_wrk_log_comp4();


CREATE OR REPLACE FUNCTION process_sigit_wrk_log_comp_ag()
  RETURNS trigger AS
$BODY$
    BEGIN
        IF (TG_OP = 'UPDATE') THEN
            INSERT INTO sigit_wrk_log SELECT NEW.utente_ult_mod, NEW.data_ult_mod, TG_TABLE_NAME,
'codice_impianto'||'='||NEW.codice_impianto||'&'||'id_tipo_componente'||'='||NEW.id_tipo_componente||'&'||'progressivo'||'='||NEW.progressivo,'UPDATE';
            RETURN NEW;
        ELSIF (TG_OP = 'INSERT') THEN
            INSERT INTO sigit_wrk_log SELECT NEW.utente_ult_mod, NEW.data_ult_mod, TG_TABLE_NAME,
'codice_impianto'||'='||NEW.codice_impianto||'&'||'id_tipo_componente'||'='||NEW.id_tipo_componente||'&'||'progressivo'||'='||NEW.progressivo,'INSERT';
            RETURN NEW;
        END IF;
        RETURN NULL; -- result is ignored since this is an AFTER trigger
    END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION process_sigit_wrk_log_comp_ag()
  OWNER TO sigit_new;
GRANT EXECUTE ON FUNCTION process_sigit_wrk_log_comp_ag() TO public;
GRANT EXECUTE ON FUNCTION process_sigit_wrk_log_comp_ag() TO sigit_new;
GRANT EXECUTE ON FUNCTION process_sigit_wrk_log_comp_ag() TO sigit_new_rw;


CREATE TRIGGER sigit_wrk_log_comp_ag
  AFTER INSERT OR UPDATE
  ON sigit_t_comp_ag
  FOR EACH ROW
  EXECUTE PROCEDURE process_sigit_wrk_log_comp_ag();




CREATE OR REPLACE FUNCTION process_sigit_wrk_log_comp_cg()
  RETURNS trigger AS
$BODY$
    BEGIN
        IF (TG_OP = 'UPDATE') THEN
            INSERT INTO sigit_wrk_log SELECT NEW.utente_ult_mod, NEW.data_ult_mod, TG_TABLE_NAME,
'codice_impianto'||'='||NEW.codice_impianto||'&'||'id_tipo_componente'||'='||NEW.id_tipo_componente||'&'||'progressivo'||'='||NEW.progressivo,'UPDATE';
            RETURN NEW;
        ELSIF (TG_OP = 'INSERT') THEN
            INSERT INTO sigit_wrk_log SELECT NEW.utente_ult_mod, NEW.data_ult_mod, TG_TABLE_NAME,
'codice_impianto'||'='||NEW.codice_impianto||'&'||'id_tipo_componente'||'='||NEW.id_tipo_componente||'&'||'progressivo'||'='||NEW.progressivo,'INSERT';
            RETURN NEW;
        END IF;
        RETURN NULL; -- result is ignored since this is an AFTER trigger
    END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION process_sigit_wrk_log_comp_cg()
  OWNER TO sigit_new;
GRANT EXECUTE ON FUNCTION process_sigit_wrk_log_comp_cg() TO public;
GRANT EXECUTE ON FUNCTION process_sigit_wrk_log_comp_cg() TO sigit_new;
GRANT EXECUTE ON FUNCTION process_sigit_wrk_log_comp_cg() TO sigit_new_rw;


CREATE TRIGGER sigit_wrk_log_comp_cg
  AFTER INSERT OR UPDATE
  ON sigit_t_comp_cg
  FOR EACH ROW
  EXECUTE PROCEDURE process_sigit_wrk_log_comp_cg();




CREATE OR REPLACE FUNCTION process_sigit_wrk_log_comp_cs()
  RETURNS trigger AS
$BODY$
    BEGIN
        IF (TG_OP = 'UPDATE') THEN
            INSERT INTO sigit_wrk_log SELECT NEW.utente_ult_mod, NEW.data_ult_mod, TG_TABLE_NAME,
'codice_impianto'||'='||NEW.codice_impianto||'&'||'id_tipo_componente'||'='||NEW.id_tipo_componente||'&'||'progressivo'||'='||NEW.progressivo,'UPDATE';
            RETURN NEW;
        ELSIF (TG_OP = 'INSERT') THEN
            INSERT INTO sigit_wrk_log SELECT NEW.utente_ult_mod, NEW.data_ult_mod, TG_TABLE_NAME,
'codice_impianto'||'='||NEW.codice_impianto||'&'||'id_tipo_componente'||'='||NEW.id_tipo_componente||'&'||'progressivo'||'='||NEW.progressivo,'INSERT';
            RETURN NEW;
        END IF;
        RETURN NULL; -- result is ignored since this is an AFTER trigger
    END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION process_sigit_wrk_log_comp_cs()
  OWNER TO sigit_new;
GRANT EXECUTE ON FUNCTION process_sigit_wrk_log_comp_cs() TO public;
GRANT EXECUTE ON FUNCTION process_sigit_wrk_log_comp_cs() TO sigit_new;
GRANT EXECUTE ON FUNCTION process_sigit_wrk_log_comp_cs() TO sigit_new_rw;


CREATE TRIGGER sigit_wrk_log_comp_cs
  AFTER INSERT OR UPDATE
  ON sigit_t_comp_cs
  FOR EACH ROW
  EXECUTE PROCEDURE process_sigit_wrk_log_comp_cs();




CREATE OR REPLACE FUNCTION process_sigit_wrk_log_comp_gf()
  RETURNS trigger AS
$BODY$
    BEGIN
        IF (TG_OP = 'UPDATE') THEN
            INSERT INTO sigit_wrk_log SELECT NEW.utente_ult_mod, NEW.data_ult_mod, TG_TABLE_NAME,
'codice_impianto'||'='||NEW.codice_impianto||'&'||'id_tipo_componente'||'='||NEW.id_tipo_componente||'&'||'progressivo'||'='||NEW.progressivo,'UPDATE';
            RETURN NEW;
        ELSIF (TG_OP = 'INSERT') THEN
            INSERT INTO sigit_wrk_log SELECT NEW.utente_ult_mod, NEW.data_ult_mod, TG_TABLE_NAME,
'codice_impianto'||'='||NEW.codice_impianto||'&'||'id_tipo_componente'||'='||NEW.id_tipo_componente||'&'||'progressivo'||'='||NEW.progressivo,'INSERT';
            RETURN NEW;
        END IF;
        RETURN NULL; -- result is ignored since this is an AFTER trigger
    END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION process_sigit_wrk_log_comp_gf()
  OWNER TO sigit_new;
GRANT EXECUTE ON FUNCTION process_sigit_wrk_log_comp_gf() TO public;
GRANT EXECUTE ON FUNCTION process_sigit_wrk_log_comp_gf() TO sigit_new;
GRANT EXECUTE ON FUNCTION process_sigit_wrk_log_comp_gf() TO sigit_new_rw;


CREATE TRIGGER sigit_wrk_log_comp_gf
  AFTER INSERT OR UPDATE
  ON sigit_t_comp_gf
  FOR EACH ROW
  EXECUTE PROCEDURE process_sigit_wrk_log_comp_gf();




CREATE OR REPLACE FUNCTION process_sigit_wrk_log_comp_gt()
  RETURNS trigger AS
$BODY$
    BEGIN
        IF (TG_OP = 'UPDATE') THEN
            INSERT INTO sigit_wrk_log SELECT NEW.utente_ult_mod, NEW.data_ult_mod, TG_TABLE_NAME,
'codice_impianto'||'='||NEW.codice_impianto||'&'||'id_tipo_componente'||'='||NEW.id_tipo_componente||'&'||'progressivo'||'='||NEW.progressivo,'UPDATE';
            RETURN NEW;
        ELSIF (TG_OP = 'INSERT') THEN
            INSERT INTO sigit_wrk_log SELECT NEW.utente_ult_mod, NEW.data_ult_mod, TG_TABLE_NAME,
'codice_impianto'||'='||NEW.codice_impianto||'&'||'id_tipo_componente'||'='||NEW.id_tipo_componente||'&'||'progressivo'||'='||NEW.progressivo,'INSERT';
            RETURN NEW;
        END IF;
        RETURN NULL; -- result is ignored since this is an AFTER trigger
    END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION process_sigit_wrk_log_comp_gt()
  OWNER TO sigit_new;
GRANT EXECUTE ON FUNCTION process_sigit_wrk_log_comp_gt() TO public;
GRANT EXECUTE ON FUNCTION process_sigit_wrk_log_comp_gt() TO sigit_new;
GRANT EXECUTE ON FUNCTION process_sigit_wrk_log_comp_gt() TO sigit_new_rw;


CREATE TRIGGER sigit_wrk_log_comp_gt
  AFTER INSERT OR UPDATE
  ON sigit_t_comp_gt
  FOR EACH ROW
  EXECUTE PROCEDURE process_sigit_wrk_log_comp_gt();




CREATE OR REPLACE FUNCTION process_sigit_wrk_log_comp_sc()
  RETURNS trigger AS
$BODY$
    BEGIN
        IF (TG_OP = 'UPDATE') THEN
            INSERT INTO sigit_wrk_log SELECT NEW.utente_ult_mod, NEW.data_ult_mod, TG_TABLE_NAME,
'codice_impianto'||'='||NEW.codice_impianto||'&'||'id_tipo_componente'||'='||NEW.id_tipo_componente||'&'||'progressivo'||'='||NEW.progressivo,'UPDATE';
            RETURN NEW;
        ELSIF (TG_OP = 'INSERT') THEN
            INSERT INTO sigit_wrk_log SELECT NEW.utente_ult_mod, NEW.data_ult_mod, TG_TABLE_NAME,
'codice_impianto'||'='||NEW.codice_impianto||'&'||'id_tipo_componente'||'='||NEW.id_tipo_componente||'&'||'progressivo'||'='||NEW.progressivo,'INSERT';
            RETURN NEW;
        END IF;
        RETURN NULL; -- result is ignored since this is an AFTER trigger
    END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION process_sigit_wrk_log_comp_sc()
  OWNER TO sigit_new;
GRANT EXECUTE ON FUNCTION process_sigit_wrk_log_comp_sc() TO public;
GRANT EXECUTE ON FUNCTION process_sigit_wrk_log_comp_sc() TO sigit_new;
GRANT EXECUTE ON FUNCTION process_sigit_wrk_log_comp_sc() TO sigit_new_rw;


CREATE TRIGGER sigit_wrk_log_comp_sc
  AFTER INSERT OR UPDATE
  ON sigit_t_comp_sc
  FOR EACH ROW
  EXECUTE PROCEDURE process_sigit_wrk_log_comp_sc();




ALTER TABLE sigit_t_comp4
  ADD CONSTRAINT pk_sigit_t_comp4 PRIMARY KEY(codice_impianto, id_tipo_componente, progressivo);




ALTER TABLE sigit_t_comp_cs
  ADD CONSTRAINT fk_sigit_t_comp4_03 FOREIGN KEY (codice_impianto, id_tipo_componente, progressivo)
      REFERENCES sigit_t_comp4 (codice_impianto, id_tipo_componente, progressivo) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;


ALTER TABLE sigit_t_comp_ag
  ADD CONSTRAINT fk_sigit_t_comp4_01 FOREIGN KEY (codice_impianto, id_tipo_componente, progressivo)
      REFERENCES sigit_t_comp4 (codice_impianto, id_tipo_componente, progressivo) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;


ALTER TABLE sigit_t_comp_cg
  ADD CONSTRAINT fk_sigit_t_comp4_02 FOREIGN KEY (codice_impianto, id_tipo_componente, progressivo)
      REFERENCES sigit_t_comp4 (codice_impianto, id_tipo_componente, progressivo) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;


ALTER TABLE sigit_t_comp_sc
  ADD CONSTRAINT fk_sigit_t_comp4_06 FOREIGN KEY (codice_impianto, id_tipo_componente, progressivo)
      REFERENCES sigit_t_comp4 (codice_impianto, id_tipo_componente, progressivo) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;


ALTER TABLE sigit_t_comp_gt
  ADD CONSTRAINT fk_sigit_t_comp4_04 FOREIGN KEY (codice_impianto, id_tipo_componente, progressivo)
      REFERENCES sigit_t_comp4 (codice_impianto, id_tipo_componente, progressivo) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;


ALTER TABLE sigit_t_comp_gf
  ADD CONSTRAINT fk_sigit_t_comp4_05 FOREIGN KEY (codice_impianto, id_tipo_componente, progressivo)
      REFERENCES sigit_t_comp4 (codice_impianto, id_tipo_componente, progressivo) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION;




CREATE TABLE sigit_r_comp4_manut
(
	id_r_comp4_manut      INTEGER  NOT NULL ,
	fk_persona_giuridica  NUMERIC(6)  NOT NULL ,
	codice_impianto       NUMERIC  NOT NULL ,
	id_tipo_componente    CHARACTER VARYING(5)  NOT NULL ,
	progressivo           NUMERIC(3)  NOT NULL ,
	data_inizio           DATE  NULL ,
	data_fine             DATE  NULL ,
	data_ult_mod          TIMESTAMP  NOT NULL ,
	utente_ult_mod        CHARACTER VARYING(16)  NOT NULL ,
	fk_ruolo				NUMERIC  NOT NULL
);



ALTER TABLE sigit_r_comp4_manut
	ADD CONSTRAINT  PK_sigit_r_comp4_manut PRIMARY KEY (id_r_comp4_manut);



ALTER TABLE sigit_r_comp4_manut
	ADD CONSTRAINT  FK_sigit_t_pers_giuridica_08 FOREIGN KEY (fk_persona_giuridica) REFERENCES sigit_t_persona_giuridica(id_persona_giuridica);



ALTER TABLE sigit_r_comp4_manut
	ADD CONSTRAINT  fk_sigit_t_comp4_07 FOREIGN KEY (codice_impianto,id_tipo_componente,progressivo) REFERENCES sigit_t_comp4(codice_impianto,id_tipo_componente,progressivo);



ALTER TABLE sigit_r_comp4_manut
	ADD CONSTRAINT  fk_sigit_d_ruolo_03 FOREIGN KEY (fk_ruolo) REFERENCES sigit_d_ruolo(id_ruolo);


GRANT SELECT, UPDATE, INSERT, TRUNCATE, DELETE ON TABLE sigit_r_comp4_manut TO sigit_new_rw;



CREATE SEQUENCE seq_r_comp4_manut INCREMENT 1  MINVALUE 1  MAXVALUE 9223372036854775807  START 1  CACHE 1;

GRANT SELECT, UPDATE ON TABLE seq_r_comp4_manut TO sigit_new_rw;





CREATE TABLE sigit_r_comp4manut_all
(
	id_allegato           NUMERIC  NOT NULL ,
	id_r_comp4_manut      INTEGER  NOT NULL );

ALTER TABLE sigit_r_comp4manut_all
	ADD CONSTRAINT  PK_sigit_r_comp4manut_all PRIMARY KEY (id_allegato,id_r_comp4_manut);

ALTER TABLE sigit_r_comp4manut_all
	ADD CONSTRAINT  fk_sigit_t_allegato_08 FOREIGN KEY (id_allegato) REFERENCES sigit_t_allegato(id_allegato);

ALTER TABLE sigit_r_comp4manut_all
	ADD CONSTRAINT  fk_sigit_r_comp4_manut_01 FOREIGN KEY (id_r_comp4_manut) REFERENCES sigit_r_comp4_manut(id_r_comp4_manut);


ALTER TABLE sigit_d_tipo_componente  ADD column  flg_visualizza NUMERIC(1)   DEFAULT  1 NULL  CONSTRAINT  dom88_0_1 CHECK (flg_visualizza IN (0,1));


INSERT INTO sigit_d_tipo_componente(id_tipo_componente, des_tipo_componente, flg_visualizza) VALUES ('ND', 'ND', 0);

ALTER TABLE sigit_t_allegato  ADD COLUMN data_respinta date;
   
   
ALTER TABLE sigit_t_dett_tipo1 ADD COLUMN e_bacharach_min1 numeric ;
ALTER TABLE sigit_t_dett_tipo1 ADD COLUMN e_bacharach_med1 numeric ;
ALTER TABLE sigit_t_dett_tipo1 ADD COLUMN e_bacharach_max1 numeric ;

update sigit_t_dett_tipo1 set e_bacharach_min1 = replace (e_bacharach_min, ',', '.') :: numeric;
update sigit_t_dett_tipo1 set e_bacharach_med1 = replace (e_bacharach_med, ',', '.') :: numeric;
update sigit_t_dett_tipo1 set e_bacharach_max1 = replace (e_bacharach_max, ',', '.') :: numeric;

ALTER TABLE sigit_t_dett_tipo1 DROP COLUMN e_bacharach_min;
ALTER TABLE sigit_t_dett_tipo1 DROP COLUMN e_bacharach_med;
ALTER TABLE sigit_t_dett_tipo1 DROP COLUMN e_bacharach_max;


ALTER TABLE sigit_t_dett_tipo1 RENAME e_bacharach_min1  TO e_bacharach_min;
ALTER TABLE sigit_t_dett_tipo1 RENAME e_bacharach_med1  TO e_bacharach_med;
ALTER TABLE sigit_t_dett_tipo1 RENAME e_bacharach_max1  TO e_bacharach_max;


ALTER TABLE sigit_t_allegato
   ALTER COLUMN fk_imp_ruolo_pfpg DROP NOT NULL;
