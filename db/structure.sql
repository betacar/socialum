--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

--
-- Name: socialum; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA socialum;


SET search_path = socialum, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: arribos_bauxita; Type: TABLE; Schema: socialum; Owner: -; Tablespace: 
--

CREATE TABLE arribos_bauxita (
    id integer NOT NULL,
    activo boolean DEFAULT true,
    bax_id character varying(255),
    fecha_hora_arribo_bauxita timestamp without time zone,
    creator_id integer,
    updater_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    descargado boolean DEFAULT false
);


--
-- Name: arribos_bauxita_id_seq; Type: SEQUENCE; Schema: socialum; Owner: -
--

CREATE SEQUENCE arribos_bauxita_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: arribos_bauxita_id_seq; Type: SEQUENCE OWNED BY; Schema: socialum; Owner: -
--

ALTER SEQUENCE arribos_bauxita_id_seq OWNED BY arribos_bauxita.id;


--
-- Name: descargas_bauxita; Type: TABLE; Schema: socialum; Owner: -; Tablespace: 
--

CREATE TABLE descargas_bauxita (
    id integer NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    arribo_id integer,
    arribo_type character varying(255),
    equipo_id integer,
    gabarra_id character varying(255),
    tonelaje_descarga_bauxita numeric,
    atraque_descarga_bauxita timestamp without time zone,
    inicio_descarga_bauxita timestamp without time zone,
    fin_descarga_bauxita timestamp without time zone,
    desatraque_descarga_bauxita timestamp without time zone,
    creator_id integer,
    updater_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: descargas_bauxita_id_seq; Type: SEQUENCE; Schema: socialum; Owner: -
--

CREATE SEQUENCE descargas_bauxita_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: descargas_bauxita_id_seq; Type: SEQUENCE OWNED BY; Schema: socialum; Owner: -
--

ALTER SEQUENCE descargas_bauxita_id_seq OWNED BY descargas_bauxita.id;


--
-- Name: equipos; Type: TABLE; Schema: socialum; Owner: -; Tablespace: 
--

CREATE TABLE equipos (
    id integer NOT NULL,
    tipo_equipo_id integer NOT NULL,
    empresa_id integer,
    nombre_equipo character varying(255) NOT NULL,
    creator_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    activo boolean DEFAULT true NOT NULL,
    updater_id integer
);


--
-- Name: equipos_id_seq; Type: SEQUENCE; Schema: socialum; Owner: -
--

CREATE SEQUENCE equipos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: equipos_id_seq; Type: SEQUENCE OWNED BY; Schema: socialum; Owner: -
--

ALTER SEQUENCE equipos_id_seq OWNED BY equipos.id;


--
-- Name: roles; Type: TABLE; Schema: socialum; Owner: -; Tablespace: 
--

CREATE TABLE roles (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: socialum; Owner: -
--

CREATE SEQUENCE roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: socialum; Owner: -
--

ALTER SEQUENCE roles_id_seq OWNED BY roles.id;


--
-- Name: roles_users; Type: TABLE; Schema: socialum; Owner: -; Tablespace: 
--

CREATE TABLE roles_users (
    rol_id integer,
    user_id integer
);


--
-- Name: schema_migrations; Type: TABLE; Schema: socialum; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: tipos_equipos; Type: TABLE; Schema: socialum; Owner: -; Tablespace: 
--

CREATE TABLE tipos_equipos (
    id integer NOT NULL,
    activo boolean DEFAULT true NOT NULL,
    nombre_tipo_equipo character varying(255) NOT NULL,
    creator_id integer,
    updater_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: tipos_equipos_id_seq; Type: SEQUENCE; Schema: socialum; Owner: -
--

CREATE SEQUENCE tipos_equipos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


--
-- Name: tipos_equipos_id_seq; Type: SEQUENCE OWNED BY; Schema: socialum; Owner: -
--

ALTER SEQUENCE tipos_equipos_id_seq OWNED BY tipos_equipos.id;


--
-- Name: usuarios; Type: TABLE; Schema: socialum; Owner: -; Tablespace: 
--

CREATE TABLE usuarios (
    id integer NOT NULL,
    estado_id integer DEFAULT 1 NOT NULL,
    login character varying(255) NOT NULL,
    ldap_attributes character varying(255),
    remember_token character varying(255),
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    encrypted_password character varying(255)
);


--
-- Name: vw_zarpes; Type: VIEW; Schema: socialum; Owner: -
--

CREATE VIEW vw_zarpes AS
    SELECT ((("substring"('00'::text, 1, (3 - length((cgb_zarpe_015.num_zarpe)::text))) || (cgb_zarpe_015.num_zarpe)::text) || '-'::text) || (cgb_zarpe_015.ano_zarpe)::text) AS id, btrim((cgb_zarpe_015.cod_emp)::text) AS empresa_maritima_id, cgb_zarpe_015.cod_remo AS remolcador_id, cgb_zarpe_015.nombre_capitan, (((date(cgb_zarpe_015.fecha_zarpe))::text || ' '::text) || ((cgb_zarpe_015.hora_zarpe)::time without time zone)::text) AS fecha_hora_zarpe, cgb_zarpe_015.carga_transportar, cgb_zarpe_015.cant_gabarras FROM spb.cgb_zarpe_015 WHERE ((cgb_zarpe_015.fecha_zarpe IS NOT NULL) AND (cgb_zarpe_015.hora_zarpe IS NOT NULL));


--
-- Name: vw_bax; Type: VIEW; Schema: socialum; Owner: -
--

CREATE VIEW vw_bax AS
    SELECT vw_zarpes.id, vw_zarpes.empresa_maritima_id, vw_zarpes.remolcador_id, vw_zarpes.nombre_capitan, vw_zarpes.fecha_hora_zarpe, vw_zarpes.carga_transportar, vw_zarpes.cant_gabarras FROM vw_zarpes WHERE ((NOT (vw_zarpes.id IN (SELECT arribos_bauxita.bax_id FROM arribos_bauxita WHERE (arribos_bauxita.descargado = true)))) AND (vw_zarpes.fecha_hora_zarpe >= '2011-05-01 00:00'::text));


--
-- Name: vw_baxs_gabarras; Type: VIEW; Schema: socialum; Owner: -
--

CREATE VIEW vw_baxs_gabarras AS
    SELECT CASE WHEN (length((cgb_calado_004.num_emba)::text) = 1) THEN ((('00'::text || (cgb_calado_004.num_emba)::text) || '-'::text) || (cgb_calado_004.ano_emba)::text) WHEN (length((cgb_calado_004.num_emba)::text) = 2) THEN ((('0'::text || (cgb_calado_004.num_emba)::text) || '-'::text) || (cgb_calado_004.ano_emba)::text) ELSE (((cgb_calado_004.num_emba)::text || '-'::text) || (cgb_calado_004.ano_emba)::text) END AS bax_id, cgb_calado_004.cod_gaba AS gabarra_id, cgb_calado_004.tone_transportada, scc_control_muestrasgaba_013.sio2r, scc_control_muestrasgaba_013.sio2q, scc_control_muestrasgaba_013.al2o3, scc_control_muestrasgaba_013.fe2o3, scc_control_muestrasgaba_013.humedad, scc_control_muestrasgaba_013.muestreo, scc_control_muestrasgaba_013.tipo_carga FROM (spb.cgb_calado_004 LEFT JOIN spb.scc_control_muestrasgaba_013 ON (((((scc_control_muestrasgaba_013.num_emba)::text = (cgb_calado_004.num_emba)::text) AND ((scc_control_muestrasgaba_013.ano_emba)::text = (cgb_calado_004.ano_emba)::text)) AND ((scc_control_muestrasgaba_013.cod_gaba)::text = (cgb_calado_004.cod_gaba)::text))));


--
-- Name: vw_empresas_maritimas; Type: VIEW; Schema: socialum; Owner: -
--

CREATE VIEW vw_empresas_maritimas AS
    SELECT btrim((cgb_emptran_009.cod_emp)::text) AS id, CASE WHEN ((cgb_emptran_009.nombre_emp)::text = ('ACBL DE VENEZUELA'::character varying)::text) THEN 'ACBL de Venezuela'::character varying(30) WHEN ((cgb_emptran_009.nombre_emp)::text = ('REMOLQUES ORINOCO'::character varying)::text) THEN 'Remolques Orinoco'::character varying(30) WHEN ((cgb_emptran_009.nombre_emp)::text = ('RENAIN'::character varying)::text) THEN 'Renain'::character varying(30) WHEN ((cgb_emptran_009.nombre_emp)::text = ('TERMINALES MARACAIBO CA'::character varying)::text) THEN 'TM Servicios Marítimos'::character varying(30) ELSE cgb_emptran_009.nombre_emp END AS nombre_emp FROM spb.cgb_emptran_009;


--
-- Name: vw_gabarras; Type: VIEW; Schema: socialum; Owner: -
--

CREATE VIEW vw_gabarras AS
    SELECT cgb_mgabarra_019.cod_gaba AS id, CASE WHEN (split_part((cgb_mgabarra_019.cod_gaba)::text, '-'::text, 1) = 'TM'::text) THEN (split_part((cgb_mgabarra_019.cod_gaba)::text, '-'::text, 1) || 'CA'::text) WHEN (split_part((cgb_mgabarra_019.cod_gaba)::text, '-'::text, 1) = 'REM'::text) THEN 'TMCA'::text WHEN (split_part((cgb_mgabarra_019.cod_gaba)::text, '-'::text, 1) = 'MTI'::text) THEN 'TMCA'::text WHEN (split_part((cgb_mgabarra_019.cod_gaba)::text, '-'::text, 1) = 'FMO'::text) THEN 'TMCA'::text WHEN (split_part((cgb_mgabarra_019.cod_gaba)::text, '-'::text, 1) = 'PLAN'::text) THEN 'TMCA'::text ELSE split_part((cgb_mgabarra_019.cod_gaba)::text, '-'::text, 1) END AS empresa_maritima_id FROM spb.cgb_mgabarra_019;


--
-- Name: vw_personal; Type: VIEW; Schema: socialum; Owner: -
--

CREATE VIEW vw_personal AS
    SELECT gen_personal_001.numero_personal AS id, gen_personal_001.area_personal, gen_personal_001.cedula, gen_personal_001.apellidos, gen_personal_001.nombres, gen_personal_001.cod_unidad, gen_personal_001.descrip_unidad, gen_personal_001.cod_gerencia, gen_personal_001.descrip_gerencia, gen_personal_001.cod_cargo, gen_personal_001.descripcion_cargo, gen_personal_001.nacionalidad, gen_personal_001.grupo_sanguineo, gen_personal_001.factor_sanguineo, gen_personal_001.codigo_operadora, gen_personal_001.extension_telef_trab, gen_personal_001.correo_electronico, gen_personal_001.fecha_nacimiento, gen_personal_001.amparado, gen_personal_001.fecha_ingreso, gen_personal_001.cod_centro_costo, gen_personal_001.sexo, gen_personal_001.cod_estatus_trab, gen_personal_001.descrip_estatus, gen_personal_001.cod_estado_civil, gen_personal_001.descrip_estado_civil, gen_personal_001.direccion_hab, gen_personal_001.estado_hab, gen_personal_001.ciudad_hab, gen_personal_001.telefono_hab, gen_personal_001.nivel_educativo, gen_personal_001.mano_dominante, gen_personal_001.cant_hijos, gen_personal_001.horario, gen_personal_001.fecha_egreso, gen_personal_001.descrip_egreso, gen_personal_001.hora_actualizacion, gen_personal_001.area_pers_ant, gen_personal_001.grupo_trabajo FROM gen.gen_personal_001;


--
-- Name: vw_remolcadores; Type: VIEW; Schema: socialum; Owner: -
--

CREATE VIEW vw_remolcadores AS
    SELECT cgb_remolcador_017.cod_remo AS id, btrim((cgb_remolcador_017.cod_emp)::text) AS empresa_maritima_id, cgb_remolcador_017.nombre_rem, cgb_remolcador_017.tiempo_mina_planta, cgb_remolcador_017.tiempo_planta_mina FROM spb.cgb_remolcador_017;


--
-- Name: vw_unidades; Type: VIEW; Schema: socialum; Owner: -
--

CREATE VIEW vw_unidades AS
    SELECT gen_unidades_006.cod_unidad, gen_unidades_006.desc_unidad, gen_unidades_006.gerencia, gen_unidades_006.desc_gerencia, gen_unidades_006.operadora, gen_unidades_006.nivel_unidad, gen_unidades_006.tipo_unidad FROM gen.gen_unidades_006;


--
-- Name: id; Type: DEFAULT; Schema: socialum; Owner: -
--

ALTER TABLE ONLY arribos_bauxita ALTER COLUMN id SET DEFAULT nextval('arribos_bauxita_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: socialum; Owner: -
--

ALTER TABLE ONLY descargas_bauxita ALTER COLUMN id SET DEFAULT nextval('descargas_bauxita_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: socialum; Owner: -
--

ALTER TABLE ONLY equipos ALTER COLUMN id SET DEFAULT nextval('equipos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: socialum; Owner: -
--

ALTER TABLE ONLY roles ALTER COLUMN id SET DEFAULT nextval('roles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: socialum; Owner: -
--

ALTER TABLE ONLY tipos_equipos ALTER COLUMN id SET DEFAULT nextval('tipos_equipos_id_seq'::regclass);


--
-- Name: arribos_bauxita_pkey; Type: CONSTRAINT; Schema: socialum; Owner: -; Tablespace: 
--

ALTER TABLE ONLY arribos_bauxita
    ADD CONSTRAINT arribos_bauxita_pkey PRIMARY KEY (id);


--
-- Name: descargas_bauxita_pkey; Type: CONSTRAINT; Schema: socialum; Owner: -; Tablespace: 
--

ALTER TABLE ONLY descargas_bauxita
    ADD CONSTRAINT descargas_bauxita_pkey PRIMARY KEY (id);


--
-- Name: equipos_pkey; Type: CONSTRAINT; Schema: socialum; Owner: -; Tablespace: 
--

ALTER TABLE ONLY equipos
    ADD CONSTRAINT equipos_pkey PRIMARY KEY (id);


--
-- Name: roles_pkey; Type: CONSTRAINT; Schema: socialum; Owner: -; Tablespace: 
--

ALTER TABLE ONLY roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: tipos_equipos_pkey; Type: CONSTRAINT; Schema: socialum; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tipos_equipos
    ADD CONSTRAINT tipos_equipos_pkey PRIMARY KEY (id);


--
-- Name: usuarios_pkey; Type: CONSTRAINT; Schema: socialum; Owner: -; Tablespace: 
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- Name: index_usuarios_on_login; Type: INDEX; Schema: socialum; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_usuarios_on_login ON usuarios USING btree (login);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: socialum; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20110601152801');

INSERT INTO schema_migrations (version) VALUES ('20110601152913');

INSERT INTO schema_migrations (version) VALUES ('20110601152945');

INSERT INTO schema_migrations (version) VALUES ('20110601153148');

INSERT INTO schema_migrations (version) VALUES ('20110601153928');

INSERT INTO schema_migrations (version) VALUES ('20110601154745');

INSERT INTO schema_migrations (version) VALUES ('20110601154831');

INSERT INTO schema_migrations (version) VALUES ('20110601154942');

INSERT INTO schema_migrations (version) VALUES ('20110601155117');

INSERT INTO schema_migrations (version) VALUES ('20110601174821');

INSERT INTO schema_migrations (version) VALUES ('20110601174936');

INSERT INTO schema_migrations (version) VALUES ('20110601175244');

INSERT INTO schema_migrations (version) VALUES ('20110601175402');

INSERT INTO schema_migrations (version) VALUES ('20110601175828');

INSERT INTO schema_migrations (version) VALUES ('20110601180016');

INSERT INTO schema_migrations (version) VALUES ('20110601180526');

INSERT INTO schema_migrations (version) VALUES ('20110601181149');

INSERT INTO schema_migrations (version) VALUES ('20110601181354');

INSERT INTO schema_migrations (version) VALUES ('20110601181629');

INSERT INTO schema_migrations (version) VALUES ('20110601181721');

INSERT INTO schema_migrations (version) VALUES ('20110601182507');

INSERT INTO schema_migrations (version) VALUES ('20110601182905');

INSERT INTO schema_migrations (version) VALUES ('20110601183730');

INSERT INTO schema_migrations (version) VALUES ('20110601184147');

INSERT INTO schema_migrations (version) VALUES ('20110602180951');

INSERT INTO schema_migrations (version) VALUES ('20110606200903');

INSERT INTO schema_migrations (version) VALUES ('20110608145857');

INSERT INTO schema_migrations (version) VALUES ('20110628155406');

INSERT INTO schema_migrations (version) VALUES ('20110708152422');

INSERT INTO schema_migrations (version) VALUES ('20110708191351');

INSERT INTO schema_migrations (version) VALUES ('20110726183108');

INSERT INTO schema_migrations (version) VALUES ('20110726183755');

INSERT INTO schema_migrations (version) VALUES ('20110726190617');

INSERT INTO schema_migrations (version) VALUES ('20110729141650');

INSERT INTO schema_migrations (version) VALUES ('20110802133432');

INSERT INTO schema_migrations (version) VALUES ('20110809184039');

INSERT INTO schema_migrations (version) VALUES ('20110811153704');

INSERT INTO schema_migrations (version) VALUES ('20110820201615');

INSERT INTO schema_migrations (version) VALUES ('20110820211931');

INSERT INTO schema_migrations (version) VALUES ('20110821211920');

INSERT INTO schema_migrations (version) VALUES ('20110824124556');

INSERT INTO schema_migrations (version) VALUES ('20110824182556');

INSERT INTO schema_migrations (version) VALUES ('20110824182835');

INSERT INTO schema_migrations (version) VALUES ('20110907180628');

INSERT INTO schema_migrations (version) VALUES ('20110926185950');

INSERT INTO schema_migrations (version) VALUES ('20110927153728');

INSERT INTO schema_migrations (version) VALUES ('20111016003210');

INSERT INTO schema_migrations (version) VALUES ('20120526164004');

INSERT INTO schema_migrations (version) VALUES ('20120704160318');

INSERT INTO schema_migrations (version) VALUES ('20120918142138');