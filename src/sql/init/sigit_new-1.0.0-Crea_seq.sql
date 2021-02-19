CREATE SEQUENCE seq_r_imp_ruolo_pfpg
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE seq_r_imp_ruolo_pfpg
  OWNER TO sigit_new;

CREATE SEQUENCE seq_t_allegato
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE seq_t_allegato
  OWNER TO sigit_new;

CREATE SEQUENCE seq_t_codice_impianto
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE seq_t_codice_impianto
  OWNER TO sigit_new;

CREATE SEQUENCE seq_t_comp_br_rc
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE seq_t_comp_br_rc
  OWNER TO sigit_new;
  
  CREATE SEQUENCE seq_t_dett_tipo1
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE seq_t_dett_tipo1
  OWNER TO sigit_new;

  
  CREATE SEQUENCE seq_t_dett_tipo2
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE seq_t_dett_tipo2
  OWNER TO sigit_new;

  
  CREATE SEQUENCE seq_t_dett_tipo3
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE seq_t_dett_tipo3
  OWNER TO sigit_new;
  
  
  CREATE SEQUENCE seq_t_dett_tipo4
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE seq_t_dett_tipo4
  OWNER TO sigit_new;
  
  
  CREATE SEQUENCE seq_t_libretto
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE seq_t_libretto
  OWNER TO sigit_new;
  
  
  CREATE SEQUENCE seq_t_numero_bollino
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE seq_t_numero_bollino
  OWNER TO sigit_new;
  
  
  CREATE SEQUENCE seq_t_persona_fisica
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE seq_t_persona_fisica
  OWNER TO sigit_new;
  
  CREATE SEQUENCE seq_t_persona_giuridica
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE seq_t_persona_giuridica
  OWNER TO sigit_new;


CREATE SEQUENCE seq_t_transazione_boll
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE seq_t_transazione_boll
  OWNER TO sigit_new;

CREATE SEQUENCE seq_t_transazione_imp
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE seq_t_transazione_imp
  OWNER TO sigit_new;

CREATE SEQUENCE seq_t_unita_immobiliare
  INCREMENT 1
  MINVALUE 1
  MAXVALUE 9223372036854775807
  START 1
  CACHE 1;
ALTER TABLE seq_t_unita_immobiliare
  OWNER TO sigit_new;
  







SELECT SETVAL('seq_t_codice_impianto',(select max(codice_impianto) from sigit_t_codice_imp)::int4,TRUE);

SELECT SETVAL('seq_t_persona_fisica',(select max(id_persona_fisica) from sigit_t_persona_fisica)::int4,TRUE);

SELECT SETVAL('seq_t_persona_giuridica',(select max(id_persona_giuridica) from sigit_t_persona_giuridica)::int4,TRUE);

SELECT SETVAL('seq_t_transazione_boll',(select max(id_transazione_boll) from sigit_t_transazione_boll)::int4,TRUE);

SELECT SETVAL('seq_t_transazione_imp',(select max(id_transazione) from sigit_t_transazione_imp)::int4,TRUE);


