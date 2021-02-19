ALTER TABLE sigit_t_import ADD COLUMN fk_persona_giuridica numeric(6,0);
ALTER TABLE sigit_t_import ADD COLUMN data_invio_mail_manut timestamp;
ALTER TABLE sigit_t_import ADD COLUMN data_invio_mail_assistenza timestamp;

ALTER TABLE sigit_t_import ADD CONSTRAINT  FK_sigit_t_pers_giuridica_07 FOREIGN KEY (fk_persona_giuridica) REFERENCES sigit_t_persona_giuridica(id_persona_giuridica);

INSERT INTO sigit_wrk_config(id_config, chiave_config, valore_config_num, valore_config_char,valore_flag)
    VALUES (7, 'BATCH_MAIL_IND_DEST',null,'assistenza.energia@csi.it',null);
INSERT INTO sigit_wrk_config(id_config, chiave_config, valore_config_num, valore_config_char,valore_flag)
    VALUES (8, 'MAX_RIGHE_RIC_AVZ_IMP',1000,null,null);


ALTER TABLE sigit_wrk_ruolo_funz  ADD COLUMN flg_ric_avz_impianti numeric(1,0);
ALTER TABLE sigit_wrk_ruolo_funz  ADD CONSTRAINT  flg_ric_avz_impianti CHECK (flg_ric_avz_impianti IN (0,1));