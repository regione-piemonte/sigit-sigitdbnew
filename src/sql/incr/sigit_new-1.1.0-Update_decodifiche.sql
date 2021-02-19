update SIGIT_D_TIPO_DOCUMENTO set des_tipo_documento = 'F' WHERE id_tipo_documento=1;
update SIGIT_D_TIPO_DOCUMENTO set des_tipo_documento = 'G' WHERE id_tipo_documento=2;
update SIGIT_D_TIPO_DOCUMENTO set des_tipo_documento = 'Libretto' WHERE id_tipo_documento=7;
update SIGIT_D_TIPO_DOCUMENTO set des_tipo_documento = 'Ispezione' WHERE id_tipo_documento=8;
update SIGIT_D_TIPO_DOCUMENTO set des_tipo_documento = 'Tipo 1 (Allegato II, DM 10/02/2014)' WHERE id_tipo_documento=3;
update SIGIT_D_TIPO_DOCUMENTO set des_tipo_documento = 'Tipo 2 (Allegato III, DM 10/02/2014)' WHERE id_tipo_documento=4;
update SIGIT_D_TIPO_DOCUMENTO set des_tipo_documento = 'Tipo 3 (Allegato IV, DM 10/02/2014)' WHERE id_tipo_documento=5;
update SIGIT_D_TIPO_DOCUMENTO set des_tipo_documento = 'Tipo 4 (Allegato V, DM 10/02/2014)' WHERE id_tipo_documento=6;


update sigit_d_dm37_2008 set des_tipo_dm37_2008='A-diploma di laurea in materia tecnica specifica ...' where tipo_dm37_2008='A';
update sigit_d_dm37_2008 set des_tipo_dm37_2008='B-diploma o qualifica cons. al termine della sc. secondaria ...' where tipo_dm37_2008='B';
update sigit_d_dm37_2008 set des_tipo_dm37_2008='C-titolo o attestato conseguito ai sensi della legislazione  ...' where tipo_dm37_2008='C';
update sigit_d_dm37_2008 set des_tipo_dm37_2008='D-prestazione lavorativa svolta alle dirette dipendenze ...' where tipo_dm37_2008='D';



update SIGIT_D_COMBUSTIBILE set des_combustibile='Tronchetti' where id_combustibile=6;
update SIGIT_D_COMBUSTIBILE set des_combustibile='Carbone' where id_combustibile=7;

INSERT INTO sigit_d_combustibile(id_combustibile, des_combustibile) VALUES (8,'Cippato');
INSERT INTO sigit_d_combustibile(id_combustibile, des_combustibile) VALUES (9,'Altra biomassa solida');
INSERT INTO sigit_d_combustibile(id_combustibile, des_combustibile) VALUES (10,'Biomassa liquida');
INSERT INTO sigit_d_combustibile(id_combustibile, des_combustibile) VALUES (11,'Biomassa gassosa');


update SIGIT_D_RUOLO set des_ruolo = 'Amministratore_OLD',ruolo_funz = 'AMMINISTRATORE_OLD'
where id_ruolo=1;

update SIGIT_D_RUOLO set des_ruolo = 'Ispettore',ruolo_funz = 'ISPETTORE'
where id_ruolo=2;

update SIGIT_D_RUOLO set des_ruolo = 'Installatore',ruolo_funz = 'INSTALLATORE'
where id_ruolo=3;

update SIGIT_D_RUOLO set des_ruolo = 'Proprietario',ruolo_funz = 'RESPONSABILE'
where id_ruolo=4;

update SIGIT_D_RUOLO set des_ruolo = 'Occupante',ruolo_funz = 'RESPONSABILE'
where id_ruolo=5;

update SIGIT_D_RUOLO set des_ruolo = 'Manutentore - Allegato Tipo 1',ruolo_funz = 'MANUTENTORE'
where id_ruolo=6;

update SIGIT_D_RUOLO set des_ruolo = 'Manutentore - Allegato Tipo 2',ruolo_funz = 'MANUTENTORE'
where id_ruolo=7;

update SIGIT_D_RUOLO set des_ruolo = 'Manutentore - Allegato Tipo 3',ruolo_funz = 'MANUTENTORE'
where id_ruolo=8;

update SIGIT_D_RUOLO set des_ruolo = 'Manutentore - Allegato Tipo 4',ruolo_funz = 'MANUTENTORE'
where id_ruolo=9;

update SIGIT_D_RUOLO set des_ruolo = 'Proprietario',ruolo_funz = 'RESPONSABILE IMPRESA'
where id_ruolo=10;

update SIGIT_D_RUOLO set des_ruolo = 'Occupante',ruolo_funz = 'RESPONSABILE IMPRESA'
where id_ruolo=11;

INSERT INTO sigit_d_ruolo(id_ruolo, des_ruolo, ruolo_funz) VALUES (12, 'Amministratore', 'RESPONSABILE IMPRESA');
INSERT INTO sigit_d_ruolo(id_ruolo, des_ruolo, ruolo_funz) VALUES (13, 'Amministratore', 'RESPONSABILE');



INSERT INTO sigit_d_dettaglio_vm(id_dettaglio_vm, des_dettaglio_vm) VALUES (1,'Sola estrazione');
INSERT INTO sigit_d_dettaglio_vm(id_dettaglio_vm, des_dettaglio_vm) VALUES (2,'Flusso doppio con recupero tramite scambiatore a flussi incrociati');
INSERT INTO sigit_d_dettaglio_vm(id_dettaglio_vm, des_dettaglio_vm) VALUES (3,'Flusso doppio con recupero termodinamico');

INSERT INTO sigit_d_tipo_consumo(id_tipo_consumo, des_tipo_consumo) VALUES ('14.1', 'Combustibile');
INSERT INTO sigit_d_tipo_consumo(id_tipo_consumo, des_tipo_consumo) VALUES ('14.2', 'Energia elettrica');
INSERT INTO sigit_d_tipo_consumo(id_tipo_consumo, des_tipo_consumo) VALUES ('14.3', 'Acqua');


INSERT INTO sigit_d_unita_misura(id_unita_misura, des_unita_misura) VALUES (1, 'litri');
INSERT INTO sigit_d_unita_misura(id_unita_misura, des_unita_misura) VALUES (2, 'kg');
INSERT INTO sigit_d_unita_misura(id_unita_misura, des_unita_misura) VALUES (3, 'm3');



INSERT INTO sigit_d_tipo_componente(id_tipo_componente) VALUES ('AC');
INSERT INTO sigit_d_tipo_componente(id_tipo_componente) VALUES ('CI');
INSERT INTO sigit_d_tipo_componente(id_tipo_componente) VALUES ('PO');
INSERT INTO sigit_d_tipo_componente(id_tipo_componente) VALUES ('RCX');
INSERT INTO sigit_d_tipo_componente(id_tipo_componente) VALUES ('RV');
INSERT INTO sigit_d_tipo_componente(id_tipo_componente) VALUES ('SCX');
INSERT INTO sigit_d_tipo_componente(id_tipo_componente) VALUES ('SR');
INSERT INTO sigit_d_tipo_componente(id_tipo_componente) VALUES ('TE');
INSERT INTO sigit_d_tipo_componente(id_tipo_componente) VALUES ('UT');
INSERT INTO sigit_d_tipo_componente(id_tipo_componente) VALUES ('VM');
INSERT INTO sigit_d_tipo_componente(id_tipo_componente) VALUES ('VR');
INSERT INTO sigit_d_tipo_componente(id_tipo_componente) VALUES ('VX');

INSERT INTO sigit_d_tipo_intervento(id_tipo_intervento, des_tipo_intervento) VALUES (0, 'Non valorizzato');


update SIGIT_D_STATO_IMP set des_stato='Inattivabile/Sospeso' where id_stato=3;

update sigit_d_combustibile set des_combustibile='Cippato' where id_combustibile=7;
update sigit_d_combustibile set des_combustibile='Carbone' where id_combustibile=8;

