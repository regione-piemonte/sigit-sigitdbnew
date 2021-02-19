-- Function: fnc_migraispezioni()

-- DROP FUNCTION fnc_migraispezioni();

CREATE OR REPLACE FUNCTION fnc_migraispezioni()
  RETURNS bigint AS
$BODY$
DECLARE

 -- *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
 -- *** 
 -- *** funzione che migrai i dati dalla sigit_t_ispezioni e sigir_r_imp_ruolo_pfpg
 -- *** alle tabelle sigit_t_verifiche, sigit_t_ispezioni_2018, SIGIT_T_AZIONE e SIGIT_T_DOC_AZIONE
 -- *** 
 -- *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
 
 -- - - - 
 c_ispez_01 cursor for 
 	select isp.id_imp_ruolo_pfpg, isp.fk_stato_ispezione, isp.data_ispezione, isp.ente_competente, isp.flg_esito,
		isp.note, ri.codice_impianto, ri.fk_ruolo, ri.data_inizio, ri.data_fine, ri.fk_persona_fisica, 
		ri.data_ult_mod, ri.utente_ult_mod, SUBSTR(i.istat_comune,1,3) istat_prov, isp.fk_stato_ispezione
	from sigit_t_ispezione isp, sigit_r_imp_ruolo_pfpg ri, sigit_t_impianto i
	where ri.id_imp_ruolo_pfpg = isp.id_imp_ruolo_pfpg
	and i.codice_impianto = ri.codice_impianto
	order by isp.id_imp_ruolo_pfpg;
 c_ispez_02 cursor for 
	select da.id_doc_aggiuntiva, da.data_upload, rii.id_ispezione_2018, da.fk_tipo_docagg, tda.des_tipo_doc_agg, 
	da.des_altro_tipodoc, da.nome_doc_originale, da.nome_doc, da.uid_index, da.utente_ult_mod, pf.cognome, pf.nome
	from SIGIT_T_DOC_AGGIUNTIVA da
	LEFT JOIN sigit_r_ispez_ispet rii ON rii.id_ispez_ispet = da.fk_imp_ruolo_pfpg
	LEFT JOIN SIGIT_D_TIPO_DOC_AGG tda ON tda.id_tipo_doc_agg = da.fk_tipo_docagg
	LEFT JOIN SIGIT_T_PERSONA_FISICA pf ON pf.codice_fiscale = da.utente_ult_mod
	where da.fk_tipo_docagg IN (2, 3)
	order by da.id_doc_aggiuntiva;
 c_ispez_03 cursor for 
	select  da.id_doc_aggiuntiva, da.codice_impianto, da.fk_imp_ruolo_pfpg,
	da.data_upload, da.nome_doc, da.data_ult_mod, da.utente_ult_mod, da.uid_index, i.data_ispezione
	from SIGIT_T_DOC_AGGIUNTIVA da
	INNER JOIN SIGIT_T_ISPEZIONE i ON i.id_imp_ruolo_pfpg = da.fk_imp_ruolo_pfpg
	where da.fk_tipo_docagg IN (1);
 c_ispez_04 cursor (idDoc integer) for 
	select distinct da.id_doc_aggiuntiva, da.codice_impianto, da.fk_imp_ruolo_pfpg, i.data_ispezione, 
	da.data_upload, da.nome_doc, da.data_ult_mod, da.utente_ult_mod, da.uid_index,
	gt.codice_impianto, gt.id_tipo_componente, gt.progressivo, gt.data_install, gt.data_dismiss,
	ri.id_imp_ruolo_pfpg, ri.fk_ruolo, ri.data_inizio, ri.data_fine, 
	c.id_contratto, c.data_inizio, c.data_fine, c.flg_tacito_rinnovo, c.data_cessazione	
	from SIGIT_T_DOC_AGGIUNTIVA da
	INNER JOIN SIGIT_T_COMP_GT gt ON gt.codice_impianto = da.codice_impianto
	INNER JOIN SIGIT_T_ISPEZIONE i ON i.id_imp_ruolo_pfpg = da.fk_imp_ruolo_pfpg
	INNER JOIN sigit_r_imp_ruolo_pfpg ri ON ri.codice_impianto = da.codice_impianto
	LEFT OUTER JOIN SIGIT_T_CONTRATTO_2019 c ON da.codice_impianto = c.codice_impianto 
		and i.data_ispezione >= c.data_inizio
		and i.data_ispezione <= coalesce(c.data_cessazione, null, 
			decode(c.flg_tacito_rinnovo,1::numeric,i.data_ispezione,0::numeric,
				coalesce(c.data_fine, null, i.data_ispezione)))
	where da.id_doc_aggiuntiva = idDoc
	and da.fk_tipo_docagg IN (1)
	and i.data_ispezione >= data_install
	and i.data_ispezione <= coalesce(data_dismiss, null, i.data_ispezione)
	and ri.fk_ruolo in (4,5,10,11,12,13)
	and i.data_ispezione >= ri.data_inizio
	and i.data_ispezione <= coalesce(ri.data_fine, null, i.data_ispezione)
	order by gt.codice_impianto, gt.id_tipo_componente, gt.progressivo, gt.data_install;

	
 v_return bigint := 0; -- N.B.: Pentaho necessita che il valore restituito sia di tipo bigint !!! 
 --
 v_messaggio_inizio character varying(200);
 --
 v_nome_funzione character varying(200);
 v_nome_tavola character varying(200);
 v_sqlerrm character varying(1000);
 --
 v_esito character varying(20);
-- v_comodo character varying(100);
-- v_num_pratica integer;
 vDescAzione character varying(1000);
 seqVerifica integer;
 seqIspezione2018 integer;
 seqAzione integer;
 dtConclusione date;
 seqAllegato numeric;
 nIdDocAggiuntivaPrec integer;
 nIdAllegatoPrec numeric;
 nIdTipoComponentePrec character varying(5);
 nProgressivoPrec numeric(3,0);
 nCodiceImpiantoPrec numeric;
 nDataInstallPrec date;
 nIdContratto numeric;
 nImpRuoloPFPG numeric;
  
BEGIN

 -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
 -- INIZIO
 -- - - - 
 -- -
 v_messaggio_inizio := 'Migrazione Ispezioni';
 v_nome_funzione := 'fnc_migraIspezioni';

 RAISE NOTICE '*** * * * * * * * * * * * * * * * * * * * * * * * * ***';
 RAISE NOTICE '%', v_messaggio_inizio;
 RAISE NOTICE '*** * * * * * * * * * * * * * * * * * * * * * * * * ***';

 RAISE NOTICE '*** FUNZIONE % ***', v_nome_funzione;
 
 -- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
 v_return := 0;
/*
 RAISE NOTICE '*** MIGRAZIONE sigit_t_verifica, sigit_t_ispezione_2018, sigit_r_ispez_ispet ***';

 FOR rec_c_ispez_01 in c_ispez_01
 LOOP

	BEGIN
	v_nome_tavola:= 'sigit_t_verifica';

	insert into sigit_t_verifica	(
					id_verifica,
					fk_tipo_verifica,
					fk_allegato,
					fk_dato_distrib,
					codice_impianto,
					cf_utente_caricamento,
					dt_caricamento
					)
	values (nextval('seq_t_verifica'),
		'7',
		0,
		0,
		rec_c_ispez_01.codice_impianto,
		'INSERTAUTOMATICO',
		rec_c_ispez_01.data_ispezione
		)
	RETURNING id_verifica INTO seqVerifica;

	EXCEPTION
		WHEN OTHERS
		then
		  RAISE NOTICE '!!! ERRORE su inserimento VERIFICA su rec_c_ispez_01.id_imp_ruolo_pfpg % !!!',  to_char(rec_c_ispez_01.id_imp_ruolo_pfpg);
		  RAISE NOTICE 'SQLERRM = %', SQLERRM; 
		  --v_sqlerrm := SQLERRM;
		  v_return = 1;
	END;

	-- *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
	-- ***
	IF v_return = 0 THEN

		BEGIN
		v_nome_tavola:= 'sigit_t_ispezione_2018';

		dtConclusione := NULL;
		IF rec_c_ispez_01.fk_stato_ispezione != 1 THEN
		   dtConclusione := rec_c_ispez_01.data_ispezione;
		END IF;

		insert into sigit_t_ispezione_2018	(
							id_ispezione_2018,
							fk_stato_ispezione,
							fk_verifica,
							fk_accertamento,
							codice_impianto,
							dt_creazione,
							ente_competente,
							flg_esito,
							note,
							istat_prov_competenza, 
							flg_acc_sostitutivo,
							dt_conclusione
							)
		values (nextval('seq_t_ispezione_2018'),
			rec_c_ispez_01.fk_stato_ispezione,
			seqVerifica,
			0,
			rec_c_ispez_01.codice_impianto,
			rec_c_ispez_01.data_ispezione,
			rec_c_ispez_01.ente_competente,
			rec_c_ispez_01.flg_esito,
			SUBSTRING(rec_c_ispez_01.note, 1, 500),
			rec_c_ispez_01.istat_prov,
			0,
			dtConclusione
			)
		RETURNING id_ispezione_2018 INTO seqIspezione2018;

		EXCEPTION
			WHEN OTHERS
			then
			  RAISE NOTICE '!!! ERRORE su inserimento ISPEZIONE_2018 su rec_c_ispez_01.id_imp_ruolo_pfpg % !!!',  to_char(rec_c_ispez_01.id_imp_ruolo_pfpg);
			  RAISE NOTICE 'SQLERRM = %', SQLERRM; 
			  --v_sqlerrm := SQLERRM;
			  v_return = 1;
		END;
	END IF;
    
	-- *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
	-- ***
	IF v_return = 0 THEN

		BEGIN
		v_nome_tavola:= 'sigit_t_azione';

		insert into sigit_t_azione	(
						id_azione,
						dt_azione,
						fk_tipo_azione,
						fk_verifica,
						fk_ispezione_2018,
						fk_accertamento,
						fk_sanzione,
						descrizione_azione,
						cf_utente_azione,
						denom_utente_azione)
		values (nextval('seq_t_azione'),
			rec_c_ispez_01.data_ispezione,
			1,
			seqVerifica,
			0,
			0,
			0,
			'Ribaltamento vecchie ispezioni',
			'INSERTAUTOMATICO',
			NULL
			);

		EXCEPTION
			WHEN OTHERS
			then
			  RAISE NOTICE '!!! ERRORE su inserimento AZIONE su rec_c_ispez_01.id_imp_ruolo_pfpg % !!!',  to_char(rec_c_ispez_01.id_imp_ruolo_pfpg);
			  RAISE NOTICE 'SQLERRM = %', SQLERRM; 
			  --v_sqlerrm := SQLERRM;
			  v_return = 1;
		END;
	END IF;
    
	-- *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
	-- ***
	IF v_return = 0 THEN

		BEGIN
		v_nome_tavola:= 'sigit_r_ispez_ispet';

		insert into sigit_r_ispez_ispet	(
						id_ispez_ispet,
						fk_ruolo,
						codice_impianto,
						data_inizio,
						data_fine,
						fk_persona_fisica,
						data_ult_mod,
						utente_ult_mod,
						id_ispezione_2018
						)
		values (rec_c_ispez_01.id_imp_ruolo_pfpg,
			rec_c_ispez_01.fk_ruolo,
			rec_c_ispez_01.codice_impianto,
			rec_c_ispez_01.data_inizio,
			rec_c_ispez_01.data_fine,
			rec_c_ispez_01.fk_persona_fisica,
			rec_c_ispez_01.data_ult_mod,
			rec_c_ispez_01.utente_ult_mod,
			seqIspezione2018
			);

		EXCEPTION
			WHEN OTHERS
			then
			  RAISE NOTICE '!!! ERRORE su inserimento ISPEZ_ISPET su rec_c_ispez_01.id_imp_ruolo_pfpg !!! % ',  to_char(rec_c_ispez_01.id_imp_ruolo_pfpg);
			  RAISE NOTICE 'SQLERRM = %', SQLERRM; 
			  --v_sqlerrm := SQLERRM;
			  v_return = 1;
		END;
	END IF;
 END LOOP; 

 IF v_return = 0 THEN
      
	-- *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
	RAISE NOTICE '*** MIGRAZIONE sigit_t_azione, sigit_t_doc_azione ***';
 
	FOR rec_c_ispez_02 in c_ispez_02
	LOOP

		v_nome_tavola:= 'sigit_t_azione';

		vDescAzione := NULL;
		IF rec_c_ispez_02.fk_tipo_docagg = 3 THEN
			vDescAzione := rec_c_ispez_02.des_tipo_doc_agg ||'-'|| rec_c_ispez_02.des_altro_tipodoc;
		ELSE
			vDescAzione := rec_c_ispez_02.des_tipo_doc_agg;
		END IF;

		BEGIN

		insert into sigit_t_azione	(
						id_azione,
						dt_azione,
						fk_tipo_azione,
						fk_verifica,
						fk_ispezione_2018,
						fk_accertamento,
						fk_sanzione,
						descrizione_azione,
						cf_utente_azione,
						denom_utente_azione)
		values (nextval('seq_t_azione'),
			rec_c_ispez_02.data_upload,
			3,
			0,
			rec_c_ispez_02.id_ispezione_2018,
			0,
			0,
			vDescAzione,
			rec_c_ispez_02.utente_ult_mod,
			rec_c_ispez_02.cognome||' '||rec_c_ispez_02.nome
			)
			RETURNING id_azione INTO seqAzione;

		EXCEPTION
			WHEN OTHERS
			then 
			  RAISE NOTICE '!!! ERRORE su inserimento AZIONE su rec_c_ispez_02.id_doc_aggiuntiva !!! % ', to_char(rec_c_ispez_02.id_doc_aggiuntiva);
			  RAISE NOTICE 'SQLERRM = %', SQLERRM; 
			  --v_sqlerrm := SQLERRM;
			  v_return = 1;
		END;

		-- *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
		-- ***
		IF v_return = 0 THEN

			v_nome_tavola:= 'sigit_t_doc_azione';

			BEGIN

			insert into sigit_t_doc_azione	(
							id_doc_azione,
							fk_azione,
							nome_doc_originale,
							nome_doc,
							uid_index,
							data_ult_mod,
							utente_ult_mod)
			values (nextval('seq_t_doc_azione'),
				seqAzione,
				rec_c_ispez_02.nome_doc_originale,
				rec_c_ispez_02.nome_doc, 
				rec_c_ispez_02.uid_index, 
				rec_c_ispez_02.data_upload, 
				rec_c_ispez_02.utente_ult_mod
				);

			EXCEPTION
				WHEN OTHERS
				then
				  RAISE NOTICE '!!! ERRORE su inserimento DOC_AZIONE su rec_c_ispez_02.id_doc_aggiuntiva % !!!',  to_char(rec_c_ispez_02.id_doc_aggiuntiva);
				  RAISE NOTICE 'SQLERRM = %', SQLERRM; 
				  --v_sqlerrm := SQLERRM;
				  v_return = 1;
			END;
		END IF;
	END LOOP;   
 END IF; 

 IF v_return = 0 THEN
      
	-- *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
	RAISE NOTICE '*** MIGRAZIONE sigit_t_allegato, sigit_r_allegato_comp_gt ***';

	nIdDocAggiuntivaPrec := -1;
	FOR rec_c_ispez_03 in c_ispez_03
	LOOP

		v_nome_tavola:= 'sigit_t_allegato';

		IF nIdDocAggiuntivaPrec != rec_c_ispez_03.id_doc_aggiuntiva THEN

			nIdDocAggiuntivaPrec := rec_c_ispez_03.id_doc_aggiuntiva;
			BEGIN

			insert into sigit_t_allegato 	(
							id_allegato,
							fk_stato_rapp,
							fk_tipo_documento,
							data_controllo,
							data_invio,
							nome_allegato,
							data_ult_mod,
							utente_ult_mod,
							uid_index,
							elenco_apparecchiature,
							fk_tipo_manutenzione,
							fk_ispez_ispet
							)
			values (nextval('seq_t_allegato'),
				1,
				8,
				rec_c_ispez_03.data_ispezione,
				rec_c_ispez_03.data_upload,
				rec_c_ispez_03.nome_doc,
				rec_c_ispez_03.data_ult_mod,
				rec_c_ispez_03.utente_ult_mod,
				rec_c_ispez_03.uid_index,
				'SCANSIONE RAPPORTO PROVA',
				0,
				rec_c_ispez_03.fk_imp_ruolo_pfpg
				)
				RETURNING id_allegato INTO seqAllegato;

			EXCEPTION
				WHEN OTHERS
				then 
				  RAISE NOTICE '!!! ERRORE su inserimento ALLEGATO su rec_c_ispez_03.id_doc_aggiuntiva !!! % ', to_char(rec_c_ispez_03.id_doc_aggiuntiva);
				  RAISE NOTICE 'SQLERRM = %', SQLERRM; 
				  --v_sqlerrm := SQLERRM;
				  v_return = 1;
			END;
		END IF;
		
		-- *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** 
		-- ***
		IF v_return = 0 THEN

			FOR rec_c_ispez_04 in c_ispez_04 (rec_c_ispez_03.id_doc_aggiuntiva)
			LOOP
				v_nome_tavola:= 'sigit_r_allegato_comp_gt';

				nIdContratto := NULL;
				nImpRuoloPFPG := NULL;
				IF rec_c_ispez_04.id_contratto IS NOT NULL THEN
					nIdContratto := rec_c_ispez_04.id_contratto;
				ELSE
					nImpRuoloPFPG := rec_c_ispez_04.id_imp_ruolo_pfpg;
				END IF;

				BEGIN

				insert into sigit_r_allegato_comp_gt 	(
									id_allegato,
									id_tipo_componente,
									progressivo,
									codice_impianto,
									data_install,
									fk_imp_ruolo_pfpg,
									fk_contratto)
				values (seqAllegato,
					rec_c_ispez_04.id_tipo_componente,
					rec_c_ispez_04.progressivo, 
					rec_c_ispez_04.codice_impianto, 
					rec_c_ispez_04.data_install, 
					nImpRuoloPFPG,
					--rec_c_ispez_03.fk_contratto
					nIdContratto
					);

				EXCEPTION
					WHEN OTHERS
					then
					  RAISE NOTICE '!!! ERRORE su inserimento sigit_r_allegato_comp_gt su rec_c_ispez_04.id_doc_aggiuntiva % !!!',  to_char(rec_c_ispez_03.id_doc_aggiuntiva);
					  RAISE NOTICE 'SQLERRM = %', SQLERRM; 
					  --v_sqlerrm := SQLERRM;
					  v_return = 1;
				END;
			END LOOP;
		END IF;
	END LOOP;   
 END IF; 

    IF v_return = 0 THEN

	BEGIN

	RAISE NOTICE '*** CANCELLAZIONE sigit_t_doc_aggiuntiva ***';

	delete from SIGIT_T_DOC_AGGIUNTIVA da
	where da.fk_tipo_docagg IN (1, 2, 3);

	EXCEPTION
		WHEN OTHERS
		then
		  RAISE NOTICE '!!! ERRORE su cancellazione DOC_AGGIUNTIVA !!!';
		  RAISE NOTICE 'SQLERRM = %', SQLERRM; 
		  --v_sqlerrm := SQLERRM;
		  v_return = 1;
	END;
    END IF;

    IF v_return = 0 THEN
	 FOR rec_c_ispez_01 in c_ispez_01
	 LOOP
		BEGIN
	 RAISE NOTICE '*** CANCELLAZIONE sigit_t_ispezione, sigit_r_imp_ruolo_pfpg ***';

		delete from sigit_t_ispezione isp1
		where isp1.id_imp_ruolo_pfpg = rec_c_ispez_01.id_imp_ruolo_pfpg;
		
		EXCEPTION
			WHEN OTHERS
			then
			  RAISE NOTICE '!!! ERRORE su cancellazione ISPEZIONE rec_c_ispez_01.id_imp_ruolo_pfpg % !!!', to_char(rec_c_ispez_01.id_imp_ruolo_pfpg);
			  RAISE NOTICE 'SQLERRM = %', SQLERRM; 
			  --v_sqlerrm := SQLERRM;
			  v_return = 1;
		END;

		BEGIN

	 RAISE NOTICE '*** 2 CANCELLAZIONE sigit_t_ispezione, sigit_r_imp_ruolo_pfpg ***';
		delete from sigit_r_imp_ruolo_pfpg ri
		where ri.id_imp_ruolo_pfpg = rec_c_ispez_01.id_imp_ruolo_pfpg;
		
		EXCEPTION
			WHEN OTHERS
			then
			  RAISE NOTICE '!!! ERRORE su cancellazione IMP_RUOLO_PFPG rec_c_ispez_01.id_imp_ruolo_pfpg % !!!', to_char(rec_c_ispez_01.id_imp_ruolo_pfpg);
			  RAISE NOTICE 'SQLERRM = %', SQLERRM; 
			  --v_sqlerrm := SQLERRM;
			  v_return = 1;
		END;
	 END LOOP;   
    END IF;
*/
 RAISE NOTICE '*** * * * * * * * * * * * * * * * * * * * * * * * * ***';
 RAISE NOTICE '% FINE ', v_messaggio_inizio;
 RAISE NOTICE '*** * * * * * * * * * * * * * * * * * * * * * * * * ***';

-- ROLLBACK;

IF v_return != 0 THEN
   ROLLBACK;
END IF;

RETURN v_return;  
 
EXCEPTION
when OTHERS 
then 
   RAISE NOTICE 'SQLERRM = %', SQLERRM; 
   v_sqlerrm := SQLERRM;

   ROLLBACK;
   RETURN 9;
    
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION fnc_migraispezioni()
  OWNER TO sigit_new;
GRANT EXECUTE ON FUNCTION fnc_migraispezioni() TO public;
GRANT EXECUTE ON FUNCTION fnc_migraispezioni() TO sigit_new;
GRANT EXECUTE ON FUNCTION fnc_migraispezioni() TO sigit_new_rw;
