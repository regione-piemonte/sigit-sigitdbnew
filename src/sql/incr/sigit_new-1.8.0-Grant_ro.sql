GRANT USAGE ON SCHEMA sigit_new TO sigit_new_ro;

GRANT SELECT ON TABLE sigit_d_dato_distrib TO sigit_new_ro;
GRANT SELECT ON TABLE sigit_t_dato_distrib TO sigit_new_ro;
GRANT SELECT ON TABLE sigit_t_import_distrib TO sigit_new_ro;
GRANT SELECT ON TABLE sigit_t_rif_catast TO sigit_new_ro;
GRANT SELECT ON TABLE sigit_t_persona_giuridica TO sigit_new_ro;
GRANT SELECT ON TABLE sigit_d_assenza_catast TO sigit_new_ro;
GRANT SELECT ON TABLE sigit_d_categoria_util TO sigit_new_ro;
GRANT SELECT ON TABLE sigit_d_combustibile TO sigit_new_ro;
GRANT SELECT ON TABLE sigit_d_unita_misura TO sigit_new_ro;
GRANT SELECT ON TABLE sigit_d_tipo_contratto_distrib TO sigit_new_ro;

GRANT SELECT ON TABLE sigit_d_ruolo TO sigit_new_ro;
GRANT SELECT ON TABLE sigit_d_stato TO sigit_new_ro;
GRANT SELECT ON TABLE sigit_d_tipo_contratto TO sigit_new_ro;

GRANT SELECT ON TABLE sigit_d_stato_imp TO sigit_new_ro;



GRANT USAGE ON SCHEMA sigit_new TO sigit_new_rw;
GRANT SELECT,UPDATE,INSERT,DELETE,TRUNCATE ON ALL TABLES IN SCHEMA sigit_new TO sigit_new_rw;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA sigit_new TO sigit_new_rw;
GRANT SELECT,UPDATE ON ALL SEQUENCES IN SCHEMA sigit_new TO sigit_new_rw;

