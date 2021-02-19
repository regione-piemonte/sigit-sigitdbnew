-- Migrazione proprietari --
select *
from sigit_d_ruolo;

--4 e 10 si duplicano diventando rispettivamente 15 e 16

select count(*)
from sigit_r_imp_ruolo_pfpg srirp
where fk_ruolo in (4,10);
-- svil 36399
-- test 678833

select count(*)
from sigit_t_impianto sti;
-- test 1037252

select count(*)
from sigit_t_impianto sti, sigit_r_imp_ruolo_pfpg srirp
where sti.codice_impianto = srirp.codice_impianto
and fk_ruolo in (4,10)
and srirp.data_fine is null
-- svil 36105
-- test 656406

create table sigit_r_imp_ruolo_pfpg_pre_ril_1_16 as
select *
from sigit_r_imp_ruolo_pfpg;
-- svil 369303
-- test 2098894

select row(), fk_ruolo, case when fk_ruolo = 4 then 15 else 16 end ruolo_new, srirp.codice_impianto, srirp.data_inizio, srirp.data_fine,
	srirp.fk_persona_fisica, srirp.fk_persona_giuridica, now(), 'TRATTAMENTO DATI', srirp.flg_primo_caricatore
from sigit_t_impianto sti, sigit_r_imp_ruolo_pfpg srirp
where sti.codice_impianto = srirp.codice_impianto
and fk_ruolo in (4,10)
and srirp.data_fine is null

insert into sigit_r_imp_ruolo_pfpg (id_imp_ruolo_pfpg, fk_ruolo, 
	codice_impianto, data_inizio, data_fine,
	fk_persona_fisica, fk_persona_giuridica, data_ult_mod, utente_ult_mod, flg_primo_caricatore)
select nextval('seq_r_imp_ruolo_pfpg'), case when fk_ruolo = 4 then 15 else 16 end ruolo_new, 
	srirp.codice_impianto, srirp.data_inizio, srirp.data_fine,
	srirp.fk_persona_fisica, srirp.fk_persona_giuridica, now(), 'TRATTAMENTO DATI', srirp.flg_primo_caricatore
from sigit_t_impianto sti, sigit_r_imp_ruolo_pfpg srirp
where sti.codice_impianto = srirp.codice_impianto
and fk_ruolo in (4,10)
and srirp.data_fine is null;
-- test 656405

select count(*)
from sigit_r_imp_ruolo_pfpg;
-- svil 369303 + 36105 = 405408
-- test 2098894 + 656405 = 2755299

-- step riconduzione proprietari non presenti su sigit_r_imp_ruolo_pfpg
-- ma presenti su impianto

select count(*)
from sigit_t_impianto 
where proprietario is not null and TRIM(proprietario)<>'';
-- svil 2610
-- test 201398

select count(*)
from sigit_t_impianto i
where proprietario is not null and TRIM(proprietario)<>''
and i.codice_impianto in (
	select srirp.codice_impianto
--	from sigit_r_imp_ruolo_pfpg_pre_ril_1_16 srirp
	from sigit_r_imp_ruolo_pfpg srirp
	where srirp.codice_impianto = i.codice_impianto
	and srirp.fk_ruolo in (15,16)
	and srirp.data_fine is null
);
-- svil 2039
-- test 158037

select count(*)
from sigit_t_impianto i
where proprietario is not null and TRIM(proprietario)<>''
and i.codice_impianto not in (
	select srirp.codice_impianto
--	from sigit_r_imp_ruolo_pfpg_pre_ril_1_16 srirp
	from sigit_r_imp_ruolo_pfpg srirp
	where srirp.codice_impianto = i.codice_impianto
	and srirp.fk_ruolo in (15,16)
	and srirp.data_fine is null
);
-- test 201398 - 158037 = 43361 impianti con proprietario senza record su sigit_r_imp_ruolo_pfpg

select count(*)
from sigit_t_persona_giuridica;
-- dev 5999
-- test 57021
-- prod 58679

-- errata
select i.codice_impianto, i.proprietario, pg.id_persona_giuridica, pg.denominazione
from sigit_t_impianto i, sigit_t_persona_giuridica pg
where proprietario is not null and TRIM(proprietario)<>''
and i.codice_impianto not in (
	select srirp.codice_impianto
--	from sigit_r_imp_ruolo_pfpg_pre_ril_1_16 srirp
	from sigit_r_imp_ruolo_pfpg srirp
	where srirp.codice_impianto = i.codice_impianto
	and srirp.fk_ruolo in (15,16)
	and srirp.data_fine is null
)
and UPPER(replace(i.proprietario,' ','')) = UPPER(replace(pg.denominazione,' ',''))
and UPPER(replace(pg.denominazione,' ','')) in
( 
select UPPER(replace(pg.denominazione,' ',''))
from sigit_t_impianto i, sigit_t_persona_giuridica pg
where i.proprietario is not null 
and TRIM(i.proprietario)<>''
and UPPER(replace(i.proprietario,' ','')) = UPPER(replace(pg.denominazione,' ',''))
group by UPPER(replace(pg.denominazione,' ',''))
having count(*) = 1
)
-- test 805 soggetti PG

-- ultima revisione 
select i.codice_impianto, i.proprietario, pg.id_persona_giuridica, pg.denominazione
from sigit_t_impianto i, sigit_t_persona_giuridica pg
where proprietario is not null and TRIM(proprietario)<>''
and i.codice_impianto not in (
	select srirp.codice_impianto
--	from sigit_r_imp_ruolo_pfpg_pre_ril_1_16 srirp
	from sigit_r_imp_ruolo_pfpg srirp
	where srirp.codice_impianto = i.codice_impianto
	and srirp.fk_ruolo in (15,16)
	and srirp.data_fine is null
)
and UPPER(replace(i.proprietario,' ','')) = UPPER(replace(pg.denominazione,' ',''))
and UPPER(replace(pg.denominazione,' ','')) in
( 
select UPPER(replace(pg.denominazione,' ',''))
from sigit_t_persona_giuridica pg
group by UPPER(replace(pg.denominazione,' ',''))
having count(*) =1
)
-- test 2478 soggetti PG

-- inserimento persone giuridiche mancanti
insert into sigit_r_imp_ruolo_pfpg (id_imp_ruolo_pfpg, fk_ruolo, codice_impianto, data_inizio, data_fine, 
	fk_persona_fisica, fk_persona_giuridica, data_ult_mod, utente_ult_mod, flg_primo_caricatore)
select nextval('seq_r_imp_ruolo_pfpg'), 16, i.codice_impianto, now(), NULL, 
	NULL, pg.id_persona_giuridica, now(), 'TRATTAMENTO DATI', 0
from sigit_t_impianto i, sigit_t_persona_giuridica pg
where proprietario is not null and TRIM(proprietario)<>''
and i.codice_impianto not in (
	select srirp.codice_impianto
--	from sigit_r_imp_ruolo_pfpg_pre_ril_1_16 srirp
	from sigit_r_imp_ruolo_pfpg srirp
	where srirp.codice_impianto = i.codice_impianto
	and srirp.fk_ruolo in (15,16)
	and srirp.data_fine is null
)
and UPPER(replace(i.proprietario,' ','')) = UPPER(replace(pg.denominazione,' ',''))
and UPPER(replace(pg.denominazione,' ','')) in
( 
select UPPER(replace(pg.denominazione,' ',''))
from sigit_t_persona_giuridica pg
group by UPPER(replace(pg.denominazione,' ',''))
having count(*) =1
)
;

select count(*)
from sigit_r_imp_ruolo_pfpg;
-- test 2755305 + 2478 = 2757783 

select count(*)
from sigit_t_persona_fisica;
-- dev 57505
-- test 769624

select i.codice_impianto, i.proprietario, pf.id_persona_fisica, pf.cognome, pf.nome
from sigit_t_impianto i, sigit_t_persona_fisica pf
where proprietario is not null and TRIM(proprietario)<>''
and i.codice_impianto not in (
	select srirp.codice_impianto
	from sigit_r_imp_ruolo_pfpg srirp
	where srirp.codice_impianto = i.codice_impianto
	and srirp.fk_ruolo in (15,16)
	and srirp.data_fine is null
)
and UPPER(replace(i.proprietario,' ','')) = UPPER(replace(TRIM(pf.cognome),' ',''))||UPPER(replace(TRIM(pf.nome),' ',''))
and pf.nome is not null and TRIM(pf.nome)<>'' 
and pf.cognome is not null and TRIM(pf.cognome)<>'' 
and UPPER(replace(TRIM(pf.cognome),' ',''))||UPPER(replace(TRIM(pf.nome),' ','')) in (
select UPPER(replace(TRIM(pf.cognome),' ',''))||UPPER(replace(TRIM(pf.nome),' ',''))
from sigit_t_persona_fisica pf
where pf.nome is not null and TRIM(pf.nome)<>'' 
and pf.cognome is not null and TRIM(pf.cognome)<>'' 
group by UPPER(replace(TRIM(pf.cognome),' ',''))||UPPER(replace(TRIM(pf.nome),' ',''))
having count(*) = 1
)
-- test 11189 trovato PF cognome e nome

-- inserimento persone fisiche mancanti trovate x cognome e nome
insert into sigit_r_imp_ruolo_pfpg (id_imp_ruolo_pfpg, fk_ruolo, codice_impianto, data_inizio, data_fine, 
	fk_persona_fisica, fk_persona_giuridica, data_ult_mod, utente_ult_mod, flg_primo_caricatore)
select nextval('seq_r_imp_ruolo_pfpg'), 15, i.codice_impianto, now(), NULL, 
	pf.id_persona_fisica, NULL, now(), 'TRATTAMENTO DATI', 0
from sigit_t_impianto i, sigit_t_persona_fisica pf
where proprietario is not null and TRIM(proprietario)<>''
and i.codice_impianto not in (
	select srirp.codice_impianto
	from sigit_r_imp_ruolo_pfpg srirp
	where srirp.codice_impianto = i.codice_impianto
	and srirp.fk_ruolo in (15,16)
	and srirp.data_fine is null
)
and UPPER(replace(i.proprietario,' ','')) = UPPER(replace(TRIM(pf.cognome),' ',''))||UPPER(replace(TRIM(pf.nome),' ',''))
and pf.nome is not null and TRIM(pf.nome)<>'' 
and pf.cognome is not null and TRIM(pf.cognome)<>'' 
and UPPER(replace(TRIM(pf.cognome),' ',''))||UPPER(replace(TRIM(pf.nome),' ','')) in (
select UPPER(replace(TRIM(pf.cognome),' ',''))||UPPER(replace(TRIM(pf.nome),' ',''))
from sigit_t_persona_fisica pf
where pf.nome is not null and TRIM(pf.nome)<>'' 
and pf.cognome is not null and TRIM(pf.cognome)<>'' 
group by UPPER(replace(TRIM(pf.cognome),' ',''))||UPPER(replace(TRIM(pf.nome),' ',''))
having count(*) = 1
)
;

select count(*)
from sigit_r_imp_ruolo_pfpg;
-- test 2757783 + 11114 = 2768897

select i.codice_impianto, i.proprietario, pf.id_persona_fisica, pf.cognome, pf.nome
from sigit_t_impianto i, sigit_t_persona_fisica pf
where proprietario is not null and TRIM(proprietario)<>''
and i.codice_impianto not in (
	select srirp.codice_impianto
	from sigit_r_imp_ruolo_pfpg srirp
	where srirp.codice_impianto = i.codice_impianto
	and srirp.fk_ruolo in (15,16)
	and srirp.data_fine is null
)
--and UPPER(replace(i.proprietario,' ','')) = UPPER(replace(TRIM(pf.cognome),' ',''))||UPPER(replace(TRIM(pf.nome),' ',''))
and UPPER(replace(i.proprietario,' ','')) = UPPER(replace(TRIM(pf.nome),' ',''))||UPPER(replace(TRIM(pf.cognome),' ',''))
and pf.nome is not null and TRIM(pf.nome)<>'' 
and pf.cognome is not null and TRIM(pf.cognome)<>'' 
and UPPER(replace(TRIM(pf.nome),' ',''))||UPPER(replace(TRIM(pf.cognome),' ','')) in (
select UPPER(replace(TRIM(pf.nome),' ',''))||UPPER(replace(TRIM(pf.cognome),' ',''))
from sigit_t_persona_fisica pf
where pf.nome is not null and TRIM(pf.nome)<>'' 
and pf.cognome is not null and TRIM(pf.cognome)<>'' 
group by UPPER(replace(TRIM(pf.nome),' ',''))||UPPER(replace(TRIM(pf.cognome),' ',''))
having count(*) = 1
)
-- test 316 trovato PF x nome e cognome 

-- inserimento persone fisiche mancanti trovate x nome e cognome
insert into sigit_r_imp_ruolo_pfpg (id_imp_ruolo_pfpg, fk_ruolo, codice_impianto, data_inizio, data_fine, 
	fk_persona_fisica, fk_persona_giuridica, data_ult_mod, utente_ult_mod, flg_primo_caricatore)
select nextval('seq_r_imp_ruolo_pfpg'), 15, i.codice_impianto, now(), NULL, 
	pf.id_persona_fisica, NULL, now(), 'TRATTAMENTO DATI', 0
from sigit_t_impianto i, sigit_t_persona_fisica pf
where proprietario is not null and TRIM(proprietario)<>''
and i.codice_impianto not in (
	select srirp.codice_impianto
	from sigit_r_imp_ruolo_pfpg srirp
	where srirp.codice_impianto = i.codice_impianto
	and srirp.fk_ruolo in (15,16)
	and srirp.data_fine is null
)
--and UPPER(replace(i.proprietario,' ','')) = UPPER(replace(TRIM(pf.cognome),' ',''))||UPPER(replace(TRIM(pf.nome),' ',''))
and UPPER(replace(i.proprietario,' ','')) = UPPER(replace(TRIM(pf.nome),' ',''))||UPPER(replace(TRIM(pf.cognome),' ',''))
and pf.nome is not null and TRIM(pf.nome)<>'' 
and pf.cognome is not null and TRIM(pf.cognome)<>'' 
and UPPER(replace(TRIM(pf.nome),' ',''))||UPPER(replace(TRIM(pf.cognome),' ','')) in (
select UPPER(replace(TRIM(pf.nome),' ',''))||UPPER(replace(TRIM(pf.cognome),' ',''))
from sigit_t_persona_fisica pf
where pf.nome is not null and TRIM(pf.nome)<>'' 
and pf.cognome is not null and TRIM(pf.cognome)<>'' 
group by UPPER(replace(TRIM(pf.nome),' ',''))||UPPER(replace(TRIM(pf.cognome),' ',''))
having count(*) = 1
)


select count(*)
from sigit_r_imp_ruolo_pfpg;
-- test 2768897 + 316 = 2769213

-- vediamo quanti non sono stati ricondotti
-- da 2039 iniziali
-- 33 pg + 229 pf = 262

select count(*)
from sigit_t_impianto i
where proprietario is not null and TRIM(proprietario)<>''
and i.codice_impianto in (
	select srirp.codice_impianto
--	from sigit_r_imp_ruolo_pfpg_pre_ril_1_16 srirp
	from sigit_r_imp_ruolo_pfpg srirp
	where srirp.codice_impianto = i.codice_impianto
	and srirp.fk_ruolo in (15,16)
	and srirp.data_fine is null
);
-- 2039 + 262 = 2301
-- dev 2186

-- restano da recuperare a mano
select *
from sigit_t_impianto i
where proprietario is not null and TRIM(proprietario)<>''
and i.codice_impianto not in (
	select srirp.codice_impianto
	from sigit_r_imp_ruolo_pfpg srirp
	where srirp.codice_impianto = i.codice_impianto
	and srirp.fk_ruolo in (15,16)
	and srirp.data_fine is null
);
-- 2610 - 2186 = 424
