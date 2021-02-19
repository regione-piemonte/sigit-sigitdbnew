CREATE TABLE sigit_r_user_elenco_ws
(
	id_user_ws            INTEGER  NOT NULL ,
	id_elenco_ws          INTEGER  NOT NULL 
);



ALTER TABLE sigit_r_user_elenco_ws
	ADD CONSTRAINT  PK_sigit_r_user_elenco_ws PRIMARY KEY (id_user_ws,id_elenco_ws);



CREATE TABLE sigit_t_elenco_ws
(
	id_elenco_ws          INTEGER  NOT NULL ,
	descrizione_ws        CHARACTER VARYING(500)  NOT NULL 
);



ALTER TABLE sigit_t_elenco_ws
	ADD CONSTRAINT  PK_sigit_t_elenco_ws PRIMARY KEY (id_elenco_ws);



CREATE TABLE sigit_t_user_ws
(
	id_user_ws            INTEGER  NOT NULL ,
	user_ws               CHARACTER VARYING(50)  NOT NULL ,
	pwd_ws                CHARACTER VARYING(20)  NOT NULL 
);



ALTER TABLE sigit_t_user_ws
	ADD CONSTRAINT  PK_sigit_t_user_ws PRIMARY KEY (id_user_ws);



ALTER TABLE sigit_r_user_elenco_ws
	ADD CONSTRAINT  fk_sigit_t_user_ws_01 FOREIGN KEY (id_user_ws) REFERENCES sigit_t_user_ws(id_user_ws);



ALTER TABLE sigit_r_user_elenco_ws
	ADD CONSTRAINT  fk_sigit_t_elenco_ws_01 FOREIGN KEY (id_elenco_ws) REFERENCES sigit_t_elenco_ws(id_elenco_ws);



GRANT SELECT,UPDATE,INSERT,DELETE,TRUNCATE ON ALL TABLES IN SCHEMA sigit_new TO sigit_new_rw;


