--
-- PostgreSQL database dump
--

-- Dumped from database version 12.11 (Ubuntu 12.11-0ubuntu0.20.04.1)
-- Dumped by pg_dump version 12.11 (Ubuntu 12.11-0ubuntu0.20.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO demouser;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.auth_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_id_seq OWNER TO demouser;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.auth_group_id_seq OWNED BY public.auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO demouser;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.auth_group_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_permissions_id_seq OWNER TO demouser;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.auth_group_permissions_id_seq OWNED BY public.auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO demouser;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.auth_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_permission_id_seq OWNER TO demouser;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.auth_permission_id_seq OWNED BY public.auth_permission.id;


--
-- Name: authtoken_token; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.authtoken_token (
    key character varying(40) NOT NULL,
    created timestamp with time zone NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.authtoken_token OWNER TO demouser;

--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO demouser;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.django_admin_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_admin_log_id_seq OWNER TO demouser;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.django_admin_log_id_seq OWNED BY public.django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO demouser;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.django_content_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_content_type_id_seq OWNER TO demouser;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.django_content_type_id_seq OWNED BY public.django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO demouser;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.django_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.django_migrations_id_seq OWNER TO demouser;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.django_migrations_id_seq OWNED BY public.django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO demouser;

--
-- Name: erp_main_achievment; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.erp_main_achievment (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    create_at timestamp with time zone NOT NULL,
    update_at timestamp with time zone NOT NULL
);


ALTER TABLE public.erp_main_achievment OWNER TO demouser;

--
-- Name: erp_main_achievment_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.erp_main_achievment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.erp_main_achievment_id_seq OWNER TO demouser;

--
-- Name: erp_main_achievment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.erp_main_achievment_id_seq OWNED BY public.erp_main_achievment.id;


--
-- Name: main_class; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.main_class (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    create_at timestamp with time zone NOT NULL,
    update_at timestamp with time zone NOT NULL,
    category_id integer,
    module_id integer
);


ALTER TABLE public.main_class OWNER TO demouser;

--
-- Name: main_class_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.main_class_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_class_id_seq OWNER TO demouser;

--
-- Name: main_class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.main_class_id_seq OWNED BY public.main_class.id;


--
-- Name: main_classdate; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.main_classdate (
    id integer NOT NULL,
    week character varying(25),
    status character varying(50) NOT NULL,
    start_date time without time zone,
    finish_date time without time zone,
    create_at timestamp with time zone NOT NULL,
    update_at timestamp with time zone NOT NULL,
    group_id integer,
    module_id integer
);


ALTER TABLE public.main_classdate OWNER TO demouser;

--
-- Name: main_classdate_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.main_classdate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_classdate_id_seq OWNER TO demouser;

--
-- Name: main_classdate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.main_classdate_id_seq OWNED BY public.main_classdate.id;


--
-- Name: main_events; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.main_events (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    description text NOT NULL,
    date date NOT NULL,
    is_new character varying(50) NOT NULL,
    status character varying(50) NOT NULL,
    create_at timestamp with time zone NOT NULL,
    update_at timestamp with time zone NOT NULL,
    clas_id integer NOT NULL
);


ALTER TABLE public.main_events OWNER TO demouser;

--
-- Name: main_events_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.main_events_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_events_id_seq OWNER TO demouser;

--
-- Name: main_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.main_events_id_seq OWNED BY public.main_events.id;


--
-- Name: main_group; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.main_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    current_students_number integer,
    "limit" integer,
    status character varying(20),
    type_group character varying(20),
    duration integer,
    create_at timestamp with time zone NOT NULL,
    update_at timestamp with time zone NOT NULL,
    level_id integer NOT NULL,
    module_id integer NOT NULL,
    number_of_lessons_per_month integer,
    clas_id integer,
    teachers_share integer
);


ALTER TABLE public.main_group OWNER TO demouser;

--
-- Name: main_group_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.main_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_group_id_seq OWNER TO demouser;

--
-- Name: main_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.main_group_id_seq OWNED BY public.main_group.id;


--
-- Name: main_images; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.main_images (
    id integer NOT NULL,
    file character varying(100) NOT NULL,
    create_at timestamp with time zone NOT NULL,
    update_at timestamp with time zone NOT NULL,
    clas_id integer,
    module_id integer
);


ALTER TABLE public.main_images OWNER TO demouser;

--
-- Name: main_images_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.main_images_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_images_id_seq OWNER TO demouser;

--
-- Name: main_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.main_images_id_seq OWNED BY public.main_images.id;


--
-- Name: main_level; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.main_level (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    duration integer NOT NULL,
    status character varying(50) NOT NULL,
    number_of_lessons integer NOT NULL,
    price integer NOT NULL,
    create_at timestamp with time zone NOT NULL,
    update_at timestamp with time zone NOT NULL,
    clas_id integer NOT NULL
);


ALTER TABLE public.main_level OWNER TO demouser;

--
-- Name: main_level_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.main_level_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_level_id_seq OWNER TO demouser;

--
-- Name: main_level_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.main_level_id_seq OWNED BY public.main_level.id;


--
-- Name: main_module; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.main_module (
    id integer NOT NULL,
    legal_name character varying(200) NOT NULL,
    password character varying(200) NOT NULL,
    contact_name character varying(200) NOT NULL,
    status character varying(30) NOT NULL,
    phone_number character varying(20) NOT NULL,
    description text,
    logo character varying(100),
    qr_code character varying(100),
    location1 character varying(300),
    location2 character varying(300),
    create_at timestamp with time zone NOT NULL,
    update_at timestamp with time zone NOT NULL,
    address character varying(300),
    bank_account bigint,
    bank_name character varying(300),
    director character varying(300),
    email character varying(100),
    established_year date,
    inn bigint,
    parent_firm_id integer,
    is_active boolean NOT NULL
);


ALTER TABLE public.main_module OWNER TO demouser;

--
-- Name: main_module_facilities; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.main_module_facilities (
    id integer NOT NULL,
    module_id integer NOT NULL,
    variant_id integer NOT NULL
);


ALTER TABLE public.main_module_facilities OWNER TO demouser;

--
-- Name: main_module_facilities_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.main_module_facilities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_module_facilities_id_seq OWNER TO demouser;

--
-- Name: main_module_facilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.main_module_facilities_id_seq OWNED BY public.main_module_facilities.id;


--
-- Name: main_module_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.main_module_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_module_id_seq OWNER TO demouser;

--
-- Name: main_module_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.main_module_id_seq OWNED BY public.main_module.id;


--
-- Name: main_question; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.main_question (
    id integer NOT NULL,
    status character varying(20) NOT NULL,
    name character varying(300) NOT NULL,
    create_at timestamp with time zone NOT NULL,
    update_at timestamp with time zone NOT NULL
);


ALTER TABLE public.main_question OWNER TO demouser;

--
-- Name: main_question_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.main_question_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_question_id_seq OWNER TO demouser;

--
-- Name: main_question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.main_question_id_seq OWNED BY public.main_question.id;


--
-- Name: main_recommendation; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.main_recommendation (
    id integer NOT NULL,
    name character varying(200) NOT NULL,
    phone_number character varying(20) NOT NULL,
    create_at timestamp with time zone NOT NULL
);


ALTER TABLE public.main_recommendation OWNER TO demouser;

--
-- Name: main_recommendation_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.main_recommendation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_recommendation_id_seq OWNER TO demouser;

--
-- Name: main_recommendation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.main_recommendation_id_seq OWNED BY public.main_recommendation.id;


--
-- Name: main_review; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.main_review (
    id integer NOT NULL,
    comment text,
    is_new character varying(50) NOT NULL,
    rate integer,
    create_at timestamp with time zone NOT NULL,
    update_at timestamp with time zone NOT NULL,
    clas_id integer,
    event_id integer,
    level_id integer,
    module_id integer,
    user_id integer
);


ALTER TABLE public.main_review OWNER TO demouser;

--
-- Name: main_review_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.main_review_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_review_id_seq OWNER TO demouser;

--
-- Name: main_review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.main_review_id_seq OWNED BY public.main_review.id;


--
-- Name: main_room; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.main_room (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    create_at timestamp with time zone NOT NULL,
    update_at timestamp with time zone NOT NULL,
    module_id integer NOT NULL
);


ALTER TABLE public.main_room OWNER TO demouser;

--
-- Name: main_room_group; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.main_room_group (
    id integer NOT NULL,
    room_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.main_room_group OWNER TO demouser;

--
-- Name: main_room_group_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.main_room_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_room_group_id_seq OWNER TO demouser;

--
-- Name: main_room_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.main_room_group_id_seq OWNED BY public.main_room_group.id;


--
-- Name: main_room_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.main_room_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_room_id_seq OWNER TO demouser;

--
-- Name: main_room_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.main_room_id_seq OWNED BY public.main_room.id;


--
-- Name: main_studentreason; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.main_studentreason (
    id integer NOT NULL,
    event_id integer,
    group_id integer,
    reason_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.main_studentreason OWNER TO demouser;

--
-- Name: main_studentreason_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.main_studentreason_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_studentreason_id_seq OWNER TO demouser;

--
-- Name: main_studentreason_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.main_studentreason_id_seq OWNED BY public.main_studentreason.id;


--
-- Name: main_user; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.main_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    email character varying(254),
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    first_name character varying(40),
    last_name character varying(40),
    birth_date date,
    username character varying(50),
    gender character varying(25),
    status character varying(25) NOT NULL,
    phone_number character varying(25) NOT NULL,
    spend double precision,
    amount double precision,
    job_latitude double precision,
    job_longitude double precision,
    home_latitude double precision,
    home_longitude double precision,
    is_user boolean NOT NULL,
    create_at timestamp with time zone NOT NULL,
    update_at timestamp with time zone NOT NULL,
    module_id integer,
    role character varying(25) NOT NULL,
    middle_name character varying(40),
    passport_file character varying(100),
    photo character varying(100),
    salary bigint,
    salary_type character varying(40) NOT NULL
);


ALTER TABLE public.main_user OWNER TO demouser;

--
-- Name: main_user_achievments; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.main_user_achievments (
    id integer NOT NULL,
    user_id integer NOT NULL,
    achievment_id bigint NOT NULL
);


ALTER TABLE public.main_user_achievments OWNER TO demouser;

--
-- Name: main_user_achievments_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.main_user_achievments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_user_achievments_id_seq OWNER TO demouser;

--
-- Name: main_user_achievments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.main_user_achievments_id_seq OWNED BY public.main_user_achievments.id;


--
-- Name: main_user_groups; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.main_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.main_user_groups OWNER TO demouser;

--
-- Name: main_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.main_user_groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_user_groups_id_seq OWNER TO demouser;

--
-- Name: main_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.main_user_groups_id_seq OWNED BY public.main_user_groups.id;


--
-- Name: main_user_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.main_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_user_id_seq OWNER TO demouser;

--
-- Name: main_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.main_user_id_seq OWNED BY public.main_user.id;


--
-- Name: main_user_user_permissions; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.main_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.main_user_user_permissions OWNER TO demouser;

--
-- Name: main_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.main_user_user_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_user_user_permissions_id_seq OWNER TO demouser;

--
-- Name: main_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.main_user_user_permissions_id_seq OWNED BY public.main_user_user_permissions.id;


--
-- Name: main_user_variant; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.main_user_variant (
    id integer NOT NULL,
    user_id integer NOT NULL,
    variant_id integer NOT NULL
);


ALTER TABLE public.main_user_variant OWNER TO demouser;

--
-- Name: main_user_variant_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.main_user_variant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_user_variant_id_seq OWNER TO demouser;

--
-- Name: main_user_variant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.main_user_variant_id_seq OWNED BY public.main_user_variant.id;


--
-- Name: main_usertoken; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.main_usertoken (
    id integer NOT NULL,
    phone_number character varying(20),
    token character varying(10)
);


ALTER TABLE public.main_usertoken OWNER TO demouser;

--
-- Name: main_usertoken_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.main_usertoken_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_usertoken_id_seq OWNER TO demouser;

--
-- Name: main_usertoken_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.main_usertoken_id_seq OWNED BY public.main_usertoken.id;


--
-- Name: main_variant; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.main_variant (
    id integer NOT NULL,
    name character varying(300) NOT NULL,
    description text,
    icon character varying(100),
    create_at timestamp with time zone NOT NULL,
    update_at timestamp with time zone NOT NULL,
    question_id integer
);


ALTER TABLE public.main_variant OWNER TO demouser;

--
-- Name: main_variant_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.main_variant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.main_variant_id_seq OWNER TO demouser;

--
-- Name: main_variant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.main_variant_id_seq OWNED BY public.main_variant.id;


--
-- Name: paymeuz_transaction; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.paymeuz_transaction (
    id integer NOT NULL,
    trans_id character varying(255) NOT NULL,
    amount numeric(10,2) NOT NULL,
    account text,
    status character varying(10) NOT NULL,
    create_time timestamp with time zone NOT NULL,
    pay_time timestamp with time zone NOT NULL,
    request_id integer NOT NULL
);


ALTER TABLE public.paymeuz_transaction OWNER TO demouser;

--
-- Name: paymeuz_transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.paymeuz_transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.paymeuz_transaction_id_seq OWNER TO demouser;

--
-- Name: paymeuz_transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.paymeuz_transaction_id_seq OWNED BY public.paymeuz_transaction.id;


--
-- Name: subscription_invoice; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.subscription_invoice (
    id bigint NOT NULL,
    amount bigint,
    card_number bigint,
    create_at timestamp with time zone NOT NULL,
    update_at timestamp with time zone NOT NULL,
    module_id integer,
    subscription_id bigint,
    user_id integer NOT NULL
);


ALTER TABLE public.subscription_invoice OWNER TO demouser;

--
-- Name: subscription_invoice_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.subscription_invoice_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscription_invoice_id_seq OWNER TO demouser;

--
-- Name: subscription_invoice_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.subscription_invoice_id_seq OWNED BY public.subscription_invoice.id;


--
-- Name: subscription_operation; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.subscription_operation (
    id bigint NOT NULL,
    is_missed boolean NOT NULL,
    is_free boolean NOT NULL,
    create_at timestamp with time zone NOT NULL,
    group_id integer,
    subscription_id bigint,
    user_id integer NOT NULL,
    is_debt boolean NOT NULL
);


ALTER TABLE public.subscription_operation OWNER TO demouser;

--
-- Name: subscription_operation_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.subscription_operation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscription_operation_id_seq OWNER TO demouser;

--
-- Name: subscription_operation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.subscription_operation_id_seq OWNED BY public.subscription_operation.id;


--
-- Name: subscription_subscription; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.subscription_subscription (
    id bigint NOT NULL,
    start_date date,
    finish_date date,
    is_free boolean NOT NULL,
    is_active boolean NOT NULL,
    is_new character varying(50) NOT NULL,
    is_paid boolean NOT NULL,
    attendance integer NOT NULL,
    create_at timestamp with time zone NOT NULL,
    update_at timestamp with time zone NOT NULL,
    group_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE public.subscription_subscription OWNER TO demouser;

--
-- Name: subscription_subscription_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.subscription_subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscription_subscription_id_seq OWNER TO demouser;

--
-- Name: subscription_subscription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.subscription_subscription_id_seq OWNED BY public.subscription_subscription.id;


--
-- Name: subscription_wishlist; Type: TABLE; Schema: public; Owner: demouser
--

CREATE TABLE public.subscription_wishlist (
    id bigint NOT NULL,
    create_at timestamp with time zone NOT NULL,
    update_at timestamp with time zone NOT NULL,
    clas_id integer,
    module_id integer,
    user_id integer NOT NULL,
    is_like boolean NOT NULL
);


ALTER TABLE public.subscription_wishlist OWNER TO demouser;

--
-- Name: subscription_wishlist_id_seq; Type: SEQUENCE; Schema: public; Owner: demouser
--

CREATE SEQUENCE public.subscription_wishlist_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscription_wishlist_id_seq OWNER TO demouser;

--
-- Name: subscription_wishlist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demouser
--

ALTER SEQUENCE public.subscription_wishlist_id_seq OWNED BY public.subscription_wishlist.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN id SET DEFAULT nextval('public.auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('public.auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.auth_permission ALTER COLUMN id SET DEFAULT nextval('public.auth_permission_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.django_admin_log ALTER COLUMN id SET DEFAULT nextval('public.django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.django_content_type ALTER COLUMN id SET DEFAULT nextval('public.django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.django_migrations ALTER COLUMN id SET DEFAULT nextval('public.django_migrations_id_seq'::regclass);


--
-- Name: erp_main_achievment id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.erp_main_achievment ALTER COLUMN id SET DEFAULT nextval('public.erp_main_achievment_id_seq'::regclass);


--
-- Name: main_class id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_class ALTER COLUMN id SET DEFAULT nextval('public.main_class_id_seq'::regclass);


--
-- Name: main_classdate id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_classdate ALTER COLUMN id SET DEFAULT nextval('public.main_classdate_id_seq'::regclass);


--
-- Name: main_events id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_events ALTER COLUMN id SET DEFAULT nextval('public.main_events_id_seq'::regclass);


--
-- Name: main_group id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_group ALTER COLUMN id SET DEFAULT nextval('public.main_group_id_seq'::regclass);


--
-- Name: main_images id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_images ALTER COLUMN id SET DEFAULT nextval('public.main_images_id_seq'::regclass);


--
-- Name: main_level id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_level ALTER COLUMN id SET DEFAULT nextval('public.main_level_id_seq'::regclass);


--
-- Name: main_module id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_module ALTER COLUMN id SET DEFAULT nextval('public.main_module_id_seq'::regclass);


--
-- Name: main_module_facilities id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_module_facilities ALTER COLUMN id SET DEFAULT nextval('public.main_module_facilities_id_seq'::regclass);


--
-- Name: main_question id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_question ALTER COLUMN id SET DEFAULT nextval('public.main_question_id_seq'::regclass);


--
-- Name: main_recommendation id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_recommendation ALTER COLUMN id SET DEFAULT nextval('public.main_recommendation_id_seq'::regclass);


--
-- Name: main_review id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_review ALTER COLUMN id SET DEFAULT nextval('public.main_review_id_seq'::regclass);


--
-- Name: main_room id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_room ALTER COLUMN id SET DEFAULT nextval('public.main_room_id_seq'::regclass);


--
-- Name: main_room_group id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_room_group ALTER COLUMN id SET DEFAULT nextval('public.main_room_group_id_seq'::regclass);


--
-- Name: main_studentreason id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_studentreason ALTER COLUMN id SET DEFAULT nextval('public.main_studentreason_id_seq'::regclass);


--
-- Name: main_user id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_user ALTER COLUMN id SET DEFAULT nextval('public.main_user_id_seq'::regclass);


--
-- Name: main_user_achievments id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_user_achievments ALTER COLUMN id SET DEFAULT nextval('public.main_user_achievments_id_seq'::regclass);


--
-- Name: main_user_groups id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_user_groups ALTER COLUMN id SET DEFAULT nextval('public.main_user_groups_id_seq'::regclass);


--
-- Name: main_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('public.main_user_user_permissions_id_seq'::regclass);


--
-- Name: main_user_variant id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_user_variant ALTER COLUMN id SET DEFAULT nextval('public.main_user_variant_id_seq'::regclass);


--
-- Name: main_usertoken id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_usertoken ALTER COLUMN id SET DEFAULT nextval('public.main_usertoken_id_seq'::regclass);


--
-- Name: main_variant id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_variant ALTER COLUMN id SET DEFAULT nextval('public.main_variant_id_seq'::regclass);


--
-- Name: paymeuz_transaction id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.paymeuz_transaction ALTER COLUMN id SET DEFAULT nextval('public.paymeuz_transaction_id_seq'::regclass);


--
-- Name: subscription_invoice id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.subscription_invoice ALTER COLUMN id SET DEFAULT nextval('public.subscription_invoice_id_seq'::regclass);


--
-- Name: subscription_operation id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.subscription_operation ALTER COLUMN id SET DEFAULT nextval('public.subscription_operation_id_seq'::regclass);


--
-- Name: subscription_subscription id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.subscription_subscription ALTER COLUMN id SET DEFAULT nextval('public.subscription_subscription_id_seq'::regclass);


--
-- Name: subscription_wishlist id; Type: DEFAULT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.subscription_wishlist ALTER COLUMN id SET DEFAULT nextval('public.subscription_wishlist_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add content type	4	add_contenttype
14	Can change content type	4	change_contenttype
15	Can delete content type	4	delete_contenttype
16	Can view content type	4	view_contenttype
17	Can add session	5	add_session
18	Can change session	5	change_session
19	Can delete session	5	delete_session
20	Can view session	5	view_session
21	Can add user	6	add_user
22	Can change user	6	change_user
23	Can delete user	6	delete_user
24	Can view user	6	view_user
25	Can add class	7	add_class
26	Can change class	7	change_class
27	Can delete class	7	delete_class
28	Can view class	7	view_class
29	Can add events	8	add_events
30	Can change events	8	change_events
31	Can delete events	8	delete_events
32	Can view events	8	view_events
33	Can add level	9	add_level
34	Can change level	9	change_level
35	Can delete level	9	delete_level
36	Can view level	9	view_level
37	Can add module	10	add_module
38	Can change module	10	change_module
39	Can delete module	10	delete_module
40	Can view module	10	view_module
41	Can add question	11	add_question
42	Can change question	11	change_question
43	Can delete question	11	delete_question
44	Can view question	11	view_question
45	Can add recommendation	12	add_recommendation
46	Can change recommendation	12	change_recommendation
47	Can delete recommendation	12	delete_recommendation
48	Can view recommendation	12	view_recommendation
49	Can add room	13	add_room
50	Can change room	13	change_room
51	Can delete room	13	delete_room
52	Can view room	13	view_room
53	Can add user token	14	add_usertoken
54	Can change user token	14	change_usertoken
55	Can delete user token	14	delete_usertoken
56	Can view user token	14	view_usertoken
57	Can add variant	15	add_variant
58	Can change variant	15	change_variant
59	Can delete variant	15	delete_variant
60	Can view variant	15	view_variant
61	Can add review	16	add_review
62	Can change review	16	change_review
63	Can delete review	16	delete_review
64	Can view review	16	view_review
65	Can add images	17	add_images
66	Can change images	17	change_images
67	Can delete images	17	delete_images
68	Can view images	17	view_images
69	Can add group	18	add_group
70	Can change group	18	change_group
71	Can delete group	18	delete_group
72	Can view group	18	view_group
73	Can add class date	19	add_classdate
74	Can change class date	19	change_classdate
75	Can delete class date	19	delete_classdate
76	Can view class date	19	view_classdate
77	Can add wishlist	20	add_wishlist
78	Can change wishlist	20	change_wishlist
79	Can delete wishlist	20	delete_wishlist
80	Can view wishlist	20	view_wishlist
81	Can add subscription	21	add_subscription
82	Can change subscription	21	change_subscription
83	Can delete subscription	21	delete_subscription
84	Can view subscription	21	view_subscription
85	Can add operation	22	add_operation
86	Can change operation	22	change_operation
87	Can delete operation	22	delete_operation
88	Can view operation	22	view_operation
89	Can add Token	23	add_token
90	Can change Token	23	change_token
91	Can delete Token	23	delete_token
92	Can view Token	23	view_token
93	Can add token	24	add_tokenproxy
94	Can change token	24	change_tokenproxy
95	Can delete token	24	delete_tokenproxy
96	Can view token	24	view_tokenproxy
97	Can add transaction	25	add_transaction
98	Can change transaction	25	change_transaction
99	Can delete transaction	25	delete_transaction
100	Can view transaction	25	view_transaction
101	Can add invoice	26	add_invoice
102	Can change invoice	26	change_invoice
103	Can delete invoice	26	delete_invoice
104	Can view invoice	26	view_invoice
105	Can add student reason	27	add_studentreason
106	Can change student reason	27	change_studentreason
107	Can delete student reason	27	delete_studentreason
108	Can view student reason	27	view_studentreason
109	Can add achievment	28	add_achievment
110	Can change achievment	28	change_achievment
111	Can delete achievment	28	delete_achievment
112	Can view achievment	28	view_achievment
\.


--
-- Data for Name: authtoken_token; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.authtoken_token (key, created, user_id) FROM stdin;
52e204d289749729ee946e1d668b924f4e5104a8	2022-07-16 12:55:42.577722+05	2
2c058924d2eca2826d55e2af3d8b80becf6c3e60	2022-07-16 12:56:20.876607+05	3
4a8e748561978d8c4d80a03abe12f6ad5bc8b0c9	2022-07-16 13:03:46.188422+05	4
f8ba36777176fbf76e1ab749554550661274bc5f	2022-07-17 11:33:07.285012+05	5
279dba129b370b8c0f4c7985e2a53a9d0b668f30	2022-07-18 01:58:56.963872+05	6
9c089482e42d32b73c6d2aad26e3a33b8ad357bc	2022-07-18 16:38:37.422383+05	8
20bf19ae2a0995ba3c187d52274f3a575d57c6fe	2022-07-19 11:52:58.50706+05	9
8e6138172800458ec71ff7896940a2ec4dc91e27	2022-07-20 11:12:50.010315+05	1
d9911e9768d55ae5cc06eb5593a6f340500c51a0	2022-07-21 14:38:09.012657+05	11
9d4ec23aa8a6810cfde78138265cf398753cebb4	2022-07-23 12:59:52.655544+05	14
0df1c0abecf97e6a940e38682fa958bb3d999bd7	2022-07-24 13:01:51.549493+05	15
3a90cd1c69d4b9c7dc021a3b6a76ee950012f4fa	2022-07-24 20:27:05.295096+05	17
845461c994fe683033cb8cf0c0d48dec52d10a4a	2022-07-27 13:52:49.426295+05	23
9fd8c63d753de77b863f6cad1c9a66dcf020e116	2022-07-27 14:02:02.846501+05	26
cab9f1094d77495f3f464659930788a76c7ee644	2022-07-27 16:39:18.364727+05	35
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
1	2022-07-16 12:36:14.681112+05	3	My School	2	[{"changed": {"fields": ["Description"]}}]	10	1
2	2022-07-16 12:36:35.532689+05	2	new name	3		10	1
3	2022-07-16 12:36:35.535255+05	1	My School	3		10	1
4	2022-07-16 13:07:17.529224+05	5	Merit	2	[{"changed": {"fields": ["Description", "Logo"]}}]	10	1
5	2022-07-16 13:11:54.928961+05	15	Merit	2	[{"changed": {"fields": ["File"]}}]	17	1
6	2022-07-16 13:12:03.830749+05	14	Merit	2	[{"changed": {"fields": ["File"]}}]	17	1
7	2022-07-16 13:12:17.107013+05	13	Merit	2	[{"changed": {"fields": ["File"]}}]	17	1
8	2022-07-16 13:12:23.146864+05	18	English	2	[{"changed": {"fields": ["File"]}}]	17	1
9	2022-07-16 13:12:31.321919+05	17	English	2	[{"changed": {"fields": ["File"]}}]	17	1
10	2022-07-16 17:44:22.448782+05	1	С чем ассоциируется данный курс	2	[{"changed": {"fields": ["Name"]}}]	11	1
11	2022-07-16 18:16:13.226097+05	8	Выберите свою цель:	1	[{"added": {}}]	11	1
12	2022-07-16 18:17:00.377912+05	62	Изучение языка	1	[{"added": {}}]	15	1
13	2022-07-16 18:17:38.817227+05	63	Подготовка к экзаменам	1	[{"added": {}}]	15	1
14	2022-07-16 18:18:03.811919+05	64	Подготовка к университету	1	[{"added": {}}]	15	1
15	2022-07-16 18:18:26.907976+05	65	Подготовка к магистратуре	1	[{"added": {}}]	15	1
16	2022-07-16 18:19:00.473778+05	66	Для работы	1	[{"added": {}}]	15	1
17	2022-07-16 18:19:27.695714+05	55	Зона отдыха	2	[{"changed": {"fields": ["Icon"]}}]	15	1
18	2022-07-16 18:19:46.181777+05	54	Бесплатный Wi-Fi	2	[{"changed": {"fields": ["Icon"]}}]	15	1
19	2022-07-16 18:20:05.324269+05	51	Рядом с метро	2	[{"changed": {"fields": ["Icon"]}}]	15	1
20	2022-07-16 18:20:18.796093+05	53	Парковка	2	[{"changed": {"fields": ["Icon"]}}]	15	1
21	2022-07-16 18:20:46.182774+05	56	Кафе/бар/закусочная	2	[{"changed": {"fields": ["Icon"]}}]	15	1
22	2022-07-16 18:21:05.589521+05	58	Питьевая вода	2	[{"changed": {"fields": ["Icon"]}}]	15	1
23	2022-07-16 18:21:28.212752+05	50	Бесплатная канцелярия	2	[{"changed": {"fields": ["Icon"]}}]	15	1
24	2022-07-17 18:35:18.167941+05	4	Everest	2	[{"changed": {"fields": ["Description", "Logo"]}}]	10	1
25	2022-07-23 12:51:05.724201+05	34	2	3		19	1
26	2022-07-23 12:51:13.700438+05	31	2	3		19	1
27	2022-07-23 12:51:19.744337+05	28	2	3		19	1
28	2022-07-23 12:52:46.765002+05	30	2	3		19	1
29	2022-07-23 12:53:03.317875+05	29	2	3		19	1
30	2022-07-23 12:54:06.982825+05	32	2	3		19	1
31	2022-07-24 00:11:50.442768+05	4	Beginner	1	[{"added": {}}]	7	1
32	2022-07-24 20:35:45.663094+05	13	Y3	2	[{"changed": {"fields": ["Level"]}}]	18	1
33	2022-07-24 20:38:06.329234+05	15	W5	2	[{"changed": {"fields": ["Level"]}}]	18	1
34	2022-07-24 20:38:11.75208+05	14	H5	2	[{"changed": {"fields": ["Level"]}}]	18	1
35	2022-07-24 20:38:17.111346+05	10	M2	2	[{"changed": {"fields": ["Level"]}}]	18	1
36	2022-07-24 20:38:22.750852+05	9	M1	2	[{"changed": {"fields": ["Level"]}}]	18	1
37	2022-07-24 20:38:39.931168+05	7	S4	2	[{"changed": {"fields": ["Level"]}}]	18	1
38	2022-07-24 20:38:46.663219+05	8	S4	2	[{"changed": {"fields": ["Level"]}}]	18	1
39	2022-07-24 20:39:13.319854+05	12	I2	2	[{"changed": {"fields": ["Level"]}}]	18	1
40	2022-07-24 20:44:19.467963+05	11	B2	2	[{"changed": {"fields": ["Level"]}}]	18	1
41	2022-07-24 20:44:27.98241+05	6	E2	2	[{"changed": {"fields": ["Level"]}}]	18	1
42	2022-07-24 20:47:53.896769+05	11	B2	2	[{"changed": {"fields": ["Level"]}}]	18	1
43	2022-07-24 20:49:50.889329+05	11	B2	2	[{"changed": {"fields": ["Level"]}}]	18	1
44	2022-07-24 20:49:57.645484+05	11	B2	2	[]	18	1
45	2022-07-24 20:50:56.435733+05	16	Intermediate 2	1	[{"added": {}}]	18	1
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	contenttypes	contenttype
5	sessions	session
6	main	user
7	main	class
8	main	events
9	main	level
10	main	module
11	main	question
12	main	recommendation
13	main	room
14	main	usertoken
15	main	variant
16	main	review
17	main	images
18	main	group
19	main	classdate
20	subscription	wishlist
21	subscription	subscription
22	subscription	operation
23	authtoken	token
24	authtoken	tokenproxy
25	paymeuz	transaction
26	subscription	invoice
27	main	studentreason
28	erp_main	achievment
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2022-07-16 11:27:20.465095+05
2	contenttypes	0002_remove_content_type_name	2022-07-16 11:27:20.493452+05
3	auth	0001_initial	2022-07-16 11:27:20.603664+05
4	auth	0002_alter_permission_name_max_length	2022-07-16 11:27:20.618866+05
5	auth	0003_alter_user_email_max_length	2022-07-16 11:27:20.632597+05
6	auth	0004_alter_user_username_opts	2022-07-16 11:27:20.646585+05
7	auth	0005_alter_user_last_login_null	2022-07-16 11:27:20.659796+05
8	auth	0006_require_contenttypes_0002	2022-07-16 11:27:20.663366+05
9	auth	0007_alter_validators_add_error_messages	2022-07-16 11:27:20.677446+05
10	auth	0008_alter_user_username_max_length	2022-07-16 11:27:20.691785+05
11	auth	0009_alter_user_last_name_max_length	2022-07-16 11:27:20.708395+05
12	auth	0010_alter_group_name_max_length	2022-07-16 11:27:20.725496+05
13	auth	0011_update_proxy_permissions	2022-07-16 11:27:20.742749+05
14	auth	0012_alter_user_first_name_max_length	2022-07-16 11:27:20.758713+05
15	main	0001_initial	2022-07-16 11:27:21.543326+05
16	admin	0001_initial	2022-07-16 11:27:21.662098+05
17	admin	0002_logentry_remove_auto_add	2022-07-16 11:27:21.680468+05
18	admin	0003_logentry_add_action_flag_choices	2022-07-16 11:27:21.699037+05
19	authtoken	0001_initial	2022-07-16 11:27:21.751684+05
20	authtoken	0002_auto_20160226_1747	2022-07-16 11:27:21.828141+05
21	authtoken	0003_tokenproxy	2022-07-16 11:27:21.832122+05
22	main	0002_auto_20220715_0922	2022-07-16 11:27:21.878241+05
23	paymeuz	0001_initial	2022-07-16 11:27:21.895417+05
24	paymeuz	0002_auto_20200826_1127	2022-07-16 11:27:21.942769+05
25	paymeuz	0003_remove_transaction_state	2022-07-16 11:27:21.950918+05
26	sessions	0001_initial	2022-07-16 11:27:21.992638+05
27	subscription	0001_initial	2022-07-16 11:27:22.249889+05
28	subscription	0002_alter_subscription_is_new	2022-07-16 11:27:22.302579+05
29	subscription	0003_alter_subscription_is_new	2022-07-16 11:27:22.353903+05
30	main	0003_module_address	2022-07-16 12:33:17.727078+05
31	main	0004_auto_20220719_0740	2022-07-19 12:40:48.228618+05
32	main	0005_room_module	2022-07-21 12:03:16.238645+05
33	subscription	0004_invoice	2022-07-24 14:50:22.916688+05
34	subscription	0005_operation_is_debt	2022-07-24 17:50:39.224409+05
35	subscription	0006_wishlist_is_like	2022-07-24 18:44:53.56477+05
36	main	0002_group_module	2022-07-25 17:02:52.944573+05
37	main	0003_remove_class_video_group_number_of_lessons_per_month_and_more	2022-07-26 11:45:14.535685+05
38	main	0004_remove_module_user_group_clas_user_module_user_role_and_more	2022-07-26 18:11:30.09801+05
39	main	0005_module_is_active	2022-07-27 12:22:49.061417+05
40	main	0006_alter_user_role	2022-07-27 13:43:10.897529+05
41	erp_main	0001_initial	2022-07-27 16:19:00.212319+05
42	main	0007_user_achievments_user_middle_name_user_passport_file_and_more	2022-07-27 16:19:00.690183+05
43	main	0008_group_teachers_share	2022-07-27 17:25:01.957802+05
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
3qqi4w2tbfjntbc7491glqu47wjxulpx	.eJxVjEEOwiAQRe_C2hCYCp26dN8zNDMDSNVAUtqV8e7apAvd_vfef6mJtjVPW4vLNAd1UVadfjcmecSyg3CncqtaalmXmfWu6IM2PdYQn9fD_TvI1PK3diB96AKgiS6lHsEjge_EJRBDEUkwifERLPuBgROQZWfZnBGDGUS9P-rhOCc:1oCcKw:airxtl27YXBf0KvWvC_fsUm3QxmibZQFxwmytoE8nJo	2022-07-30 12:35:38.087746+05
63fkmyfzolxkh87rhtm7kf8ts0b9mnjq	.eJxVjDsOgzAQRO_iOrK867WBlOk5g-X1J5BEtoShinL3gESRdKN5b-YtnN_WyW0tLW6O4ipAXH479uGZygHiw5d7laGWdZlZHoo8aZNjjel1O92_g8m3aV9r1NBnVhk7ooC9Zu6yMkBZDSbrCNyjGYAsRWtDF6z1GXDPDDhgIvH5Ar0KNt8:1oFzZT:obRsf4k7G78jnUTWu3sjWe5OdKeu3ib9-M0waUxm5zE	2022-08-08 20:00:35.70963+05
\.


--
-- Data for Name: erp_main_achievment; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.erp_main_achievment (id, name, create_at, update_at) FROM stdin;
1	IELTS	2022-07-27 16:23:07.663042+05	2022-07-27 16:23:07.663134+05
2	TOEFL	2022-07-27 16:23:14.077872+05	2022-07-27 16:23:14.077892+05
4	Communication Skills	2022-07-27 16:23:46.701675+05	2022-07-27 16:23:46.702442+05
3	CEFR	2022-07-27 16:23:18.64646+05	2022-07-27 16:24:32.525821+05
\.


--
-- Data for Name: main_class; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.main_class (id, name, description, create_at, update_at, category_id, module_id) FROM stdin;
1	English	Description for courses	2022-07-16 12:34:34.856943+05	2022-07-16 12:34:34.85696+05	1	3
2	English	Description for courses	2022-07-16 12:46:24.816652+05	2022-07-16 12:46:24.816717+05	1	4
4	Beginner	This course for Beginner level of students	2022-07-24 00:11:50.435895+05	2022-07-24 00:11:50.435945+05	5	4
3	Ona tili	Ona tilimizni yaxshi bilish har bir fuqaro uchun juda zarur. auf !!	2022-07-16 12:53:11.870976+05	2022-07-26 15:50:49.56394+05	13	5
6	Ona tili	Ona tilimizni yaxshi bilish har bir fuqaro uchun juda zarur. auf !!	2022-07-26 19:44:53.631176+05	2022-07-26 19:44:53.63162+05	13	5
\.


--
-- Data for Name: main_classdate; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.main_classdate (id, week, status, start_date, finish_date, create_at, update_at, group_id, module_id) FROM stdin;
1	1,6	1	08:00:00	22:00:00	2022-07-16 12:34:34.854736+05	2022-07-16 12:34:34.854757+05	\N	3
2	5	2	14:00:00	16:00:00	2022-07-16 12:34:34.871533+05	2022-07-16 12:34:34.871571+05	1	\N
3	1	2	14:00:00	16:00:00	2022-07-16 12:34:34.873905+05	2022-07-16 12:34:34.873941+05	1	\N
4	3	2	14:00:00	16:00:00	2022-07-16 12:34:34.875965+05	2022-07-16 12:34:34.876001+05	1	\N
5	1	2	10:00:00	12:00:00	2022-07-16 12:34:34.879947+05	2022-07-16 12:34:34.879983+05	2	\N
6	3	2	10:00:00	12:00:00	2022-07-16 12:34:34.882058+05	2022-07-16 12:34:34.882093+05	2	\N
7	5	2	10:00:00	12:00:00	2022-07-16 12:34:34.88399+05	2022-07-16 12:34:34.884028+05	2	\N
8	1,6	1	09:00:00	20:00:00	2022-07-16 12:46:24.813612+05	2022-07-16 12:46:24.813646+05	\N	4
9	5	2	09:30:00	11:30:00	2022-07-16 12:46:24.834525+05	2022-07-16 12:46:24.834553+05	3	\N
10	1	2	09:30:00	11:30:00	2022-07-16 12:46:24.83633+05	2022-07-16 12:46:24.836358+05	3	\N
11	3	2	09:30:00	11:30:00	2022-07-16 12:46:24.837851+05	2022-07-16 12:46:24.837878+05	3	\N
12	1	2	10:00:00	12:00:00	2022-07-16 12:46:24.840906+05	2022-07-16 12:46:24.840937+05	4	\N
13	3	2	10:00:00	12:00:00	2022-07-16 12:46:24.842582+05	2022-07-16 12:46:24.842612+05	4	\N
14	5	2	10:00:00	12:00:00	2022-07-16 12:46:24.844381+05	2022-07-16 12:46:24.844412+05	4	\N
15	1,6	1	10:00:00	21:00:00	2022-07-16 12:53:11.8674+05	2022-07-16 12:53:11.86744+05	\N	5
16	5	2	09:30:00	11:30:00	2022-07-16 12:53:11.896125+05	2022-07-16 12:53:11.896274+05	5	\N
17	1	2	09:30:00	11:30:00	2022-07-16 12:53:11.898959+05	2022-07-16 12:53:11.898998+05	5	\N
18	3	2	09:30:00	11:30:00	2022-07-16 12:53:11.901287+05	2022-07-16 12:53:11.901324+05	5	\N
19	1	2	10:00:00	12:00:00	2022-07-16 12:53:11.905634+05	2022-07-16 12:53:11.90567+05	6	\N
20	3	2	10:00:00	12:00:00	2022-07-16 12:53:11.90773+05	2022-07-16 12:53:11.907766+05	6	\N
21	5	2	10:00:00	12:00:00	2022-07-16 12:53:11.910015+05	2022-07-16 12:53:11.91005+05	6	\N
22	1	2	14:00:00	16:00:00	2022-07-19 11:54:15.637792+05	2022-07-19 11:54:15.637857+05	4	\N
23	1	2	17:00:00	18:20:00	2022-07-19 11:55:18.787341+05	2022-07-19 11:55:18.787427+05	3	\N
24	1	2	17:00:00	19:00:00	2022-07-19 14:35:12.134099+05	2022-07-19 14:35:12.134185+05	8	\N
25	4	2	17:00:00	19:00:00	2022-07-19 19:48:20.26656+05	2022-07-19 19:48:20.266741+05	8	\N
26	6	2	17:00:00	19:00:00	2022-07-19 19:48:36.362266+05	2022-07-19 19:48:36.362401+05	6	\N
27	2	2	17:00:00	19:00:00	2022-07-19 19:48:43.908924+05	2022-07-19 19:48:43.909019+05	6	\N
33	1	2	14:00:00	15:00:00	2022-07-22 15:47:36.78901+05	2022-07-22 15:47:36.789165+05	9	\N
35	3	2	13:00:00	15:00:00	2022-07-22 15:48:50.806119+05	2022-07-22 15:48:50.806176+05	2	\N
36	3	2	13:00:00	15:00:00	2022-07-22 15:49:48.998249+05	2022-07-22 15:49:48.998341+05	10	\N
37	1	2	13:00:00	15:00:00	2022-07-22 15:49:53.235672+05	2022-07-22 15:49:53.235715+05	10	\N
38	5	2	13:00:00	15:00:00	2022-07-22 15:49:56.554274+05	2022-07-22 15:49:56.554332+05	10	\N
39	5	2	15:00:00	17:00:00	2022-07-22 15:56:41.243464+05	2022-07-22 15:56:41.243645+05	11	\N
40	3	2	15:00:00	17:00:00	2022-07-22 15:56:49.233781+05	2022-07-22 15:56:49.233895+05	11	\N
41	1	2	15:00:00	17:00:00	2022-07-22 15:56:58.561003+05	2022-07-22 15:56:58.561064+05	11	\N
42	1	2	15:00:00	17:00:00	2022-07-22 15:59:11.390896+05	2022-07-22 15:59:11.390929+05	12	\N
43	1	2	15:00:00	17:00:00	2022-07-22 16:00:31.20683+05	2022-07-22 16:00:31.206905+05	13	\N
44	5	2	12:00:00	17:00:00	2022-07-23 12:42:04.971053+05	2022-07-23 12:42:04.971251+05	14	\N
45	5	2	09:00:00	14:00:00	2022-07-23 12:43:31.237749+05	2022-07-23 12:43:31.237826+05	15	\N
46	1	2	13:00:00	15:00:00	2022-07-24 20:51:51.621318+05	2022-07-24 20:51:51.621377+05	16	\N
\.


--
-- Data for Name: main_events; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.main_events (id, name, description, date, is_new, status, create_at, update_at, clas_id) FROM stdin;
1	Bussines Training	Event for students of My School education center	2022-07-17	new	1-2 раза в неделю	2022-07-16 12:34:34.886943+05	2022-07-16 12:34:34.886982+05	1
2	Mock IELTS	Event for students of Events education center	2022-07-17	new	1-2 раза в неделю	2022-07-16 12:46:24.846811+05	2022-07-16 12:46:24.846838+05	2
3	Speaking Club	Event for students of Merit education center	2022-07-17	new	1-2 раза в неделю	2022-07-16 12:53:11.912252+05	2022-07-16 12:53:11.91229+05	3
\.


--
-- Data for Name: main_group; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.main_group (id, name, current_students_number, "limit", status, type_group, duration, create_at, update_at, level_id, module_id, number_of_lessons_per_month, clas_id, teachers_share) FROM stdin;
1	A1	10	10	open	group	\N	2022-07-16 12:34:34.868496+05	2022-07-16 12:34:34.868556+05	1	5	\N	\N	\N
5	G1	5	12	open	group	\N	2022-07-16 12:53:11.892924+05	2022-07-16 12:53:11.892965+05	3	5	\N	\N	\N
2	A2	12	10	waiting	group	\N	2022-07-16 12:34:34.877993+05	2022-07-16 13:30:25.087691+05	1	5	\N	\N	\N
4	E2	12	12	waiting	group	\N	2022-07-16 12:46:24.839307+05	2022-07-19 11:50:41.475785+05	2	5	\N	\N	\N
13	Y3	12	12	full	individual	\N	2022-07-22 16:00:18.804813+05	2022-07-24 20:35:45.659583+05	1	5	\N	\N	\N
15	W5	12	12	full	individual	\N	2022-07-23 12:43:06.623801+05	2022-07-24 20:38:06.324666+05	1	5	\N	\N	\N
14	H5	12	12	full	individual	\N	2022-07-23 12:40:51.623865+05	2022-07-24 20:38:11.748843+05	2	5	\N	\N	\N
10	M2	12	12	full	individual	\N	2022-07-22 15:49:34.169681+05	2022-07-24 20:38:17.107601+05	2	5	\N	\N	\N
9	M1	12	12	full	individual	\N	2022-07-22 15:40:58.994766+05	2022-07-24 20:38:22.747595+05	2	5	\N	\N	\N
7	S4	12	12	full	individual	\N	2022-07-19 11:53:02.121201+05	2022-07-24 20:38:39.927484+05	2	5	\N	\N	\N
8	S4	12	12	full	individual	\N	2022-07-19 14:34:37.86933+05	2022-07-24 20:38:46.659919+05	1	5	\N	\N	\N
12	I2	12	12	full	individual	\N	2022-07-22 15:58:45.542531+05	2022-07-24 20:39:13.31491+05	2	5	\N	\N	\N
6	E2	12	12	waiting	group	\N	2022-07-16 12:53:11.903428+05	2022-07-24 20:44:27.978509+05	2	5	\N	\N	\N
11	B2	12	12	full	individual	\N	2022-07-22 15:55:39.51435+05	2022-07-24 20:49:57.642133+05	5	5	\N	\N	\N
16	Intermediate 2	10	12	open	individual	3	2022-07-24 20:50:56.433034+05	2022-07-24 20:50:56.433083+05	4	5	\N	\N	\N
3	B2	12	12	full	individual	\N	2022-07-16 12:46:24.832216+05	2022-07-26 16:39:03.594198+05	2	5	\N	\N	\N
\.


--
-- Data for Name: main_images; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.main_images (id, file, create_at, update_at, clas_id, module_id) FROM stdin;
1	module/Screenshot_from_2022-07-14_13-36-49.png	2022-07-16 12:34:34.813663+05	2022-07-16 12:34:34.813687+05	\N	3
2	module/Screenshot_from_2022-07-14_13-36-49_5dsHl0Q.png	2022-07-16 12:34:34.830035+05	2022-07-16 12:34:34.830057+05	\N	3
3	module/Screenshot_from_2022-07-14_17-44-33.png	2022-07-16 12:34:34.839316+05	2022-07-16 12:34:34.839351+05	\N	3
4	module/Screenshot_from_2022-07-14_13-36-49_RvdJEPR.png	2022-07-16 12:34:34.859858+05	2022-07-16 12:34:34.859877+05	1	\N
5	module/Screenshot_from_2022-07-14_17-44-33_bD5wpJm.png	2022-07-16 12:34:34.86308+05	2022-07-16 12:34:34.863122+05	1	\N
6	module/Screenshot_from_2022-07-16_11-58-09.png	2022-07-16 12:34:34.865382+05	2022-07-16 12:34:34.8654+05	1	\N
7	module/Screenshot_from_2022-07-14_13-36-49_q5R98bZ.png	2022-07-16 12:46:24.78178+05	2022-07-16 12:46:24.781803+05	\N	4
8	module/Screenshot_from_2022-07-14_13-36-49_beH4tJp.png	2022-07-16 12:46:24.78543+05	2022-07-16 12:46:24.785452+05	\N	4
9	module/Screenshot_from_2022-07-14_17-44-33_dzWiwBK.png	2022-07-16 12:46:24.787585+05	2022-07-16 12:46:24.787607+05	\N	4
10	module/Screenshot_from_2022-07-14_13-36-49_riE8wM2.png	2022-07-16 12:46:24.821084+05	2022-07-16 12:46:24.821119+05	2	\N
11	module/Screenshot_from_2022-07-14_17-44-33_yixh4Mq.png	2022-07-16 12:46:24.824713+05	2022-07-16 12:46:24.82475+05	2	\N
12	module/Screenshot_from_2022-07-16_11-58-09_6dsVaU9.png	2022-07-16 12:46:24.827978+05	2022-07-16 12:46:24.828012+05	2	\N
16	module/Screenshot_from_2022-07-14_13-36-49_1AwZG20.png	2022-07-16 12:53:11.877649+05	2022-07-16 12:53:11.877695+05	3	\N
15	module/download.jpeg	2022-07-16 12:53:11.842446+05	2022-07-16 13:11:54.925053+05	\N	5
14	module/download_1.jpeg	2022-07-16 12:53:11.8383+05	2022-07-16 13:12:03.828307+05	\N	5
13	module/images_1.jpeg	2022-07-16 12:53:11.831283+05	2022-07-16 13:12:17.104077+05	\N	5
18	module/download_47uykZh.jpeg	2022-07-16 12:53:11.887449+05	2022-07-16 13:12:23.143591+05	3	\N
17	module/images.jpeg	2022-07-16 12:53:11.883292+05	2022-07-16 13:12:31.320365+05	3	\N
\.


--
-- Data for Name: main_level; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.main_level (id, name, duration, status, number_of_lessons, price, create_at, update_at, clas_id) FROM stdin;
1	Beginner	3	all	12	450000	2022-07-16 12:34:34.866437+05	2022-07-16 12:34:34.866454+05	1
2	Beginner	2	all	14	350000	2022-07-16 12:46:24.829906+05	2022-07-16 12:46:24.829938+05	2
4	intermediate	3	all	8	350000	2022-07-24 20:47:38.107445+05	2022-07-24 20:47:38.107501+05	3
5	advanced	3	all	8	350000	2022-07-24 20:49:42.173173+05	2022-07-24 20:49:42.173249+05	3
3	advanced	3	all	8	350000	2022-07-16 12:53:11.889777+05	2022-07-26 15:53:42.992014+05	3
\.


--
-- Data for Name: main_module; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.main_module (id, legal_name, password, contact_name, status, phone_number, description, logo, qr_code, location1, location2, create_at, update_at, address, bank_account, bank_name, director, email, established_year, inn, parent_firm_id, is_active) FROM stdin;
4	Everest	123	Admin Everest	active	+998932429263	Description for Novza education center	logo/download.png	qr_code/imageEverest.png	41.293395362293886	69.22289033082598	2022-07-16 12:46:24.7754+05	2022-07-17 18:35:18.161638+05	Toshkent shahar, Novza metrosi yaqinida	\N	\N	\N	\N	\N	\N	\N	t
3	My School	12	Admin MySchool	active	+998932429262	Description for My School education center	logo/photo_2022-07-16_11-31-07.jpg	qr_code/imageMy_School.png	41.30570225828447	69.26839192901788	2022-07-16 12:34:34.801964+05	2022-07-18 12:48:39.612685+05	Toshkent shahar, Komnavtlar metrosi yaqinida	\N	\N	\N	\N	\N	\N	\N	t
5	Merit	123	Admin Merit	potential	+998932429263	Description for Merit education center	logo/logo.jpeg	qr_code/imageMerit.png	41.36779556872779	69.29552262115604	2022-07-16 12:53:11.819259+05	2022-07-24 20:58:21.633237+05	Toshkent shahar, Yunusobod metrosi yaqinida	\N	\N	\N	\N	\N	\N	\N	t
\.


--
-- Data for Name: main_module_facilities; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.main_module_facilities (id, module_id, variant_id) FROM stdin;
1	3	54
2	3	53
3	3	60
4	4	53
5	4	60
6	4	57
7	4	61
8	5	60
9	5	57
10	5	61
\.


--
-- Data for Name: main_question; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.main_question (id, status, name, create_at, update_at) FROM stdin;
2	user	Ваш город	2022-07-16 11:38:32.97651+05	2022-07-16 11:38:32.976594+05
3	user	Как часто вы посещаете образовательные учреждения?	2022-07-16 11:38:46.92383+05	2022-07-16 11:38:46.923897+05
4	user	Покупаете ли вы абонемент в учебный центр или другие образовательные учреждения?	2022-07-16 11:38:56.705191+05	2022-07-16 11:38:56.705248+05
5	user	Если бы был тариф на сумму указанную выше, вы бы посещали эти секции?	2022-07-16 11:39:06.69493+05	2022-07-16 11:39:06.69496+05
6	user	Какие удобства для вас важны в учебных заведениях?	2022-07-16 11:39:20.71045+05	2022-07-16 11:39:20.710541+05
7	partner	Удобства	2022-07-16 11:39:34.685736+05	2022-07-16 11:39:34.685825+05
1	partner	С чем ассоциируется данный курс	2022-07-16 11:38:11.749091+05	2022-07-16 17:44:22.446997+05
8	user	Выберите свою цель:	2022-07-16 18:16:13.22257+05	2022-07-16 18:16:13.222624+05
\.


--
-- Data for Name: main_recommendation; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.main_recommendation (id, name, phone_number, create_at) FROM stdin;
1	Diyorbek	+998932429262	2022-07-17 18:36:24.221373+05
\.


--
-- Data for Name: main_review; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.main_review (id, comment, is_new, rate, create_at, update_at, clas_id, event_id, level_id, module_id, user_id) FROM stdin;
20	Lorem ipsum dolor sit amet, consectetur adipiscing elit hello.	old	4	2022-07-23 19:03:49.868875+05	2022-07-23 19:05:19.484453+05	\N	\N	\N	3	6
5	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ornare nec ipsum sed facilisis. Mauris ante urna, viverra ac purus ac.	old	5	2022-07-16 13:00:55.56626+05	2022-07-18 09:44:42.168096+05	2	\N	\N	\N	2
4	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ornare nec ipsum sed facilisis. Mauris ante urna, viverra ac purus ac.	old	3	2022-07-16 13:00:46.477823+05	2022-07-18 09:44:44.026279+05	2	\N	\N	\N	3
3	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ornare nec ipsum sed facilisis. Mauris ante urna, viverra ac purus ac.	old	4	2022-07-16 13:00:34.349912+05	2022-07-18 09:44:51.888836+05	3	\N	\N	\N	3
10	Lorem ipsum dolor sit amet, consectetur adipiscing elit.	old	4	2022-07-16 13:04:59.437095+05	2022-07-18 09:45:13.919477+05	\N	\N	\N	5	4
9	Lorem ipsum dolor sit amet, consectetur adipiscing elit.	old	4	2022-07-16 13:04:25.234159+05	2022-07-18 09:45:15.435871+05	\N	\N	\N	3	4
8	Lorem ipsum dolor sit amet, consectetur adipiscing elit.	old	5	2022-07-16 13:04:11.44263+05	2022-07-18 09:45:16.239592+05	\N	\N	\N	4	4
7	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ornare nec ipsum sed facilisis. Mauris ante urna, viverra ac purus ac.	old	3	2022-07-16 13:01:34.286322+05	2022-07-18 09:45:17.197525+05	\N	\N	\N	4	3
6	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ornare nec ipsum sed facilisis. Mauris ante urna, viverra ac purus ac.	old	3	2022-07-16 13:01:25.476573+05	2022-07-18 09:45:17.737929+05	\N	\N	\N	4	2
1	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ornare nec ipsum sed facilisis. Mauris ante urna, viverra ac purus ac, condimentum dignissim arcu. Cras vitae fringilla arcu. Suspendisse eget orci quis massa imperdiet sodales.	old	5	2022-07-16 13:00:06.796014+05	2022-07-18 10:07:23.911478+05	\N	\N	\N	3	2
12	This is a test by third user	old	2	2022-07-17 22:21:41.779971+05	2022-07-18 10:13:39.129271+05	\N	\N	\N	5	3
13	Good anakin, very good!	old	5	2022-07-17 22:33:23.573144+05	2022-07-20 22:15:33.578289+05	\N	\N	\N	5	2
11	This is a great place, recommend it!	old	5	2022-07-17 21:22:32.407592+05	2022-07-20 22:15:36.153274+05	\N	\N	\N	3	1
2	Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean ornare nec ipsum sed facilisis. Mauris ante urna, viverra ac purus ac.	old	4	2022-07-16 13:00:27.119891+05	2022-07-21 19:43:41.298093+05	\N	\N	\N	3	3
18	Lorem ipsum dolor sit amet, consectetur adipiscing elit hello.	old	4	2022-07-23 18:50:41.452777+05	2022-07-23 18:57:00.127131+05	\N	\N	\N	5	5
19	Lorem ipsum dolor sit amet, consectetur adipiscing elit hello.	old	4	2022-07-23 18:54:22.229083+05	2022-07-23 19:01:26.820834+05	\N	\N	\N	3	5
\.


--
-- Data for Name: main_room; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.main_room (id, name, create_at, update_at, module_id) FROM stdin;
11	Room 1	2022-07-21 12:38:46.345692+05	2022-07-21 12:38:46.345725+05	3
5	Room 6	2022-07-19 14:31:41.24119+05	2022-07-25 13:15:58.827003+05	5
7	new Room	2022-07-20 19:54:50.371213+05	2022-07-25 13:16:19.045829+05	5
3	Room 3	2022-07-16 13:30:03.977213+05	2022-07-25 15:17:04.658214+05	5
4	Room 4	2022-07-16 13:30:07.14133+05	2022-07-25 15:17:58.325131+05	5
13	hp	2022-07-25 15:16:25.44332+05	2022-07-25 18:17:22.051049+05	5
\.


--
-- Data for Name: main_room_group; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.main_room_group (id, room_id, group_id) FROM stdin;
3	3	4
6	5	2
7	5	4
33	4	4
34	4	7
41	4	8
43	3	8
47	11	5
53	3	6
54	3	7
57	3	2
58	3	10
59	3	11
60	3	12
61	3	13
66	5	16
67	7	5
68	7	16
69	4	16
\.


--
-- Data for Name: main_studentreason; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.main_studentreason (id, event_id, group_id, reason_id, user_id) FROM stdin;
\.


--
-- Data for Name: main_user; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.main_user (id, password, last_login, is_superuser, email, is_staff, is_active, date_joined, first_name, last_name, birth_date, username, gender, status, phone_number, spend, amount, job_latitude, job_longitude, home_latitude, home_longitude, is_user, create_at, update_at, module_id, role, middle_name, passport_file, photo, salary, salary_type) FROM stdin;
2		\N	f		f	t	2022-07-16 12:55:42.561726+05	Diyorbek	Yuldashev	2001-05-23	+99893345700	male	potential	+99893345700	150000	100000	\N	\N	\N	\N	f	2022-07-16 12:55:42.562492+05	2022-07-16 12:55:42.573414+05	\N	student	\N	\N	\N	\N	not_given
15		\N	f		f	t	2022-07-24 13:01:51.539561+05	\N	\N	\N	\N	\N	potential	+998 99 4977920	\N	\N	\N	\N	\N	\N	t	2022-07-24 13:01:51.542779+05	2022-07-24 13:01:51.544355+05	\N	student	\N	\N	\N	\N	not_given
3		\N	f		f	t	2022-07-16 12:56:20.863169+05	Abdulloh	Shokirov	1998-05-23	+998998423108	male	potential	+998998423108	150000	100000	\N	\N	\N	\N	f	2022-07-16 12:56:20.86369+05	2022-07-16 12:56:20.873552+05	\N	student	\N	\N	\N	\N	not_given
9		\N	f		f	t	2022-07-19 11:52:58.49806+05	\N	\N	\N	\N	\N	potential	+998 88 7803635	\N	\N	\N	\N	\N	\N	t	2022-07-19 11:52:58.498959+05	2022-07-24 13:28:15.983791+05	\N	student	\N	\N	\N	\N	not_given
6		\N	f		f	t	2022-07-18 01:58:56.956429+05	\N	\N	\N	\N	\N	potential	935620707	\N	\N	\N	\N	\N	\N	t	2022-07-18 01:58:56.957241+05	2022-07-18 01:58:56.95895+05	\N	student	\N	\N	\N	\N	not_given
17		\N	f		f	t	2022-07-24 20:27:05.279207+05	Fresh	Doktor	2009-07-22	\N	female	potential	+998935620707	\N	\N	\N	\N	\N	\N	t	2022-07-24 20:27:05.280909+05	2022-07-24 20:27:44.355029+05	\N	student	\N	\N	\N	\N	not_given
11		\N	f		f	t	2022-07-21 14:38:08.995696+05	dd	fff	1999-12-12	\N	male	potential	+998908181183	\N	\N	\N	\N	\N	\N	t	2022-07-21 14:38:08.9975+05	2022-07-23 16:36:14.134174+05	\N	student	\N	\N	\N	\N	not_given
8		\N	f		f	t	2022-07-18 16:38:37.408713+05	Asdas	dsaDAS	2001-05-23	\N	male	potential	+998887803635	\N	\N	25.1548561	23.4578541	25.1548561	23.4578541	t	2022-07-18 16:38:37.410514+05	2022-07-21 12:41:46.073094+05	\N	student	\N	\N	\N	\N	not_given
1	pbkdf2_sha256$320000$ygau2TQoOz9LIM8HdpzWOu$hHZscSQfv7f6Ch6CjR+4UrdDQQ71KJI4PQSmG9dRJIc=	2022-07-25 20:00:35.602642+05	t		t	t	2022-07-16 12:35:29.132785+05	Diyorbek	Yuldashev	2001-05-23	admin	male	potential		\N	\N	\N	\N	\N	\N	t	2022-07-16 12:35:29.349759+05	2022-07-22 11:36:51.610522+05	\N	student	\N	\N	\N	\N	not_given
23	123123	\N	f		f	t	2022-07-27 13:43:14.163639+05	Mannopov	Ulug'bek	1999-05-23	\N	male	potential	+998909551775	\N	\N	\N	\N	\N	\N	f	2022-07-27 13:43:14.16431+05	2022-07-27 13:43:14.16432+05	\N	staff	\N	\N	\N	\N	not_given
24		\N	f		f	t	2022-07-27 14:00:52.456275+05	Azizbek	Azizov	1999-05-23	+998909551770	male	potential	+998909551770	\N	\N	\N	\N	\N	\N	f	2022-07-27 14:00:52.456914+05	2022-07-27 14:00:52.456928+05	\N	student	\N	\N	\N	\N	not_given
25		\N	f		f	t	2022-07-27 14:01:16.142065+05	Azizbek	Azizov	1999-05-23	+998909551771	male	potential	+998909551771	\N	\N	\N	\N	\N	\N	f	2022-07-27 14:01:16.142545+05	2022-07-27 14:01:16.142553+05	\N	student	\N	\N	\N	\N	not_given
26	123123	\N	f		f	t	2022-07-27 14:01:47.575155+05	Azizbek	Azizov	1999-05-23	\N	male	potential	+998909551761	\N	\N	\N	\N	\N	\N	f	2022-07-27 14:01:47.576165+05	2022-07-27 14:01:47.576181+05	5	staff	\N	\N	\N	\N	not_given
4		\N	f		f	t	2022-07-16 13:03:46.152443+05	Mannopov	Ulug'bek	1999-05-23	+998909551776	male	potential	+998909551776	150000	100000	\N	\N	\N	\N	t	2022-07-16 13:03:46.154995+05	2022-07-27 14:29:46.303906+05	5	staff	\N	\N	\N	\N	not_given
5	new_passwor	\N	f		f	t	2022-07-17 11:33:07.279863+05	Diyorbek	Yuldashev	2001-02-23	\N	male	partner	+998932429262	\N	\N	\N	\N	\N	\N	f	2022-07-17 11:33:07.280521+05	2022-07-27 14:51:56.910079+05	5	staff	\N	\N	\N	\N	not_given
35	mypassword	\N	f	diyorbeky610@gmail.com	f	f	2022-07-27 16:38:44.251884+05	Alexander	Walker	1999-05-23	+998910234567	\N	potential	+998910234567	\N	\N	\N	\N	\N	\N	f	2022-07-27 16:38:44.254206+05	2022-07-27 16:38:44.254223+05	5	staff	Johns	passports/Muhammads_Resume.pdf	profile/profile.jpg	5000000	fixed
14	mypassword	\N	f	diyorbeky610@gmail.com	f	t	2022-07-23 12:59:52.640293+05	Alexander	Walker	1999-05-23	+998910234566	\N	potential	+998910234566	\N	\N	\N	\N	\N	\N	t	2022-07-23 12:59:52.642015+05	2022-07-27 17:12:39.40647+05	5	staff	Johns		profile/profile_J441TlN.jpg	5000000	fixed
\.


--
-- Data for Name: main_user_achievments; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.main_user_achievments (id, user_id, achievment_id) FROM stdin;
1	35	1
2	35	3
3	14	1
4	14	3
\.


--
-- Data for Name: main_user_groups; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.main_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: main_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.main_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: main_user_variant; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.main_user_variant (id, user_id, variant_id) FROM stdin;
1	2	1
2	2	3
3	2	5
4	3	1
5	3	3
6	3	5
7	4	1
8	4	3
9	4	5
19	8	1
20	8	3
21	8	5
59	1	1
60	1	3
61	1	5
68	17	20
69	17	64
70	17	10
71	17	16
\.


--
-- Data for Name: main_usertoken; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.main_usertoken (id, phone_number, token) FROM stdin;
1	935620707	50
2	+998998423108	6422
3	935620707	83
4	935620707	92
5	935620707	36
6	935620707	06
7	+998935620707	49
8	935620707	11
9	+998932429262	4560
10	+998932429262	7314
11	+998932429262	0917
12	+998932429262	5065
13	+998932429262	9399
14	+998932429262	3495
15	+998932429262	2529
268	+998935620707	3151
158	225222222	2783
159	225222222	1897
160	225222222	7202
161	222222	4655
162	222222	8016
163	222222	6498
164	222222	9641
165	222222	9387
166	222222	4684
167	222222222	6248
168	3232323	2768
169	222222	1856
170	2222223	0737
32	+998932429262	1207
33	+998932429262	9144
34	+998932429262	4830
35	+998932429262	7602
171	2222223	0895
37	+998932429262	5384
172	55525552	1905
39	+998887803635	1383
40	+998887803635	2831
41	+998 88 7803635	4747
42	+998 88 7803635	4380
43	+998 88 7803635	7773
44	7773	4249
45		5287
46	7773	0876
47	+998111111111	5288
49	+998 88 7803635	5449
50	5449	4504
175	+998908181183	5960
53	+998 88 7803635	4161
55	+998 88 7803635	9337
56	+998 88 7803635	8459
57	+998 88 7803635	7400
58	+998 88 7803635	5057
59	+998 88 7803635	5594
177	+9988181183	2338
65	+998 22 2222222	4480
66	+998 88 7803635	3128
67	+998 88 7803635	1418
182	+998935620707	7462
69	+998 88 7803635	8547
70	+998 88 7803635	0698
71	+998 88 7803635	8767
183	+998935620707	9550
73	+998	8301
74	+998	7820
75	+998	9960
76	+998	2389
77	+998	3227
78	+998	1093
184	+998935620707	3741
80	+998	6848
81	+998	8399
185	935620707	6084
83	+998	3876
186	935620707	4174
85	+998	2360
86	+998	6832
87	+998	9048
88	+998	0809
187	+998935620707	5047
90	+998 88 7803635	6958
91	+998	9593
188	935620707	9287
93	+998	3963
94	+998	6329
95	+998	3913
96	+998	8549
97	+998	1000
98	+998	9349
99	+998	3386
100	+998	8642
101	+998	6482
102	+998	6218
103	+998	0476
104	+998	3949
105	+998	6761
106	+998	1008
107	+998	0165
108	+998	0192
109	+998	8671
110	+998	9389
111	+998	3467
112	+998	8217
113	+998	5628
114	+998	3791
115	+998	8062
116	+998	7021
192	+998908181183	5152
121	+998 88 7803635	3242
193	+998908181183	9132
194	+998908181183	2412
127	+998 88 7803635	1730
198	+998908181183	2268
129	+998 88 7803635	6832
137	+998 88 7803635	2796
209	+998996980648	4805
218	+998908181183	2882
219	+998908181183	7426
221	+998908181183	6320
241	+998908181183	9194
242	+998908181183	1249
244	+998908181183	2938
245	+998908181183	9724
247	+998908181183	3512
248	+998908181183	6207
\.


--
-- Data for Name: main_variant; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.main_variant (id, name, description, icon, create_at, update_at, question_id) FROM stdin;
1	Английский язык	\N		2022-07-16 11:38:11.755101+05	2022-07-16 11:38:11.755137+05	1
2	Подготовка к IELTS	\N		2022-07-16 11:38:11.759684+05	2022-07-16 11:38:11.759729+05	1
3	Подготовка к TOEFL	\N		2022-07-16 11:38:11.762949+05	2022-07-16 11:38:11.762982+05	1
4	Подготовка к CEFR	\N		2022-07-16 11:38:11.764882+05	2022-07-16 11:38:11.764912+05	1
5	Математика	\N		2022-07-16 11:38:11.766776+05	2022-07-16 11:38:11.766807+05	1
6	Ментальная арифметика	\N		2022-07-16 11:38:11.768521+05	2022-07-16 11:38:11.768566+05	1
7	Корейский язык	\N		2022-07-16 11:38:11.770425+05	2022-07-16 11:38:11.770454+05	1
8	Немецкий язык	\N		2022-07-16 11:38:11.77212+05	2022-07-16 11:38:11.772148+05	1
9	Французский язык	\N		2022-07-16 11:38:11.77372+05	2022-07-16 11:38:11.773747+05	1
10	Португальский язык	\N		2022-07-16 11:38:11.775216+05	2022-07-16 11:38:11.775245+05	1
11	Арабский язык	\N		2022-07-16 11:38:11.776781+05	2022-07-16 11:38:11.776811+05	1
12	Турецкий язык	\N		2022-07-16 11:38:11.778274+05	2022-07-16 11:38:11.778302+05	1
13	Китайский язык	\N		2022-07-16 11:38:11.779804+05	2022-07-16 11:38:11.779831+05	1
14	Японский язык	\N		2022-07-16 11:38:11.781364+05	2022-07-16 11:38:11.781392+05	1
15	Другие языки	\N		2022-07-16 11:38:11.782885+05	2022-07-16 11:38:11.782913+05	1
16	Почемучка	\N		2022-07-16 11:38:11.784444+05	2022-07-16 11:38:11.784472+05	1
17	Подготовка к университету	\N		2022-07-16 11:38:11.785956+05	2022-07-16 11:38:11.785984+05	1
18	Языки программирования	\N		2022-07-16 11:38:11.787634+05	2022-07-16 11:38:11.787663+05	1
19	Веб и графический дизайн	\N		2022-07-16 11:38:11.789268+05	2022-07-16 11:38:11.789295+05	1
20	Ташкент	\N		2022-07-16 11:38:32.979772+05	2022-07-16 11:38:32.979796+05	2
21	Ташкентская область	\N		2022-07-16 11:38:32.981873+05	2022-07-16 11:38:32.981919+05	2
22	Андижанская область	\N		2022-07-16 11:38:32.983041+05	2022-07-16 11:38:32.983057+05	2
23	Бухарская область	\N		2022-07-16 11:38:32.983962+05	2022-07-16 11:38:32.983978+05	2
24	Джизакская область	\N		2022-07-16 11:38:32.984889+05	2022-07-16 11:38:32.984905+05	2
25	Кашкадарьинская область	\N		2022-07-16 11:38:32.985773+05	2022-07-16 11:38:32.985788+05	2
26	Навоийская область	\N		2022-07-16 11:38:32.986745+05	2022-07-16 11:38:32.98676+05	2
27	Наманганская область	\N		2022-07-16 11:38:32.987649+05	2022-07-16 11:38:32.987664+05	2
28	Самаркандская область	\N		2022-07-16 11:38:32.988539+05	2022-07-16 11:38:32.988563+05	2
29	Сурхандарьинская область	\N		2022-07-16 11:38:32.989448+05	2022-07-16 11:38:32.989482+05	2
30	Сырдарьинская область	\N		2022-07-16 11:38:32.990335+05	2022-07-16 11:38:32.99035+05	2
31	Ферганская область	\N		2022-07-16 11:38:32.991237+05	2022-07-16 11:38:32.991252+05	2
32	Хорезмская область	\N		2022-07-16 11:38:32.992269+05	2022-07-16 11:38:32.992284+05	2
33	Республика Каракалпакстан	\N		2022-07-16 11:38:32.993089+05	2022-07-16 11:38:32.993104+05	2
34	Каждый день	\N		2022-07-16 11:38:46.935197+05	2022-07-16 11:38:46.935218+05	3
35	Через день	\N		2022-07-16 11:38:46.937298+05	2022-07-16 11:38:46.937318+05	3
36	1-2 раза в неделю	\N		2022-07-16 11:38:46.938501+05	2022-07-16 11:38:46.93852+05	3
37	1 раз в месяц	\N		2022-07-16 11:38:46.939567+05	2022-07-16 11:38:46.939585+05	3
38	Другая частота посещения	\N		2022-07-16 11:38:46.940576+05	2022-07-16 11:38:46.940594+05	3
39	Не посещаю учебные заведения	\N		2022-07-16 11:38:46.941579+05	2022-07-16 11:38:46.941597+05	3
40	Да	\N		2022-07-16 11:38:56.707585+05	2022-07-16 11:38:56.707602+05	4
41	Нет	\N		2022-07-16 11:38:56.709171+05	2022-07-16 11:38:56.709187+05	4
42	Да	\N		2022-07-16 11:39:06.697134+05	2022-07-16 11:39:06.697151+05	5
43	Нет	\N		2022-07-16 11:39:06.698816+05	2022-07-16 11:39:06.698833+05	5
44	Парковка	\N		2022-07-16 11:39:20.717836+05	2022-07-16 11:39:20.717878+05	6
45	Бесплатный Wi-Fi	\N		2022-07-16 11:39:20.722384+05	2022-07-16 11:39:20.722425+05	6
46	Зона отдыха	\N		2022-07-16 11:39:20.724601+05	2022-07-16 11:39:20.724643+05	6
47	Кафе/бар/закусочная	\N		2022-07-16 11:39:20.726043+05	2022-07-16 11:39:20.726083+05	6
48	Фито-бар	\N		2022-07-16 11:39:20.727372+05	2022-07-16 11:39:20.727394+05	6
49	Питьевая вода	\N		2022-07-16 11:39:20.728983+05	2022-07-16 11:39:20.729027+05	6
52	Бесплатные полотенца	\N		2022-07-16 11:39:20.734561+05	2022-07-16 11:39:20.734604+05	6
57	Фито-бар	\N		2022-07-16 11:39:34.699108+05	2022-07-16 11:39:34.699141+05	7
59	Бесплатная канцелярия	\N		2022-07-16 11:39:34.70274+05	2022-07-16 11:39:34.702771+05	7
60	Рядом с метро	\N		2022-07-16 11:39:34.7045+05	2022-07-16 11:39:34.704532+05	7
61	Бесплатные полотенца	\N		2022-07-16 11:39:34.706267+05	2022-07-16 11:39:34.706298+05	7
62	Изучение языка	Изучать иностранные языки	icons/Frame_ws7xPNd.png	2022-07-16 18:17:00.374623+05	2022-07-16 18:17:00.374652+05	8
63	Подготовка к экзаменам	IELTS, TOEFL, GMAT и другие	icons/Frame_1_Ub6gqS0.png	2022-07-16 18:17:38.814775+05	2022-07-16 18:17:38.814818+05	8
64	Подготовка к университету	Все необходимое для абитуриента	icons/Frame_2_AKPawoQ.png	2022-07-16 18:18:03.81046+05	2022-07-16 18:18:03.810487+05	8
65	Подготовка к магистратуре	Пройти самые продвинутые курсы	icons/Frame_3_9HtymC5.png	2022-07-16 18:18:26.906629+05	2022-07-16 18:18:26.906656+05	8
66	Для работы	Подтянуть профессиональные знания	icons/Frame_4_OfP9K8D.png	2022-07-16 18:19:00.471819+05	2022-07-16 18:19:00.471844+05	8
55	Зона отдыха		icons/Frame_11_425J5aH.png	2022-07-16 11:39:34.695231+05	2022-07-16 18:19:27.694075+05	7
54	Бесплатный Wi-Fi		icons/Frame_9_LEYnqal.png	2022-07-16 11:39:34.693189+05	2022-07-16 18:19:46.180329+05	7
51	Рядом с метро		icons/Frame_8_Cf6Z2xc.png	2022-07-16 11:39:20.732696+05	2022-07-16 18:20:05.322872+05	6
53	Парковка		icons/Frame_5_Dtqphzq.png	2022-07-16 11:39:34.68997+05	2022-07-16 18:20:18.792892+05	7
56	Кафе/бар/закусочная		icons/Frame_10_XYpACGT.png	2022-07-16 11:39:34.697267+05	2022-07-16 18:20:46.179974+05	7
58	Питьевая вода		icons/Frame_6_N1KCEdW.png	2022-07-16 11:39:34.700917+05	2022-07-16 18:21:05.586437+05	7
50	Бесплатная канцелярия		icons/Frame_7_x8MIYjn.png	2022-07-16 11:39:20.730867+05	2022-07-16 18:21:28.20966+05	6
\.


--
-- Data for Name: paymeuz_transaction; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.paymeuz_transaction (id, trans_id, amount, account, status, create_time, pay_time, request_id) FROM stdin;
1	62dcf65cf0ca6ccd1c9164c1	500.00	[]	1	2022-07-24 12:35:56.62046+05	2022-07-24 12:35:56.935233+05	4
2	62dd08758cb675f01c71646c	500.00	[]	1	2022-07-24 13:53:09.88647+05	2022-07-24 13:53:10.072086+05	4
3	62dd11848cb675f01c71b794	500.00	[]	1	2022-07-24 14:31:48.602459+05	2022-07-24 14:31:49.283494+05	13
4	62dd18e2186aebd41c347878	500.00	[]	1	2022-07-24 15:03:14.066376+05	2022-07-24 15:03:21.614684+05	13
5	62dd6bac8cb675f01c74a4fa	500.00	[]	1	2022-07-24 20:56:28.278838+05	2022-07-24 20:56:29.101658+05	17
6	62dd70e7f04050dd1c2719ff	500.00	[]	1	2022-07-24 21:18:47.415682+05	2022-07-24 21:18:48.220112+05	17
\.


--
-- Data for Name: subscription_invoice; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.subscription_invoice (id, amount, card_number, create_at, update_at, module_id, subscription_id, user_id) FROM stdin;
2	550000	9860350109483742	2022-07-24 20:56:29.277954+05	2022-07-24 20:56:29.277997+05	5	23	17
3	450000	9860350109483742	2022-07-24 21:18:48.367926+05	2022-07-24 21:18:48.367971+05	3	24	17
\.


--
-- Data for Name: subscription_operation; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.subscription_operation (id, is_missed, is_free, create_at, group_id, subscription_id, user_id, is_debt) FROM stdin;
1	f	f	2022-07-16 13:27:26.013869+05	2	2	3	f
2	f	f	2022-07-16 13:27:32.628877+05	2	3	3	f
3	f	f	2022-07-16 13:27:40.161278+05	2	3	2	f
5	f	t	2022-07-24 08:35:24.731343+05	2	10	1	f
6	f	f	2022-07-24 09:23:38.89123+05	2	9	1	f
7	f	f	2022-07-24 09:25:04.697525+05	2	2	1	f
8	f	f	2022-07-24 21:20:30.607872+05	2	24	17	f
\.


--
-- Data for Name: subscription_subscription; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.subscription_subscription (id, start_date, finish_date, is_free, is_active, is_new, is_paid, attendance, create_at, update_at, group_id, user_id) FROM stdin;
1	2022-07-06	2022-09-06	f	t	new	t	0	2022-07-16 13:26:41.300466+05	2022-07-16 13:26:41.300505+05	3	2
4	2022-07-06	2022-09-06	f	t	new	t	0	2022-07-16 13:27:01.384543+05	2022-07-16 13:27:01.38458+05	4	3
5	2022-07-06	2022-09-06	f	t	new	t	0	2022-07-16 13:27:09.446252+05	2022-07-16 13:27:09.446277+05	3	4
6	2022-07-06	2022-09-06	f	t	old	t	1	2022-07-16 13:27:13.116272+05	2022-07-24 08:33:01.878639+05	1	4
10	2022-07-06	2022-09-06	t	t	old	t	1	2022-07-23 19:08:26.599737+05	2022-07-24 08:35:24.736664+05	2	4
9	2022-07-06	2022-09-06	f	t	old	t	1	2022-07-23 19:07:10.50413+05	2022-07-24 09:23:38.898352+05	2	4
2	2022-07-06	2022-09-06	f	t	old	t	2	2022-07-16 13:26:51.218348+05	2022-07-24 09:25:04.702856+05	2	2
14	\N	\N	f	t	new	t	0	2022-07-24 10:56:24.769813+05	2022-07-24 10:56:24.76988+05	5	4
23	\N	\N	f	t	new	t	0	2022-07-24 20:56:29.257903+05	2022-07-24 20:56:29.257991+05	5	17
24	2022-07-24	2022-08-23	f	t	new	t	1	2022-07-24 21:18:48.348452+05	2022-07-24 21:20:30.615833+05	2	17
3	2022-07-06	2022-09-06	f	t	old	t	2	2022-07-16 13:26:56.349111+05	2022-07-23 19:05:31.602411+05	2	3
7	2022-07-06	2022-09-06	f	t	new	t	0	2022-07-23 19:07:02.603607+05	2022-07-23 19:07:02.603686+05	3	4
8	2022-07-06	2022-09-06	f	t	new	t	0	2022-07-23 19:07:07.186749+05	2022-07-23 19:07:07.186843+05	5	4
11	2022-07-06	2022-09-06	t	t	new	t	0	2022-07-23 19:09:48.092903+05	2022-07-23 19:09:48.092984+05	2	5
12	2022-07-06	2022-09-06	t	t	new	t	0	2022-07-23 19:10:00.438755+05	2022-07-23 19:10:00.438825+05	2	5
13	2022-07-06	2022-09-06	t	t	old	t	0	2022-07-23 19:10:04.643274+05	2022-07-23 19:10:15.963569+05	2	1
\.


--
-- Data for Name: subscription_wishlist; Type: TABLE DATA; Schema: public; Owner: demouser
--

COPY public.subscription_wishlist (id, create_at, update_at, clas_id, module_id, user_id, is_like) FROM stdin;
1	2022-07-16 13:24:40.71385+05	2022-07-16 13:24:40.713938+05	\N	3	4	t
2	2022-07-16 13:24:55.015963+05	2022-07-16 13:24:55.01603+05	\N	3	3	t
3	2022-07-16 13:25:02.612749+05	2022-07-16 13:25:02.612781+05	\N	4	2	t
4	2022-07-16 13:25:11.3212+05	2022-07-16 13:25:11.321347+05	\N	4	4	t
5	2022-07-16 13:25:26.456892+05	2022-07-16 13:25:26.456935+05	2	\N	3	t
6	2022-07-16 13:25:46.547089+05	2022-07-16 13:25:46.547177+05	1	\N	4	t
7	2022-07-18 00:19:23.617473+05	2022-07-18 00:19:23.617621+05	\N	3	4	t
8	2022-07-18 01:01:29.473849+05	2022-07-18 01:01:29.473992+05	\N	3	4	t
9	2022-07-18 01:01:45.04909+05	2022-07-18 01:01:45.049155+05	\N	3	4	t
10	2022-07-18 01:02:58.381069+05	2022-07-18 01:02:58.381132+05	3	\N	4	t
11	2022-07-18 01:06:25.704101+05	2022-07-18 01:06:25.704239+05	2	\N	4	t
12	2022-07-23 16:43:43.374299+05	2022-07-23 16:43:43.374379+05	\N	5	4	t
14	2022-07-23 16:48:57.465453+05	2022-07-23 16:48:57.465541+05	3	\N	4	t
18	2022-07-24 18:16:07.587823+05	2022-07-24 18:16:07.587935+05	3	\N	3	t
27	2022-07-24 19:15:30.224015+05	2022-07-24 19:26:35.272104+05	\N	5	6	f
29	2022-07-24 19:28:51.929949+05	2022-07-24 19:29:04.049648+05	\N	4	6	f
30	2022-07-24 20:28:05.133456+05	2022-07-24 20:28:10.044904+05	3	\N	17	f
31	2022-07-24 20:28:30.56895+05	2022-07-24 20:28:46.82335+05	\N	5	17	f
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 112, true);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 45, true);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 28, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 43, true);


--
-- Name: erp_main_achievment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.erp_main_achievment_id_seq', 4, true);


--
-- Name: main_class_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.main_class_id_seq', 6, true);


--
-- Name: main_classdate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.main_classdate_id_seq', 46, true);


--
-- Name: main_events_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.main_events_id_seq', 3, true);


--
-- Name: main_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.main_group_id_seq', 16, true);


--
-- Name: main_images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.main_images_id_seq', 18, true);


--
-- Name: main_level_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.main_level_id_seq', 5, true);


--
-- Name: main_module_facilities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.main_module_facilities_id_seq', 10, true);


--
-- Name: main_module_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.main_module_id_seq', 5, true);


--
-- Name: main_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.main_question_id_seq', 8, true);


--
-- Name: main_recommendation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.main_recommendation_id_seq', 1, true);


--
-- Name: main_review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.main_review_id_seq', 23, true);


--
-- Name: main_room_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.main_room_group_id_seq', 70, true);


--
-- Name: main_room_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.main_room_id_seq', 13, true);


--
-- Name: main_studentreason_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.main_studentreason_id_seq', 1, false);


--
-- Name: main_user_achievments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.main_user_achievments_id_seq', 4, true);


--
-- Name: main_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.main_user_groups_id_seq', 1, false);


--
-- Name: main_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.main_user_id_seq', 35, true);


--
-- Name: main_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.main_user_user_permissions_id_seq', 1, false);


--
-- Name: main_user_variant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.main_user_variant_id_seq', 71, true);


--
-- Name: main_usertoken_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.main_usertoken_id_seq', 279, true);


--
-- Name: main_variant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.main_variant_id_seq', 66, true);


--
-- Name: paymeuz_transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.paymeuz_transaction_id_seq', 6, true);


--
-- Name: subscription_invoice_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.subscription_invoice_id_seq', 3, true);


--
-- Name: subscription_operation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.subscription_operation_id_seq', 8, true);


--
-- Name: subscription_subscription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.subscription_subscription_id_seq', 24, true);


--
-- Name: subscription_wishlist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demouser
--

SELECT pg_catalog.setval('public.subscription_wishlist_id_seq', 31, true);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: authtoken_token authtoken_token_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_pkey PRIMARY KEY (key);


--
-- Name: authtoken_token authtoken_token_user_id_key; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_key UNIQUE (user_id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: erp_main_achievment erp_main_achievment_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.erp_main_achievment
    ADD CONSTRAINT erp_main_achievment_pkey PRIMARY KEY (id);


--
-- Name: main_class main_class_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_class
    ADD CONSTRAINT main_class_pkey PRIMARY KEY (id);


--
-- Name: main_classdate main_classdate_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_classdate
    ADD CONSTRAINT main_classdate_pkey PRIMARY KEY (id);


--
-- Name: main_events main_events_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_events
    ADD CONSTRAINT main_events_pkey PRIMARY KEY (id);


--
-- Name: main_group main_group_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_group
    ADD CONSTRAINT main_group_pkey PRIMARY KEY (id);


--
-- Name: main_images main_images_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_images
    ADD CONSTRAINT main_images_pkey PRIMARY KEY (id);


--
-- Name: main_level main_level_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_level
    ADD CONSTRAINT main_level_pkey PRIMARY KEY (id);


--
-- Name: main_module_facilities main_module_facilities_module_id_variant_id_28950415_uniq; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_module_facilities
    ADD CONSTRAINT main_module_facilities_module_id_variant_id_28950415_uniq UNIQUE (module_id, variant_id);


--
-- Name: main_module_facilities main_module_facilities_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_module_facilities
    ADD CONSTRAINT main_module_facilities_pkey PRIMARY KEY (id);


--
-- Name: main_module main_module_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_module
    ADD CONSTRAINT main_module_pkey PRIMARY KEY (id);


--
-- Name: main_question main_question_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_question
    ADD CONSTRAINT main_question_pkey PRIMARY KEY (id);


--
-- Name: main_recommendation main_recommendation_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_recommendation
    ADD CONSTRAINT main_recommendation_pkey PRIMARY KEY (id);


--
-- Name: main_review main_review_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_review
    ADD CONSTRAINT main_review_pkey PRIMARY KEY (id);


--
-- Name: main_room_group main_room_group_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_room_group
    ADD CONSTRAINT main_room_group_pkey PRIMARY KEY (id);


--
-- Name: main_room_group main_room_group_room_id_group_id_0376db9e_uniq; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_room_group
    ADD CONSTRAINT main_room_group_room_id_group_id_0376db9e_uniq UNIQUE (room_id, group_id);


--
-- Name: main_room main_room_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_room
    ADD CONSTRAINT main_room_pkey PRIMARY KEY (id);


--
-- Name: main_studentreason main_studentreason_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_studentreason
    ADD CONSTRAINT main_studentreason_pkey PRIMARY KEY (id);


--
-- Name: main_user_achievments main_user_achievments_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_user_achievments
    ADD CONSTRAINT main_user_achievments_pkey PRIMARY KEY (id);


--
-- Name: main_user_achievments main_user_achievments_user_id_achievment_id_d753b9ac_uniq; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_user_achievments
    ADD CONSTRAINT main_user_achievments_user_id_achievment_id_d753b9ac_uniq UNIQUE (user_id, achievment_id);


--
-- Name: main_user_groups main_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_user_groups
    ADD CONSTRAINT main_user_groups_pkey PRIMARY KEY (id);


--
-- Name: main_user_groups main_user_groups_user_id_group_id_ae195797_uniq; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_user_groups
    ADD CONSTRAINT main_user_groups_user_id_group_id_ae195797_uniq UNIQUE (user_id, group_id);


--
-- Name: main_user main_user_phone_number_key; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_user
    ADD CONSTRAINT main_user_phone_number_key UNIQUE (phone_number);


--
-- Name: main_user main_user_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_user
    ADD CONSTRAINT main_user_pkey PRIMARY KEY (id);


--
-- Name: main_user_user_permissions main_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_user_user_permissions
    ADD CONSTRAINT main_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: main_user_user_permissions main_user_user_permissions_user_id_permission_id_96b9fadf_uniq; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_user_user_permissions
    ADD CONSTRAINT main_user_user_permissions_user_id_permission_id_96b9fadf_uniq UNIQUE (user_id, permission_id);


--
-- Name: main_user main_user_username_key; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_user
    ADD CONSTRAINT main_user_username_key UNIQUE (username);


--
-- Name: main_user_variant main_user_variant_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_user_variant
    ADD CONSTRAINT main_user_variant_pkey PRIMARY KEY (id);


--
-- Name: main_user_variant main_user_variant_user_id_variant_id_97ef8047_uniq; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_user_variant
    ADD CONSTRAINT main_user_variant_user_id_variant_id_97ef8047_uniq UNIQUE (user_id, variant_id);


--
-- Name: main_usertoken main_usertoken_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_usertoken
    ADD CONSTRAINT main_usertoken_pkey PRIMARY KEY (id);


--
-- Name: main_variant main_variant_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_variant
    ADD CONSTRAINT main_variant_pkey PRIMARY KEY (id);


--
-- Name: paymeuz_transaction paymeuz_transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.paymeuz_transaction
    ADD CONSTRAINT paymeuz_transaction_pkey PRIMARY KEY (id);


--
-- Name: subscription_invoice subscription_invoice_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.subscription_invoice
    ADD CONSTRAINT subscription_invoice_pkey PRIMARY KEY (id);


--
-- Name: subscription_operation subscription_operation_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.subscription_operation
    ADD CONSTRAINT subscription_operation_pkey PRIMARY KEY (id);


--
-- Name: subscription_subscription subscription_subscription_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.subscription_subscription
    ADD CONSTRAINT subscription_subscription_pkey PRIMARY KEY (id);


--
-- Name: subscription_wishlist subscription_wishlist_pkey; Type: CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.subscription_wishlist
    ADD CONSTRAINT subscription_wishlist_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: authtoken_token_key_10f0b77e_like; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX authtoken_token_key_10f0b77e_like ON public.authtoken_token USING btree (key varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: main_class_category_id_641b93f4; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_class_category_id_641b93f4 ON public.main_class USING btree (category_id);


--
-- Name: main_class_module_id_6d6b2cbf; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_class_module_id_6d6b2cbf ON public.main_class USING btree (module_id);


--
-- Name: main_classdate_group_id_691e2c78; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_classdate_group_id_691e2c78 ON public.main_classdate USING btree (group_id);


--
-- Name: main_classdate_module_id_e73cf408; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_classdate_module_id_e73cf408 ON public.main_classdate USING btree (module_id);


--
-- Name: main_events_clas_id_34f5a09b; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_events_clas_id_34f5a09b ON public.main_events USING btree (clas_id);


--
-- Name: main_group_clas_id_42e774e1; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_group_clas_id_42e774e1 ON public.main_group USING btree (clas_id);


--
-- Name: main_group_level_id_f4c440b3; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_group_level_id_f4c440b3 ON public.main_group USING btree (level_id);


--
-- Name: main_group_module_id_5e569c92; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_group_module_id_5e569c92 ON public.main_group USING btree (module_id);


--
-- Name: main_images_clas_id_24dd6c88; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_images_clas_id_24dd6c88 ON public.main_images USING btree (clas_id);


--
-- Name: main_images_module_id_419fa6d1; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_images_module_id_419fa6d1 ON public.main_images USING btree (module_id);


--
-- Name: main_level_clas_id_783ea278; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_level_clas_id_783ea278 ON public.main_level USING btree (clas_id);


--
-- Name: main_module_facilities_module_id_ea8afd9f; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_module_facilities_module_id_ea8afd9f ON public.main_module_facilities USING btree (module_id);


--
-- Name: main_module_facilities_variant_id_42306049; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_module_facilities_variant_id_42306049 ON public.main_module_facilities USING btree (variant_id);


--
-- Name: main_module_parent_firm_id_beee30a7; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_module_parent_firm_id_beee30a7 ON public.main_module USING btree (parent_firm_id);


--
-- Name: main_review_clas_id_e2b2dd07; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_review_clas_id_e2b2dd07 ON public.main_review USING btree (clas_id);


--
-- Name: main_review_event_id_b7ca6d87; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_review_event_id_b7ca6d87 ON public.main_review USING btree (event_id);


--
-- Name: main_review_level_id_e5e21fcb; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_review_level_id_e5e21fcb ON public.main_review USING btree (level_id);


--
-- Name: main_review_module_id_80f39d1a; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_review_module_id_80f39d1a ON public.main_review USING btree (module_id);


--
-- Name: main_review_user_id_ee71ed52; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_review_user_id_ee71ed52 ON public.main_review USING btree (user_id);


--
-- Name: main_room_group_group_id_81afbfa6; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_room_group_group_id_81afbfa6 ON public.main_room_group USING btree (group_id);


--
-- Name: main_room_group_room_id_c321b3cd; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_room_group_room_id_c321b3cd ON public.main_room_group USING btree (room_id);


--
-- Name: main_room_module_id_64a7084a; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_room_module_id_64a7084a ON public.main_room USING btree (module_id);


--
-- Name: main_studentreason_event_id_d037ebeb; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_studentreason_event_id_d037ebeb ON public.main_studentreason USING btree (event_id);


--
-- Name: main_studentreason_group_id_87a3dd9b; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_studentreason_group_id_87a3dd9b ON public.main_studentreason USING btree (group_id);


--
-- Name: main_studentreason_reason_id_2cd1af83; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_studentreason_reason_id_2cd1af83 ON public.main_studentreason USING btree (reason_id);


--
-- Name: main_studentreason_user_id_d7c34098; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_studentreason_user_id_d7c34098 ON public.main_studentreason USING btree (user_id);


--
-- Name: main_user_achievments_achievment_id_f2a0c75a; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_user_achievments_achievment_id_f2a0c75a ON public.main_user_achievments USING btree (achievment_id);


--
-- Name: main_user_achievments_user_id_c389ebca; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_user_achievments_user_id_c389ebca ON public.main_user_achievments USING btree (user_id);


--
-- Name: main_user_groups_group_id_a337ba62; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_user_groups_group_id_a337ba62 ON public.main_user_groups USING btree (group_id);


--
-- Name: main_user_groups_user_id_df502602; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_user_groups_user_id_df502602 ON public.main_user_groups USING btree (user_id);


--
-- Name: main_user_module_id_5a38c54a; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_user_module_id_5a38c54a ON public.main_user USING btree (module_id);


--
-- Name: main_user_phone_number_58947ae4_like; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_user_phone_number_58947ae4_like ON public.main_user USING btree (phone_number varchar_pattern_ops);


--
-- Name: main_user_user_permissions_permission_id_cd2b56a3; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_user_user_permissions_permission_id_cd2b56a3 ON public.main_user_user_permissions USING btree (permission_id);


--
-- Name: main_user_user_permissions_user_id_451ce57f; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_user_user_permissions_user_id_451ce57f ON public.main_user_user_permissions USING btree (user_id);


--
-- Name: main_user_username_6330637b_like; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_user_username_6330637b_like ON public.main_user USING btree (username varchar_pattern_ops);


--
-- Name: main_user_variant_user_id_3b25bab5; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_user_variant_user_id_3b25bab5 ON public.main_user_variant USING btree (user_id);


--
-- Name: main_user_variant_variant_id_e6d9f87d; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_user_variant_variant_id_e6d9f87d ON public.main_user_variant USING btree (variant_id);


--
-- Name: main_variant_question_id_406e3ee8; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX main_variant_question_id_406e3ee8 ON public.main_variant USING btree (question_id);


--
-- Name: subscription_invoice_module_id_cb9c7c04; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX subscription_invoice_module_id_cb9c7c04 ON public.subscription_invoice USING btree (module_id);


--
-- Name: subscription_invoice_subscription_id_a7162549; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX subscription_invoice_subscription_id_a7162549 ON public.subscription_invoice USING btree (subscription_id);


--
-- Name: subscription_invoice_user_id_bdf0fca8; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX subscription_invoice_user_id_bdf0fca8 ON public.subscription_invoice USING btree (user_id);


--
-- Name: subscription_operation_group_id_4cab0fc3; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX subscription_operation_group_id_4cab0fc3 ON public.subscription_operation USING btree (group_id);


--
-- Name: subscription_operation_subscription_id_b4021a49; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX subscription_operation_subscription_id_b4021a49 ON public.subscription_operation USING btree (subscription_id);


--
-- Name: subscription_operation_user_id_3da3011f; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX subscription_operation_user_id_3da3011f ON public.subscription_operation USING btree (user_id);


--
-- Name: subscription_subscription_group_id_ee602ed0; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX subscription_subscription_group_id_ee602ed0 ON public.subscription_subscription USING btree (group_id);


--
-- Name: subscription_subscription_user_id_ff2293c7; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX subscription_subscription_user_id_ff2293c7 ON public.subscription_subscription USING btree (user_id);


--
-- Name: subscription_wishlist_clas_id_b096ecb1; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX subscription_wishlist_clas_id_b096ecb1 ON public.subscription_wishlist USING btree (clas_id);


--
-- Name: subscription_wishlist_module_id_d331b7b2; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX subscription_wishlist_module_id_d331b7b2 ON public.subscription_wishlist USING btree (module_id);


--
-- Name: subscription_wishlist_user_id_fda7c692; Type: INDEX; Schema: public; Owner: demouser
--

CREATE INDEX subscription_wishlist_user_id_fda7c692 ON public.subscription_wishlist USING btree (user_id);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: authtoken_token authtoken_token_user_id_35299eff_fk_main_user_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.authtoken_token
    ADD CONSTRAINT authtoken_token_user_id_35299eff_fk_main_user_id FOREIGN KEY (user_id) REFERENCES public.main_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_main_user_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_main_user_id FOREIGN KEY (user_id) REFERENCES public.main_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_class main_class_category_id_641b93f4_fk_main_variant_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_class
    ADD CONSTRAINT main_class_category_id_641b93f4_fk_main_variant_id FOREIGN KEY (category_id) REFERENCES public.main_variant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_class main_class_module_id_6d6b2cbf_fk_main_module_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_class
    ADD CONSTRAINT main_class_module_id_6d6b2cbf_fk_main_module_id FOREIGN KEY (module_id) REFERENCES public.main_module(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_classdate main_classdate_group_id_691e2c78_fk_main_group_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_classdate
    ADD CONSTRAINT main_classdate_group_id_691e2c78_fk_main_group_id FOREIGN KEY (group_id) REFERENCES public.main_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_classdate main_classdate_module_id_e73cf408_fk_main_module_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_classdate
    ADD CONSTRAINT main_classdate_module_id_e73cf408_fk_main_module_id FOREIGN KEY (module_id) REFERENCES public.main_module(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_events main_events_clas_id_34f5a09b_fk_main_class_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_events
    ADD CONSTRAINT main_events_clas_id_34f5a09b_fk_main_class_id FOREIGN KEY (clas_id) REFERENCES public.main_class(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_group main_group_clas_id_42e774e1_fk_main_class_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_group
    ADD CONSTRAINT main_group_clas_id_42e774e1_fk_main_class_id FOREIGN KEY (clas_id) REFERENCES public.main_class(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_group main_group_level_id_f4c440b3_fk_main_level_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_group
    ADD CONSTRAINT main_group_level_id_f4c440b3_fk_main_level_id FOREIGN KEY (level_id) REFERENCES public.main_level(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_group main_group_module_id_5e569c92_fk_main_module_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_group
    ADD CONSTRAINT main_group_module_id_5e569c92_fk_main_module_id FOREIGN KEY (module_id) REFERENCES public.main_module(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_images main_images_clas_id_24dd6c88_fk_main_class_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_images
    ADD CONSTRAINT main_images_clas_id_24dd6c88_fk_main_class_id FOREIGN KEY (clas_id) REFERENCES public.main_class(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_images main_images_module_id_419fa6d1_fk_main_module_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_images
    ADD CONSTRAINT main_images_module_id_419fa6d1_fk_main_module_id FOREIGN KEY (module_id) REFERENCES public.main_module(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_level main_level_clas_id_783ea278_fk_main_class_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_level
    ADD CONSTRAINT main_level_clas_id_783ea278_fk_main_class_id FOREIGN KEY (clas_id) REFERENCES public.main_class(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_module_facilities main_module_facilities_module_id_ea8afd9f_fk_main_module_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_module_facilities
    ADD CONSTRAINT main_module_facilities_module_id_ea8afd9f_fk_main_module_id FOREIGN KEY (module_id) REFERENCES public.main_module(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_module_facilities main_module_facilities_variant_id_42306049_fk_main_variant_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_module_facilities
    ADD CONSTRAINT main_module_facilities_variant_id_42306049_fk_main_variant_id FOREIGN KEY (variant_id) REFERENCES public.main_variant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_module main_module_parent_firm_id_beee30a7_fk_main_module_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_module
    ADD CONSTRAINT main_module_parent_firm_id_beee30a7_fk_main_module_id FOREIGN KEY (parent_firm_id) REFERENCES public.main_module(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_review main_review_clas_id_e2b2dd07_fk_main_class_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_review
    ADD CONSTRAINT main_review_clas_id_e2b2dd07_fk_main_class_id FOREIGN KEY (clas_id) REFERENCES public.main_class(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_review main_review_event_id_b7ca6d87_fk_main_events_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_review
    ADD CONSTRAINT main_review_event_id_b7ca6d87_fk_main_events_id FOREIGN KEY (event_id) REFERENCES public.main_events(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_review main_review_level_id_e5e21fcb_fk_main_level_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_review
    ADD CONSTRAINT main_review_level_id_e5e21fcb_fk_main_level_id FOREIGN KEY (level_id) REFERENCES public.main_level(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_review main_review_module_id_80f39d1a_fk_main_module_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_review
    ADD CONSTRAINT main_review_module_id_80f39d1a_fk_main_module_id FOREIGN KEY (module_id) REFERENCES public.main_module(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_review main_review_user_id_ee71ed52_fk_main_user_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_review
    ADD CONSTRAINT main_review_user_id_ee71ed52_fk_main_user_id FOREIGN KEY (user_id) REFERENCES public.main_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_room_group main_room_group_group_id_81afbfa6_fk_main_group_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_room_group
    ADD CONSTRAINT main_room_group_group_id_81afbfa6_fk_main_group_id FOREIGN KEY (group_id) REFERENCES public.main_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_room_group main_room_group_room_id_c321b3cd_fk_main_room_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_room_group
    ADD CONSTRAINT main_room_group_room_id_c321b3cd_fk_main_room_id FOREIGN KEY (room_id) REFERENCES public.main_room(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_room main_room_module_id_64a7084a_fk_main_module_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_room
    ADD CONSTRAINT main_room_module_id_64a7084a_fk_main_module_id FOREIGN KEY (module_id) REFERENCES public.main_module(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_studentreason main_studentreason_event_id_d037ebeb_fk_main_events_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_studentreason
    ADD CONSTRAINT main_studentreason_event_id_d037ebeb_fk_main_events_id FOREIGN KEY (event_id) REFERENCES public.main_events(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_studentreason main_studentreason_group_id_87a3dd9b_fk_main_group_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_studentreason
    ADD CONSTRAINT main_studentreason_group_id_87a3dd9b_fk_main_group_id FOREIGN KEY (group_id) REFERENCES public.main_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_studentreason main_studentreason_reason_id_2cd1af83_fk_main_variant_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_studentreason
    ADD CONSTRAINT main_studentreason_reason_id_2cd1af83_fk_main_variant_id FOREIGN KEY (reason_id) REFERENCES public.main_variant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_studentreason main_studentreason_user_id_d7c34098_fk_main_user_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_studentreason
    ADD CONSTRAINT main_studentreason_user_id_d7c34098_fk_main_user_id FOREIGN KEY (user_id) REFERENCES public.main_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_user_achievments main_user_achievment_achievment_id_f2a0c75a_fk_erp_main_; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_user_achievments
    ADD CONSTRAINT main_user_achievment_achievment_id_f2a0c75a_fk_erp_main_ FOREIGN KEY (achievment_id) REFERENCES public.erp_main_achievment(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_user_achievments main_user_achievments_user_id_c389ebca_fk_main_user_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_user_achievments
    ADD CONSTRAINT main_user_achievments_user_id_c389ebca_fk_main_user_id FOREIGN KEY (user_id) REFERENCES public.main_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_user_groups main_user_groups_group_id_a337ba62_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_user_groups
    ADD CONSTRAINT main_user_groups_group_id_a337ba62_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_user_groups main_user_groups_user_id_df502602_fk_main_user_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_user_groups
    ADD CONSTRAINT main_user_groups_user_id_df502602_fk_main_user_id FOREIGN KEY (user_id) REFERENCES public.main_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_user main_user_module_id_5a38c54a_fk_main_module_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_user
    ADD CONSTRAINT main_user_module_id_5a38c54a_fk_main_module_id FOREIGN KEY (module_id) REFERENCES public.main_module(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_user_user_permissions main_user_user_permi_permission_id_cd2b56a3_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_user_user_permissions
    ADD CONSTRAINT main_user_user_permi_permission_id_cd2b56a3_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_user_user_permissions main_user_user_permissions_user_id_451ce57f_fk_main_user_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_user_user_permissions
    ADD CONSTRAINT main_user_user_permissions_user_id_451ce57f_fk_main_user_id FOREIGN KEY (user_id) REFERENCES public.main_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_user_variant main_user_variant_user_id_3b25bab5_fk_main_user_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_user_variant
    ADD CONSTRAINT main_user_variant_user_id_3b25bab5_fk_main_user_id FOREIGN KEY (user_id) REFERENCES public.main_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_user_variant main_user_variant_variant_id_e6d9f87d_fk_main_variant_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_user_variant
    ADD CONSTRAINT main_user_variant_variant_id_e6d9f87d_fk_main_variant_id FOREIGN KEY (variant_id) REFERENCES public.main_variant(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: main_variant main_variant_question_id_406e3ee8_fk_main_question_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.main_variant
    ADD CONSTRAINT main_variant_question_id_406e3ee8_fk_main_question_id FOREIGN KEY (question_id) REFERENCES public.main_question(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: subscription_invoice subscription_invoice_module_id_cb9c7c04_fk_main_module_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.subscription_invoice
    ADD CONSTRAINT subscription_invoice_module_id_cb9c7c04_fk_main_module_id FOREIGN KEY (module_id) REFERENCES public.main_module(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: subscription_invoice subscription_invoice_subscription_id_a7162549_fk_subscript; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.subscription_invoice
    ADD CONSTRAINT subscription_invoice_subscription_id_a7162549_fk_subscript FOREIGN KEY (subscription_id) REFERENCES public.subscription_subscription(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: subscription_invoice subscription_invoice_user_id_bdf0fca8_fk_main_user_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.subscription_invoice
    ADD CONSTRAINT subscription_invoice_user_id_bdf0fca8_fk_main_user_id FOREIGN KEY (user_id) REFERENCES public.main_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: subscription_operation subscription_operati_subscription_id_b4021a49_fk_subscript; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.subscription_operation
    ADD CONSTRAINT subscription_operati_subscription_id_b4021a49_fk_subscript FOREIGN KEY (subscription_id) REFERENCES public.subscription_subscription(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: subscription_operation subscription_operation_group_id_4cab0fc3_fk_main_group_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.subscription_operation
    ADD CONSTRAINT subscription_operation_group_id_4cab0fc3_fk_main_group_id FOREIGN KEY (group_id) REFERENCES public.main_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: subscription_operation subscription_operation_user_id_3da3011f_fk_main_user_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.subscription_operation
    ADD CONSTRAINT subscription_operation_user_id_3da3011f_fk_main_user_id FOREIGN KEY (user_id) REFERENCES public.main_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: subscription_subscription subscription_subscription_group_id_ee602ed0_fk_main_group_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.subscription_subscription
    ADD CONSTRAINT subscription_subscription_group_id_ee602ed0_fk_main_group_id FOREIGN KEY (group_id) REFERENCES public.main_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: subscription_subscription subscription_subscription_user_id_ff2293c7_fk_main_user_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.subscription_subscription
    ADD CONSTRAINT subscription_subscription_user_id_ff2293c7_fk_main_user_id FOREIGN KEY (user_id) REFERENCES public.main_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: subscription_wishlist subscription_wishlist_clas_id_b096ecb1_fk_main_class_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.subscription_wishlist
    ADD CONSTRAINT subscription_wishlist_clas_id_b096ecb1_fk_main_class_id FOREIGN KEY (clas_id) REFERENCES public.main_class(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: subscription_wishlist subscription_wishlist_module_id_d331b7b2_fk_main_module_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.subscription_wishlist
    ADD CONSTRAINT subscription_wishlist_module_id_d331b7b2_fk_main_module_id FOREIGN KEY (module_id) REFERENCES public.main_module(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: subscription_wishlist subscription_wishlist_user_id_fda7c692_fk_main_user_id; Type: FK CONSTRAINT; Schema: public; Owner: demouser
--

ALTER TABLE ONLY public.subscription_wishlist
    ADD CONSTRAINT subscription_wishlist_user_id_fda7c692_fk_main_user_id FOREIGN KEY (user_id) REFERENCES public.main_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

