ALTER TABLE sigit_r_pf_ruolo_pa
	DROP CONSTRAINT  PK_sigit_r_pf_ruolo_pa;
	
ALTER TABLE sigit_r_pf_ruolo_pa
	ADD CONSTRAINT  PK_sigit_r_pf_ruolo_pa PRIMARY KEY (id_persona_fisica,id_ruolo_pa,istat_abilitazione,data_inizio);
