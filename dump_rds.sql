--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2
-- Dumped by pg_dump version 17.2 (Debian 17.2-1.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: 2_leagues; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."2_leagues" (
    id bigint,
    name text,
    type text,
    logo text,
    country_id bigint
);


ALTER TABLE public."2_leagues" OWNER TO postgres;

--
-- Name: 3_matches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."3_matches" (
    id bigint,
    data timestamp without time zone,
    home_team_id bigint,
    away_team_id bigint,
    home_team_goals double precision,
    away_team_goals double precision,
    home_team_possession double precision,
    away_team_possession double precision,
    home_team_shots double precision,
    away_team_shots double precision,
    home_team_shots_on_target double precision,
    away_team_shots_on_target double precision,
    home_team_fouls double precision,
    away_team_fouls double precision,
    home_team_corners double precision,
    away_team_corners double precision,
    home_team_yellow_cards double precision,
    away_team_yellow_cards double precision,
    home_team_red_cards double precision,
    away_team_red_cards double precision,
    league_id bigint,
    utc_date text,
    matchday text,
    status text
);


ALTER TABLE public."3_matches" OWNER TO postgres;

--
-- Name: countries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.countries (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    code character varying(100)
);


ALTER TABLE public.countries OWNER TO postgres;

--
-- Name: countries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.countries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.countries_id_seq OWNER TO postgres;

--
-- Name: countries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.countries_id_seq OWNED BY public.countries.id;


--
-- Name: leagues; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.leagues (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    type character varying(50) NOT NULL,
    logo character varying(255),
    country_id integer
);


ALTER TABLE public.leagues OWNER TO postgres;

--
-- Name: leagues_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.leagues_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.leagues_id_seq OWNER TO postgres;

--
-- Name: leagues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.leagues_id_seq OWNED BY public.leagues.id;


--
-- Name: matches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.matches (
    id integer NOT NULL,
    data timestamp without time zone NOT NULL,
    home_team_id integer,
    away_team_id integer,
    home_team_goals integer,
    away_team_goals integer,
    home_team_possession numeric(5,2),
    away_team_possession numeric(5,2),
    home_team_shots integer,
    away_team_shots integer,
    home_team_shots_on_target integer,
    away_team_shots_on_target integer,
    home_team_fouls integer,
    away_team_fouls integer,
    home_team_corners integer,
    away_team_corners integer,
    home_team_yellow_cards integer,
    away_team_yellow_cards integer,
    home_team_red_cards integer,
    away_team_red_cards integer,
    league_id integer,
    status character varying(1) NOT NULL,
    matchday integer NOT NULL,
    home_team_goals_firsthalf integer,
    away_team_goals_firsthalf integer
);


ALTER TABLE public.matches OWNER TO postgres;

--
-- Name: matches_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.matches_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.matches_id_seq OWNER TO postgres;

--
-- Name: matches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.matches_id_seq OWNED BY public.matches.id;


--
-- Name: players; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.players (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    "position" character varying(50) NOT NULL,
    team_id integer
);


ALTER TABLE public.players OWNER TO postgres;

--
-- Name: players_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.players_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.players_id_seq OWNER TO postgres;

--
-- Name: players_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.players_id_seq OWNED BY public.players.id;


--
-- Name: players_statistics; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.players_statistics (
    id integer NOT NULL,
    player_id integer,
    match_id integer,
    minutes integer,
    shots integer,
    shot_on_target integer,
    passes integer,
    key_passes integer,
    pass_accuracy numeric(5,2),
    fouls_drawn integer,
    fouls_committed integer,
    goals integer,
    red_card integer,
    yellow_card integer
);


ALTER TABLE public.players_statistics OWNER TO postgres;

--
-- Name: players_statistics_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.players_statistics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.players_statistics_id_seq OWNER TO postgres;

--
-- Name: players_statistics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.players_statistics_id_seq OWNED BY public.players_statistics.id;


--
-- Name: season_teams; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.season_teams (
    season_id integer NOT NULL,
    team_id integer NOT NULL
);


ALTER TABLE public.season_teams OWNER TO postgres;

--
-- Name: seasons; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.seasons (
    id integer NOT NULL,
    year character varying(9) NOT NULL,
    league_id integer,
    current boolean,
    type character varying(50) NOT NULL,
    logo character varying(255) NOT NULL,
    start_date timestamp without time zone,
    end_date timestamp without time zone
);


ALTER TABLE public.seasons OWNER TO postgres;

--
-- Name: seasons_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seasons_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.seasons_id_seq OWNER TO postgres;

--
-- Name: seasons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.seasons_id_seq OWNED BY public.seasons.id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teams (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    short_name character varying,
    city character varying(100),
    img_url character varying(255)
);


ALTER TABLE public.teams OWNER TO postgres;

--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.teams_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.teams_id_seq OWNER TO postgres;

--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.teams_id_seq OWNED BY public.teams.id;


--
-- Name: teams_players; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.teams_players (
    team_id integer NOT NULL,
    player_id integer NOT NULL
);


ALTER TABLE public.teams_players OWNER TO postgres;

--
-- Name: countries id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries ALTER COLUMN id SET DEFAULT nextval('public.countries_id_seq'::regclass);


--
-- Name: leagues id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leagues ALTER COLUMN id SET DEFAULT nextval('public.leagues_id_seq'::regclass);


--
-- Name: matches id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matches ALTER COLUMN id SET DEFAULT nextval('public.matches_id_seq'::regclass);


--
-- Name: players id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players ALTER COLUMN id SET DEFAULT nextval('public.players_id_seq'::regclass);


--
-- Name: players_statistics id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players_statistics ALTER COLUMN id SET DEFAULT nextval('public.players_statistics_id_seq'::regclass);


--
-- Name: seasons id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seasons ALTER COLUMN id SET DEFAULT nextval('public.seasons_id_seq'::regclass);


--
-- Name: teams id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams ALTER COLUMN id SET DEFAULT nextval('public.teams_id_seq'::regclass);


--
-- Data for Name: 2_leagues; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."2_leagues" (id, name, type, logo, country_id) FROM stdin;
4	Euro Championship	Cup	https://media.api-sports.io/football/leagues/4.png	169
21	Confederations Cup	Cup	https://media.api-sports.io/football/leagues/21.png	169
61	Ligue 1	League	https://media.api-sports.io/football/leagues/61.png	56
144	Jupiler Pro League	League	https://media.api-sports.io/football/leagues/144.png	16
71	Serie A	League	https://media.api-sports.io/football/leagues/71.png	24
39	Premier League	League	https://media.api-sports.io/football/leagues/39.png	49
78	Bundesliga	League	https://media.api-sports.io/football/leagues/78.png	60
135	Serie A	League	https://media.api-sports.io/football/leagues/135.png	79
88	Eredivisie	League	https://media.api-sports.io/football/leagues/88.png	115
94	Primeira Liga	League	https://media.api-sports.io/football/leagues/94.png	129
140	La Liga	League	https://media.api-sports.io/football/leagues/140.png	145
179	Premiership	League	https://media.api-sports.io/football/leagues/179.png	136
180	Championship	League	https://media.api-sports.io/football/leagues/180.png	136
1	World Cup	Cup	https://media.api-sports.io/football/leagues/1.png	169
803	Asian Games	Cup	https://media.api-sports.io/football/leagues/803.png	169
804	Caribbean Cup	Cup	https://media.api-sports.io/football/leagues/804.png	169
62	Ligue 2	League	https://media.api-sports.io/football/leagues/62.png	56
2	UEFA Champions League	Cup	https://media.api-sports.io/football/leagues/2.png	169
311	1st Division	League	https://media.api-sports.io/football/leagues/311.png	1
310	Superliga	League	https://media.api-sports.io/football/leagues/310.png	1
186	Ligue 1	League	https://media.api-sports.io/football/leagues/186.png	2
187	Ligue 2	League	https://media.api-sports.io/football/leagues/187.png	2
571	Vysshaya Liga	League	https://media.api-sports.io/football/leagues/571.png	151
586	West Bank Premier League	League	https://media.api-sports.io/football/leagues/586.png	123
588	National League	League	https://media.api-sports.io/football/leagues/588.png	112
591	Pro League	League	https://media.api-sports.io/football/leagues/591.png	155
335	Cup	Cup	https://media.api-sports.io/football/leagues/335.png	38
336	Druha Liga	League	https://media.api-sports.io/football/leagues/336.png	38
334	Persha Liga	League	https://media.api-sports.io/football/leagues/334.png	38
333	Premier League	League	https://media.api-sports.io/football/leagues/333.png	38
301	Pro League	League	https://media.api-sports.io/football/leagues/301.png	160
303	Division 1	League	https://media.api-sports.io/football/leagues/303.png	160
302	League Cup	Cup	https://media.api-sports.io/football/leagues/302.png	160
269	Segunda División	League	https://media.api-sports.io/football/leagues/269.png	161
202	Ligue 1	League	https://media.api-sports.io/football/leagues/202.png	156
203	Süper Lig	League	https://media.api-sports.io/football/leagues/203.png	157
204	1. Lig	League	https://media.api-sports.io/football/leagues/204.png	157
205	2. Lig	League	https://media.api-sports.io/football/leagues/205.png	157
206	Cup	Cup	https://media.api-sports.io/football/leagues/206.png	157
552	3. Lig - Group 1	League	https://media.api-sports.io/football/leagues/552.png	157
553	3. Lig - Group 2	League	https://media.api-sports.io/football/leagues/553.png	157
554	3. Lig - Group 3	League	https://media.api-sports.io/football/leagues/554.png	157
63	National 1	League	https://media.api-sports.io/football/leagues/63.png	56
66	Coupe de France	Cup	https://media.api-sports.io/football/leagues/66.png	56
65	Coupe de la Ligue	Cup	https://media.api-sports.io/football/leagues/65.png	56
67	National 2 - Group A	League	https://media.api-sports.io/football/leagues/67.png	56
68	National 2 - Group B	League	https://media.api-sports.io/football/leagues/68.png	56
69	National 2 - Group C	League	https://media.api-sports.io/football/leagues/69.png	56
70	National 2 - Group D	League	https://media.api-sports.io/football/leagues/70.png	56
233	Premier League	League	https://media.api-sports.io/football/leagues/233.png	47
370	Primera Division	League	https://media.api-sports.io/football/leagues/370.png	48
328	Esiliiga A	League	https://media.api-sports.io/football/leagues/328.png	50
329	Meistriliiga	League	https://media.api-sports.io/football/leagues/329.png	50
326	Erovnuli Liga 2	League	https://media.api-sports.io/football/leagues/326.png	59
570	Premier League	League	https://media.api-sports.io/football/leagues/570.png	61
377	Division d'Honneur	League	https://media.api-sports.io/football/leagues/377.png	65
339	Liga Nacional	League	https://media.api-sports.io/football/leagues/339.png	66
338	Primera Division	League	https://media.api-sports.io/football/leagues/338.png	66
199	Cup	Cup	https://media.api-sports.io/football/leagues/199.png	63
198	Football League	League	https://media.api-sports.io/football/leagues/198.png	63
197	Super League 1	League	https://media.api-sports.io/football/leagues/197.png	63
79	2. Bundesliga	League	https://media.api-sports.io/football/leagues/79.png	60
80	3. Liga	League	https://media.api-sports.io/football/leagues/80.png	60
529	Super Cup	Cup	https://media.api-sports.io/football/leagues/529.png	60
81	DFB Pokal	Cup	https://media.api-sports.io/football/leagues/81.png	60
7	Asian Cup	Cup	https://media.api-sports.io/football/leagues/7.png	169
8	World Cup - Women	Cup	https://media.api-sports.io/football/leagues/8.png	169
512	2nd Division - Group A	League	https://media.api-sports.io/football/leagues/512.png	1
513	2nd Division - Group B	League	https://media.api-sports.io/football/leagues/513.png	1
312	1a Divisió	League	https://media.api-sports.io/football/leagues/312.png	3
313	2a Divisió	League	https://media.api-sports.io/football/leagues/313.png	3
131	Primera B Metropolitana	League	https://media.api-sports.io/football/leagues/131.png	6
129	Primera Nacional	League	https://media.api-sports.io/football/leagues/129.png	6
132	Primera C	League	https://media.api-sports.io/football/leagues/132.png	6
133	Primera D	League	https://media.api-sports.io/football/leagues/133.png	6
134	Torneo Federal A	League	https://media.api-sports.io/football/leagues/134.png	6
188	A-League	League	https://media.api-sports.io/football/leagues/188.png	9
191	Brisbane Premier League	League	https://media.api-sports.io/football/leagues/191.png	9
193	Northern Territory Premier League	League	https://media.api-sports.io/football/leagues/193.png	9
220	Cup	Cup	https://media.api-sports.io/football/leagues/220.png	10
219	2. Liga	League	https://media.api-sports.io/football/leagues/219.png	10
218	Bundesliga	League	https://media.api-sports.io/football/leagues/218.png	10
418	Birinci Dasta	League	https://media.api-sports.io/football/leagues/418.png	11
419	Premyer Liqa	League	https://media.api-sports.io/football/leagues/419.png	11
222	Regionalliga - Mitte	League	https://media.api-sports.io/football/leagues/222.png	10
221	Regionalliga - Ost	League	https://media.api-sports.io/football/leagues/221.png	10
223	Regionalliga - West	League	https://media.api-sports.io/football/leagues/223.png	10
110	Premier League	League	https://media.api-sports.io/football/leagues/110.png	166
112	Welsh Cup	Cup	https://media.api-sports.io/football/leagues/112.png	166
299	Primera División	League	https://media.api-sports.io/football/leagues/299.png	164
300	Segunda División	League	https://media.api-sports.io/football/leagues/300.png	164
406	Professional League	League	https://media.api-sports.io/football/leagues/406.png	121
322	Premier League	League	https://media.api-sports.io/football/leagues/322.png	81
387	League	League	https://media.api-sports.io/football/leagues/387.png	83
388	1. Division	League	https://media.api-sports.io/football/leagues/388.png	84
330	Premier League	League	https://media.api-sports.io/football/leagues/330.png	87
119	Superliga	League	https://media.api-sports.io/football/leagues/119.png	44
120	1. Division	League	https://media.api-sports.io/football/leagues/120.png	44
124	Denmark Series - Group 1	League	https://media.api-sports.io/football/leagues/124.png	44
125	Denmark Series - Group 2	League	https://media.api-sports.io/football/leagues/125.png	44
126	Denmark Series - Group 3	League	https://media.api-sports.io/football/leagues/126.png	44
234	Liga Nacional	League	https://media.api-sports.io/football/leagues/234.png	69
381	HKFA 1st Division	League	https://media.api-sports.io/football/leagues/381.png	70
380	Premier League	League	https://media.api-sports.io/football/leagues/380.png	70
273	Magyar Kupa	Cup	https://media.api-sports.io/football/leagues/273.png	71
271	NB I	League	https://media.api-sports.io/football/leagues/271.png	71
272	NB II	League	https://media.api-sports.io/football/leagues/272.png	71
390	Premier League	League	https://media.api-sports.io/football/leagues/390.png	91
261	National Division	League	https://media.api-sports.io/football/leagues/261.png	97
306	Second Division	League	https://media.api-sports.io/football/leagues/306.png	130
305	Stars League	League	https://media.api-sports.io/football/leagues/305.png	130
40	Championship	League	https://media.api-sports.io/football/leagues/40.png	49
46	EFL Trophy	Cup	https://media.api-sports.io/football/leagues/46.png	49
45	FA Cup	Cup	https://media.api-sports.io/football/leagues/45.png	49
47	FA Trophy	Cup	https://media.api-sports.io/football/leagues/47.png	49
48	League Cup	Cup	https://media.api-sports.io/football/leagues/48.png	49
43	National League	League	https://media.api-sports.io/football/leagues/43.png	49
41	League One	League	https://media.api-sports.io/football/leagues/41.png	49
42	League Two	League	https://media.api-sports.io/football/leagues/42.png	49
568	Eerste Divisie	League	https://media.api-sports.io/football/leagues/568.png	147
15	FIFA Club World Cup	Cup	https://media.api-sports.io/football/leagues/15.png	169
422	Premier League	League	https://media.api-sports.io/football/leagues/422.png	14
480	Olympics Men	Cup	https://media.api-sports.io/football/leagues/480.png	169
535	CECAFA Senior Challenge Cup	Cup	https://media.api-sports.io/football/leagues/535.png	169
72	Serie B	League	https://media.api-sports.io/football/leagues/72.png	24
75	Serie C	League	https://media.api-sports.io/football/leagues/75.png	24
76	Serie D	League	https://media.api-sports.io/football/leagues/76.png	24
585	Premier League	League	https://media.api-sports.io/football/leagues/585.png	159
598	Première Division	League	https://media.api-sports.io/football/leagues/598.png	103
253	Major League Soccer	League	https://media.api-sports.io/football/leagues/253.png	162
257	US Open Cup	Cup	https://media.api-sports.io/football/leagues/257.png	162
268	Primera División - Apertura	League	https://media.api-sports.io/football/leagues/268.png	161
270	Primera División - Clausura	League	https://media.api-sports.io/football/leagues/270.png	161
369	Super League	League	https://media.api-sports.io/football/leagues/369.png	163
296	Thai League 1	League	https://media.api-sports.io/football/leagues/296.png	153
297	Thai League 2	League	https://media.api-sports.io/football/leagues/297.png	153
551	Super Cup	Cup	https://media.api-sports.io/football/leagues/551.png	157
366	1. Deild	League	https://media.api-sports.io/football/leagues/366.png	53
367	Meistaradeildin	League	https://media.api-sports.io/football/leagues/367.png	53
245	Ykkönen	League	https://media.api-sports.io/football/leagues/245.png	55
244	Veikkausliiga	League	https://media.api-sports.io/football/leagues/244.png	55
246	Suomen Cup	Cup	https://media.api-sports.io/football/leagues/246.png	55
247	Kakkonen - Lohko A	League	https://media.api-sports.io/football/leagues/247.png	55
248	Kakkonen - Lohko B	League	https://media.api-sports.io/football/leagues/248.png	55
249	Kakkonen - Lohko C	League	https://media.api-sports.io/football/leagues/249.png	55
526	Trophée des Champions	Cup	https://media.api-sports.io/football/leagues/526.png	56
242	Liga Pro	League	https://media.api-sports.io/football/leagues/242.png	46
243	Liga Pro Serie B	League	https://media.api-sports.io/football/leagues/243.png	46
539	Super Cup	Cup	https://media.api-sports.io/football/leagues/539.png	47
397	Girabola	League	https://media.api-sports.io/football/leagues/397.png	4
343	First League	League	https://media.api-sports.io/football/leagues/343.png	7
342	Premier League	League	https://media.api-sports.io/football/leagues/342.png	7
481	Northern NSW NPL	League	https://media.api-sports.io/football/leagues/481.png	9
116	Premier League	League	https://media.api-sports.io/football/leagues/116.png	15
117	1. Division	League	https://media.api-sports.io/football/leagues/117.png	15
118	2. Division	League	https://media.api-sports.io/football/leagues/118.png	15
400	Super League	League	https://media.api-sports.io/football/leagues/400.png	171
340	V.League 1	League	https://media.api-sports.io/football/leagues/340.png	165
102	Emperor Cup	Cup	https://media.api-sports.io/football/leagues/102.png	82
101	J-League Cup	Cup	https://media.api-sports.io/football/leagues/101.png	82
98	J1 League	League	https://media.api-sports.io/football/leagues/98.png	82
99	J2 League	League	https://media.api-sports.io/football/leagues/99.png	82
100	J3 League	League	https://media.api-sports.io/football/leagues/100.png	82
389	Premier League	League	https://media.api-sports.io/football/leagues/389.png	84
276	FKF Premier League	League	https://media.api-sports.io/football/leagues/276.png	85
121	DBU Pokalen	Cup	https://media.api-sports.io/football/leagues/121.png	44
379	Ligue Haïtienne	League	https://media.api-sports.io/football/leagues/379.png	68
364	1. Liga	League	https://media.api-sports.io/football/leagues/364.png	90
365	Virsliga	League	https://media.api-sports.io/football/leagues/365.png	90
361	1 Lyga	League	https://media.api-sports.io/football/leagues/361.png	96
362	A Lyga	League	https://media.api-sports.io/football/leagues/362.png	96
528	Community Shield	Cup	https://media.api-sports.io/football/leagues/528.png	49
505	League Cup	Cup	https://media.api-sports.io/football/leagues/505.png	139
28	SAFF Championship	Cup	https://media.api-sports.io/football/leagues/28.png	169
421	Division di Honor	League	https://media.api-sports.io/football/leagues/421.png	8
420	Cup	Cup	https://media.api-sports.io/football/leagues/420.png	11
298	FA Cup	Cup	https://media.api-sports.io/football/leagues/298.png	153
376	National Football League	League	https://media.api-sports.io/football/leagues/376.png	54
64	Feminine Division 1	League	https://media.api-sports.io/football/leagues/64.png	56
3	UEFA Europa League	Cup	https://media.api-sports.io/football/leagues/3.png	169
327	Erovnuli Liga	League	https://media.api-sports.io/football/leagues/327.png	59
378	Ligue 1	League	https://media.api-sports.io/football/leagues/378.png	67
37	World Cup - Qualification Intercontinental Play-offs	Cup	https://media.api-sports.io/football/leagues/37.png	169
520	Acreano	League	https://media.api-sports.io/football/leagues/520.png	24
807	AFC Challenge Cup	Cup	https://media.api-sports.io/football/leagues/807.png	169
547	Super Cup	Cup	https://media.api-sports.io/football/leagues/547.png	79
19	African Nations Championship	Cup	https://media.api-sports.io/football/leagues/19.png	169
24	AFF Championship	Cup	https://media.api-sports.io/football/leagues/24.png	169
128	Liga Profesional Argentina	League	https://media.api-sports.io/football/leagues/128.png	6
183	League One	League	https://media.api-sports.io/football/leagues/183.png	136
184	League Two	League	https://media.api-sports.io/football/leagues/184.png	136
22	CONCACAF Gold Cup	Cup	https://media.api-sports.io/football/leagues/22.png	169
23	EAFF E-1 Football Championship	Cup	https://media.api-sports.io/football/leagues/23.png	169
27	OFC Champions League	Cup	https://media.api-sports.io/football/leagues/27.png	169
519	Super Cup	Cup	https://media.api-sports.io/football/leagues/519.png	16
527	Super Cup	Cup	https://media.api-sports.io/football/leagues/527.png	31
6	Africa Cup of Nations	Cup	https://media.api-sports.io/football/leagues/6.png	169
9	Copa America	Cup	https://media.api-sports.io/football/leagues/9.png	169
925	Super Cup	Cup	https://media.api-sports.io/football/leagues/925.png	43
255	USL Championship	League	https://media.api-sports.io/football/leagues/255.png	162
363	Premier League	League	https://media.api-sports.io/football/leagues/363.png	52
122	2nd Division - Group 1	League	https://media.api-sports.io/football/leagues/122.png	44
123	2nd Division - Group 2	League	https://media.api-sports.io/football/leagues/123.png	44
567	Ligi kuu Bara	League	https://media.api-sports.io/football/leagues/567.png	152
550	Super Cup	Cup	https://media.api-sports.io/football/leagues/550.png	129
555	Supercupa	Cup	https://media.api-sports.io/football/leagues/555.png	131
556	Super Cup	Cup	https://media.api-sports.io/football/leagues/556.png	145
497	Japan Football League	League	https://media.api-sports.io/football/leagues/497.png	82
127	Denmark Series - Group 4	League	https://media.api-sports.io/football/leagues/127.png	44
563	Ettan - Norra	League	https://media.api-sports.io/football/leagues/563.png	148
564	Ettan - Södra	League	https://media.api-sports.io/football/leagues/564.png	148
317	1st League - RS	League	https://media.api-sports.io/football/leagues/317.png	22
316	1st League - FBiH	League	https://media.api-sports.io/football/leagues/316.png	22
295	K3 League	League	https://media.api-sports.io/football/leagues/295.png	144
495	Hazfi Cup	Cup	https://media.api-sports.io/football/leagues/495.png	75
496	Liga Alef	League	https://media.api-sports.io/football/leagues/496.png	78
506	2. liga	League	https://media.api-sports.io/football/leagues/506.png	140
514	Coupe Nationale	Cup	https://media.api-sports.io/football/leagues/514.png	2
521	Amapaense	League	https://media.api-sports.io/football/leagues/521.png	24
522	Amazonense	League	https://media.api-sports.io/football/leagues/522.png	24
524	Olympics Women	Cup	https://media.api-sports.io/football/leagues/524.png	169
531	UEFA Super Cup	Cup	https://media.api-sports.io/football/leagues/531.png	169
543	Super Cup	Cup	https://media.api-sports.io/football/leagues/543.png	115
166	2. Deild	League	https://media.api-sports.io/football/leagues/166.png	72
368	Premier League	League	https://media.api-sports.io/football/leagues/368.png	139
314	Cup	Cup	https://media.api-sports.io/football/leagues/314.png	22
315	Premijer Liga	League	https://media.api-sports.io/football/leagues/315.png	22
371	First League	League	https://media.api-sports.io/football/leagues/371.png	99
382	Liga Leumit	League	https://media.api-sports.io/football/leagues/382.png	78
383	Ligat Ha'al	League	https://media.api-sports.io/football/leagues/383.png	78
386	Ligue 1	League	https://media.api-sports.io/football/leagues/386.png	80
392	Challenge League	League	https://media.api-sports.io/football/leagues/392.png	104
393	Premier League	League	https://media.api-sports.io/football/leagues/393.png	104
394	Super Liga	League	https://media.api-sports.io/football/leagues/394.png	108
396	Primera Division	League	https://media.api-sports.io/football/leagues/396.png	117
96	Taça de Portugal	Cup	https://media.api-sports.io/football/leagues/96.png	129
399	NPFL	League	https://media.api-sports.io/football/leagues/399.png	118
401	Premier Soccer League	League	https://media.api-sports.io/football/leagues/401.png	172
402	Sudani Premier League	League	https://media.api-sports.io/football/leagues/402.png	146
403	Ligue 1	League	https://media.api-sports.io/football/leagues/403.png	137
404	Campionato	League	https://media.api-sports.io/football/leagues/404.png	134
411	Elite One	League	https://media.api-sports.io/football/leagues/411.png	29
410	C-League	League	https://media.api-sports.io/football/leagues/410.png	28
417	Premier League	League	https://media.api-sports.io/football/leagues/417.png	12
415	Championnat National	League	https://media.api-sports.io/football/leagues/415.png	18
414	Premier League	League	https://media.api-sports.io/football/leagues/414.png	19
413	Super League	League	https://media.api-sports.io/football/leagues/413.png	20
412	Premier League	League	https://media.api-sports.io/football/leagues/412.png	23
398	Premier League	League	https://media.api-sports.io/football/leagues/398.png	13
16	CONCACAF Champions League	Cup	https://media.api-sports.io/football/leagues/16.png	169
17	AFC Champions League	Cup	https://media.api-sports.io/football/leagues/17.png	169
25	Gulf Cup of Nations	Cup	https://media.api-sports.io/football/leagues/25.png	169
26	International Champions Cup	Cup	https://media.api-sports.io/football/leagues/26.png	169
141	Segunda División	League	https://media.api-sports.io/football/leagues/141.png	145
136	Serie B	League	https://media.api-sports.io/football/leagues/136.png	79
103	Eliteserien	League	https://media.api-sports.io/football/leagues/103.png	120
89	Eerste Divisie	League	https://media.api-sports.io/football/leagues/89.png	115
95	Segunda Liga	League	https://media.api-sports.io/football/leagues/95.png	129
113	Allsvenskan	League	https://media.api-sports.io/football/leagues/113.png	148
162	Primera División	League	https://media.api-sports.io/football/leagues/162.png	37
164	Úrvalsdeild	League	https://media.api-sports.io/football/leagues/164.png	72
169	Super League	League	https://media.api-sports.io/football/leagues/169.png	32
137	Coppa Italia	Cup	https://media.api-sports.io/football/leagues/137.png	79
200	Botola Pro	League	https://media.api-sports.io/football/leagues/200.png	111
207	Super League	League	https://media.api-sports.io/football/leagues/207.png	149
210	HNL	League	https://media.api-sports.io/football/leagues/210.png	39
235	Premier League	League	https://media.api-sports.io/football/leagues/235.png	132
239	Primera A	League	https://media.api-sports.io/football/leagues/239.png	34
250	Division Profesional - Apertura	League	https://media.api-sports.io/football/leagues/250.png	125
73	Copa Do Brasil	Cup	https://media.api-sports.io/football/leagues/73.png	24
90	KNVB Beker	Cup	https://media.api-sports.io/football/leagues/90.png	115
145	Challenger Pro League	League	https://media.api-sports.io/football/leagues/145.png	16
173	Second League	League	https://media.api-sports.io/football/leagues/173.png	25
170	League One	League	https://media.api-sports.io/football/leagues/170.png	32
189	Capital Territory NPL	League	https://media.api-sports.io/football/leagues/189.png	9
240	Primera B	League	https://media.api-sports.io/football/leagues/240.png	34
211	First NL	League	https://media.api-sports.io/football/leagues/211.png	39
138	Serie C - Girone A	League	https://media.api-sports.io/football/leagues/138.png	79
146	Super League Women	League	https://media.api-sports.io/football/leagues/146.png	16
74	Brasileiro Women	League	https://media.api-sports.io/football/leagues/74.png	24
44	FA WSL	League	https://media.api-sports.io/football/leagues/44.png	49
82	Frauen Bundesliga	League	https://media.api-sports.io/football/leagues/82.png	60
139	Serie A Women	League	https://media.api-sports.io/football/leagues/139.png	79
91	Eredivisie Women	League	https://media.api-sports.io/football/leagues/91.png	115
142	Primera División Femenina	League	https://media.api-sports.io/football/leagues/142.png	145
130	Copa Argentina	Cup	https://media.api-sports.io/football/leagues/130.png	6
190	A-League Women	League	https://media.api-sports.io/football/leagues/190.png	9
236	First League	League	https://media.api-sports.io/football/leagues/236.png	132
165	1. Deild	League	https://media.api-sports.io/football/leagues/165.png	72
251	Division Intermedia	League	https://media.api-sports.io/football/leagues/251.png	125
104	1. Division	League	https://media.api-sports.io/football/leagues/104.png	120
114	Superettan	League	https://media.api-sports.io/football/leagues/114.png	148
208	Challenge League	League	https://media.api-sports.io/football/leagues/208.png	149
262	Liga MX	League	https://media.api-sports.io/football/leagues/262.png	107
263	Liga de Expansión MX	League	https://media.api-sports.io/football/leagues/263.png	107
259	Canadian Championship	Cup	https://media.api-sports.io/football/leagues/259.png	30
278	Super League	League	https://media.api-sports.io/football/leagues/278.png	101
279	Premier League	League	https://media.api-sports.io/football/leagues/279.png	101
280	Premiership	League	https://media.api-sports.io/football/leagues/280.png	116
281	Primera División	League	https://media.api-sports.io/football/leagues/281.png	126
282	Segunda División	League	https://media.api-sports.io/football/leagues/282.png	126
283	Liga I	League	https://media.api-sports.io/football/leagues/283.png	131
284	Liga II	League	https://media.api-sports.io/football/leagues/284.png	131
286	Super Liga	League	https://media.api-sports.io/football/leagues/286.png	138
287	Prva Liga	League	https://media.api-sports.io/football/leagues/287.png	138
288	Premier Soccer League	League	https://media.api-sports.io/football/leagues/288.png	143
289	1st Division	League	https://media.api-sports.io/football/leagues/289.png	143
290	Persian Gulf Pro League	League	https://media.api-sports.io/football/leagues/290.png	75
291	Azadegan League	League	https://media.api-sports.io/football/leagues/291.png	75
292	K League 1	League	https://media.api-sports.io/football/leagues/292.png	144
293	K League 2	League	https://media.api-sports.io/football/leagues/293.png	144
307	Pro League	League	https://media.api-sports.io/football/leagues/307.png	135
308	Division 1	League	https://media.api-sports.io/football/leagues/308.png	135
309	Division 2	League	https://media.api-sports.io/football/leagues/309.png	135
252	Division Profesional - Clausura	League	https://media.api-sports.io/football/leagues/252.png	125
569	Premier League	League	https://media.api-sports.io/football/leagues/569.png	88
592	Division 2 - Norra Götaland	League	https://media.api-sports.io/football/leagues/592.png	148
593	Division 2 - Norra Svealand	League	https://media.api-sports.io/football/leagues/593.png	148
594	Division 2 - Norrland	League	https://media.api-sports.io/football/leagues/594.png	148
595	Division 2 - Södra Svealand	League	https://media.api-sports.io/football/leagues/595.png	148
596	Division 2 - Västra Götaland	League	https://media.api-sports.io/football/leagues/596.png	148
597	Division 2 - Östra Götaland	League	https://media.api-sports.io/football/leagues/597.png	148
511	Cup	Cup	https://media.api-sports.io/football/leagues/511.png	156
488	U19 Bundesliga	League	https://media.api-sports.io/football/leagues/488.png	60
805	Copa Centroamericana	Cup	https://media.api-sports.io/football/leagues/805.png	169
806	OFC Nations Cup	Cup	https://media.api-sports.io/football/leagues/806.png	169
766	China Cup	Cup	https://media.api-sports.io/football/leagues/766.png	169
827	Crown Prince Cup	Cup	https://media.api-sports.io/football/leagues/827.png	135
372	Second League	League	https://media.api-sports.io/football/leagues/372.png	99
174	Cup	Cup	https://media.api-sports.io/football/leagues/174.png	25
10	Friendlies	Cup	https://media.api-sports.io/football/leagues/10.png	169
14	UEFA Youth League	League	https://media.api-sports.io/football/leagues/14.png	169
18	AFC Cup	Cup	https://media.api-sports.io/football/leagues/18.png	169
20	CAF Confederation Cup	Cup	https://media.api-sports.io/football/leagues/20.png	169
559	League Cup	Cup	https://media.api-sports.io/football/leagues/559.png	119
560	Presidents Cup	Cup	https://media.api-sports.io/football/leagues/560.png	160
561	Premier Intermediate League	League	https://media.api-sports.io/football/leagues/561.png	119
407	Championship	League	https://media.api-sports.io/football/leagues/407.png	119
408	Premiership	League	https://media.api-sports.io/football/leagues/408.png	119
331	Division 1	League	https://media.api-sports.io/football/leagues/331.png	87
38	UEFA U21 Championship	Cup	https://media.api-sports.io/football/leagues/38.png	169
425	Premier League	League	https://media.api-sports.io/football/leagues/425.png	150
77	Alagoano	Cup	https://media.api-sports.io/football/leagues/77.png	24
337	Druha Liga - Group B	League	https://media.api-sports.io/football/leagues/337.png	38
185	League Cup	Cup	https://media.api-sports.io/football/leagues/185.png	136
490	World Cup - U20	Cup	https://media.api-sports.io/football/leagues/490.png	169
492	Tweede Divisie	League	https://media.api-sports.io/football/leagues/492.png	115
498	Cup	Cup	https://media.api-sports.io/football/leagues/498.png	84
504	King's Cup	Cup	https://media.api-sports.io/football/leagues/504.png	135
507	Cup	Cup	https://media.api-sports.io/football/leagues/507.png	143
508	League Cup	Cup	https://media.api-sports.io/football/leagues/508.png	143
510	1. Liga Promotion	League	https://media.api-sports.io/football/leagues/510.png	149
584	Premier League	League	https://media.api-sports.io/football/leagues/584.png	94
589	Taiwan Football Premier League	League	https://media.api-sports.io/football/leagues/589.png	33
258	Canadian Soccer League	League	https://media.api-sports.io/football/leagues/258.png	30
274	Liga 1	League	https://media.api-sports.io/football/leagues/274.png	74
304	Liga Panameña de Fútbol	League	https://media.api-sports.io/football/leagues/304.png	124
106	Ekstraklasa	League	https://media.api-sports.io/football/leagues/106.png	128
172	First League	League	https://media.api-sports.io/football/leagues/172.png	25
5	UEFA Nations League	Cup	https://media.api-sports.io/football/leagues/5.png	169
163	Liga de Ascenso	League	https://media.api-sports.io/football/leagues/163.png	37
111	FAW Championship	League	https://media.api-sports.io/football/leagues/111.png	166
265	Primera División	League	https://media.api-sports.io/football/leagues/265.png	31
266	Primera B	League	https://media.api-sports.io/football/leagues/266.png	31
277	Super League	League	https://media.api-sports.io/football/leagues/277.png	85
318	1. Division	League	https://media.api-sports.io/football/leagues/318.png	42
319	2. Division	League	https://media.api-sports.io/football/leagues/319.png	42
320	3. Division	League	https://media.api-sports.io/football/leagues/320.png	42
201	Botola 2	League	https://media.api-sports.io/football/leagues/201.png	111
323	Indian Super League	League	https://media.api-sports.io/football/leagues/323.png	73
324	I-League	League	https://media.api-sports.io/football/leagues/324.png	73
107	I Liga	League	https://media.api-sports.io/football/leagues/107.png	128
332	Super Liga	League	https://media.api-sports.io/football/leagues/332.png	140
345	Czech Liga	League	https://media.api-sports.io/football/leagues/345.png	43
346	FNL	League	https://media.api-sports.io/football/leagues/346.png	43
355	First League	League	https://media.api-sports.io/football/leagues/355.png	110
356	Second League	League	https://media.api-sports.io/football/leagues/356.png	110
344	Primera División	League	https://media.api-sports.io/football/leagues/344.png	21
256	USL League Two	League	https://media.api-sports.io/football/leagues/256.png	162
544	FA Cup	Cup	https://media.api-sports.io/football/leagues/544.png	70
545	AIFF Super Cup	Cup	https://media.api-sports.io/football/leagues/545.png	73
557	Super Cup	Cup	https://media.api-sports.io/football/leagues/557.png	120
808	CONCACAF Nations League - Qualification	Cup	https://media.api-sports.io/football/leagues/808.png	169
373	1. SNL	League	https://media.api-sports.io/football/leagues/373.png	141
374	2. SNL	League	https://media.api-sports.io/football/leagues/374.png	141
391	Super League	League	https://media.api-sports.io/football/leagues/391.png	100
143	Copa del Rey	Cup	https://media.api-sports.io/football/leagues/143.png	145
405	National Soccer League	League	https://media.api-sports.io/football/leagues/405.png	133
409	Premier League	League	https://media.api-sports.io/football/leagues/409.png	113
416	Premier League	League	https://media.api-sports.io/football/leagues/416.png	17
212	Cup	Cup	https://media.api-sports.io/football/leagues/212.png	39
384	State Cup	Cup	https://media.api-sports.io/football/leagues/384.png	78
285	Cupa României	Cup	https://media.api-sports.io/football/leagues/285.png	131
321	Cup	Cup	https://media.api-sports.io/football/leagues/321.png	42
31	World Cup - Qualification CONCACAF	Cup	https://media.api-sports.io/football/leagues/31.png	169
32	World Cup - Qualification Europe	Cup	https://media.api-sports.io/football/leagues/32.png	169
33	World Cup - Qualification Oceania	Cup	https://media.api-sports.io/football/leagues/33.png	169
34	World Cup - Qualification South America	Cup	https://media.api-sports.io/football/leagues/34.png	169
29	World Cup - Qualification Africa	Cup	https://media.api-sports.io/football/leagues/29.png	169
30	World Cup - Qualification Asia	Cup	https://media.api-sports.io/football/leagues/30.png	169
942	Serie C - Girone B	League	https://media.api-sports.io/football/leagues/942.png	79
943	Serie C - Girone C	League	https://media.api-sports.io/football/leagues/943.png	79
530	Super Cup	Cup	https://media.api-sports.io/football/leagues/530.png	59
718	Piala Indonesia	Cup	https://media.api-sports.io/football/leagues/718.png	74
149	Second Amateur Division - VFV A	League	https://media.api-sports.io/football/leagues/149.png	16
150	Second Amateur Division - VFV B	League	https://media.api-sports.io/football/leagues/150.png	16
151	Third Amateur Division - VFV A	League	https://media.api-sports.io/football/leagues/151.png	16
152	Third Amateur Division - VFV B	League	https://media.api-sports.io/football/leagues/152.png	16
175	Third League - Northeast	League	https://media.api-sports.io/football/leagues/175.png	25
176	Third League - Northwest	League	https://media.api-sports.io/football/leagues/176.png	25
177	Third League - Southeast	League	https://media.api-sports.io/football/leagues/177.png	25
178	Third League - Southwest	League	https://media.api-sports.io/football/leagues/178.png	25
49	National League - Play-offs	League	https://media.api-sports.io/football/leagues/49.png	49
491	Løgmanssteypid	Cup	https://media.api-sports.io/football/leagues/491.png	53
493	UEFA U19 Championship	Cup	https://media.api-sports.io/football/leagues/493.png	169
499	Malaysia Cup	Cup	https://media.api-sports.io/football/leagues/499.png	101
516	Super Cup	Cup	https://media.api-sports.io/football/leagues/516.png	2
537	CONCACAF U20	Cup	https://media.api-sports.io/football/leagues/537.png	169
224	Landesliga - Burgenland	League	https://media.api-sports.io/football/leagues/224.png	10
225	Landesliga - Karnten	League	https://media.api-sports.io/football/leagues/225.png	10
226	Landesliga - Niederosterreich	League	https://media.api-sports.io/football/leagues/226.png	10
227	Landesliga - Oberosterreich	League	https://media.api-sports.io/football/leagues/227.png	10
228	Landesliga - Salzburg	League	https://media.api-sports.io/football/leagues/228.png	10
229	Landesliga - Steiermark	League	https://media.api-sports.io/football/leagues/229.png	10
230	Landesliga - Tirol	League	https://media.api-sports.io/football/leagues/230.png	10
231	Landesliga - Vorarlbergliga	League	https://media.api-sports.io/football/leagues/231.png	10
232	Landesliga - Wien	League	https://media.api-sports.io/football/leagues/232.png	10
294	FA Cup	Cup	https://media.api-sports.io/football/leagues/294.png	144
148	Second Amateur Division - ACFF	League	https://media.api-sports.io/football/leagues/148.png	16
153	Provincial - Antwerpen	League	https://media.api-sports.io/football/leagues/153.png	16
154	Provincial - Brabant VFV	League	https://media.api-sports.io/football/leagues/154.png	16
155	Provincial - Hainaut	League	https://media.api-sports.io/football/leagues/155.png	16
156	Provincial - Liege	League	https://media.api-sports.io/football/leagues/156.png	16
157	Provincial - Limburg	League	https://media.api-sports.io/football/leagues/157.png	16
158	Provincial - Luxembourg	League	https://media.api-sports.io/football/leagues/158.png	16
159	Provincial - Namur	League	https://media.api-sports.io/football/leagues/159.png	16
160	Provincial - Oost-Vlaanderen	League	https://media.api-sports.io/football/leagues/160.png	16
161	Provincial - West-Vlaanderen	League	https://media.api-sports.io/football/leagues/161.png	16
423	Ligue 1	League	https://media.api-sports.io/football/leagues/423.png	26
424	Ligue 1	League	https://media.api-sports.io/football/leagues/424.png	36
213	Third NL - Istok	League	https://media.api-sports.io/football/leagues/213.png	39
214	Third NL - Jug	League	https://media.api-sports.io/football/leagues/214.png	39
215	Third NL - Sjever	League	https://media.api-sports.io/football/leagues/215.png	39
216	Third NL - Sredite	League	https://media.api-sports.io/football/leagues/216.png	39
217	Third NL - Zapad	League	https://media.api-sports.io/football/leagues/217.png	39
348	3. liga - CFL A	League	https://media.api-sports.io/football/leagues/348.png	43
349	3. liga - MSFL	League	https://media.api-sports.io/football/leagues/349.png	43
350	4. liga - Divizie A	League	https://media.api-sports.io/football/leagues/350.png	43
351	4. liga - Divizie B	League	https://media.api-sports.io/football/leagues/351.png	43
352	4. liga - Divizie C	League	https://media.api-sports.io/football/leagues/352.png	43
353	4. liga - Divizie D	League	https://media.api-sports.io/football/leagues/353.png	43
354	4. liga - Divizie E	League	https://media.api-sports.io/football/leagues/354.png	43
50	National League - North	League	https://media.api-sports.io/football/leagues/50.png	49
51	National League - South	League	https://media.api-sports.io/football/leagues/51.png	49
52	Non League Div One - Isthmian North	League	https://media.api-sports.io/football/leagues/52.png	49
53	Non League Div One - Isthmian South Central	League	https://media.api-sports.io/football/leagues/53.png	49
54	Non League Div One - Northern West	League	https://media.api-sports.io/football/leagues/54.png	49
55	Non League Div One - Northern Midlands	League	https://media.api-sports.io/football/leagues/55.png	49
56	Non League Div One - Southern South	League	https://media.api-sports.io/football/leagues/56.png	49
57	Non League Div One - Isthmian South East	League	https://media.api-sports.io/football/leagues/57.png	49
58	Non League Premier - Isthmian	League	https://media.api-sports.io/football/leagues/58.png	49
59	Non League Premier - Northern	League	https://media.api-sports.io/football/leagues/59.png	49
60	Non League Premier - Southern South	League	https://media.api-sports.io/football/leagues/60.png	49
92	Derde Divisie - Saturday	League	https://media.api-sports.io/football/leagues/92.png	115
93	Derde Divisie - Sunday	League	https://media.api-sports.io/football/leagues/93.png	115
109	II Liga - East	League	https://media.api-sports.io/football/leagues/109.png	128
341	Cup	Cup	https://media.api-sports.io/football/leagues/341.png	165
238	Youth Championship	League	https://media.api-sports.io/football/leagues/238.png	132
83	Regionalliga - Bayern	League	https://media.api-sports.io/football/leagues/83.png	60
84	Regionalliga - Nord	League	https://media.api-sports.io/football/leagues/84.png	60
85	Regionalliga - Nordost	League	https://media.api-sports.io/football/leagues/85.png	60
86	Regionalliga - SudWest	League	https://media.api-sports.io/football/leagues/86.png	60
87	Regionalliga - West	League	https://media.api-sports.io/football/leagues/87.png	60
426	Serie D - Girone A	League	https://media.api-sports.io/football/leagues/426.png	79
427	Serie D - Girone B	League	https://media.api-sports.io/football/leagues/427.png	79
428	Serie D - Girone C	League	https://media.api-sports.io/football/leagues/428.png	79
429	Serie D - Girone D	League	https://media.api-sports.io/football/leagues/429.png	79
430	Serie D - Girone E	League	https://media.api-sports.io/football/leagues/430.png	79
431	Serie D - Girone F	League	https://media.api-sports.io/football/leagues/431.png	79
432	Serie D - Girone G	League	https://media.api-sports.io/football/leagues/432.png	79
433	Serie D - Girone H	League	https://media.api-sports.io/football/leagues/433.png	79
434	Serie D - Girone I	League	https://media.api-sports.io/football/leagues/434.png	79
435	Primera División RFEF - Group 1	League	https://media.api-sports.io/football/leagues/435.png	145
436	Primera División RFEF - Group 2	League	https://media.api-sports.io/football/leagues/436.png	145
437	Primera División RFEF - Group 3	League	https://media.api-sports.io/football/leagues/437.png	145
438	Primera División RFEF - Group 4	League	https://media.api-sports.io/football/leagues/438.png	145
439	Tercera División RFEF - Group 1	League	https://media.api-sports.io/football/leagues/439.png	145
440	Tercera División RFEF - Group 2	League	https://media.api-sports.io/football/leagues/440.png	145
441	Tercera División RFEF - Group 3	League	https://media.api-sports.io/football/leagues/441.png	145
442	Tercera División RFEF - Group 4	League	https://media.api-sports.io/football/leagues/442.png	145
443	Tercera División RFEF - Group 5	League	https://media.api-sports.io/football/leagues/443.png	145
444	Tercera División RFEF - Group 6	League	https://media.api-sports.io/football/leagues/444.png	145
445	Tercera División RFEF - Group 7	League	https://media.api-sports.io/football/leagues/445.png	145
446	Tercera División RFEF - Group 8	League	https://media.api-sports.io/football/leagues/446.png	145
447	Tercera División RFEF - Group 9	League	https://media.api-sports.io/football/leagues/447.png	145
448	Tercera División RFEF - Group 10	League	https://media.api-sports.io/football/leagues/448.png	145
449	Tercera División RFEF - Group 11	League	https://media.api-sports.io/football/leagues/449.png	145
450	Tercera División RFEF - Group 12	League	https://media.api-sports.io/football/leagues/450.png	145
451	Tercera División RFEF - Group 13	League	https://media.api-sports.io/football/leagues/451.png	145
452	Tercera División RFEF - Group 14	League	https://media.api-sports.io/football/leagues/452.png	145
453	Tercera División RFEF - Group 15	League	https://media.api-sports.io/football/leagues/453.png	145
454	Tercera División RFEF - Group 16	League	https://media.api-sports.io/football/leagues/454.png	145
455	Tercera División RFEF - Group 17	League	https://media.api-sports.io/football/leagues/455.png	145
456	Tercera División RFEF - Group 18	League	https://media.api-sports.io/football/leagues/456.png	145
457	Campeonato de Portugal Prio - Group A	League	https://media.api-sports.io/football/leagues/457.png	129
458	Campeonato de Portugal Prio - Group B	League	https://media.api-sports.io/football/leagues/458.png	129
459	Campeonato de Portugal Prio - Group C	League	https://media.api-sports.io/football/leagues/459.png	129
460	Campeonato de Portugal Prio - Group D	League	https://media.api-sports.io/football/leagues/460.png	129
461	National 3 - Group A	League	https://media.api-sports.io/football/leagues/461.png	56
462	National 3 - Group B	League	https://media.api-sports.io/football/leagues/462.png	56
463	National 3 - Group C	League	https://media.api-sports.io/football/leagues/463.png	56
464	National 3 - Group D	League	https://media.api-sports.io/football/leagues/464.png	56
465	National 3 - Group E	League	https://media.api-sports.io/football/leagues/465.png	56
466	National 3 - Group F	League	https://media.api-sports.io/football/leagues/466.png	56
467	National 3 - Group H	League	https://media.api-sports.io/football/leagues/467.png	56
468	National 3 - Group I	League	https://media.api-sports.io/football/leagues/468.png	56
469	National 3 - Group J	League	https://media.api-sports.io/football/leagues/469.png	56
470	National 3 - Group K	League	https://media.api-sports.io/football/leagues/470.png	56
471	National 3 - Group L	League	https://media.api-sports.io/football/leagues/471.png	56
472	National 3 - Group M	League	https://media.api-sports.io/football/leagues/472.png	56
473	2. Division - Group 1	League	https://media.api-sports.io/football/leagues/473.png	120
474	2. Division - Group 2	League	https://media.api-sports.io/football/leagues/474.png	120
484	Frauenliga	League	https://media.api-sports.io/football/leagues/484.png	10
485	Federation Cup	Cup	https://media.api-sports.io/football/leagues/485.png	12
486	Coppa	Cup	https://media.api-sports.io/football/leagues/486.png	15
487	First Amateur Division	League	https://media.api-sports.io/football/leagues/487.png	16
489	USL League One	League	https://media.api-sports.io/football/leagues/489.png	162
494	Super League 2	League	https://media.api-sports.io/football/leagues/494.png	63
501	Copa Paraguay	Cup	https://media.api-sports.io/football/leagues/501.png	125
502	Copa Bicentenario	Cup	https://media.api-sports.io/football/leagues/502.png	126
503	Copa Perú	Cup	https://media.api-sports.io/football/leagues/503.png	126
509	8 Cup	Cup	https://media.api-sports.io/football/leagues/509.png	143
515	U21 League 1	League	https://media.api-sports.io/football/leagues/515.png	2
517	Trofeo de Campeones de la Superliga	Cup	https://media.api-sports.io/football/leagues/517.png	6
518	Reserve Pro League	League	https://media.api-sports.io/football/leagues/518.png	16
523	NISA	League	https://media.api-sports.io/football/leagues/523.png	162
525	UEFA Champions League Women	Cup	https://media.api-sports.io/football/leagues/525.png	169
533	CAF Super Cup	Cup	https://media.api-sports.io/football/leagues/533.png	169
534	CONCACAF Caribbean Club Shield	Cup	https://media.api-sports.io/football/leagues/534.png	169
275	Liga 2	League	https://media.api-sports.io/football/leagues/275.png	74
395	Liga 1	League	https://media.api-sports.io/football/leagues/395.png	108
267	Copa Chile	Cup	https://media.api-sports.io/football/leagues/267.png	31
171	FA Cup	Cup	https://media.api-sports.io/football/leagues/171.png	32
241	Copa Colombia	Cup	https://media.api-sports.io/football/leagues/241.png	34
147	Cup	Cup	https://media.api-sports.io/football/leagues/147.png	16
167	Cup	Cup	https://media.api-sports.io/football/leagues/167.png	72
168	League Cup	Cup	https://media.api-sports.io/football/leagues/168.png	72
359	FAI Cup	Cup	https://media.api-sports.io/football/leagues/359.png	77
360	League Cup	Cup	https://media.api-sports.io/football/leagues/360.png	77
385	Toto Cup Ligat Al	Cup	https://media.api-sports.io/football/leagues/385.png	78
264	Copa MX	Cup	https://media.api-sports.io/football/leagues/264.png	107
11	CONMEBOL Sudamericana	Cup	https://media.api-sports.io/football/leagues/11.png	169
12	CAF Champions League	Cup	https://media.api-sports.io/football/leagues/12.png	169
13	CONMEBOL Libertadores	Cup	https://media.api-sports.io/football/leagues/13.png	169
209	Schweizer Cup	Cup	https://media.api-sports.io/football/leagues/209.png	149
115	Svenska Cupen	Cup	https://media.api-sports.io/football/leagues/115.png	148
375	Cup	Cup	https://media.api-sports.io/football/leagues/375.png	141
181	FA Cup	Cup	https://media.api-sports.io/football/leagues/181.png	136
182	Challenge Cup	Cup	https://media.api-sports.io/football/leagues/182.png	136
237	Cup	Cup	https://media.api-sports.io/football/leagues/237.png	132
97	Taça da Liga	Cup	https://media.api-sports.io/football/leagues/97.png	129
108	Cup	Cup	https://media.api-sports.io/football/leagues/108.png	128
105	NM Cupen	Cup	https://media.api-sports.io/football/leagues/105.png	120
325	Santosh Trophy	Cup	https://media.api-sports.io/football/leagues/325.png	73
347	Cup	Cup	https://media.api-sports.io/football/leagues/347.png	43
35	Asian Cup - Qualification	Cup	https://media.api-sports.io/football/leagues/35.png	169
254	NWSL Women	League	https://media.api-sports.io/football/leagues/254.png	162
260	Pacific Coast Soccer League	League	https://media.api-sports.io/football/leagues/260.png	30
192	New South Wales NPL	League	https://media.api-sports.io/football/leagues/192.png	9
194	South Australia NPL	League	https://media.api-sports.io/football/leagues/194.png	9
195	Victoria NPL	League	https://media.api-sports.io/football/leagues/195.png	9
196	Western Australia NPL	League	https://media.api-sports.io/football/leagues/196.png	9
357	Premier Division	League	https://media.api-sports.io/football/leagues/357.png	77
358	First Division	League	https://media.api-sports.io/football/leagues/358.png	77
768	Arab Club Champions Cup	Cup	https://media.api-sports.io/football/leagues/768.png	169
769	Premier League Asia Trophy	Cup	https://media.api-sports.io/football/leagues/769.png	169
770	Pacific Games	Cup	https://media.api-sports.io/football/leagues/770.png	169
772	Leagues Cup	Cup	https://media.api-sports.io/football/leagues/772.png	169
773	Sudamericano U20	Cup	https://media.api-sports.io/football/leagues/773.png	169
546	FAI President's Cup	Cup	https://media.api-sports.io/football/leagues/546.png	77
482	Queensland NPL	League	https://media.api-sports.io/football/leagues/482.png	9
566	Ligue A	League	https://media.api-sports.io/football/leagues/566.png	27
642	Curaçao Sekshon Pagá	League	https://media.api-sports.io/football/leagues/642.png	41
655	Copa Constitució	Cup	https://media.api-sports.io/football/leagues/655.png	3
664	Superliga	League	https://media.api-sports.io/football/leagues/664.png	86
665	Cup	Cup	https://media.api-sports.io/football/leagues/665.png	86
677	QSL Cup	Cup	https://media.api-sports.io/football/leagues/677.png	130
698	FA Women's Cup	Cup	https://media.api-sports.io/football/leagues/698.png	49
714	Cup	Cup	https://media.api-sports.io/football/leagues/714.png	47
716	Senior Shield	Cup	https://media.api-sports.io/football/leagues/716.png	70
572	Srpska Liga - Belgrade	League	https://media.api-sports.io/football/leagues/572.png	138
573	Srpska Liga - Vojvodina	League	https://media.api-sports.io/football/leagues/573.png	138
574	Srpska Liga - East	League	https://media.api-sports.io/football/leagues/574.png	138
575	Srpska Liga - West	League	https://media.api-sports.io/football/leagues/575.png	138
576	Gamma Ethniki - Group 1	League	https://media.api-sports.io/football/leagues/576.png	63
577	Gamma Ethniki - Group 2	League	https://media.api-sports.io/football/leagues/577.png	63
578	Gamma Ethniki - Group 3	League	https://media.api-sports.io/football/leagues/578.png	63
579	Gamma Ethniki - Group 4	League	https://media.api-sports.io/football/leagues/579.png	63
580	Gamma Ethniki - Group 5	League	https://media.api-sports.io/football/leagues/580.png	63
581	Gamma Ethniki - Group 6	League	https://media.api-sports.io/football/leagues/581.png	63
582	Gamma Ethniki - Group 7	League	https://media.api-sports.io/football/leagues/582.png	63
583	Gamma Ethniki - Group 8	League	https://media.api-sports.io/football/leagues/583.png	63
587	World Cup - U17	Cup	https://media.api-sports.io/football/leagues/587.png	169
590	A Division	League	https://media.api-sports.io/football/leagues/590.png	114
599	1. Liga Classic - Group 1	League	https://media.api-sports.io/football/leagues/599.png	149
600	1. Liga Classic - Group 2	League	https://media.api-sports.io/football/leagues/600.png	149
601	1. Liga Classic - Group 3	League	https://media.api-sports.io/football/leagues/601.png	149
613	Baiano - 2	League	https://media.api-sports.io/football/leagues/613.png	24
620	Cearense - 2	League	https://media.api-sports.io/football/leagues/620.png	24
625	Carioca - 2	League	https://media.api-sports.io/football/leagues/625.png	24
633	NB III - Northeast	League	https://media.api-sports.io/football/leagues/633.png	71
634	NB III - Southwest	League	https://media.api-sports.io/football/leagues/634.png	71
635	NB III - Northwest	League	https://media.api-sports.io/football/leagues/635.png	71
638	Kvindeliga	League	https://media.api-sports.io/football/leagues/638.png	44
602	Baiano - 1	League	https://media.api-sports.io/football/leagues/602.png	24
603	Paraibano	League	https://media.api-sports.io/football/leagues/603.png	24
604	Catarinense - 1	League	https://media.api-sports.io/football/leagues/604.png	24
605	Paulista - A3	League	https://media.api-sports.io/football/leagues/605.png	24
606	Paranaense - 1	League	https://media.api-sports.io/football/leagues/606.png	24
607	Roraimense	League	https://media.api-sports.io/football/leagues/607.png	24
608	Maranhense	League	https://media.api-sports.io/football/leagues/608.png	24
609	Cearense - 1	League	https://media.api-sports.io/football/leagues/609.png	24
610	Brasiliense	League	https://media.api-sports.io/football/leagues/610.png	24
611	Capixaba	League	https://media.api-sports.io/football/leagues/611.png	24
612	Copa do Nordeste	Cup	https://media.api-sports.io/football/leagues/612.png	24
614	Paranaense - 2	League	https://media.api-sports.io/football/leagues/614.png	24
615	Rondoniense	League	https://media.api-sports.io/football/leagues/615.png	24
616	Potiguar	League	https://media.api-sports.io/football/leagues/616.png	24
617	Copa do Brasil U20	Cup	https://media.api-sports.io/football/leagues/617.png	24
618	São Paulo Youth Cup	Cup	https://media.api-sports.io/football/leagues/618.png	24
619	Mineiro - 2	League	https://media.api-sports.io/football/leagues/619.png	24
621	Piauiense	League	https://media.api-sports.io/football/leagues/621.png	24
622	Pernambucano - 1	League	https://media.api-sports.io/football/leagues/622.png	24
623	Sul-Matogrossense	League	https://media.api-sports.io/football/leagues/623.png	24
624	Carioca - 1	League	https://media.api-sports.io/football/leagues/624.png	24
626	Sergipano	League	https://media.api-sports.io/football/leagues/626.png	24
627	Paraense	League	https://media.api-sports.io/football/leagues/627.png	24
628	Goiano - 1	League	https://media.api-sports.io/football/leagues/628.png	24
629	Mineiro - 1	League	https://media.api-sports.io/football/leagues/629.png	24
630	Matogrossense	League	https://media.api-sports.io/football/leagues/630.png	24
631	Tocantinense	League	https://media.api-sports.io/football/leagues/631.png	24
632	Supercopa do Brasil	Cup	https://media.api-sports.io/football/leagues/632.png	24
636	Ýokary Liga	League	https://media.api-sports.io/football/leagues/636.png	158
637	V.League 2	League	https://media.api-sports.io/football/leagues/637.png	165
639	Super Cup	Cup	https://media.api-sports.io/football/leagues/639.png	72
640	Kansallinen Liiga	League	https://media.api-sports.io/football/leagues/640.png	55
641	NWSL Women - Challenge Cup	Cup	https://media.api-sports.io/football/leagues/641.png	162
729	Coppa Titano	Cup	https://media.api-sports.io/football/leagues/729.png	134
730	Football League - Highland League	League	https://media.api-sports.io/football/leagues/730.png	136
731	Football League - Lowland League	League	https://media.api-sports.io/football/leagues/731.png	136
732	Cup	Cup	https://media.api-sports.io/football/leagues/732.png	138
733	I Liga - Women	League	https://media.api-sports.io/football/leagues/733.png	140
734	Diski Challenge	League	https://media.api-sports.io/football/leagues/734.png	143
735	Copa Federacion	Cup	https://media.api-sports.io/football/leagues/735.png	145
737	Svenska Cupen - Women	Cup	https://media.api-sports.io/football/leagues/737.png	148
738	League Cup	Cup	https://media.api-sports.io/football/leagues/738.png	166
739	AXA Women’s Super League	League	https://media.api-sports.io/football/leagues/739.png	149
740	CBF Brasileiro U20	Cup	https://media.api-sports.io/football/leagues/740.png	24
741	Brasileiro de Aspirantes	Cup	https://media.api-sports.io/football/leagues/741.png	24
742	Copa Paulista	Cup	https://media.api-sports.io/football/leagues/742.png	24
744	Oberliga - Schleswig-Holstein	League	https://media.api-sports.io/football/leagues/744.png	60
745	Oberliga - Hamburg	League	https://media.api-sports.io/football/leagues/745.png	60
746	Oberliga - Mittelrhein	League	https://media.api-sports.io/football/leagues/746.png	60
747	Oberliga - Westfalen	League	https://media.api-sports.io/football/leagues/747.png	60
748	Oberliga - Niedersachsen	League	https://media.api-sports.io/football/leagues/748.png	60
749	Oberliga - Bremen	League	https://media.api-sports.io/football/leagues/749.png	60
750	Oberliga - Hessen	League	https://media.api-sports.io/football/leagues/750.png	60
751	Oberliga - Niederrhein	League	https://media.api-sports.io/football/leagues/751.png	60
752	Oberliga - Rheinland-Pfalz / Saar	League	https://media.api-sports.io/football/leagues/752.png	60
753	Oberliga - Baden-Württemberg	League	https://media.api-sports.io/football/leagues/753.png	60
754	Oberliga - Nordost-Nord	League	https://media.api-sports.io/football/leagues/754.png	60
755	Oberliga - Nordost-Süd	League	https://media.api-sports.io/football/leagues/755.png	60
756	Cup	Cup	https://media.api-sports.io/football/leagues/756.png	99
757	Irish Cup	Cup	https://media.api-sports.io/football/leagues/757.png	119
758	Premier Division	League	https://media.api-sports.io/football/leagues/758.png	62
759	Liga Mayor	League	https://media.api-sports.io/football/leagues/759.png	45
760	LFA First Division	League	https://media.api-sports.io/football/leagues/760.png	93
761	Cup	Cup	https://media.api-sports.io/football/leagues/761.png	95
762	Premier League	League	https://media.api-sports.io/football/leagues/762.png	105
763	Mauritian League	League	https://media.api-sports.io/football/leagues/763.png	106
764	Premier League	League	https://media.api-sports.io/football/leagues/764.png	109
765	PFL	League	https://media.api-sports.io/football/leagues/765.png	127
767	CONCACAF League	Cup	https://media.api-sports.io/football/leagues/767.png	169
771	COSAFA U20 Championship	Cup	https://media.api-sports.io/football/leagues/771.png	169
774	3. Division - Girone 1	League	https://media.api-sports.io/football/leagues/774.png	120
775	3. Division - Girone 2	League	https://media.api-sports.io/football/leagues/775.png	120
776	3. Division - Girone 3	League	https://media.api-sports.io/football/leagues/776.png	120
777	3. Division - Girone 4	League	https://media.api-sports.io/football/leagues/777.png	120
778	3. Division - Girone 5	League	https://media.api-sports.io/football/leagues/778.png	120
779	3. Division - Girone 6	League	https://media.api-sports.io/football/leagues/779.png	120
780	III Liga - Group 1	League	https://media.api-sports.io/football/leagues/780.png	128
781	III Liga - Group 2	League	https://media.api-sports.io/football/leagues/781.png	128
782	III Liga - Group 3	League	https://media.api-sports.io/football/leagues/782.png	128
783	III Liga - Group 4	League	https://media.api-sports.io/football/leagues/783.png	128
784	Liga III - Serie 1	League	https://media.api-sports.io/football/leagues/784.png	131
785	Liga III - Serie 2	League	https://media.api-sports.io/football/leagues/785.png	131
786	Liga III - Serie 3	League	https://media.api-sports.io/football/leagues/786.png	131
787	Liga III - Serie 4	League	https://media.api-sports.io/football/leagues/787.png	131
788	Liga III - Serie 5	League	https://media.api-sports.io/football/leagues/788.png	131
789	Liga III - Serie 6	League	https://media.api-sports.io/football/leagues/789.png	131
790	Liga III - Serie 7	League	https://media.api-sports.io/football/leagues/790.png	131
791	Liga III - Serie 8	League	https://media.api-sports.io/football/leagues/791.png	131
792	Liga III - Serie 9	League	https://media.api-sports.io/football/leagues/792.png	131
793	Liga III - Serie 10	League	https://media.api-sports.io/football/leagues/793.png	131
794	3. SNL - East	League	https://media.api-sports.io/football/leagues/794.png	141
795	3. SNL - West	League	https://media.api-sports.io/football/leagues/795.png	141
796	2. Liga Interregional - Group 1	League	https://media.api-sports.io/football/leagues/796.png	149
797	2. Liga Interregional - Group 2	League	https://media.api-sports.io/football/leagues/797.png	149
798	2. Liga Interregional - Group 3	League	https://media.api-sports.io/football/leagues/798.png	149
799	2. Liga Interregional - Group 4	League	https://media.api-sports.io/football/leagues/799.png	149
800	2. Liga Interregional - Group 5	League	https://media.api-sports.io/football/leagues/800.png	149
801	2. Liga Interregional - Group 6	League	https://media.api-sports.io/football/leagues/801.png	149
802	Cup	Cup	https://media.api-sports.io/football/leagues/802.png	163
809	Super Cup	Cup	https://media.api-sports.io/football/leagues/809.png	3
810	Super Copa	Cup	https://media.api-sports.io/football/leagues/810.png	6
811	Federation Cup	Cup	https://media.api-sports.io/football/leagues/811.png	13
813	Elite Two	League	https://media.api-sports.io/football/leagues/813.png	29
816	Shield Cup	Cup	https://media.api-sports.io/football/leagues/816.png	83
817	Super Cup Primavera	Cup	https://media.api-sports.io/football/leagues/817.png	79
819	Super Cup	Cup	https://media.api-sports.io/football/leagues/819.png	86
820	Crown Prince Cup	Cup	https://media.api-sports.io/football/leagues/820.png	87
821	FA Trophy	Cup	https://media.api-sports.io/football/leagues/821.png	104
822	Cup	Cup	https://media.api-sports.io/football/leagues/822.png	111
828	Ligue 2	League	https://media.api-sports.io/football/leagues/828.png	156
829	Youth League	League	https://media.api-sports.io/football/leagues/829.png	158
830	Super Cup	Cup	https://media.api-sports.io/football/leagues/830.png	163
832	Coupe de la Ligue	Cup	https://media.api-sports.io/football/leagues/832.png	2
837	Rock Cup	Cup	https://media.api-sports.io/football/leagues/837.png	62
838	Super Cup	Cup	https://media.api-sports.io/football/leagues/838.png	83
840	Taça Revelação U23	Cup	https://media.api-sports.io/football/leagues/840.png	129
841	QFA Cup	Cup	https://media.api-sports.io/football/leagues/841.png	130
843	Copa Verde	Cup	https://media.api-sports.io/football/leagues/843.png	24
844	Ligue 1	League	https://media.api-sports.io/football/leagues/844.png	35
845	GFA League	League	https://media.api-sports.io/football/leagues/845.png	58
847	Premier League	League	https://media.api-sports.io/football/leagues/847.png	51
849	Baltic Cup	Cup	https://media.api-sports.io/football/leagues/849.png	169
475	Paulista - A1	League	https://media.api-sports.io/football/leagues/475.png	24
476	Paulista - A2	League	https://media.api-sports.io/football/leagues/476.png	24
477	Gaúcho - 1	League	https://media.api-sports.io/football/leagues/477.png	24
478	Gaúcho - 2	League	https://media.api-sports.io/football/leagues/478.png	24
479	Canadian Premier League	League	https://media.api-sports.io/football/leagues/479.png	30
483	Copa de la Superliga	Cup	https://media.api-sports.io/football/leagues/483.png	6
500	FA Cup	Cup	https://media.api-sports.io/football/leagues/500.png	101
532	AFC U23 Asian Cup	Cup	https://media.api-sports.io/football/leagues/532.png	169
536	CONCACAF Nations League	Cup	https://media.api-sports.io/football/leagues/536.png	169
538	Africa Cup of Nations U20	Cup	https://media.api-sports.io/football/leagues/538.png	169
540	CONMEBOL Libertadores U20	Cup	https://media.api-sports.io/football/leagues/540.png	169
541	CONMEBOL Recopa	Cup	https://media.api-sports.io/football/leagues/541.png	169
542	Iraqi League	League	https://media.api-sports.io/football/leagues/542.png	76
863	Cup	Cup	https://media.api-sports.io/football/leagues/863.png	83
881	Olympics Men - Qualification Concacaf	Cup	https://media.api-sports.io/football/leagues/881.png	169
882	Olympics Women - Qualification Asia	Cup	https://media.api-sports.io/football/leagues/882.png	169
885	Campeones Cup	Cup	https://media.api-sports.io/football/leagues/885.png	169
548	Super Cup	Cup	https://media.api-sports.io/football/leagues/548.png	82
549	Damallsvenskan	League	https://media.api-sports.io/football/leagues/549.png	148
558	Supercopa	Cup	https://media.api-sports.io/football/leagues/558.png	126
562	Reserve League	League	https://media.api-sports.io/football/leagues/562.png	15
565	Liga Primera U20	League	https://media.api-sports.io/football/leagues/565.png	117
643	3. liga - Bratislava	League	https://media.api-sports.io/football/leagues/643.png	140
644	3. liga - West	League	https://media.api-sports.io/football/leagues/644.png	140
645	3. liga - East	League	https://media.api-sports.io/football/leagues/645.png	140
646	3. liga - Center	League	https://media.api-sports.io/football/leagues/646.png	140
647	Lao League	League	https://media.api-sports.io/football/leagues/647.png	89
648	Tasmania NPL	League	https://media.api-sports.io/football/leagues/648.png	9
649	Supreme Division Women	League	https://media.api-sports.io/football/leagues/649.png	132
650	Second League - Group 3	League	https://media.api-sports.io/football/leagues/650.png	132
651	Second League - Group 1	League	https://media.api-sports.io/football/leagues/651.png	132
652	Second League - Group 2	League	https://media.api-sports.io/football/leagues/652.png	132
653	Second League - Group 4	League	https://media.api-sports.io/football/leagues/653.png	132
654	Super Cup	Cup	https://media.api-sports.io/football/leagues/654.png	7
656	Super Cup	Cup	https://media.api-sports.io/football/leagues/656.png	25
657	Cup	Cup	https://media.api-sports.io/football/leagues/657.png	50
658	Cup	Cup	https://media.api-sports.io/football/leagues/658.png	90
659	Super Cup	Cup	https://media.api-sports.io/football/leagues/659.png	78
660	WK-League	League	https://media.api-sports.io/football/leagues/660.png	144
661	Cup	Cup	https://media.api-sports.io/football/leagues/661.png	96
662	Copa por México	Cup	https://media.api-sports.io/football/leagues/662.png	107
663	Super Cup	Cup	https://media.api-sports.io/football/leagues/663.png	132
666	Friendlies Women	Cup	https://media.api-sports.io/football/leagues/666.png	169
667	Friendlies Clubs	Cup	https://media.api-sports.io/football/leagues/667.png	169
668	1. Liga U19	League	https://media.api-sports.io/football/leagues/668.png	43
669	1. Liga Women	League	https://media.api-sports.io/football/leagues/669.png	43
670	Community Shield Women	Cup	https://media.api-sports.io/football/leagues/670.png	49
671	Úrvalsdeild Women	League	https://media.api-sports.io/football/leagues/671.png	72
672	David Kipiani Cup	Cup	https://media.api-sports.io/football/leagues/672.png	59
673	Liga MX Femenil	League	https://media.api-sports.io/football/leagues/673.png	107
674	Cupa	Cup	https://media.api-sports.io/football/leagues/674.png	108
675	U21 Divisie 1	League	https://media.api-sports.io/football/leagues/675.png	115
676	Central Youth League	League	https://media.api-sports.io/football/leagues/676.png	128
678	Super Cup	Cup	https://media.api-sports.io/football/leagues/678.png	38
679	U21 League	League	https://media.api-sports.io/football/leagues/679.png	38
680	Cup	Cup	https://media.api-sports.io/football/leagues/680.png	140
681	Campeonato de Portugal Prio - Group E	League	https://media.api-sports.io/football/leagues/681.png	129
682	Campeonato de Portugal Prio - Group F	League	https://media.api-sports.io/football/leagues/682.png	129
683	Campeonato de Portugal Prio - Group G	League	https://media.api-sports.io/football/leagues/683.png	129
684	Campeonato de Portugal Prio - Group H	League	https://media.api-sports.io/football/leagues/684.png	129
685	3. liga - CFL B	League	https://media.api-sports.io/football/leagues/685.png	43
686	4. liga - Divizie F	League	https://media.api-sports.io/football/leagues/686.png	43
687	Regionalliga - Tirol	League	https://media.api-sports.io/football/leagues/687.png	10
688	Regionalliga - Salzburg	League	https://media.api-sports.io/football/leagues/688.png	10
689	Third Amateur Division - ACFF A	League	https://media.api-sports.io/football/leagues/689.png	16
690	Third Amateur Division - ACFF B	League	https://media.api-sports.io/football/leagues/690.png	16
691	Provincial - Brabant ACFF	League	https://media.api-sports.io/football/leagues/691.png	16
692	Primera División RFEF - Group 5	League	https://media.api-sports.io/football/leagues/692.png	145
693	Gamma Ethniki - Group 9	League	https://media.api-sports.io/football/leagues/693.png	63
694	Gamma Ethniki - Group 10	League	https://media.api-sports.io/football/leagues/694.png	63
695	U18 Premier League - North	League	https://media.api-sports.io/football/leagues/695.png	49
696	U18 Premier League - South	League	https://media.api-sports.io/football/leagues/696.png	49
697	WSL Cup	Cup	https://media.api-sports.io/football/leagues/697.png	49
699	Women's Championship	League	https://media.api-sports.io/football/leagues/699.png	49
700	Kakkosen Cup	Cup	https://media.api-sports.io/football/leagues/700.png	55
701	Liga Revelação U23	League	https://media.api-sports.io/football/leagues/701.png	129
702	Premier League 2 Division One	League	https://media.api-sports.io/football/leagues/702.png	49
703	Professional Development League	League	https://media.api-sports.io/football/leagues/703.png	49
704	Coppa Italia Primavera	Cup	https://media.api-sports.io/football/leagues/704.png	79
705	Campionato Primavera - 1	League	https://media.api-sports.io/football/leagues/705.png	79
706	Campionato Primavera - 2	League	https://media.api-sports.io/football/leagues/706.png	79
707	Cup	Cup	https://media.api-sports.io/football/leagues/707.png	1
708	Super Cup	Cup	https://media.api-sports.io/football/leagues/708.png	1
709	Cup	Cup	https://media.api-sports.io/football/leagues/709.png	7
710	Nacional B	League	https://media.api-sports.io/football/leagues/710.png	21
711	Segunda División	League	https://media.api-sports.io/football/leagues/711.png	31
712	Liga Femenina	League	https://media.api-sports.io/football/leagues/712.png	34
713	Superliga	Cup	https://media.api-sports.io/football/leagues/713.png	34
715	DFB Junioren Pokal	Cup	https://media.api-sports.io/football/leagues/715.png	60
717	I-League - 2nd Division	League	https://media.api-sports.io/football/leagues/717.png	73
719	Super Cup	Cup	https://media.api-sports.io/football/leagues/719.png	87
720	Emir Cup	Cup	https://media.api-sports.io/football/leagues/720.png	87
721	Cup	Cup	https://media.api-sports.io/football/leagues/721.png	97
722	Liga Premier Serie A	League	https://media.api-sports.io/football/leagues/722.png	107
723	Cup	Cup	https://media.api-sports.io/football/leagues/723.png	110
724	U18 Divisie 1	League	https://media.api-sports.io/football/leagues/724.png	115
726	Sultan Cup	Cup	https://media.api-sports.io/football/leagues/726.png	121
727	Super Cup	Cup	https://media.api-sports.io/football/leagues/727.png	128
728	Liga 1 Feminin	League	https://media.api-sports.io/football/leagues/728.png	131
725	Toppserien	League	https://media.api-sports.io/football/leagues/725.png	120
736	Elitettan	League	https://media.api-sports.io/football/leagues/736.png	148
743	UEFA Championship - Women	Cup	https://media.api-sports.io/football/leagues/743.png	169
812	Super Cup	Cup	https://media.api-sports.io/football/leagues/812.png	15
814	Reykjavik Cup	Cup	https://media.api-sports.io/football/leagues/814.png	72
815	Fotbolti.net Cup A	Cup	https://media.api-sports.io/football/leagues/815.png	72
818	Super Cup	Cup	https://media.api-sports.io/football/leagues/818.png	84
823	Nasjonal U19 Champions League	Cup	https://media.api-sports.io/football/leagues/823.png	120
824	Emir Cup	Cup	https://media.api-sports.io/football/leagues/824.png	130
825	Qatar Cup	Cup	https://media.api-sports.io/football/leagues/825.png	130
826	Super Cup	Cup	https://media.api-sports.io/football/leagues/826.png	135
831	Super Cup	Cup	https://media.api-sports.io/football/leagues/831.png	165
833	Queensland Premier League	League	https://media.api-sports.io/football/leagues/833.png	9
834	South Australia State League 1	League	https://media.api-sports.io/football/leagues/834.png	9
835	New South Wales NPL 2	League	https://media.api-sports.io/football/leagues/835.png	9
836	Victoria NPL 2	League	https://media.api-sports.io/football/leagues/836.png	9
839	Super Cup	Cup	https://media.api-sports.io/football/leagues/839.png	96
842	Super Copa	Cup	https://media.api-sports.io/football/leagues/842.png	161
846	Somali Premier League	League	https://media.api-sports.io/football/leagues/846.png	142
848	UEFA Europa Conference League	Cup	https://media.api-sports.io/football/leagues/848.png	169
851	Carioca A2	League	https://media.api-sports.io/football/leagues/851.png	24
852	Super Cup	Cup	https://media.api-sports.io/football/leagues/852.png	42
853	Supercopa de Ecuador	Cup	https://media.api-sports.io/football/leagues/853.png	46
854	WE League	League	https://media.api-sports.io/football/leagues/854.png	82
855	Dhivehi Premier League	League	https://media.api-sports.io/football/leagues/855.png	102
856	CONCACAF Caribbean Club Championship	Cup	https://media.api-sports.io/football/leagues/856.png	169
857	Campeón de Campeones	Cup	https://media.api-sports.io/football/leagues/857.png	107
858	CONCACAF Gold Cup - Qualification	Cup	https://media.api-sports.io/football/leagues/858.png	169
859	COSAFA Cup	Cup	https://media.api-sports.io/football/leagues/859.png	169
860	Arab Cup	Cup	https://media.api-sports.io/football/leagues/860.png	169
910	Youth Viareggio Cup	Cup	https://media.api-sports.io/football/leagues/910.png	169
861	U20 League	League	https://media.api-sports.io/football/leagues/861.png	107
862	3. Division	League	https://media.api-sports.io/football/leagues/862.png	44
864	Supercopa	Cup	https://media.api-sports.io/football/leagues/864.png	37
865	Liga 3	League	https://media.api-sports.io/football/leagues/865.png	129
866	MLS All-Star	Cup	https://media.api-sports.io/football/leagues/866.png	162
891	Coppa Italia Serie C	Cup	https://media.api-sports.io/football/leagues/891.png	79
868	Premier League	League	https://media.api-sports.io/football/leagues/868.png	122
869	CECAFA Club Cup	Cup	https://media.api-sports.io/football/leagues/869.png	169
870	Premier League	League	https://media.api-sports.io/football/leagues/870.png	38
871	Premier League Cup	Cup	https://media.api-sports.io/football/leagues/871.png	49
872	Liga Premier Serie B	League	https://media.api-sports.io/football/leagues/872.png	107
873	Thai Champions Cup	Cup	https://media.api-sports.io/football/leagues/873.png	153
874	Australia Cup	Cup	https://media.api-sports.io/football/leagues/874.png	9
875	Segunda División RFEF - Group 1	League	https://media.api-sports.io/football/leagues/875.png	145
876	Segunda División RFEF - Group 2	League	https://media.api-sports.io/football/leagues/876.png	145
877	Segunda División RFEF - Group 3	League	https://media.api-sports.io/football/leagues/877.png	145
878	Segunda División RFEF - Group 4	League	https://media.api-sports.io/football/leagues/878.png	145
879	Segunda División RFEF - Group 5	League	https://media.api-sports.io/football/leagues/879.png	145
880	World Cup - Women - Qualification Europe	Cup	https://media.api-sports.io/football/leagues/880.png	169
883	Reserve League	League	https://media.api-sports.io/football/leagues/883.png	115
884	Super Cup	Cup	https://media.api-sports.io/football/leagues/884.png	134
887	Second League	League	https://media.api-sports.io/football/leagues/887.png	47
888	Second League - Group B	League	https://media.api-sports.io/football/leagues/888.png	47
889	Second League - Group C	League	https://media.api-sports.io/football/leagues/889.png	47
890	U20 Elite League	Cup	https://media.api-sports.io/football/leagues/890.png	169
892	Coppa Italia Serie D	Cup	https://media.api-sports.io/football/leagues/892.png	79
867	Copa Paulino Alcantara	League	https://media.api-sports.io/football/leagues/867.png	127
895	League Cup	Cup	https://media.api-sports.io/football/leagues/895.png	47
896	Super Cup	Cup	https://media.api-sports.io/football/leagues/896.png	160
898	League Cup	Cup	https://media.api-sports.io/football/leagues/898.png	153
902	Algarve Cup	Cup	https://media.api-sports.io/football/leagues/902.png	169
903	The Atlantic Cup	Cup	https://media.api-sports.io/football/leagues/903.png	169
905	Super Cup	Cup	https://media.api-sports.io/football/leagues/905.png	75
36	Africa Cup of Nations - Qualification	Cup	https://media.api-sports.io/football/leagues/36.png	169
944	Super Cup	Cup	https://media.api-sports.io/football/leagues/944.png	121
945	International Champions Cup - Women	Cup	https://media.api-sports.io/football/leagues/945.png	169
946	Second NL	League	https://media.api-sports.io/football/leagues/946.png	39
947	DFB Pokal - Women	Cup	https://media.api-sports.io/football/leagues/947.png	60
948	1a Divisão - Women	League	https://media.api-sports.io/football/leagues/948.png	129
949	CONMEBOL Libertadores Femenina	Cup	https://media.api-sports.io/football/leagues/949.png	169
950	World Cup - U17 - Women	Cup	https://media.api-sports.io/football/leagues/950.png	169
951	South American Youth Games	Cup	https://media.api-sports.io/football/leagues/951.png	169
952	AFC U23 Asian Cup - Qualification	Cup	https://media.api-sports.io/football/leagues/952.png	169
953	Africa U23 Cup of Nations - Qualification	Cup	https://media.api-sports.io/football/leagues/953.png	169
954	National League - Central	League	https://media.api-sports.io/football/leagues/954.png	116
955	National League - National	League	https://media.api-sports.io/football/leagues/955.png	116
956	National League - Northern	League	https://media.api-sports.io/football/leagues/956.png	116
957	National League - Southern	League	https://media.api-sports.io/football/leagues/957.png	116
958	Copa Costa Rica	Cup	https://media.api-sports.io/football/leagues/958.png	37
959	Cup	Cup	https://media.api-sports.io/football/leagues/959.png	139
961	Supercopa	Cup	https://media.api-sports.io/football/leagues/961.png	125
962	Premier League	League	https://media.api-sports.io/football/leagues/962.png	92
966	Cup	Cup	https://media.api-sports.io/football/leagues/966.png	61
967	Cup	Cup	https://media.api-sports.io/football/leagues/967.png	91
968	Championnat D1	League	https://media.api-sports.io/football/leagues/968.png	57
971	Shield Cup	Cup	https://media.api-sports.io/football/leagues/971.png	85
975	Serie C - Relegation - Play-offs	League	https://media.api-sports.io/football/leagues/975.png	79
976	Serie C - Promotion - Play-offs	League	https://media.api-sports.io/football/leagues/976.png	79
974	Serie C - Supercoppa Lega Finals	League	https://media.api-sports.io/football/leagues/974.png	79
977	Tercera División RFEF - Promotion - Play-offs	League	https://media.api-sports.io/football/leagues/977.png	145
978	2nd Division - Play-offs	League	https://media.api-sports.io/football/leagues/978.png	1
979	Provincial - Play-offs VV	League	https://media.api-sports.io/football/leagues/979.png	16
980	Provincial - Play-offs ACFF	League	https://media.api-sports.io/football/leagues/980.png	16
981	Third Amateur Division - Play-offs	League	https://media.api-sports.io/football/leagues/981.png	16
982	Denmark Series - Promotion Round	League	https://media.api-sports.io/football/leagues/982.png	44
983	Denmark Series - Relegation Round	League	https://media.api-sports.io/football/leagues/983.png	44
984	National League - North - Play-offs	League	https://media.api-sports.io/football/leagues/984.png	49
985	National League - South - Play-offs	League	https://media.api-sports.io/football/leagues/985.png	49
986	Non League Div One - Play-offs	League	https://media.api-sports.io/football/leagues/986.png	49
987	U18 Premier League - Championship	League	https://media.api-sports.io/football/leagues/987.png	49
988	Oberliga - Promotion Round	League	https://media.api-sports.io/football/leagues/988.png	60
989	Oberliga - Relegation Round	League	https://media.api-sports.io/football/leagues/989.png	60
990	Gamma Ethniki - Promotion Group	League	https://media.api-sports.io/football/leagues/990.png	63
991	Campeonato de Portugal Prio - Promotion Round	League	https://media.api-sports.io/football/leagues/991.png	129
992	Football League - Championship	League	https://media.api-sports.io/football/leagues/992.png	136
993	Non League Premier - Isthmian - Play-offs	League	https://media.api-sports.io/football/leagues/993.png	49
994	Non League Premier - Northern - Play-offs	League	https://media.api-sports.io/football/leagues/994.png	49
995	Non League Premier - Southern South - Play-offs	League	https://media.api-sports.io/football/leagues/995.png	49
996	Non League Premier - Southern Central - Play-offs	League	https://media.api-sports.io/football/leagues/996.png	49
997	Serie D - Promotion - Play-offs	League	https://media.api-sports.io/football/leagues/997.png	79
998	Serie D - Relegation - Play-offs	League	https://media.api-sports.io/football/leagues/998.png	79
999	Serie D - Championship Round	League	https://media.api-sports.io/football/leagues/999.png	79
1000	Segunda División RFEF - Play-offs	League	https://media.api-sports.io/football/leagues/1000.png	145
1002	Regionalliga - Promotion Play-offs	League	https://media.api-sports.io/football/leagues/1002.png	60
1003	Regionalliga - Relegation Round	League	https://media.api-sports.io/football/leagues/1003.png	60
1004	Derde Divisie - Relegation Round	League	https://media.api-sports.io/football/leagues/1004.png	115
1005	1. Liga Classic - Play-offs	League	https://media.api-sports.io/football/leagues/1005.png	149
1006	Primera División RFEF - Play Offs	League	https://media.api-sports.io/football/leagues/1006.png	145
1007	3. Lig - Play-offs	League	https://media.api-sports.io/football/leagues/1007.png	157
886	UEFA U17 Championship - Qualification	Cup	https://media.api-sports.io/football/leagues/886.png	169
893	UEFA U19 Championship - Qualification	Cup	https://media.api-sports.io/football/leagues/893.png	169
894	Asian Cup Women - Qualification	Cup	https://media.api-sports.io/football/leagues/894.png	169
897	Asian Cup Women	Cup	https://media.api-sports.io/football/leagues/897.png	169
899	League Cup	Cup	https://media.api-sports.io/football/leagues/899.png	55
900	Tipsport Malta Cup	Cup	https://media.api-sports.io/football/leagues/900.png	169
901	Ykköscup	Cup	https://media.api-sports.io/football/leagues/901.png	55
904	SheBelieves Cup	Cup	https://media.api-sports.io/football/leagues/904.png	169
906	Reserve League	League	https://media.api-sports.io/football/leagues/906.png	6
907	Primera Division	League	https://media.api-sports.io/football/leagues/907.png	40
908	AFF U23 Championship	Cup	https://media.api-sports.io/football/leagues/908.png	169
1009	Liga III - Play-offs	League	https://media.api-sports.io/football/leagues/1009.png	131
1010	3. liga - Promotion Play-off	League	https://media.api-sports.io/football/leagues/1010.png	43
1011	Second Amateur Division - Play-offs 	League	https://media.api-sports.io/football/leagues/1011.png	16
1014	Second League - Play-offs	League	https://media.api-sports.io/football/leagues/1014.png	47
1016	CAC Games	Cup	https://media.api-sports.io/football/leagues/1016.png	169
909	MLS Next Pro	League	https://media.api-sports.io/football/leagues/909.png	162
911	Southeast Asian Games	Cup	https://media.api-sports.io/football/leagues/911.png	169
912	CONCACAF Women U17	Cup	https://media.api-sports.io/football/leagues/912.png	169
913	CONMEBOL - UEFA Finalissima	Cup	https://media.api-sports.io/football/leagues/913.png	169
914	Tournoi Maurice Revello	Cup	https://media.api-sports.io/football/leagues/914.png	169
915	1. Division Women	League	https://media.api-sports.io/football/leagues/915.png	120
916	Kirin Cup	Cup	https://media.api-sports.io/football/leagues/916.png	169
917	Copa Ecuador	Cup	https://media.api-sports.io/football/leagues/917.png	46
918	UEFA U19 Championship - Women	Cup	https://media.api-sports.io/football/leagues/918.png	169
919	Mediterranean Games	Cup	https://media.api-sports.io/football/leagues/919.png	169
920	World Cup - U20 - Women	Cup	https://media.api-sports.io/football/leagues/920.png	169
921	UEFA U17 Championship	Cup	https://media.api-sports.io/football/leagues/921.png	169
922	Africa Cup of Nations - Women	Cup	https://media.api-sports.io/football/leagues/922.png	169
923	League 1 Ontario	League	https://media.api-sports.io/football/leagues/923.png	30
924	Piala Presiden	Cup	https://media.api-sports.io/football/leagues/924.png	74
926	Copa America Femenina	Cup	https://media.api-sports.io/football/leagues/926.png	169
927	World Cup - Women - Qualification Concacaf	Cup	https://media.api-sports.io/football/leagues/927.png	169
928	AFF U19 Championship	Cup	https://media.api-sports.io/football/leagues/928.png	169
929	League Two	League	https://media.api-sports.io/football/leagues/929.png	32
930	Copa Uruguay	Cup	https://media.api-sports.io/football/leagues/930.png	161
931	Non League Premier - Southern Central	League	https://media.api-sports.io/football/leagues/931.png	49
932	Non League Div One - Northern East	League	https://media.api-sports.io/football/leagues/932.png	49
933	Non League Div One - Southern Central	League	https://media.api-sports.io/football/leagues/933.png	49
934	Arab Championship - U20	Cup	https://media.api-sports.io/football/leagues/934.png	169
935	Diski Shield	Cup	https://media.api-sports.io/football/leagues/935.png	143
936	Catarinense - 2	League	https://media.api-sports.io/football/leagues/936.png	24
937	Emirates Cup	Cup	https://media.api-sports.io/football/leagues/937.png	169
938	Oberliga - Bayern Nord	League	https://media.api-sports.io/football/leagues/938.png	60
939	Oberliga - Bayern Süd	League	https://media.api-sports.io/football/leagues/939.png	60
940	COTIF Tournament	Cup	https://media.api-sports.io/football/leagues/940.png	169
941	Islamic Solidarity Games	Cup	https://media.api-sports.io/football/leagues/941.png	169
1039	Premier League International Cup	Cup	https://media.api-sports.io/football/leagues/1039.png	169
1040	UEFA Nations League - Women	Cup	https://media.api-sports.io/football/leagues/1040.png	169
1041	Júniores U19	League	https://media.api-sports.io/football/leagues/1041.png	129
1042	Super Cup	Cup	https://media.api-sports.io/football/leagues/1042.png	62
1043	African Football League	Cup	https://media.api-sports.io/football/leagues/1043.png	169
1044	Erste Liga Cup	Cup	https://media.api-sports.io/football/leagues/1044.png	149
1045	Pan American Games	Cup	https://media.api-sports.io/football/leagues/1045.png	169
1048	Premier Division	League	https://media.api-sports.io/football/leagues/1048.png	5
1049	King's Cup	Cup	https://media.api-sports.io/football/leagues/1049.png	12
1050	Super Cup	Cup	https://media.api-sports.io/football/leagues/1050.png	104
1052	Kakkonen - Play-offs	League	https://media.api-sports.io/football/leagues/1052.png	55
1053	Division 2 - Play-offs	League	https://media.api-sports.io/football/leagues/1053.png	148
1054	2. Division - Play-offs	League	https://media.api-sports.io/football/leagues/1054.png	120
1055	Ettan - Relegation Round	League	https://media.api-sports.io/football/leagues/1055.png	148
1056	National League - Championship - Final	League	https://media.api-sports.io/football/leagues/1056.png	116
1058	Supercopa Femenina	Cup	https://media.api-sports.io/football/leagues/1058.png	145
1061	Second League A - Spring Season Gold	League	https://media.api-sports.io/football/leagues/1061.png	132
1064	Second League A - Spring Season Silver	League	https://media.api-sports.io/football/leagues/1064.png	132
1065	U19 League	League	https://media.api-sports.io/football/leagues/1065.png	38
1068	FA Youth Cup	Cup	https://media.api-sports.io/football/leagues/1068.png	49
1072	All Africa Games	Cup	https://media.api-sports.io/football/leagues/1072.png	169
1074	SWPL Cup	Cup	https://media.api-sports.io/football/leagues/1074.png	136
1078	SWF Scottish Cup	Cup	https://media.api-sports.io/football/leagues/1078.png	136
1079	Yemeni League	League	https://media.api-sports.io/football/leagues/1079.png	170
1080	Premier Division	League	https://media.api-sports.io/football/leagues/1080.png	64
1084	Championnat National	League	https://media.api-sports.io/football/leagues/1084.png	154
1099	Gamma Ethniki - Relegation Play-offs	League	https://media.api-sports.io/football/leagues/1099.png	63
1109	Super Cup	Cup	https://media.api-sports.io/football/leagues/1109.png	12
1111	NB III - Promotion Play-offs	League	https://media.api-sports.io/football/leagues/1111.png	71
1121	Second League A - Promotion Play-offs	League	https://media.api-sports.io/football/leagues/1121.png	132
960	Euro Championship - Qualification	Cup	https://media.api-sports.io/football/leagues/960.png	169
963	CONCACAF U17	Cup	https://media.api-sports.io/football/leagues/963.png	169
964	Copa de la División Profesional	Cup	https://media.api-sports.io/football/leagues/964.png	21
965	AFC U20 Asian Cup	Cup	https://media.api-sports.io/football/leagues/965.png	169
969	Primeira Divisão	League	https://media.api-sports.io/football/leagues/969.png	98
970	CONMEBOL - U17	Cup	https://media.api-sports.io/football/leagues/970.png	169
972	Super Cup	Cup	https://media.api-sports.io/football/leagues/972.png	32
973	CAF Cup of Nations - U17	Cup	https://media.api-sports.io/football/leagues/973.png	169
1008	CAFA Nations Cup	Cup	https://media.api-sports.io/football/leagues/1008.png	169
1012	AFC U17 Asian Cup	Cup	https://media.api-sports.io/football/leagues/1012.png	169
1013	All-Island Cup - Women	Cup	https://media.api-sports.io/football/leagues/1013.png	169
1015	CAF U23 Cup of Nations	Cup	https://media.api-sports.io/football/leagues/1015.png	169
1017	U23 League	League	https://media.api-sports.io/football/leagues/1017.png	107
1018	Federation Cup	Cup	https://media.api-sports.io/football/leagues/1018.png	91
1019	Charity Shield	Cup	https://media.api-sports.io/football/leagues/1019.png	119
1020	Calcutta Premier Division	League	https://media.api-sports.io/football/leagues/1020.png	73
1021	Super Cup	Cup	https://media.api-sports.io/football/leagues/1021.png	39
1022	Premier League - Summer Series	League	https://media.api-sports.io/football/leagues/1022.png	49
1023	NB III - Southeast	League	https://media.api-sports.io/football/leagues/1023.png	71
1024	UEFA - CONMEBOL - Club Challenge	Cup	https://media.api-sports.io/football/leagues/1024.png	169
1025	Second League A - Fall Season Gold	League	https://media.api-sports.io/football/leagues/1025.png	132
1026	Second League A - Fall Season Silver	League	https://media.api-sports.io/football/leagues/1026.png	132
1027	3. Lig - Group 4	League	https://media.api-sports.io/football/leagues/1027.png	157
1028	Concacaf Central American Cup	Cup	https://media.api-sports.io/football/leagues/1028.png	169
1029	National 3 - Group G	League	https://media.api-sports.io/football/leagues/1029.png	56
1030	Goiano - 2	League	https://media.api-sports.io/football/leagues/1030.png	24
1031	Premier League	League	https://media.api-sports.io/football/leagues/1031.png	20
1032	Copa de la Liga Profesional	League	https://media.api-sports.io/football/leagues/1032.png	6
1033	Ekstraliga Women	League	https://media.api-sports.io/football/leagues/1033.png	128
1034	2. Frauen Bundesliga	League	https://media.api-sports.io/football/leagues/1034.png	60
1035	Copa Rio	Cup	https://media.api-sports.io/football/leagues/1035.png	24
1036	Copa Santa Catarina	Cup	https://media.api-sports.io/football/leagues/1036.png	24
1037	Paraibano 2	League	https://media.api-sports.io/football/leagues/1037.png	24
1038	King's Cup	Cup	https://media.api-sports.io/football/leagues/1038.png	169
850	UEFA U21 Championship - Qualification	Cup	https://media.api-sports.io/football/leagues/850.png	169
1149	Potiguar - 2	League	https://media.api-sports.io/football/leagues/1149.png	24
1150	Gaúcho - 3	League	https://media.api-sports.io/football/leagues/1150.png	24
1151	Pernambucano - 3	League	https://media.api-sports.io/football/leagues/1151.png	24
1152	U19 Divisie 1	League	https://media.api-sports.io/football/leagues/1152.png	115
1153	AFC U20 Asian Cup - Qualification	Cup	https://media.api-sports.io/football/leagues/1153.png	169
1154	Catarinense - 3	League	https://media.api-sports.io/football/leagues/1154.png	24
1155	Carioca B2	League	https://media.api-sports.io/football/leagues/1155.png	24
1156	National League Cup	Cup	https://media.api-sports.io/football/leagues/1156.png	49
1157	Paraense U20	League	https://media.api-sports.io/football/leagues/1157.png	24
1158	Copa Gaúcha	Cup	https://media.api-sports.io/football/leagues/1158.png	24
1159	CECAFA U20 Championship	Cup	https://media.api-sports.io/football/leagues/1159.png	169
1160	Sapling Cup	Cup	https://media.api-sports.io/football/leagues/1160.png	70
1161	AFC U17 Asian Cup - Qualification	Cup	https://media.api-sports.io/football/leagues/1161.png	169
1162	AGCFF Gulf Champions League	Cup	https://media.api-sports.io/football/leagues/1162.png	169
1163	African Nations Championship - Qualification	Cup	https://media.api-sports.io/football/leagues/1163.png	169
1164	CAF Women's Champions League	Cup	https://media.api-sports.io/football/leagues/1164.png	169
1165	Copa Fares Lopes	Cup	https://media.api-sports.io/football/leagues/1165.png	24
1166	Super Cup	Cup	https://media.api-sports.io/football/leagues/1166.png	29
1167	Recopa	Cup	https://media.api-sports.io/football/leagues/1167.png	37
1170	MFL Cup	Cup	https://media.api-sports.io/football/leagues/1170.png	101
1171	Coppa Italia Women	Cup	https://media.api-sports.io/football/leagues/1171.png	79
1173	Challenge Cup	Cup	https://media.api-sports.io/football/leagues/1173.png	104
1174	Hun Sen Cup	Cup	https://media.api-sports.io/football/leagues/1174.png	28
1001	CONCACAF Women U20	Cup	https://media.api-sports.io/football/leagues/1001.png	169
1046	CONCACAF Gold Cup - Qualification - Women	Cup	https://media.api-sports.io/football/leagues/1046.png	169
1047	Olympics Women - Qualification CAF	Cup	https://media.api-sports.io/football/leagues/1047.png	169
1051	HKPL Cup	Cup	https://media.api-sports.io/football/leagues/1051.png	70
1057	CONCACAF Gold Cup - Women	Cup	https://media.api-sports.io/football/leagues/1057.png	169
1059	Recopa Catarinense	Cup	https://media.api-sports.io/football/leagues/1059.png	24
1060	CONMEBOL - Pre-Olympic Tournament	Cup	https://media.api-sports.io/football/leagues/1060.png	169
1062	Paulista - A4	League	https://media.api-sports.io/football/leagues/1062.png	24
1063	Copa Alagoas	Cup	https://media.api-sports.io/football/leagues/1063.png	24
1066	CONCACAF U20 - Qualification	Cup	https://media.api-sports.io/football/leagues/1066.png	169
1067	Torneo Promocional Amateur	League	https://media.api-sports.io/football/leagues/1067.png	6
1069	Goiano U20	League	https://media.api-sports.io/football/leagues/1069.png	24
1070	AFC U20 Asian Cup - Women	Cup	https://media.api-sports.io/football/leagues/1070.png	169
1071	Paranaense U20	League	https://media.api-sports.io/football/leagues/1071.png	24
1073	Baiano U20	League	https://media.api-sports.io/football/leagues/1073.png	24
1075	Pro League A	League	https://media.api-sports.io/football/leagues/1075.png	163
1076	Catarinense U20	League	https://media.api-sports.io/football/leagues/1076.png	24
1077	WAFF Championship U23	Cup	https://media.api-sports.io/football/leagues/1077.png	169
1081	CONMEBOL - U17 Femenino	Cup	https://media.api-sports.io/football/leagues/1081.png	169
1082	Copa Rio U20	Cup	https://media.api-sports.io/football/leagues/1082.png	24
1085	CONMEBOL U20 Femenino	Cup	https://media.api-sports.io/football/leagues/1085.png	169
1086	Paulista - U20	League	https://media.api-sports.io/football/leagues/1086.png	24
1087	Ykkösliiga	League	https://media.api-sports.io/football/leagues/1087.png	55
1088	Pernambucano - U20	League	https://media.api-sports.io/football/leagues/1088.png	24
1089	UAE-Qatar - Super Shield	Cup	https://media.api-sports.io/football/leagues/1089.png	169
1090	NNSW League 1	League	https://media.api-sports.io/football/leagues/1090.png	9
1091	Tasmania Northern Championship	League	https://media.api-sports.io/football/leagues/1091.png	9
1092	Capital Territory NPL 2	League	https://media.api-sports.io/football/leagues/1092.png	9
1093	Tasmania Southern Championship	League	https://media.api-sports.io/football/leagues/1093.png	9
1094	Western Australia State League 1	League	https://media.api-sports.io/football/leagues/1094.png	9
1095	USL League One Cup	League	https://media.api-sports.io/football/leagues/1095.png	162
1096	Matogrossense 2	League	https://media.api-sports.io/football/leagues/1096.png	24
1097	Copa Espírito Santo	Cup	https://media.api-sports.io/football/leagues/1097.png	24
1098	Paulista Série B	League	https://media.api-sports.io/football/leagues/1098.png	24
1100	Brasiliense U20	League	https://media.api-sports.io/football/leagues/1100.png	24
1101	AFC U17 Asian Cup - Women	Cup	https://media.api-sports.io/football/leagues/1101.png	169
1102	UEFA U17 Championship - Women	Cup	https://media.api-sports.io/football/leagues/1102.png	169
1103	Premiership Women	League	https://media.api-sports.io/football/leagues/1103.png	119
1104	Liga 3	League	https://media.api-sports.io/football/leagues/1104.png	59
1105	Olympics - Intercontinental Play-offs	Cup	https://media.api-sports.io/football/leagues/1105.png	169
1106	Carioca C	League	https://media.api-sports.io/football/leagues/1106.png	24
1107	Mineiro U20	League	https://media.api-sports.io/football/leagues/1107.png	24
1108	Sergipano U20	League	https://media.api-sports.io/football/leagues/1108.png	24
1110	Alagoano U20	League	https://media.api-sports.io/football/leagues/1110.png	24
1112	Cearense U20	League	https://media.api-sports.io/football/leagues/1112.png	24
1113	Copa Venezuela	Cup	https://media.api-sports.io/football/leagues/1113.png	164
1114	Carioca U20	League	https://media.api-sports.io/football/leagues/1114.png	24
1115	Paraense B2	League	https://media.api-sports.io/football/leagues/1115.png	24
1116	WPSL	League	https://media.api-sports.io/football/leagues/1116.png	162
1117	USL W League	League	https://media.api-sports.io/football/leagues/1117.png	162
1118	NPSL	League	https://media.api-sports.io/football/leagues/1118.png	162
1119	NWSL - Liga MXF Summer Cup	League	https://media.api-sports.io/football/leagues/1119.png	162
1120	Paraibano U20	League	https://media.api-sports.io/football/leagues/1120.png	24
1122	OFC U19 Championship	Cup	https://media.api-sports.io/football/leagues/1122.png	169
1123	Qatar-UAE Super Cup	Cup	https://media.api-sports.io/football/leagues/1123.png	169
1124	Cearense - 3	League	https://media.api-sports.io/football/leagues/1124.png	24
1125	Pernambucano - 2	League	https://media.api-sports.io/football/leagues/1125.png	24
1126	Esiliiga B	League	https://media.api-sports.io/football/leagues/1126.png	50
1127	Chatham Cup	Cup	https://media.api-sports.io/football/leagues/1127.png	116
1128	Brasileiro U17	League	https://media.api-sports.io/football/leagues/1128.png	24
1129	ASEAN Club Championship	Cup	https://media.api-sports.io/football/leagues/1129.png	169
1130	USL Super League	League	https://media.api-sports.io/football/leagues/1130.png	162
1131	Super Cup	League	https://media.api-sports.io/football/leagues/1131.png	109
1132	AFC Challenge League	Cup	https://media.api-sports.io/football/leagues/1132.png	169
1133	Goiano - 3	League	https://media.api-sports.io/football/leagues/1133.png	24
1134	Amazonense - 2	League	https://media.api-sports.io/football/leagues/1134.png	24
1135	Sergipano - 2	League	https://media.api-sports.io/football/leagues/1135.png	24
1136	CONCACAF W Champions Cup	Cup	https://media.api-sports.io/football/leagues/1136.png	169
1137	Supercup der Frauen	League	https://media.api-sports.io/football/leagues/1137.png	60
1138	Paranaense - 3	League	https://media.api-sports.io/football/leagues/1138.png	24
1139	Potiguar - U20	League	https://media.api-sports.io/football/leagues/1139.png	24
1140	AFC Women's Champions League	Cup	https://media.api-sports.io/football/leagues/1140.png	169
1141	Brasiliense B	League	https://media.api-sports.io/football/leagues/1141.png	24
1142	Mineiro - 3	League	https://media.api-sports.io/football/leagues/1142.png	24
1143	Estadual Junior U20	League	https://media.api-sports.io/football/leagues/1143.png	24
1144	Super Cup	Cup	https://media.api-sports.io/football/leagues/1144.png	61
1168	FIFA Intercontinental Cup	Cup	https://media.api-sports.io/football/leagues/1168.png	169
1145	Paraense B1	League	https://media.api-sports.io/football/leagues/1145.png	24
1146	Alagoano - 2	Cup	https://media.api-sports.io/football/leagues/1146.png	24
1148	Maranhense - 2	League	https://media.api-sports.io/football/leagues/1148.png	24
1083	UEFA Championship - Women - Qualification	Cup	https://media.api-sports.io/football/leagues/1083.png	169
1169	EAFF E-1 Football Championship - Qualification	Cup	https://media.api-sports.io/football/leagues/1169.png	169
1180	Copa LDF	Cup	https://media.api-sports.io/football/leagues/1180.png	45
1172	Torneo Amistoso de Verano	Cup	https://media.api-sports.io/football/leagues/1172.png	21
1175	Women's President's Cup	Cup	https://media.api-sports.io/football/leagues/1175.png	77
1176	Super Cup	Cup	https://media.api-sports.io/football/leagues/1176.png	90
1177	Super Cup	Cup	https://media.api-sports.io/football/leagues/1177.png	53
1178	Super Copa International	Cup	https://media.api-sports.io/football/leagues/1178.png	6
1179	Copa do Brasil U17	Cup	https://media.api-sports.io/football/leagues/1179.png	24
1181	Supercopa	Cup	https://media.api-sports.io/football/leagues/1181.png	164
1182	Northern Super League	League	https://media.api-sports.io/football/leagues/1182.png	30
1147	Capixaba B	League	https://media.api-sports.io/football/leagues/1147.png	24
\.


--
-- Data for Name: 3_matches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."3_matches" (id, data, home_team_id, away_team_id, home_team_goals, away_team_goals, home_team_possession, away_team_possession, home_team_shots, away_team_shots, home_team_shots_on_target, away_team_shots_on_target, home_team_fouls, away_team_fouls, home_team_corners, away_team_corners, home_team_yellow_cards, away_team_yellow_cards, home_team_red_cards, away_team_red_cards, league_id, utc_date, matchday, status) FROM stdin;
1208032	2024-08-24 16:30:00	66	42	0	2	39	61	11	9	3	4	8	16	4	1	1	3	\N	\N	39	\N	 2   	1
1208031	2024-08-25 13:00:00	35	34	1	1	39	61	16	14	4	5	20	8	8	9	2	2	\N	\N	39	\N	 2   	1
1208036	2024-08-25 15:30:00	40	55	2	0	63	37	19	8	8	2	10	7	9	4	2	3	\N	\N	39	\N	 2   	1
1208046	2024-08-31 14:00:00	46	66	1	2	58	42	9	10	3	5	13	21	1	4	4	5	\N	\N	39	\N	 3   	1
1208045	2024-08-31 14:00:00	57	36	1	1	49	51	11	9	4	4	15	15	8	6	2	3	\N	\N	39	\N	 3   	1
1208048	2024-09-01 12:30:00	34	47	2	1	34	66	9	20	3	6	16	13	7	12	4	4	\N	\N	39	\N	 3   	1
1208047	2024-09-01 15:00:00	33	40	0	3	53	47	8	11	3	3	7	7	5	2	4	1	\N	\N	39	\N	 3   	1
1208056	2024-09-14 14:00:00	40	65	0	1	69	31	14	5	5	3	15	6	7	2	4	4	\N	\N	39	\N	 4   	1
1208053	2024-09-14 14:00:00	51	57	0	0	69	31	21	6	6	1	14	16	9	2	4	3	\N	\N	39	\N	 4   	1
1208051	2024-09-14 19:00:00	35	49	0	1	33	67	19	10	7	3	16	9	6	3	6	8	\N	\N	39	\N	 4   	1
1208060	2024-09-15 15:30:00	39	34	1	2	49	51	12	14	5	6	17	6	4	7	3	3	\N	\N	39	\N	 4   	1
1208066	2024-09-21 14:00:00	40	35	3	0	59	41	19	19	13	6	10	12	3	9	1	4	\N	\N	39	\N	 5   	1
1208069	2024-09-21 14:00:00	47	55	3	1	48	52	23	6	10	6	11	9	9	4	3	1	\N	\N	39	\N	 5   	1
1208063	2024-09-21 16:30:00	52	33	0	0	33	67	9	15	4	6	7	12	4	11	3	2	\N	\N	39	\N	 5   	1
1208067	2024-09-22 15:30:00	50	42	2	2	77	23	33	5	11	3	7	10	8	2	3	6	0	1	39	\N	 5   	1
1208075	2024-09-28 14:00:00	45	52	2	1	40	60	8	17	2	5	13	11	5	8	2	0	\N	\N	39	\N	 6   	1
1208079	2024-09-28 14:00:00	65	36	0	1	41	59	11	14	1	2	11	15	6	5	2	4	\N	\N	39	\N	 6   	1
1208076	2024-09-29 13:00:00	57	66	2	2	44	56	15	7	5	3	10	14	10	0	4	1	\N	\N	39	\N	 6   	1
1208071	2024-09-30 19:00:00	35	41	3	1	40	60	14	9	6	3	19	12	6	4	2	5	\N	\N	39	\N	 6   	1
1208088	2024-10-05 14:00:00	46	35	1	0	44	56	6	19	2	2	12	14	0	9	4	1	\N	\N	39	\N	 7   	1
1208083	2024-10-05 14:00:00	55	39	5	3	44	56	19	17	12	6	9	10	10	3	2	3	\N	\N	39	\N	 7   	1
1208085	2024-10-06 13:00:00	49	65	1	1	66	34	22	16	8	9	12	11	11	3	6	4	0	1	39	\N	 7   	1
1208099	2024-10-19 11:30:00	47	48	4	1	57	43	22	11	7	4	10	15	13	5	1	3	0	1	39	\N	 8   	1
1208096	2024-10-19 14:00:00	34	51	0	1	60	40	21	10	6	5	11	9	9	4	2	2	\N	\N	39	\N	 8   	1
1208098	2024-10-19 14:00:00	41	46	2	3	42	58	14	18	7	4	10	10	10	6	5	3	1	0	39	\N	 8   	1
1208100	2024-10-20 13:00:00	39	50	1	2	22	78	3	22	2	7	8	5	1	18	4	1	\N	\N	39	\N	 8   	1
1208097	2024-10-21 19:00:00	65	52	1	0	50	50	20	20	6	7	9	12	6	6	2	3	\N	\N	39	\N	 8   	1
1208106	2024-10-26 14:00:00	51	39	2	2	51	49	19	14	6	7	12	10	9	6	3	3	\N	\N	39	\N	 9   	1
1208104	2024-10-26 14:00:00	66	35	1	1	57	43	18	10	8	3	12	14	9	7	7	6	\N	\N	39	\N	 9   	1
1208107	2024-10-27 13:00:00	49	34	2	1	50	50	17	11	7	3	13	16	7	4	6	3	\N	\N	39	\N	 9   	1
1208103	2024-10-27 15:30:00	42	40	2	2	45	55	9	9	3	4	14	14	1	3	2	2	\N	\N	39	\N	 9   	1
1208116	2024-11-02 15:00:00	40	51	2	1	49	51	16	13	8	5	10	18	9	7	1	1	\N	\N	39	\N	10   	1
1208115	2024-11-02 15:00:00	57	46	1	1	42	58	14	20	2	6	11	10	4	6	6	2	1	0	39	\N	10   	1
1208121	2024-11-03 14:00:00	47	66	4	1	51	49	16	12	6	1	14	14	6	4	2	0	\N	\N	39	\N	10   	1
1208114	2024-11-04 20:00:00	36	55	2	1	68	32	26	5	12	2	3	10	11	3	2	1	\N	\N	39	\N	10   	1
1208126	2024-11-09 15:00:00	52	36	0	2	36	64	13	17	5	7	10	11	1	8	1	1	1	0	39	\N	11   	1
1208227	2025-01-15 19:30:00	46	52	0	2	57	43	21	9	4	4	7	6	4	3	\N	\N	\N	\N	39	\N	21   	1
1208226	2025-01-16 19:30:00	57	51	0	2	46	54	5	11	3	5	13	14	1	9	2	2	\N	\N	39	\N	21   	1
1208238	2025-01-18 15:00:00	46	36	0	2	39	61	8	17	4	2	8	8	5	2	3	1	\N	\N	39	\N	22   	1
1208242	2025-01-18 15:00:00	48	52	0	2	54	46	7	12	0	7	13	10	2	4	3	0	1	0	39	\N	22   	1
1208233	2025-01-18 17:30:00	42	66	2	2	66	34	18	8	6	4	10	18	10	1	2	3	\N	\N	39	\N	22   	1
1208241	2025-01-19 14:00:00	65	41	3	2	45	55	14	10	5	4	4	18	2	8	0	4	\N	\N	39	\N	22   	1
1208235	2025-01-20 20:00:00	49	39	3	1	63	37	19	9	7	4	8	14	3	6	4	2	\N	\N	39	\N	22   	1
1208248	2025-01-25 15:00:00	40	57	4	1	70	30	16	3	6	3	10	11	3	4	0	2	\N	\N	39	\N	23   	1
1208245	2025-01-25 15:00:00	51	45	0	1	69	31	16	3	1	1	8	11	9	1	4	4	\N	\N	39	\N	23   	1
1208246	2025-01-26 14:00:00	52	55	1	2	47	53	16	13	5	6	8	11	4	7	2	2	\N	\N	39	\N	23   	1
1208247	2025-01-26 19:00:00	36	33	0	1	51	49	9	4	3	1	7	9	3	0	0	1	\N	\N	39	\N	23   	1
1208253	2025-02-01 15:00:00	35	40	0	2	49	51	14	19	3	7	15	9	3	3	2	3	\N	\N	39	\N	24   	1
1208262	2025-02-01 17:30:00	39	66	2	0	31	69	8	10	5	3	20	13	5	8	2	3	\N	\N	39	\N	24   	1
1208255	2025-02-02 14:00:00	55	47	0	2	54	46	20	13	4	2	4	11	10	3	0	1	\N	\N	39	\N	24   	1
1208166	2025-02-12 19:30:00	45	40	2	2	37	63	10	6	3	4	9	20	2	3	4	4	1	1	39	\N	15   	1
1208267	2025-02-15 12:30:00	46	42	0	2	40	60	6	11	2	5	9	10	3	7	2	1	\N	\N	39	\N	25   	1
1208272	2025-02-15 15:00:00	48	55	0	1	59	41	13	14	3	5	10	13	9	2	1	1	\N	\N	39	\N	25   	1
1208263	2025-02-15 15:00:00	66	57	1	1	76	24	25	4	6	3	7	11	16	1	0	5	0	1	39	\N	25   	1
1208271	2025-02-16 16:30:00	47	33	1	0	56	44	22	16	7	6	13	9	10	5	1	2	\N	\N	39	\N	25   	1
1208276	2025-02-22 12:30:00	45	33	2	2	38	62	9	9	8	3	12	9	7	8	4	1	\N	\N	39	\N	26   	1
1208277	2025-02-22 15:00:00	36	52	0	2	62	38	10	10	0	5	10	7	7	7	1	3	\N	\N	39	\N	26   	1
1208274	2025-02-22 15:00:00	42	48	0	1	68	32	20	5	2	2	16	15	2	0	1	3	1	0	39	\N	26   	1
1208281	2025-02-23 14:00:00	34	65	4	3	57	43	13	17	5	5	11	13	7	6	1	4	\N	\N	39	\N	26   	1
1208284	2025-02-25 19:30:00	51	35	2	1	43	57	11	19	4	5	12	14	1	9	2	1	\N	\N	39	\N	27   	1
1208127	2024-11-09 20:00:00	40	66	2	0	62	38	14	12	5	2	11	15	2	9	0	3	\N	\N	39	\N	11   	1
1208130	2024-11-10 14:00:00	47	57	1	2	66	34	17	8	5	3	10	19	12	2	1	5	\N	\N	39	\N	11   	1
1208139	2024-11-23 12:30:00	46	49	1	2	37	63	4	16	1	7	15	12	2	9	4	3	\N	\N	39	\N	12   	1
1208137	2024-11-23 15:00:00	36	39	1	4	59	41	10	10	3	5	14	14	7	2	3	0	\N	\N	39	\N	12   	1
1208134	2024-11-23 15:00:00	42	65	3	0	66	34	19	7	7	0	10	11	8	1	3	2	\N	\N	39	\N	12   	1
1208136	2024-11-23 15:00:00	45	55	0	0	59	41	27	9	5	2	8	10	10	4	\N	\N	0	1	39	\N	12   	1
1208140	2024-11-23 17:30:00	50	47	0	4	58	42	23	9	5	7	19	9	9	3	4	2	\N	\N	39	\N	12   	1
1208141	2024-11-25 20:00:00	34	48	0	2	53	47	18	15	2	6	11	8	8	3	1	0	\N	\N	39	\N	12   	1
1208146	2024-11-30 15:00:00	52	34	1	1	49	51	16	1	4	0	12	11	8	9	3	3	\N	\N	39	\N	13   	1
1208149	2024-11-30 15:00:00	65	57	1	0	45	55	12	7	5	3	5	16	8	7	1	3	\N	\N	39	\N	13   	1
1208150	2024-12-01 13:30:00	47	36	1	1	51	49	8	14	3	6	4	14	7	11	0	1	0	1	39	\N	13   	1
1208147	2024-12-01 16:00:00	40	50	2	0	44	56	18	8	7	2	9	8	7	4	1	3	\N	\N	39	\N	13   	1
1208161	2024-12-04 19:30:00	34	40	3	3	41	59	17	16	6	5	9	17	5	6	2	5	\N	\N	39	\N	14   	1
1208156	2024-12-04 19:30:00	45	39	4	0	44	56	13	6	4	2	10	8	3	4	2	0	\N	\N	39	\N	14   	1
1208155	2024-12-04 20:15:00	66	55	3	1	49	51	20	9	10	1	11	15	10	5	2	2	\N	\N	39	\N	14   	1
1208153	2024-12-05 20:15:00	35	47	1	0	35	65	21	12	8	4	15	8	5	9	2	2	\N	\N	39	\N	14   	1
1208163	2024-12-07 15:00:00	66	41	1	0	47	53	18	4	5	0	18	15	14	1	1	3	\N	\N	39	\N	15   	1
1208167	2024-12-08 14:00:00	36	42	1	1	34	66	2	12	2	4	10	9	0	6	4	2	\N	\N	39	\N	15   	1
1208171	2024-12-08 16:30:00	47	49	3	4	39	61	13	17	5	8	17	11	5	10	2	3	\N	\N	39	\N	15   	1
1208179	2024-12-14 15:00:00	34	46	4	0	59	41	27	4	11	1	7	16	5	2	3	3	\N	\N	39	\N	16   	1
1208174	2024-12-14 15:00:00	42	45	0	0	77	23	13	2	5	0	6	9	8	2	0	3	\N	\N	39	\N	16   	1
1208175	2024-12-15 14:00:00	51	52	1	3	65	35	17	13	5	5	11	15	8	5	1	4	\N	\N	39	\N	16   	1
1208176	2024-12-15 19:00:00	49	55	2	1	62	38	26	9	8	4	11	7	8	5	2	2	1	0	39	\N	16   	1
1208183	2024-12-21 12:30:00	66	50	2	1	44	56	11	12	6	6	14	7	5	4	3	3	\N	\N	39	\N	17   	1
1208188	2024-12-21 15:00:00	57	34	0	4	42	58	10	15	2	7	9	7	2	1	2	0	\N	\N	39	\N	17   	1
1208190	2024-12-22 14:00:00	33	35	0	3	60	40	23	10	7	5	11	11	13	1	1	3	\N	\N	39	\N	17   	1
1208189	2024-12-22 14:00:00	46	39	0	3	54	46	9	8	5	4	15	16	6	1	2	0	\N	\N	39	\N	17   	1
1208198	2024-12-26 12:30:00	50	45	1	1	66	34	24	8	5	3	5	10	8	5	1	4	\N	\N	39	\N	18   	1
1208201	2024-12-26 15:00:00	41	48	0	1	54	46	18	16	5	2	15	8	2	2	1	2	\N	\N	39	\N	18   	1
1208200	2024-12-26 15:00:00	65	47	1	0	30	70	10	13	3	4	12	13	2	7	3	4	0	1	39	\N	18   	1
1208195	2024-12-27 19:30:00	51	55	0	0	58	42	24	8	7	3	6	12	5	3	0	2	\N	\N	39	\N	18   	1
1208209	2024-12-29 14:30:00	46	50	0	2	54	46	11	14	4	5	11	6	4	4	2	1	\N	\N	39	\N	19   	1
1208211	2024-12-29 15:00:00	47	39	2	2	48	52	13	11	3	3	9	10	5	5	1	2	\N	\N	39	\N	19   	1
1208212	2024-12-29 17:15:00	48	40	0	5	46	54	7	22	0	13	7	10	2	6	\N	\N	\N	\N	39	\N	19   	1
1208210	2024-12-30 20:00:00	33	34	0	2	53	47	10	12	0	4	13	8	2	3	1	1	\N	\N	39	\N	19   	1
1208221	2025-01-04 12:30:00	47	34	1	2	57	43	13	14	4	4	11	15	9	10	1	4	\N	\N	39	\N	20   	1
1208219	2025-01-04 15:00:00	50	48	4	1	56	44	10	17	7	4	8	13	7	1	2	1	\N	\N	39	\N	20   	1
1208214	2025-01-04 15:00:00	66	46	2	1	61	39	13	4	5	2	10	11	6	2	0	1	\N	\N	39	\N	20   	1
1208218	2025-01-05 16:30:00	40	33	2	2	53	47	19	13	6	4	10	13	5	9	2	4	\N	\N	39	\N	20   	1
1208229	2025-01-14 19:30:00	48	36	3	2	44	56	4	21	3	5	9	18	0	3	3	3	\N	\N	39	\N	21   	1
1208290	2025-02-25 20:15:00	49	41	4	0	60	40	19	7	10	2	6	9	4	2	1	2	\N	\N	39	\N	27   	1
1208283	2025-02-26 19:30:00	55	45	1	1	52	48	12	14	3	4	3	6	2	5	2	1	\N	\N	39	\N	27   	1
1208291	2025-02-26 20:15:00	40	34	2	0	61	39	12	3	3	0	12	11	4	2	0	1	\N	\N	39	\N	27   	1
1208297	2025-03-08 15:00:00	40	41	3	1	71	29	28	6	7	4	10	9	6	4	2	1	\N	\N	39	\N	28   	1
1208296	2025-03-08 15:00:00	52	57	1	0	55	45	19	15	4	8	8	7	5	4	4	3	\N	\N	39	\N	28   	1
1208300	2025-03-09 14:00:00	47	35	2	2	61	39	12	17	4	8	15	16	3	6	3	3	\N	\N	39	\N	28   	1
1208298	2025-03-09 16:30:00	33	42	1	1	32	68	10	17	6	6	8	11	2	9	0	1	\N	\N	39	\N	28   	1
1208306	2025-03-15 15:00:00	45	48	1	1	54	46	13	10	5	5	12	8	6	5	1	2	\N	\N	39	\N	29   	1
1208303	2025-03-15 17:30:00	35	55	1	2	59	41	17	10	5	4	13	7	4	3	3	0	\N	\N	39	\N	29   	1
1208304	2025-03-16 13:30:00	42	49	1	0	41	59	12	8	4	2	10	13	5	4	3	3	\N	\N	39	\N	29   	1
1180549	2024-07-28 00:30:00	120	135	0	3	59	41	19	12	10	5	14	15	8	1	2	4	\N	\N	71	\N	20   	1
1180551	2024-07-28 14:00:00	794	124	0	1	59	41	13	7	2	3	12	13	5	6	1	2	\N	\N	71	\N	20   	1
1180548	2024-07-28 19:00:00	127	144	2	0	53	47	12	12	6	3	9	12	6	3	3	2	\N	\N	71	\N	20   	1
1180546	2024-07-28 22:00:00	1062	131	2	1	68	32	10	11	4	7	17	16	4	4	3	3	1	0	71	\N	20   	1
1180557	2024-08-03 19:00:00	136	1193	1	0	47	53	17	9	3	2	16	17	4	5	3	3	\N	\N	71	\N	21   	1
1180559	2024-08-03 22:00:00	133	794	2	2	64	36	11	7	3	3	8	18	4	3	4	1	\N	\N	71	\N	21   	1
1180563	2024-08-03 23:00:00	144	120	1	4	48	52	9	13	3	9	17	14	3	7	3	3	1	1	71	\N	21   	1
1180561	2024-08-04 00:30:00	126	127	1	0	59	41	15	8	3	0	11	13	8	3	1	3	\N	\N	71	\N	21   	1
1180560	2024-08-04 19:00:00	131	152	1	1	64	36	34	6	10	3	16	15	11	3	2	7	0	3	71	\N	21   	1
1208228	2025-01-14 20:00:00	65	40	1	1	29	71	6	23	3	7	7	10	0	9	2	1	\N	\N	39	\N	21   	1
1180364	2024-04-13 21:30:00	140	152	1	1	47	53	10	15	3	4	11	15	0	4	4	6	\N	\N	71	\N	 1   	1
1180361	2024-04-14 00:00:00	126	154	1	2	72	28	14	6	5	2	10	14	11	4	2	3	\N	\N	71	\N	 1   	1
1180359	2024-04-14 19:00:00	133	130	2	1	47	53	15	9	3	2	19	10	3	5	4	1	\N	\N	71	\N	 1   	1
1180362	2024-04-14 19:00:00	134	1193	4	0	62	38	20	1	9	0	16	9	7	0	0	3	\N	\N	71	\N	 1   	1
1180356	2024-04-14 20:00:00	135	120	3	2	56	44	15	6	5	3	12	11	6	3	4	3	0	1	71	\N	 1   	1
1180367	2024-04-17 00:30:00	118	124	2	1	40	60	12	9	5	3	15	23	4	3	4	5	\N	\N	71	\N	 2   	1
1180365	2024-04-17 22:00:00	130	134	2	0	48	52	14	4	7	0	7	13	9	2	1	3	\N	\N	71	\N	 2   	1
1180370	2024-04-17 23:00:00	121	119	0	1	64	36	18	5	3	2	17	21	6	2	2	4	\N	\N	71	\N	 2   	1
1180372	2024-04-17 23:00:00	154	135	1	1	39	61	14	14	3	6	13	10	7	5	2	3	0	1	71	\N	 2   	1
1180366	2024-04-17 23:00:00	1062	140	1	1	68	32	22	5	6	1	12	10	9	2	2	4	\N	\N	71	\N	 2   	1
1180369	2024-04-19 00:30:00	120	144	1	0	53	47	13	12	4	3	13	11	8	8	3	4	\N	\N	71	\N	 2   	1
1180375	2024-04-20 21:30:00	130	1193	1	0	57	43	7	14	4	3	10	5	3	4	4	2	\N	\N	71	\N	 3   	1
1180381	2024-04-20 21:30:00	794	131	1	0	35	65	10	15	3	4	21	10	3	4	4	2	\N	\N	71	\N	 3   	1
1180380	2024-04-21 19:00:00	121	127	0	0	49	51	12	8	1	3	23	14	6	5	5	4	\N	\N	71	\N	 3   	1
1180377	2024-04-21 19:00:00	136	118	2	2	42	58	13	20	8	7	12	13	2	7	3	3	\N	\N	71	\N	 3   	1
1180379	2024-04-21 21:30:00	120	152	5	1	56	44	13	12	6	1	22	10	5	4	3	4	0	1	71	\N	 3   	1
1180389	2024-04-27 19:00:00	133	140	0	4	58	42	21	17	5	10	13	7	5	4	1	0	\N	\N	71	\N	 4   	1
1180387	2024-04-28 00:00:00	118	130	1	0	60	40	14	3	4	2	10	15	4	0	2	4	0	2	71	\N	 4   	1
1180390	2024-04-28 19:00:00	131	124	3	0	31	69	17	13	7	2	15	15	6	8	4	2	\N	\N	71	\N	 4   	1
1180386	2024-04-28 19:00:00	135	136	3	1	54	46	15	8	6	3	12	6	10	4	2	0	\N	\N	71	\N	 4   	1
1180392	2024-04-28 21:30:00	154	794	1	1	44	56	22	10	5	4	9	6	12	6	1	1	\N	\N	71	\N	 4   	1
1180385	2024-04-28 23:00:00	119	144	1	1	72	28	22	4	5	2	13	12	13	0	0	4	\N	\N	71	\N	 4   	1
1180398	2024-05-04 19:00:00	124	1062	2	2	43	57	11	19	5	7	11	18	4	10	5	2	\N	\N	71	\N	 5   	1
1180400	2024-05-05 00:00:00	131	154	0	0	65	35	18	12	9	2	14	17	9	5	1	7	\N	\N	71	\N	 5   	1
1180397	2024-05-05 19:00:00	136	126	1	3	33	67	6	20	2	8	10	13	3	8	3	4	1	0	71	\N	 5   	1
1180399	2024-05-05 21:30:00	120	118	1	2	55	45	16	10	5	4	10	5	5	1	2	2	\N	\N	71	\N	 5   	1
1180408	2024-05-11 19:00:00	127	131	2	0	58	42	18	13	9	3	12	16	13	6	1	1	\N	\N	71	\N	 6   	1
1180413	2024-05-12 19:00:00	144	135	0	1	46	54	17	12	5	5	13	10	5	5	1	2	\N	\N	71	\N	 6   	1
1180412	2024-05-12 19:00:00	154	120	1	1	43	57	10	11	4	5	12	19	6	5	4	6	\N	\N	71	\N	 6   	1
1180409	2024-05-12 21:30:00	133	136	2	1	57	43	17	13	8	5	12	12	4	4	5	2	0	1	71	\N	 6   	1
1180415	2024-06-01 19:00:00	130	794	0	2	44	56	9	14	1	4	16	19	6	0	4	2	\N	\N	71	\N	 7   	1
1180417	2024-06-01 19:00:00	136	144	0	2	33	67	12	12	3	5	7	9	3	4	3	2	2	0	71	\N	 7   	1
1180423	2024-06-01 21:30:00	1193	119	0	1	36	64	8	9	3	3	12	21	0	2	4	4	\N	\N	71	\N	 7   	1
1180419	2024-06-02 19:00:00	133	127	1	6	27	73	2	30	2	18	18	6	1	8	2	0	1	0	71	\N	 7   	1
1180424	2024-06-02 19:00:00	140	121	1	2	39	61	12	23	4	5	17	9	4	6	7	3	\N	\N	71	\N	 7   	1
1180421	2024-06-02 21:30:00	126	135	2	0	56	44	11	10	4	3	18	11	4	2	2	2	0	1	71	\N	 7   	1
1180404	2024-06-05 22:00:00	152	144	1	0	42	58	8	22	2	5	13	12	4	7	3	4	1	0	71	\N	 5   	1
1180373	2024-06-05 23:00:00	1193	136	0	0	54	46	11	13	0	4	19	14	4	3	3	4	\N	\N	71	\N	 2   	1
1180433	2024-06-11 22:00:00	144	131	2	2	73	27	22	7	7	3	12	13	3	4	3	5	0	1	71	\N	 8   	1
1180429	2024-06-11 23:00:00	120	124	1	0	44	56	19	6	6	0	22	13	14	2	3	3	\N	\N	71	\N	 8   	1
1180426	2024-06-13 22:00:00	135	1193	2	1	51	49	12	16	6	5	9	12	6	4	3	2	\N	\N	71	\N	 8   	1
1180425	2024-06-13 23:00:00	119	126	0	0	54	46	7	9	0	4	15	18	5	3	5	4	\N	\N	71	\N	 8   	1
1180432	2024-06-13 23:00:00	134	140	3	1	57	43	23	12	7	4	9	12	5	3	0	1	\N	\N	71	\N	 8   	1
1208346	2025-04-19 14:00:00	45	50	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	33   	0
1180427	2024-06-14 00:30:00	118	154	1	0	54	46	12	21	3	6	14	9	5	9	6	1	\N	\N	71	\N	 8   	1
1180441	2024-06-15 21:30:00	794	152	2	1	36	64	6	14	2	6	12	12	1	1	4	4	1	0	71	\N	 9   	1
1180440	2024-06-16 19:00:00	131	126	2	2	40	60	16	12	8	7	15	10	9	5	4	5	1	0	71	\N	 9   	1
1180437	2024-06-16 19:00:00	136	119	2	1	39	61	11	15	4	5	6	16	4	2	1	5	\N	\N	71	\N	 9   	1
1180435	2024-06-16 21:30:00	130	120	1	2	45	55	15	14	4	5	12	11	7	4	3	3	\N	\N	71	\N	 9   	1
1180444	2024-06-16 21:30:00	140	118	2	2	32	68	17	22	5	6	14	13	6	7	4	1	1	0	71	\N	 9   	1
1180436	2024-06-17 23:30:00	1062	121	0	4	52	48	11	22	3	9	16	16	3	6	5	3	2	0	71	\N	 9   	1
1180449	2024-06-19 22:00:00	120	134	1	1	62	38	8	16	1	6	13	14	5	9	0	5	\N	\N	71	\N	10   	1
1180451	2024-06-19 23:00:00	126	1193	0	1	66	34	15	11	4	3	5	16	4	6	2	3	\N	\N	71	\N	10   	1
1180452	2024-06-19 23:00:00	154	130	1	0	52	48	13	8	4	2	15	7	8	3	3	4	0	1	71	\N	10   	1
1180445	2024-06-20 00:30:00	119	131	1	0	47	53	11	13	5	3	17	13	3	7	1	2	\N	\N	71	\N	10   	1
1180447	2024-06-20 21:30:00	136	1062	4	2	39	61	12	19	6	7	15	13	2	4	2	2	\N	\N	71	\N	10   	1
1180450	2024-06-21 00:30:00	121	794	2	1	41	59	24	13	7	3	10	9	10	3	0	2	\N	\N	71	\N	10   	1
1180464	2024-06-22 19:00:00	140	120	2	1	38	62	16	11	4	2	16	14	4	7	4	3	\N	\N	71	\N	11   	1
1208022	2024-08-17 11:30:00	57	40	0	2	38	62	7	18	2	5	9	18	2	10	3	1	\N	\N	39	\N	 1   	1
1208025	2024-08-17 14:00:00	34	41	1	0	22	78	3	19	1	4	15	16	3	12	2	4	1	0	39	\N	 1   	1
1180455	2024-06-22 20:30:00	130	119	0	1	58	42	10	16	2	2	12	11	5	4	3	2	\N	\N	71	\N	11   	1
1208021	2024-08-16 19:00:00	33	36	1	0	55	45	14	10	5	2	12	10	7	8	2	3	\N	\N	39	\N	 1   	1
1208023	2024-08-17 14:00:00	42	39	2	0	53	47	18	9	6	3	17	14	8	2	2	2	\N	\N	39	\N	 1   	1
1208024	2024-08-17 14:00:00	45	51	0	3	38	62	9	10	1	5	8	8	1	5	1	1	1	0	39	\N	 1   	1
1208026	2024-08-17 14:00:00	65	35	1	1	53	47	14	13	8	4	17	8	2	6	1	3	\N	\N	39	\N	 1   	1
1208027	2024-08-17 16:30:00	48	66	1	2	52	48	14	15	3	3	18	11	5	3	1	2	\N	\N	39	\N	 1   	1
1208028	2024-08-18 13:00:00	55	52	2	1	46	54	9	14	5	6	6	15	4	7	1	5	\N	\N	39	\N	 1   	1
1208029	2024-08-18 15:30:00	49	50	0	2	48	52	10	11	3	5	12	9	4	3	1	1	\N	\N	39	\N	 1   	1
1208030	2024-08-19 19:00:00	46	47	1	1	30	70	7	15	3	7	11	12	2	13	1	1	\N	\N	39	\N	 1   	1
1208033	2024-08-24 11:30:00	51	33	2	1	48	52	14	11	5	4	9	13	4	4	1	2	\N	\N	39	\N	 2   	1
1208035	2024-08-24 14:00:00	36	46	2	1	54	46	18	10	6	4	14	13	7	5	2	2	\N	\N	39	\N	 2   	1
1208038	2024-08-24 14:00:00	41	65	0	1	65	35	5	23	1	8	14	14	4	10	3	3	\N	\N	39	\N	 2   	1
1208039	2024-08-24 14:00:00	47	45	4	0	71	29	13	10	7	1	11	15	12	5	\N	\N	\N	\N	39	\N	 2   	1
1208037	2024-08-24 14:00:00	50	57	4	1	75	25	14	1	5	1	4	15	10	1	2	3	\N	\N	39	\N	 2   	1
1208034	2024-08-24 14:00:00	52	48	0	2	58	42	14	18	2	3	9	17	3	3	1	1	\N	\N	39	\N	 2   	1
1180463	2024-06-22 21:30:00	1193	144	0	0	53	47	10	18	3	9	9	12	5	4	3	1	\N	\N	71	\N	11   	1
1180459	2024-06-23 00:30:00	133	126	4	1	41	59	14	10	7	2	13	14	2	8	3	1	\N	\N	71	\N	11   	1
1180457	2024-06-23 19:00:00	118	135	4	1	64	36	14	7	6	1	6	13	3	1	0	3	0	1	71	\N	11   	1
1180458	2024-06-23 19:00:00	124	127	0	1	54	46	2	14	0	4	16	13	2	6	4	3	1	0	71	\N	11   	1
1180462	2024-06-23 19:00:00	134	131	1	1	54	46	20	15	7	6	19	12	11	2	2	1	\N	\N	71	\N	11   	1
1180460	2024-06-23 21:30:00	121	152	3	1	57	43	28	16	10	8	14	7	10	4	2	3	\N	\N	71	\N	11   	1
1180461	2024-06-23 21:30:00	794	136	2	1	64	36	16	10	6	5	10	11	6	7	3	2	\N	\N	71	\N	11   	1
1180456	2024-06-23 21:30:00	1062	154	1	1	67	33	21	13	8	3	15	17	3	4	3	2	\N	\N	71	\N	11   	1
1180469	2024-06-26 22:00:00	120	794	2	1	49	51	12	13	4	6	13	12	7	4	2	3	\N	\N	71	\N	12   	1
1180466	2024-06-26 22:00:00	135	134	2	0	49	51	22	14	7	3	8	6	7	12	2	2	\N	\N	71	\N	12   	1
1180470	2024-06-26 23:00:00	131	1193	1	1	66	34	24	13	7	4	10	13	13	1	3	4	\N	\N	71	\N	12   	1
1180473	2024-06-26 23:00:00	144	130	1	1	49	51	16	11	5	4	13	11	5	8	7	4	\N	\N	71	\N	12   	1
1180474	2024-06-26 23:00:00	152	127	2	1	53	47	15	9	8	5	9	10	7	8	2	1	\N	\N	71	\N	12   	1
1180467	2024-06-27 00:30:00	118	133	2	1	63	37	17	9	8	3	14	15	7	0	0	5	0	1	71	\N	12   	1
1180465	2024-06-27 00:30:00	119	1062	1	2	46	54	13	15	6	5	17	10	5	9	4	4	\N	\N	71	\N	12   	1
1180472	2024-06-27 00:30:00	154	121	3	0	32	68	12	17	6	7	17	11	3	8	2	2	\N	\N	71	\N	12   	1
1180468	2024-06-27 22:00:00	124	136	0	1	64	36	12	9	5	6	14	12	6	2	3	1	\N	\N	71	\N	12   	1
1180471	2024-06-27 23:00:00	126	140	2	1	62	38	13	10	6	2	10	22	2	2	2	4	\N	\N	71	\N	12   	1
1180479	2024-06-29 21:30:00	133	120	1	1	54	46	10	13	2	6	13	23	0	5	4	5	\N	\N	71	\N	13   	1
1180483	2024-06-29 21:30:00	1193	794	1	1	34	66	5	14	2	5	13	16	3	11	4	2	1	0	71	\N	13   	1
1180476	2024-06-30 14:00:00	1062	144	1	1	68	32	15	12	6	6	10	11	5	8	0	1	\N	\N	71	\N	13   	1
1180481	2024-06-30 19:00:00	126	118	3	1	41	59	10	15	4	6	15	9	4	4	4	1	\N	\N	71	\N	13   	1
1180475	2024-06-30 19:00:00	130	124	1	0	47	53	16	8	9	3	13	14	6	1	2	3	0	1	71	\N	13   	1
1180482	2024-06-30 19:00:00	154	152	2	1	38	62	19	12	7	3	22	16	7	5	2	0	\N	\N	71	\N	13   	1
1180478	2024-06-30 21:30:00	127	135	2	1	46	54	7	14	3	5	5	17	2	5	1	3	\N	\N	71	\N	13   	1
1180477	2024-06-30 21:30:00	136	134	0	1	59	41	16	7	3	2	12	16	7	6	3	2	\N	\N	71	\N	13   	1
1180484	2024-06-30 21:30:00	140	119	1	1	46	54	17	12	7	4	10	14	5	5	2	3	\N	\N	71	\N	13   	1
1180480	2024-07-01 23:00:00	121	131	2	0	49	51	20	13	10	3	18	10	7	3	3	4	1	0	71	\N	13   	1
1180489	2024-07-03 23:00:00	133	154	2	0	59	41	19	10	9	4	21	12	7	3	4	3	0	1	71	\N	14   	1
1180492	2024-07-04 00:30:00	134	126	1	2	45	55	12	13	4	8	19	8	6	2	1	3	1	0	71	\N	14   	1
1180491	2024-07-04 00:30:00	794	144	3	1	52	48	13	13	5	6	15	9	3	8	2	3	\N	\N	71	\N	14   	1
1180487	2024-07-04 22:00:00	118	152	2	0	57	43	22	10	9	2	15	9	6	7	0	4	\N	\N	71	\N	14   	1
1180488	2024-07-04 23:00:00	124	119	1	1	55	45	8	12	3	4	17	17	3	4	6	5	\N	\N	71	\N	14   	1
1180490	2024-07-04 23:00:00	131	136	3	2	44	56	14	18	5	6	15	10	9	9	4	3	\N	\N	71	\N	14   	1
1180498	2024-07-06 23:00:00	127	1193	1	1	66	34	20	7	10	3	14	12	7	0	1	3	\N	\N	71	\N	15   	1
1180504	2024-07-07 19:00:00	152	130	3	0	49	51	14	13	6	5	14	10	3	8	1	3	\N	\N	71	\N	15   	1
1180502	2024-07-07 19:00:00	154	124	1	0	42	58	19	11	6	3	13	14	12	3	1	2	\N	\N	71	\N	15   	1
1180500	2024-07-07 21:30:00	121	118	2	0	44	56	12	13	4	3	15	10	4	3	1	1	\N	\N	71	\N	15   	1
1180503	2024-07-07 21:30:00	144	134	1	2	43	57	12	17	3	6	11	11	4	11	1	3	1	0	71	\N	15   	1
1180505	2024-07-10 21:30:00	130	135	0	2	45	55	8	14	3	6	9	10	1	5	1	1	1	0	71	\N	16   	1
1208040	2024-08-25 13:00:00	39	49	2	6	40	60	12	14	4	8	13	13	5	5	2	3	\N	\N	39	\N	 2   	1
1208041	2024-08-31 11:30:00	42	51	1	1	36	64	11	22	7	4	12	7	3	7	5	2	1	0	39	\N	 3   	1
1208044	2024-08-31 14:00:00	45	35	2	3	47	53	18	17	8	7	6	11	8	4	2	1	\N	\N	39	\N	 3   	1
1208042	2024-08-31 14:00:00	55	41	3	1	37	63	20	18	7	6	10	7	2	8	2	1	\N	\N	39	\N	 3   	1
1208049	2024-08-31 14:00:00	65	39	1	1	52	48	16	11	5	3	15	18	7	3	3	4	\N	\N	39	\N	 3   	1
1208050	2024-08-31 16:30:00	48	50	1	3	32	68	10	23	2	8	10	3	3	11	3	2	\N	\N	39	\N	 3   	1
1208043	2024-09-01 12:30:00	49	52	1	1	63	37	13	9	7	3	9	13	4	4	4	2	\N	\N	39	\N	 3   	1
1208058	2024-09-14 11:30:00	41	33	0	3	44	56	6	20	4	10	11	14	0	7	1	4	1	0	39	\N	 4   	1
1208055	2024-09-14 14:00:00	36	48	1	1	55	45	21	11	5	3	15	18	3	2	2	3	\N	\N	39	\N	 4   	1
1208057	2024-09-14 14:00:00	50	55	2	1	54	46	18	8	7	5	9	3	12	3	3	1	\N	\N	39	\N	 4   	1
1208352	2025-04-19 14:00:00	48	41	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	33   	0
1208345	2025-04-19 14:00:00	52	35	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	33   	0
1208054	2024-09-14 14:00:00	52	46	2	2	67	33	20	9	4	4	11	15	5	2	0	3	\N	\N	39	\N	 4   	1
1208052	2024-09-14 16:30:00	66	45	3	2	73	27	17	6	8	2	10	12	6	2	1	4	\N	\N	39	\N	 4   	1
1208059	2024-09-15 13:00:00	47	42	0	1	64	36	15	7	5	4	13	10	7	6	5	3	\N	\N	39	\N	 4   	1
1208070	2024-09-21 11:30:00	48	49	0	3	53	47	15	12	7	5	17	9	6	5	5	2	\N	\N	39	\N	 5   	1
1208064	2024-09-21 14:00:00	36	34	3	1	39	61	22	16	11	5	16	8	6	0	6	0	\N	\N	39	\N	 5   	1
1208068	2024-09-21 14:00:00	41	57	1	1	54	46	11	13	3	6	16	16	2	10	4	4	\N	\N	39	\N	 5   	1
1208065	2024-09-21 14:00:00	46	45	1	1	59	41	12	17	2	5	11	12	6	1	1	2	\N	\N	39	\N	 5   	1
1208061	2024-09-21 14:00:00	66	39	3	1	53	47	9	10	4	4	11	16	6	5	3	6	\N	\N	39	\N	 5   	1
1208062	2024-09-22 13:00:00	51	65	2	2	70	30	14	4	3	3	12	11	9	1	3	6	0	1	39	\N	 5   	1
1208078	2024-09-28 11:30:00	34	50	1	1	38	62	11	16	4	6	14	10	5	6	4	4	\N	\N	39	\N	 6   	1
1208072	2024-09-28 14:00:00	42	46	4	2	75	25	36	5	16	3	11	6	17	0	2	4	\N	\N	39	\N	 6   	1
1208074	2024-09-28 14:00:00	49	51	4	2	41	59	15	15	7	5	11	8	8	2	3	2	\N	\N	39	\N	 6   	1
1208073	2024-09-28 14:00:00	55	48	1	1	57	43	8	19	3	3	2	11	7	6	2	3	\N	\N	39	\N	 6   	1
1208080	2024-09-28 16:30:00	39	40	1	2	45	55	8	10	3	6	16	8	2	10	2	3	\N	\N	39	\N	 6   	1
1208077	2024-09-29 15:30:00	33	47	0	3	39	61	11	24	2	10	16	14	5	3	5	3	1	0	39	\N	 6   	1
1208086	2024-10-05 11:30:00	52	40	0	1	32	68	9	16	5	4	7	15	3	8	4	2	\N	\N	39	\N	 7   	1
1208081	2024-10-05 14:00:00	42	41	3	1	59	41	29	8	6	2	10	9	13	1	0	3	\N	\N	39	\N	 7   	1
1208090	2024-10-05 14:00:00	48	57	4	1	53	47	23	9	13	2	12	6	5	5	0	1	\N	\N	39	\N	 7   	1
1208089	2024-10-05 14:00:00	50	36	3	2	58	42	20	11	7	4	4	10	8	3	2	1	\N	\N	39	\N	 7   	1
1208087	2024-10-05 16:30:00	45	34	0	0	32	68	8	14	2	3	12	8	0	10	1	2	\N	\N	39	\N	 7   	1
1208082	2024-10-06 13:00:00	66	33	0	0	54	46	11	10	1	4	12	11	6	3	1	5	\N	\N	39	\N	 7   	1
1208084	2024-10-06 15:30:00	51	47	3	2	41	59	11	13	4	3	14	10	4	7	2	2	\N	\N	39	\N	 7   	1
1208095	2024-10-19 14:00:00	33	55	2	1	50	50	23	8	11	2	4	5	9	2	2	2	\N	\N	39	\N	 8   	1
1208092	2024-10-19 14:00:00	36	66	1	3	52	48	10	14	4	5	8	11	6	11	3	5	1	1	39	\N	 8   	1
1208093	2024-10-19 14:00:00	57	45	0	2	55	45	13	11	2	8	12	10	5	7	1	1	\N	\N	39	\N	 8   	1
1208091	2024-10-19 16:30:00	35	42	2	0	49	51	13	6	4	1	12	11	7	4	1	1	0	1	39	\N	 8   	1
1208094	2024-10-20 15:30:00	40	49	2	1	43	57	9	12	5	2	12	13	1	5	4	3	\N	\N	39	\N	 8   	1
1208110	2024-10-25 19:00:00	46	65	1	3	64	36	11	20	1	5	16	9	6	7	5	3	\N	\N	39	\N	 9   	1
1208111	2024-10-26 14:00:00	50	41	1	0	57	43	22	5	8	2	9	9	12	1	1	3	\N	\N	39	\N	 9   	1
1208105	2024-10-26 14:00:00	55	57	4	3	65	35	20	11	9	5	7	10	4	5	0	3	0	1	39	\N	 9   	1
1208109	2024-10-26 16:30:00	45	36	1	1	40	60	10	14	5	3	8	8	4	2	1	0	\N	\N	39	\N	 9   	1
1208112	2024-10-27 13:00:00	48	33	2	1	43	57	12	18	3	5	6	7	6	5	5	1	\N	\N	39	\N	 9   	1
1208108	2024-10-27 13:00:00	52	47	1	0	34	66	14	11	6	3	16	12	8	8	4	4	\N	\N	39	\N	 9   	1
1208118	2024-11-02 12:30:00	34	42	1	0	36	64	9	10	4	1	16	18	4	6	4	4	\N	\N	39	\N	10   	1
1208113	2024-11-02 15:00:00	35	50	2	1	36	64	12	18	6	4	11	6	3	10	2	1	\N	\N	39	\N	10   	1
1208120	2024-11-02 15:00:00	41	45	1	0	65	35	9	16	2	5	14	18	3	6	4	2	\N	\N	39	\N	10   	1
1208119	2024-11-02 15:00:00	65	48	3	0	53	47	19	4	6	2	7	9	10	6	1	4	0	1	39	\N	10   	1
1208122	2024-11-02 17:30:00	39	52	2	2	57	43	11	19	6	7	7	9	3	6	1	2	\N	\N	39	\N	10   	1
1208117	2024-11-03 16:30:00	33	49	1	1	46	54	11	12	4	3	19	14	4	8	6	2	\N	\N	39	\N	10   	1
1208132	2024-11-09 15:00:00	39	41	2	0	29	71	8	9	4	0	14	12	1	9	1	4	\N	\N	39	\N	11   	1
1208131	2024-11-09 15:00:00	48	45	0	0	49	51	11	18	6	4	10	9	7	6	1	2	\N	\N	39	\N	11   	1
1208123	2024-11-09 15:00:00	55	35	3	2	52	48	12	15	6	3	8	16	6	4	2	4	\N	\N	39	\N	11   	1
1208124	2024-11-09 17:30:00	51	50	2	1	40	60	10	15	4	6	12	10	0	4	3	3	\N	\N	39	\N	11   	1
1208128	2024-11-10 14:00:00	33	46	3	0	51	49	13	6	3	5	9	5	1	5	0	1	\N	\N	39	\N	11   	1
1208129	2024-11-10 14:00:00	65	34	1	3	44	56	9	17	3	6	13	6	4	5	1	1	\N	\N	39	\N	11   	1
1208125	2024-11-10 16:30:00	49	42	1	1	49	51	17	13	3	3	12	12	4	3	4	2	\N	\N	39	\N	11   	1
1208133	2024-11-23 15:00:00	35	51	1	2	55	45	19	6	5	4	13	10	7	0	2	4	0	1	39	\N	12   	1
1208135	2024-11-23 15:00:00	66	52	2	2	70	30	17	13	5	6	10	11	10	1	3	2	\N	\N	39	\N	12   	1
1208142	2024-11-24 14:00:00	41	40	2	3	38	62	7	27	5	11	11	9	3	10	3	4	\N	\N	39	\N	12   	1
1208138	2024-11-24 16:30:00	57	33	1	1	40	60	11	11	6	4	11	10	4	3	\N	\N	\N	\N	39	\N	12   	1
1208144	2024-11-29 20:00:00	51	41	1	1	52	48	22	10	5	2	20	16	7	6	2	4	\N	\N	39	\N	13   	1
1208152	2024-11-30 15:00:00	39	35	2	4	60	40	10	12	3	8	13	11	3	4	5	1	\N	\N	39	\N	13   	1
1208143	2024-11-30 15:00:00	55	46	4	1	60	40	13	7	6	3	9	10	5	4	1	1	\N	\N	39	\N	13   	1
1208151	2024-11-30 17:30:00	48	42	2	5	40	60	12	16	5	7	10	13	2	10	4	1	\N	\N	39	\N	13   	1
1208148	2024-12-01 13:30:00	33	45	4	0	60	40	11	8	5	2	12	12	2	2	2	3	\N	\N	39	\N	13   	1
1208145	2024-12-01 13:30:00	49	66	3	0	64	36	17	10	8	4	21	6	3	4	2	2	\N	\N	39	\N	13   	1
1208158	2024-12-03 19:30:00	57	52	0	1	54	46	9	13	2	3	14	13	4	7	2	4	\N	\N	39	\N	14   	1
1208159	2024-12-03 20:15:00	46	48	3	1	39	61	8	31	6	10	9	7	3	9	2	2	\N	\N	39	\N	14   	1
1208162	2024-12-04 19:30:00	41	49	1	5	45	55	6	26	4	13	7	14	5	7	1	0	1	0	39	\N	14   	1
1208160	2024-12-04 19:30:00	50	65	3	0	66	34	17	12	7	3	7	15	8	2	2	4	\N	\N	39	\N	14   	1
1208154	2024-12-04 20:15:00	42	33	2	0	50	50	14	5	6	2	12	8	13	0	1	3	\N	\N	39	\N	14   	1
1208157	2024-12-05 19:30:00	36	51	3	1	43	57	6	13	2	3	7	8	5	6	2	2	\N	\N	39	\N	14   	1
1208165	2024-12-07 15:00:00	52	50	2	2	32	68	12	12	3	4	4	10	6	8	1	2	0	1	39	\N	15   	1
1208164	2024-12-07 15:00:00	55	34	4	2	44	56	11	16	8	3	10	7	3	4	3	0	\N	\N	39	\N	15   	1
1208170	2024-12-07 17:30:00	33	65	2	3	71	29	17	11	7	3	10	13	5	3	0	2	\N	\N	39	\N	15   	1
1208169	2024-12-08 14:00:00	46	51	2	2	55	45	10	16	3	7	9	10	4	5	1	2	\N	\N	39	\N	15   	1
1208168	2024-12-08 14:00:00	57	35	1	2	43	57	18	22	5	6	9	13	6	13	2	1	\N	\N	39	\N	15   	1
1208172	2024-12-09 20:00:00	48	39	2	1	54	46	19	19	4	5	12	17	11	0	5	4	\N	\N	39	\N	15   	1
1208182	2024-12-14 15:00:00	39	57	1	2	54	46	16	10	6	5	13	9	7	3	2	2	1	0	39	\N	16   	1
1208177	2024-12-14 15:00:00	40	36	2	2	61	39	16	12	4	3	10	7	5	4	3	4	1	0	39	\N	16   	1
1208180	2024-12-14 17:30:00	65	66	2	1	50	50	17	8	6	2	12	6	4	3	0	1	\N	\N	39	\N	16   	1
1208178	2024-12-15 16:30:00	50	33	1	2	52	48	10	10	3	3	5	14	8	2	1	1	\N	\N	39	\N	16   	1
1208181	2024-12-15 19:00:00	41	47	0	5	42	58	9	18	3	9	8	15	2	5	1	3	\N	\N	39	\N	16   	1
1208173	2024-12-16 20:00:00	35	48	1	1	51	49	29	16	9	3	6	11	12	6	0	2	\N	\N	39	\N	16   	1
1208192	2024-12-21 15:00:00	48	51	1	1	46	54	11	12	4	6	14	20	8	4	2	2	\N	\N	39	\N	17   	1
1208184	2024-12-21 15:00:00	55	65	0	2	64	36	7	10	3	6	10	14	9	5	3	4	\N	\N	39	\N	17   	1
1208185	2024-12-21 17:30:00	52	42	1	5	42	58	15	14	6	6	9	8	3	3	2	2	\N	\N	39	\N	17   	1
1208187	2024-12-22 14:00:00	36	41	0	0	57	43	15	5	5	1	8	15	6	5	1	3	\N	\N	39	\N	17   	1
1208186	2024-12-22 14:00:00	45	49	0	0	25	75	5	12	4	5	20	12	2	5	4	1	\N	\N	39	\N	17   	1
1208191	2024-12-22 16:30:00	47	40	3	6	52	48	9	24	5	12	7	9	7	5	1	2	\N	\N	39	\N	17   	1
1208199	2024-12-26 15:00:00	34	66	3	0	63	37	22	4	8	1	15	10	9	6	2	1	0	1	39	\N	18   	1
1208193	2024-12-26 15:00:00	35	52	0	0	52	48	18	10	4	4	13	12	5	2	2	2	\N	\N	39	\N	18   	1
1208196	2024-12-26 15:00:00	49	36	1	2	47	53	12	14	8	7	13	13	3	1	1	3	\N	\N	39	\N	18   	1
1208202	2024-12-26 17:30:00	39	33	2	0	51	49	7	11	4	4	12	12	4	4	2	4	0	1	39	\N	18   	1
1208197	2024-12-26 20:00:00	40	46	3	1	69	31	19	4	7	1	17	5	14	1	3	2	\N	\N	39	\N	18   	1
1208194	2024-12-27 20:15:00	42	57	1	0	68	32	13	3	5	0	7	12	5	1	1	1	\N	\N	39	\N	18   	1
1208207	2024-12-29 15:00:00	36	35	2	2	52	48	11	16	6	9	7	16	1	7	1	3	\N	\N	39	\N	19   	1
1208206	2024-12-29 15:00:00	45	65	0	2	64	36	13	11	2	7	13	10	5	4	4	1	\N	\N	39	\N	19   	1
1208205	2024-12-29 15:00:00	52	41	2	1	46	54	19	7	10	3	18	19	8	7	2	3	\N	\N	39	\N	19   	1
1208208	2024-12-30 19:45:00	57	49	2	0	24	76	9	20	6	5	9	5	4	7	4	4	\N	\N	39	\N	19   	1
1208203	2024-12-30 19:45:00	66	51	2	2	60	40	20	13	4	4	9	14	12	3	2	3	\N	\N	39	\N	19   	1
1208204	2025-01-01 17:30:00	55	42	1	3	51	49	5	14	2	5	6	8	4	3	1	2	\N	\N	39	\N	19   	1
1208213	2025-01-04 15:00:00	35	45	1	0	58	42	19	9	8	0	15	14	9	3	2	2	\N	\N	39	\N	20   	1
1208220	2025-01-04 15:00:00	41	55	0	5	51	49	8	20	1	11	10	4	2	2	2	0	\N	\N	39	\N	20   	1
1208216	2025-01-04 15:00:00	52	49	1	1	38	62	13	15	6	1	9	12	6	6	0	2	\N	\N	39	\N	20   	1
1208215	2025-01-04 17:30:00	51	42	1	1	45	55	11	9	4	3	17	14	2	5	2	3	\N	\N	39	\N	20   	1
1208217	2025-01-05 14:00:00	36	57	2	2	73	27	15	7	4	3	10	14	9	2	1	5	\N	\N	39	\N	20   	1
1208222	2025-01-06 20:00:00	39	65	0	3	61	39	13	11	6	3	10	8	5	3	1	2	\N	\N	39	\N	20   	1
1208230	2025-01-14 19:30:00	49	35	2	2	57	43	26	7	10	3	15	16	9	3	2	3	\N	\N	39	\N	21   	1
1208224	2025-01-14 19:30:00	55	50	2	2	45	55	18	21	6	8	4	4	4	5	\N	\N	\N	\N	39	\N	21   	1
1208231	2025-01-15 19:30:00	34	39	3	0	61	39	17	13	5	7	10	13	4	2	0	2	\N	\N	39	\N	21   	1
1208225	2025-01-15 19:30:00	45	66	0	1	50	50	10	11	3	3	17	10	8	5	2	1	\N	\N	39	\N	21   	1
1208223	2025-01-15 20:00:00	42	47	2	1	53	47	14	10	4	2	16	9	10	4	3	1	\N	\N	39	\N	21   	1
1208232	2025-01-16 20:00:00	33	41	3	1	60	40	23	13	9	5	7	10	4	4	1	3	\N	\N	39	\N	21   	1
1208240	2025-01-18 12:30:00	34	35	1	4	55	45	13	19	5	10	7	18	7	6	1	6	\N	\N	39	\N	22   	1
1208317	2025-04-01 18:45:00	39	48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	30   	0
1208314	2025-04-01 18:45:00	42	36	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	30   	0
1208316	2025-04-01 19:00:00	65	33	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	30   	0
1208320	2025-04-02 18:45:00	34	55	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	30   	0
1208313	2025-04-02 18:45:00	35	57	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	30   	0
1208321	2025-04-02 18:45:00	41	52	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	30   	0
1208319	2025-04-02 18:45:00	50	46	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	30   	0
1208315	2025-04-02 18:45:00	51	66	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	30   	0
1208322	2025-04-02 19:00:00	40	45	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	30   	0
1208318	2025-04-03 19:00:00	49	47	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	30   	0
1208326	2025-04-05 11:30:00	45	42	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	31   	0
1208332	2025-04-05 14:00:00	48	35	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	31   	0
1208325	2025-04-05 14:00:00	52	51	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	31   	0
1208328	2025-04-05 14:00:00	57	39	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	31   	0
1208323	2025-04-05 16:30:00	66	65	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	31   	0
1208327	2025-04-06 13:00:00	36	40	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	31   	0
1208331	2025-04-06 13:00:00	47	41	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	31   	0
1208324	2025-04-06 13:00:00	55	49	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	31   	0
1208330	2025-04-06 15:30:00	33	50	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	31   	0
1208329	2025-04-07 19:00:00	46	34	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	31   	0
1208234	2025-01-18 15:00:00	55	40	0	2	39	61	11	37	6	8	6	14	2	15	2	3	\N	\N	39	\N	22   	1
1208239	2025-01-19 14:00:00	33	51	1	3	52	48	10	6	1	3	13	12	4	2	3	3	\N	\N	39	\N	22   	1
1208236	2025-01-19 14:00:00	45	47	3	2	35	65	12	11	6	6	14	14	3	8	2	1	\N	\N	39	\N	22   	1
1208237	2025-01-19 16:30:00	57	50	0	6	33	67	8	17	4	9	4	7	4	7	0	1	\N	\N	39	\N	22   	1
1208243	2025-01-25 15:00:00	35	65	5	0	51	49	16	18	10	4	9	12	3	9	2	3	\N	\N	39	\N	23   	1
1208252	2025-01-25 15:00:00	39	42	0	1	52	48	9	9	4	3	20	10	1	5	2	1	1	1	39	\N	23   	1
1208250	2025-01-25 15:00:00	41	34	1	3	53	47	12	17	5	9	10	5	3	8	1	0	\N	\N	39	\N	23   	1
1208249	2025-01-25 17:30:00	50	49	3	1	57	43	15	10	6	4	6	8	2	3	3	2	\N	\N	39	\N	23   	1
1208251	2025-01-26 14:00:00	47	46	1	2	61	39	15	12	6	3	6	16	6	4	1	5	\N	\N	39	\N	23   	1
1208244	2025-01-26 16:30:00	66	48	1	1	46	54	14	14	4	4	13	16	4	3	2	3	\N	\N	39	\N	23   	1
1208261	2025-02-01 12:30:00	65	51	7	0	37	63	14	10	9	5	8	13	4	6	1	3	\N	\N	39	\N	24   	1
1208260	2025-02-01 15:00:00	34	36	1	2	48	52	11	15	4	4	10	15	3	7	4	4	\N	\N	39	\N	24   	1
1208257	2025-02-01 15:00:00	45	46	4	0	47	53	13	9	7	1	7	13	5	6	\N	\N	\N	\N	39	\N	24   	1
1208258	2025-02-01 15:00:00	57	41	1	2	57	43	15	9	6	4	11	14	1	2	0	3	\N	\N	39	\N	24   	1
1208259	2025-02-02 14:00:00	33	52	0	2	67	33	17	11	2	3	12	13	11	0	3	1	\N	\N	39	\N	24   	1
1208254	2025-02-02 16:30:00	42	50	5	1	46	54	12	7	7	4	6	7	5	2	2	0	\N	\N	39	\N	24   	1
1208256	2025-02-03 20:00:00	49	48	2	1	68	32	22	14	3	5	11	10	4	3	3	1	\N	\N	39	\N	24   	1
1208264	2025-02-14 20:00:00	51	49	3	0	31	69	13	8	5	0	12	15	2	9	1	2	\N	\N	39	\N	25   	1
1208266	2025-02-15 15:00:00	36	65	2	1	56	44	24	8	10	2	13	8	8	4	\N	\N	\N	\N	39	\N	25   	1
1208270	2025-02-15 15:00:00	41	35	1	3	45	55	11	14	4	7	13	15	4	6	1	3	\N	\N	39	\N	25   	1
1208269	2025-02-15 15:00:00	50	34	4	0	62	38	11	3	7	1	5	13	7	4	0	1	\N	\N	39	\N	25   	1
1208265	2025-02-15 17:30:00	52	45	1	2	58	42	17	11	6	6	9	12	6	2	0	1	\N	\N	39	\N	25   	1
1208268	2025-02-16 14:00:00	40	39	2	1	50	50	10	16	3	4	15	13	4	3	2	2	\N	\N	39	\N	25   	1
1208305	2025-02-19 19:30:00	66	40	2	2	52	48	9	17	4	3	8	6	6	8	1	0	\N	\N	39	\N	29   	1
1208279	2025-02-21 20:00:00	46	55	0	4	48	52	8	14	3	6	10	10	5	6	4	0	\N	\N	39	\N	26   	1
1208273	2025-02-22 15:00:00	35	39	0	1	45	55	8	13	3	5	17	9	6	7	3	3	1	0	39	\N	26   	1
1208282	2025-02-22 15:00:00	41	51	0	4	50	50	6	18	1	12	11	12	5	6	2	0	\N	\N	39	\N	26   	1
1208278	2025-02-22 15:00:00	57	47	1	4	41	59	17	10	5	6	15	14	4	4	2	1	\N	\N	39	\N	26   	1
1208275	2025-02-22 17:30:00	66	49	2	1	52	48	12	15	6	7	15	16	2	3	1	3	\N	\N	39	\N	26   	1
1208280	2025-02-23 16:30:00	50	40	0	2	66	34	16	8	5	4	3	10	7	5	\N	\N	\N	\N	39	\N	26   	1
1208288	2025-02-25 19:30:00	39	36	1	2	60	40	18	11	5	5	8	15	7	4	1	3	\N	\N	39	\N	27   	1
1208289	2025-02-25 19:30:00	52	66	4	1	36	64	19	6	6	2	19	10	3	8	3	1	\N	\N	39	\N	27   	1
1208292	2025-02-26 19:30:00	33	57	3	2	45	55	10	12	6	3	9	16	5	6	4	4	1	0	39	\N	27   	1
1208286	2025-02-26 19:30:00	47	50	0	1	56	44	11	12	6	5	12	15	8	3	3	0	\N	\N	39	\N	27   	1
1208285	2025-02-26 19:30:00	65	42	0	0	35	65	6	13	2	1	10	17	3	11	1	1	\N	\N	39	\N	27   	1
1208287	2025-02-27 20:00:00	48	46	2	0	58	42	8	10	2	2	12	6	3	3	\N	\N	\N	\N	39	\N	27   	1
1208299	2025-03-08 12:30:00	65	50	1	0	31	69	9	14	4	3	9	7	3	2	3	2	\N	\N	39	\N	28   	1
1208294	2025-03-08 15:00:00	51	36	2	1	53	47	9	6	4	1	6	12	3	7	0	2	\N	\N	39	\N	28   	1
1208293	2025-03-08 17:30:00	55	66	0	1	60	40	13	12	3	4	10	5	6	5	2	2	\N	\N	39	\N	28   	1
1208302	2025-03-08 20:00:00	39	45	1	1	66	34	11	12	3	4	11	16	5	5	2	2	\N	\N	39	\N	28   	1
1208295	2025-03-09 14:00:00	49	46	1	0	57	43	20	3	7	3	12	13	12	2	1	0	\N	\N	39	\N	28   	1
1208301	2025-03-10 20:00:00	48	34	0	1	51	49	9	9	2	3	7	15	3	4	0	1	\N	\N	39	\N	28   	1
1208312	2025-03-15 15:00:00	41	39	1	2	59	41	10	5	3	3	12	13	5	1	\N	\N	\N	\N	39	\N	29   	1
1208310	2025-03-15 15:00:00	50	51	2	2	60	40	11	15	3	3	10	10	4	5	2	5	\N	\N	39	\N	29   	1
1208308	2025-03-15 15:00:00	57	65	2	4	56	44	11	11	4	6	4	13	6	3	1	1	\N	\N	39	\N	29   	1
1208307	2025-03-16 13:30:00	36	47	2	0	57	43	13	12	4	4	13	10	6	5	\N	\N	\N	\N	39	\N	29   	1
1208309	2025-03-16 19:00:00	46	33	0	3	54	46	11	18	3	5	6	6	6	4	2	0	\N	\N	39	\N	29   	1
1208338	2025-04-12 11:30:00	50	52	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	32   	0
1208341	2025-04-12 14:00:00	41	66	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	32   	0
1208335	2025-04-12 14:00:00	51	46	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	32   	0
1208340	2025-04-12 14:00:00	65	45	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	32   	0
1208334	2025-04-12 16:30:00	42	55	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	32   	0
1208342	2025-04-13 13:00:00	39	47	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	32   	0
1208337	2025-04-13 13:00:00	40	48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	32   	0
1208336	2025-04-13 13:00:00	49	57	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	32   	0
1208339	2025-04-13 15:30:00	34	33	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	32   	0
1208333	2025-04-14 19:00:00	35	36	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	32   	0
1208311	2025-04-16 18:30:00	34	52	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	29   	0
1208344	2025-04-19 14:00:00	55	51	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	33   	0
1208343	2025-04-19 16:30:00	66	34	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	33   	0
1208350	2025-04-20 13:00:00	33	39	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	33   	0
1208347	2025-04-20 13:00:00	36	49	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	33   	0
1208348	2025-04-20 13:00:00	57	42	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	33   	0
1208349	2025-04-20 15:30:00	46	40	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	33   	0
1208351	2025-04-21 19:00:00	47	65	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	33   	0
1208356	2025-04-26 11:30:00	49	45	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	34   	0
1208359	2025-04-26 14:00:00	34	57	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	34   	0
1208362	2025-04-26 14:00:00	39	46	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	34   	0
1208361	2025-04-26 14:00:00	41	36	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	34   	0
1208355	2025-04-26 14:00:00	51	48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	34   	0
1208360	2025-04-26 14:00:00	65	55	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	34   	0
1208354	2025-04-26 16:30:00	42	52	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	34   	0
1208353	2025-04-27 13:00:00	35	33	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	34   	0
1208357	2025-04-27 15:30:00	40	47	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	34   	0
1208358	2025-04-28 19:00:00	50	66	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	34   	0
1208371	2025-05-02 19:00:00	50	39	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	35   	0
1208364	2025-05-03 11:30:00	66	36	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	35   	0
1208369	2025-05-03 14:00:00	45	57	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	35   	0
1208370	2025-05-03 14:00:00	46	41	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	35   	0
1208372	2025-05-03 14:00:00	48	47	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	35   	0
1208365	2025-05-03 14:00:00	55	33	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	35   	0
1208363	2025-05-03 16:30:00	42	35	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	35   	0
1208366	2025-05-04 13:00:00	51	34	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	35   	0
1208367	2025-05-04 15:30:00	49	40	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	35   	0
1208368	2025-05-05 19:00:00	52	65	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	35   	0
1208377	2025-05-10 14:00:00	33	48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	36   	0
1208378	2025-05-10 14:00:00	34	49	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	36   	0
1208373	2025-05-10 14:00:00	35	66	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	36   	0
1208374	2025-05-10 14:00:00	36	45	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	36   	0
1208382	2025-05-10 14:00:00	39	51	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	36   	0
1208376	2025-05-10 14:00:00	40	42	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	36   	0
1208380	2025-05-10 14:00:00	41	50	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	36   	0
1208381	2025-05-10 14:00:00	47	52	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	36   	0
1208375	2025-05-10 14:00:00	57	55	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	36   	0
1208379	2025-05-10 14:00:00	65	46	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	36   	0
1208383	2025-05-18 14:00:00	42	34	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	37   	0
1208389	2025-05-18 14:00:00	45	41	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	37   	0
1208390	2025-05-18 14:00:00	46	57	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	37   	0
1208392	2025-05-18 14:00:00	48	65	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	37   	0
1208387	2025-05-18 14:00:00	49	33	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	37   	0
1208391	2025-05-18 14:00:00	50	35	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	37   	0
1208386	2025-05-18 14:00:00	51	40	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	37   	0
1208388	2025-05-18 14:00:00	52	39	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	37   	0
1208385	2025-05-18 14:00:00	55	36	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	37   	0
1208384	2025-05-18 14:00:00	66	47	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	37   	0
1208397	2025-05-25 15:00:00	33	66	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	38   	0
1208398	2025-05-25 15:00:00	34	45	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	38   	0
1208393	2025-05-25 15:00:00	35	46	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	38   	0
1208394	2025-05-25 15:00:00	36	50	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	38   	0
1208402	2025-05-25 15:00:00	39	55	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	38   	0
1208396	2025-05-25 15:00:00	40	52	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	38   	0
1208400	2025-05-25 15:00:00	41	42	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	38   	0
1208401	2025-05-25 15:00:00	47	51	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	38   	0
1208395	2025-05-25 15:00:00	57	48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	38   	0
1208399	2025-05-25 15:00:00	65	49	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	\N	38   	0
1180510	2024-07-11 22:30:00	121	144	3	1	64	36	23	11	6	3	9	19	9	2	2	2	\N	\N	71	\N	16   	1
1180514	2024-07-11 23:00:00	140	124	1	1	40	60	13	18	4	10	15	7	2	5	2	1	\N	\N	71	\N	16   	1
1180507	2024-07-12 00:30:00	136	120	0	1	46	54	11	15	5	4	16	24	4	5	2	3	\N	\N	71	\N	16   	1
1180517	2024-07-13 19:00:00	118	1193	1	2	64	36	14	14	2	3	4	8	8	4	2	3	\N	\N	71	\N	17   	1
1180524	2024-07-16 22:00:00	152	1062	1	1	27	73	8	20	2	5	8	12	1	8	2	1	\N	\N	71	\N	17   	1
1180520	2024-07-17 00:00:00	131	140	2	1	54	46	14	16	7	4	10	17	5	5	1	0	\N	\N	71	\N	17   	1
1180521	2024-07-17 23:00:00	126	130	1	0	55	45	14	19	8	5	16	8	8	9	6	3	1	0	71	\N	17   	1
1180522	2024-07-18 00:30:00	154	136	3	1	48	52	12	11	4	3	19	19	1	6	4	3	\N	\N	71	\N	17   	1
1180529	2024-07-20 21:30:00	120	119	1	0	48	52	10	10	4	1	16	14	2	1	4	2	\N	\N	71	\N	18   	1
1180530	2024-07-21 00:00:00	121	135	2	0	43	57	15	8	5	2	16	16	6	4	4	4	\N	\N	71	\N	18   	1
1180527	2024-07-21 19:00:00	118	131	0	1	65	35	17	7	7	2	12	18	6	3	4	4	\N	\N	71	\N	18   	1
1180526	2024-07-21 19:00:00	1062	133	2	0	54	46	15	8	3	1	13	6	6	1	1	1	\N	\N	71	\N	18   	1
1180532	2024-07-21 21:30:00	154	144	3	1	60	40	12	10	3	2	12	12	5	6	5	3	1	1	71	\N	18   	1
1180533	2024-07-21 23:00:00	1193	124	0	1	47	53	16	10	6	4	19	6	6	4	1	2	0	1	71	\N	18   	1
1180384	2024-07-24 22:00:00	140	154	1	1	48	52	13	15	7	4	11	8	4	5	0	1	\N	\N	71	\N	 3   	1
1180541	2024-07-24 22:30:00	126	120	2	2	69	31	15	12	6	6	17	22	7	1	4	3	\N	\N	71	\N	19   	1
1180538	2024-07-25 00:30:00	124	121	1	0	50	50	14	7	2	1	14	19	4	2	2	3	\N	\N	71	\N	19   	1
1180540	2024-07-25 23:00:00	131	130	2	2	64	36	14	18	7	7	21	17	4	5	1	2	\N	\N	71	\N	19   	1
1180550	2024-07-27 22:00:00	121	136	0	2	71	29	21	10	3	3	14	9	13	2	2	6	0	1	71	\N	20   	1
1180535	2024-09-11 22:30:00	119	154	2	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	19   	1
1180572	2024-08-10 19:00:00	154	140	1	0	50	50	16	12	4	2	16	13	4	6	2	4	\N	\N	71	\N	22   	1
1180570	2024-08-11 00:30:00	131	794	1	1	63	37	19	11	5	6	11	18	6	6	4	6	\N	\N	71	\N	22   	1
1180569	2024-08-11 00:30:00	133	124	2	0	43	57	8	12	3	3	23	12	6	3	3	3	\N	\N	71	\N	22   	1
1180574	2024-08-11 14:00:00	152	120	3	2	37	63	16	24	8	10	10	14	6	12	3	5	\N	\N	71	\N	22   	1
1180567	2024-08-11 19:00:00	118	136	2	0	57	43	7	14	3	5	10	12	3	7	3	4	\N	\N	71	\N	22   	1
1180568	2024-08-11 19:00:00	127	121	1	1	52	48	11	9	7	7	15	21	4	2	1	4	0	1	71	\N	22   	1
1180405	2024-08-14 22:30:00	119	152	2	1	48	52	21	8	10	3	19	17	8	1	2	4	\N	\N	71	\N	 6   	1
1180576	2024-08-17 19:00:00	1062	1193	1	1	60	40	13	11	4	6	13	14	8	6	3	6	\N	\N	71	\N	23   	1
1180581	2024-08-17 21:30:00	794	154	1	2	61	39	13	14	9	7	19	13	9	2	4	4	\N	\N	71	\N	23   	1
1180580	2024-08-18 19:00:00	121	126	2	1	53	47	24	8	8	4	17	12	6	1	4	3	1	2	71	\N	23   	1
1180583	2024-08-18 19:00:00	144	119	1	0	42	58	13	19	5	6	11	6	4	7	3	0	\N	\N	71	\N	23   	1
1180579	2024-08-18 21:30:00	120	127	4	1	54	46	19	10	9	4	17	7	5	2	4	2	\N	\N	71	\N	23   	1
1180577	2024-08-19 23:00:00	136	135	2	2	30	70	14	25	5	12	10	13	4	7	1	3	1	0	71	\N	23   	1
1180590	2024-08-24 21:30:00	121	1193	5	0	58	42	14	10	9	3	16	6	7	1	1	1	\N	\N	71	\N	24   	1
1180586	2024-08-25 00:00:00	1062	124	0	2	60	40	19	8	0	6	19	7	5	2	5	2	\N	\N	71	\N	24   	1
1180594	2024-08-25 19:00:00	140	130	0	1	47	53	19	14	4	4	15	8	6	9	2	1	\N	\N	71	\N	24   	1
1180591	2024-08-25 21:30:00	126	136	2	1	58	42	12	10	3	4	7	8	4	3	0	2	\N	\N	71	\N	24   	1
1180585	2024-08-25 22:00:00	119	135	1	0	44	56	19	5	9	3	12	9	12	3	3	2	\N	\N	71	\N	24   	1
1180589	2024-08-27 00:00:00	133	134	2	1	46	54	7	9	5	4	10	11	4	5	1	2	0	1	71	\N	24   	1
1180544	2024-08-28 22:30:00	140	794	1	0	49	51	14	15	2	6	17	15	6	8	3	3	\N	\N	71	\N	19   	1
1180603	2024-08-31 21:30:00	1193	140	2	1	45	55	22	12	3	3	16	9	5	5	3	0	\N	\N	71	\N	25   	1
1180595	2024-09-01 14:00:00	130	1062	2	3	28	72	11	27	5	13	11	17	5	9	1	3	1	0	71	\N	25   	1
1180600	2024-09-01 19:00:00	131	127	2	1	43	57	13	10	4	3	18	18	5	2	5	4	2	1	71	\N	25   	1
1180598	2024-09-01 21:30:00	124	126	2	0	44	56	10	15	5	2	13	16	5	4	4	4	\N	\N	71	\N	25   	1
1180597	2024-09-01 21:30:00	136	133	0	1	47	53	21	9	5	6	7	7	10	3	3	3	\N	\N	71	\N	25   	1
1180601	2024-09-01 21:30:00	794	118	2	1	30	70	15	16	6	6	8	13	5	10	2	3	\N	\N	71	\N	25   	1
1180513	2024-09-05 23:00:00	1193	152	0	0	53	47	12	9	3	3	17	11	3	3	3	1	\N	\N	71	\N	16   	1
1180612	2024-09-14 21:30:00	134	154	1	1	55	45	28	10	9	3	12	10	13	4	2	2	\N	\N	71	\N	26   	1
1180610	2024-09-15 19:00:00	121	140	5	0	54	46	14	14	8	5	12	11	4	6	0	2	1	0	71	\N	26   	1
1180614	2024-09-15 19:00:00	152	124	2	1	53	47	12	8	5	1	8	9	8	5	5	4	\N	\N	71	\N	26   	1
1180607	2024-09-15 21:30:00	118	1062	3	0	55	45	16	5	4	2	17	16	6	1	1	3	\N	\N	71	\N	26   	1
1180606	2024-09-15 21:30:00	135	126	0	1	61	39	14	14	1	4	11	10	7	7	4	3	\N	\N	71	\N	26   	1
1180605	2024-09-16 23:00:00	119	1193	3	0	67	33	15	2	7	0	8	10	2	3	1	2	\N	\N	71	\N	26   	1
1180617	2024-09-21 19:00:00	136	152	1	0	36	64	13	11	2	2	12	15	4	5	3	4	\N	\N	71	\N	27   	1
1180622	2024-09-22 00:00:00	154	118	4	1	37	63	11	9	7	4	13	9	2	1	2	1	1	0	71	\N	27   	1
1180619	2024-09-22 19:00:00	133	121	0	1	55	45	10	14	3	3	8	14	5	5	1	2	\N	\N	71	\N	27   	1
1180621	2024-09-22 21:30:00	126	119	1	3	61	39	7	14	2	6	18	16	2	4	4	1	\N	\N	71	\N	27   	1
1180623	2024-09-22 21:30:00	1193	135	0	0	48	52	9	13	4	2	10	10	4	5	0	1	0	1	71	\N	27   	1
1180624	2024-09-23 21:30:00	140	134	0	0	64	36	24	10	6	3	11	12	12	1	2	2	\N	\N	71	\N	27   	1
1180511	2024-09-25 22:00:00	794	119	2	2	43	57	10	24	4	11	13	11	1	9	3	2	\N	\N	71	\N	16   	1
1180629	2024-09-29 00:00:00	120	130	0	0	63	37	15	11	3	4	10	14	5	3	2	3	0	1	71	\N	28   	1
1180631	2024-09-29 19:00:00	126	131	3	1	53	47	19	11	8	3	18	17	7	2	6	6	0	2	71	\N	28   	1
1180633	2024-09-29 19:00:00	144	124	1	0	40	60	16	13	7	2	15	14	4	3	0	2	\N	\N	71	\N	28   	1
1180627	2024-09-29 21:30:00	118	140	1	0	55	45	21	2	7	1	10	8	9	1	1	2	\N	\N	71	\N	28   	1
1180626	2024-09-29 21:30:00	135	133	1	1	56	44	15	13	6	4	7	6	11	4	0	3	0	1	71	\N	28   	1
1180628	2024-09-29 23:00:00	127	134	1	0	70	30	17	7	5	1	12	13	6	1	2	2	\N	\N	71	\N	28   	1
1180638	2024-10-04 00:30:00	124	135	1	0	47	53	14	13	5	5	19	16	2	2	8	3	\N	\N	71	\N	29   	1
1180642	2024-10-05 19:30:00	134	120	0	1	53	47	26	11	3	3	8	20	8	3	2	4	\N	\N	71	\N	29   	1
1180641	2024-10-05 19:30:00	794	121	0	0	41	59	17	14	5	5	7	14	1	3	4	3	1	1	71	\N	29   	1
1180637	2024-10-05 22:00:00	118	127	0	2	46	54	9	13	2	6	20	11	3	7	5	4	1	0	71	\N	29   	1
1180643	2024-10-05 22:00:00	1193	126	2	0	22	78	7	12	3	3	12	8	3	7	2	2	\N	\N	71	\N	29   	1
1180406	2024-10-09 22:30:00	1062	130	2	1	45	55	14	14	5	4	15	7	4	10	4	3	\N	\N	71	\N	 6   	1
1180651	2024-10-17 00:45:00	126	133	3	0	47	53	13	9	5	3	8	5	3	5	1	0	\N	\N	71	\N	30   	1
1180648	2024-10-17 23:00:00	127	124	0	2	60	40	19	12	5	3	15	15	5	1	1	3	\N	\N	71	\N	30   	1
1180650	2024-10-17 23:00:00	131	134	5	2	61	39	14	22	8	6	9	7	3	8	3	3	\N	\N	71	\N	30   	1
1180649	2024-10-18 23:00:00	120	140	1	1	74	26	25	6	7	3	12	10	9	1	1	2	\N	\N	71	\N	30   	1
1351154	2025-06-11 00:00:00	120	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	12   	0
1351155	2025-06-11 00:00:00	121	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	12   	0
1351162	2025-06-11 00:00:00	123	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	12   	0
1351153	2025-06-11 00:00:00	124	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	12   	0
1180647	2024-10-19 19:00:00	136	794	1	0	49	51	11	9	3	1	15	8	5	5	2	1	\N	\N	71	\N	30   	1
1180518	2024-10-22 22:30:00	124	134	1	0	75	25	14	6	5	2	9	15	5	3	2	4	\N	\N	71	\N	17   	1
1180660	2024-10-26 19:30:00	121	154	2	2	60	40	16	11	6	3	9	17	3	3	1	5	\N	\N	71	\N	31   	1
1180655	2024-10-26 19:30:00	130	144	3	1	48	52	11	13	5	5	14	18	4	3	2	5	\N	\N	71	\N	31   	1
1180657	2024-10-26 19:30:00	136	124	2	1	50	50	12	11	3	4	15	7	7	5	4	2	\N	\N	71	\N	31   	1
1180661	2024-10-26 23:00:00	794	120	0	1	38	62	6	19	1	5	13	17	3	6	1	1	\N	\N	71	\N	31   	1
1180656	2024-10-26 23:00:00	1062	119	1	3	58	42	7	11	3	7	15	15	3	3	6	2	1	0	71	\N	31   	1
1180663	2024-10-28 22:00:00	1193	131	0	1	56	44	13	9	5	3	14	16	5	2	5	2	\N	\N	71	\N	31   	1
1180515	2024-10-30 22:00:00	119	127	1	1	47	53	18	12	5	3	14	10	5	5	1	4	\N	\N	71	\N	17   	1
1180671	2024-11-02 19:00:00	794	1193	0	0	68	32	18	7	4	1	8	11	11	5	1	3	\N	\N	71	\N	32   	1
1180672	2024-11-02 21:30:00	134	136	1	2	64	36	24	11	6	5	8	13	9	3	1	3	\N	\N	71	\N	32   	1
1180670	2024-11-04 23:00:00	131	121	2	0	42	58	6	17	4	4	18	13	2	9	2	3	\N	\N	71	\N	32   	1
1180667	2024-11-06 00:30:00	118	126	0	3	52	48	24	9	6	4	13	16	10	3	3	2	\N	\N	71	\N	32   	1
1180669	2024-11-06 00:30:00	120	133	3	0	64	36	20	11	4	3	13	8	7	4	0	3	0	1	71	\N	32   	1
1180673	2024-11-07 00:00:00	144	1062	1	0	37	63	13	12	3	5	11	13	4	7	2	2	\N	\N	71	\N	32   	1
1180675	2024-11-08 22:00:00	119	124	2	0	51	49	14	9	5	2	11	10	4	4	3	1	\N	\N	71	\N	33   	1
1180679	2024-11-09 19:30:00	120	1193	0	0	74	26	28	4	5	2	7	13	8	1	0	5	\N	\N	71	\N	33   	1
1180676	2024-11-09 22:00:00	135	140	2	1	63	37	26	12	9	7	13	11	6	5	3	4	\N	\N	71	\N	33   	1
1180683	2024-11-09 22:00:00	144	794	0	0	41	59	10	17	4	7	14	11	7	6	3	2	\N	\N	71	\N	33   	1
1180682	2024-11-09 22:00:00	154	133	3	0	39	61	14	4	8	2	13	11	5	1	1	1	\N	\N	71	\N	33   	1
1180678	2024-11-13 23:00:00	127	1062	0	0	54	46	25	16	6	2	14	7	7	4	1	1	\N	\N	71	\N	33   	1
1180542	2024-11-16 21:30:00	134	1062	1	0	30	70	17	13	5	3	11	10	4	3	2	2	\N	\N	71	\N	19   	1
1180692	2024-11-20 19:30:00	134	144	2	0	37	63	11	20	8	6	9	8	6	9	1	2	1	0	71	\N	34   	1
1180691	2024-11-20 19:30:00	794	126	1	1	43	57	18	10	5	2	16	12	1	1	3	2	\N	\N	71	\N	34   	1
1180687	2024-11-20 21:00:00	118	121	1	2	58	42	17	11	5	2	15	14	4	5	1	1	\N	\N	71	\N	34   	1
1180693	2024-11-20 22:00:00	1193	127	1	2	37	63	5	19	3	7	6	10	4	10	1	2	\N	\N	71	\N	34   	1
1180689	2024-11-21 23:00:00	133	119	0	1	49	51	12	16	2	7	8	10	8	3	1	0	\N	\N	71	\N	34   	1
1180688	2024-11-23 00:30:00	124	154	2	2	74	26	10	11	5	5	9	11	8	3	1	3	\N	\N	71	\N	34   	1
1180703	2024-11-23 22:30:00	144	121	0	1	55	45	9	10	2	3	16	14	4	2	3	2	\N	\N	71	\N	35   	1
1180701	2024-11-24 00:30:00	126	1062	2	2	54	46	13	3	4	3	11	11	7	1	3	5	0	1	71	\N	35   	1
1180697	2024-11-24 19:00:00	118	134	1	1	74	26	25	6	8	3	7	13	11	1	1	2	\N	\N	71	\N	35   	1
1180700	2024-11-24 19:00:00	131	133	3	1	60	40	23	8	8	2	8	14	7	6	1	4	\N	\N	71	\N	35   	1
1180702	2024-11-26 23:00:00	154	127	0	0	39	61	7	16	1	4	16	14	5	5	2	4	0	1	71	\N	35   	1
1180706	2024-11-27 00:30:00	1062	152	2	3	64	36	21	13	6	7	13	8	9	5	1	0	\N	\N	71	\N	36   	1
1180696	2024-11-28 00:00:00	135	130	1	1	61	39	19	9	3	4	16	6	5	1	2	1	\N	\N	71	\N	35   	1
1180713	2024-11-30 22:30:00	1193	118	1	2	44	56	11	11	2	3	9	8	3	3	4	1	\N	\N	71	\N	36   	1
1180709	2024-12-01 00:30:00	133	144	2	2	61	39	16	12	7	6	9	10	5	3	2	3	0	1	71	\N	36   	1
1180705	2024-12-01 19:00:00	130	126	2	1	38	62	16	7	8	2	11	7	10	6	1	1	\N	\N	71	\N	36   	1
1180707	2024-12-01 21:30:00	136	154	2	0	29	71	19	11	8	2	13	10	7	8	4	3	\N	\N	71	\N	36   	1
1180711	2024-12-01 21:30:00	794	135	1	1	33	67	7	22	2	2	11	14	6	10	2	2	\N	\N	71	\N	36   	1
1180719	2024-12-04 22:00:00	133	1062	2	0	58	42	11	11	4	3	20	13	3	6	4	2	\N	\N	71	\N	37   	1
1180717	2024-12-04 23:00:00	136	130	1	1	49	51	25	7	5	2	13	10	7	1	1	2	\N	\N	71	\N	37   	1
1180724	2024-12-04 23:00:00	140	127	0	3	38	62	16	12	4	7	16	6	7	3	1	0	\N	\N	71	\N	37   	1
1180716	2024-12-05 00:30:00	135	121	1	2	46	54	9	31	3	12	14	13	7	6	3	1	\N	\N	71	\N	37   	1
1180718	2024-12-05 23:00:00	124	1193	1	0	58	42	24	3	6	3	14	9	10	3	3	4	\N	\N	71	\N	37   	1
1180722	2024-12-05 23:00:00	134	794	1	2	55	45	22	13	7	4	14	15	6	4	1	5	\N	\N	71	\N	37   	1
1180729	2024-12-08 19:00:00	120	126	2	1	46	54	17	5	8	1	8	3	3	0	\N	\N	\N	\N	71	\N	38   	1
1180728	2024-12-08 19:00:00	127	136	2	2	68	32	23	12	4	5	7	8	6	4	0	2	\N	\N	71	\N	38   	1
1180725	2024-12-08 19:00:00	130	131	0	3	35	65	17	19	4	6	11	14	6	7	2	3	1	1	71	\N	38   	1
1180732	2024-12-08 19:00:00	154	119	3	0	37	63	10	11	5	1	8	13	4	3	1	2	\N	\N	71	\N	38   	1
1180726	2024-12-08 19:00:00	1062	134	1	0	62	38	14	7	7	4	12	16	5	4	3	3	\N	\N	71	\N	38   	1
1180733	2024-12-08 19:00:00	1193	133	1	2	33	67	11	11	4	4	15	8	2	5	0	1	\N	\N	71	\N	38   	1
1351049	2025-03-29 21:30:00	130	1062	2	1	32	68	12	22	5	7	19	5	1	11	4	0	\N	\N	71	\N	 1   	1
1351052	2025-03-29 21:30:00	152	136	2	0	36	64	9	13	4	5	16	16	3	5	3	4	\N	\N	71	\N	 1   	1
1351051	2025-03-29 21:30:00	154	124	2	0	30	70	5	15	3	1	16	5	4	5	1	0	\N	\N	71	\N	 1   	1
1351045	2025-03-30 19:00:00	121	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 1   	0
1351044	2025-03-30 21:30:00	133	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 1   	0
1351050	2025-03-30 23:00:00	118	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 1   	0
1351047	2025-03-31 23:00:00	794	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 1   	0
1351061	2025-04-05 21:30:00	129	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 2   	0
1351055	2025-04-05 21:30:00	131	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 2   	0
1351054	2025-04-06 00:00:00	120	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 2   	0
1351053	2025-04-06 19:00:00	124	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 2   	0
1351058	2025-04-06 19:00:00	1062	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 2   	0
1351059	2025-04-06 21:30:00	119	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 2   	0
1351062	2025-04-06 21:30:00	123	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 2   	0
1351060	2025-04-06 21:30:00	136	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 2   	0
1351057	2025-04-06 21:30:00	7848	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 2   	0
1351056	2025-04-06 23:30:00	128	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 2   	0
1351072	2025-04-12 19:00:00	152	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 3   	0
1351067	2025-04-12 19:00:00	794	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 3   	0
1351065	2025-04-12 21:30:00	121	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 3   	0
1351064	2025-04-13 00:00:00	133	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 3   	0
1351070	2025-04-13 19:00:00	118	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 3   	0
1351066	2025-04-13 20:30:00	126	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 3   	0
1351069	2025-04-13 20:30:00	130	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 3   	0
1351063	2025-04-13 22:30:00	124	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 3   	0
1351071	2025-04-13 23:00:00	154	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 3   	0
1351068	2025-04-13 23:30:00	1062	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 3   	0
1351081	2025-04-16 00:30:00	129	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 4   	0
1351082	2025-04-16 22:00:00	123	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 4   	0
1351077	2025-04-16 22:00:00	7848	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 4   	0
1351079	2025-04-16 22:30:00	119	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 4   	0
1351075	2025-04-16 22:30:00	131	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 4   	0
1351073	2025-04-17 00:30:00	127	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 4   	0
1351076	2025-04-17 00:30:00	128	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 4   	0
1351080	2025-04-17 00:30:00	136	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 4   	0
1351074	2025-04-17 22:00:00	120	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 4   	0
1351078	2025-04-18 00:30:00	135	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 4   	0
1351085	2025-04-19 19:00:00	131	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 5   	0
1351084	2025-04-19 21:30:00	133	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 5   	0
1351089	2025-04-20 00:00:00	130	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 5   	0
1351092	2025-04-20 14:00:00	152	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 5   	0
1351086	2025-04-20 19:00:00	126	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 5   	0
1351088	2025-04-20 19:00:00	1062	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 5   	0
1351083	2025-04-20 21:30:00	124	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 5   	0
1351091	2025-04-20 21:30:00	154	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 5   	0
1351099	2025-04-26 19:00:00	119	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 6   	0
1351101	2025-04-26 21:30:00	129	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 6   	0
1351097	2025-04-26 21:30:00	7848	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 6   	0
1351102	2025-04-26 23:00:00	123	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 6   	0
1351094	2025-04-27 00:00:00	120	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 6   	0
1351093	2025-04-27 19:00:00	127	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 6   	0
1351095	2025-04-27 21:30:00	121	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 6   	0
1351098	2025-04-27 21:30:00	135	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 6   	0
1351100	2025-04-27 21:30:00	136	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 6   	0
1351106	2025-05-03 00:30:00	126	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 7   	0
1351103	2025-05-03 21:30:00	124	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 7   	0
1351111	2025-05-03 21:30:00	129	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 7   	0
1351105	2025-05-03 21:30:00	131	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 7   	0
1351110	2025-05-04 00:00:00	118	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 7   	0
1351109	2025-05-04 19:00:00	130	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 7   	0
1351104	2025-05-04 19:00:00	133	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 7   	0
1351108	2025-05-04 21:30:00	135	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 7   	0
1351121	2025-05-10 19:00:00	154	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 8   	0
1351119	2025-05-10 21:30:00	130	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 8   	0
1351120	2025-05-10 21:30:00	136	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 8   	0
1351117	2025-05-10 21:30:00	7848	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 8   	0
1351113	2025-05-11 00:00:00	127	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 8   	0
1351122	2025-05-11 19:00:00	123	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 8   	0
1351115	2025-05-11 20:30:00	121	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 8   	0
1351118	2025-05-11 20:30:00	1062	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 8   	0
1351116	2025-05-12 23:00:00	128	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 8   	0
1351131	2025-05-17 19:00:00	129	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 9   	0
1351124	2025-05-17 21:30:00	133	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 9   	0
1351126	2025-05-18 00:00:00	126	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 9   	0
1351130	2025-05-18 19:00:00	118	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 9   	0
1351125	2025-05-18 19:00:00	131	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 9   	0
1351132	2025-05-18 19:00:00	152	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 9   	0
1351123	2025-05-18 21:30:00	127	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 9   	0
1351127	2025-05-18 21:30:00	794	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 9   	0
1351134	2025-05-24 19:00:00	120	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	10   	0
1351133	2025-05-24 21:30:00	124	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	10   	0
1351136	2025-05-24 21:30:00	126	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	10   	0
1351138	2025-05-25 00:00:00	1062	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	10   	0
1351139	2025-05-25 14:00:00	130	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	10   	0
1351135	2025-05-25 19:00:00	121	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	10   	0
1351142	2025-05-25 19:00:00	123	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	10   	0
1351140	2025-05-25 21:30:00	136	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	10   	0
1351150	2025-05-31 19:00:00	118	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	11   	0
1351148	2025-05-31 21:30:00	135	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	11   	0
1351144	2025-06-01 00:00:00	133	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	11   	0
1351147	2025-06-01 14:00:00	7848	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	11   	0
1351146	2025-06-01 19:00:00	128	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	11   	0
1351152	2025-06-01 19:00:00	152	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	11   	0
1351143	2025-06-01 21:30:00	127	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	11   	0
1351151	2025-06-01 21:30:00	129	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	11   	0
1351145	2025-06-01 21:30:00	131	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	11   	0
1351156	2025-06-13 00:30:00	126	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	12   	0
1351158	2025-06-13 00:30:00	1062	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	12   	0
1351090	2025-04-19 00:00:00	118	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 5   	0
1351087	2025-04-19 00:00:00	794	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 5   	0
1351096	2025-04-26 00:00:00	128	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 6   	0
1351112	2025-05-03 00:00:00	152	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 7   	0
1351107	2025-05-03 00:00:00	794	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 7   	0
1351114	2025-05-10 00:00:00	120	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 8   	0
1351129	2025-05-17 00:00:00	119	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 9   	0
1351128	2025-05-17 00:00:00	135	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	 9   	0
1351141	2025-05-24 00:00:00	154	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	10   	0
1351137	2025-05-24 00:00:00	794	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	10   	0
1351149	2025-05-30 00:00:00	119	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	11   	0
1351159	2025-06-11 00:00:00	130	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	12   	0
1351160	2025-06-11 00:00:00	136	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	12   	0
1351161	2025-06-11 00:00:00	154	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	12   	0
1351157	2025-06-11 00:00:00	794	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	12   	0
1351170	2025-07-12 00:00:00	118	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	13   	0
1351169	2025-07-12 00:00:00	119	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	13   	0
1351163	2025-07-12 00:00:00	127	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	13   	0
1351166	2025-07-12 00:00:00	128	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	13   	0
1351165	2025-07-12 00:00:00	131	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	13   	0
1351164	2025-07-12 00:00:00	133	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	13   	0
1351168	2025-07-12 00:00:00	135	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	13   	0
1351172	2025-07-12 00:00:00	152	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	13   	0
1351171	2025-07-12 00:00:00	154	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	13   	0
1351167	2025-07-12 00:00:00	7848	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	13   	0
1351180	2025-07-16 00:00:00	118	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	14   	0
1351174	2025-07-16 00:00:00	120	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	14   	0
1351175	2025-07-16 00:00:00	121	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	14   	0
1351173	2025-07-16 00:00:00	124	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	14   	0
1351176	2025-07-16 00:00:00	128	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	14   	0
1351181	2025-07-16 00:00:00	129	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	14   	0
1351179	2025-07-16 00:00:00	130	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	14   	0
1351182	2025-07-16 00:00:00	152	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	14   	0
1351177	2025-07-16 00:00:00	794	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	14   	0
1351178	2025-07-16 00:00:00	1062	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	14   	0
1351189	2025-07-19 00:00:00	119	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	15   	0
1351185	2025-07-19 00:00:00	121	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	15   	0
1351192	2025-07-19 00:00:00	123	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	15   	0
1351186	2025-07-19 00:00:00	126	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	15   	0
1351183	2025-07-19 00:00:00	127	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	15   	0
1351184	2025-07-19 00:00:00	133	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	15   	0
1351188	2025-07-19 00:00:00	135	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	15   	0
1351190	2025-07-19 00:00:00	136	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	15   	0
1351191	2025-07-19 00:00:00	154	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	15   	0
1351187	2025-07-19 00:00:00	7848	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	15   	0
1351193	2025-07-23 00:00:00	124	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	16   	0
1351196	2025-07-23 00:00:00	128	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	16   	0
1351201	2025-07-23 00:00:00	129	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	16   	0
1351199	2025-07-23 00:00:00	130	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	16   	0
1351195	2025-07-23 00:00:00	131	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	16   	0
1351194	2025-07-23 00:00:00	133	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	16   	0
1351200	2025-07-23 00:00:00	136	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	16   	0
1351202	2025-07-23 00:00:00	152	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	16   	0
1351197	2025-07-23 00:00:00	794	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	16   	0
1351198	2025-07-23 00:00:00	1062	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	16   	0
1351210	2025-07-26 00:00:00	118	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	17   	0
1351209	2025-07-26 00:00:00	119	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	17   	0
1351204	2025-07-26 00:00:00	120	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	17   	0
1351205	2025-07-26 00:00:00	121	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	17   	0
1351212	2025-07-26 00:00:00	123	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	17   	0
1351206	2025-07-26 00:00:00	126	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	17   	0
1351203	2025-07-26 00:00:00	127	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	17   	0
1351208	2025-07-26 00:00:00	135	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	17   	0
1351211	2025-07-26 00:00:00	154	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	17   	0
1351207	2025-07-26 00:00:00	7848	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	17   	0
1351219	2025-08-02 00:00:00	119	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	18   	0
1351214	2025-08-02 00:00:00	120	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	18   	0
1351222	2025-08-02 00:00:00	123	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	18   	0
1351213	2025-08-02 00:00:00	124	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	18   	0
1351216	2025-08-02 00:00:00	128	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	18   	0
1351221	2025-08-02 00:00:00	129	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	18   	0
1351215	2025-08-02 00:00:00	131	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	18   	0
1351220	2025-08-02 00:00:00	136	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	18   	0
1351218	2025-08-02 00:00:00	1062	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	18   	0
1351217	2025-08-02 00:00:00	7848	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	18   	0
1351230	2025-08-09 00:00:00	118	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	19   	0
1351225	2025-08-09 00:00:00	121	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	19   	0
1351226	2025-08-09 00:00:00	126	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	19   	0
1351223	2025-08-09 00:00:00	127	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	19   	0
1351229	2025-08-09 00:00:00	130	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	19   	0
1351224	2025-08-09 00:00:00	133	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	19   	0
1351228	2025-08-09 00:00:00	135	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	19   	0
1351232	2025-08-09 00:00:00	152	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	19   	0
1351231	2025-08-09 00:00:00	154	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	19   	0
1351227	2025-08-09 00:00:00	794	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	19   	0
1351239	2025-08-16 00:00:00	119	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	20   	0
1351234	2025-08-16 00:00:00	120	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	20   	0
1351242	2025-08-16 00:00:00	123	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	20   	0
1351233	2025-08-16 00:00:00	124	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	20   	0
1351236	2025-08-16 00:00:00	128	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	20   	0
1351241	2025-08-16 00:00:00	129	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	20   	0
1351235	2025-08-16 00:00:00	131	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	20   	0
1351240	2025-08-16 00:00:00	136	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	20   	0
1351238	2025-08-16 00:00:00	1062	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	20   	0
1351237	2025-08-16 00:00:00	7848	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	20   	0
1351250	2025-08-23 00:00:00	118	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	21   	0
1351245	2025-08-23 00:00:00	121	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	21   	0
1351246	2025-08-23 00:00:00	126	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	21   	0
1351243	2025-08-23 00:00:00	127	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	21   	0
1351249	2025-08-23 00:00:00	130	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	21   	0
1351244	2025-08-23 00:00:00	133	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	21   	0
1351248	2025-08-23 00:00:00	135	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	21   	0
1351252	2025-08-23 00:00:00	152	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	21   	0
1351251	2025-08-23 00:00:00	154	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	21   	0
1351247	2025-08-23 00:00:00	794	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	21   	0
1351259	2025-08-30 00:00:00	119	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	22   	0
1351254	2025-08-30 00:00:00	120	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	22   	0
1351262	2025-08-30 00:00:00	123	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	22   	0
1351253	2025-08-30 00:00:00	127	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	22   	0
1351256	2025-08-30 00:00:00	128	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	22   	0
1351261	2025-08-30 00:00:00	129	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	22   	0
1351255	2025-08-30 00:00:00	131	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	22   	0
1351258	2025-08-30 00:00:00	135	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	22   	0
1351260	2025-08-30 00:00:00	136	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	22   	0
1351257	2025-08-30 00:00:00	7848	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	22   	0
1351270	2025-09-13 00:00:00	118	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	23   	0
1351265	2025-09-13 00:00:00	121	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	23   	0
1351263	2025-09-13 00:00:00	124	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	23   	0
1351266	2025-09-13 00:00:00	126	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	23   	0
1351269	2025-09-13 00:00:00	130	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	23   	0
1351264	2025-09-13 00:00:00	133	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	23   	0
1351272	2025-09-13 00:00:00	152	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	23   	0
1351271	2025-09-13 00:00:00	154	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	23   	0
1351267	2025-09-13 00:00:00	794	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	23   	0
1351268	2025-09-13 00:00:00	1062	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	23   	0
1351279	2025-09-20 00:00:00	119	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	24   	0
1351274	2025-09-20 00:00:00	120	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	24   	0
1351275	2025-09-20 00:00:00	121	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	24   	0
1351282	2025-09-20 00:00:00	123	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	24   	0
1351273	2025-09-20 00:00:00	127	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	24   	0
1351276	2025-09-20 00:00:00	128	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	24   	0
1351281	2025-09-20 00:00:00	129	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	24   	0
1351278	2025-09-20 00:00:00	135	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	24   	0
1351280	2025-09-20 00:00:00	136	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	24   	0
1351277	2025-09-20 00:00:00	7848	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	24   	0
1351290	2025-09-27 00:00:00	118	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	25   	0
1351283	2025-09-27 00:00:00	124	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	25   	0
1351286	2025-09-27 00:00:00	126	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	25   	0
1351289	2025-09-27 00:00:00	130	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	25   	0
1351285	2025-09-27 00:00:00	131	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	25   	0
1351284	2025-09-27 00:00:00	133	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	25   	0
1351292	2025-09-27 00:00:00	152	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	25   	0
1351291	2025-09-27 00:00:00	154	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	25   	0
1351287	2025-09-27 00:00:00	794	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	25   	0
1351288	2025-09-27 00:00:00	1062	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	25   	0
1351299	2025-10-01 00:00:00	119	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	26   	0
1351294	2025-10-01 00:00:00	120	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	26   	0
1351295	2025-10-01 00:00:00	121	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	26   	0
1351302	2025-10-01 00:00:00	123	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	26   	0
1351293	2025-10-01 00:00:00	127	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	26   	0
1351296	2025-10-01 00:00:00	128	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	26   	0
1351300	2025-10-01 00:00:00	136	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	26   	0
1351301	2025-10-01 00:00:00	154	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	26   	0
1351298	2025-10-01 00:00:00	1062	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	26   	0
1351297	2025-10-01 00:00:00	7848	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	26   	0
1351310	2025-10-16 00:00:00	118	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	27   	0
1351309	2025-10-16 00:00:00	119	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	27   	0
1351303	2025-10-16 00:00:00	124	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	27   	0
1351306	2025-10-16 00:00:00	126	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	27   	0
1351311	2025-10-16 00:00:00	129	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	27   	0
1351305	2025-10-16 00:00:00	131	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	27   	0
1351304	2025-10-16 00:00:00	133	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	27   	0
1351308	2025-10-16 00:00:00	135	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	27   	0
1351312	2025-10-16 00:00:00	152	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	27   	0
1351307	2025-10-16 00:00:00	794	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	27   	0
1351314	2025-10-25 00:00:00	120	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	28   	0
1351315	2025-10-25 00:00:00	121	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	28   	0
1351322	2025-10-25 00:00:00	123	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	28   	0
1351313	2025-10-25 00:00:00	124	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	28   	0
1351316	2025-10-25 00:00:00	128	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	28   	0
1351319	2025-10-25 00:00:00	130	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	28   	0
1351320	2025-10-25 00:00:00	136	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	28   	0
1351321	2025-10-25 00:00:00	154	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	28   	0
1351318	2025-10-25 00:00:00	1062	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	28   	0
1351317	2025-10-25 00:00:00	7848	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	28   	0
1351330	2025-11-05 00:00:00	118	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	29   	0
1351329	2025-11-05 00:00:00	119	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	29   	0
1351323	2025-11-05 00:00:00	127	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	29   	0
1351326	2025-11-05 00:00:00	128	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	29   	0
1351331	2025-11-05 00:00:00	129	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	29   	0
1351325	2025-11-05 00:00:00	131	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	29   	0
1351324	2025-11-05 00:00:00	133	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	29   	0
1351328	2025-11-05 00:00:00	135	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	29   	0
1351332	2025-11-05 00:00:00	152	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	29   	0
1351327	2025-11-05 00:00:00	7848	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	29   	0
1351334	2025-11-19 00:00:00	120	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	30   	0
1351335	2025-11-19 00:00:00	121	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	30   	0
1351342	2025-11-19 00:00:00	123	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	30   	0
1351333	2025-11-19 00:00:00	124	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	30   	0
1351336	2025-11-19 00:00:00	126	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	30   	0
1351339	2025-11-19 00:00:00	130	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	30   	0
1351340	2025-11-19 00:00:00	136	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	30   	0
1351341	2025-11-19 00:00:00	154	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	30   	0
1351337	2025-11-19 00:00:00	794	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	30   	0
1351338	2025-11-19 00:00:00	1062	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	30   	0
1351350	2025-11-22 00:00:00	118	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	31   	0
1351349	2025-11-22 00:00:00	119	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	31   	0
1351343	2025-11-22 00:00:00	127	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	31   	0
1351346	2025-11-22 00:00:00	128	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	31   	0
1351351	2025-11-22 00:00:00	129	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	31   	0
1351345	2025-11-22 00:00:00	131	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	31   	0
1351344	2025-11-22 00:00:00	133	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	31   	0
1351348	2025-11-22 00:00:00	135	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	31   	0
1351352	2025-11-22 00:00:00	152	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	31   	0
1351347	2025-11-22 00:00:00	7848	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	31   	0
1351354	2025-11-29 00:00:00	120	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	32   	0
1351355	2025-11-29 00:00:00	121	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	32   	0
1351362	2025-11-29 00:00:00	123	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	32   	0
1351353	2025-11-29 00:00:00	124	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	32   	0
1351356	2025-11-29 00:00:00	126	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	32   	0
1351361	2025-11-29 00:00:00	129	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	32   	0
1351359	2025-11-29 00:00:00	130	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	32   	0
1351360	2025-11-29 00:00:00	136	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	32   	0
1351357	2025-11-29 00:00:00	794	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	32   	0
1351358	2025-11-29 00:00:00	1062	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	32   	0
1351369	2025-12-03 00:00:00	119	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	33   	0
1351372	2025-12-03 00:00:00	123	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	33   	0
1351366	2025-12-03 00:00:00	126	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	33   	0
1351363	2025-12-03 00:00:00	127	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	33   	0
1351365	2025-12-03 00:00:00	131	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	33   	0
1351364	2025-12-03 00:00:00	133	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	33   	0
1351368	2025-12-03 00:00:00	135	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	33   	0
1351370	2025-12-03 00:00:00	136	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	33   	0
1351371	2025-12-03 00:00:00	154	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	33   	0
1351367	2025-12-03 00:00:00	7848	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	33   	0
1351380	2025-12-06 00:00:00	118	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	34   	0
1351374	2025-12-06 00:00:00	120	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	34   	0
1351373	2025-12-06 00:00:00	124	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	34   	0
1351376	2025-12-06 00:00:00	128	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	34   	0
1351381	2025-12-06 00:00:00	129	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	34   	0
1351379	2025-12-06 00:00:00	130	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	34   	0
1351375	2025-12-06 00:00:00	131	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	34   	0
1351382	2025-12-06 00:00:00	152	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	34   	0
1351377	2025-12-06 00:00:00	794	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	34   	0
1351378	2025-12-06 00:00:00	1062	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	34   	0
1351390	2025-12-10 00:00:00	118	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	35   	0
1351389	2025-12-10 00:00:00	119	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	35   	0
1351384	2025-12-10 00:00:00	120	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	35   	0
1351385	2025-12-10 00:00:00	121	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	35   	0
1351392	2025-12-10 00:00:00	123	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	35   	0
1351386	2025-12-10 00:00:00	126	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	35   	0
1351383	2025-12-10 00:00:00	127	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	35   	0
1351388	2025-12-10 00:00:00	135	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	35   	0
1351391	2025-12-10 00:00:00	154	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	35   	0
1351387	2025-12-10 00:00:00	7848	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	35   	0
1351393	2025-12-13 00:00:00	124	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	36   	0
1351396	2025-12-13 00:00:00	128	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	36   	0
1351401	2025-12-13 00:00:00	129	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	36   	0
1351399	2025-12-13 00:00:00	130	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	36   	0
1351395	2025-12-13 00:00:00	131	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	36   	0
1351394	2025-12-13 00:00:00	133	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	36   	0
1351400	2025-12-13 00:00:00	136	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	36   	0
1351402	2025-12-13 00:00:00	152	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	36   	0
1351397	2025-12-13 00:00:00	794	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	36   	0
1351398	2025-12-13 00:00:00	1062	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	36   	0
1351410	2025-12-17 00:00:00	118	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	37   	0
1351405	2025-12-17 00:00:00	121	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	37   	0
1351406	2025-12-17 00:00:00	126	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	37   	0
1351403	2025-12-17 00:00:00	127	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	37   	0
1351409	2025-12-17 00:00:00	130	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	37   	0
1351404	2025-12-17 00:00:00	133	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	37   	0
1351408	2025-12-17 00:00:00	135	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	37   	0
1351412	2025-12-17 00:00:00	152	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	37   	0
1351411	2025-12-17 00:00:00	154	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	37   	0
1351407	2025-12-17 00:00:00	794	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	37   	0
1351419	2025-12-21 00:00:00	119	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	38   	0
1351414	2025-12-21 00:00:00	120	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	38   	0
1351422	2025-12-21 00:00:00	123	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	38   	0
1351413	2025-12-21 00:00:00	124	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	38   	0
1351416	2025-12-21 00:00:00	128	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	38   	0
1351421	2025-12-21 00:00:00	129	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	38   	0
1351415	2025-12-21 00:00:00	131	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	38   	0
1351420	2025-12-21 00:00:00	136	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	38   	0
1351418	2025-12-21 00:00:00	1062	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	38   	0
1351417	2025-12-21 00:00:00	7848	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	\N	38   	0
1180554	2024-07-27 22:00:00	152	140	1	2	58	42	12	14	5	7	13	18	5	7	1	2	\N	\N	71	\N	20   	1
1180547	2024-07-27 23:00:00	118	119	1	1	51	49	9	12	3	2	12	18	4	2	1	3	\N	\N	71	\N	20   	1
1180552	2024-07-28 00:30:00	154	126	1	0	37	63	11	12	2	1	15	16	3	10	3	4	1	0	71	\N	20   	1
1180545	2024-07-28 22:00:00	130	133	1	0	53	47	20	13	3	1	13	13	8	3	3	4	\N	\N	71	\N	20   	1
1180553	2024-07-28 22:00:00	1193	134	1	2	50	50	21	11	5	4	8	12	12	2	0	2	\N	\N	71	\N	20   	1
1180564	2024-08-03 23:00:00	140	1062	2	1	27	73	13	19	5	3	14	7	5	1	1	2	\N	\N	71	\N	21   	1
1180558	2024-08-04 19:00:00	124	118	1	0	49	51	12	11	6	3	12	10	3	3	3	2	\N	\N	71	\N	21   	1
1180562	2024-08-04 19:00:00	134	130	0	2	75	25	18	9	3	7	12	12	9	0	2	0	\N	\N	71	\N	21   	1
1180355	2024-04-13 21:30:00	119	118	2	1	53	47	17	9	9	4	21	13	6	3	5	3	\N	\N	71	\N	 1   	1
1180358	2024-04-14 00:00:00	124	794	2	2	69	31	26	16	11	8	8	19	13	6	3	4	\N	\N	71	\N	 1   	1
1180360	2024-04-14 19:00:00	131	1062	0	0	48	52	14	8	2	3	16	14	3	3	8	6	0	1	71	\N	 1   	1
1180363	2024-04-14 19:00:00	144	127	1	2	32	68	11	15	4	2	12	12	4	4	5	3	2	0	71	\N	 1   	1
1180357	2024-04-14 21:30:00	136	121	0	1	56	44	13	15	5	4	12	15	3	9	3	5	\N	\N	71	\N	 1   	1
1180371	2024-04-17 22:00:00	794	133	2	1	40	60	17	13	5	3	14	15	4	6	2	1	\N	\N	71	\N	 2   	1
1180374	2024-04-17 23:00:00	152	131	2	0	45	55	16	17	8	2	16	10	6	7	3	1	1	0	71	\N	 2   	1
1180368	2024-04-18 00:30:00	127	126	2	1	47	53	12	10	6	3	19	19	9	1	1	3	\N	\N	71	\N	 2   	1
1180378	2024-04-20 19:00:00	124	133	2	1	58	42	11	21	8	5	16	17	2	7	4	5	\N	\N	71	\N	 3   	1
1180376	2024-04-21 00:00:00	1062	135	3	0	56	44	9	10	4	3	15	17	4	4	2	2	\N	\N	71	\N	 3   	1
1180382	2024-04-21 19:00:00	134	119	1	0	46	54	5	7	0	1	6	6	1	1	1	4	\N	\N	71	\N	 3   	1
1180383	2024-04-21 21:30:00	144	126	0	3	35	65	9	19	1	7	13	9	4	3	5	0	2	0	71	\N	 3   	1
1180393	2024-04-27 21:30:00	1193	1062	0	3	33	67	4	12	1	5	11	17	3	10	4	5	0	1	71	\N	 4   	1
1180388	2024-04-28 14:00:00	127	120	0	2	60	40	15	9	0	3	12	15	8	3	1	4	\N	\N	71	\N	 4   	1
1180394	2024-04-28 21:30:00	152	134	1	1	55	45	15	15	5	6	12	17	4	6	2	2	\N	\N	71	\N	 4   	1
1180391	2024-04-29 23:00:00	126	121	0	0	57	43	16	9	1	3	10	20	6	4	4	3	\N	\N	71	\N	 4   	1
1180401	2024-05-04 21:30:00	794	127	1	1	43	57	18	19	3	6	17	10	8	4	2	2	\N	\N	71	\N	 5   	1
1180402	2024-05-05 19:00:00	134	133	1	0	56	44	26	7	7	1	11	9	6	5	1	0	0	1	71	\N	 5   	1
1180403	2024-05-05 21:30:00	1193	121	0	2	45	55	9	15	1	6	10	11	6	6	2	3	\N	\N	71	\N	 5   	1
1180410	2024-05-12 19:00:00	121	134	0	2	63	37	23	11	5	6	11	17	9	6	4	6	0	1	71	\N	 6   	1
1180407	2024-05-12 21:30:00	118	794	1	0	50	50	8	15	3	5	12	15	6	7	2	3	\N	\N	71	\N	 6   	1
1180411	2024-05-13 23:00:00	126	124	2	1	49	51	15	7	8	2	15	12	7	4	5	3	\N	\N	71	\N	 6   	1
1180418	2024-06-01 21:30:00	124	152	1	1	62	38	17	12	4	4	13	19	5	3	2	4	0	1	71	\N	 7   	1
1180420	2024-06-02 00:00:00	131	120	0	1	53	47	16	9	7	2	7	16	2	5	2	4	\N	\N	71	\N	 7   	1
1180416	2024-06-02 19:00:00	1062	118	1	1	64	36	21	9	4	2	13	9	5	4	6	4	\N	\N	71	\N	 7   	1
1180422	2024-06-02 21:30:00	154	134	1	0	52	48	11	15	4	2	12	17	2	4	3	4	\N	\N	71	\N	 7   	1
1180414	2024-06-09 19:00:00	140	1193	2	5	62	38	23	13	9	7	10	13	6	2	5	6	1	0	71	\N	 6   	1
1180434	2024-06-11 22:00:00	152	136	1	1	60	40	12	18	2	4	16	8	5	4	3	4	\N	\N	71	\N	 8   	1
1180431	2024-06-12 00:30:00	794	1062	1	2	55	45	15	10	5	4	17	18	8	5	5	6	1	1	71	\N	 8   	1
1180428	2024-06-13 23:00:00	127	130	2	1	42	58	16	15	6	5	9	10	4	6	2	4	\N	\N	71	\N	 8   	1
1180430	2024-06-14 00:30:00	121	133	2	0	57	43	28	9	6	2	10	14	10	6	1	2	\N	\N	71	\N	 8   	1
1180438	2024-06-16 00:00:00	124	144	1	2	56	44	9	17	5	7	10	12	3	3	4	1	1	0	71	\N	 9   	1
1180442	2024-06-16 19:00:00	134	127	1	1	48	52	14	9	3	6	11	11	5	9	4	3	1	0	71	\N	 9   	1
1180439	2024-06-16 21:30:00	133	135	0	0	50	50	14	8	4	2	11	11	5	5	2	4	\N	\N	71	\N	 9   	1
1180443	2024-06-16 21:30:00	1193	154	5	0	55	45	21	2	13	0	9	6	5	1	1	3	0	2	71	\N	 9   	1
1180453	2024-06-19 22:00:00	144	140	1	2	50	50	12	19	1	7	10	11	5	1	1	1	1	0	71	\N	10   	1
1180454	2024-06-19 23:00:00	152	133	2	0	55	45	14	6	5	2	13	18	5	4	2	3	0	1	71	\N	10   	1
1180446	2024-06-20 00:30:00	135	124	2	0	35	65	17	9	5	4	16	11	6	5	3	2	\N	\N	71	\N	10   	1
1180448	2024-06-20 23:00:00	127	118	2	1	35	65	14	8	3	3	8	10	6	2	1	1	\N	\N	71	\N	10   	1
1180493	2024-07-03 22:00:00	1193	120	1	2	51	49	11	6	6	4	8	15	7	5	4	1	\N	\N	71	\N	14   	1
1180494	2024-07-03 23:00:00	140	135	1	0	35	65	13	17	6	6	11	7	7	10	4	2	1	0	71	\N	14   	1
1180486	2024-07-04 00:30:00	1062	127	2	4	52	48	11	14	4	8	12	11	4	4	4	2	1	0	71	\N	14   	1
1180485	2024-07-04 22:00:00	130	121	2	2	40	60	14	21	5	5	9	13	5	10	2	3	\N	\N	71	\N	14   	1
1180501	2024-07-06 23:00:00	126	794	2	0	60	40	14	10	4	3	10	9	6	3	2	2	\N	\N	71	\N	15   	1
1180496	2024-07-07 19:00:00	135	131	3	0	47	53	12	15	5	2	22	12	8	8	2	1	\N	\N	71	\N	15   	1
1180495	2024-07-07 21:00:00	119	133	1	2	65	35	14	8	6	6	16	12	4	4	2	2	\N	\N	71	\N	15   	1
1180497	2024-07-07 21:30:00	136	140	2	1	45	55	9	13	3	2	12	18	6	3	1	2	\N	\N	71	\N	15   	1
1180499	2024-07-07 23:30:00	120	1062	3	0	57	43	19	6	8	2	19	12	3	2	2	1	0	1	71	\N	15   	1
1180509	2024-07-10 22:00:00	133	131	2	0	50	50	14	11	3	2	15	10	7	5	3	5	\N	\N	71	\N	16   	1
1180512	2024-07-10 22:00:00	134	118	1	3	52	48	22	7	8	5	13	13	9	2	2	4	\N	\N	71	\N	16   	1
1180508	2024-07-11 23:00:00	127	154	1	2	70	30	21	7	7	2	9	11	9	4	1	1	\N	\N	71	\N	16   	1
1180506	2024-07-12 00:30:00	1062	126	2	1	62	38	14	11	5	4	9	13	2	6	2	1	0	1	71	\N	16   	1
1180516	2024-07-13 19:00:00	135	794	2	1	53	47	10	15	4	5	11	14	1	8	2	2	\N	\N	71	\N	17   	1
1180523	2024-07-17 22:00:00	144	133	0	1	52	48	19	14	7	5	13	11	4	6	2	3	\N	\N	71	\N	17   	1
1180519	2024-07-18 00:30:00	120	121	1	0	43	57	16	18	7	5	20	10	5	4	2	0	\N	\N	71	\N	17   	1
1180528	2024-07-20 19:00:00	127	140	2	1	63	37	15	16	6	4	12	21	7	4	4	9	0	1	71	\N	18   	1
1180525	2024-07-21 14:00:00	130	136	2	0	59	41	13	5	6	0	11	20	7	4	1	7	\N	\N	71	\N	18   	1
1180534	2024-07-21 21:30:00	152	126	0	0	37	63	10	11	0	2	13	17	1	4	4	2	\N	\N	71	\N	18   	1
1180531	2024-07-21 21:30:00	794	134	1	0	35	65	12	19	3	7	6	14	2	11	2	7	1	0	71	\N	18   	1
1180536	2024-07-24 22:00:00	135	152	2	0	55	45	12	7	5	2	14	14	6	5	3	5	0	1	71	\N	19   	1
1180537	2024-07-24 23:00:00	136	127	1	2	43	57	10	8	3	4	9	15	4	8	1	1	\N	\N	71	\N	19   	1
1180543	2024-07-25 00:30:00	144	118	1	1	29	71	15	7	4	2	18	12	8	4	5	4	3	0	71	\N	19   	1
1180555	2024-08-04 20:00:00	119	121	1	1	41	59	16	17	7	5	19	6	4	11	2	0	\N	\N	71	\N	21   	1
1180556	2024-08-06 00:00:00	135	154	1	2	68	32	15	11	7	4	18	17	5	1	4	4	\N	\N	71	\N	21   	1
1180573	2024-08-10 22:00:00	1193	130	1	3	61	39	15	10	3	6	15	7	5	5	1	2	\N	\N	71	\N	22   	1
1180566	2024-08-11 00:30:00	135	1062	0	0	35	65	6	12	1	4	19	12	4	4	3	1	\N	\N	71	\N	22   	1
1180571	2024-08-11 19:00:00	126	144	1	0	45	55	12	13	7	6	15	8	3	2	1	2	\N	\N	71	\N	22   	1
1180565	2024-08-11 22:00:00	119	134	2	2	54	46	23	12	4	5	18	13	9	0	1	2	\N	\N	71	\N	22   	1
1180575	2024-08-17 19:00:00	130	118	0	2	40	60	13	12	5	5	10	10	1	5	3	1	\N	\N	71	\N	23   	1
1180578	2024-08-18 00:00:00	124	131	0	0	56	44	16	8	4	2	10	17	6	2	2	2	\N	\N	71	\N	23   	1
1180584	2024-08-18 19:00:00	140	133	2	2	51	49	19	13	8	4	15	7	9	10	3	2	\N	\N	71	\N	23   	1
1180582	2024-08-18 21:30:00	134	152	1	2	60	40	23	8	7	5	17	10	10	4	4	2	\N	\N	71	\N	23   	1
1180593	2024-08-24 19:00:00	144	152	2	1	40	60	18	13	7	3	17	10	4	5	5	6	1	1	71	\N	24   	1
1180587	2024-08-25 19:00:00	118	120	0	0	53	47	17	14	7	5	19	21	4	7	4	4	\N	\N	71	\N	24   	1
1180592	2024-08-25 19:00:00	154	131	1	0	44	56	8	10	5	3	14	16	3	9	3	3	\N	\N	71	\N	24   	1
1180588	2024-08-25 23:00:00	127	794	2	1	56	44	13	12	7	2	13	12	6	10	1	1	\N	\N	71	\N	24   	1
1180396	2024-08-28 22:30:00	135	119	0	0	69	31	19	1	4	0	12	13	10	3	2	7	0	1	71	\N	 5   	1
1180599	2024-09-01 00:00:00	120	154	2	0	64	36	22	10	7	1	13	8	9	6	3	4	\N	\N	71	\N	25   	1
1180596	2024-09-01 14:00:00	135	144	3	1	49	51	11	17	6	4	13	7	8	3	2	5	\N	\N	71	\N	25   	1
1180602	2024-09-01 21:30:00	134	121	0	2	47	53	15	19	9	10	10	9	4	4	2	1	\N	\N	71	\N	25   	1
1180604	2024-09-01 21:30:00	152	119	1	3	37	63	14	18	5	8	13	17	6	4	1	2	1	0	71	\N	25   	1
1180613	2024-09-14 19:00:00	144	136	0	2	64	36	13	7	4	4	14	14	9	5	3	6	\N	\N	71	\N	26   	1
1180609	2024-09-15 00:00:00	120	131	2	1	57	43	21	12	10	2	12	7	6	3	1	3	\N	\N	71	\N	26   	1
1180611	2024-09-15 19:00:00	794	130	2	2	47	53	23	8	6	4	12	7	6	7	5	1	\N	\N	71	\N	26   	1
1180608	2024-09-15 21:30:00	127	133	1	1	61	39	17	9	3	2	10	10	5	6	0	1	\N	\N	71	\N	26   	1
1180620	2024-09-21 19:00:00	131	144	3	0	61	39	17	14	6	3	7	17	6	1	3	4	\N	\N	71	\N	27   	1
1180618	2024-09-21 21:30:00	124	120	0	1	50	50	13	9	5	6	13	17	5	4	1	1	\N	\N	71	\N	27   	1
1180616	2024-09-22 19:00:00	1062	794	3	0	50	50	13	8	8	3	14	9	4	2	2	3	\N	\N	71	\N	27   	1
1180615	2024-09-22 21:30:00	130	127	3	2	44	56	12	20	3	8	6	13	4	6	1	0	0	1	71	\N	27   	1
1180395	2024-09-25 22:00:00	130	140	1	2	65	35	14	11	3	4	8	12	6	3	2	5	\N	\N	71	\N	 5   	1
1180630	2024-09-28 21:30:00	121	1062	2	1	43	57	15	6	8	3	15	10	7	3	2	2	\N	\N	71	\N	28   	1
1180634	2024-09-29 14:00:00	152	794	1	1	52	48	12	15	6	6	9	19	4	5	1	6	\N	\N	71	\N	28   	1
1180632	2024-09-29 19:00:00	154	1193	1	0	54	46	15	2	6	1	18	9	7	3	2	4	\N	\N	71	\N	28   	1
1180625	2024-09-29 21:30:00	119	136	3	1	54	46	10	7	5	4	26	8	2	6	3	1	\N	\N	71	\N	28   	1
1180644	2024-10-03 22:00:00	140	144	2	0	47	53	17	14	5	3	16	7	7	6	1	4	\N	\N	71	\N	29   	1
1180635	2024-10-05 00:30:00	130	154	3	1	38	62	16	7	6	5	11	9	10	2	2	4	1	1	71	\N	29   	1
1180636	2024-10-05 19:30:00	1062	136	2	2	56	44	14	9	3	3	13	14	2	5	1	0	1	0	71	\N	29   	1
1180640	2024-10-05 22:00:00	131	119	2	2	53	47	15	9	6	3	11	14	9	9	6	4	\N	\N	71	\N	29   	1
1180639	2024-10-06 00:00:00	133	152	1	1	54	46	16	17	3	5	14	13	3	6	1	3	1	0	71	\N	29   	1
1180652	2024-10-17 00:45:00	154	1062	1	1	46	54	14	18	1	5	9	10	7	3	1	3	2	0	71	\N	30   	1
1180653	2024-10-18 22:00:00	144	1193	0	0	60	40	16	6	4	0	17	15	8	4	2	3	\N	\N	71	\N	30   	1
1180646	2024-10-19 00:30:00	135	118	1	1	49	51	11	10	3	4	10	8	5	7	1	2	\N	\N	71	\N	30   	1
1180645	2024-10-19 19:00:00	119	130	1	0	64	36	18	9	6	7	14	15	3	6	1	3	\N	\N	71	\N	30   	1
1180654	2024-10-20 23:00:00	152	121	3	5	53	47	25	14	6	7	15	19	7	5	2	5	\N	\N	71	\N	30   	1
1180539	2024-10-25 22:00:00	133	1193	1	0	49	51	13	13	2	2	16	14	3	2	2	1	\N	\N	71	\N	19   	1
1180658	2024-10-26 19:30:00	127	152	4	2	74	26	20	5	10	3	8	14	8	1	3	5	0	1	71	\N	31   	1
1180662	2024-10-26 21:30:00	134	135	3	0	58	42	19	2	6	0	14	14	7	1	0	3	0	1	71	\N	31   	1
1180664	2024-10-27 01:00:00	140	126	1	1	30	70	10	16	3	3	13	10	6	7	2	0	\N	\N	71	\N	31   	1
1180659	2024-10-29 00:00:00	133	118	3	2	48	52	15	12	8	7	11	9	2	4	3	2	\N	\N	71	\N	31   	1
1180668	2024-11-02 00:00:00	124	130	2	2	62	38	18	7	7	4	15	14	8	2	6	4	1	0	71	\N	32   	1
1180674	2024-11-02 21:30:00	152	154	0	3	60	40	17	11	6	4	7	14	5	3	3	2	\N	\N	71	\N	32   	1
1180665	2024-11-06 00:30:00	119	140	2	0	69	31	20	5	9	4	15	13	7	3	1	2	0	1	71	\N	32   	1
1180666	2024-11-07 00:00:00	135	127	0	1	53	47	15	10	5	2	8	13	7	4	2	7	0	1	71	\N	32   	1
1180680	2024-11-09 00:30:00	121	130	1	0	63	37	33	6	14	1	14	9	14	1	5	3	\N	\N	71	\N	33   	1
1180677	2024-11-09 19:30:00	136	131	1	2	41	59	10	13	2	7	11	11	14	4	4	2	\N	\N	71	\N	33   	1
1180684	2024-11-09 22:00:00	152	118	2	1	39	61	20	8	8	3	11	9	7	2	3	1	\N	\N	71	\N	33   	1
1180681	2024-11-10 00:00:00	126	134	2	1	78	22	10	9	3	3	5	20	5	6	2	5	\N	\N	71	\N	33   	1
1180690	2024-11-20 14:00:00	131	135	2	1	45	55	13	8	9	2	13	15	3	4	3	3	\N	\N	71	\N	34   	1
1180694	2024-11-20 19:30:00	140	136	0	1	49	51	13	14	1	3	11	18	6	5	1	3	1	0	71	\N	34   	1
1180685	2024-11-20 22:00:00	130	152	2	2	56	44	11	11	4	5	17	16	5	4	3	4	\N	\N	71	\N	34   	1
1180686	2024-11-21 00:30:00	1062	120	0	0	30	70	3	27	0	4	9	11	1	10	7	2	1	1	71	\N	34   	1
1180699	2024-11-23 22:30:00	120	136	1	1	73	27	26	10	9	4	10	7	10	0	3	4	1	0	71	\N	35   	1
1180704	2024-11-23 22:30:00	152	1193	1	1	60	40	19	7	4	1	9	7	6	5	0	3	\N	\N	71	\N	35   	1
1180695	2024-11-24 19:00:00	119	794	4	1	55	45	16	5	7	1	16	12	8	4	2	1	\N	\N	71	\N	35   	1
1180698	2024-11-26 22:00:00	124	140	0	0	64	36	19	10	3	3	6	15	9	4	1	2	\N	\N	71	\N	35   	1
1180710	2024-11-27 00:30:00	121	120	1	3	55	45	19	13	5	7	9	16	5	7	2	4	1	0	71	\N	36   	1
1180714	2024-11-30 22:30:00	140	131	2	4	38	62	12	19	4	11	10	8	3	7	2	3	\N	\N	71	\N	36   	1
1180708	2024-12-01 19:00:00	127	119	3	2	56	44	17	13	10	6	14	12	6	4	2	2	\N	\N	71	\N	36   	1
1180712	2024-12-01 21:30:00	134	124	1	1	29	71	16	15	4	4	10	10	3	8	1	2	1	1	71	\N	36   	1
1180720	2024-12-03 23:00:00	131	118	3	0	52	48	18	12	7	2	12	13	7	4	2	4	\N	\N	71	\N	37   	1
1180721	2024-12-04 23:00:00	126	152	1	2	70	30	10	13	2	7	9	15	12	2	0	2	\N	\N	71	\N	37   	1
1180715	2024-12-05 00:30:00	119	120	0	1	67	33	14	2	6	1	9	12	10	1	5	1	\N	\N	71	\N	37   	1
1180723	2024-12-05 00:30:00	144	154	3	1	56	44	26	12	9	4	13	16	5	3	4	3	\N	\N	71	\N	37   	1
1180727	2024-12-08 19:00:00	118	144	2	0	48	52	17	13	5	2	15	11	4	5	3	1	\N	\N	71	\N	38   	1
1180730	2024-12-08 19:00:00	121	124	0	1	58	42	11	7	3	5	14	11	11	2	2	5	\N	\N	71	\N	38   	1
1180734	2024-12-08 19:00:00	152	135	0	1	50	50	21	8	7	1	13	13	8	1	3	4	2	1	71	\N	38   	1
1180731	2024-12-08 19:00:00	794	140	5	1	48	52	18	7	8	4	9	13	6	8	1	3	\N	\N	71	\N	38   	1
1351046	2025-03-29 21:30:00	126	123	0	0	65	35	15	8	3	1	17	21	6	2	0	2	\N	\N	71	\N	 1   	1
1351048	2025-03-29 21:30:00	135	7848	2	1	45	55	8	16	2	6	18	21	2	6	4	3	\N	\N	71	\N	 1   	1
1351043	2025-03-30 00:00:00	127	119	1	1	62	38	19	5	5	1	10	17	4	2	2	4	\N	\N	71	\N	 1   	1
\.


--
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.countries (id, name, code) FROM stdin;
1	Albania	AL
2	Algeria	DZ
3	Andorra	AD
4	Angola	AO
5	Antigua-And-Barbuda	AG
6	Argentina	AR
7	Armenia	AM
8	Aruba	AW
9	Australia	AU
10	Austria	AT
11	Azerbaijan	AZ
12	Bahrain	BH
13	Bangladesh	BD
14	Barbados	BB
15	Belarus	BY
16	Belgium	BE
17	Belize	BZ
18	Benin	BJ
19	Bermuda	BM
20	Bhutan	BT
21	Bolivia	BO
22	Bosnia	BA
23	Botswana	BW
24	Brazil	BR
25	Bulgaria	BG
26	Burkina-Faso	BF
27	Burundi	BI
28	Cambodia	KH
29	Cameroon	CM
30	Canada	CA
31	Chile	CL
32	China	CN
33	Chinese-Taipei	TW
34	Colombia	CO
35	Congo	CD
36	Congo-DR	CG
37	Costa-Rica	CR
38	Crimea	UA
39	Croatia	HR
40	Cuba	CU
41	Curacao	CW
42	Cyprus	CY
43	Czech-Republic	CZ
44	Denmark	DK
45	Dominican-Republic	DO
46	Ecuador	EC
47	Egypt	EG
48	El-Salvador	SV
49	England	GB-ENG
50	Estonia	EE
51	Eswatini	SZ
52	Ethiopia	ET
53	Faroe-Islands	FO
54	Fiji	FJ
55	Finland	FI
56	France	FR
57	Gabon	GA
58	Gambia	GM
59	Georgia	GE
60	Germany	DE
61	Ghana	GH
62	Gibraltar	GI
63	Greece	GR
64	Grenada	GD
65	Guadeloupe	GP
66	Guatemala	GT
67	Guinea	GN
68	Haiti	HT
69	Honduras	HN
70	Hong-Kong	HK
71	Hungary	HU
72	Iceland	IS
73	India	IN
74	Indonesia	ID
75	Iran	IR
76	Iraq	IQ
77	Ireland	IE
78	Israel	IL
79	Italy	IT
80	Ivory-Coast	CI
81	Jamaica	JM
82	Japan	JP
83	Jordan	JO
84	Kazakhstan	KZ
85	Kenya	KE
86	Kosovo	XK
87	Kuwait	KW
88	Kyrgyzstan	KG
89	Laos	LA
90	Latvia	LV
91	Lebanon	LB
92	Lesotho	LS
93	Liberia	LR
94	Libya	LY
95	Liechtenstein	LI
96	Lithuania	LT
97	Luxembourg	LU
98	Macao	MO
99	Macedonia	MK
100	Malawi	MW
101	Malaysia	MY
102	Maldives	MV
103	Mali	ML
104	Malta	MT
105	Mauritania	MR
106	Mauritius	MU
107	Mexico	MX
108	Moldova	MD
109	Mongolia	MN
110	Montenegro	ME
111	Morocco	MA
112	Myanmar	MM
113	Namibia	NA
114	Nepal	NP
115	Netherlands	NL
116	New-Zealand	NZ
117	Nicaragua	NI
118	Nigeria	NG
119	Northern-Ireland	GB-NIR
120	Norway	NO
121	Oman	OM
122	Pakistan	PK
123	Palestine	PS
124	Panama	PA
125	Paraguay	PY
126	Peru	PE
127	Philippines	PH
128	Poland	PL
129	Portugal	PT
130	Qatar	QA
131	Romania	RO
132	Russia	RU
133	Rwanda	RW
134	San-Marino	SM
135	Saudi-Arabia	SA
136	Scotland	GB-SCT
137	Senegal	SN
138	Serbia	RS
139	Singapore	SG
140	Slovakia	SK
141	Slovenia	SI
142	Somalia	SO
143	South-Africa	ZA
144	South-Korea	KR
145	Spain	ES
146	Sudan	SD
147	Suriname	SR
148	Sweden	SE
149	Switzerland	CH
150	Syria	SY
151	Tajikistan	TJ
152	Tanzania	TZ
153	Thailand	TH
154	Togo	TG
155	Trinidad-And-Tobago	TT
156	Tunisia	TN
157	Turkey	TR
158	Turkmenistan	TM
159	Uganda	UG
160	United-Arab-Emirates	AE
161	Uruguay	UY
162	USA	US
163	Uzbekistan	UZ
164	Venezuela	VE
165	Vietnam	VN
166	Wales	GB-WLS
169	World	N/A
170	Yemen	YE
171	Zambia	ZM
172	Zimbabwe	ZW
\.


--
-- Data for Name: leagues; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.leagues (id, name, type, logo, country_id) FROM stdin;
4	Euro Championship	Cup	https://media.api-sports.io/football/leagues/4.png	169
21	Confederations Cup	Cup	https://media.api-sports.io/football/leagues/21.png	169
61	Ligue 1	League	https://media.api-sports.io/football/leagues/61.png	56
144	Jupiler Pro League	League	https://media.api-sports.io/football/leagues/144.png	16
71	Serie A	League	https://media.api-sports.io/football/leagues/71.png	24
39	Premier League	League	https://media.api-sports.io/football/leagues/39.png	49
78	Bundesliga	League	https://media.api-sports.io/football/leagues/78.png	60
135	Serie A	League	https://media.api-sports.io/football/leagues/135.png	79
88	Eredivisie	League	https://media.api-sports.io/football/leagues/88.png	115
94	Primeira Liga	League	https://media.api-sports.io/football/leagues/94.png	129
140	La Liga	League	https://media.api-sports.io/football/leagues/140.png	145
179	Premiership	League	https://media.api-sports.io/football/leagues/179.png	136
180	Championship	League	https://media.api-sports.io/football/leagues/180.png	136
1	World Cup	Cup	https://media.api-sports.io/football/leagues/1.png	169
803	Asian Games	Cup	https://media.api-sports.io/football/leagues/803.png	169
804	Caribbean Cup	Cup	https://media.api-sports.io/football/leagues/804.png	169
62	Ligue 2	League	https://media.api-sports.io/football/leagues/62.png	56
2	UEFA Champions League	Cup	https://media.api-sports.io/football/leagues/2.png	169
311	1st Division	League	https://media.api-sports.io/football/leagues/311.png	1
310	Superliga	League	https://media.api-sports.io/football/leagues/310.png	1
186	Ligue 1	League	https://media.api-sports.io/football/leagues/186.png	2
187	Ligue 2	League	https://media.api-sports.io/football/leagues/187.png	2
571	Vysshaya Liga	League	https://media.api-sports.io/football/leagues/571.png	151
586	West Bank Premier League	League	https://media.api-sports.io/football/leagues/586.png	123
588	National League	League	https://media.api-sports.io/football/leagues/588.png	112
591	Pro League	League	https://media.api-sports.io/football/leagues/591.png	155
335	Cup	Cup	https://media.api-sports.io/football/leagues/335.png	38
336	Druha Liga	League	https://media.api-sports.io/football/leagues/336.png	38
334	Persha Liga	League	https://media.api-sports.io/football/leagues/334.png	38
333	Premier League	League	https://media.api-sports.io/football/leagues/333.png	38
301	Pro League	League	https://media.api-sports.io/football/leagues/301.png	160
303	Division 1	League	https://media.api-sports.io/football/leagues/303.png	160
302	League Cup	Cup	https://media.api-sports.io/football/leagues/302.png	160
269	Segunda División	League	https://media.api-sports.io/football/leagues/269.png	161
202	Ligue 1	League	https://media.api-sports.io/football/leagues/202.png	156
203	Süper Lig	League	https://media.api-sports.io/football/leagues/203.png	157
204	1. Lig	League	https://media.api-sports.io/football/leagues/204.png	157
205	2. Lig	League	https://media.api-sports.io/football/leagues/205.png	157
206	Cup	Cup	https://media.api-sports.io/football/leagues/206.png	157
552	3. Lig - Group 1	League	https://media.api-sports.io/football/leagues/552.png	157
553	3. Lig - Group 2	League	https://media.api-sports.io/football/leagues/553.png	157
554	3. Lig - Group 3	League	https://media.api-sports.io/football/leagues/554.png	157
63	National 1	League	https://media.api-sports.io/football/leagues/63.png	56
66	Coupe de France	Cup	https://media.api-sports.io/football/leagues/66.png	56
65	Coupe de la Ligue	Cup	https://media.api-sports.io/football/leagues/65.png	56
67	National 2 - Group A	League	https://media.api-sports.io/football/leagues/67.png	56
68	National 2 - Group B	League	https://media.api-sports.io/football/leagues/68.png	56
69	National 2 - Group C	League	https://media.api-sports.io/football/leagues/69.png	56
70	National 2 - Group D	League	https://media.api-sports.io/football/leagues/70.png	56
233	Premier League	League	https://media.api-sports.io/football/leagues/233.png	47
370	Primera Division	League	https://media.api-sports.io/football/leagues/370.png	48
328	Esiliiga A	League	https://media.api-sports.io/football/leagues/328.png	50
329	Meistriliiga	League	https://media.api-sports.io/football/leagues/329.png	50
326	Erovnuli Liga 2	League	https://media.api-sports.io/football/leagues/326.png	59
570	Premier League	League	https://media.api-sports.io/football/leagues/570.png	61
377	Division d'Honneur	League	https://media.api-sports.io/football/leagues/377.png	65
339	Liga Nacional	League	https://media.api-sports.io/football/leagues/339.png	66
338	Primera Division	League	https://media.api-sports.io/football/leagues/338.png	66
199	Cup	Cup	https://media.api-sports.io/football/leagues/199.png	63
198	Football League	League	https://media.api-sports.io/football/leagues/198.png	63
197	Super League 1	League	https://media.api-sports.io/football/leagues/197.png	63
79	2. Bundesliga	League	https://media.api-sports.io/football/leagues/79.png	60
80	3. Liga	League	https://media.api-sports.io/football/leagues/80.png	60
529	Super Cup	Cup	https://media.api-sports.io/football/leagues/529.png	60
81	DFB Pokal	Cup	https://media.api-sports.io/football/leagues/81.png	60
7	Asian Cup	Cup	https://media.api-sports.io/football/leagues/7.png	169
8	World Cup - Women	Cup	https://media.api-sports.io/football/leagues/8.png	169
512	2nd Division - Group A	League	https://media.api-sports.io/football/leagues/512.png	1
513	2nd Division - Group B	League	https://media.api-sports.io/football/leagues/513.png	1
312	1a Divisió	League	https://media.api-sports.io/football/leagues/312.png	3
313	2a Divisió	League	https://media.api-sports.io/football/leagues/313.png	3
131	Primera B Metropolitana	League	https://media.api-sports.io/football/leagues/131.png	6
129	Primera Nacional	League	https://media.api-sports.io/football/leagues/129.png	6
132	Primera C	League	https://media.api-sports.io/football/leagues/132.png	6
133	Primera D	League	https://media.api-sports.io/football/leagues/133.png	6
134	Torneo Federal A	League	https://media.api-sports.io/football/leagues/134.png	6
188	A-League	League	https://media.api-sports.io/football/leagues/188.png	9
191	Brisbane Premier League	League	https://media.api-sports.io/football/leagues/191.png	9
193	Northern Territory Premier League	League	https://media.api-sports.io/football/leagues/193.png	9
220	Cup	Cup	https://media.api-sports.io/football/leagues/220.png	10
219	2. Liga	League	https://media.api-sports.io/football/leagues/219.png	10
218	Bundesliga	League	https://media.api-sports.io/football/leagues/218.png	10
418	Birinci Dasta	League	https://media.api-sports.io/football/leagues/418.png	11
419	Premyer Liqa	League	https://media.api-sports.io/football/leagues/419.png	11
222	Regionalliga - Mitte	League	https://media.api-sports.io/football/leagues/222.png	10
221	Regionalliga - Ost	League	https://media.api-sports.io/football/leagues/221.png	10
223	Regionalliga - West	League	https://media.api-sports.io/football/leagues/223.png	10
110	Premier League	League	https://media.api-sports.io/football/leagues/110.png	166
112	Welsh Cup	Cup	https://media.api-sports.io/football/leagues/112.png	166
299	Primera División	League	https://media.api-sports.io/football/leagues/299.png	164
300	Segunda División	League	https://media.api-sports.io/football/leagues/300.png	164
406	Professional League	League	https://media.api-sports.io/football/leagues/406.png	121
322	Premier League	League	https://media.api-sports.io/football/leagues/322.png	81
387	League	League	https://media.api-sports.io/football/leagues/387.png	83
388	1. Division	League	https://media.api-sports.io/football/leagues/388.png	84
330	Premier League	League	https://media.api-sports.io/football/leagues/330.png	87
119	Superliga	League	https://media.api-sports.io/football/leagues/119.png	44
120	1. Division	League	https://media.api-sports.io/football/leagues/120.png	44
124	Denmark Series - Group 1	League	https://media.api-sports.io/football/leagues/124.png	44
125	Denmark Series - Group 2	League	https://media.api-sports.io/football/leagues/125.png	44
126	Denmark Series - Group 3	League	https://media.api-sports.io/football/leagues/126.png	44
234	Liga Nacional	League	https://media.api-sports.io/football/leagues/234.png	69
381	HKFA 1st Division	League	https://media.api-sports.io/football/leagues/381.png	70
380	Premier League	League	https://media.api-sports.io/football/leagues/380.png	70
273	Magyar Kupa	Cup	https://media.api-sports.io/football/leagues/273.png	71
271	NB I	League	https://media.api-sports.io/football/leagues/271.png	71
272	NB II	League	https://media.api-sports.io/football/leagues/272.png	71
390	Premier League	League	https://media.api-sports.io/football/leagues/390.png	91
261	National Division	League	https://media.api-sports.io/football/leagues/261.png	97
306	Second Division	League	https://media.api-sports.io/football/leagues/306.png	130
305	Stars League	League	https://media.api-sports.io/football/leagues/305.png	130
40	Championship	League	https://media.api-sports.io/football/leagues/40.png	49
46	EFL Trophy	Cup	https://media.api-sports.io/football/leagues/46.png	49
45	FA Cup	Cup	https://media.api-sports.io/football/leagues/45.png	49
47	FA Trophy	Cup	https://media.api-sports.io/football/leagues/47.png	49
48	League Cup	Cup	https://media.api-sports.io/football/leagues/48.png	49
43	National League	League	https://media.api-sports.io/football/leagues/43.png	49
41	League One	League	https://media.api-sports.io/football/leagues/41.png	49
42	League Two	League	https://media.api-sports.io/football/leagues/42.png	49
568	Eerste Divisie	League	https://media.api-sports.io/football/leagues/568.png	147
15	FIFA Club World Cup	Cup	https://media.api-sports.io/football/leagues/15.png	169
422	Premier League	League	https://media.api-sports.io/football/leagues/422.png	14
480	Olympics Men	Cup	https://media.api-sports.io/football/leagues/480.png	169
535	CECAFA Senior Challenge Cup	Cup	https://media.api-sports.io/football/leagues/535.png	169
72	Serie B	League	https://media.api-sports.io/football/leagues/72.png	24
75	Serie C	League	https://media.api-sports.io/football/leagues/75.png	24
76	Serie D	League	https://media.api-sports.io/football/leagues/76.png	24
585	Premier League	League	https://media.api-sports.io/football/leagues/585.png	159
598	Première Division	League	https://media.api-sports.io/football/leagues/598.png	103
253	Major League Soccer	League	https://media.api-sports.io/football/leagues/253.png	162
257	US Open Cup	Cup	https://media.api-sports.io/football/leagues/257.png	162
268	Primera División - Apertura	League	https://media.api-sports.io/football/leagues/268.png	161
270	Primera División - Clausura	League	https://media.api-sports.io/football/leagues/270.png	161
369	Super League	League	https://media.api-sports.io/football/leagues/369.png	163
296	Thai League 1	League	https://media.api-sports.io/football/leagues/296.png	153
297	Thai League 2	League	https://media.api-sports.io/football/leagues/297.png	153
551	Super Cup	Cup	https://media.api-sports.io/football/leagues/551.png	157
366	1. Deild	League	https://media.api-sports.io/football/leagues/366.png	53
367	Meistaradeildin	League	https://media.api-sports.io/football/leagues/367.png	53
245	Ykkönen	League	https://media.api-sports.io/football/leagues/245.png	55
244	Veikkausliiga	League	https://media.api-sports.io/football/leagues/244.png	55
246	Suomen Cup	Cup	https://media.api-sports.io/football/leagues/246.png	55
247	Kakkonen - Lohko A	League	https://media.api-sports.io/football/leagues/247.png	55
248	Kakkonen - Lohko B	League	https://media.api-sports.io/football/leagues/248.png	55
249	Kakkonen - Lohko C	League	https://media.api-sports.io/football/leagues/249.png	55
526	Trophée des Champions	Cup	https://media.api-sports.io/football/leagues/526.png	56
242	Liga Pro	League	https://media.api-sports.io/football/leagues/242.png	46
243	Liga Pro Serie B	League	https://media.api-sports.io/football/leagues/243.png	46
539	Super Cup	Cup	https://media.api-sports.io/football/leagues/539.png	47
397	Girabola	League	https://media.api-sports.io/football/leagues/397.png	4
343	First League	League	https://media.api-sports.io/football/leagues/343.png	7
342	Premier League	League	https://media.api-sports.io/football/leagues/342.png	7
481	Northern NSW NPL	League	https://media.api-sports.io/football/leagues/481.png	9
116	Premier League	League	https://media.api-sports.io/football/leagues/116.png	15
117	1. Division	League	https://media.api-sports.io/football/leagues/117.png	15
118	2. Division	League	https://media.api-sports.io/football/leagues/118.png	15
400	Super League	League	https://media.api-sports.io/football/leagues/400.png	171
340	V.League 1	League	https://media.api-sports.io/football/leagues/340.png	165
102	Emperor Cup	Cup	https://media.api-sports.io/football/leagues/102.png	82
101	J-League Cup	Cup	https://media.api-sports.io/football/leagues/101.png	82
98	J1 League	League	https://media.api-sports.io/football/leagues/98.png	82
99	J2 League	League	https://media.api-sports.io/football/leagues/99.png	82
100	J3 League	League	https://media.api-sports.io/football/leagues/100.png	82
389	Premier League	League	https://media.api-sports.io/football/leagues/389.png	84
276	FKF Premier League	League	https://media.api-sports.io/football/leagues/276.png	85
121	DBU Pokalen	Cup	https://media.api-sports.io/football/leagues/121.png	44
379	Ligue Haïtienne	League	https://media.api-sports.io/football/leagues/379.png	68
364	1. Liga	League	https://media.api-sports.io/football/leagues/364.png	90
365	Virsliga	League	https://media.api-sports.io/football/leagues/365.png	90
361	1 Lyga	League	https://media.api-sports.io/football/leagues/361.png	96
362	A Lyga	League	https://media.api-sports.io/football/leagues/362.png	96
528	Community Shield	Cup	https://media.api-sports.io/football/leagues/528.png	49
505	League Cup	Cup	https://media.api-sports.io/football/leagues/505.png	139
28	SAFF Championship	Cup	https://media.api-sports.io/football/leagues/28.png	169
421	Division di Honor	League	https://media.api-sports.io/football/leagues/421.png	8
420	Cup	Cup	https://media.api-sports.io/football/leagues/420.png	11
298	FA Cup	Cup	https://media.api-sports.io/football/leagues/298.png	153
376	National Football League	League	https://media.api-sports.io/football/leagues/376.png	54
64	Feminine Division 1	League	https://media.api-sports.io/football/leagues/64.png	56
3	UEFA Europa League	Cup	https://media.api-sports.io/football/leagues/3.png	169
327	Erovnuli Liga	League	https://media.api-sports.io/football/leagues/327.png	59
378	Ligue 1	League	https://media.api-sports.io/football/leagues/378.png	67
37	World Cup - Qualification Intercontinental Play-offs	Cup	https://media.api-sports.io/football/leagues/37.png	169
520	Acreano	League	https://media.api-sports.io/football/leagues/520.png	24
807	AFC Challenge Cup	Cup	https://media.api-sports.io/football/leagues/807.png	169
547	Super Cup	Cup	https://media.api-sports.io/football/leagues/547.png	79
19	African Nations Championship	Cup	https://media.api-sports.io/football/leagues/19.png	169
24	AFF Championship	Cup	https://media.api-sports.io/football/leagues/24.png	169
128	Liga Profesional Argentina	League	https://media.api-sports.io/football/leagues/128.png	6
183	League One	League	https://media.api-sports.io/football/leagues/183.png	136
184	League Two	League	https://media.api-sports.io/football/leagues/184.png	136
22	CONCACAF Gold Cup	Cup	https://media.api-sports.io/football/leagues/22.png	169
23	EAFF E-1 Football Championship	Cup	https://media.api-sports.io/football/leagues/23.png	169
27	OFC Champions League	Cup	https://media.api-sports.io/football/leagues/27.png	169
519	Super Cup	Cup	https://media.api-sports.io/football/leagues/519.png	16
527	Super Cup	Cup	https://media.api-sports.io/football/leagues/527.png	31
6	Africa Cup of Nations	Cup	https://media.api-sports.io/football/leagues/6.png	169
9	Copa America	Cup	https://media.api-sports.io/football/leagues/9.png	169
925	Super Cup	Cup	https://media.api-sports.io/football/leagues/925.png	43
255	USL Championship	League	https://media.api-sports.io/football/leagues/255.png	162
363	Premier League	League	https://media.api-sports.io/football/leagues/363.png	52
122	2nd Division - Group 1	League	https://media.api-sports.io/football/leagues/122.png	44
123	2nd Division - Group 2	League	https://media.api-sports.io/football/leagues/123.png	44
567	Ligi kuu Bara	League	https://media.api-sports.io/football/leagues/567.png	152
550	Super Cup	Cup	https://media.api-sports.io/football/leagues/550.png	129
555	Supercupa	Cup	https://media.api-sports.io/football/leagues/555.png	131
556	Super Cup	Cup	https://media.api-sports.io/football/leagues/556.png	145
497	Japan Football League	League	https://media.api-sports.io/football/leagues/497.png	82
127	Denmark Series - Group 4	League	https://media.api-sports.io/football/leagues/127.png	44
563	Ettan - Norra	League	https://media.api-sports.io/football/leagues/563.png	148
564	Ettan - Södra	League	https://media.api-sports.io/football/leagues/564.png	148
317	1st League - RS	League	https://media.api-sports.io/football/leagues/317.png	22
316	1st League - FBiH	League	https://media.api-sports.io/football/leagues/316.png	22
295	K3 League	League	https://media.api-sports.io/football/leagues/295.png	144
495	Hazfi Cup	Cup	https://media.api-sports.io/football/leagues/495.png	75
496	Liga Alef	League	https://media.api-sports.io/football/leagues/496.png	78
506	2. liga	League	https://media.api-sports.io/football/leagues/506.png	140
514	Coupe Nationale	Cup	https://media.api-sports.io/football/leagues/514.png	2
521	Amapaense	League	https://media.api-sports.io/football/leagues/521.png	24
522	Amazonense	League	https://media.api-sports.io/football/leagues/522.png	24
524	Olympics Women	Cup	https://media.api-sports.io/football/leagues/524.png	169
531	UEFA Super Cup	Cup	https://media.api-sports.io/football/leagues/531.png	169
543	Super Cup	Cup	https://media.api-sports.io/football/leagues/543.png	115
166	2. Deild	League	https://media.api-sports.io/football/leagues/166.png	72
368	Premier League	League	https://media.api-sports.io/football/leagues/368.png	139
314	Cup	Cup	https://media.api-sports.io/football/leagues/314.png	22
315	Premijer Liga	League	https://media.api-sports.io/football/leagues/315.png	22
371	First League	League	https://media.api-sports.io/football/leagues/371.png	99
382	Liga Leumit	League	https://media.api-sports.io/football/leagues/382.png	78
383	Ligat Ha'al	League	https://media.api-sports.io/football/leagues/383.png	78
386	Ligue 1	League	https://media.api-sports.io/football/leagues/386.png	80
392	Challenge League	League	https://media.api-sports.io/football/leagues/392.png	104
393	Premier League	League	https://media.api-sports.io/football/leagues/393.png	104
394	Super Liga	League	https://media.api-sports.io/football/leagues/394.png	108
396	Primera Division	League	https://media.api-sports.io/football/leagues/396.png	117
96	Taça de Portugal	Cup	https://media.api-sports.io/football/leagues/96.png	129
399	NPFL	League	https://media.api-sports.io/football/leagues/399.png	118
401	Premier Soccer League	League	https://media.api-sports.io/football/leagues/401.png	172
402	Sudani Premier League	League	https://media.api-sports.io/football/leagues/402.png	146
403	Ligue 1	League	https://media.api-sports.io/football/leagues/403.png	137
404	Campionato	League	https://media.api-sports.io/football/leagues/404.png	134
411	Elite One	League	https://media.api-sports.io/football/leagues/411.png	29
410	C-League	League	https://media.api-sports.io/football/leagues/410.png	28
417	Premier League	League	https://media.api-sports.io/football/leagues/417.png	12
415	Championnat National	League	https://media.api-sports.io/football/leagues/415.png	18
414	Premier League	League	https://media.api-sports.io/football/leagues/414.png	19
413	Super League	League	https://media.api-sports.io/football/leagues/413.png	20
412	Premier League	League	https://media.api-sports.io/football/leagues/412.png	23
398	Premier League	League	https://media.api-sports.io/football/leagues/398.png	13
16	CONCACAF Champions League	Cup	https://media.api-sports.io/football/leagues/16.png	169
17	AFC Champions League	Cup	https://media.api-sports.io/football/leagues/17.png	169
25	Gulf Cup of Nations	Cup	https://media.api-sports.io/football/leagues/25.png	169
26	International Champions Cup	Cup	https://media.api-sports.io/football/leagues/26.png	169
141	Segunda División	League	https://media.api-sports.io/football/leagues/141.png	145
136	Serie B	League	https://media.api-sports.io/football/leagues/136.png	79
103	Eliteserien	League	https://media.api-sports.io/football/leagues/103.png	120
89	Eerste Divisie	League	https://media.api-sports.io/football/leagues/89.png	115
95	Segunda Liga	League	https://media.api-sports.io/football/leagues/95.png	129
113	Allsvenskan	League	https://media.api-sports.io/football/leagues/113.png	148
162	Primera División	League	https://media.api-sports.io/football/leagues/162.png	37
164	Úrvalsdeild	League	https://media.api-sports.io/football/leagues/164.png	72
169	Super League	League	https://media.api-sports.io/football/leagues/169.png	32
137	Coppa Italia	Cup	https://media.api-sports.io/football/leagues/137.png	79
200	Botola Pro	League	https://media.api-sports.io/football/leagues/200.png	111
207	Super League	League	https://media.api-sports.io/football/leagues/207.png	149
210	HNL	League	https://media.api-sports.io/football/leagues/210.png	39
235	Premier League	League	https://media.api-sports.io/football/leagues/235.png	132
239	Primera A	League	https://media.api-sports.io/football/leagues/239.png	34
250	Division Profesional - Apertura	League	https://media.api-sports.io/football/leagues/250.png	125
73	Copa Do Brasil	Cup	https://media.api-sports.io/football/leagues/73.png	24
90	KNVB Beker	Cup	https://media.api-sports.io/football/leagues/90.png	115
145	Challenger Pro League	League	https://media.api-sports.io/football/leagues/145.png	16
173	Second League	League	https://media.api-sports.io/football/leagues/173.png	25
170	League One	League	https://media.api-sports.io/football/leagues/170.png	32
189	Capital Territory NPL	League	https://media.api-sports.io/football/leagues/189.png	9
240	Primera B	League	https://media.api-sports.io/football/leagues/240.png	34
211	First NL	League	https://media.api-sports.io/football/leagues/211.png	39
138	Serie C - Girone A	League	https://media.api-sports.io/football/leagues/138.png	79
146	Super League Women	League	https://media.api-sports.io/football/leagues/146.png	16
74	Brasileiro Women	League	https://media.api-sports.io/football/leagues/74.png	24
44	FA WSL	League	https://media.api-sports.io/football/leagues/44.png	49
82	Frauen Bundesliga	League	https://media.api-sports.io/football/leagues/82.png	60
139	Serie A Women	League	https://media.api-sports.io/football/leagues/139.png	79
91	Eredivisie Women	League	https://media.api-sports.io/football/leagues/91.png	115
142	Primera División Femenina	League	https://media.api-sports.io/football/leagues/142.png	145
130	Copa Argentina	Cup	https://media.api-sports.io/football/leagues/130.png	6
190	A-League Women	League	https://media.api-sports.io/football/leagues/190.png	9
236	First League	League	https://media.api-sports.io/football/leagues/236.png	132
165	1. Deild	League	https://media.api-sports.io/football/leagues/165.png	72
251	Division Intermedia	League	https://media.api-sports.io/football/leagues/251.png	125
104	1. Division	League	https://media.api-sports.io/football/leagues/104.png	120
114	Superettan	League	https://media.api-sports.io/football/leagues/114.png	148
208	Challenge League	League	https://media.api-sports.io/football/leagues/208.png	149
262	Liga MX	League	https://media.api-sports.io/football/leagues/262.png	107
263	Liga de Expansión MX	League	https://media.api-sports.io/football/leagues/263.png	107
259	Canadian Championship	Cup	https://media.api-sports.io/football/leagues/259.png	30
278	Super League	League	https://media.api-sports.io/football/leagues/278.png	101
279	Premier League	League	https://media.api-sports.io/football/leagues/279.png	101
280	Premiership	League	https://media.api-sports.io/football/leagues/280.png	116
281	Primera División	League	https://media.api-sports.io/football/leagues/281.png	126
282	Segunda División	League	https://media.api-sports.io/football/leagues/282.png	126
283	Liga I	League	https://media.api-sports.io/football/leagues/283.png	131
284	Liga II	League	https://media.api-sports.io/football/leagues/284.png	131
286	Super Liga	League	https://media.api-sports.io/football/leagues/286.png	138
287	Prva Liga	League	https://media.api-sports.io/football/leagues/287.png	138
288	Premier Soccer League	League	https://media.api-sports.io/football/leagues/288.png	143
289	1st Division	League	https://media.api-sports.io/football/leagues/289.png	143
290	Persian Gulf Pro League	League	https://media.api-sports.io/football/leagues/290.png	75
291	Azadegan League	League	https://media.api-sports.io/football/leagues/291.png	75
292	K League 1	League	https://media.api-sports.io/football/leagues/292.png	144
293	K League 2	League	https://media.api-sports.io/football/leagues/293.png	144
307	Pro League	League	https://media.api-sports.io/football/leagues/307.png	135
308	Division 1	League	https://media.api-sports.io/football/leagues/308.png	135
309	Division 2	League	https://media.api-sports.io/football/leagues/309.png	135
252	Division Profesional - Clausura	League	https://media.api-sports.io/football/leagues/252.png	125
569	Premier League	League	https://media.api-sports.io/football/leagues/569.png	88
592	Division 2 - Norra Götaland	League	https://media.api-sports.io/football/leagues/592.png	148
593	Division 2 - Norra Svealand	League	https://media.api-sports.io/football/leagues/593.png	148
594	Division 2 - Norrland	League	https://media.api-sports.io/football/leagues/594.png	148
595	Division 2 - Södra Svealand	League	https://media.api-sports.io/football/leagues/595.png	148
596	Division 2 - Västra Götaland	League	https://media.api-sports.io/football/leagues/596.png	148
597	Division 2 - Östra Götaland	League	https://media.api-sports.io/football/leagues/597.png	148
511	Cup	Cup	https://media.api-sports.io/football/leagues/511.png	156
488	U19 Bundesliga	League	https://media.api-sports.io/football/leagues/488.png	60
805	Copa Centroamericana	Cup	https://media.api-sports.io/football/leagues/805.png	169
806	OFC Nations Cup	Cup	https://media.api-sports.io/football/leagues/806.png	169
766	China Cup	Cup	https://media.api-sports.io/football/leagues/766.png	169
827	Crown Prince Cup	Cup	https://media.api-sports.io/football/leagues/827.png	135
372	Second League	League	https://media.api-sports.io/football/leagues/372.png	99
174	Cup	Cup	https://media.api-sports.io/football/leagues/174.png	25
10	Friendlies	Cup	https://media.api-sports.io/football/leagues/10.png	169
14	UEFA Youth League	League	https://media.api-sports.io/football/leagues/14.png	169
18	AFC Cup	Cup	https://media.api-sports.io/football/leagues/18.png	169
20	CAF Confederation Cup	Cup	https://media.api-sports.io/football/leagues/20.png	169
559	League Cup	Cup	https://media.api-sports.io/football/leagues/559.png	119
560	Presidents Cup	Cup	https://media.api-sports.io/football/leagues/560.png	160
561	Premier Intermediate League	League	https://media.api-sports.io/football/leagues/561.png	119
407	Championship	League	https://media.api-sports.io/football/leagues/407.png	119
408	Premiership	League	https://media.api-sports.io/football/leagues/408.png	119
331	Division 1	League	https://media.api-sports.io/football/leagues/331.png	87
38	UEFA U21 Championship	Cup	https://media.api-sports.io/football/leagues/38.png	169
425	Premier League	League	https://media.api-sports.io/football/leagues/425.png	150
77	Alagoano	Cup	https://media.api-sports.io/football/leagues/77.png	24
337	Druha Liga - Group B	League	https://media.api-sports.io/football/leagues/337.png	38
185	League Cup	Cup	https://media.api-sports.io/football/leagues/185.png	136
490	World Cup - U20	Cup	https://media.api-sports.io/football/leagues/490.png	169
492	Tweede Divisie	League	https://media.api-sports.io/football/leagues/492.png	115
498	Cup	Cup	https://media.api-sports.io/football/leagues/498.png	84
504	King's Cup	Cup	https://media.api-sports.io/football/leagues/504.png	135
507	Cup	Cup	https://media.api-sports.io/football/leagues/507.png	143
508	League Cup	Cup	https://media.api-sports.io/football/leagues/508.png	143
510	1. Liga Promotion	League	https://media.api-sports.io/football/leagues/510.png	149
584	Premier League	League	https://media.api-sports.io/football/leagues/584.png	94
589	Taiwan Football Premier League	League	https://media.api-sports.io/football/leagues/589.png	33
258	Canadian Soccer League	League	https://media.api-sports.io/football/leagues/258.png	30
274	Liga 1	League	https://media.api-sports.io/football/leagues/274.png	74
304	Liga Panameña de Fútbol	League	https://media.api-sports.io/football/leagues/304.png	124
106	Ekstraklasa	League	https://media.api-sports.io/football/leagues/106.png	128
172	First League	League	https://media.api-sports.io/football/leagues/172.png	25
5	UEFA Nations League	Cup	https://media.api-sports.io/football/leagues/5.png	169
163	Liga de Ascenso	League	https://media.api-sports.io/football/leagues/163.png	37
111	FAW Championship	League	https://media.api-sports.io/football/leagues/111.png	166
265	Primera División	League	https://media.api-sports.io/football/leagues/265.png	31
266	Primera B	League	https://media.api-sports.io/football/leagues/266.png	31
277	Super League	League	https://media.api-sports.io/football/leagues/277.png	85
318	1. Division	League	https://media.api-sports.io/football/leagues/318.png	42
319	2. Division	League	https://media.api-sports.io/football/leagues/319.png	42
320	3. Division	League	https://media.api-sports.io/football/leagues/320.png	42
201	Botola 2	League	https://media.api-sports.io/football/leagues/201.png	111
323	Indian Super League	League	https://media.api-sports.io/football/leagues/323.png	73
324	I-League	League	https://media.api-sports.io/football/leagues/324.png	73
107	I Liga	League	https://media.api-sports.io/football/leagues/107.png	128
332	Super Liga	League	https://media.api-sports.io/football/leagues/332.png	140
345	Czech Liga	League	https://media.api-sports.io/football/leagues/345.png	43
346	FNL	League	https://media.api-sports.io/football/leagues/346.png	43
355	First League	League	https://media.api-sports.io/football/leagues/355.png	110
356	Second League	League	https://media.api-sports.io/football/leagues/356.png	110
344	Primera División	League	https://media.api-sports.io/football/leagues/344.png	21
256	USL League Two	League	https://media.api-sports.io/football/leagues/256.png	162
544	FA Cup	Cup	https://media.api-sports.io/football/leagues/544.png	70
545	AIFF Super Cup	Cup	https://media.api-sports.io/football/leagues/545.png	73
557	Super Cup	Cup	https://media.api-sports.io/football/leagues/557.png	120
808	CONCACAF Nations League - Qualification	Cup	https://media.api-sports.io/football/leagues/808.png	169
373	1. SNL	League	https://media.api-sports.io/football/leagues/373.png	141
374	2. SNL	League	https://media.api-sports.io/football/leagues/374.png	141
391	Super League	League	https://media.api-sports.io/football/leagues/391.png	100
143	Copa del Rey	Cup	https://media.api-sports.io/football/leagues/143.png	145
405	National Soccer League	League	https://media.api-sports.io/football/leagues/405.png	133
409	Premier League	League	https://media.api-sports.io/football/leagues/409.png	113
416	Premier League	League	https://media.api-sports.io/football/leagues/416.png	17
212	Cup	Cup	https://media.api-sports.io/football/leagues/212.png	39
384	State Cup	Cup	https://media.api-sports.io/football/leagues/384.png	78
285	Cupa României	Cup	https://media.api-sports.io/football/leagues/285.png	131
321	Cup	Cup	https://media.api-sports.io/football/leagues/321.png	42
31	World Cup - Qualification CONCACAF	Cup	https://media.api-sports.io/football/leagues/31.png	169
32	World Cup - Qualification Europe	Cup	https://media.api-sports.io/football/leagues/32.png	169
33	World Cup - Qualification Oceania	Cup	https://media.api-sports.io/football/leagues/33.png	169
34	World Cup - Qualification South America	Cup	https://media.api-sports.io/football/leagues/34.png	169
29	World Cup - Qualification Africa	Cup	https://media.api-sports.io/football/leagues/29.png	169
30	World Cup - Qualification Asia	Cup	https://media.api-sports.io/football/leagues/30.png	169
942	Serie C - Girone B	League	https://media.api-sports.io/football/leagues/942.png	79
943	Serie C - Girone C	League	https://media.api-sports.io/football/leagues/943.png	79
530	Super Cup	Cup	https://media.api-sports.io/football/leagues/530.png	59
718	Piala Indonesia	Cup	https://media.api-sports.io/football/leagues/718.png	74
149	Second Amateur Division - VFV A	League	https://media.api-sports.io/football/leagues/149.png	16
150	Second Amateur Division - VFV B	League	https://media.api-sports.io/football/leagues/150.png	16
151	Third Amateur Division - VFV A	League	https://media.api-sports.io/football/leagues/151.png	16
152	Third Amateur Division - VFV B	League	https://media.api-sports.io/football/leagues/152.png	16
175	Third League - Northeast	League	https://media.api-sports.io/football/leagues/175.png	25
176	Third League - Northwest	League	https://media.api-sports.io/football/leagues/176.png	25
177	Third League - Southeast	League	https://media.api-sports.io/football/leagues/177.png	25
178	Third League - Southwest	League	https://media.api-sports.io/football/leagues/178.png	25
49	National League - Play-offs	League	https://media.api-sports.io/football/leagues/49.png	49
491	Løgmanssteypid	Cup	https://media.api-sports.io/football/leagues/491.png	53
493	UEFA U19 Championship	Cup	https://media.api-sports.io/football/leagues/493.png	169
499	Malaysia Cup	Cup	https://media.api-sports.io/football/leagues/499.png	101
516	Super Cup	Cup	https://media.api-sports.io/football/leagues/516.png	2
537	CONCACAF U20	Cup	https://media.api-sports.io/football/leagues/537.png	169
224	Landesliga - Burgenland	League	https://media.api-sports.io/football/leagues/224.png	10
225	Landesliga - Karnten	League	https://media.api-sports.io/football/leagues/225.png	10
226	Landesliga - Niederosterreich	League	https://media.api-sports.io/football/leagues/226.png	10
227	Landesliga - Oberosterreich	League	https://media.api-sports.io/football/leagues/227.png	10
228	Landesliga - Salzburg	League	https://media.api-sports.io/football/leagues/228.png	10
229	Landesliga - Steiermark	League	https://media.api-sports.io/football/leagues/229.png	10
230	Landesliga - Tirol	League	https://media.api-sports.io/football/leagues/230.png	10
231	Landesliga - Vorarlbergliga	League	https://media.api-sports.io/football/leagues/231.png	10
232	Landesliga - Wien	League	https://media.api-sports.io/football/leagues/232.png	10
294	FA Cup	Cup	https://media.api-sports.io/football/leagues/294.png	144
148	Second Amateur Division - ACFF	League	https://media.api-sports.io/football/leagues/148.png	16
153	Provincial - Antwerpen	League	https://media.api-sports.io/football/leagues/153.png	16
154	Provincial - Brabant VFV	League	https://media.api-sports.io/football/leagues/154.png	16
155	Provincial - Hainaut	League	https://media.api-sports.io/football/leagues/155.png	16
156	Provincial - Liege	League	https://media.api-sports.io/football/leagues/156.png	16
157	Provincial - Limburg	League	https://media.api-sports.io/football/leagues/157.png	16
158	Provincial - Luxembourg	League	https://media.api-sports.io/football/leagues/158.png	16
159	Provincial - Namur	League	https://media.api-sports.io/football/leagues/159.png	16
160	Provincial - Oost-Vlaanderen	League	https://media.api-sports.io/football/leagues/160.png	16
161	Provincial - West-Vlaanderen	League	https://media.api-sports.io/football/leagues/161.png	16
423	Ligue 1	League	https://media.api-sports.io/football/leagues/423.png	26
424	Ligue 1	League	https://media.api-sports.io/football/leagues/424.png	36
213	Third NL - Istok	League	https://media.api-sports.io/football/leagues/213.png	39
214	Third NL - Jug	League	https://media.api-sports.io/football/leagues/214.png	39
215	Third NL - Sjever	League	https://media.api-sports.io/football/leagues/215.png	39
216	Third NL - Sredite	League	https://media.api-sports.io/football/leagues/216.png	39
217	Third NL - Zapad	League	https://media.api-sports.io/football/leagues/217.png	39
348	3. liga - CFL A	League	https://media.api-sports.io/football/leagues/348.png	43
349	3. liga - MSFL	League	https://media.api-sports.io/football/leagues/349.png	43
350	4. liga - Divizie A	League	https://media.api-sports.io/football/leagues/350.png	43
351	4. liga - Divizie B	League	https://media.api-sports.io/football/leagues/351.png	43
352	4. liga - Divizie C	League	https://media.api-sports.io/football/leagues/352.png	43
353	4. liga - Divizie D	League	https://media.api-sports.io/football/leagues/353.png	43
354	4. liga - Divizie E	League	https://media.api-sports.io/football/leagues/354.png	43
50	National League - North	League	https://media.api-sports.io/football/leagues/50.png	49
51	National League - South	League	https://media.api-sports.io/football/leagues/51.png	49
52	Non League Div One - Isthmian North	League	https://media.api-sports.io/football/leagues/52.png	49
53	Non League Div One - Isthmian South Central	League	https://media.api-sports.io/football/leagues/53.png	49
54	Non League Div One - Northern West	League	https://media.api-sports.io/football/leagues/54.png	49
55	Non League Div One - Northern Midlands	League	https://media.api-sports.io/football/leagues/55.png	49
56	Non League Div One - Southern South	League	https://media.api-sports.io/football/leagues/56.png	49
57	Non League Div One - Isthmian South East	League	https://media.api-sports.io/football/leagues/57.png	49
58	Non League Premier - Isthmian	League	https://media.api-sports.io/football/leagues/58.png	49
59	Non League Premier - Northern	League	https://media.api-sports.io/football/leagues/59.png	49
60	Non League Premier - Southern South	League	https://media.api-sports.io/football/leagues/60.png	49
92	Derde Divisie - Saturday	League	https://media.api-sports.io/football/leagues/92.png	115
93	Derde Divisie - Sunday	League	https://media.api-sports.io/football/leagues/93.png	115
109	II Liga - East	League	https://media.api-sports.io/football/leagues/109.png	128
341	Cup	Cup	https://media.api-sports.io/football/leagues/341.png	165
238	Youth Championship	League	https://media.api-sports.io/football/leagues/238.png	132
83	Regionalliga - Bayern	League	https://media.api-sports.io/football/leagues/83.png	60
84	Regionalliga - Nord	League	https://media.api-sports.io/football/leagues/84.png	60
85	Regionalliga - Nordost	League	https://media.api-sports.io/football/leagues/85.png	60
86	Regionalliga - SudWest	League	https://media.api-sports.io/football/leagues/86.png	60
87	Regionalliga - West	League	https://media.api-sports.io/football/leagues/87.png	60
426	Serie D - Girone A	League	https://media.api-sports.io/football/leagues/426.png	79
427	Serie D - Girone B	League	https://media.api-sports.io/football/leagues/427.png	79
428	Serie D - Girone C	League	https://media.api-sports.io/football/leagues/428.png	79
429	Serie D - Girone D	League	https://media.api-sports.io/football/leagues/429.png	79
430	Serie D - Girone E	League	https://media.api-sports.io/football/leagues/430.png	79
431	Serie D - Girone F	League	https://media.api-sports.io/football/leagues/431.png	79
432	Serie D - Girone G	League	https://media.api-sports.io/football/leagues/432.png	79
433	Serie D - Girone H	League	https://media.api-sports.io/football/leagues/433.png	79
434	Serie D - Girone I	League	https://media.api-sports.io/football/leagues/434.png	79
435	Primera División RFEF - Group 1	League	https://media.api-sports.io/football/leagues/435.png	145
436	Primera División RFEF - Group 2	League	https://media.api-sports.io/football/leagues/436.png	145
437	Primera División RFEF - Group 3	League	https://media.api-sports.io/football/leagues/437.png	145
438	Primera División RFEF - Group 4	League	https://media.api-sports.io/football/leagues/438.png	145
439	Tercera División RFEF - Group 1	League	https://media.api-sports.io/football/leagues/439.png	145
440	Tercera División RFEF - Group 2	League	https://media.api-sports.io/football/leagues/440.png	145
441	Tercera División RFEF - Group 3	League	https://media.api-sports.io/football/leagues/441.png	145
442	Tercera División RFEF - Group 4	League	https://media.api-sports.io/football/leagues/442.png	145
443	Tercera División RFEF - Group 5	League	https://media.api-sports.io/football/leagues/443.png	145
444	Tercera División RFEF - Group 6	League	https://media.api-sports.io/football/leagues/444.png	145
445	Tercera División RFEF - Group 7	League	https://media.api-sports.io/football/leagues/445.png	145
446	Tercera División RFEF - Group 8	League	https://media.api-sports.io/football/leagues/446.png	145
447	Tercera División RFEF - Group 9	League	https://media.api-sports.io/football/leagues/447.png	145
448	Tercera División RFEF - Group 10	League	https://media.api-sports.io/football/leagues/448.png	145
449	Tercera División RFEF - Group 11	League	https://media.api-sports.io/football/leagues/449.png	145
450	Tercera División RFEF - Group 12	League	https://media.api-sports.io/football/leagues/450.png	145
451	Tercera División RFEF - Group 13	League	https://media.api-sports.io/football/leagues/451.png	145
452	Tercera División RFEF - Group 14	League	https://media.api-sports.io/football/leagues/452.png	145
453	Tercera División RFEF - Group 15	League	https://media.api-sports.io/football/leagues/453.png	145
454	Tercera División RFEF - Group 16	League	https://media.api-sports.io/football/leagues/454.png	145
455	Tercera División RFEF - Group 17	League	https://media.api-sports.io/football/leagues/455.png	145
456	Tercera División RFEF - Group 18	League	https://media.api-sports.io/football/leagues/456.png	145
457	Campeonato de Portugal Prio - Group A	League	https://media.api-sports.io/football/leagues/457.png	129
458	Campeonato de Portugal Prio - Group B	League	https://media.api-sports.io/football/leagues/458.png	129
459	Campeonato de Portugal Prio - Group C	League	https://media.api-sports.io/football/leagues/459.png	129
460	Campeonato de Portugal Prio - Group D	League	https://media.api-sports.io/football/leagues/460.png	129
461	National 3 - Group A	League	https://media.api-sports.io/football/leagues/461.png	56
462	National 3 - Group B	League	https://media.api-sports.io/football/leagues/462.png	56
463	National 3 - Group C	League	https://media.api-sports.io/football/leagues/463.png	56
464	National 3 - Group D	League	https://media.api-sports.io/football/leagues/464.png	56
465	National 3 - Group E	League	https://media.api-sports.io/football/leagues/465.png	56
466	National 3 - Group F	League	https://media.api-sports.io/football/leagues/466.png	56
467	National 3 - Group H	League	https://media.api-sports.io/football/leagues/467.png	56
468	National 3 - Group I	League	https://media.api-sports.io/football/leagues/468.png	56
469	National 3 - Group J	League	https://media.api-sports.io/football/leagues/469.png	56
470	National 3 - Group K	League	https://media.api-sports.io/football/leagues/470.png	56
471	National 3 - Group L	League	https://media.api-sports.io/football/leagues/471.png	56
472	National 3 - Group M	League	https://media.api-sports.io/football/leagues/472.png	56
473	2. Division - Group 1	League	https://media.api-sports.io/football/leagues/473.png	120
474	2. Division - Group 2	League	https://media.api-sports.io/football/leagues/474.png	120
484	Frauenliga	League	https://media.api-sports.io/football/leagues/484.png	10
485	Federation Cup	Cup	https://media.api-sports.io/football/leagues/485.png	12
486	Coppa	Cup	https://media.api-sports.io/football/leagues/486.png	15
487	First Amateur Division	League	https://media.api-sports.io/football/leagues/487.png	16
489	USL League One	League	https://media.api-sports.io/football/leagues/489.png	162
494	Super League 2	League	https://media.api-sports.io/football/leagues/494.png	63
501	Copa Paraguay	Cup	https://media.api-sports.io/football/leagues/501.png	125
502	Copa Bicentenario	Cup	https://media.api-sports.io/football/leagues/502.png	126
503	Copa Perú	Cup	https://media.api-sports.io/football/leagues/503.png	126
509	8 Cup	Cup	https://media.api-sports.io/football/leagues/509.png	143
515	U21 League 1	League	https://media.api-sports.io/football/leagues/515.png	2
517	Trofeo de Campeones de la Superliga	Cup	https://media.api-sports.io/football/leagues/517.png	6
518	Reserve Pro League	League	https://media.api-sports.io/football/leagues/518.png	16
523	NISA	League	https://media.api-sports.io/football/leagues/523.png	162
525	UEFA Champions League Women	Cup	https://media.api-sports.io/football/leagues/525.png	169
533	CAF Super Cup	Cup	https://media.api-sports.io/football/leagues/533.png	169
534	CONCACAF Caribbean Club Shield	Cup	https://media.api-sports.io/football/leagues/534.png	169
275	Liga 2	League	https://media.api-sports.io/football/leagues/275.png	74
395	Liga 1	League	https://media.api-sports.io/football/leagues/395.png	108
267	Copa Chile	Cup	https://media.api-sports.io/football/leagues/267.png	31
171	FA Cup	Cup	https://media.api-sports.io/football/leagues/171.png	32
241	Copa Colombia	Cup	https://media.api-sports.io/football/leagues/241.png	34
147	Cup	Cup	https://media.api-sports.io/football/leagues/147.png	16
167	Cup	Cup	https://media.api-sports.io/football/leagues/167.png	72
168	League Cup	Cup	https://media.api-sports.io/football/leagues/168.png	72
359	FAI Cup	Cup	https://media.api-sports.io/football/leagues/359.png	77
360	League Cup	Cup	https://media.api-sports.io/football/leagues/360.png	77
385	Toto Cup Ligat Al	Cup	https://media.api-sports.io/football/leagues/385.png	78
264	Copa MX	Cup	https://media.api-sports.io/football/leagues/264.png	107
11	CONMEBOL Sudamericana	Cup	https://media.api-sports.io/football/leagues/11.png	169
12	CAF Champions League	Cup	https://media.api-sports.io/football/leagues/12.png	169
13	CONMEBOL Libertadores	Cup	https://media.api-sports.io/football/leagues/13.png	169
209	Schweizer Cup	Cup	https://media.api-sports.io/football/leagues/209.png	149
115	Svenska Cupen	Cup	https://media.api-sports.io/football/leagues/115.png	148
375	Cup	Cup	https://media.api-sports.io/football/leagues/375.png	141
181	FA Cup	Cup	https://media.api-sports.io/football/leagues/181.png	136
182	Challenge Cup	Cup	https://media.api-sports.io/football/leagues/182.png	136
237	Cup	Cup	https://media.api-sports.io/football/leagues/237.png	132
97	Taça da Liga	Cup	https://media.api-sports.io/football/leagues/97.png	129
108	Cup	Cup	https://media.api-sports.io/football/leagues/108.png	128
105	NM Cupen	Cup	https://media.api-sports.io/football/leagues/105.png	120
325	Santosh Trophy	Cup	https://media.api-sports.io/football/leagues/325.png	73
347	Cup	Cup	https://media.api-sports.io/football/leagues/347.png	43
35	Asian Cup - Qualification	Cup	https://media.api-sports.io/football/leagues/35.png	169
254	NWSL Women	League	https://media.api-sports.io/football/leagues/254.png	162
260	Pacific Coast Soccer League	League	https://media.api-sports.io/football/leagues/260.png	30
192	New South Wales NPL	League	https://media.api-sports.io/football/leagues/192.png	9
194	South Australia NPL	League	https://media.api-sports.io/football/leagues/194.png	9
195	Victoria NPL	League	https://media.api-sports.io/football/leagues/195.png	9
196	Western Australia NPL	League	https://media.api-sports.io/football/leagues/196.png	9
357	Premier Division	League	https://media.api-sports.io/football/leagues/357.png	77
358	First Division	League	https://media.api-sports.io/football/leagues/358.png	77
768	Arab Club Champions Cup	Cup	https://media.api-sports.io/football/leagues/768.png	169
769	Premier League Asia Trophy	Cup	https://media.api-sports.io/football/leagues/769.png	169
770	Pacific Games	Cup	https://media.api-sports.io/football/leagues/770.png	169
772	Leagues Cup	Cup	https://media.api-sports.io/football/leagues/772.png	169
773	Sudamericano U20	Cup	https://media.api-sports.io/football/leagues/773.png	169
546	FAI President's Cup	Cup	https://media.api-sports.io/football/leagues/546.png	77
482	Queensland NPL	League	https://media.api-sports.io/football/leagues/482.png	9
566	Ligue A	League	https://media.api-sports.io/football/leagues/566.png	27
642	Curaçao Sekshon Pagá	League	https://media.api-sports.io/football/leagues/642.png	41
655	Copa Constitució	Cup	https://media.api-sports.io/football/leagues/655.png	3
664	Superliga	League	https://media.api-sports.io/football/leagues/664.png	86
665	Cup	Cup	https://media.api-sports.io/football/leagues/665.png	86
677	QSL Cup	Cup	https://media.api-sports.io/football/leagues/677.png	130
698	FA Women's Cup	Cup	https://media.api-sports.io/football/leagues/698.png	49
714	Cup	Cup	https://media.api-sports.io/football/leagues/714.png	47
716	Senior Shield	Cup	https://media.api-sports.io/football/leagues/716.png	70
572	Srpska Liga - Belgrade	League	https://media.api-sports.io/football/leagues/572.png	138
573	Srpska Liga - Vojvodina	League	https://media.api-sports.io/football/leagues/573.png	138
574	Srpska Liga - East	League	https://media.api-sports.io/football/leagues/574.png	138
575	Srpska Liga - West	League	https://media.api-sports.io/football/leagues/575.png	138
576	Gamma Ethniki - Group 1	League	https://media.api-sports.io/football/leagues/576.png	63
577	Gamma Ethniki - Group 2	League	https://media.api-sports.io/football/leagues/577.png	63
578	Gamma Ethniki - Group 3	League	https://media.api-sports.io/football/leagues/578.png	63
579	Gamma Ethniki - Group 4	League	https://media.api-sports.io/football/leagues/579.png	63
580	Gamma Ethniki - Group 5	League	https://media.api-sports.io/football/leagues/580.png	63
581	Gamma Ethniki - Group 6	League	https://media.api-sports.io/football/leagues/581.png	63
582	Gamma Ethniki - Group 7	League	https://media.api-sports.io/football/leagues/582.png	63
583	Gamma Ethniki - Group 8	League	https://media.api-sports.io/football/leagues/583.png	63
587	World Cup - U17	Cup	https://media.api-sports.io/football/leagues/587.png	169
590	A Division	League	https://media.api-sports.io/football/leagues/590.png	114
599	1. Liga Classic - Group 1	League	https://media.api-sports.io/football/leagues/599.png	149
600	1. Liga Classic - Group 2	League	https://media.api-sports.io/football/leagues/600.png	149
601	1. Liga Classic - Group 3	League	https://media.api-sports.io/football/leagues/601.png	149
613	Baiano - 2	League	https://media.api-sports.io/football/leagues/613.png	24
620	Cearense - 2	League	https://media.api-sports.io/football/leagues/620.png	24
625	Carioca - 2	League	https://media.api-sports.io/football/leagues/625.png	24
633	NB III - Northeast	League	https://media.api-sports.io/football/leagues/633.png	71
634	NB III - Southwest	League	https://media.api-sports.io/football/leagues/634.png	71
635	NB III - Northwest	League	https://media.api-sports.io/football/leagues/635.png	71
638	Kvindeliga	League	https://media.api-sports.io/football/leagues/638.png	44
602	Baiano - 1	League	https://media.api-sports.io/football/leagues/602.png	24
603	Paraibano	League	https://media.api-sports.io/football/leagues/603.png	24
604	Catarinense - 1	League	https://media.api-sports.io/football/leagues/604.png	24
605	Paulista - A3	League	https://media.api-sports.io/football/leagues/605.png	24
606	Paranaense - 1	League	https://media.api-sports.io/football/leagues/606.png	24
607	Roraimense	League	https://media.api-sports.io/football/leagues/607.png	24
608	Maranhense	League	https://media.api-sports.io/football/leagues/608.png	24
609	Cearense - 1	League	https://media.api-sports.io/football/leagues/609.png	24
610	Brasiliense	League	https://media.api-sports.io/football/leagues/610.png	24
611	Capixaba	League	https://media.api-sports.io/football/leagues/611.png	24
612	Copa do Nordeste	Cup	https://media.api-sports.io/football/leagues/612.png	24
614	Paranaense - 2	League	https://media.api-sports.io/football/leagues/614.png	24
615	Rondoniense	League	https://media.api-sports.io/football/leagues/615.png	24
616	Potiguar	League	https://media.api-sports.io/football/leagues/616.png	24
617	Copa do Brasil U20	Cup	https://media.api-sports.io/football/leagues/617.png	24
618	São Paulo Youth Cup	Cup	https://media.api-sports.io/football/leagues/618.png	24
619	Mineiro - 2	League	https://media.api-sports.io/football/leagues/619.png	24
621	Piauiense	League	https://media.api-sports.io/football/leagues/621.png	24
622	Pernambucano - 1	League	https://media.api-sports.io/football/leagues/622.png	24
623	Sul-Matogrossense	League	https://media.api-sports.io/football/leagues/623.png	24
624	Carioca - 1	League	https://media.api-sports.io/football/leagues/624.png	24
626	Sergipano	League	https://media.api-sports.io/football/leagues/626.png	24
627	Paraense	League	https://media.api-sports.io/football/leagues/627.png	24
628	Goiano - 1	League	https://media.api-sports.io/football/leagues/628.png	24
629	Mineiro - 1	League	https://media.api-sports.io/football/leagues/629.png	24
630	Matogrossense	League	https://media.api-sports.io/football/leagues/630.png	24
631	Tocantinense	League	https://media.api-sports.io/football/leagues/631.png	24
632	Supercopa do Brasil	Cup	https://media.api-sports.io/football/leagues/632.png	24
636	Ýokary Liga	League	https://media.api-sports.io/football/leagues/636.png	158
637	V.League 2	League	https://media.api-sports.io/football/leagues/637.png	165
639	Super Cup	Cup	https://media.api-sports.io/football/leagues/639.png	72
640	Kansallinen Liiga	League	https://media.api-sports.io/football/leagues/640.png	55
641	NWSL Women - Challenge Cup	Cup	https://media.api-sports.io/football/leagues/641.png	162
729	Coppa Titano	Cup	https://media.api-sports.io/football/leagues/729.png	134
730	Football League - Highland League	League	https://media.api-sports.io/football/leagues/730.png	136
731	Football League - Lowland League	League	https://media.api-sports.io/football/leagues/731.png	136
732	Cup	Cup	https://media.api-sports.io/football/leagues/732.png	138
733	I Liga - Women	League	https://media.api-sports.io/football/leagues/733.png	140
734	Diski Challenge	League	https://media.api-sports.io/football/leagues/734.png	143
735	Copa Federacion	Cup	https://media.api-sports.io/football/leagues/735.png	145
737	Svenska Cupen - Women	Cup	https://media.api-sports.io/football/leagues/737.png	148
738	League Cup	Cup	https://media.api-sports.io/football/leagues/738.png	166
739	AXA Women’s Super League	League	https://media.api-sports.io/football/leagues/739.png	149
740	CBF Brasileiro U20	Cup	https://media.api-sports.io/football/leagues/740.png	24
741	Brasileiro de Aspirantes	Cup	https://media.api-sports.io/football/leagues/741.png	24
742	Copa Paulista	Cup	https://media.api-sports.io/football/leagues/742.png	24
744	Oberliga - Schleswig-Holstein	League	https://media.api-sports.io/football/leagues/744.png	60
745	Oberliga - Hamburg	League	https://media.api-sports.io/football/leagues/745.png	60
746	Oberliga - Mittelrhein	League	https://media.api-sports.io/football/leagues/746.png	60
747	Oberliga - Westfalen	League	https://media.api-sports.io/football/leagues/747.png	60
748	Oberliga - Niedersachsen	League	https://media.api-sports.io/football/leagues/748.png	60
749	Oberliga - Bremen	League	https://media.api-sports.io/football/leagues/749.png	60
750	Oberliga - Hessen	League	https://media.api-sports.io/football/leagues/750.png	60
751	Oberliga - Niederrhein	League	https://media.api-sports.io/football/leagues/751.png	60
752	Oberliga - Rheinland-Pfalz / Saar	League	https://media.api-sports.io/football/leagues/752.png	60
753	Oberliga - Baden-Württemberg	League	https://media.api-sports.io/football/leagues/753.png	60
754	Oberliga - Nordost-Nord	League	https://media.api-sports.io/football/leagues/754.png	60
755	Oberliga - Nordost-Süd	League	https://media.api-sports.io/football/leagues/755.png	60
756	Cup	Cup	https://media.api-sports.io/football/leagues/756.png	99
757	Irish Cup	Cup	https://media.api-sports.io/football/leagues/757.png	119
758	Premier Division	League	https://media.api-sports.io/football/leagues/758.png	62
759	Liga Mayor	League	https://media.api-sports.io/football/leagues/759.png	45
760	LFA First Division	League	https://media.api-sports.io/football/leagues/760.png	93
761	Cup	Cup	https://media.api-sports.io/football/leagues/761.png	95
762	Premier League	League	https://media.api-sports.io/football/leagues/762.png	105
763	Mauritian League	League	https://media.api-sports.io/football/leagues/763.png	106
764	Premier League	League	https://media.api-sports.io/football/leagues/764.png	109
765	PFL	League	https://media.api-sports.io/football/leagues/765.png	127
767	CONCACAF League	Cup	https://media.api-sports.io/football/leagues/767.png	169
771	COSAFA U20 Championship	Cup	https://media.api-sports.io/football/leagues/771.png	169
774	3. Division - Girone 1	League	https://media.api-sports.io/football/leagues/774.png	120
775	3. Division - Girone 2	League	https://media.api-sports.io/football/leagues/775.png	120
776	3. Division - Girone 3	League	https://media.api-sports.io/football/leagues/776.png	120
777	3. Division - Girone 4	League	https://media.api-sports.io/football/leagues/777.png	120
778	3. Division - Girone 5	League	https://media.api-sports.io/football/leagues/778.png	120
779	3. Division - Girone 6	League	https://media.api-sports.io/football/leagues/779.png	120
780	III Liga - Group 1	League	https://media.api-sports.io/football/leagues/780.png	128
781	III Liga - Group 2	League	https://media.api-sports.io/football/leagues/781.png	128
782	III Liga - Group 3	League	https://media.api-sports.io/football/leagues/782.png	128
783	III Liga - Group 4	League	https://media.api-sports.io/football/leagues/783.png	128
784	Liga III - Serie 1	League	https://media.api-sports.io/football/leagues/784.png	131
785	Liga III - Serie 2	League	https://media.api-sports.io/football/leagues/785.png	131
786	Liga III - Serie 3	League	https://media.api-sports.io/football/leagues/786.png	131
787	Liga III - Serie 4	League	https://media.api-sports.io/football/leagues/787.png	131
788	Liga III - Serie 5	League	https://media.api-sports.io/football/leagues/788.png	131
789	Liga III - Serie 6	League	https://media.api-sports.io/football/leagues/789.png	131
790	Liga III - Serie 7	League	https://media.api-sports.io/football/leagues/790.png	131
791	Liga III - Serie 8	League	https://media.api-sports.io/football/leagues/791.png	131
792	Liga III - Serie 9	League	https://media.api-sports.io/football/leagues/792.png	131
793	Liga III - Serie 10	League	https://media.api-sports.io/football/leagues/793.png	131
794	3. SNL - East	League	https://media.api-sports.io/football/leagues/794.png	141
795	3. SNL - West	League	https://media.api-sports.io/football/leagues/795.png	141
796	2. Liga Interregional - Group 1	League	https://media.api-sports.io/football/leagues/796.png	149
797	2. Liga Interregional - Group 2	League	https://media.api-sports.io/football/leagues/797.png	149
798	2. Liga Interregional - Group 3	League	https://media.api-sports.io/football/leagues/798.png	149
799	2. Liga Interregional - Group 4	League	https://media.api-sports.io/football/leagues/799.png	149
800	2. Liga Interregional - Group 5	League	https://media.api-sports.io/football/leagues/800.png	149
801	2. Liga Interregional - Group 6	League	https://media.api-sports.io/football/leagues/801.png	149
802	Cup	Cup	https://media.api-sports.io/football/leagues/802.png	163
809	Super Cup	Cup	https://media.api-sports.io/football/leagues/809.png	3
810	Super Copa	Cup	https://media.api-sports.io/football/leagues/810.png	6
811	Federation Cup	Cup	https://media.api-sports.io/football/leagues/811.png	13
813	Elite Two	League	https://media.api-sports.io/football/leagues/813.png	29
816	Shield Cup	Cup	https://media.api-sports.io/football/leagues/816.png	83
817	Super Cup Primavera	Cup	https://media.api-sports.io/football/leagues/817.png	79
819	Super Cup	Cup	https://media.api-sports.io/football/leagues/819.png	86
820	Crown Prince Cup	Cup	https://media.api-sports.io/football/leagues/820.png	87
821	FA Trophy	Cup	https://media.api-sports.io/football/leagues/821.png	104
822	Cup	Cup	https://media.api-sports.io/football/leagues/822.png	111
828	Ligue 2	League	https://media.api-sports.io/football/leagues/828.png	156
829	Youth League	League	https://media.api-sports.io/football/leagues/829.png	158
830	Super Cup	Cup	https://media.api-sports.io/football/leagues/830.png	163
832	Coupe de la Ligue	Cup	https://media.api-sports.io/football/leagues/832.png	2
837	Rock Cup	Cup	https://media.api-sports.io/football/leagues/837.png	62
838	Super Cup	Cup	https://media.api-sports.io/football/leagues/838.png	83
840	Taça Revelação U23	Cup	https://media.api-sports.io/football/leagues/840.png	129
841	QFA Cup	Cup	https://media.api-sports.io/football/leagues/841.png	130
843	Copa Verde	Cup	https://media.api-sports.io/football/leagues/843.png	24
844	Ligue 1	League	https://media.api-sports.io/football/leagues/844.png	35
845	GFA League	League	https://media.api-sports.io/football/leagues/845.png	58
847	Premier League	League	https://media.api-sports.io/football/leagues/847.png	51
849	Baltic Cup	Cup	https://media.api-sports.io/football/leagues/849.png	169
475	Paulista - A1	League	https://media.api-sports.io/football/leagues/475.png	24
476	Paulista - A2	League	https://media.api-sports.io/football/leagues/476.png	24
477	Gaúcho - 1	League	https://media.api-sports.io/football/leagues/477.png	24
478	Gaúcho - 2	League	https://media.api-sports.io/football/leagues/478.png	24
479	Canadian Premier League	League	https://media.api-sports.io/football/leagues/479.png	30
483	Copa de la Superliga	Cup	https://media.api-sports.io/football/leagues/483.png	6
500	FA Cup	Cup	https://media.api-sports.io/football/leagues/500.png	101
532	AFC U23 Asian Cup	Cup	https://media.api-sports.io/football/leagues/532.png	169
536	CONCACAF Nations League	Cup	https://media.api-sports.io/football/leagues/536.png	169
538	Africa Cup of Nations U20	Cup	https://media.api-sports.io/football/leagues/538.png	169
540	CONMEBOL Libertadores U20	Cup	https://media.api-sports.io/football/leagues/540.png	169
541	CONMEBOL Recopa	Cup	https://media.api-sports.io/football/leagues/541.png	169
542	Iraqi League	League	https://media.api-sports.io/football/leagues/542.png	76
863	Cup	Cup	https://media.api-sports.io/football/leagues/863.png	83
881	Olympics Men - Qualification Concacaf	Cup	https://media.api-sports.io/football/leagues/881.png	169
882	Olympics Women - Qualification Asia	Cup	https://media.api-sports.io/football/leagues/882.png	169
885	Campeones Cup	Cup	https://media.api-sports.io/football/leagues/885.png	169
548	Super Cup	Cup	https://media.api-sports.io/football/leagues/548.png	82
549	Damallsvenskan	League	https://media.api-sports.io/football/leagues/549.png	148
558	Supercopa	Cup	https://media.api-sports.io/football/leagues/558.png	126
562	Reserve League	League	https://media.api-sports.io/football/leagues/562.png	15
565	Liga Primera U20	League	https://media.api-sports.io/football/leagues/565.png	117
643	3. liga - Bratislava	League	https://media.api-sports.io/football/leagues/643.png	140
644	3. liga - West	League	https://media.api-sports.io/football/leagues/644.png	140
645	3. liga - East	League	https://media.api-sports.io/football/leagues/645.png	140
646	3. liga - Center	League	https://media.api-sports.io/football/leagues/646.png	140
647	Lao League	League	https://media.api-sports.io/football/leagues/647.png	89
648	Tasmania NPL	League	https://media.api-sports.io/football/leagues/648.png	9
649	Supreme Division Women	League	https://media.api-sports.io/football/leagues/649.png	132
650	Second League - Group 3	League	https://media.api-sports.io/football/leagues/650.png	132
651	Second League - Group 1	League	https://media.api-sports.io/football/leagues/651.png	132
652	Second League - Group 2	League	https://media.api-sports.io/football/leagues/652.png	132
653	Second League - Group 4	League	https://media.api-sports.io/football/leagues/653.png	132
654	Super Cup	Cup	https://media.api-sports.io/football/leagues/654.png	7
656	Super Cup	Cup	https://media.api-sports.io/football/leagues/656.png	25
657	Cup	Cup	https://media.api-sports.io/football/leagues/657.png	50
658	Cup	Cup	https://media.api-sports.io/football/leagues/658.png	90
659	Super Cup	Cup	https://media.api-sports.io/football/leagues/659.png	78
660	WK-League	League	https://media.api-sports.io/football/leagues/660.png	144
661	Cup	Cup	https://media.api-sports.io/football/leagues/661.png	96
662	Copa por México	Cup	https://media.api-sports.io/football/leagues/662.png	107
663	Super Cup	Cup	https://media.api-sports.io/football/leagues/663.png	132
666	Friendlies Women	Cup	https://media.api-sports.io/football/leagues/666.png	169
667	Friendlies Clubs	Cup	https://media.api-sports.io/football/leagues/667.png	169
668	1. Liga U19	League	https://media.api-sports.io/football/leagues/668.png	43
669	1. Liga Women	League	https://media.api-sports.io/football/leagues/669.png	43
670	Community Shield Women	Cup	https://media.api-sports.io/football/leagues/670.png	49
671	Úrvalsdeild Women	League	https://media.api-sports.io/football/leagues/671.png	72
672	David Kipiani Cup	Cup	https://media.api-sports.io/football/leagues/672.png	59
673	Liga MX Femenil	League	https://media.api-sports.io/football/leagues/673.png	107
674	Cupa	Cup	https://media.api-sports.io/football/leagues/674.png	108
675	U21 Divisie 1	League	https://media.api-sports.io/football/leagues/675.png	115
676	Central Youth League	League	https://media.api-sports.io/football/leagues/676.png	128
678	Super Cup	Cup	https://media.api-sports.io/football/leagues/678.png	38
679	U21 League	League	https://media.api-sports.io/football/leagues/679.png	38
680	Cup	Cup	https://media.api-sports.io/football/leagues/680.png	140
681	Campeonato de Portugal Prio - Group E	League	https://media.api-sports.io/football/leagues/681.png	129
682	Campeonato de Portugal Prio - Group F	League	https://media.api-sports.io/football/leagues/682.png	129
683	Campeonato de Portugal Prio - Group G	League	https://media.api-sports.io/football/leagues/683.png	129
684	Campeonato de Portugal Prio - Group H	League	https://media.api-sports.io/football/leagues/684.png	129
685	3. liga - CFL B	League	https://media.api-sports.io/football/leagues/685.png	43
686	4. liga - Divizie F	League	https://media.api-sports.io/football/leagues/686.png	43
687	Regionalliga - Tirol	League	https://media.api-sports.io/football/leagues/687.png	10
688	Regionalliga - Salzburg	League	https://media.api-sports.io/football/leagues/688.png	10
689	Third Amateur Division - ACFF A	League	https://media.api-sports.io/football/leagues/689.png	16
690	Third Amateur Division - ACFF B	League	https://media.api-sports.io/football/leagues/690.png	16
691	Provincial - Brabant ACFF	League	https://media.api-sports.io/football/leagues/691.png	16
692	Primera División RFEF - Group 5	League	https://media.api-sports.io/football/leagues/692.png	145
693	Gamma Ethniki - Group 9	League	https://media.api-sports.io/football/leagues/693.png	63
694	Gamma Ethniki - Group 10	League	https://media.api-sports.io/football/leagues/694.png	63
695	U18 Premier League - North	League	https://media.api-sports.io/football/leagues/695.png	49
696	U18 Premier League - South	League	https://media.api-sports.io/football/leagues/696.png	49
697	WSL Cup	Cup	https://media.api-sports.io/football/leagues/697.png	49
699	Women's Championship	League	https://media.api-sports.io/football/leagues/699.png	49
700	Kakkosen Cup	Cup	https://media.api-sports.io/football/leagues/700.png	55
701	Liga Revelação U23	League	https://media.api-sports.io/football/leagues/701.png	129
702	Premier League 2 Division One	League	https://media.api-sports.io/football/leagues/702.png	49
703	Professional Development League	League	https://media.api-sports.io/football/leagues/703.png	49
704	Coppa Italia Primavera	Cup	https://media.api-sports.io/football/leagues/704.png	79
705	Campionato Primavera - 1	League	https://media.api-sports.io/football/leagues/705.png	79
706	Campionato Primavera - 2	League	https://media.api-sports.io/football/leagues/706.png	79
707	Cup	Cup	https://media.api-sports.io/football/leagues/707.png	1
708	Super Cup	Cup	https://media.api-sports.io/football/leagues/708.png	1
709	Cup	Cup	https://media.api-sports.io/football/leagues/709.png	7
710	Nacional B	League	https://media.api-sports.io/football/leagues/710.png	21
711	Segunda División	League	https://media.api-sports.io/football/leagues/711.png	31
712	Liga Femenina	League	https://media.api-sports.io/football/leagues/712.png	34
713	Superliga	Cup	https://media.api-sports.io/football/leagues/713.png	34
715	DFB Junioren Pokal	Cup	https://media.api-sports.io/football/leagues/715.png	60
717	I-League - 2nd Division	League	https://media.api-sports.io/football/leagues/717.png	73
719	Super Cup	Cup	https://media.api-sports.io/football/leagues/719.png	87
720	Emir Cup	Cup	https://media.api-sports.io/football/leagues/720.png	87
721	Cup	Cup	https://media.api-sports.io/football/leagues/721.png	97
722	Liga Premier Serie A	League	https://media.api-sports.io/football/leagues/722.png	107
723	Cup	Cup	https://media.api-sports.io/football/leagues/723.png	110
724	U18 Divisie 1	League	https://media.api-sports.io/football/leagues/724.png	115
726	Sultan Cup	Cup	https://media.api-sports.io/football/leagues/726.png	121
727	Super Cup	Cup	https://media.api-sports.io/football/leagues/727.png	128
728	Liga 1 Feminin	League	https://media.api-sports.io/football/leagues/728.png	131
725	Toppserien	League	https://media.api-sports.io/football/leagues/725.png	120
736	Elitettan	League	https://media.api-sports.io/football/leagues/736.png	148
743	UEFA Championship - Women	Cup	https://media.api-sports.io/football/leagues/743.png	169
812	Super Cup	Cup	https://media.api-sports.io/football/leagues/812.png	15
814	Reykjavik Cup	Cup	https://media.api-sports.io/football/leagues/814.png	72
815	Fotbolti.net Cup A	Cup	https://media.api-sports.io/football/leagues/815.png	72
818	Super Cup	Cup	https://media.api-sports.io/football/leagues/818.png	84
823	Nasjonal U19 Champions League	Cup	https://media.api-sports.io/football/leagues/823.png	120
824	Emir Cup	Cup	https://media.api-sports.io/football/leagues/824.png	130
825	Qatar Cup	Cup	https://media.api-sports.io/football/leagues/825.png	130
826	Super Cup	Cup	https://media.api-sports.io/football/leagues/826.png	135
831	Super Cup	Cup	https://media.api-sports.io/football/leagues/831.png	165
833	Queensland Premier League	League	https://media.api-sports.io/football/leagues/833.png	9
834	South Australia State League 1	League	https://media.api-sports.io/football/leagues/834.png	9
835	New South Wales NPL 2	League	https://media.api-sports.io/football/leagues/835.png	9
836	Victoria NPL 2	League	https://media.api-sports.io/football/leagues/836.png	9
839	Super Cup	Cup	https://media.api-sports.io/football/leagues/839.png	96
842	Super Copa	Cup	https://media.api-sports.io/football/leagues/842.png	161
846	Somali Premier League	League	https://media.api-sports.io/football/leagues/846.png	142
848	UEFA Europa Conference League	Cup	https://media.api-sports.io/football/leagues/848.png	169
851	Carioca A2	League	https://media.api-sports.io/football/leagues/851.png	24
852	Super Cup	Cup	https://media.api-sports.io/football/leagues/852.png	42
853	Supercopa de Ecuador	Cup	https://media.api-sports.io/football/leagues/853.png	46
854	WE League	League	https://media.api-sports.io/football/leagues/854.png	82
855	Dhivehi Premier League	League	https://media.api-sports.io/football/leagues/855.png	102
856	CONCACAF Caribbean Club Championship	Cup	https://media.api-sports.io/football/leagues/856.png	169
857	Campeón de Campeones	Cup	https://media.api-sports.io/football/leagues/857.png	107
858	CONCACAF Gold Cup - Qualification	Cup	https://media.api-sports.io/football/leagues/858.png	169
859	COSAFA Cup	Cup	https://media.api-sports.io/football/leagues/859.png	169
860	Arab Cup	Cup	https://media.api-sports.io/football/leagues/860.png	169
910	Youth Viareggio Cup	Cup	https://media.api-sports.io/football/leagues/910.png	169
861	U20 League	League	https://media.api-sports.io/football/leagues/861.png	107
862	3. Division	League	https://media.api-sports.io/football/leagues/862.png	44
864	Supercopa	Cup	https://media.api-sports.io/football/leagues/864.png	37
865	Liga 3	League	https://media.api-sports.io/football/leagues/865.png	129
866	MLS All-Star	Cup	https://media.api-sports.io/football/leagues/866.png	162
891	Coppa Italia Serie C	Cup	https://media.api-sports.io/football/leagues/891.png	79
868	Premier League	League	https://media.api-sports.io/football/leagues/868.png	122
869	CECAFA Club Cup	Cup	https://media.api-sports.io/football/leagues/869.png	169
870	Premier League	League	https://media.api-sports.io/football/leagues/870.png	38
871	Premier League Cup	Cup	https://media.api-sports.io/football/leagues/871.png	49
872	Liga Premier Serie B	League	https://media.api-sports.io/football/leagues/872.png	107
873	Thai Champions Cup	Cup	https://media.api-sports.io/football/leagues/873.png	153
874	Australia Cup	Cup	https://media.api-sports.io/football/leagues/874.png	9
875	Segunda División RFEF - Group 1	League	https://media.api-sports.io/football/leagues/875.png	145
876	Segunda División RFEF - Group 2	League	https://media.api-sports.io/football/leagues/876.png	145
877	Segunda División RFEF - Group 3	League	https://media.api-sports.io/football/leagues/877.png	145
878	Segunda División RFEF - Group 4	League	https://media.api-sports.io/football/leagues/878.png	145
879	Segunda División RFEF - Group 5	League	https://media.api-sports.io/football/leagues/879.png	145
880	World Cup - Women - Qualification Europe	Cup	https://media.api-sports.io/football/leagues/880.png	169
883	Reserve League	League	https://media.api-sports.io/football/leagues/883.png	115
884	Super Cup	Cup	https://media.api-sports.io/football/leagues/884.png	134
887	Second League	League	https://media.api-sports.io/football/leagues/887.png	47
888	Second League - Group B	League	https://media.api-sports.io/football/leagues/888.png	47
889	Second League - Group C	League	https://media.api-sports.io/football/leagues/889.png	47
890	U20 Elite League	Cup	https://media.api-sports.io/football/leagues/890.png	169
892	Coppa Italia Serie D	Cup	https://media.api-sports.io/football/leagues/892.png	79
867	Copa Paulino Alcantara	League	https://media.api-sports.io/football/leagues/867.png	127
895	League Cup	Cup	https://media.api-sports.io/football/leagues/895.png	47
896	Super Cup	Cup	https://media.api-sports.io/football/leagues/896.png	160
898	League Cup	Cup	https://media.api-sports.io/football/leagues/898.png	153
902	Algarve Cup	Cup	https://media.api-sports.io/football/leagues/902.png	169
903	The Atlantic Cup	Cup	https://media.api-sports.io/football/leagues/903.png	169
905	Super Cup	Cup	https://media.api-sports.io/football/leagues/905.png	75
36	Africa Cup of Nations - Qualification	Cup	https://media.api-sports.io/football/leagues/36.png	169
944	Super Cup	Cup	https://media.api-sports.io/football/leagues/944.png	121
945	International Champions Cup - Women	Cup	https://media.api-sports.io/football/leagues/945.png	169
946	Second NL	League	https://media.api-sports.io/football/leagues/946.png	39
947	DFB Pokal - Women	Cup	https://media.api-sports.io/football/leagues/947.png	60
948	1a Divisão - Women	League	https://media.api-sports.io/football/leagues/948.png	129
949	CONMEBOL Libertadores Femenina	Cup	https://media.api-sports.io/football/leagues/949.png	169
950	World Cup - U17 - Women	Cup	https://media.api-sports.io/football/leagues/950.png	169
951	South American Youth Games	Cup	https://media.api-sports.io/football/leagues/951.png	169
952	AFC U23 Asian Cup - Qualification	Cup	https://media.api-sports.io/football/leagues/952.png	169
953	Africa U23 Cup of Nations - Qualification	Cup	https://media.api-sports.io/football/leagues/953.png	169
954	National League - Central	League	https://media.api-sports.io/football/leagues/954.png	116
955	National League - National	League	https://media.api-sports.io/football/leagues/955.png	116
956	National League - Northern	League	https://media.api-sports.io/football/leagues/956.png	116
957	National League - Southern	League	https://media.api-sports.io/football/leagues/957.png	116
958	Copa Costa Rica	Cup	https://media.api-sports.io/football/leagues/958.png	37
959	Cup	Cup	https://media.api-sports.io/football/leagues/959.png	139
961	Supercopa	Cup	https://media.api-sports.io/football/leagues/961.png	125
962	Premier League	League	https://media.api-sports.io/football/leagues/962.png	92
966	Cup	Cup	https://media.api-sports.io/football/leagues/966.png	61
967	Cup	Cup	https://media.api-sports.io/football/leagues/967.png	91
968	Championnat D1	League	https://media.api-sports.io/football/leagues/968.png	57
971	Shield Cup	Cup	https://media.api-sports.io/football/leagues/971.png	85
975	Serie C - Relegation - Play-offs	League	https://media.api-sports.io/football/leagues/975.png	79
976	Serie C - Promotion - Play-offs	League	https://media.api-sports.io/football/leagues/976.png	79
974	Serie C - Supercoppa Lega Finals	League	https://media.api-sports.io/football/leagues/974.png	79
977	Tercera División RFEF - Promotion - Play-offs	League	https://media.api-sports.io/football/leagues/977.png	145
978	2nd Division - Play-offs	League	https://media.api-sports.io/football/leagues/978.png	1
979	Provincial - Play-offs VV	League	https://media.api-sports.io/football/leagues/979.png	16
980	Provincial - Play-offs ACFF	League	https://media.api-sports.io/football/leagues/980.png	16
981	Third Amateur Division - Play-offs	League	https://media.api-sports.io/football/leagues/981.png	16
982	Denmark Series - Promotion Round	League	https://media.api-sports.io/football/leagues/982.png	44
983	Denmark Series - Relegation Round	League	https://media.api-sports.io/football/leagues/983.png	44
984	National League - North - Play-offs	League	https://media.api-sports.io/football/leagues/984.png	49
985	National League - South - Play-offs	League	https://media.api-sports.io/football/leagues/985.png	49
986	Non League Div One - Play-offs	League	https://media.api-sports.io/football/leagues/986.png	49
987	U18 Premier League - Championship	League	https://media.api-sports.io/football/leagues/987.png	49
988	Oberliga - Promotion Round	League	https://media.api-sports.io/football/leagues/988.png	60
989	Oberliga - Relegation Round	League	https://media.api-sports.io/football/leagues/989.png	60
990	Gamma Ethniki - Promotion Group	League	https://media.api-sports.io/football/leagues/990.png	63
991	Campeonato de Portugal Prio - Promotion Round	League	https://media.api-sports.io/football/leagues/991.png	129
992	Football League - Championship	League	https://media.api-sports.io/football/leagues/992.png	136
993	Non League Premier - Isthmian - Play-offs	League	https://media.api-sports.io/football/leagues/993.png	49
994	Non League Premier - Northern - Play-offs	League	https://media.api-sports.io/football/leagues/994.png	49
995	Non League Premier - Southern South - Play-offs	League	https://media.api-sports.io/football/leagues/995.png	49
996	Non League Premier - Southern Central - Play-offs	League	https://media.api-sports.io/football/leagues/996.png	49
997	Serie D - Promotion - Play-offs	League	https://media.api-sports.io/football/leagues/997.png	79
998	Serie D - Relegation - Play-offs	League	https://media.api-sports.io/football/leagues/998.png	79
999	Serie D - Championship Round	League	https://media.api-sports.io/football/leagues/999.png	79
1000	Segunda División RFEF - Play-offs	League	https://media.api-sports.io/football/leagues/1000.png	145
1002	Regionalliga - Promotion Play-offs	League	https://media.api-sports.io/football/leagues/1002.png	60
1003	Regionalliga - Relegation Round	League	https://media.api-sports.io/football/leagues/1003.png	60
1004	Derde Divisie - Relegation Round	League	https://media.api-sports.io/football/leagues/1004.png	115
1005	1. Liga Classic - Play-offs	League	https://media.api-sports.io/football/leagues/1005.png	149
1006	Primera División RFEF - Play Offs	League	https://media.api-sports.io/football/leagues/1006.png	145
1007	3. Lig - Play-offs	League	https://media.api-sports.io/football/leagues/1007.png	157
886	UEFA U17 Championship - Qualification	Cup	https://media.api-sports.io/football/leagues/886.png	169
893	UEFA U19 Championship - Qualification	Cup	https://media.api-sports.io/football/leagues/893.png	169
894	Asian Cup Women - Qualification	Cup	https://media.api-sports.io/football/leagues/894.png	169
897	Asian Cup Women	Cup	https://media.api-sports.io/football/leagues/897.png	169
899	League Cup	Cup	https://media.api-sports.io/football/leagues/899.png	55
900	Tipsport Malta Cup	Cup	https://media.api-sports.io/football/leagues/900.png	169
901	Ykköscup	Cup	https://media.api-sports.io/football/leagues/901.png	55
904	SheBelieves Cup	Cup	https://media.api-sports.io/football/leagues/904.png	169
906	Reserve League	League	https://media.api-sports.io/football/leagues/906.png	6
907	Primera Division	League	https://media.api-sports.io/football/leagues/907.png	40
908	AFF U23 Championship	Cup	https://media.api-sports.io/football/leagues/908.png	169
1009	Liga III - Play-offs	League	https://media.api-sports.io/football/leagues/1009.png	131
1010	3. liga - Promotion Play-off	League	https://media.api-sports.io/football/leagues/1010.png	43
1011	Second Amateur Division - Play-offs 	League	https://media.api-sports.io/football/leagues/1011.png	16
1014	Second League - Play-offs	League	https://media.api-sports.io/football/leagues/1014.png	47
1016	CAC Games	Cup	https://media.api-sports.io/football/leagues/1016.png	169
909	MLS Next Pro	League	https://media.api-sports.io/football/leagues/909.png	162
911	Southeast Asian Games	Cup	https://media.api-sports.io/football/leagues/911.png	169
912	CONCACAF Women U17	Cup	https://media.api-sports.io/football/leagues/912.png	169
913	CONMEBOL - UEFA Finalissima	Cup	https://media.api-sports.io/football/leagues/913.png	169
914	Tournoi Maurice Revello	Cup	https://media.api-sports.io/football/leagues/914.png	169
915	1. Division Women	League	https://media.api-sports.io/football/leagues/915.png	120
916	Kirin Cup	Cup	https://media.api-sports.io/football/leagues/916.png	169
917	Copa Ecuador	Cup	https://media.api-sports.io/football/leagues/917.png	46
918	UEFA U19 Championship - Women	Cup	https://media.api-sports.io/football/leagues/918.png	169
919	Mediterranean Games	Cup	https://media.api-sports.io/football/leagues/919.png	169
920	World Cup - U20 - Women	Cup	https://media.api-sports.io/football/leagues/920.png	169
921	UEFA U17 Championship	Cup	https://media.api-sports.io/football/leagues/921.png	169
922	Africa Cup of Nations - Women	Cup	https://media.api-sports.io/football/leagues/922.png	169
923	League 1 Ontario	League	https://media.api-sports.io/football/leagues/923.png	30
924	Piala Presiden	Cup	https://media.api-sports.io/football/leagues/924.png	74
926	Copa America Femenina	Cup	https://media.api-sports.io/football/leagues/926.png	169
927	World Cup - Women - Qualification Concacaf	Cup	https://media.api-sports.io/football/leagues/927.png	169
928	AFF U19 Championship	Cup	https://media.api-sports.io/football/leagues/928.png	169
929	League Two	League	https://media.api-sports.io/football/leagues/929.png	32
930	Copa Uruguay	Cup	https://media.api-sports.io/football/leagues/930.png	161
931	Non League Premier - Southern Central	League	https://media.api-sports.io/football/leagues/931.png	49
932	Non League Div One - Northern East	League	https://media.api-sports.io/football/leagues/932.png	49
933	Non League Div One - Southern Central	League	https://media.api-sports.io/football/leagues/933.png	49
934	Arab Championship - U20	Cup	https://media.api-sports.io/football/leagues/934.png	169
935	Diski Shield	Cup	https://media.api-sports.io/football/leagues/935.png	143
936	Catarinense - 2	League	https://media.api-sports.io/football/leagues/936.png	24
937	Emirates Cup	Cup	https://media.api-sports.io/football/leagues/937.png	169
938	Oberliga - Bayern Nord	League	https://media.api-sports.io/football/leagues/938.png	60
939	Oberliga - Bayern Süd	League	https://media.api-sports.io/football/leagues/939.png	60
940	COTIF Tournament	Cup	https://media.api-sports.io/football/leagues/940.png	169
941	Islamic Solidarity Games	Cup	https://media.api-sports.io/football/leagues/941.png	169
1039	Premier League International Cup	Cup	https://media.api-sports.io/football/leagues/1039.png	169
1040	UEFA Nations League - Women	Cup	https://media.api-sports.io/football/leagues/1040.png	169
1041	Júniores U19	League	https://media.api-sports.io/football/leagues/1041.png	129
1042	Super Cup	Cup	https://media.api-sports.io/football/leagues/1042.png	62
1043	African Football League	Cup	https://media.api-sports.io/football/leagues/1043.png	169
1044	Erste Liga Cup	Cup	https://media.api-sports.io/football/leagues/1044.png	149
1045	Pan American Games	Cup	https://media.api-sports.io/football/leagues/1045.png	169
1048	Premier Division	League	https://media.api-sports.io/football/leagues/1048.png	5
1049	King's Cup	Cup	https://media.api-sports.io/football/leagues/1049.png	12
1050	Super Cup	Cup	https://media.api-sports.io/football/leagues/1050.png	104
1052	Kakkonen - Play-offs	League	https://media.api-sports.io/football/leagues/1052.png	55
1053	Division 2 - Play-offs	League	https://media.api-sports.io/football/leagues/1053.png	148
1054	2. Division - Play-offs	League	https://media.api-sports.io/football/leagues/1054.png	120
1055	Ettan - Relegation Round	League	https://media.api-sports.io/football/leagues/1055.png	148
1056	National League - Championship - Final	League	https://media.api-sports.io/football/leagues/1056.png	116
1058	Supercopa Femenina	Cup	https://media.api-sports.io/football/leagues/1058.png	145
1061	Second League A - Spring Season Gold	League	https://media.api-sports.io/football/leagues/1061.png	132
1064	Second League A - Spring Season Silver	League	https://media.api-sports.io/football/leagues/1064.png	132
1065	U19 League	League	https://media.api-sports.io/football/leagues/1065.png	38
1068	FA Youth Cup	Cup	https://media.api-sports.io/football/leagues/1068.png	49
1072	All Africa Games	Cup	https://media.api-sports.io/football/leagues/1072.png	169
1074	SWPL Cup	Cup	https://media.api-sports.io/football/leagues/1074.png	136
1078	SWF Scottish Cup	Cup	https://media.api-sports.io/football/leagues/1078.png	136
1079	Yemeni League	League	https://media.api-sports.io/football/leagues/1079.png	170
1080	Premier Division	League	https://media.api-sports.io/football/leagues/1080.png	64
1084	Championnat National	League	https://media.api-sports.io/football/leagues/1084.png	154
1099	Gamma Ethniki - Relegation Play-offs	League	https://media.api-sports.io/football/leagues/1099.png	63
1109	Super Cup	Cup	https://media.api-sports.io/football/leagues/1109.png	12
1111	NB III - Promotion Play-offs	League	https://media.api-sports.io/football/leagues/1111.png	71
1121	Second League A - Promotion Play-offs	League	https://media.api-sports.io/football/leagues/1121.png	132
960	Euro Championship - Qualification	Cup	https://media.api-sports.io/football/leagues/960.png	169
963	CONCACAF U17	Cup	https://media.api-sports.io/football/leagues/963.png	169
964	Copa de la División Profesional	Cup	https://media.api-sports.io/football/leagues/964.png	21
965	AFC U20 Asian Cup	Cup	https://media.api-sports.io/football/leagues/965.png	169
969	Primeira Divisão	League	https://media.api-sports.io/football/leagues/969.png	98
970	CONMEBOL - U17	Cup	https://media.api-sports.io/football/leagues/970.png	169
972	Super Cup	Cup	https://media.api-sports.io/football/leagues/972.png	32
973	CAF Cup of Nations - U17	Cup	https://media.api-sports.io/football/leagues/973.png	169
1008	CAFA Nations Cup	Cup	https://media.api-sports.io/football/leagues/1008.png	169
1012	AFC U17 Asian Cup	Cup	https://media.api-sports.io/football/leagues/1012.png	169
1013	All-Island Cup - Women	Cup	https://media.api-sports.io/football/leagues/1013.png	169
1015	CAF U23 Cup of Nations	Cup	https://media.api-sports.io/football/leagues/1015.png	169
1017	U23 League	League	https://media.api-sports.io/football/leagues/1017.png	107
1018	Federation Cup	Cup	https://media.api-sports.io/football/leagues/1018.png	91
1019	Charity Shield	Cup	https://media.api-sports.io/football/leagues/1019.png	119
1020	Calcutta Premier Division	League	https://media.api-sports.io/football/leagues/1020.png	73
1021	Super Cup	Cup	https://media.api-sports.io/football/leagues/1021.png	39
1022	Premier League - Summer Series	League	https://media.api-sports.io/football/leagues/1022.png	49
1023	NB III - Southeast	League	https://media.api-sports.io/football/leagues/1023.png	71
1024	UEFA - CONMEBOL - Club Challenge	Cup	https://media.api-sports.io/football/leagues/1024.png	169
1025	Second League A - Fall Season Gold	League	https://media.api-sports.io/football/leagues/1025.png	132
1026	Second League A - Fall Season Silver	League	https://media.api-sports.io/football/leagues/1026.png	132
1027	3. Lig - Group 4	League	https://media.api-sports.io/football/leagues/1027.png	157
1028	Concacaf Central American Cup	Cup	https://media.api-sports.io/football/leagues/1028.png	169
1029	National 3 - Group G	League	https://media.api-sports.io/football/leagues/1029.png	56
1030	Goiano - 2	League	https://media.api-sports.io/football/leagues/1030.png	24
1031	Premier League	League	https://media.api-sports.io/football/leagues/1031.png	20
1032	Copa de la Liga Profesional	League	https://media.api-sports.io/football/leagues/1032.png	6
1033	Ekstraliga Women	League	https://media.api-sports.io/football/leagues/1033.png	128
1034	2. Frauen Bundesliga	League	https://media.api-sports.io/football/leagues/1034.png	60
1035	Copa Rio	Cup	https://media.api-sports.io/football/leagues/1035.png	24
1036	Copa Santa Catarina	Cup	https://media.api-sports.io/football/leagues/1036.png	24
1037	Paraibano 2	League	https://media.api-sports.io/football/leagues/1037.png	24
1038	King's Cup	Cup	https://media.api-sports.io/football/leagues/1038.png	169
850	UEFA U21 Championship - Qualification	Cup	https://media.api-sports.io/football/leagues/850.png	169
1149	Potiguar - 2	League	https://media.api-sports.io/football/leagues/1149.png	24
1150	Gaúcho - 3	League	https://media.api-sports.io/football/leagues/1150.png	24
1151	Pernambucano - 3	League	https://media.api-sports.io/football/leagues/1151.png	24
1152	U19 Divisie 1	League	https://media.api-sports.io/football/leagues/1152.png	115
1153	AFC U20 Asian Cup - Qualification	Cup	https://media.api-sports.io/football/leagues/1153.png	169
1154	Catarinense - 3	League	https://media.api-sports.io/football/leagues/1154.png	24
1155	Carioca B2	League	https://media.api-sports.io/football/leagues/1155.png	24
1156	National League Cup	Cup	https://media.api-sports.io/football/leagues/1156.png	49
1157	Paraense U20	League	https://media.api-sports.io/football/leagues/1157.png	24
1158	Copa Gaúcha	Cup	https://media.api-sports.io/football/leagues/1158.png	24
1159	CECAFA U20 Championship	Cup	https://media.api-sports.io/football/leagues/1159.png	169
1160	Sapling Cup	Cup	https://media.api-sports.io/football/leagues/1160.png	70
1161	AFC U17 Asian Cup - Qualification	Cup	https://media.api-sports.io/football/leagues/1161.png	169
1162	AGCFF Gulf Champions League	Cup	https://media.api-sports.io/football/leagues/1162.png	169
1163	African Nations Championship - Qualification	Cup	https://media.api-sports.io/football/leagues/1163.png	169
1164	CAF Women's Champions League	Cup	https://media.api-sports.io/football/leagues/1164.png	169
1165	Copa Fares Lopes	Cup	https://media.api-sports.io/football/leagues/1165.png	24
1166	Super Cup	Cup	https://media.api-sports.io/football/leagues/1166.png	29
1167	Recopa	Cup	https://media.api-sports.io/football/leagues/1167.png	37
1170	MFL Cup	Cup	https://media.api-sports.io/football/leagues/1170.png	101
1171	Coppa Italia Women	Cup	https://media.api-sports.io/football/leagues/1171.png	79
1173	Challenge Cup	Cup	https://media.api-sports.io/football/leagues/1173.png	104
1174	Hun Sen Cup	Cup	https://media.api-sports.io/football/leagues/1174.png	28
1001	CONCACAF Women U20	Cup	https://media.api-sports.io/football/leagues/1001.png	169
1046	CONCACAF Gold Cup - Qualification - Women	Cup	https://media.api-sports.io/football/leagues/1046.png	169
1047	Olympics Women - Qualification CAF	Cup	https://media.api-sports.io/football/leagues/1047.png	169
1051	HKPL Cup	Cup	https://media.api-sports.io/football/leagues/1051.png	70
1057	CONCACAF Gold Cup - Women	Cup	https://media.api-sports.io/football/leagues/1057.png	169
1059	Recopa Catarinense	Cup	https://media.api-sports.io/football/leagues/1059.png	24
1060	CONMEBOL - Pre-Olympic Tournament	Cup	https://media.api-sports.io/football/leagues/1060.png	169
1062	Paulista - A4	League	https://media.api-sports.io/football/leagues/1062.png	24
1063	Copa Alagoas	Cup	https://media.api-sports.io/football/leagues/1063.png	24
1066	CONCACAF U20 - Qualification	Cup	https://media.api-sports.io/football/leagues/1066.png	169
1067	Torneo Promocional Amateur	League	https://media.api-sports.io/football/leagues/1067.png	6
1069	Goiano U20	League	https://media.api-sports.io/football/leagues/1069.png	24
1070	AFC U20 Asian Cup - Women	Cup	https://media.api-sports.io/football/leagues/1070.png	169
1071	Paranaense U20	League	https://media.api-sports.io/football/leagues/1071.png	24
1073	Baiano U20	League	https://media.api-sports.io/football/leagues/1073.png	24
1075	Pro League A	League	https://media.api-sports.io/football/leagues/1075.png	163
1076	Catarinense U20	League	https://media.api-sports.io/football/leagues/1076.png	24
1077	WAFF Championship U23	Cup	https://media.api-sports.io/football/leagues/1077.png	169
1081	CONMEBOL - U17 Femenino	Cup	https://media.api-sports.io/football/leagues/1081.png	169
1082	Copa Rio U20	Cup	https://media.api-sports.io/football/leagues/1082.png	24
1085	CONMEBOL U20 Femenino	Cup	https://media.api-sports.io/football/leagues/1085.png	169
1086	Paulista - U20	League	https://media.api-sports.io/football/leagues/1086.png	24
1087	Ykkösliiga	League	https://media.api-sports.io/football/leagues/1087.png	55
1088	Pernambucano - U20	League	https://media.api-sports.io/football/leagues/1088.png	24
1089	UAE-Qatar - Super Shield	Cup	https://media.api-sports.io/football/leagues/1089.png	169
1090	NNSW League 1	League	https://media.api-sports.io/football/leagues/1090.png	9
1091	Tasmania Northern Championship	League	https://media.api-sports.io/football/leagues/1091.png	9
1092	Capital Territory NPL 2	League	https://media.api-sports.io/football/leagues/1092.png	9
1093	Tasmania Southern Championship	League	https://media.api-sports.io/football/leagues/1093.png	9
1094	Western Australia State League 1	League	https://media.api-sports.io/football/leagues/1094.png	9
1095	USL League One Cup	League	https://media.api-sports.io/football/leagues/1095.png	162
1096	Matogrossense 2	League	https://media.api-sports.io/football/leagues/1096.png	24
1097	Copa Espírito Santo	Cup	https://media.api-sports.io/football/leagues/1097.png	24
1098	Paulista Série B	League	https://media.api-sports.io/football/leagues/1098.png	24
1100	Brasiliense U20	League	https://media.api-sports.io/football/leagues/1100.png	24
1101	AFC U17 Asian Cup - Women	Cup	https://media.api-sports.io/football/leagues/1101.png	169
1102	UEFA U17 Championship - Women	Cup	https://media.api-sports.io/football/leagues/1102.png	169
1103	Premiership Women	League	https://media.api-sports.io/football/leagues/1103.png	119
1104	Liga 3	League	https://media.api-sports.io/football/leagues/1104.png	59
1105	Olympics - Intercontinental Play-offs	Cup	https://media.api-sports.io/football/leagues/1105.png	169
1106	Carioca C	League	https://media.api-sports.io/football/leagues/1106.png	24
1107	Mineiro U20	League	https://media.api-sports.io/football/leagues/1107.png	24
1108	Sergipano U20	League	https://media.api-sports.io/football/leagues/1108.png	24
1110	Alagoano U20	League	https://media.api-sports.io/football/leagues/1110.png	24
1112	Cearense U20	League	https://media.api-sports.io/football/leagues/1112.png	24
1113	Copa Venezuela	Cup	https://media.api-sports.io/football/leagues/1113.png	164
1114	Carioca U20	League	https://media.api-sports.io/football/leagues/1114.png	24
1115	Paraense B2	League	https://media.api-sports.io/football/leagues/1115.png	24
1116	WPSL	League	https://media.api-sports.io/football/leagues/1116.png	162
1117	USL W League	League	https://media.api-sports.io/football/leagues/1117.png	162
1118	NPSL	League	https://media.api-sports.io/football/leagues/1118.png	162
1119	NWSL - Liga MXF Summer Cup	League	https://media.api-sports.io/football/leagues/1119.png	162
1120	Paraibano U20	League	https://media.api-sports.io/football/leagues/1120.png	24
1122	OFC U19 Championship	Cup	https://media.api-sports.io/football/leagues/1122.png	169
1123	Qatar-UAE Super Cup	Cup	https://media.api-sports.io/football/leagues/1123.png	169
1124	Cearense - 3	League	https://media.api-sports.io/football/leagues/1124.png	24
1125	Pernambucano - 2	League	https://media.api-sports.io/football/leagues/1125.png	24
1126	Esiliiga B	League	https://media.api-sports.io/football/leagues/1126.png	50
1127	Chatham Cup	Cup	https://media.api-sports.io/football/leagues/1127.png	116
1128	Brasileiro U17	League	https://media.api-sports.io/football/leagues/1128.png	24
1129	ASEAN Club Championship	Cup	https://media.api-sports.io/football/leagues/1129.png	169
1130	USL Super League	League	https://media.api-sports.io/football/leagues/1130.png	162
1131	Super Cup	League	https://media.api-sports.io/football/leagues/1131.png	109
1132	AFC Challenge League	Cup	https://media.api-sports.io/football/leagues/1132.png	169
1133	Goiano - 3	League	https://media.api-sports.io/football/leagues/1133.png	24
1134	Amazonense - 2	League	https://media.api-sports.io/football/leagues/1134.png	24
1135	Sergipano - 2	League	https://media.api-sports.io/football/leagues/1135.png	24
1136	CONCACAF W Champions Cup	Cup	https://media.api-sports.io/football/leagues/1136.png	169
1137	Supercup der Frauen	League	https://media.api-sports.io/football/leagues/1137.png	60
1138	Paranaense - 3	League	https://media.api-sports.io/football/leagues/1138.png	24
1139	Potiguar - U20	League	https://media.api-sports.io/football/leagues/1139.png	24
1140	AFC Women's Champions League	Cup	https://media.api-sports.io/football/leagues/1140.png	169
1141	Brasiliense B	League	https://media.api-sports.io/football/leagues/1141.png	24
1142	Mineiro - 3	League	https://media.api-sports.io/football/leagues/1142.png	24
1143	Estadual Junior U20	League	https://media.api-sports.io/football/leagues/1143.png	24
1144	Super Cup	Cup	https://media.api-sports.io/football/leagues/1144.png	61
1168	FIFA Intercontinental Cup	Cup	https://media.api-sports.io/football/leagues/1168.png	169
1145	Paraense B1	League	https://media.api-sports.io/football/leagues/1145.png	24
1146	Alagoano - 2	Cup	https://media.api-sports.io/football/leagues/1146.png	24
1148	Maranhense - 2	League	https://media.api-sports.io/football/leagues/1148.png	24
1083	UEFA Championship - Women - Qualification	Cup	https://media.api-sports.io/football/leagues/1083.png	169
1169	EAFF E-1 Football Championship - Qualification	Cup	https://media.api-sports.io/football/leagues/1169.png	169
1180	Copa LDF	Cup	https://media.api-sports.io/football/leagues/1180.png	45
1172	Torneo Amistoso de Verano	Cup	https://media.api-sports.io/football/leagues/1172.png	21
1175	Women's President's Cup	Cup	https://media.api-sports.io/football/leagues/1175.png	77
1176	Super Cup	Cup	https://media.api-sports.io/football/leagues/1176.png	90
1177	Super Cup	Cup	https://media.api-sports.io/football/leagues/1177.png	53
1178	Super Copa International	Cup	https://media.api-sports.io/football/leagues/1178.png	6
1179	Copa do Brasil U17	Cup	https://media.api-sports.io/football/leagues/1179.png	24
1181	Supercopa	Cup	https://media.api-sports.io/football/leagues/1181.png	164
1182	Northern Super League	League	https://media.api-sports.io/football/leagues/1182.png	30
1147	Capixaba B	League	https://media.api-sports.io/football/leagues/1147.png	24
1183	Brasileiro U20 B	Cup	https://media.api-sports.io/football/leagues/1183.png	24
1184	Copa Grão Pará	Cup	https://media.api-sports.io/football/leagues/1184.png	24
\.


--
-- Data for Name: matches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.matches (id, data, home_team_id, away_team_id, home_team_goals, away_team_goals, home_team_possession, away_team_possession, home_team_shots, away_team_shots, home_team_shots_on_target, away_team_shots_on_target, home_team_fouls, away_team_fouls, home_team_corners, away_team_corners, home_team_yellow_cards, away_team_yellow_cards, home_team_red_cards, away_team_red_cards, league_id, status, matchday, home_team_goals_firsthalf, away_team_goals_firsthalf) FROM stdin;
1208032	2024-08-24 16:30:00	66	42	0	2	39.00	61.00	11	9	3	4	8	16	4	1	1	3	\N	\N	39	1	2	\N	\N
1208031	2024-08-25 13:00:00	35	34	1	1	39.00	61.00	16	14	4	5	20	8	8	9	2	2	\N	\N	39	1	2	\N	\N
1208036	2024-08-25 15:30:00	40	55	2	0	63.00	37.00	19	8	8	2	10	7	9	4	2	3	\N	\N	39	1	2	\N	\N
1208046	2024-08-31 14:00:00	46	66	1	2	58.00	42.00	9	10	3	5	13	21	1	4	4	5	\N	\N	39	1	3	\N	\N
1208045	2024-08-31 14:00:00	57	36	1	1	49.00	51.00	11	9	4	4	15	15	8	6	2	3	\N	\N	39	1	3	\N	\N
1208048	2024-09-01 12:30:00	34	47	2	1	34.00	66.00	9	20	3	6	16	13	7	12	4	4	\N	\N	39	1	3	\N	\N
1208047	2024-09-01 15:00:00	33	40	0	3	53.00	47.00	8	11	3	3	7	7	5	2	4	1	\N	\N	39	1	3	\N	\N
1208056	2024-09-14 14:00:00	40	65	0	1	69.00	31.00	14	5	5	3	15	6	7	2	4	4	\N	\N	39	1	4	\N	\N
1208053	2024-09-14 14:00:00	51	57	0	0	69.00	31.00	21	6	6	1	14	16	9	2	4	3	\N	\N	39	1	4	\N	\N
1208051	2024-09-14 19:00:00	35	49	0	1	33.00	67.00	19	10	7	3	16	9	6	3	6	8	\N	\N	39	1	4	\N	\N
1208060	2024-09-15 15:30:00	39	34	1	2	49.00	51.00	12	14	5	6	17	6	4	7	3	3	\N	\N	39	1	4	\N	\N
1208066	2024-09-21 14:00:00	40	35	3	0	59.00	41.00	19	19	13	6	10	12	3	9	1	4	\N	\N	39	1	5	\N	\N
1208069	2024-09-21 14:00:00	47	55	3	1	48.00	52.00	23	6	10	6	11	9	9	4	3	1	\N	\N	39	1	5	\N	\N
1208063	2024-09-21 16:30:00	52	33	0	0	33.00	67.00	9	15	4	6	7	12	4	11	3	2	\N	\N	39	1	5	\N	\N
1208067	2024-09-22 15:30:00	50	42	2	2	77.00	23.00	33	5	11	3	7	10	8	2	3	6	0	1	39	1	5	\N	\N
1208075	2024-09-28 14:00:00	45	52	2	1	40.00	60.00	8	17	2	5	13	11	5	8	2	0	\N	\N	39	1	6	\N	\N
1208079	2024-09-28 14:00:00	65	36	0	1	41.00	59.00	11	14	1	2	11	15	6	5	2	4	\N	\N	39	1	6	\N	\N
1208076	2024-09-29 13:00:00	57	66	2	2	44.00	56.00	15	7	5	3	10	14	10	0	4	1	\N	\N	39	1	6	\N	\N
1208071	2024-09-30 19:00:00	35	41	3	1	40.00	60.00	14	9	6	3	19	12	6	4	2	5	\N	\N	39	1	6	\N	\N
1208088	2024-10-05 14:00:00	46	35	1	0	44.00	56.00	6	19	2	2	12	14	0	9	4	1	\N	\N	39	1	7	\N	\N
1208083	2024-10-05 14:00:00	55	39	5	3	44.00	56.00	19	17	12	6	9	10	10	3	2	3	\N	\N	39	1	7	\N	\N
1208085	2024-10-06 13:00:00	49	65	1	1	66.00	34.00	22	16	8	9	12	11	11	3	6	4	0	1	39	1	7	\N	\N
1208099	2024-10-19 11:30:00	47	48	4	1	57.00	43.00	22	11	7	4	10	15	13	5	1	3	0	1	39	1	8	\N	\N
1208096	2024-10-19 14:00:00	34	51	0	1	60.00	40.00	21	10	6	5	11	9	9	4	2	2	\N	\N	39	1	8	\N	\N
1208098	2024-10-19 14:00:00	41	46	2	3	42.00	58.00	14	18	7	4	10	10	10	6	5	3	1	0	39	1	8	\N	\N
1208100	2024-10-20 13:00:00	39	50	1	2	22.00	78.00	3	22	2	7	8	5	1	18	4	1	\N	\N	39	1	8	\N	\N
1208097	2024-10-21 19:00:00	65	52	1	0	50.00	50.00	20	20	6	7	9	12	6	6	2	3	\N	\N	39	1	8	\N	\N
1208106	2024-10-26 14:00:00	51	39	2	2	51.00	49.00	19	14	6	7	12	10	9	6	3	3	\N	\N	39	1	9	\N	\N
1208104	2024-10-26 14:00:00	66	35	1	1	57.00	43.00	18	10	8	3	12	14	9	7	7	6	\N	\N	39	1	9	\N	\N
1208107	2024-10-27 13:00:00	49	34	2	1	50.00	50.00	17	11	7	3	13	16	7	4	6	3	\N	\N	39	1	9	\N	\N
1208103	2024-10-27 15:30:00	42	40	2	2	45.00	55.00	9	9	3	4	14	14	1	3	2	2	\N	\N	39	1	9	\N	\N
1208116	2024-11-02 15:00:00	40	51	2	1	49.00	51.00	16	13	8	5	10	18	9	7	1	1	\N	\N	39	1	10	\N	\N
1208115	2024-11-02 15:00:00	57	46	1	1	42.00	58.00	14	20	2	6	11	10	4	6	6	2	1	0	39	1	10	\N	\N
1208121	2024-11-03 14:00:00	47	66	4	1	51.00	49.00	16	12	6	1	14	14	6	4	2	0	\N	\N	39	1	10	\N	\N
1208114	2024-11-04 20:00:00	36	55	2	1	68.00	32.00	26	5	12	2	3	10	11	3	2	1	\N	\N	39	1	10	\N	\N
1208126	2024-11-09 15:00:00	52	36	0	2	36.00	64.00	13	17	5	7	10	11	1	8	1	1	1	0	39	1	11	\N	\N
1208227	2025-01-15 19:30:00	46	52	0	2	57.00	43.00	21	9	4	4	7	6	4	3	\N	\N	\N	\N	39	1	21	\N	\N
1208226	2025-01-16 19:30:00	57	51	0	2	46.00	54.00	5	11	3	5	13	14	1	9	2	2	\N	\N	39	1	21	\N	\N
1208238	2025-01-18 15:00:00	46	36	0	2	39.00	61.00	8	17	4	2	8	8	5	2	3	1	\N	\N	39	1	22	\N	\N
1208242	2025-01-18 15:00:00	48	52	0	2	54.00	46.00	7	12	0	7	13	10	2	4	3	0	1	0	39	1	22	\N	\N
1208233	2025-01-18 17:30:00	42	66	2	2	66.00	34.00	18	8	6	4	10	18	10	1	2	3	\N	\N	39	1	22	\N	\N
1208241	2025-01-19 14:00:00	65	41	3	2	45.00	55.00	14	10	5	4	4	18	2	8	0	4	\N	\N	39	1	22	\N	\N
1208235	2025-01-20 20:00:00	49	39	3	1	63.00	37.00	19	9	7	4	8	14	3	6	4	2	\N	\N	39	1	22	\N	\N
1208248	2025-01-25 15:00:00	40	57	4	1	70.00	30.00	16	3	6	3	10	11	3	4	0	2	\N	\N	39	1	23	\N	\N
1208245	2025-01-25 15:00:00	51	45	0	1	69.00	31.00	16	3	1	1	8	11	9	1	4	4	\N	\N	39	1	23	\N	\N
1208246	2025-01-26 14:00:00	52	55	1	2	47.00	53.00	16	13	5	6	8	11	4	7	2	2	\N	\N	39	1	23	\N	\N
1208247	2025-01-26 19:00:00	36	33	0	1	51.00	49.00	9	4	3	1	7	9	3	0	0	1	\N	\N	39	1	23	\N	\N
1208253	2025-02-01 15:00:00	35	40	0	2	49.00	51.00	14	19	3	7	15	9	3	3	2	3	\N	\N	39	1	24	\N	\N
1208262	2025-02-01 17:30:00	39	66	2	0	31.00	69.00	8	10	5	3	20	13	5	8	2	3	\N	\N	39	1	24	\N	\N
1208255	2025-02-02 14:00:00	55	47	0	2	54.00	46.00	20	13	4	2	4	11	10	3	0	1	\N	\N	39	1	24	\N	\N
1208166	2025-02-12 19:30:00	45	40	2	2	37.00	63.00	10	6	3	4	9	20	2	3	4	4	1	1	39	1	15	\N	\N
1208267	2025-02-15 12:30:00	46	42	0	2	40.00	60.00	6	11	2	5	9	10	3	7	2	1	\N	\N	39	1	25	\N	\N
1208272	2025-02-15 15:00:00	48	55	0	1	59.00	41.00	13	14	3	5	10	13	9	2	1	1	\N	\N	39	1	25	\N	\N
1208263	2025-02-15 15:00:00	66	57	1	1	76.00	24.00	25	4	6	3	7	11	16	1	0	5	0	1	39	1	25	\N	\N
1208271	2025-02-16 16:30:00	47	33	1	0	56.00	44.00	22	16	7	6	13	9	10	5	1	2	\N	\N	39	1	25	\N	\N
1208276	2025-02-22 12:30:00	45	33	2	2	38.00	62.00	9	9	8	3	12	9	7	8	4	1	\N	\N	39	1	26	\N	\N
1208277	2025-02-22 15:00:00	36	52	0	2	62.00	38.00	10	10	0	5	10	7	7	7	1	3	\N	\N	39	1	26	\N	\N
1208274	2025-02-22 15:00:00	42	48	0	1	68.00	32.00	20	5	2	2	16	15	2	0	1	3	1	0	39	1	26	\N	\N
1208281	2025-02-23 14:00:00	34	65	4	3	57.00	43.00	13	17	5	5	11	13	7	6	1	4	\N	\N	39	1	26	\N	\N
1208284	2025-02-25 19:30:00	51	35	2	1	43.00	57.00	11	19	4	5	12	14	1	9	2	1	\N	\N	39	1	27	\N	\N
1208127	2024-11-09 20:00:00	40	66	2	0	62.00	38.00	14	12	5	2	11	15	2	9	0	3	\N	\N	39	1	11	\N	\N
1208365	2025-05-03 14:00:00	55	33	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	35	\N	\N
1208130	2024-11-10 14:00:00	47	57	1	2	66.00	34.00	17	8	5	3	10	19	12	2	1	5	\N	\N	39	1	11	\N	\N
1208139	2024-11-23 12:30:00	46	49	1	2	37.00	63.00	4	16	1	7	15	12	2	9	4	3	\N	\N	39	1	12	\N	\N
1208137	2024-11-23 15:00:00	36	39	1	4	59.00	41.00	10	10	3	5	14	14	7	2	3	0	\N	\N	39	1	12	\N	\N
1208134	2024-11-23 15:00:00	42	65	3	0	66.00	34.00	19	7	7	0	10	11	8	1	3	2	\N	\N	39	1	12	\N	\N
1208136	2024-11-23 15:00:00	45	55	0	0	59.00	41.00	27	9	5	2	8	10	10	4	\N	\N	0	1	39	1	12	\N	\N
1208140	2024-11-23 17:30:00	50	47	0	4	58.00	42.00	23	9	5	7	19	9	9	3	4	2	\N	\N	39	1	12	\N	\N
1208141	2024-11-25 20:00:00	34	48	0	2	53.00	47.00	18	15	2	6	11	8	8	3	1	0	\N	\N	39	1	12	\N	\N
1208146	2024-11-30 15:00:00	52	34	1	1	49.00	51.00	16	1	4	0	12	11	8	9	3	3	\N	\N	39	1	13	\N	\N
1208149	2024-11-30 15:00:00	65	57	1	0	45.00	55.00	12	7	5	3	5	16	8	7	1	3	\N	\N	39	1	13	\N	\N
1208150	2024-12-01 13:30:00	47	36	1	1	51.00	49.00	8	14	3	6	4	14	7	11	0	1	0	1	39	1	13	\N	\N
1208147	2024-12-01 16:00:00	40	50	2	0	44.00	56.00	18	8	7	2	9	8	7	4	1	3	\N	\N	39	1	13	\N	\N
1208161	2024-12-04 19:30:00	34	40	3	3	41.00	59.00	17	16	6	5	9	17	5	6	2	5	\N	\N	39	1	14	\N	\N
1208156	2024-12-04 19:30:00	45	39	4	0	44.00	56.00	13	6	4	2	10	8	3	4	2	0	\N	\N	39	1	14	\N	\N
1208155	2024-12-04 20:15:00	66	55	3	1	49.00	51.00	20	9	10	1	11	15	10	5	2	2	\N	\N	39	1	14	\N	\N
1208153	2024-12-05 20:15:00	35	47	1	0	35.00	65.00	21	12	8	4	15	8	5	9	2	2	\N	\N	39	1	14	\N	\N
1208163	2024-12-07 15:00:00	66	41	1	0	47.00	53.00	18	4	5	0	18	15	14	1	1	3	\N	\N	39	1	15	\N	\N
1208167	2024-12-08 14:00:00	36	42	1	1	34.00	66.00	2	12	2	4	10	9	0	6	4	2	\N	\N	39	1	15	\N	\N
1208171	2024-12-08 16:30:00	47	49	3	4	39.00	61.00	13	17	5	8	17	11	5	10	2	3	\N	\N	39	1	15	\N	\N
1208179	2024-12-14 15:00:00	34	46	4	0	59.00	41.00	27	4	11	1	7	16	5	2	3	3	\N	\N	39	1	16	\N	\N
1208174	2024-12-14 15:00:00	42	45	0	0	77.00	23.00	13	2	5	0	6	9	8	2	0	3	\N	\N	39	1	16	\N	\N
1208175	2024-12-15 14:00:00	51	52	1	3	65.00	35.00	17	13	5	5	11	15	8	5	1	4	\N	\N	39	1	16	\N	\N
1208176	2024-12-15 19:00:00	49	55	2	1	62.00	38.00	26	9	8	4	11	7	8	5	2	2	1	0	39	1	16	\N	\N
1208183	2024-12-21 12:30:00	66	50	2	1	44.00	56.00	11	12	6	6	14	7	5	4	3	3	\N	\N	39	1	17	\N	\N
1208188	2024-12-21 15:00:00	57	34	0	4	42.00	58.00	10	15	2	7	9	7	2	1	2	0	\N	\N	39	1	17	\N	\N
1208190	2024-12-22 14:00:00	33	35	0	3	60.00	40.00	23	10	7	5	11	11	13	1	1	3	\N	\N	39	1	17	\N	\N
1208189	2024-12-22 14:00:00	46	39	0	3	54.00	46.00	9	8	5	4	15	16	6	1	2	0	\N	\N	39	1	17	\N	\N
1208198	2024-12-26 12:30:00	50	45	1	1	66.00	34.00	24	8	5	3	5	10	8	5	1	4	\N	\N	39	1	18	\N	\N
1208201	2024-12-26 15:00:00	41	48	0	1	54.00	46.00	18	16	5	2	15	8	2	2	1	2	\N	\N	39	1	18	\N	\N
1208200	2024-12-26 15:00:00	65	47	1	0	30.00	70.00	10	13	3	4	12	13	2	7	3	4	0	1	39	1	18	\N	\N
1208195	2024-12-27 19:30:00	51	55	0	0	58.00	42.00	24	8	7	3	6	12	5	3	0	2	\N	\N	39	1	18	\N	\N
1208209	2024-12-29 14:30:00	46	50	0	2	54.00	46.00	11	14	4	5	11	6	4	4	2	1	\N	\N	39	1	19	\N	\N
1208211	2024-12-29 15:00:00	47	39	2	2	48.00	52.00	13	11	3	3	9	10	5	5	1	2	\N	\N	39	1	19	\N	\N
1208212	2024-12-29 17:15:00	48	40	0	5	46.00	54.00	7	22	0	13	7	10	2	6	\N	\N	\N	\N	39	1	19	\N	\N
1208210	2024-12-30 20:00:00	33	34	0	2	53.00	47.00	10	12	0	4	13	8	2	3	1	1	\N	\N	39	1	19	\N	\N
1208221	2025-01-04 12:30:00	47	34	1	2	57.00	43.00	13	14	4	4	11	15	9	10	1	4	\N	\N	39	1	20	\N	\N
1208219	2025-01-04 15:00:00	50	48	4	1	56.00	44.00	10	17	7	4	8	13	7	1	2	1	\N	\N	39	1	20	\N	\N
1208214	2025-01-04 15:00:00	66	46	2	1	61.00	39.00	13	4	5	2	10	11	6	2	0	1	\N	\N	39	1	20	\N	\N
1208218	2025-01-05 16:30:00	40	33	2	2	53.00	47.00	19	13	6	4	10	13	5	9	2	4	\N	\N	39	1	20	\N	\N
1208229	2025-01-14 19:30:00	48	36	3	2	44.00	56.00	4	21	3	5	9	18	0	3	3	3	\N	\N	39	1	21	\N	\N
1208290	2025-02-25 20:15:00	49	41	4	0	60.00	40.00	19	7	10	2	6	9	4	2	1	2	\N	\N	39	1	27	\N	\N
1208283	2025-02-26 19:30:00	55	45	1	1	52.00	48.00	12	14	3	4	3	6	2	5	2	1	\N	\N	39	1	27	\N	\N
1208291	2025-02-26 20:15:00	40	34	2	0	61.00	39.00	12	3	3	0	12	11	4	2	0	1	\N	\N	39	1	27	\N	\N
1208297	2025-03-08 15:00:00	40	41	3	1	71.00	29.00	28	6	7	4	10	9	6	4	2	1	\N	\N	39	1	28	\N	\N
1208296	2025-03-08 15:00:00	52	57	1	0	55.00	45.00	19	15	4	8	8	7	5	4	4	3	\N	\N	39	1	28	\N	\N
1208300	2025-03-09 14:00:00	47	35	2	2	61.00	39.00	12	17	4	8	15	16	3	6	3	3	\N	\N	39	1	28	\N	\N
1208298	2025-03-09 16:30:00	33	42	1	1	32.00	68.00	10	17	6	6	8	11	2	9	0	1	\N	\N	39	1	28	\N	\N
1208306	2025-03-15 15:00:00	45	48	1	1	54.00	46.00	13	10	5	5	12	8	6	5	1	2	\N	\N	39	1	29	\N	\N
1208303	2025-03-15 17:30:00	35	55	1	2	59.00	41.00	17	10	5	4	13	7	4	3	3	0	\N	\N	39	1	29	\N	\N
1208304	2025-03-16 13:30:00	42	49	1	0	41.00	59.00	12	8	4	2	10	13	5	4	3	3	\N	\N	39	1	29	\N	\N
1180549	2024-07-28 00:30:00	120	135	0	3	59.00	41.00	19	12	10	5	14	15	8	1	2	4	\N	\N	71	1	20	\N	\N
1180551	2024-07-28 14:00:00	794	124	0	1	59.00	41.00	13	7	2	3	12	13	5	6	1	2	\N	\N	71	1	20	\N	\N
1180548	2024-07-28 19:00:00	127	144	2	0	53.00	47.00	12	12	6	3	9	12	6	3	3	2	\N	\N	71	1	20	\N	\N
1180546	2024-07-28 22:00:00	1062	131	2	1	68.00	32.00	10	11	4	7	17	16	4	4	3	3	1	0	71	1	20	\N	\N
1180557	2024-08-03 19:00:00	136	1193	1	0	47.00	53.00	17	9	3	2	16	17	4	5	3	3	\N	\N	71	1	21	\N	\N
1180559	2024-08-03 22:00:00	133	794	2	2	64.00	36.00	11	7	3	3	8	18	4	3	4	1	\N	\N	71	1	21	\N	\N
1180563	2024-08-03 23:00:00	144	120	1	4	48.00	52.00	9	13	3	9	17	14	3	7	3	3	1	1	71	1	21	\N	\N
1180561	2024-08-04 00:30:00	126	127	1	0	59.00	41.00	15	8	3	0	11	13	8	3	1	3	\N	\N	71	1	21	\N	\N
1180560	2024-08-04 19:00:00	131	152	1	1	64.00	36.00	34	6	10	3	16	15	11	3	2	7	0	3	71	1	21	\N	\N
1208228	2025-01-14 20:00:00	65	40	1	1	29.00	71.00	6	23	3	7	7	10	0	9	2	1	\N	\N	39	1	21	\N	\N
1180364	2024-04-13 21:30:00	140	152	1	1	47.00	53.00	10	15	3	4	11	15	0	4	4	6	\N	\N	71	1	1	\N	\N
1180361	2024-04-14 00:00:00	126	154	1	2	72.00	28.00	14	6	5	2	10	14	11	4	2	3	\N	\N	71	1	1	\N	\N
1208363	2025-05-03 16:30:00	42	35	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	35	\N	\N
1180359	2024-04-14 19:00:00	133	130	2	1	47.00	53.00	15	9	3	2	19	10	3	5	4	1	\N	\N	71	1	1	\N	\N
1180362	2024-04-14 19:00:00	134	1193	4	0	62.00	38.00	20	1	9	0	16	9	7	0	0	3	\N	\N	71	1	1	\N	\N
1180356	2024-04-14 20:00:00	135	120	3	2	56.00	44.00	15	6	5	3	12	11	6	3	4	3	0	1	71	1	1	\N	\N
1180367	2024-04-17 00:30:00	118	124	2	1	40.00	60.00	12	9	5	3	15	23	4	3	4	5	\N	\N	71	1	2	\N	\N
1180365	2024-04-17 22:00:00	130	134	2	0	48.00	52.00	14	4	7	0	7	13	9	2	1	3	\N	\N	71	1	2	\N	\N
1180370	2024-04-17 23:00:00	121	119	0	1	64.00	36.00	18	5	3	2	17	21	6	2	2	4	\N	\N	71	1	2	\N	\N
1180372	2024-04-17 23:00:00	154	135	1	1	39.00	61.00	14	14	3	6	13	10	7	5	2	3	0	1	71	1	2	\N	\N
1180366	2024-04-17 23:00:00	1062	140	1	1	68.00	32.00	22	5	6	1	12	10	9	2	2	4	\N	\N	71	1	2	\N	\N
1180369	2024-04-19 00:30:00	120	144	1	0	53.00	47.00	13	12	4	3	13	11	8	8	3	4	\N	\N	71	1	2	\N	\N
1180375	2024-04-20 21:30:00	130	1193	1	0	57.00	43.00	7	14	4	3	10	5	3	4	4	2	\N	\N	71	1	3	\N	\N
1180381	2024-04-20 21:30:00	794	131	1	0	35.00	65.00	10	15	3	4	21	10	3	4	4	2	\N	\N	71	1	3	\N	\N
1180380	2024-04-21 19:00:00	121	127	0	0	49.00	51.00	12	8	1	3	23	14	6	5	5	4	\N	\N	71	1	3	\N	\N
1180377	2024-04-21 19:00:00	136	118	2	2	42.00	58.00	13	20	8	7	12	13	2	7	3	3	\N	\N	71	1	3	\N	\N
1180379	2024-04-21 21:30:00	120	152	5	1	56.00	44.00	13	12	6	1	22	10	5	4	3	4	0	1	71	1	3	\N	\N
1180389	2024-04-27 19:00:00	133	140	0	4	58.00	42.00	21	17	5	10	13	7	5	4	1	0	\N	\N	71	1	4	\N	\N
1180387	2024-04-28 00:00:00	118	130	1	0	60.00	40.00	14	3	4	2	10	15	4	0	2	4	0	2	71	1	4	\N	\N
1180390	2024-04-28 19:00:00	131	124	3	0	31.00	69.00	17	13	7	2	15	15	6	8	4	2	\N	\N	71	1	4	\N	\N
1180386	2024-04-28 19:00:00	135	136	3	1	54.00	46.00	15	8	6	3	12	6	10	4	2	0	\N	\N	71	1	4	\N	\N
1180392	2024-04-28 21:30:00	154	794	1	1	44.00	56.00	22	10	5	4	9	6	12	6	1	1	\N	\N	71	1	4	\N	\N
1180385	2024-04-28 23:00:00	119	144	1	1	72.00	28.00	22	4	5	2	13	12	13	0	0	4	\N	\N	71	1	4	\N	\N
1180398	2024-05-04 19:00:00	124	1062	2	2	43.00	57.00	11	19	5	7	11	18	4	10	5	2	\N	\N	71	1	5	\N	\N
1180400	2024-05-05 00:00:00	131	154	0	0	65.00	35.00	18	12	9	2	14	17	9	5	1	7	\N	\N	71	1	5	\N	\N
1180397	2024-05-05 19:00:00	136	126	1	3	33.00	67.00	6	20	2	8	10	13	3	8	3	4	1	0	71	1	5	\N	\N
1180399	2024-05-05 21:30:00	120	118	1	2	55.00	45.00	16	10	5	4	10	5	5	1	2	2	\N	\N	71	1	5	\N	\N
1180408	2024-05-11 19:00:00	127	131	2	0	58.00	42.00	18	13	9	3	12	16	13	6	1	1	\N	\N	71	1	6	\N	\N
1180413	2024-05-12 19:00:00	144	135	0	1	46.00	54.00	17	12	5	5	13	10	5	5	1	2	\N	\N	71	1	6	\N	\N
1180412	2024-05-12 19:00:00	154	120	1	1	43.00	57.00	10	11	4	5	12	19	6	5	4	6	\N	\N	71	1	6	\N	\N
1180409	2024-05-12 21:30:00	133	136	2	1	57.00	43.00	17	13	8	5	12	12	4	4	5	2	0	1	71	1	6	\N	\N
1180415	2024-06-01 19:00:00	130	794	0	2	44.00	56.00	9	14	1	4	16	19	6	0	4	2	\N	\N	71	1	7	\N	\N
1180417	2024-06-01 19:00:00	136	144	0	2	33.00	67.00	12	12	3	5	7	9	3	4	3	2	2	0	71	1	7	\N	\N
1180423	2024-06-01 21:30:00	1193	119	0	1	36.00	64.00	8	9	3	3	12	21	0	2	4	4	\N	\N	71	1	7	\N	\N
1180419	2024-06-02 19:00:00	133	127	1	6	27.00	73.00	2	30	2	18	18	6	1	8	2	0	1	0	71	1	7	\N	\N
1180424	2024-06-02 19:00:00	140	121	1	2	39.00	61.00	12	23	4	5	17	9	4	6	7	3	\N	\N	71	1	7	\N	\N
1180421	2024-06-02 21:30:00	126	135	2	0	56.00	44.00	11	10	4	3	18	11	4	2	2	2	0	1	71	1	7	\N	\N
1180404	2024-06-05 22:00:00	152	144	1	0	42.00	58.00	8	22	2	5	13	12	4	7	3	4	1	0	71	1	5	\N	\N
1180373	2024-06-05 23:00:00	1193	136	0	0	54.00	46.00	11	13	0	4	19	14	4	3	3	4	\N	\N	71	1	2	\N	\N
1180433	2024-06-11 22:00:00	144	131	2	2	73.00	27.00	22	7	7	3	12	13	3	4	3	5	0	1	71	1	8	\N	\N
1180429	2024-06-11 23:00:00	120	124	1	0	44.00	56.00	19	6	6	0	22	13	14	2	3	3	\N	\N	71	1	8	\N	\N
1180426	2024-06-13 22:00:00	135	1193	2	1	51.00	49.00	12	16	6	5	9	12	6	4	3	2	\N	\N	71	1	8	\N	\N
1180425	2024-06-13 23:00:00	119	126	0	0	54.00	46.00	7	9	0	4	15	18	5	3	5	4	\N	\N	71	1	8	\N	\N
1180432	2024-06-13 23:00:00	134	140	3	1	57.00	43.00	23	12	7	4	9	12	5	3	0	1	\N	\N	71	1	8	\N	\N
1180427	2024-06-14 00:30:00	118	154	1	0	54.00	46.00	12	21	3	6	14	9	5	9	6	1	\N	\N	71	1	8	\N	\N
1180441	2024-06-15 21:30:00	794	152	2	1	36.00	64.00	6	14	2	6	12	12	1	1	4	4	1	0	71	1	9	\N	\N
1180440	2024-06-16 19:00:00	131	126	2	2	40.00	60.00	16	12	8	7	15	10	9	5	4	5	1	0	71	1	9	\N	\N
1180437	2024-06-16 19:00:00	136	119	2	1	39.00	61.00	11	15	4	5	6	16	4	2	1	5	\N	\N	71	1	9	\N	\N
1180435	2024-06-16 21:30:00	130	120	1	2	45.00	55.00	15	14	4	5	12	11	7	4	3	3	\N	\N	71	1	9	\N	\N
1180444	2024-06-16 21:30:00	140	118	2	2	32.00	68.00	17	22	5	6	14	13	6	7	4	1	1	0	71	1	9	\N	\N
1180436	2024-06-17 23:30:00	1062	121	0	4	52.00	48.00	11	22	3	9	16	16	3	6	5	3	2	0	71	1	9	\N	\N
1180449	2024-06-19 22:00:00	120	134	1	1	62.00	38.00	8	16	1	6	13	14	5	9	0	5	\N	\N	71	1	10	\N	\N
1180451	2024-06-19 23:00:00	126	1193	0	1	66.00	34.00	15	11	4	3	5	16	4	6	2	3	\N	\N	71	1	10	\N	\N
1180452	2024-06-19 23:00:00	154	130	1	0	52.00	48.00	13	8	4	2	15	7	8	3	3	4	0	1	71	1	10	\N	\N
1180445	2024-06-20 00:30:00	119	131	1	0	47.00	53.00	11	13	5	3	17	13	3	7	1	2	\N	\N	71	1	10	\N	\N
1180447	2024-06-20 21:30:00	136	1062	4	2	39.00	61.00	12	19	6	7	15	13	2	4	2	2	\N	\N	71	1	10	\N	\N
1180450	2024-06-21 00:30:00	121	794	2	1	41.00	59.00	24	13	7	3	10	9	10	3	0	2	\N	\N	71	1	10	\N	\N
1180464	2024-06-22 19:00:00	140	120	2	1	38.00	62.00	16	11	4	2	16	14	4	7	4	3	\N	\N	71	1	11	\N	\N
1208022	2024-08-17 11:30:00	57	40	0	2	38.00	62.00	7	18	2	5	9	18	2	10	3	1	\N	\N	39	1	1	\N	\N
1208025	2024-08-17 14:00:00	34	41	1	0	22.00	78.00	3	19	1	4	15	16	3	12	2	4	1	0	39	1	1	\N	\N
1180455	2024-06-22 20:30:00	130	119	0	1	58.00	42.00	10	16	2	2	12	11	5	4	3	2	\N	\N	71	1	11	\N	\N
1208021	2024-08-16 19:00:00	33	36	1	0	55.00	45.00	14	10	5	2	12	10	7	8	2	3	\N	\N	39	1	1	\N	\N
1208023	2024-08-17 14:00:00	42	39	2	0	53.00	47.00	18	9	6	3	17	14	8	2	2	2	\N	\N	39	1	1	\N	\N
1208024	2024-08-17 14:00:00	45	51	0	3	38.00	62.00	9	10	1	5	8	8	1	5	1	1	1	0	39	1	1	\N	\N
1208366	2025-05-04 13:00:00	51	34	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	35	\N	\N
1208026	2024-08-17 14:00:00	65	35	1	1	53.00	47.00	14	13	8	4	17	8	2	6	1	3	\N	\N	39	1	1	\N	\N
1208027	2024-08-17 16:30:00	48	66	1	2	52.00	48.00	14	15	3	3	18	11	5	3	1	2	\N	\N	39	1	1	\N	\N
1208028	2024-08-18 13:00:00	55	52	2	1	46.00	54.00	9	14	5	6	6	15	4	7	1	5	\N	\N	39	1	1	\N	\N
1208029	2024-08-18 15:30:00	49	50	0	2	48.00	52.00	10	11	3	5	12	9	4	3	1	1	\N	\N	39	1	1	\N	\N
1208030	2024-08-19 19:00:00	46	47	1	1	30.00	70.00	7	15	3	7	11	12	2	13	1	1	\N	\N	39	1	1	\N	\N
1208033	2024-08-24 11:30:00	51	33	2	1	48.00	52.00	14	11	5	4	9	13	4	4	1	2	\N	\N	39	1	2	\N	\N
1208035	2024-08-24 14:00:00	36	46	2	1	54.00	46.00	18	10	6	4	14	13	7	5	2	2	\N	\N	39	1	2	\N	\N
1208038	2024-08-24 14:00:00	41	65	0	1	65.00	35.00	5	23	1	8	14	14	4	10	3	3	\N	\N	39	1	2	\N	\N
1208039	2024-08-24 14:00:00	47	45	4	0	71.00	29.00	13	10	7	1	11	15	12	5	\N	\N	\N	\N	39	1	2	\N	\N
1208037	2024-08-24 14:00:00	50	57	4	1	75.00	25.00	14	1	5	1	4	15	10	1	2	3	\N	\N	39	1	2	\N	\N
1208034	2024-08-24 14:00:00	52	48	0	2	58.00	42.00	14	18	2	3	9	17	3	3	1	1	\N	\N	39	1	2	\N	\N
1180463	2024-06-22 21:30:00	1193	144	0	0	53.00	47.00	10	18	3	9	9	12	5	4	3	1	\N	\N	71	1	11	\N	\N
1180459	2024-06-23 00:30:00	133	126	4	1	41.00	59.00	14	10	7	2	13	14	2	8	3	1	\N	\N	71	1	11	\N	\N
1180457	2024-06-23 19:00:00	118	135	4	1	64.00	36.00	14	7	6	1	6	13	3	1	0	3	0	1	71	1	11	\N	\N
1180458	2024-06-23 19:00:00	124	127	0	1	54.00	46.00	2	14	0	4	16	13	2	6	4	3	1	0	71	1	11	\N	\N
1180462	2024-06-23 19:00:00	134	131	1	1	54.00	46.00	20	15	7	6	19	12	11	2	2	1	\N	\N	71	1	11	\N	\N
1180460	2024-06-23 21:30:00	121	152	3	1	57.00	43.00	28	16	10	8	14	7	10	4	2	3	\N	\N	71	1	11	\N	\N
1180461	2024-06-23 21:30:00	794	136	2	1	64.00	36.00	16	10	6	5	10	11	6	7	3	2	\N	\N	71	1	11	\N	\N
1180456	2024-06-23 21:30:00	1062	154	1	1	67.00	33.00	21	13	8	3	15	17	3	4	3	2	\N	\N	71	1	11	\N	\N
1180469	2024-06-26 22:00:00	120	794	2	1	49.00	51.00	12	13	4	6	13	12	7	4	2	3	\N	\N	71	1	12	\N	\N
1180466	2024-06-26 22:00:00	135	134	2	0	49.00	51.00	22	14	7	3	8	6	7	12	2	2	\N	\N	71	1	12	\N	\N
1180470	2024-06-26 23:00:00	131	1193	1	1	66.00	34.00	24	13	7	4	10	13	13	1	3	4	\N	\N	71	1	12	\N	\N
1180473	2024-06-26 23:00:00	144	130	1	1	49.00	51.00	16	11	5	4	13	11	5	8	7	4	\N	\N	71	1	12	\N	\N
1180474	2024-06-26 23:00:00	152	127	2	1	53.00	47.00	15	9	8	5	9	10	7	8	2	1	\N	\N	71	1	12	\N	\N
1180467	2024-06-27 00:30:00	118	133	2	1	63.00	37.00	17	9	8	3	14	15	7	0	0	5	0	1	71	1	12	\N	\N
1180465	2024-06-27 00:30:00	119	1062	1	2	46.00	54.00	13	15	6	5	17	10	5	9	4	4	\N	\N	71	1	12	\N	\N
1180472	2024-06-27 00:30:00	154	121	3	0	32.00	68.00	12	17	6	7	17	11	3	8	2	2	\N	\N	71	1	12	\N	\N
1180468	2024-06-27 22:00:00	124	136	0	1	64.00	36.00	12	9	5	6	14	12	6	2	3	1	\N	\N	71	1	12	\N	\N
1180471	2024-06-27 23:00:00	126	140	2	1	62.00	38.00	13	10	6	2	10	22	2	2	2	4	\N	\N	71	1	12	\N	\N
1180479	2024-06-29 21:30:00	133	120	1	1	54.00	46.00	10	13	2	6	13	23	0	5	4	5	\N	\N	71	1	13	\N	\N
1180483	2024-06-29 21:30:00	1193	794	1	1	34.00	66.00	5	14	2	5	13	16	3	11	4	2	1	0	71	1	13	\N	\N
1180476	2024-06-30 14:00:00	1062	144	1	1	68.00	32.00	15	12	6	6	10	11	5	8	0	1	\N	\N	71	1	13	\N	\N
1180481	2024-06-30 19:00:00	126	118	3	1	41.00	59.00	10	15	4	6	15	9	4	4	4	1	\N	\N	71	1	13	\N	\N
1180475	2024-06-30 19:00:00	130	124	1	0	47.00	53.00	16	8	9	3	13	14	6	1	2	3	0	1	71	1	13	\N	\N
1180482	2024-06-30 19:00:00	154	152	2	1	38.00	62.00	19	12	7	3	22	16	7	5	2	0	\N	\N	71	1	13	\N	\N
1180478	2024-06-30 21:30:00	127	135	2	1	46.00	54.00	7	14	3	5	5	17	2	5	1	3	\N	\N	71	1	13	\N	\N
1180477	2024-06-30 21:30:00	136	134	0	1	59.00	41.00	16	7	3	2	12	16	7	6	3	2	\N	\N	71	1	13	\N	\N
1180484	2024-06-30 21:30:00	140	119	1	1	46.00	54.00	17	12	7	4	10	14	5	5	2	3	\N	\N	71	1	13	\N	\N
1180480	2024-07-01 23:00:00	121	131	2	0	49.00	51.00	20	13	10	3	18	10	7	3	3	4	1	0	71	1	13	\N	\N
1180489	2024-07-03 23:00:00	133	154	2	0	59.00	41.00	19	10	9	4	21	12	7	3	4	3	0	1	71	1	14	\N	\N
1180492	2024-07-04 00:30:00	134	126	1	2	45.00	55.00	12	13	4	8	19	8	6	2	1	3	1	0	71	1	14	\N	\N
1180491	2024-07-04 00:30:00	794	144	3	1	52.00	48.00	13	13	5	6	15	9	3	8	2	3	\N	\N	71	1	14	\N	\N
1180487	2024-07-04 22:00:00	118	152	2	0	57.00	43.00	22	10	9	2	15	9	6	7	0	4	\N	\N	71	1	14	\N	\N
1180488	2024-07-04 23:00:00	124	119	1	1	55.00	45.00	8	12	3	4	17	17	3	4	6	5	\N	\N	71	1	14	\N	\N
1180490	2024-07-04 23:00:00	131	136	3	2	44.00	56.00	14	18	5	6	15	10	9	9	4	3	\N	\N	71	1	14	\N	\N
1180498	2024-07-06 23:00:00	127	1193	1	1	66.00	34.00	20	7	10	3	14	12	7	0	1	3	\N	\N	71	1	15	\N	\N
1180504	2024-07-07 19:00:00	152	130	3	0	49.00	51.00	14	13	6	5	14	10	3	8	1	3	\N	\N	71	1	15	\N	\N
1180502	2024-07-07 19:00:00	154	124	1	0	42.00	58.00	19	11	6	3	13	14	12	3	1	2	\N	\N	71	1	15	\N	\N
1180500	2024-07-07 21:30:00	121	118	2	0	44.00	56.00	12	13	4	3	15	10	4	3	1	1	\N	\N	71	1	15	\N	\N
1180503	2024-07-07 21:30:00	144	134	1	2	43.00	57.00	12	17	3	6	11	11	4	11	1	3	1	0	71	1	15	\N	\N
1180505	2024-07-10 21:30:00	130	135	0	2	45.00	55.00	8	14	3	6	9	10	1	5	1	1	1	0	71	1	16	\N	\N
1208040	2024-08-25 13:00:00	39	49	2	6	40.00	60.00	12	14	4	8	13	13	5	5	2	3	\N	\N	39	1	2	\N	\N
1208041	2024-08-31 11:30:00	42	51	1	1	36.00	64.00	11	22	7	4	12	7	3	7	5	2	1	0	39	1	3	\N	\N
1208044	2024-08-31 14:00:00	45	35	2	3	47.00	53.00	18	17	8	7	6	11	8	4	2	1	\N	\N	39	1	3	\N	\N
1208042	2024-08-31 14:00:00	55	41	3	1	37.00	63.00	20	18	7	6	10	7	2	8	2	1	\N	\N	39	1	3	\N	\N
1208049	2024-08-31 14:00:00	65	39	1	1	52.00	48.00	16	11	5	3	15	18	7	3	3	4	\N	\N	39	1	3	\N	\N
1208050	2024-08-31 16:30:00	48	50	1	3	32.00	68.00	10	23	2	8	10	3	3	11	3	2	\N	\N	39	1	3	\N	\N
1208043	2024-09-01 12:30:00	49	52	1	1	63.00	37.00	13	9	7	3	9	13	4	4	4	2	\N	\N	39	1	3	\N	\N
1208058	2024-09-14 11:30:00	41	33	0	3	44.00	56.00	6	20	4	10	11	14	0	7	1	4	1	0	39	1	4	\N	\N
1208055	2024-09-14 14:00:00	36	48	1	1	55.00	45.00	21	11	5	3	15	18	3	2	2	3	\N	\N	39	1	4	\N	\N
1208057	2024-09-14 14:00:00	50	55	2	1	54.00	46.00	18	8	7	5	9	3	12	3	3	1	\N	\N	39	1	4	\N	\N
1208367	2025-05-04 15:30:00	49	40	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	35	\N	\N
1208054	2024-09-14 14:00:00	52	46	2	2	67.00	33.00	20	9	4	4	11	15	5	2	0	3	\N	\N	39	1	4	\N	\N
1208052	2024-09-14 16:30:00	66	45	3	2	73.00	27.00	17	6	8	2	10	12	6	2	1	4	\N	\N	39	1	4	\N	\N
1208059	2024-09-15 13:00:00	47	42	0	1	64.00	36.00	15	7	5	4	13	10	7	6	5	3	\N	\N	39	1	4	\N	\N
1208070	2024-09-21 11:30:00	48	49	0	3	53.00	47.00	15	12	7	5	17	9	6	5	5	2	\N	\N	39	1	5	\N	\N
1208064	2024-09-21 14:00:00	36	34	3	1	39.00	61.00	22	16	11	5	16	8	6	0	6	0	\N	\N	39	1	5	\N	\N
1208068	2024-09-21 14:00:00	41	57	1	1	54.00	46.00	11	13	3	6	16	16	2	10	4	4	\N	\N	39	1	5	\N	\N
1208065	2024-09-21 14:00:00	46	45	1	1	59.00	41.00	12	17	2	5	11	12	6	1	1	2	\N	\N	39	1	5	\N	\N
1208061	2024-09-21 14:00:00	66	39	3	1	53.00	47.00	9	10	4	4	11	16	6	5	3	6	\N	\N	39	1	5	\N	\N
1208062	2024-09-22 13:00:00	51	65	2	2	70.00	30.00	14	4	3	3	12	11	9	1	3	6	0	1	39	1	5	\N	\N
1208078	2024-09-28 11:30:00	34	50	1	1	38.00	62.00	11	16	4	6	14	10	5	6	4	4	\N	\N	39	1	6	\N	\N
1208072	2024-09-28 14:00:00	42	46	4	2	75.00	25.00	36	5	16	3	11	6	17	0	2	4	\N	\N	39	1	6	\N	\N
1208074	2024-09-28 14:00:00	49	51	4	2	41.00	59.00	15	15	7	5	11	8	8	2	3	2	\N	\N	39	1	6	\N	\N
1208073	2024-09-28 14:00:00	55	48	1	1	57.00	43.00	8	19	3	3	2	11	7	6	2	3	\N	\N	39	1	6	\N	\N
1208080	2024-09-28 16:30:00	39	40	1	2	45.00	55.00	8	10	3	6	16	8	2	10	2	3	\N	\N	39	1	6	\N	\N
1208077	2024-09-29 15:30:00	33	47	0	3	39.00	61.00	11	24	2	10	16	14	5	3	5	3	1	0	39	1	6	\N	\N
1208086	2024-10-05 11:30:00	52	40	0	1	32.00	68.00	9	16	5	4	7	15	3	8	4	2	\N	\N	39	1	7	\N	\N
1208081	2024-10-05 14:00:00	42	41	3	1	59.00	41.00	29	8	6	2	10	9	13	1	0	3	\N	\N	39	1	7	\N	\N
1208090	2024-10-05 14:00:00	48	57	4	1	53.00	47.00	23	9	13	2	12	6	5	5	0	1	\N	\N	39	1	7	\N	\N
1208089	2024-10-05 14:00:00	50	36	3	2	58.00	42.00	20	11	7	4	4	10	8	3	2	1	\N	\N	39	1	7	\N	\N
1208087	2024-10-05 16:30:00	45	34	0	0	32.00	68.00	8	14	2	3	12	8	0	10	1	2	\N	\N	39	1	7	\N	\N
1208082	2024-10-06 13:00:00	66	33	0	0	54.00	46.00	11	10	1	4	12	11	6	3	1	5	\N	\N	39	1	7	\N	\N
1208084	2024-10-06 15:30:00	51	47	3	2	41.00	59.00	11	13	4	3	14	10	4	7	2	2	\N	\N	39	1	7	\N	\N
1208095	2024-10-19 14:00:00	33	55	2	1	50.00	50.00	23	8	11	2	4	5	9	2	2	2	\N	\N	39	1	8	\N	\N
1208092	2024-10-19 14:00:00	36	66	1	3	52.00	48.00	10	14	4	5	8	11	6	11	3	5	1	1	39	1	8	\N	\N
1208093	2024-10-19 14:00:00	57	45	0	2	55.00	45.00	13	11	2	8	12	10	5	7	1	1	\N	\N	39	1	8	\N	\N
1208091	2024-10-19 16:30:00	35	42	2	0	49.00	51.00	13	6	4	1	12	11	7	4	1	1	0	1	39	1	8	\N	\N
1208094	2024-10-20 15:30:00	40	49	2	1	43.00	57.00	9	12	5	2	12	13	1	5	4	3	\N	\N	39	1	8	\N	\N
1208110	2024-10-25 19:00:00	46	65	1	3	64.00	36.00	11	20	1	5	16	9	6	7	5	3	\N	\N	39	1	9	\N	\N
1208111	2024-10-26 14:00:00	50	41	1	0	57.00	43.00	22	5	8	2	9	9	12	1	1	3	\N	\N	39	1	9	\N	\N
1208105	2024-10-26 14:00:00	55	57	4	3	65.00	35.00	20	11	9	5	7	10	4	5	0	3	0	1	39	1	9	\N	\N
1208109	2024-10-26 16:30:00	45	36	1	1	40.00	60.00	10	14	5	3	8	8	4	2	1	0	\N	\N	39	1	9	\N	\N
1208112	2024-10-27 13:00:00	48	33	2	1	43.00	57.00	12	18	3	5	6	7	6	5	5	1	\N	\N	39	1	9	\N	\N
1208108	2024-10-27 13:00:00	52	47	1	0	34.00	66.00	14	11	6	3	16	12	8	8	4	4	\N	\N	39	1	9	\N	\N
1208118	2024-11-02 12:30:00	34	42	1	0	36.00	64.00	9	10	4	1	16	18	4	6	4	4	\N	\N	39	1	10	\N	\N
1208113	2024-11-02 15:00:00	35	50	2	1	36.00	64.00	12	18	6	4	11	6	3	10	2	1	\N	\N	39	1	10	\N	\N
1208120	2024-11-02 15:00:00	41	45	1	0	65.00	35.00	9	16	2	5	14	18	3	6	4	2	\N	\N	39	1	10	\N	\N
1208119	2024-11-02 15:00:00	65	48	3	0	53.00	47.00	19	4	6	2	7	9	10	6	1	4	0	1	39	1	10	\N	\N
1208122	2024-11-02 17:30:00	39	52	2	2	57.00	43.00	11	19	6	7	7	9	3	6	1	2	\N	\N	39	1	10	\N	\N
1208117	2024-11-03 16:30:00	33	49	1	1	46.00	54.00	11	12	4	3	19	14	4	8	6	2	\N	\N	39	1	10	\N	\N
1208132	2024-11-09 15:00:00	39	41	2	0	29.00	71.00	8	9	4	0	14	12	1	9	1	4	\N	\N	39	1	11	\N	\N
1208131	2024-11-09 15:00:00	48	45	0	0	49.00	51.00	11	18	6	4	10	9	7	6	1	2	\N	\N	39	1	11	\N	\N
1208123	2024-11-09 15:00:00	55	35	3	2	52.00	48.00	12	15	6	3	8	16	6	4	2	4	\N	\N	39	1	11	\N	\N
1208124	2024-11-09 17:30:00	51	50	2	1	40.00	60.00	10	15	4	6	12	10	0	4	3	3	\N	\N	39	1	11	\N	\N
1208128	2024-11-10 14:00:00	33	46	3	0	51.00	49.00	13	6	3	5	9	5	1	5	0	1	\N	\N	39	1	11	\N	\N
1208129	2024-11-10 14:00:00	65	34	1	3	44.00	56.00	9	17	3	6	13	6	4	5	1	1	\N	\N	39	1	11	\N	\N
1208125	2024-11-10 16:30:00	49	42	1	1	49.00	51.00	17	13	3	3	12	12	4	3	4	2	\N	\N	39	1	11	\N	\N
1208133	2024-11-23 15:00:00	35	51	1	2	55.00	45.00	19	6	5	4	13	10	7	0	2	4	0	1	39	1	12	\N	\N
1208135	2024-11-23 15:00:00	66	52	2	2	70.00	30.00	17	13	5	6	10	11	10	1	3	2	\N	\N	39	1	12	\N	\N
1208142	2024-11-24 14:00:00	41	40	2	3	38.00	62.00	7	27	5	11	11	9	3	10	3	4	\N	\N	39	1	12	\N	\N
1208138	2024-11-24 16:30:00	57	33	1	1	40.00	60.00	11	11	6	4	11	10	4	3	\N	\N	\N	\N	39	1	12	\N	\N
1208144	2024-11-29 20:00:00	51	41	1	1	52.00	48.00	22	10	5	2	20	16	7	6	2	4	\N	\N	39	1	13	\N	\N
1208152	2024-11-30 15:00:00	39	35	2	4	60.00	40.00	10	12	3	8	13	11	3	4	5	1	\N	\N	39	1	13	\N	\N
1208143	2024-11-30 15:00:00	55	46	4	1	60.00	40.00	13	7	6	3	9	10	5	4	1	1	\N	\N	39	1	13	\N	\N
1208151	2024-11-30 17:30:00	48	42	2	5	40.00	60.00	12	16	5	7	10	13	2	10	4	1	\N	\N	39	1	13	\N	\N
1208148	2024-12-01 13:30:00	33	45	4	0	60.00	40.00	11	8	5	2	12	12	2	2	2	3	\N	\N	39	1	13	\N	\N
1208145	2024-12-01 13:30:00	49	66	3	0	64.00	36.00	17	10	8	4	21	6	3	4	2	2	\N	\N	39	1	13	\N	\N
1208158	2024-12-03 19:30:00	57	52	0	1	54.00	46.00	9	13	2	3	14	13	4	7	2	4	\N	\N	39	1	14	\N	\N
1208159	2024-12-03 20:15:00	46	48	3	1	39.00	61.00	8	31	6	10	9	7	3	9	2	2	\N	\N	39	1	14	\N	\N
1208162	2024-12-04 19:30:00	41	49	1	5	45.00	55.00	6	26	4	13	7	14	5	7	1	0	1	0	39	1	14	\N	\N
1208160	2024-12-04 19:30:00	50	65	3	0	66.00	34.00	17	12	7	3	7	15	8	2	2	4	\N	\N	39	1	14	\N	\N
1208154	2024-12-04 20:15:00	42	33	2	0	50.00	50.00	14	5	6	2	12	8	13	0	1	3	\N	\N	39	1	14	\N	\N
1208368	2025-05-05 19:00:00	52	65	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	35	\N	\N
1208157	2024-12-05 19:30:00	36	51	3	1	43.00	57.00	6	13	2	3	7	8	5	6	2	2	\N	\N	39	1	14	\N	\N
1208165	2024-12-07 15:00:00	52	50	2	2	32.00	68.00	12	12	3	4	4	10	6	8	1	2	0	1	39	1	15	\N	\N
1208164	2024-12-07 15:00:00	55	34	4	2	44.00	56.00	11	16	8	3	10	7	3	4	3	0	\N	\N	39	1	15	\N	\N
1208170	2024-12-07 17:30:00	33	65	2	3	71.00	29.00	17	11	7	3	10	13	5	3	0	2	\N	\N	39	1	15	\N	\N
1208169	2024-12-08 14:00:00	46	51	2	2	55.00	45.00	10	16	3	7	9	10	4	5	1	2	\N	\N	39	1	15	\N	\N
1208168	2024-12-08 14:00:00	57	35	1	2	43.00	57.00	18	22	5	6	9	13	6	13	2	1	\N	\N	39	1	15	\N	\N
1208172	2024-12-09 20:00:00	48	39	2	1	54.00	46.00	19	19	4	5	12	17	11	0	5	4	\N	\N	39	1	15	\N	\N
1208182	2024-12-14 15:00:00	39	57	1	2	54.00	46.00	16	10	6	5	13	9	7	3	2	2	1	0	39	1	16	\N	\N
1208177	2024-12-14 15:00:00	40	36	2	2	61.00	39.00	16	12	4	3	10	7	5	4	3	4	1	0	39	1	16	\N	\N
1208180	2024-12-14 17:30:00	65	66	2	1	50.00	50.00	17	8	6	2	12	6	4	3	0	1	\N	\N	39	1	16	\N	\N
1208178	2024-12-15 16:30:00	50	33	1	2	52.00	48.00	10	10	3	3	5	14	8	2	1	1	\N	\N	39	1	16	\N	\N
1208181	2024-12-15 19:00:00	41	47	0	5	42.00	58.00	9	18	3	9	8	15	2	5	1	3	\N	\N	39	1	16	\N	\N
1208173	2024-12-16 20:00:00	35	48	1	1	51.00	49.00	29	16	9	3	6	11	12	6	0	2	\N	\N	39	1	16	\N	\N
1208192	2024-12-21 15:00:00	48	51	1	1	46.00	54.00	11	12	4	6	14	20	8	4	2	2	\N	\N	39	1	17	\N	\N
1208184	2024-12-21 15:00:00	55	65	0	2	64.00	36.00	7	10	3	6	10	14	9	5	3	4	\N	\N	39	1	17	\N	\N
1208185	2024-12-21 17:30:00	52	42	1	5	42.00	58.00	15	14	6	6	9	8	3	3	2	2	\N	\N	39	1	17	\N	\N
1208187	2024-12-22 14:00:00	36	41	0	0	57.00	43.00	15	5	5	1	8	15	6	5	1	3	\N	\N	39	1	17	\N	\N
1208186	2024-12-22 14:00:00	45	49	0	0	25.00	75.00	5	12	4	5	20	12	2	5	4	1	\N	\N	39	1	17	\N	\N
1208191	2024-12-22 16:30:00	47	40	3	6	52.00	48.00	9	24	5	12	7	9	7	5	1	2	\N	\N	39	1	17	\N	\N
1208199	2024-12-26 15:00:00	34	66	3	0	63.00	37.00	22	4	8	1	15	10	9	6	2	1	0	1	39	1	18	\N	\N
1208193	2024-12-26 15:00:00	35	52	0	0	52.00	48.00	18	10	4	4	13	12	5	2	2	2	\N	\N	39	1	18	\N	\N
1208196	2024-12-26 15:00:00	49	36	1	2	47.00	53.00	12	14	8	7	13	13	3	1	1	3	\N	\N	39	1	18	\N	\N
1208202	2024-12-26 17:30:00	39	33	2	0	51.00	49.00	7	11	4	4	12	12	4	4	2	4	0	1	39	1	18	\N	\N
1208197	2024-12-26 20:00:00	40	46	3	1	69.00	31.00	19	4	7	1	17	5	14	1	3	2	\N	\N	39	1	18	\N	\N
1208194	2024-12-27 20:15:00	42	57	1	0	68.00	32.00	13	3	5	0	7	12	5	1	1	1	\N	\N	39	1	18	\N	\N
1208207	2024-12-29 15:00:00	36	35	2	2	52.00	48.00	11	16	6	9	7	16	1	7	1	3	\N	\N	39	1	19	\N	\N
1208206	2024-12-29 15:00:00	45	65	0	2	64.00	36.00	13	11	2	7	13	10	5	4	4	1	\N	\N	39	1	19	\N	\N
1208205	2024-12-29 15:00:00	52	41	2	1	46.00	54.00	19	7	10	3	18	19	8	7	2	3	\N	\N	39	1	19	\N	\N
1208208	2024-12-30 19:45:00	57	49	2	0	24.00	76.00	9	20	6	5	9	5	4	7	4	4	\N	\N	39	1	19	\N	\N
1208203	2024-12-30 19:45:00	66	51	2	2	60.00	40.00	20	13	4	4	9	14	12	3	2	3	\N	\N	39	1	19	\N	\N
1208204	2025-01-01 17:30:00	55	42	1	3	51.00	49.00	5	14	2	5	6	8	4	3	1	2	\N	\N	39	1	19	\N	\N
1208213	2025-01-04 15:00:00	35	45	1	0	58.00	42.00	19	9	8	0	15	14	9	3	2	2	\N	\N	39	1	20	\N	\N
1208220	2025-01-04 15:00:00	41	55	0	5	51.00	49.00	8	20	1	11	10	4	2	2	2	0	\N	\N	39	1	20	\N	\N
1208216	2025-01-04 15:00:00	52	49	1	1	38.00	62.00	13	15	6	1	9	12	6	6	0	2	\N	\N	39	1	20	\N	\N
1208215	2025-01-04 17:30:00	51	42	1	1	45.00	55.00	11	9	4	3	17	14	2	5	2	3	\N	\N	39	1	20	\N	\N
1208217	2025-01-05 14:00:00	36	57	2	2	73.00	27.00	15	7	4	3	10	14	9	2	1	5	\N	\N	39	1	20	\N	\N
1208222	2025-01-06 20:00:00	39	65	0	3	61.00	39.00	13	11	6	3	10	8	5	3	1	2	\N	\N	39	1	20	\N	\N
1208230	2025-01-14 19:30:00	49	35	2	2	57.00	43.00	26	7	10	3	15	16	9	3	2	3	\N	\N	39	1	21	\N	\N
1208224	2025-01-14 19:30:00	55	50	2	2	45.00	55.00	18	21	6	8	4	4	4	5	\N	\N	\N	\N	39	1	21	\N	\N
1208231	2025-01-15 19:30:00	34	39	3	0	61.00	39.00	17	13	5	7	10	13	4	2	0	2	\N	\N	39	1	21	\N	\N
1208225	2025-01-15 19:30:00	45	66	0	1	50.00	50.00	10	11	3	3	17	10	8	5	2	1	\N	\N	39	1	21	\N	\N
1208223	2025-01-15 20:00:00	42	47	2	1	53.00	47.00	14	10	4	2	16	9	10	4	3	1	\N	\N	39	1	21	\N	\N
1208232	2025-01-16 20:00:00	33	41	3	1	60.00	40.00	23	13	9	5	7	10	4	4	1	3	\N	\N	39	1	21	\N	\N
1208240	2025-01-18 12:30:00	34	35	1	4	55.00	45.00	13	19	5	10	7	18	7	6	1	6	\N	\N	39	1	22	\N	\N
1208326	2025-04-05 11:30:00	45	42	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	31	\N	\N
1208332	2025-04-05 14:00:00	48	35	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	31	\N	\N
1208325	2025-04-05 14:00:00	52	51	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	31	\N	\N
1208328	2025-04-05 14:00:00	57	39	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	31	\N	\N
1208323	2025-04-05 16:30:00	66	65	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	31	\N	\N
1208327	2025-04-06 13:00:00	36	40	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	31	\N	\N
1208331	2025-04-06 13:00:00	47	41	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	31	\N	\N
1208324	2025-04-06 13:00:00	55	49	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	31	\N	\N
1208330	2025-04-06 15:30:00	33	50	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	31	\N	\N
1208329	2025-04-07 19:00:00	46	34	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	31	\N	\N
1208234	2025-01-18 15:00:00	55	40	0	2	39.00	61.00	11	37	6	8	6	14	2	15	2	3	\N	\N	39	1	22	\N	\N
1208239	2025-01-19 14:00:00	33	51	1	3	52.00	48.00	10	6	1	3	13	12	4	2	3	3	\N	\N	39	1	22	\N	\N
1208236	2025-01-19 14:00:00	45	47	3	2	35.00	65.00	12	11	6	6	14	14	3	8	2	1	\N	\N	39	1	22	\N	\N
1208237	2025-01-19 16:30:00	57	50	0	6	33.00	67.00	8	17	4	9	4	7	4	7	0	1	\N	\N	39	1	22	\N	\N
1208243	2025-01-25 15:00:00	35	65	5	0	51.00	49.00	16	18	10	4	9	12	3	9	2	3	\N	\N	39	1	23	\N	\N
1208252	2025-01-25 15:00:00	39	42	0	1	52.00	48.00	9	9	4	3	20	10	1	5	2	1	1	1	39	1	23	\N	\N
1208321	2025-04-02 18:45:00	41	52	1	1	43.00	57.00	8	9	2	3	14	9	2	2	2	1	\N	\N	39	1	30	\N	\N
1208316	2025-04-01 19:00:00	65	33	1	0	32.00	68.00	8	23	2	6	5	12	3	10	1	3	\N	\N	39	1	30	\N	\N
1208319	2025-04-02 18:45:00	50	46	2	0	72.00	28.00	18	2	5	0	11	8	5	0	1	4	\N	\N	39	1	30	\N	\N
1208318	2025-04-03 19:00:00	49	47	1	0	50.00	50.00	11	8	5	2	7	16	4	6	5	5	\N	\N	39	1	30	\N	\N
1208320	2025-04-02 18:45:00	34	55	2	1	48.00	52.00	21	12	4	3	12	12	4	5	1	1	\N	\N	39	1	30	\N	\N
1208250	2025-01-25 15:00:00	41	34	1	3	53.00	47.00	12	17	5	9	10	5	3	8	1	0	\N	\N	39	1	23	\N	\N
1208249	2025-01-25 17:30:00	50	49	3	1	57.00	43.00	15	10	6	4	6	8	2	3	3	2	\N	\N	39	1	23	\N	\N
1208251	2025-01-26 14:00:00	47	46	1	2	61.00	39.00	15	12	6	3	6	16	6	4	1	5	\N	\N	39	1	23	\N	\N
1208244	2025-01-26 16:30:00	66	48	1	1	46.00	54.00	14	14	4	4	13	16	4	3	2	3	\N	\N	39	1	23	\N	\N
1208261	2025-02-01 12:30:00	65	51	7	0	37.00	63.00	14	10	9	5	8	13	4	6	1	3	\N	\N	39	1	24	\N	\N
1208260	2025-02-01 15:00:00	34	36	1	2	48.00	52.00	11	15	4	4	10	15	3	7	4	4	\N	\N	39	1	24	\N	\N
1208257	2025-02-01 15:00:00	45	46	4	0	47.00	53.00	13	9	7	1	7	13	5	6	\N	\N	\N	\N	39	1	24	\N	\N
1208258	2025-02-01 15:00:00	57	41	1	2	57.00	43.00	15	9	6	4	11	14	1	2	0	3	\N	\N	39	1	24	\N	\N
1208259	2025-02-02 14:00:00	33	52	0	2	67.00	33.00	17	11	2	3	12	13	11	0	3	1	\N	\N	39	1	24	\N	\N
1208254	2025-02-02 16:30:00	42	50	5	1	46.00	54.00	12	7	7	4	6	7	5	2	2	0	\N	\N	39	1	24	\N	\N
1208256	2025-02-03 20:00:00	49	48	2	1	68.00	32.00	22	14	3	5	11	10	4	3	3	1	\N	\N	39	1	24	\N	\N
1208264	2025-02-14 20:00:00	51	49	3	0	31.00	69.00	13	8	5	0	12	15	2	9	1	2	\N	\N	39	1	25	\N	\N
1208266	2025-02-15 15:00:00	36	65	2	1	56.00	44.00	24	8	10	2	13	8	8	4	\N	\N	\N	\N	39	1	25	\N	\N
1208270	2025-02-15 15:00:00	41	35	1	3	45.00	55.00	11	14	4	7	13	15	4	6	1	3	\N	\N	39	1	25	\N	\N
1208269	2025-02-15 15:00:00	50	34	4	0	62.00	38.00	11	3	7	1	5	13	7	4	0	1	\N	\N	39	1	25	\N	\N
1208265	2025-02-15 17:30:00	52	45	1	2	58.00	42.00	17	11	6	6	9	12	6	2	0	1	\N	\N	39	1	25	\N	\N
1208268	2025-02-16 14:00:00	40	39	2	1	50.00	50.00	10	16	3	4	15	13	4	3	2	2	\N	\N	39	1	25	\N	\N
1208305	2025-02-19 19:30:00	66	40	2	2	52.00	48.00	9	17	4	3	8	6	6	8	1	0	\N	\N	39	1	29	\N	\N
1208279	2025-02-21 20:00:00	46	55	0	4	48.00	52.00	8	14	3	6	10	10	5	6	4	0	\N	\N	39	1	26	\N	\N
1208273	2025-02-22 15:00:00	35	39	0	1	45.00	55.00	8	13	3	5	17	9	6	7	3	3	1	0	39	1	26	\N	\N
1208282	2025-02-22 15:00:00	41	51	0	4	50.00	50.00	6	18	1	12	11	12	5	6	2	0	\N	\N	39	1	26	\N	\N
1208278	2025-02-22 15:00:00	57	47	1	4	41.00	59.00	17	10	5	6	15	14	4	4	2	1	\N	\N	39	1	26	\N	\N
1208275	2025-02-22 17:30:00	66	49	2	1	52.00	48.00	12	15	6	7	15	16	2	3	1	3	\N	\N	39	1	26	\N	\N
1208280	2025-02-23 16:30:00	50	40	0	2	66.00	34.00	16	8	5	4	3	10	7	5	\N	\N	\N	\N	39	1	26	\N	\N
1208288	2025-02-25 19:30:00	39	36	1	2	60.00	40.00	18	11	5	5	8	15	7	4	1	3	\N	\N	39	1	27	\N	\N
1208289	2025-02-25 19:30:00	52	66	4	1	36.00	64.00	19	6	6	2	19	10	3	8	3	1	\N	\N	39	1	27	\N	\N
1208292	2025-02-26 19:30:00	33	57	3	2	45.00	55.00	10	12	6	3	9	16	5	6	4	4	1	0	39	1	27	\N	\N
1208286	2025-02-26 19:30:00	47	50	0	1	56.00	44.00	11	12	6	5	12	15	8	3	3	0	\N	\N	39	1	27	\N	\N
1208285	2025-02-26 19:30:00	65	42	0	0	35.00	65.00	6	13	2	1	10	17	3	11	1	1	\N	\N	39	1	27	\N	\N
1208287	2025-02-27 20:00:00	48	46	2	0	58.00	42.00	8	10	2	2	12	6	3	3	\N	\N	\N	\N	39	1	27	\N	\N
1208299	2025-03-08 12:30:00	65	50	1	0	31.00	69.00	9	14	4	3	9	7	3	2	3	2	\N	\N	39	1	28	\N	\N
1208294	2025-03-08 15:00:00	51	36	2	1	53.00	47.00	9	6	4	1	6	12	3	7	0	2	\N	\N	39	1	28	\N	\N
1208293	2025-03-08 17:30:00	55	66	0	1	60.00	40.00	13	12	3	4	10	5	6	5	2	2	\N	\N	39	1	28	\N	\N
1208302	2025-03-08 20:00:00	39	45	1	1	66.00	34.00	11	12	3	4	11	16	5	5	2	2	\N	\N	39	1	28	\N	\N
1208295	2025-03-09 14:00:00	49	46	1	0	57.00	43.00	20	3	7	3	12	13	12	2	1	0	\N	\N	39	1	28	\N	\N
1208301	2025-03-10 20:00:00	48	34	0	1	51.00	49.00	9	9	2	3	7	15	3	4	0	1	\N	\N	39	1	28	\N	\N
1208312	2025-03-15 15:00:00	41	39	1	2	59.00	41.00	10	5	3	3	12	13	5	1	\N	\N	\N	\N	39	1	29	\N	\N
1208310	2025-03-15 15:00:00	50	51	2	2	60.00	40.00	11	15	3	3	10	10	4	5	2	5	\N	\N	39	1	29	\N	\N
1208308	2025-03-15 15:00:00	57	65	2	4	56.00	44.00	11	11	4	6	4	13	6	3	1	1	\N	\N	39	1	29	\N	\N
1208307	2025-03-16 13:30:00	36	47	2	0	57.00	43.00	13	12	4	4	13	10	6	5	\N	\N	\N	\N	39	1	29	\N	\N
1208309	2025-03-16 19:00:00	46	33	0	3	54.00	46.00	11	18	3	5	6	6	6	4	2	0	\N	\N	39	1	29	\N	\N
1208338	2025-04-12 11:30:00	50	52	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	32	\N	\N
1208341	2025-04-12 14:00:00	41	66	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	32	\N	\N
1208335	2025-04-12 14:00:00	51	46	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	32	\N	\N
1208340	2025-04-12 14:00:00	65	45	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	32	\N	\N
1208334	2025-04-12 16:30:00	42	55	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	32	\N	\N
1208342	2025-04-13 13:00:00	39	47	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	32	\N	\N
1208337	2025-04-13 13:00:00	40	48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	32	\N	\N
1208336	2025-04-13 13:00:00	49	57	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	32	\N	\N
1208339	2025-04-13 15:30:00	34	33	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	32	\N	\N
1208333	2025-04-14 19:00:00	35	36	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	32	\N	\N
1208311	2025-04-16 18:30:00	34	52	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	29	\N	\N
1208346	2025-04-19 14:00:00	45	50	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	33	\N	\N
1208352	2025-04-19 14:00:00	48	41	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	33	\N	\N
1208345	2025-04-19 14:00:00	52	35	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	33	\N	\N
1208344	2025-04-19 14:00:00	55	51	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	33	\N	\N
1208343	2025-04-19 16:30:00	66	34	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	33	\N	\N
1208350	2025-04-20 13:00:00	33	39	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	33	\N	\N
1208347	2025-04-20 13:00:00	36	49	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	33	\N	\N
1208348	2025-04-20 13:00:00	57	42	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	33	\N	\N
1208349	2025-04-20 15:30:00	46	40	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	33	\N	\N
1208351	2025-04-21 19:00:00	47	65	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	33	\N	\N
1208356	2025-04-26 11:30:00	49	45	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	34	\N	\N
1208359	2025-04-26 14:00:00	34	57	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	34	\N	\N
1208362	2025-04-26 14:00:00	39	46	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	34	\N	\N
1208361	2025-04-26 14:00:00	41	36	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	34	\N	\N
1208355	2025-04-26 14:00:00	51	48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	34	\N	\N
1208360	2025-04-26 14:00:00	65	55	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	34	\N	\N
1208354	2025-04-26 16:30:00	42	52	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	34	\N	\N
1208353	2025-04-27 13:00:00	35	33	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	34	\N	\N
1208357	2025-04-27 15:30:00	40	47	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	34	\N	\N
1208358	2025-04-28 19:00:00	50	66	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	34	\N	\N
1208371	2025-05-02 19:00:00	50	39	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	35	\N	\N
1208364	2025-05-03 11:30:00	66	36	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	35	\N	\N
1208369	2025-05-03 14:00:00	45	57	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	35	\N	\N
1208370	2025-05-03 14:00:00	46	41	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	35	\N	\N
1208372	2025-05-03 14:00:00	48	47	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	35	\N	\N
1208377	2025-05-10 14:00:00	33	48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	36	\N	\N
1208378	2025-05-10 14:00:00	34	49	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	36	\N	\N
1208373	2025-05-10 14:00:00	35	66	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	36	\N	\N
1208374	2025-05-10 14:00:00	36	45	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	36	\N	\N
1208382	2025-05-10 14:00:00	39	51	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	36	\N	\N
1208376	2025-05-10 14:00:00	40	42	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	36	\N	\N
1208380	2025-05-10 14:00:00	41	50	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	36	\N	\N
1208381	2025-05-10 14:00:00	47	52	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	36	\N	\N
1208375	2025-05-10 14:00:00	57	55	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	36	\N	\N
1208379	2025-05-10 14:00:00	65	46	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	36	\N	\N
1208383	2025-05-18 14:00:00	42	34	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	37	\N	\N
1208389	2025-05-18 14:00:00	45	41	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	37	\N	\N
1208390	2025-05-18 14:00:00	46	57	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	37	\N	\N
1208392	2025-05-18 14:00:00	48	65	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	37	\N	\N
1208387	2025-05-18 14:00:00	49	33	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	37	\N	\N
1208391	2025-05-18 14:00:00	50	35	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	37	\N	\N
1208386	2025-05-18 14:00:00	51	40	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	37	\N	\N
1208388	2025-05-18 14:00:00	52	39	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	37	\N	\N
1208385	2025-05-18 14:00:00	55	36	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	37	\N	\N
1208384	2025-05-18 14:00:00	66	47	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	37	\N	\N
1208397	2025-05-25 15:00:00	33	66	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	38	\N	\N
1208398	2025-05-25 15:00:00	34	45	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	38	\N	\N
1208393	2025-05-25 15:00:00	35	46	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	38	\N	\N
1208394	2025-05-25 15:00:00	36	50	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	38	\N	\N
1208402	2025-05-25 15:00:00	39	55	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	38	\N	\N
1208396	2025-05-25 15:00:00	40	52	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	38	\N	\N
1208400	2025-05-25 15:00:00	41	42	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	38	\N	\N
1208401	2025-05-25 15:00:00	47	51	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	38	\N	\N
1208395	2025-05-25 15:00:00	57	48	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	38	\N	\N
1208399	2025-05-25 15:00:00	65	49	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	39	0	38	\N	\N
1180510	2024-07-11 22:30:00	121	144	3	1	64.00	36.00	23	11	6	3	9	19	9	2	2	2	\N	\N	71	1	16	\N	\N
1180514	2024-07-11 23:00:00	140	124	1	1	40.00	60.00	13	18	4	10	15	7	2	5	2	1	\N	\N	71	1	16	\N	\N
1180507	2024-07-12 00:30:00	136	120	0	1	46.00	54.00	11	15	5	4	16	24	4	5	2	3	\N	\N	71	1	16	\N	\N
1180517	2024-07-13 19:00:00	118	1193	1	2	64.00	36.00	14	14	2	3	4	8	8	4	2	3	\N	\N	71	1	17	\N	\N
1180524	2024-07-16 22:00:00	152	1062	1	1	27.00	73.00	8	20	2	5	8	12	1	8	2	1	\N	\N	71	1	17	\N	\N
1180520	2024-07-17 00:00:00	131	140	2	1	54.00	46.00	14	16	7	4	10	17	5	5	1	0	\N	\N	71	1	17	\N	\N
1180521	2024-07-17 23:00:00	126	130	1	0	55.00	45.00	14	19	8	5	16	8	8	9	6	3	1	0	71	1	17	\N	\N
1180522	2024-07-18 00:30:00	154	136	3	1	48.00	52.00	12	11	4	3	19	19	1	6	4	3	\N	\N	71	1	17	\N	\N
1180529	2024-07-20 21:30:00	120	119	1	0	48.00	52.00	10	10	4	1	16	14	2	1	4	2	\N	\N	71	1	18	\N	\N
1180530	2024-07-21 00:00:00	121	135	2	0	43.00	57.00	15	8	5	2	16	16	6	4	4	4	\N	\N	71	1	18	\N	\N
1180527	2024-07-21 19:00:00	118	131	0	1	65.00	35.00	17	7	7	2	12	18	6	3	4	4	\N	\N	71	1	18	\N	\N
1180526	2024-07-21 19:00:00	1062	133	2	0	54.00	46.00	15	8	3	1	13	6	6	1	1	1	\N	\N	71	1	18	\N	\N
1180532	2024-07-21 21:30:00	154	144	3	1	60.00	40.00	12	10	3	2	12	12	5	6	5	3	1	1	71	1	18	\N	\N
1180533	2024-07-21 23:00:00	1193	124	0	1	47.00	53.00	16	10	6	4	19	6	6	4	1	2	0	1	71	1	18	\N	\N
1180384	2024-07-24 22:00:00	140	154	1	1	48.00	52.00	13	15	7	4	11	8	4	5	0	1	\N	\N	71	1	3	\N	\N
1180541	2024-07-24 22:30:00	126	120	2	2	69.00	31.00	15	12	6	6	17	22	7	1	4	3	\N	\N	71	1	19	\N	\N
1180538	2024-07-25 00:30:00	124	121	1	0	50.00	50.00	14	7	2	1	14	19	4	2	2	3	\N	\N	71	1	19	\N	\N
1180540	2024-07-25 23:00:00	131	130	2	2	64.00	36.00	14	18	7	7	21	17	4	5	1	2	\N	\N	71	1	19	\N	\N
1180550	2024-07-27 22:00:00	121	136	0	2	71.00	29.00	21	10	3	3	14	9	13	2	2	6	0	1	71	1	20	\N	\N
1180535	2024-09-11 22:30:00	119	154	2	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	1	19	\N	\N
1180572	2024-08-10 19:00:00	154	140	1	0	50.00	50.00	16	12	4	2	16	13	4	6	2	4	\N	\N	71	1	22	\N	\N
1180570	2024-08-11 00:30:00	131	794	1	1	63.00	37.00	19	11	5	6	11	18	6	6	4	6	\N	\N	71	1	22	\N	\N
1180569	2024-08-11 00:30:00	133	124	2	0	43.00	57.00	8	12	3	3	23	12	6	3	3	3	\N	\N	71	1	22	\N	\N
1180574	2024-08-11 14:00:00	152	120	3	2	37.00	63.00	16	24	8	10	10	14	6	12	3	5	\N	\N	71	1	22	\N	\N
1180567	2024-08-11 19:00:00	118	136	2	0	57.00	43.00	7	14	3	5	10	12	3	7	3	4	\N	\N	71	1	22	\N	\N
1180568	2024-08-11 19:00:00	127	121	1	1	52.00	48.00	11	9	7	7	15	21	4	2	1	4	0	1	71	1	22	\N	\N
1180405	2024-08-14 22:30:00	119	152	2	1	48.00	52.00	21	8	10	3	19	17	8	1	2	4	\N	\N	71	1	6	\N	\N
1180576	2024-08-17 19:00:00	1062	1193	1	1	60.00	40.00	13	11	4	6	13	14	8	6	3	6	\N	\N	71	1	23	\N	\N
1180581	2024-08-17 21:30:00	794	154	1	2	61.00	39.00	13	14	9	7	19	13	9	2	4	4	\N	\N	71	1	23	\N	\N
1180580	2024-08-18 19:00:00	121	126	2	1	53.00	47.00	24	8	8	4	17	12	6	1	4	3	1	2	71	1	23	\N	\N
1180583	2024-08-18 19:00:00	144	119	1	0	42.00	58.00	13	19	5	6	11	6	4	7	3	0	\N	\N	71	1	23	\N	\N
1180579	2024-08-18 21:30:00	120	127	4	1	54.00	46.00	19	10	9	4	17	7	5	2	4	2	\N	\N	71	1	23	\N	\N
1180577	2024-08-19 23:00:00	136	135	2	2	30.00	70.00	14	25	5	12	10	13	4	7	1	3	1	0	71	1	23	\N	\N
1180590	2024-08-24 21:30:00	121	1193	5	0	58.00	42.00	14	10	9	3	16	6	7	1	1	1	\N	\N	71	1	24	\N	\N
1180586	2024-08-25 00:00:00	1062	124	0	2	60.00	40.00	19	8	0	6	19	7	5	2	5	2	\N	\N	71	1	24	\N	\N
1180594	2024-08-25 19:00:00	140	130	0	1	47.00	53.00	19	14	4	4	15	8	6	9	2	1	\N	\N	71	1	24	\N	\N
1180591	2024-08-25 21:30:00	126	136	2	1	58.00	42.00	12	10	3	4	7	8	4	3	0	2	\N	\N	71	1	24	\N	\N
1180585	2024-08-25 22:00:00	119	135	1	0	44.00	56.00	19	5	9	3	12	9	12	3	3	2	\N	\N	71	1	24	\N	\N
1180589	2024-08-27 00:00:00	133	134	2	1	46.00	54.00	7	9	5	4	10	11	4	5	1	2	0	1	71	1	24	\N	\N
1180544	2024-08-28 22:30:00	140	794	1	0	49.00	51.00	14	15	2	6	17	15	6	8	3	3	\N	\N	71	1	19	\N	\N
1180603	2024-08-31 21:30:00	1193	140	2	1	45.00	55.00	22	12	3	3	16	9	5	5	3	0	\N	\N	71	1	25	\N	\N
1180595	2024-09-01 14:00:00	130	1062	2	3	28.00	72.00	11	27	5	13	11	17	5	9	1	3	1	0	71	1	25	\N	\N
1180600	2024-09-01 19:00:00	131	127	2	1	43.00	57.00	13	10	4	3	18	18	5	2	5	4	2	1	71	1	25	\N	\N
1180598	2024-09-01 21:30:00	124	126	2	0	44.00	56.00	10	15	5	2	13	16	5	4	4	4	\N	\N	71	1	25	\N	\N
1351108	2025-05-04 21:30:00	135	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	7	\N	\N
1180597	2024-09-01 21:30:00	136	133	0	1	47.00	53.00	21	9	5	6	7	7	10	3	3	3	\N	\N	71	1	25	\N	\N
1180601	2024-09-01 21:30:00	794	118	2	1	30.00	70.00	15	16	6	6	8	13	5	10	2	3	\N	\N	71	1	25	\N	\N
1180513	2024-09-05 23:00:00	1193	152	0	0	53.00	47.00	12	9	3	3	17	11	3	3	3	1	\N	\N	71	1	16	\N	\N
1180612	2024-09-14 21:30:00	134	154	1	1	55.00	45.00	28	10	9	3	12	10	13	4	2	2	\N	\N	71	1	26	\N	\N
1180610	2024-09-15 19:00:00	121	140	5	0	54.00	46.00	14	14	8	5	12	11	4	6	0	2	1	0	71	1	26	\N	\N
1180614	2024-09-15 19:00:00	152	124	2	1	53.00	47.00	12	8	5	1	8	9	8	5	5	4	\N	\N	71	1	26	\N	\N
1180607	2024-09-15 21:30:00	118	1062	3	0	55.00	45.00	16	5	4	2	17	16	6	1	1	3	\N	\N	71	1	26	\N	\N
1180606	2024-09-15 21:30:00	135	126	0	1	61.00	39.00	14	14	1	4	11	10	7	7	4	3	\N	\N	71	1	26	\N	\N
1180605	2024-09-16 23:00:00	119	1193	3	0	67.00	33.00	15	2	7	0	8	10	2	3	1	2	\N	\N	71	1	26	\N	\N
1180617	2024-09-21 19:00:00	136	152	1	0	36.00	64.00	13	11	2	2	12	15	4	5	3	4	\N	\N	71	1	27	\N	\N
1180622	2024-09-22 00:00:00	154	118	4	1	37.00	63.00	11	9	7	4	13	9	2	1	2	1	1	0	71	1	27	\N	\N
1180619	2024-09-22 19:00:00	133	121	0	1	55.00	45.00	10	14	3	3	8	14	5	5	1	2	\N	\N	71	1	27	\N	\N
1180621	2024-09-22 21:30:00	126	119	1	3	61.00	39.00	7	14	2	6	18	16	2	4	4	1	\N	\N	71	1	27	\N	\N
1180623	2024-09-22 21:30:00	1193	135	0	0	48.00	52.00	9	13	4	2	10	10	4	5	0	1	0	1	71	1	27	\N	\N
1180624	2024-09-23 21:30:00	140	134	0	0	64.00	36.00	24	10	6	3	11	12	12	1	2	2	\N	\N	71	1	27	\N	\N
1180511	2024-09-25 22:00:00	794	119	2	2	43.00	57.00	10	24	4	11	13	11	1	9	3	2	\N	\N	71	1	16	\N	\N
1180629	2024-09-29 00:00:00	120	130	0	0	63.00	37.00	15	11	3	4	10	14	5	3	2	3	0	1	71	1	28	\N	\N
1180631	2024-09-29 19:00:00	126	131	3	1	53.00	47.00	19	11	8	3	18	17	7	2	6	6	0	2	71	1	28	\N	\N
1180633	2024-09-29 19:00:00	144	124	1	0	40.00	60.00	16	13	7	2	15	14	4	3	0	2	\N	\N	71	1	28	\N	\N
1180627	2024-09-29 21:30:00	118	140	1	0	55.00	45.00	21	2	7	1	10	8	9	1	1	2	\N	\N	71	1	28	\N	\N
1180626	2024-09-29 21:30:00	135	133	1	1	56.00	44.00	15	13	6	4	7	6	11	4	0	3	0	1	71	1	28	\N	\N
1180628	2024-09-29 23:00:00	127	134	1	0	70.00	30.00	17	7	5	1	12	13	6	1	2	2	\N	\N	71	1	28	\N	\N
1180638	2024-10-04 00:30:00	124	135	1	0	47.00	53.00	14	13	5	5	19	16	2	2	8	3	\N	\N	71	1	29	\N	\N
1180642	2024-10-05 19:30:00	134	120	0	1	53.00	47.00	26	11	3	3	8	20	8	3	2	4	\N	\N	71	1	29	\N	\N
1180641	2024-10-05 19:30:00	794	121	0	0	41.00	59.00	17	14	5	5	7	14	1	3	4	3	1	1	71	1	29	\N	\N
1180637	2024-10-05 22:00:00	118	127	0	2	46.00	54.00	9	13	2	6	20	11	3	7	5	4	1	0	71	1	29	\N	\N
1180643	2024-10-05 22:00:00	1193	126	2	0	22.00	78.00	7	12	3	3	12	8	3	7	2	2	\N	\N	71	1	29	\N	\N
1180406	2024-10-09 22:30:00	1062	130	2	1	45.00	55.00	14	14	5	4	15	7	4	10	4	3	\N	\N	71	1	6	\N	\N
1180651	2024-10-17 00:45:00	126	133	3	0	47.00	53.00	13	9	5	3	8	5	3	5	1	0	\N	\N	71	1	30	\N	\N
1180648	2024-10-17 23:00:00	127	124	0	2	60.00	40.00	19	12	5	3	15	15	5	1	1	3	\N	\N	71	1	30	\N	\N
1180650	2024-10-17 23:00:00	131	134	5	2	61.00	39.00	14	22	8	6	9	7	3	8	3	3	\N	\N	71	1	30	\N	\N
1180649	2024-10-18 23:00:00	120	140	1	1	74.00	26.00	25	6	7	3	12	10	9	1	1	2	\N	\N	71	1	30	\N	\N
1351154	2025-06-11 00:00:00	120	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	12	\N	\N
1351155	2025-06-11 00:00:00	121	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	12	\N	\N
1351162	2025-06-11 00:00:00	123	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	12	\N	\N
1351153	2025-06-11 00:00:00	124	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	12	\N	\N
1180647	2024-10-19 19:00:00	136	794	1	0	49.00	51.00	11	9	3	1	15	8	5	5	2	1	\N	\N	71	1	30	\N	\N
1180518	2024-10-22 22:30:00	124	134	1	0	75.00	25.00	14	6	5	2	9	15	5	3	2	4	\N	\N	71	1	17	\N	\N
1180660	2024-10-26 19:30:00	121	154	2	2	60.00	40.00	16	11	6	3	9	17	3	3	1	5	\N	\N	71	1	31	\N	\N
1180655	2024-10-26 19:30:00	130	144	3	1	48.00	52.00	11	13	5	5	14	18	4	3	2	5	\N	\N	71	1	31	\N	\N
1180657	2024-10-26 19:30:00	136	124	2	1	50.00	50.00	12	11	3	4	15	7	7	5	4	2	\N	\N	71	1	31	\N	\N
1180661	2024-10-26 23:00:00	794	120	0	1	38.00	62.00	6	19	1	5	13	17	3	6	1	1	\N	\N	71	1	31	\N	\N
1180656	2024-10-26 23:00:00	1062	119	1	3	58.00	42.00	7	11	3	7	15	15	3	3	6	2	1	0	71	1	31	\N	\N
1180663	2024-10-28 22:00:00	1193	131	0	1	56.00	44.00	13	9	5	3	14	16	5	2	5	2	\N	\N	71	1	31	\N	\N
1180515	2024-10-30 22:00:00	119	127	1	1	47.00	53.00	18	12	5	3	14	10	5	5	1	4	\N	\N	71	1	17	\N	\N
1180671	2024-11-02 19:00:00	794	1193	0	0	68.00	32.00	18	7	4	1	8	11	11	5	1	3	\N	\N	71	1	32	\N	\N
1180672	2024-11-02 21:30:00	134	136	1	2	64.00	36.00	24	11	6	5	8	13	9	3	1	3	\N	\N	71	1	32	\N	\N
1180670	2024-11-04 23:00:00	131	121	2	0	42.00	58.00	6	17	4	4	18	13	2	9	2	3	\N	\N	71	1	32	\N	\N
1180667	2024-11-06 00:30:00	118	126	0	3	52.00	48.00	24	9	6	4	13	16	10	3	3	2	\N	\N	71	1	32	\N	\N
1180669	2024-11-06 00:30:00	120	133	3	0	64.00	36.00	20	11	4	3	13	8	7	4	0	3	0	1	71	1	32	\N	\N
1180673	2024-11-07 00:00:00	144	1062	1	0	37.00	63.00	13	12	3	5	11	13	4	7	2	2	\N	\N	71	1	32	\N	\N
1180675	2024-11-08 22:00:00	119	124	2	0	51.00	49.00	14	9	5	2	11	10	4	4	3	1	\N	\N	71	1	33	\N	\N
1180679	2024-11-09 19:30:00	120	1193	0	0	74.00	26.00	28	4	5	2	7	13	8	1	0	5	\N	\N	71	1	33	\N	\N
1180676	2024-11-09 22:00:00	135	140	2	1	63.00	37.00	26	12	9	7	13	11	6	5	3	4	\N	\N	71	1	33	\N	\N
1180683	2024-11-09 22:00:00	144	794	0	0	41.00	59.00	10	17	4	7	14	11	7	6	3	2	\N	\N	71	1	33	\N	\N
1180682	2024-11-09 22:00:00	154	133	3	0	39.00	61.00	14	4	8	2	13	11	5	1	1	1	\N	\N	71	1	33	\N	\N
1180678	2024-11-13 23:00:00	127	1062	0	0	54.00	46.00	25	16	6	2	14	7	7	4	1	1	\N	\N	71	1	33	\N	\N
1180542	2024-11-16 21:30:00	134	1062	1	0	30.00	70.00	17	13	5	3	11	10	4	3	2	2	\N	\N	71	1	19	\N	\N
1180692	2024-11-20 19:30:00	134	144	2	0	37.00	63.00	11	20	8	6	9	8	6	9	1	2	1	0	71	1	34	\N	\N
1180691	2024-11-20 19:30:00	794	126	1	1	43.00	57.00	18	10	5	2	16	12	1	1	3	2	\N	\N	71	1	34	\N	\N
1180687	2024-11-20 21:00:00	118	121	1	2	58.00	42.00	17	11	5	2	15	14	4	5	1	1	\N	\N	71	1	34	\N	\N
1180693	2024-11-20 22:00:00	1193	127	1	2	37.00	63.00	5	19	3	7	6	10	4	10	1	2	\N	\N	71	1	34	\N	\N
1180689	2024-11-21 23:00:00	133	119	0	1	49.00	51.00	12	16	2	7	8	10	8	3	1	0	\N	\N	71	1	34	\N	\N
1180688	2024-11-23 00:30:00	124	154	2	2	74.00	26.00	10	11	5	5	9	11	8	3	1	3	\N	\N	71	1	34	\N	\N
1180703	2024-11-23 22:30:00	144	121	0	1	55.00	45.00	9	10	2	3	16	14	4	2	3	2	\N	\N	71	1	35	\N	\N
1180701	2024-11-24 00:30:00	126	1062	2	2	54.00	46.00	13	3	4	3	11	11	7	1	3	5	0	1	71	1	35	\N	\N
1180697	2024-11-24 19:00:00	118	134	1	1	74.00	26.00	25	6	8	3	7	13	11	1	1	2	\N	\N	71	1	35	\N	\N
1180700	2024-11-24 19:00:00	131	133	3	1	60.00	40.00	23	8	8	2	8	14	7	6	1	4	\N	\N	71	1	35	\N	\N
1180702	2024-11-26 23:00:00	154	127	0	0	39.00	61.00	7	16	1	4	16	14	5	5	2	4	0	1	71	1	35	\N	\N
1180706	2024-11-27 00:30:00	1062	152	2	3	64.00	36.00	21	13	6	7	13	8	9	5	1	0	\N	\N	71	1	36	\N	\N
1180696	2024-11-28 00:00:00	135	130	1	1	61.00	39.00	19	9	3	4	16	6	5	1	2	1	\N	\N	71	1	35	\N	\N
1180713	2024-11-30 22:30:00	1193	118	1	2	44.00	56.00	11	11	2	3	9	8	3	3	4	1	\N	\N	71	1	36	\N	\N
1180709	2024-12-01 00:30:00	133	144	2	2	61.00	39.00	16	12	7	6	9	10	5	3	2	3	0	1	71	1	36	\N	\N
1180705	2024-12-01 19:00:00	130	126	2	1	38.00	62.00	16	7	8	2	11	7	10	6	1	1	\N	\N	71	1	36	\N	\N
1180707	2024-12-01 21:30:00	136	154	2	0	29.00	71.00	19	11	8	2	13	10	7	8	4	3	\N	\N	71	1	36	\N	\N
1180711	2024-12-01 21:30:00	794	135	1	1	33.00	67.00	7	22	2	2	11	14	6	10	2	2	\N	\N	71	1	36	\N	\N
1180719	2024-12-04 22:00:00	133	1062	2	0	58.00	42.00	11	11	4	3	20	13	3	6	4	2	\N	\N	71	1	37	\N	\N
1180717	2024-12-04 23:00:00	136	130	1	1	49.00	51.00	25	7	5	2	13	10	7	1	1	2	\N	\N	71	1	37	\N	\N
1180724	2024-12-04 23:00:00	140	127	0	3	38.00	62.00	16	12	4	7	16	6	7	3	1	0	\N	\N	71	1	37	\N	\N
1180716	2024-12-05 00:30:00	135	121	1	2	46.00	54.00	9	31	3	12	14	13	7	6	3	1	\N	\N	71	1	37	\N	\N
1180718	2024-12-05 23:00:00	124	1193	1	0	58.00	42.00	24	3	6	3	14	9	10	3	3	4	\N	\N	71	1	37	\N	\N
1180722	2024-12-05 23:00:00	134	794	1	2	55.00	45.00	22	13	7	4	14	15	6	4	1	5	\N	\N	71	1	37	\N	\N
1180729	2024-12-08 19:00:00	120	126	2	1	46.00	54.00	17	5	8	1	8	3	3	0	\N	\N	\N	\N	71	1	38	\N	\N
1180728	2024-12-08 19:00:00	127	136	2	2	68.00	32.00	23	12	4	5	7	8	6	4	0	2	\N	\N	71	1	38	\N	\N
1180725	2024-12-08 19:00:00	130	131	0	3	35.00	65.00	17	19	4	6	11	14	6	7	2	3	1	1	71	1	38	\N	\N
1180732	2024-12-08 19:00:00	154	119	3	0	37.00	63.00	10	11	5	1	8	13	4	3	1	2	\N	\N	71	1	38	\N	\N
1180726	2024-12-08 19:00:00	1062	134	1	0	62.00	38.00	14	7	7	4	12	16	5	4	3	3	\N	\N	71	1	38	\N	\N
1180733	2024-12-08 19:00:00	1193	133	1	2	33.00	67.00	11	11	4	4	15	8	2	5	0	1	\N	\N	71	1	38	\N	\N
1351049	2025-03-29 21:30:00	130	1062	2	1	32.00	68.00	12	22	5	7	19	5	1	11	4	0	\N	\N	71	1	1	\N	\N
1351052	2025-03-29 21:30:00	152	136	2	0	36.00	64.00	9	13	4	5	16	16	3	5	3	4	\N	\N	71	1	1	\N	\N
1351051	2025-03-29 21:30:00	154	124	2	0	30.00	70.00	5	15	3	1	16	5	4	5	1	0	\N	\N	71	1	1	\N	\N
1351072	2025-04-12 19:00:00	152	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	3	\N	\N
1351067	2025-04-12 19:00:00	794	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	3	\N	\N
1351065	2025-04-12 21:30:00	121	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	3	\N	\N
1351064	2025-04-13 00:00:00	133	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	3	\N	\N
1351070	2025-04-13 19:00:00	118	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	3	\N	\N
1351066	2025-04-13 20:30:00	126	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	3	\N	\N
1351069	2025-04-13 20:30:00	130	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	3	\N	\N
1351063	2025-04-13 22:30:00	124	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	3	\N	\N
1351071	2025-04-13 23:00:00	154	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	3	\N	\N
1351068	2025-04-13 23:30:00	1062	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	3	\N	\N
1351081	2025-04-16 00:30:00	129	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	4	\N	\N
1351082	2025-04-16 22:00:00	123	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	4	\N	\N
1351077	2025-04-16 22:00:00	7848	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	4	\N	\N
1351079	2025-04-16 22:30:00	119	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	4	\N	\N
1351075	2025-04-16 22:30:00	131	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	4	\N	\N
1351073	2025-04-17 00:30:00	127	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	4	\N	\N
1351076	2025-04-17 00:30:00	128	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	4	\N	\N
1351080	2025-04-17 00:30:00	136	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	4	\N	\N
1351074	2025-04-17 22:00:00	120	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	4	\N	\N
1351078	2025-04-18 00:30:00	135	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	4	\N	\N
1351085	2025-04-19 19:00:00	131	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	5	\N	\N
1351084	2025-04-19 21:30:00	133	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	5	\N	\N
1351089	2025-04-20 00:00:00	130	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	5	\N	\N
1351092	2025-04-20 14:00:00	152	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	5	\N	\N
1351086	2025-04-20 19:00:00	126	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	5	\N	\N
1351088	2025-04-20 19:00:00	1062	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	5	\N	\N
1351083	2025-04-20 21:30:00	124	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	5	\N	\N
1351091	2025-04-20 21:30:00	154	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	5	\N	\N
1351099	2025-04-26 19:00:00	119	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	6	\N	\N
1351101	2025-04-26 21:30:00	129	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	6	\N	\N
1351097	2025-04-26 21:30:00	7848	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	6	\N	\N
1351102	2025-04-26 23:00:00	123	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	6	\N	\N
1351094	2025-04-27 00:00:00	120	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	6	\N	\N
1351093	2025-04-27 19:00:00	127	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	6	\N	\N
1351095	2025-04-27 21:30:00	121	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	6	\N	\N
1351098	2025-04-27 21:30:00	135	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	6	\N	\N
1351100	2025-04-27 21:30:00	136	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	6	\N	\N
1351106	2025-05-03 00:30:00	126	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	7	\N	\N
1351103	2025-05-03 21:30:00	124	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	7	\N	\N
1351111	2025-05-03 21:30:00	129	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	7	\N	\N
1351105	2025-05-03 21:30:00	131	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	7	\N	\N
1351110	2025-05-04 00:00:00	118	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	7	\N	\N
1351109	2025-05-04 19:00:00	130	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	7	\N	\N
1351104	2025-05-04 19:00:00	133	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	7	\N	\N
1351050	2025-03-30 23:00:00	118	131	1	1	42.00	58.00	14	9	5	4	16	15	3	5	4	2	1	0	71	1	1	1	0
1351058	2025-04-06 19:00:00	1062	126	0	0	59.00	41.00	25	6	6	4	16	12	12	4	2	3	1	1	71	1	2	0	0
1351059	2025-04-06 21:30:00	119	135	3	0	68.00	32.00	24	6	11	1	19	11	9	2	1	1	0	1	71	1	2	2	0
1351061	2025-04-05 21:30:00	129	130	2	0	39.00	61.00	12	12	6	3	9	18	3	9	1	3	\N	\N	71	1	2	1	0
1351060	2025-04-06 21:30:00	136	127	1	2	37.00	63.00	5	14	3	7	7	17	2	6	\N	\N	\N	\N	71	1	2	0	0
1351057	2025-04-06 21:30:00	7848	154	1	1	70.00	30.00	20	7	5	3	12	12	8	1	2	3	\N	\N	71	1	2	0	1
1351054	2025-04-06 00:00:00	120	152	2	0	57.00	43.00	16	14	6	3	14	7	3	3	2	3	\N	\N	71	1	2	1	0
1351121	2025-05-10 19:00:00	154	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	8	\N	\N
1351119	2025-05-10 21:30:00	130	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	8	\N	\N
1351120	2025-05-10 21:30:00	136	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	8	\N	\N
1351117	2025-05-10 21:30:00	7848	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	8	\N	\N
1351113	2025-05-11 00:00:00	127	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	8	\N	\N
1351122	2025-05-11 19:00:00	123	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	8	\N	\N
1351115	2025-05-11 20:30:00	121	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	8	\N	\N
1351118	2025-05-11 20:30:00	1062	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	8	\N	\N
1351116	2025-05-12 23:00:00	128	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	8	\N	\N
1351131	2025-05-17 19:00:00	129	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	9	\N	\N
1351124	2025-05-17 21:30:00	133	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	9	\N	\N
1351126	2025-05-18 00:00:00	126	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	9	\N	\N
1351130	2025-05-18 19:00:00	118	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	9	\N	\N
1351125	2025-05-18 19:00:00	131	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	9	\N	\N
1351132	2025-05-18 19:00:00	152	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	9	\N	\N
1351123	2025-05-18 21:30:00	127	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	9	\N	\N
1351127	2025-05-18 21:30:00	794	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	9	\N	\N
1351134	2025-05-24 19:00:00	120	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	10	\N	\N
1351133	2025-05-24 21:30:00	124	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	10	\N	\N
1351136	2025-05-24 21:30:00	126	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	10	\N	\N
1351138	2025-05-25 00:00:00	1062	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	10	\N	\N
1351139	2025-05-25 14:00:00	130	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	10	\N	\N
1351135	2025-05-25 19:00:00	121	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	10	\N	\N
1351142	2025-05-25 19:00:00	123	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	10	\N	\N
1351140	2025-05-25 21:30:00	136	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	10	\N	\N
1351150	2025-05-31 19:00:00	118	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	11	\N	\N
1351148	2025-05-31 21:30:00	135	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	11	\N	\N
1351144	2025-06-01 00:00:00	133	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	11	\N	\N
1351147	2025-06-01 14:00:00	7848	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	11	\N	\N
1351146	2025-06-01 19:00:00	128	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	11	\N	\N
1351152	2025-06-01 19:00:00	152	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	11	\N	\N
1351143	2025-06-01 21:30:00	127	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	11	\N	\N
1351151	2025-06-01 21:30:00	129	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	11	\N	\N
1351145	2025-06-01 21:30:00	131	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	11	\N	\N
1351156	2025-06-13 00:30:00	126	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	12	\N	\N
1351158	2025-06-13 00:30:00	1062	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	12	\N	\N
1351090	2025-04-19 00:00:00	118	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	5	\N	\N
1351087	2025-04-19 00:00:00	794	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	5	\N	\N
1351096	2025-04-26 00:00:00	128	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	6	\N	\N
1351112	2025-05-03 00:00:00	152	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	7	\N	\N
1351107	2025-05-03 00:00:00	794	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	7	\N	\N
1351114	2025-05-10 00:00:00	120	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	8	\N	\N
1351129	2025-05-17 00:00:00	119	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	9	\N	\N
1351128	2025-05-17 00:00:00	135	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	9	\N	\N
1351141	2025-05-24 00:00:00	154	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	10	\N	\N
1351137	2025-05-24 00:00:00	794	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	10	\N	\N
1351149	2025-05-30 00:00:00	119	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	11	\N	\N
1351159	2025-06-11 00:00:00	130	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	12	\N	\N
1351160	2025-06-11 00:00:00	136	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	12	\N	\N
1351161	2025-06-11 00:00:00	154	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	12	\N	\N
1351157	2025-06-11 00:00:00	794	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	12	\N	\N
1351170	2025-07-12 00:00:00	118	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	13	\N	\N
1351169	2025-07-12 00:00:00	119	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	13	\N	\N
1351163	2025-07-12 00:00:00	127	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	13	\N	\N
1351166	2025-07-12 00:00:00	128	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	13	\N	\N
1351165	2025-07-12 00:00:00	131	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	13	\N	\N
1351164	2025-07-12 00:00:00	133	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	13	\N	\N
1351168	2025-07-12 00:00:00	135	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	13	\N	\N
1351172	2025-07-12 00:00:00	152	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	13	\N	\N
1351171	2025-07-12 00:00:00	154	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	13	\N	\N
1351167	2025-07-12 00:00:00	7848	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	13	\N	\N
1351180	2025-07-16 00:00:00	118	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	14	\N	\N
1351174	2025-07-16 00:00:00	120	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	14	\N	\N
1351175	2025-07-16 00:00:00	121	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	14	\N	\N
1351173	2025-07-16 00:00:00	124	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	14	\N	\N
1351176	2025-07-16 00:00:00	128	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	14	\N	\N
1351181	2025-07-16 00:00:00	129	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	14	\N	\N
1351179	2025-07-16 00:00:00	130	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	14	\N	\N
1351182	2025-07-16 00:00:00	152	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	14	\N	\N
1351177	2025-07-16 00:00:00	794	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	14	\N	\N
1351178	2025-07-16 00:00:00	1062	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	14	\N	\N
1351189	2025-07-19 00:00:00	119	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	15	\N	\N
1351185	2025-07-19 00:00:00	121	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	15	\N	\N
1351192	2025-07-19 00:00:00	123	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	15	\N	\N
1351186	2025-07-19 00:00:00	126	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	15	\N	\N
1351183	2025-07-19 00:00:00	127	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	15	\N	\N
1351184	2025-07-19 00:00:00	133	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	15	\N	\N
1351188	2025-07-19 00:00:00	135	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	15	\N	\N
1351190	2025-07-19 00:00:00	136	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	15	\N	\N
1351191	2025-07-19 00:00:00	154	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	15	\N	\N
1351187	2025-07-19 00:00:00	7848	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	15	\N	\N
1351193	2025-07-23 00:00:00	124	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	16	\N	\N
1351196	2025-07-23 00:00:00	128	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	16	\N	\N
1351201	2025-07-23 00:00:00	129	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	16	\N	\N
1351199	2025-07-23 00:00:00	130	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	16	\N	\N
1351195	2025-07-23 00:00:00	131	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	16	\N	\N
1351194	2025-07-23 00:00:00	133	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	16	\N	\N
1351200	2025-07-23 00:00:00	136	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	16	\N	\N
1351202	2025-07-23 00:00:00	152	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	16	\N	\N
1351197	2025-07-23 00:00:00	794	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	16	\N	\N
1351198	2025-07-23 00:00:00	1062	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	16	\N	\N
1351210	2025-07-26 00:00:00	118	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	17	\N	\N
1351209	2025-07-26 00:00:00	119	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	17	\N	\N
1351204	2025-07-26 00:00:00	120	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	17	\N	\N
1351205	2025-07-26 00:00:00	121	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	17	\N	\N
1351212	2025-07-26 00:00:00	123	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	17	\N	\N
1351206	2025-07-26 00:00:00	126	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	17	\N	\N
1351203	2025-07-26 00:00:00	127	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	17	\N	\N
1351208	2025-07-26 00:00:00	135	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	17	\N	\N
1351211	2025-07-26 00:00:00	154	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	17	\N	\N
1351207	2025-07-26 00:00:00	7848	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	17	\N	\N
1351219	2025-08-02 00:00:00	119	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	18	\N	\N
1351214	2025-08-02 00:00:00	120	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	18	\N	\N
1351222	2025-08-02 00:00:00	123	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	18	\N	\N
1351213	2025-08-02 00:00:00	124	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	18	\N	\N
1351216	2025-08-02 00:00:00	128	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	18	\N	\N
1351221	2025-08-02 00:00:00	129	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	18	\N	\N
1351215	2025-08-02 00:00:00	131	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	18	\N	\N
1351220	2025-08-02 00:00:00	136	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	18	\N	\N
1351218	2025-08-02 00:00:00	1062	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	18	\N	\N
1351217	2025-08-02 00:00:00	7848	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	18	\N	\N
1351230	2025-08-09 00:00:00	118	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	19	\N	\N
1351225	2025-08-09 00:00:00	121	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	19	\N	\N
1351226	2025-08-09 00:00:00	126	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	19	\N	\N
1351223	2025-08-09 00:00:00	127	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	19	\N	\N
1351229	2025-08-09 00:00:00	130	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	19	\N	\N
1351224	2025-08-09 00:00:00	133	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	19	\N	\N
1351228	2025-08-09 00:00:00	135	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	19	\N	\N
1351232	2025-08-09 00:00:00	152	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	19	\N	\N
1351231	2025-08-09 00:00:00	154	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	19	\N	\N
1351227	2025-08-09 00:00:00	794	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	19	\N	\N
1351239	2025-08-16 00:00:00	119	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	20	\N	\N
1351234	2025-08-16 00:00:00	120	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	20	\N	\N
1351242	2025-08-16 00:00:00	123	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	20	\N	\N
1351233	2025-08-16 00:00:00	124	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	20	\N	\N
1351236	2025-08-16 00:00:00	128	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	20	\N	\N
1351241	2025-08-16 00:00:00	129	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	20	\N	\N
1351235	2025-08-16 00:00:00	131	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	20	\N	\N
1351240	2025-08-16 00:00:00	136	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	20	\N	\N
1351238	2025-08-16 00:00:00	1062	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	20	\N	\N
1351237	2025-08-16 00:00:00	7848	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	20	\N	\N
1351250	2025-08-23 00:00:00	118	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	21	\N	\N
1351245	2025-08-23 00:00:00	121	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	21	\N	\N
1351246	2025-08-23 00:00:00	126	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	21	\N	\N
1351243	2025-08-23 00:00:00	127	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	21	\N	\N
1351249	2025-08-23 00:00:00	130	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	21	\N	\N
1351244	2025-08-23 00:00:00	133	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	21	\N	\N
1351248	2025-08-23 00:00:00	135	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	21	\N	\N
1351252	2025-08-23 00:00:00	152	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	21	\N	\N
1351251	2025-08-23 00:00:00	154	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	21	\N	\N
1351247	2025-08-23 00:00:00	794	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	21	\N	\N
1351259	2025-08-30 00:00:00	119	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	22	\N	\N
1351254	2025-08-30 00:00:00	120	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	22	\N	\N
1351262	2025-08-30 00:00:00	123	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	22	\N	\N
1351253	2025-08-30 00:00:00	127	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	22	\N	\N
1351256	2025-08-30 00:00:00	128	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	22	\N	\N
1351261	2025-08-30 00:00:00	129	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	22	\N	\N
1351255	2025-08-30 00:00:00	131	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	22	\N	\N
1351258	2025-08-30 00:00:00	135	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	22	\N	\N
1351260	2025-08-30 00:00:00	136	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	22	\N	\N
1351257	2025-08-30 00:00:00	7848	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	22	\N	\N
1351270	2025-09-13 00:00:00	118	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	23	\N	\N
1351265	2025-09-13 00:00:00	121	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	23	\N	\N
1351263	2025-09-13 00:00:00	124	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	23	\N	\N
1351266	2025-09-13 00:00:00	126	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	23	\N	\N
1351269	2025-09-13 00:00:00	130	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	23	\N	\N
1351264	2025-09-13 00:00:00	133	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	23	\N	\N
1351272	2025-09-13 00:00:00	152	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	23	\N	\N
1351271	2025-09-13 00:00:00	154	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	23	\N	\N
1351267	2025-09-13 00:00:00	794	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	23	\N	\N
1351268	2025-09-13 00:00:00	1062	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	23	\N	\N
1351279	2025-09-20 00:00:00	119	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	24	\N	\N
1351274	2025-09-20 00:00:00	120	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	24	\N	\N
1351275	2025-09-20 00:00:00	121	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	24	\N	\N
1351282	2025-09-20 00:00:00	123	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	24	\N	\N
1351273	2025-09-20 00:00:00	127	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	24	\N	\N
1351276	2025-09-20 00:00:00	128	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	24	\N	\N
1351281	2025-09-20 00:00:00	129	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	24	\N	\N
1351278	2025-09-20 00:00:00	135	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	24	\N	\N
1351280	2025-09-20 00:00:00	136	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	24	\N	\N
1351277	2025-09-20 00:00:00	7848	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	24	\N	\N
1351290	2025-09-27 00:00:00	118	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	25	\N	\N
1351283	2025-09-27 00:00:00	124	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	25	\N	\N
1351286	2025-09-27 00:00:00	126	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	25	\N	\N
1351289	2025-09-27 00:00:00	130	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	25	\N	\N
1351285	2025-09-27 00:00:00	131	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	25	\N	\N
1351284	2025-09-27 00:00:00	133	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	25	\N	\N
1351292	2025-09-27 00:00:00	152	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	25	\N	\N
1351291	2025-09-27 00:00:00	154	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	25	\N	\N
1351287	2025-09-27 00:00:00	794	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	25	\N	\N
1351288	2025-09-27 00:00:00	1062	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	25	\N	\N
1351299	2025-10-01 00:00:00	119	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	26	\N	\N
1351294	2025-10-01 00:00:00	120	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	26	\N	\N
1351295	2025-10-01 00:00:00	121	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	26	\N	\N
1351302	2025-10-01 00:00:00	123	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	26	\N	\N
1351293	2025-10-01 00:00:00	127	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	26	\N	\N
1351296	2025-10-01 00:00:00	128	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	26	\N	\N
1351300	2025-10-01 00:00:00	136	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	26	\N	\N
1351301	2025-10-01 00:00:00	154	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	26	\N	\N
1351298	2025-10-01 00:00:00	1062	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	26	\N	\N
1351297	2025-10-01 00:00:00	7848	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	26	\N	\N
1351310	2025-10-16 00:00:00	118	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	27	\N	\N
1351309	2025-10-16 00:00:00	119	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	27	\N	\N
1351303	2025-10-16 00:00:00	124	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	27	\N	\N
1351306	2025-10-16 00:00:00	126	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	27	\N	\N
1351311	2025-10-16 00:00:00	129	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	27	\N	\N
1351305	2025-10-16 00:00:00	131	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	27	\N	\N
1351304	2025-10-16 00:00:00	133	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	27	\N	\N
1351308	2025-10-16 00:00:00	135	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	27	\N	\N
1351312	2025-10-16 00:00:00	152	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	27	\N	\N
1351307	2025-10-16 00:00:00	794	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	27	\N	\N
1351314	2025-10-25 00:00:00	120	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	28	\N	\N
1351315	2025-10-25 00:00:00	121	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	28	\N	\N
1351322	2025-10-25 00:00:00	123	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	28	\N	\N
1351313	2025-10-25 00:00:00	124	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	28	\N	\N
1351316	2025-10-25 00:00:00	128	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	28	\N	\N
1351319	2025-10-25 00:00:00	130	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	28	\N	\N
1351320	2025-10-25 00:00:00	136	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	28	\N	\N
1351321	2025-10-25 00:00:00	154	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	28	\N	\N
1351318	2025-10-25 00:00:00	1062	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	28	\N	\N
1351317	2025-10-25 00:00:00	7848	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	28	\N	\N
1351330	2025-11-05 00:00:00	118	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	29	\N	\N
1351329	2025-11-05 00:00:00	119	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	29	\N	\N
1351323	2025-11-05 00:00:00	127	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	29	\N	\N
1351326	2025-11-05 00:00:00	128	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	29	\N	\N
1351331	2025-11-05 00:00:00	129	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	29	\N	\N
1351325	2025-11-05 00:00:00	131	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	29	\N	\N
1351324	2025-11-05 00:00:00	133	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	29	\N	\N
1351328	2025-11-05 00:00:00	135	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	29	\N	\N
1351332	2025-11-05 00:00:00	152	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	29	\N	\N
1351327	2025-11-05 00:00:00	7848	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	29	\N	\N
1351334	2025-11-19 00:00:00	120	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	30	\N	\N
1351335	2025-11-19 00:00:00	121	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	30	\N	\N
1351342	2025-11-19 00:00:00	123	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	30	\N	\N
1351333	2025-11-19 00:00:00	124	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	30	\N	\N
1351336	2025-11-19 00:00:00	126	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	30	\N	\N
1351339	2025-11-19 00:00:00	130	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	30	\N	\N
1351340	2025-11-19 00:00:00	136	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	30	\N	\N
1351341	2025-11-19 00:00:00	154	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	30	\N	\N
1351337	2025-11-19 00:00:00	794	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	30	\N	\N
1351338	2025-11-19 00:00:00	1062	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	30	\N	\N
1351350	2025-11-22 00:00:00	118	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	31	\N	\N
1351349	2025-11-22 00:00:00	119	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	31	\N	\N
1351343	2025-11-22 00:00:00	127	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	31	\N	\N
1351346	2025-11-22 00:00:00	128	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	31	\N	\N
1351351	2025-11-22 00:00:00	129	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	31	\N	\N
1351345	2025-11-22 00:00:00	131	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	31	\N	\N
1351344	2025-11-22 00:00:00	133	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	31	\N	\N
1351348	2025-11-22 00:00:00	135	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	31	\N	\N
1351352	2025-11-22 00:00:00	152	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	31	\N	\N
1351347	2025-11-22 00:00:00	7848	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	31	\N	\N
1351354	2025-11-29 00:00:00	120	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	32	\N	\N
1351355	2025-11-29 00:00:00	121	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	32	\N	\N
1351362	2025-11-29 00:00:00	123	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	32	\N	\N
1351353	2025-11-29 00:00:00	124	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	32	\N	\N
1351356	2025-11-29 00:00:00	126	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	32	\N	\N
1351361	2025-11-29 00:00:00	129	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	32	\N	\N
1351359	2025-11-29 00:00:00	130	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	32	\N	\N
1351360	2025-11-29 00:00:00	136	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	32	\N	\N
1351357	2025-11-29 00:00:00	794	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	32	\N	\N
1351358	2025-11-29 00:00:00	1062	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	32	\N	\N
1351369	2025-12-03 00:00:00	119	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	33	\N	\N
1351372	2025-12-03 00:00:00	123	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	33	\N	\N
1351366	2025-12-03 00:00:00	126	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	33	\N	\N
1351363	2025-12-03 00:00:00	127	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	33	\N	\N
1351365	2025-12-03 00:00:00	131	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	33	\N	\N
1351364	2025-12-03 00:00:00	133	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	33	\N	\N
1351368	2025-12-03 00:00:00	135	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	33	\N	\N
1351370	2025-12-03 00:00:00	136	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	33	\N	\N
1351371	2025-12-03 00:00:00	154	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	33	\N	\N
1351367	2025-12-03 00:00:00	7848	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	33	\N	\N
1351380	2025-12-06 00:00:00	118	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	34	\N	\N
1351374	2025-12-06 00:00:00	120	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	34	\N	\N
1351373	2025-12-06 00:00:00	124	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	34	\N	\N
1351376	2025-12-06 00:00:00	128	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	34	\N	\N
1351381	2025-12-06 00:00:00	129	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	34	\N	\N
1351379	2025-12-06 00:00:00	130	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	34	\N	\N
1351375	2025-12-06 00:00:00	131	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	34	\N	\N
1351382	2025-12-06 00:00:00	152	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	34	\N	\N
1351377	2025-12-06 00:00:00	794	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	34	\N	\N
1351378	2025-12-06 00:00:00	1062	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	34	\N	\N
1351390	2025-12-10 00:00:00	118	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	35	\N	\N
1351389	2025-12-10 00:00:00	119	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	35	\N	\N
1351384	2025-12-10 00:00:00	120	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	35	\N	\N
1351385	2025-12-10 00:00:00	121	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	35	\N	\N
1351392	2025-12-10 00:00:00	123	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	35	\N	\N
1351386	2025-12-10 00:00:00	126	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	35	\N	\N
1351383	2025-12-10 00:00:00	127	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	35	\N	\N
1351388	2025-12-10 00:00:00	135	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	35	\N	\N
1351391	2025-12-10 00:00:00	154	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	35	\N	\N
1351387	2025-12-10 00:00:00	7848	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	35	\N	\N
1351393	2025-12-13 00:00:00	124	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	36	\N	\N
1351396	2025-12-13 00:00:00	128	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	36	\N	\N
1351401	2025-12-13 00:00:00	129	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	36	\N	\N
1351399	2025-12-13 00:00:00	130	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	36	\N	\N
1351395	2025-12-13 00:00:00	131	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	36	\N	\N
1351394	2025-12-13 00:00:00	133	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	36	\N	\N
1351400	2025-12-13 00:00:00	136	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	36	\N	\N
1351402	2025-12-13 00:00:00	152	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	36	\N	\N
1351397	2025-12-13 00:00:00	794	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	36	\N	\N
1351398	2025-12-13 00:00:00	1062	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	36	\N	\N
1351410	2025-12-17 00:00:00	118	123	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	37	\N	\N
1351405	2025-12-17 00:00:00	121	136	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	37	\N	\N
1351406	2025-12-17 00:00:00	126	119	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	37	\N	\N
1351403	2025-12-17 00:00:00	127	129	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	37	\N	\N
1351409	2025-12-17 00:00:00	130	124	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	37	\N	\N
1351404	2025-12-17 00:00:00	133	7848	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	37	\N	\N
1351408	2025-12-17 00:00:00	135	120	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	37	\N	\N
1351412	2025-12-17 00:00:00	152	128	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	37	\N	\N
1351411	2025-12-17 00:00:00	154	131	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	37	\N	\N
1351407	2025-12-17 00:00:00	794	1062	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	37	\N	\N
1351419	2025-12-21 00:00:00	119	794	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	38	\N	\N
1351414	2025-12-21 00:00:00	120	154	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	38	\N	\N
1351422	2025-12-21 00:00:00	123	130	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	38	\N	\N
1351413	2025-12-21 00:00:00	124	118	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	38	\N	\N
1351416	2025-12-21 00:00:00	128	135	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	38	\N	\N
1351421	2025-12-21 00:00:00	129	121	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	38	\N	\N
1351415	2025-12-21 00:00:00	131	152	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	38	\N	\N
1351420	2025-12-21 00:00:00	136	126	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	38	\N	\N
1351418	2025-12-21 00:00:00	1062	133	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	38	\N	\N
1351417	2025-12-21 00:00:00	7848	127	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	71	0	38	\N	\N
1180554	2024-07-27 22:00:00	152	140	1	2	58.00	42.00	12	14	5	7	13	18	5	7	1	2	\N	\N	71	1	20	\N	\N
1180547	2024-07-27 23:00:00	118	119	1	1	51.00	49.00	9	12	3	2	12	18	4	2	1	3	\N	\N	71	1	20	\N	\N
1180552	2024-07-28 00:30:00	154	126	1	0	37.00	63.00	11	12	2	1	15	16	3	10	3	4	1	0	71	1	20	\N	\N
1180545	2024-07-28 22:00:00	130	133	1	0	53.00	47.00	20	13	3	1	13	13	8	3	3	4	\N	\N	71	1	20	\N	\N
1180553	2024-07-28 22:00:00	1193	134	1	2	50.00	50.00	21	11	5	4	8	12	12	2	0	2	\N	\N	71	1	20	\N	\N
1180564	2024-08-03 23:00:00	140	1062	2	1	27.00	73.00	13	19	5	3	14	7	5	1	1	2	\N	\N	71	1	21	\N	\N
1180558	2024-08-04 19:00:00	124	118	1	0	49.00	51.00	12	11	6	3	12	10	3	3	3	2	\N	\N	71	1	21	\N	\N
1180562	2024-08-04 19:00:00	134	130	0	2	75.00	25.00	18	9	3	7	12	12	9	0	2	0	\N	\N	71	1	21	\N	\N
1180355	2024-04-13 21:30:00	119	118	2	1	53.00	47.00	17	9	9	4	21	13	6	3	5	3	\N	\N	71	1	1	\N	\N
1180358	2024-04-14 00:00:00	124	794	2	2	69.00	31.00	26	16	11	8	8	19	13	6	3	4	\N	\N	71	1	1	\N	\N
1180360	2024-04-14 19:00:00	131	1062	0	0	48.00	52.00	14	8	2	3	16	14	3	3	8	6	0	1	71	1	1	\N	\N
1180363	2024-04-14 19:00:00	144	127	1	2	32.00	68.00	11	15	4	2	12	12	4	4	5	3	2	0	71	1	1	\N	\N
1180357	2024-04-14 21:30:00	136	121	0	1	56.00	44.00	13	15	5	4	12	15	3	9	3	5	\N	\N	71	1	1	\N	\N
1180371	2024-04-17 22:00:00	794	133	2	1	40.00	60.00	17	13	5	3	14	15	4	6	2	1	\N	\N	71	1	2	\N	\N
1180374	2024-04-17 23:00:00	152	131	2	0	45.00	55.00	16	17	8	2	16	10	6	7	3	1	1	0	71	1	2	\N	\N
1180368	2024-04-18 00:30:00	127	126	2	1	47.00	53.00	12	10	6	3	19	19	9	1	1	3	\N	\N	71	1	2	\N	\N
1180378	2024-04-20 19:00:00	124	133	2	1	58.00	42.00	11	21	8	5	16	17	2	7	4	5	\N	\N	71	1	3	\N	\N
1180376	2024-04-21 00:00:00	1062	135	3	0	56.00	44.00	9	10	4	3	15	17	4	4	2	2	\N	\N	71	1	3	\N	\N
1180382	2024-04-21 19:00:00	134	119	1	0	46.00	54.00	5	7	0	1	6	6	1	1	1	4	\N	\N	71	1	3	\N	\N
1180383	2024-04-21 21:30:00	144	126	0	3	35.00	65.00	9	19	1	7	13	9	4	3	5	0	2	0	71	1	3	\N	\N
1180393	2024-04-27 21:30:00	1193	1062	0	3	33.00	67.00	4	12	1	5	11	17	3	10	4	5	0	1	71	1	4	\N	\N
1180388	2024-04-28 14:00:00	127	120	0	2	60.00	40.00	15	9	0	3	12	15	8	3	1	4	\N	\N	71	1	4	\N	\N
1180394	2024-04-28 21:30:00	152	134	1	1	55.00	45.00	15	15	5	6	12	17	4	6	2	2	\N	\N	71	1	4	\N	\N
1180391	2024-04-29 23:00:00	126	121	0	0	57.00	43.00	16	9	1	3	10	20	6	4	4	3	\N	\N	71	1	4	\N	\N
1180401	2024-05-04 21:30:00	794	127	1	1	43.00	57.00	18	19	3	6	17	10	8	4	2	2	\N	\N	71	1	5	\N	\N
1180402	2024-05-05 19:00:00	134	133	1	0	56.00	44.00	26	7	7	1	11	9	6	5	1	0	0	1	71	1	5	\N	\N
1180403	2024-05-05 21:30:00	1193	121	0	2	45.00	55.00	9	15	1	6	10	11	6	6	2	3	\N	\N	71	1	5	\N	\N
1180410	2024-05-12 19:00:00	121	134	0	2	63.00	37.00	23	11	5	6	11	17	9	6	4	6	0	1	71	1	6	\N	\N
1180407	2024-05-12 21:30:00	118	794	1	0	50.00	50.00	8	15	3	5	12	15	6	7	2	3	\N	\N	71	1	6	\N	\N
1180411	2024-05-13 23:00:00	126	124	2	1	49.00	51.00	15	7	8	2	15	12	7	4	5	3	\N	\N	71	1	6	\N	\N
1180418	2024-06-01 21:30:00	124	152	1	1	62.00	38.00	17	12	4	4	13	19	5	3	2	4	0	1	71	1	7	\N	\N
1180420	2024-06-02 00:00:00	131	120	0	1	53.00	47.00	16	9	7	2	7	16	2	5	2	4	\N	\N	71	1	7	\N	\N
1180416	2024-06-02 19:00:00	1062	118	1	1	64.00	36.00	21	9	4	2	13	9	5	4	6	4	\N	\N	71	1	7	\N	\N
1180422	2024-06-02 21:30:00	154	134	1	0	52.00	48.00	11	15	4	2	12	17	2	4	3	4	\N	\N	71	1	7	\N	\N
1180414	2024-06-09 19:00:00	140	1193	2	5	62.00	38.00	23	13	9	7	10	13	6	2	5	6	1	0	71	1	6	\N	\N
1180434	2024-06-11 22:00:00	152	136	1	1	60.00	40.00	12	18	2	4	16	8	5	4	3	4	\N	\N	71	1	8	\N	\N
1180431	2024-06-12 00:30:00	794	1062	1	2	55.00	45.00	15	10	5	4	17	18	8	5	5	6	1	1	71	1	8	\N	\N
1180428	2024-06-13 23:00:00	127	130	2	1	42.00	58.00	16	15	6	5	9	10	4	6	2	4	\N	\N	71	1	8	\N	\N
1180430	2024-06-14 00:30:00	121	133	2	0	57.00	43.00	28	9	6	2	10	14	10	6	1	2	\N	\N	71	1	8	\N	\N
1180438	2024-06-16 00:00:00	124	144	1	2	56.00	44.00	9	17	5	7	10	12	3	3	4	1	1	0	71	1	9	\N	\N
1180442	2024-06-16 19:00:00	134	127	1	1	48.00	52.00	14	9	3	6	11	11	5	9	4	3	1	0	71	1	9	\N	\N
1180439	2024-06-16 21:30:00	133	135	0	0	50.00	50.00	14	8	4	2	11	11	5	5	2	4	\N	\N	71	1	9	\N	\N
1180443	2024-06-16 21:30:00	1193	154	5	0	55.00	45.00	21	2	13	0	9	6	5	1	1	3	0	2	71	1	9	\N	\N
1180453	2024-06-19 22:00:00	144	140	1	2	50.00	50.00	12	19	1	7	10	11	5	1	1	1	1	0	71	1	10	\N	\N
1180454	2024-06-19 23:00:00	152	133	2	0	55.00	45.00	14	6	5	2	13	18	5	4	2	3	0	1	71	1	10	\N	\N
1180446	2024-06-20 00:30:00	135	124	2	0	35.00	65.00	17	9	5	4	16	11	6	5	3	2	\N	\N	71	1	10	\N	\N
1180448	2024-06-20 23:00:00	127	118	2	1	35.00	65.00	14	8	3	3	8	10	6	2	1	1	\N	\N	71	1	10	\N	\N
1180493	2024-07-03 22:00:00	1193	120	1	2	51.00	49.00	11	6	6	4	8	15	7	5	4	1	\N	\N	71	1	14	\N	\N
1180494	2024-07-03 23:00:00	140	135	1	0	35.00	65.00	13	17	6	6	11	7	7	10	4	2	1	0	71	1	14	\N	\N
1180486	2024-07-04 00:30:00	1062	127	2	4	52.00	48.00	11	14	4	8	12	11	4	4	4	2	1	0	71	1	14	\N	\N
1180485	2024-07-04 22:00:00	130	121	2	2	40.00	60.00	14	21	5	5	9	13	5	10	2	3	\N	\N	71	1	14	\N	\N
1180501	2024-07-06 23:00:00	126	794	2	0	60.00	40.00	14	10	4	3	10	9	6	3	2	2	\N	\N	71	1	15	\N	\N
1180496	2024-07-07 19:00:00	135	131	3	0	47.00	53.00	12	15	5	2	22	12	8	8	2	1	\N	\N	71	1	15	\N	\N
1180495	2024-07-07 21:00:00	119	133	1	2	65.00	35.00	14	8	6	6	16	12	4	4	2	2	\N	\N	71	1	15	\N	\N
1180497	2024-07-07 21:30:00	136	140	2	1	45.00	55.00	9	13	3	2	12	18	6	3	1	2	\N	\N	71	1	15	\N	\N
1180499	2024-07-07 23:30:00	120	1062	3	0	57.00	43.00	19	6	8	2	19	12	3	2	2	1	0	1	71	1	15	\N	\N
1180509	2024-07-10 22:00:00	133	131	2	0	50.00	50.00	14	11	3	2	15	10	7	5	3	5	\N	\N	71	1	16	\N	\N
1180512	2024-07-10 22:00:00	134	118	1	3	52.00	48.00	22	7	8	5	13	13	9	2	2	4	\N	\N	71	1	16	\N	\N
1180508	2024-07-11 23:00:00	127	154	1	2	70.00	30.00	21	7	7	2	9	11	9	4	1	1	\N	\N	71	1	16	\N	\N
1180506	2024-07-12 00:30:00	1062	126	2	1	62.00	38.00	14	11	5	4	9	13	2	6	2	1	0	1	71	1	16	\N	\N
1180516	2024-07-13 19:00:00	135	794	2	1	53.00	47.00	10	15	4	5	11	14	1	8	2	2	\N	\N	71	1	17	\N	\N
1180523	2024-07-17 22:00:00	144	133	0	1	52.00	48.00	19	14	7	5	13	11	4	6	2	3	\N	\N	71	1	17	\N	\N
1180519	2024-07-18 00:30:00	120	121	1	0	43.00	57.00	16	18	7	5	20	10	5	4	2	0	\N	\N	71	1	17	\N	\N
1180528	2024-07-20 19:00:00	127	140	2	1	63.00	37.00	15	16	6	4	12	21	7	4	4	9	0	1	71	1	18	\N	\N
1180525	2024-07-21 14:00:00	130	136	2	0	59.00	41.00	13	5	6	0	11	20	7	4	1	7	\N	\N	71	1	18	\N	\N
1180534	2024-07-21 21:30:00	152	126	0	0	37.00	63.00	10	11	0	2	13	17	1	4	4	2	\N	\N	71	1	18	\N	\N
1180531	2024-07-21 21:30:00	794	134	1	0	35.00	65.00	12	19	3	7	6	14	2	11	2	7	1	0	71	1	18	\N	\N
1180536	2024-07-24 22:00:00	135	152	2	0	55.00	45.00	12	7	5	2	14	14	6	5	3	5	0	1	71	1	19	\N	\N
1180537	2024-07-24 23:00:00	136	127	1	2	43.00	57.00	10	8	3	4	9	15	4	8	1	1	\N	\N	71	1	19	\N	\N
1180543	2024-07-25 00:30:00	144	118	1	1	29.00	71.00	15	7	4	2	18	12	8	4	5	4	3	0	71	1	19	\N	\N
1180555	2024-08-04 20:00:00	119	121	1	1	41.00	59.00	16	17	7	5	19	6	4	11	2	0	\N	\N	71	1	21	\N	\N
1180556	2024-08-06 00:00:00	135	154	1	2	68.00	32.00	15	11	7	4	18	17	5	1	4	4	\N	\N	71	1	21	\N	\N
1180573	2024-08-10 22:00:00	1193	130	1	3	61.00	39.00	15	10	3	6	15	7	5	5	1	2	\N	\N	71	1	22	\N	\N
1180566	2024-08-11 00:30:00	135	1062	0	0	35.00	65.00	6	12	1	4	19	12	4	4	3	1	\N	\N	71	1	22	\N	\N
1180571	2024-08-11 19:00:00	126	144	1	0	45.00	55.00	12	13	7	6	15	8	3	2	1	2	\N	\N	71	1	22	\N	\N
1180565	2024-08-11 22:00:00	119	134	2	2	54.00	46.00	23	12	4	5	18	13	9	0	1	2	\N	\N	71	1	22	\N	\N
1180575	2024-08-17 19:00:00	130	118	0	2	40.00	60.00	13	12	5	5	10	10	1	5	3	1	\N	\N	71	1	23	\N	\N
1180578	2024-08-18 00:00:00	124	131	0	0	56.00	44.00	16	8	4	2	10	17	6	2	2	2	\N	\N	71	1	23	\N	\N
1180584	2024-08-18 19:00:00	140	133	2	2	51.00	49.00	19	13	8	4	15	7	9	10	3	2	\N	\N	71	1	23	\N	\N
1180582	2024-08-18 21:30:00	134	152	1	2	60.00	40.00	23	8	7	5	17	10	10	4	4	2	\N	\N	71	1	23	\N	\N
1180593	2024-08-24 19:00:00	144	152	2	1	40.00	60.00	18	13	7	3	17	10	4	5	5	6	1	1	71	1	24	\N	\N
1180587	2024-08-25 19:00:00	118	120	0	0	53.00	47.00	17	14	7	5	19	21	4	7	4	4	\N	\N	71	1	24	\N	\N
1180592	2024-08-25 19:00:00	154	131	1	0	44.00	56.00	8	10	5	3	14	16	3	9	3	3	\N	\N	71	1	24	\N	\N
1180588	2024-08-25 23:00:00	127	794	2	1	56.00	44.00	13	12	7	2	13	12	6	10	1	1	\N	\N	71	1	24	\N	\N
1180396	2024-08-28 22:30:00	135	119	0	0	69.00	31.00	19	1	4	0	12	13	10	3	2	7	0	1	71	1	5	\N	\N
1180599	2024-09-01 00:00:00	120	154	2	0	64.00	36.00	22	10	7	1	13	8	9	6	3	4	\N	\N	71	1	25	\N	\N
1180596	2024-09-01 14:00:00	135	144	3	1	49.00	51.00	11	17	6	4	13	7	8	3	2	5	\N	\N	71	1	25	\N	\N
1180602	2024-09-01 21:30:00	134	121	0	2	47.00	53.00	15	19	9	10	10	9	4	4	2	1	\N	\N	71	1	25	\N	\N
1180604	2024-09-01 21:30:00	152	119	1	3	37.00	63.00	14	18	5	8	13	17	6	4	1	2	1	0	71	1	25	\N	\N
1180613	2024-09-14 19:00:00	144	136	0	2	64.00	36.00	13	7	4	4	14	14	9	5	3	6	\N	\N	71	1	26	\N	\N
1180609	2024-09-15 00:00:00	120	131	2	1	57.00	43.00	21	12	10	2	12	7	6	3	1	3	\N	\N	71	1	26	\N	\N
1180611	2024-09-15 19:00:00	794	130	2	2	47.00	53.00	23	8	6	4	12	7	6	7	5	1	\N	\N	71	1	26	\N	\N
1180608	2024-09-15 21:30:00	127	133	1	1	61.00	39.00	17	9	3	2	10	10	5	6	0	1	\N	\N	71	1	26	\N	\N
1180620	2024-09-21 19:00:00	131	144	3	0	61.00	39.00	17	14	6	3	7	17	6	1	3	4	\N	\N	71	1	27	\N	\N
1180618	2024-09-21 21:30:00	124	120	0	1	50.00	50.00	13	9	5	6	13	17	5	4	1	1	\N	\N	71	1	27	\N	\N
1180616	2024-09-22 19:00:00	1062	794	3	0	50.00	50.00	13	8	8	3	14	9	4	2	2	3	\N	\N	71	1	27	\N	\N
1180615	2024-09-22 21:30:00	130	127	3	2	44.00	56.00	12	20	3	8	6	13	4	6	1	0	0	1	71	1	27	\N	\N
1180395	2024-09-25 22:00:00	130	140	1	2	65.00	35.00	14	11	3	4	8	12	6	3	2	5	\N	\N	71	1	5	\N	\N
1180630	2024-09-28 21:30:00	121	1062	2	1	43.00	57.00	15	6	8	3	15	10	7	3	2	2	\N	\N	71	1	28	\N	\N
1180634	2024-09-29 14:00:00	152	794	1	1	52.00	48.00	12	15	6	6	9	19	4	5	1	6	\N	\N	71	1	28	\N	\N
1180632	2024-09-29 19:00:00	154	1193	1	0	54.00	46.00	15	2	6	1	18	9	7	3	2	4	\N	\N	71	1	28	\N	\N
1180625	2024-09-29 21:30:00	119	136	3	1	54.00	46.00	10	7	5	4	26	8	2	6	3	1	\N	\N	71	1	28	\N	\N
1180644	2024-10-03 22:00:00	140	144	2	0	47.00	53.00	17	14	5	3	16	7	7	6	1	4	\N	\N	71	1	29	\N	\N
1180635	2024-10-05 00:30:00	130	154	3	1	38.00	62.00	16	7	6	5	11	9	10	2	2	4	1	1	71	1	29	\N	\N
1180636	2024-10-05 19:30:00	1062	136	2	2	56.00	44.00	14	9	3	3	13	14	2	5	1	0	1	0	71	1	29	\N	\N
1180640	2024-10-05 22:00:00	131	119	2	2	53.00	47.00	15	9	6	3	11	14	9	9	6	4	\N	\N	71	1	29	\N	\N
1180639	2024-10-06 00:00:00	133	152	1	1	54.00	46.00	16	17	3	5	14	13	3	6	1	3	1	0	71	1	29	\N	\N
1180652	2024-10-17 00:45:00	154	1062	1	1	46.00	54.00	14	18	1	5	9	10	7	3	1	3	2	0	71	1	30	\N	\N
1180653	2024-10-18 22:00:00	144	1193	0	0	60.00	40.00	16	6	4	0	17	15	8	4	2	3	\N	\N	71	1	30	\N	\N
1180646	2024-10-19 00:30:00	135	118	1	1	49.00	51.00	11	10	3	4	10	8	5	7	1	2	\N	\N	71	1	30	\N	\N
1180645	2024-10-19 19:00:00	119	130	1	0	64.00	36.00	18	9	6	7	14	15	3	6	1	3	\N	\N	71	1	30	\N	\N
1180654	2024-10-20 23:00:00	152	121	3	5	53.00	47.00	25	14	6	7	15	19	7	5	2	5	\N	\N	71	1	30	\N	\N
1180539	2024-10-25 22:00:00	133	1193	1	0	49.00	51.00	13	13	2	2	16	14	3	2	2	1	\N	\N	71	1	19	\N	\N
1180658	2024-10-26 19:30:00	127	152	4	2	74.00	26.00	20	5	10	3	8	14	8	1	3	5	0	1	71	1	31	\N	\N
1180662	2024-10-26 21:30:00	134	135	3	0	58.00	42.00	19	2	6	0	14	14	7	1	0	3	0	1	71	1	31	\N	\N
1180664	2024-10-27 01:00:00	140	126	1	1	30.00	70.00	10	16	3	3	13	10	6	7	2	0	\N	\N	71	1	31	\N	\N
1180659	2024-10-29 00:00:00	133	118	3	2	48.00	52.00	15	12	8	7	11	9	2	4	3	2	\N	\N	71	1	31	\N	\N
1180668	2024-11-02 00:00:00	124	130	2	2	62.00	38.00	18	7	7	4	15	14	8	2	6	4	1	0	71	1	32	\N	\N
1180674	2024-11-02 21:30:00	152	154	0	3	60.00	40.00	17	11	6	4	7	14	5	3	3	2	\N	\N	71	1	32	\N	\N
1180665	2024-11-06 00:30:00	119	140	2	0	69.00	31.00	20	5	9	4	15	13	7	3	1	2	0	1	71	1	32	\N	\N
1180666	2024-11-07 00:00:00	135	127	0	1	53.00	47.00	15	10	5	2	8	13	7	4	2	7	0	1	71	1	32	\N	\N
1180680	2024-11-09 00:30:00	121	130	1	0	63.00	37.00	33	6	14	1	14	9	14	1	5	3	\N	\N	71	1	33	\N	\N
1180677	2024-11-09 19:30:00	136	131	1	2	41.00	59.00	10	13	2	7	11	11	14	4	4	2	\N	\N	71	1	33	\N	\N
1180684	2024-11-09 22:00:00	152	118	2	1	39.00	61.00	20	8	8	3	11	9	7	2	3	1	\N	\N	71	1	33	\N	\N
1180681	2024-11-10 00:00:00	126	134	2	1	78.00	22.00	10	9	3	3	5	20	5	6	2	5	\N	\N	71	1	33	\N	\N
1180690	2024-11-20 14:00:00	131	135	2	1	45.00	55.00	13	8	9	2	13	15	3	4	3	3	\N	\N	71	1	34	\N	\N
1180694	2024-11-20 19:30:00	140	136	0	1	49.00	51.00	13	14	1	3	11	18	6	5	1	3	1	0	71	1	34	\N	\N
1180685	2024-11-20 22:00:00	130	152	2	2	56.00	44.00	11	11	4	5	17	16	5	4	3	4	\N	\N	71	1	34	\N	\N
1180686	2024-11-21 00:30:00	1062	120	0	0	30.00	70.00	3	27	0	4	9	11	1	10	7	2	1	1	71	1	34	\N	\N
1180699	2024-11-23 22:30:00	120	136	1	1	73.00	27.00	26	10	9	4	10	7	10	0	3	4	1	0	71	1	35	\N	\N
1180704	2024-11-23 22:30:00	152	1193	1	1	60.00	40.00	19	7	4	1	9	7	6	5	0	3	\N	\N	71	1	35	\N	\N
1180695	2024-11-24 19:00:00	119	794	4	1	55.00	45.00	16	5	7	1	16	12	8	4	2	1	\N	\N	71	1	35	\N	\N
1180698	2024-11-26 22:00:00	124	140	0	0	64.00	36.00	19	10	3	3	6	15	9	4	1	2	\N	\N	71	1	35	\N	\N
1180710	2024-11-27 00:30:00	121	120	1	3	55.00	45.00	19	13	5	7	9	16	5	7	2	4	1	0	71	1	36	\N	\N
1180714	2024-11-30 22:30:00	140	131	2	4	38.00	62.00	12	19	4	11	10	8	3	7	2	3	\N	\N	71	1	36	\N	\N
1180708	2024-12-01 19:00:00	127	119	3	2	56.00	44.00	17	13	10	6	14	12	6	4	2	2	\N	\N	71	1	36	\N	\N
1180712	2024-12-01 21:30:00	134	124	1	1	29.00	71.00	16	15	4	4	10	10	3	8	1	2	1	1	71	1	36	\N	\N
1180720	2024-12-03 23:00:00	131	118	3	0	52.00	48.00	18	12	7	2	12	13	7	4	2	4	\N	\N	71	1	37	\N	\N
1180721	2024-12-04 23:00:00	126	152	1	2	70.00	30.00	10	13	2	7	9	15	12	2	0	2	\N	\N	71	1	37	\N	\N
1180715	2024-12-05 00:30:00	119	120	0	1	67.00	33.00	14	2	6	1	9	12	10	1	5	1	\N	\N	71	1	37	\N	\N
1180723	2024-12-05 00:30:00	144	154	3	1	56.00	44.00	26	12	9	4	13	16	5	3	4	3	\N	\N	71	1	37	\N	\N
1180727	2024-12-08 19:00:00	118	144	2	0	48.00	52.00	17	13	5	2	15	11	4	5	3	1	\N	\N	71	1	38	\N	\N
1180730	2024-12-08 19:00:00	121	124	0	1	58.00	42.00	11	7	3	5	14	11	11	2	2	5	\N	\N	71	1	38	\N	\N
1180734	2024-12-08 19:00:00	152	135	0	1	50.00	50.00	21	8	7	1	13	13	8	1	3	4	2	1	71	1	38	\N	\N
1180731	2024-12-08 19:00:00	794	140	5	1	48.00	52.00	18	7	8	4	9	13	6	8	1	3	\N	\N	71	1	38	\N	\N
1351046	2025-03-29 21:30:00	126	123	0	0	65.00	35.00	15	8	3	1	17	21	6	2	0	2	\N	\N	71	1	1	\N	\N
1351048	2025-03-29 21:30:00	135	7848	2	1	45.00	55.00	8	16	2	6	18	21	2	6	4	3	\N	\N	71	1	1	\N	\N
1208495	2024-08-15 19:30:00	543	547	1	1	39.00	61.00	19	13	4	2	11	7	4	4	2	0	\N	\N	140	1	1	1	0
1351043	2025-03-30 00:00:00	127	119	1	1	62.00	38.00	19	5	5	1	10	17	4	2	2	4	\N	\N	71	1	1	0	1
1208317	2025-04-01 18:45:00	39	48	1	0	41.00	59.00	9	10	2	1	16	12	1	2	4	2	\N	\N	39	1	30	\N	\N
1208314	2025-04-01 18:45:00	42	36	2	1	51.00	49.00	17	9	4	3	2	10	5	4	1	2	\N	\N	39	1	30	\N	\N
1208313	2025-04-02 18:45:00	35	57	1	2	64.00	36.00	24	10	7	2	14	15	8	3	1	2	\N	\N	39	1	30	\N	\N
1208315	2025-04-02 18:45:00	51	66	0	3	56.00	44.00	11	8	4	5	16	11	4	0	2	3	\N	\N	39	1	30	\N	\N
1208322	2025-04-02 19:00:00	40	45	1	0	74.00	26.00	17	5	3	0	7	11	11	5	2	2	\N	\N	39	1	30	\N	\N
1208501	2024-08-16 17:00:00	538	542	2	1	64.00	36.00	6	10	4	2	8	23	3	3	2	2	\N	\N	140	1	1	0	1
1208497	2024-08-16 19:30:00	534	536	2	2	48.00	52.00	15	18	5	5	14	15	6	3	2	2	\N	\N	140	1	1	1	1
1208499	2024-08-17 19:30:00	532	529	1	2	36.00	64.00	6	18	2	6	11	13	3	8	2	3	\N	\N	140	1	1	1	1
1208496	2024-08-18 19:30:00	798	541	1	1	34.00	66.00	12	13	5	5	11	6	8	7	1	0	0	1	140	1	1	0	1
1212910	2024-08-19 17:00:00	720	540	1	0	45.00	55.00	12	10	1	2	15	8	3	2	2	2	\N	\N	140	1	1	1	0
1208504	2024-08-23 17:00:00	538	532	3	1	49.00	51.00	7	13	5	5	9	11	4	7	3	0	\N	\N	140	1	2	2	1
1208507	2024-08-23 19:30:00	536	533	1	2	60.00	40.00	16	8	7	6	16	8	7	2	3	5	\N	\N	140	1	2	1	1
1208510	2024-08-24 17:00:00	529	531	2	1	65.00	35.00	13	8	5	2	11	16	5	6	4	5	\N	\N	140	1	2	1	1
1208505	2024-08-24 19:30:00	546	728	0	0	48.00	52.00	12	3	0	0	16	18	3	2	1	2	\N	\N	140	1	2	0	0
1208506	2024-08-25 15:00:00	541	720	3	0	64.00	36.00	17	8	9	0	10	15	5	5	1	1	\N	\N	140	1	2	0	0
1208508	2024-08-25 17:15:00	542	543	0	0	37.00	63.00	5	15	1	3	17	16	3	8	1	4	1	0	140	1	2	0	0
1208503	2024-08-25 19:30:00	530	547	3	0	42.00	58.00	11	13	6	4	11	11	1	9	1	3	\N	\N	140	1	2	1	0
1208515	2024-08-27 17:00:00	798	536	0	0	45.00	55.00	12	16	4	7	15	10	5	9	0	1	0	1	140	1	3	0	0
1208517	2024-08-27 19:30:00	728	529	1	2	35.00	65.00	8	22	4	5	17	11	6	6	3	1	\N	\N	140	1	3	1	0
1208520	2024-08-28 17:00:00	720	537	0	0	59.00	41.00	12	7	2	1	13	19	4	4	1	5	\N	\N	140	1	3	0	0
1208519	2024-08-28 19:30:00	548	542	1	2	53.00	47.00	10	14	1	5	16	13	8	6	4	4	1	0	140	1	3	1	1
1208514	2024-08-29 17:00:00	547	727	4	0	60.00	40.00	10	1	5	0	10	9	5	0	\N	\N	\N	\N	140	1	3	1	0
1208522	2024-08-31 15:00:00	529	720	7	0	71.00	29.00	23	4	11	1	6	12	10	1	0	3	\N	\N	140	1	4	3	0
1208521	2024-08-31 17:00:00	531	530	0	1	53.00	47.00	8	9	1	2	13	9	2	2	3	1	\N	\N	140	1	4	0	0
1208524	2024-08-31 19:30:00	532	533	1	1	58.00	42.00	22	9	5	2	15	11	14	3	3	5	0	1	140	1	4	1	1
1208525	2024-09-01 15:00:00	542	534	2	0	29.00	71.00	15	12	5	6	13	9	6	5	3	0	\N	\N	140	1	4	1	0
1208528	2024-09-01 15:00:00	727	538	3	2	50.00	50.00	10	12	3	4	19	10	6	3	2	0	0	1	140	1	4	2	1
1208523	2024-09-01 17:15:00	546	548	0	0	53.00	47.00	16	1	1	0	14	16	4	1	1	1	\N	\N	140	1	4	0	0
1208527	2024-09-01 19:30:00	541	543	2	0	60.00	40.00	22	11	7	2	9	17	7	3	2	0	\N	\N	140	1	4	0	0
1208533	2024-09-14 12:00:00	798	533	1	2	54.00	46.00	9	21	4	4	11	10	7	6	3	3	1	0	140	1	5	0	1
1212914	2024-09-14 14:15:00	540	542	3	2	38.00	62.00	9	19	4	6	17	14	0	5	2	3	\N	\N	140	1	5	1	1
1208538	2024-09-14 19:00:00	548	541	0	2	48.00	52.00	11	16	2	6	12	9	6	6	4	1	\N	\N	140	1	5	0	0
1208535	2024-09-15 14:15:00	547	529	1	4	45.00	55.00	9	20	4	9	13	4	1	6	3	2	0	1	140	1	5	0	2
1208534	2024-09-15 16:30:00	534	531	2	3	65.00	35.00	15	9	6	4	8	12	9	3	1	2	0	1	140	1	5	0	2
1208537	2024-09-16 19:00:00	728	727	3	1	66.00	34.00	17	5	6	2	12	15	7	4	3	2	\N	\N	140	1	5	0	1
1208550	2024-09-17 17:00:00	798	548	1	0	40.00	60.00	10	13	4	5	5	10	5	5	1	1	\N	\N	140	1	7	1	0
1208542	2024-09-20 19:00:00	542	536	2	1	35.00	65.00	10	8	4	2	11	16	3	5	1	4	\N	\N	140	1	6	1	0
1208547	2024-09-21 14:15:00	727	534	2	1	39.00	61.00	13	11	4	6	14	11	2	4	2	5	\N	\N	140	1	6	1	1
1208545	2024-09-21 16:30:00	532	547	2	0	32.00	68.00	7	8	2	3	13	10	5	4	3	2	\N	\N	140	1	6	0	0
1208541	2024-09-22 12:00:00	546	537	1	1	59.00	41.00	13	6	4	2	16	17	6	2	3	2	\N	\N	140	1	6	0	0
1208544	2024-09-22 16:30:00	533	529	1	5	36.00	64.00	13	17	4	10	11	12	7	3	6	1	\N	\N	140	1	6	1	2
1208543	2024-09-22 19:00:00	728	530	1	1	55.00	45.00	16	10	4	5	9	12	3	4	\N	\N	\N	\N	140	1	6	1	0
1208555	2024-09-24 17:00:00	532	727	0	0	52.00	48.00	10	9	3	2	6	11	10	5	2	3	\N	\N	140	1	7	0	0
1208551	2024-09-24 17:00:00	536	720	2	1	55.00	45.00	22	8	5	2	14	12	6	4	5	4	1	0	140	1	7	1	0
1208549	2024-09-25 17:00:00	547	728	0	0	71.00	29.00	11	2	1	0	8	16	4	3	3	4	\N	\N	140	1	7	0	0
1208548	2024-09-25 19:00:00	529	546	1	0	78.00	22.00	15	7	4	1	4	15	7	5	1	1	\N	\N	140	1	7	1	0
1212916	2024-09-26 17:00:00	540	533	1	2	56.00	44.00	9	15	2	4	12	14	4	1	5	3	\N	\N	140	1	7	1	1
1208562	2024-09-27 19:00:00	720	798	1	2	50.00	50.00	13	17	1	6	16	11	7	4	3	2	\N	\N	140	1	8	0	0
1208564	2024-09-28 12:00:00	546	542	2	0	45.00	55.00	14	9	8	1	17	24	2	2	3	6	\N	\N	140	1	8	1	0
1208560	2024-09-28 16:30:00	548	532	3	0	62.00	38.00	11	9	6	4	7	12	6	4	\N	\N	\N	\N	140	1	8	1	0
1208561	2024-09-28 19:00:00	727	529	4	2	25.00	75.00	11	12	5	6	13	3	5	8	2	2	\N	\N	140	1	8	2	0
1208557	2024-09-29 14:15:00	531	536	1	1	39.00	61.00	13	13	5	3	6	7	4	7	0	3	1	0	140	1	8	1	0
1208558	2024-09-29 19:00:00	530	541	1	1	51.00	49.00	12	12	4	4	11	11	5	5	3	1	1	0	140	1	8	0	0
1208563	2024-09-30 19:00:00	533	534	3	1	42.00	58.00	20	7	7	3	15	11	3	2	0	4	\N	\N	140	1	8	1	0
1212918	2024-10-05 12:00:00	540	798	2	1	40.00	60.00	8	11	3	5	14	19	4	6	1	5	\N	\N	140	1	9	1	0
1208566	2024-10-05 14:15:00	546	727	1	1	40.00	60.00	11	6	3	2	17	10	4	2	2	4	\N	\N	140	1	9	1	0
1208574	2024-10-05 16:30:00	720	728	1	2	39.00	61.00	13	17	6	3	13	18	5	13	4	2	\N	\N	140	1	9	0	0
1208567	2024-10-05 19:00:00	541	533	2	0	55.00	45.00	11	12	2	1	7	11	2	5	0	1	\N	\N	140	1	9	1	0
1208568	2024-10-06 14:15:00	542	529	0	3	28.00	72.00	11	14	2	9	13	8	11	3	2	2	\N	\N	140	1	9	0	3
1208571	2024-10-06 19:00:00	548	530	1	1	67.00	33.00	16	4	7	1	10	9	5	1	0	2	\N	\N	140	1	9	0	1
1208580	2024-10-18 19:00:00	542	720	2	3	62.00	38.00	10	12	4	4	15	14	5	6	6	2	1	0	140	1	10	1	1
1208581	2024-10-19 14:15:00	727	543	1	2	55.00	45.00	19	11	6	7	12	8	10	2	2	1	0	1	140	1	10	0	1
1208578	2024-10-19 16:30:00	547	548	0	1	47.00	53.00	8	14	3	4	10	12	6	6	2	1	\N	\N	140	1	10	0	1
1208579	2024-10-20 12:00:00	798	728	1	0	51.00	49.00	19	10	5	2	9	13	9	2	1	1	\N	\N	140	1	10	0	0
1208582	2024-10-20 16:30:00	533	546	1	1	57.00	43.00	10	21	4	4	18	21	5	5	4	3	\N	\N	140	1	10	1	0
1208576	2024-10-20 19:00:00	529	536	5	1	67.00	33.00	21	7	9	1	6	14	5	5	1	2	\N	\N	140	1	10	3	0
1212920	2024-10-25 19:00:00	540	536	0	2	42.00	58.00	16	6	1	3	14	9	13	2	2	0	\N	\N	140	1	11	0	2
1208591	2024-10-26 12:00:00	720	533	1	2	45.00	55.00	7	21	3	9	16	13	4	6	4	3	\N	\N	140	1	11	0	1
1208589	2024-10-26 16:30:00	534	547	1	0	43.00	57.00	12	8	3	3	12	14	3	5	4	5	0	1	140	1	11	1	0
1208588	2024-10-27 12:00:00	537	538	3	0	39.00	61.00	7	18	4	5	15	17	4	2	2	2	\N	\N	140	1	11	0	0
1208584	2024-10-27 14:15:00	546	532	1	1	64.00	36.00	15	2	4	1	20	20	8	2	3	7	\N	\N	140	1	11	0	1
1208590	2024-10-27 20:00:00	548	727	0	2	75.00	25.00	19	10	9	4	7	14	14	4	3	4	\N	\N	140	1	11	0	2
1208585	2024-10-28 20:00:00	798	531	0	0	33.00	67.00	4	20	1	1	9	12	1	14	5	1	1	0	140	1	11	0	0
1208597	2024-11-02 13:00:00	727	720	1	0	50.00	50.00	20	7	4	4	21	12	7	2	1	5	\N	\N	140	1	12	1	0
1208594	2024-11-03 13:00:00	530	534	2	0	57.00	43.00	15	1	3	1	13	13	9	1	1	1	\N	\N	140	1	12	1	0
1212921	2024-11-03 15:15:00	529	540	3	1	77.00	23.00	14	10	9	3	13	14	9	5	0	3	\N	\N	140	1	12	3	0
1208593	2024-11-03 20:00:00	531	543	1	1	49.00	51.00	17	7	8	4	9	8	6	2	\N	\N	\N	\N	140	1	12	0	0
1208595	2024-11-04 20:00:00	538	546	1	0	58.00	42.00	10	10	3	2	12	11	0	2	1	4	0	1	140	1	12	1	0
1208608	2024-11-09 13:00:00	541	727	4	0	68.00	32.00	18	2	8	0	9	16	11	3	0	2	\N	\N	140	1	13	2	0
1208610	2024-11-09 15:15:00	533	542	3	0	63.00	37.00	13	9	3	3	17	21	7	2	1	3	\N	\N	140	1	13	1	0
1208602	2024-11-10 13:00:00	543	538	2	2	56.00	44.00	19	3	6	2	12	8	2	0	3	0	\N	\N	140	1	13	1	1
1208603	2024-11-10 17:30:00	546	547	0	1	47.00	53.00	8	3	0	2	25	16	5	2	3	3	\N	\N	140	1	13	0	1
1208605	2024-11-10 17:30:00	720	531	1	1	35.00	65.00	6	17	3	1	12	12	5	5	4	4	\N	\N	140	1	13	0	0
1208612	2024-11-22 20:00:00	546	720	2	0	56.00	44.00	12	6	5	3	15	15	3	2	3	2	\N	\N	140	1	14	0	0
1208617	2024-11-23 13:00:00	532	543	4	2	49.00	51.00	11	7	5	3	10	16	2	4	4	2	\N	\N	140	1	14	1	1
1208614	2024-11-23 17:30:00	534	798	2	3	62.00	38.00	14	9	3	3	10	18	4	3	4	2	0	1	140	1	14	0	0
1208616	2024-11-23 20:00:00	538	529	2	2	41.00	59.00	15	9	8	4	13	9	5	1	5	5	0	1	140	1	14	0	1
1208613	2024-11-24 13:00:00	727	533	2	2	41.00	59.00	4	17	3	7	12	13	0	8	6	5	\N	\N	140	1	14	2	0
1208615	2024-11-24 17:30:00	537	541	0	3	32.00	68.00	4	16	0	9	17	11	2	4	2	0	\N	\N	140	1	14	0	1
1208611	2024-11-24 20:00:00	531	548	1	0	40.00	60.00	12	6	4	1	18	9	4	4	3	4	\N	\N	140	1	14	1	0
1208620	2024-11-30 13:00:00	529	534	1	2	70.00	30.00	27	5	8	3	7	11	7	0	\N	\N	\N	\N	140	1	15	0	0
1208677	2025-01-24 20:00:00	534	727	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	21	0	0
1208679	2025-01-25 13:00:00	798	543	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	21	0	0
1208675	2025-01-25 15:15:00	530	533	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	21	0	1
1212930	2025-01-25 17:30:00	536	540	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	21	0	1
1208682	2025-01-25 20:00:00	720	541	0	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	21	0	1
1208681	2025-01-26 13:00:00	728	547	2	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	21	0	0
1208680	2025-01-26 15:15:00	548	546	0	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	21	0	0
1208674	2025-01-26 17:30:00	531	537	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	21	0	0
1208676	2025-01-26 20:00:00	529	532	7	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	21	5	0
1208678	2025-01-27 20:00:00	542	538	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	21	1	0
1208688	2025-01-31 20:00:00	537	728	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	22	0	0
1208684	2025-02-01 13:00:00	546	536	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	22	0	0
1208687	2025-02-01 15:15:00	533	720	5	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	22	1	0
1208683	2025-02-01 17:30:00	530	798	2	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	22	1	0
1212931	2025-02-01 20:00:00	540	541	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	22	0	0
1208691	2025-02-02 13:00:00	529	542	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	22	0	0
1208690	2025-02-02 15:15:00	532	538	2	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	22	1	0
1208686	2025-02-02 17:30:00	727	548	2	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	22	1	0
1208689	2025-02-02 20:00:00	543	531	2	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	22	2	1
1208685	2025-02-03 20:00:00	547	534	2	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	22	1	0
1208694	2025-02-07 20:00:00	728	720	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	23	0	0
1208699	2025-02-08 13:00:00	538	543	3	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	23	0	2
1208692	2025-02-08 15:15:00	531	547	3	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	23	2	0
1208695	2025-02-08 17:30:00	534	533	1	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	23	0	0
1208697	2025-02-08 20:00:00	541	530	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	23	0	1
1208696	2025-02-09 13:00:00	542	546	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	23	0	1
1208700	2025-02-09 15:15:00	532	537	2	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	23	2	0
1212924	2024-11-30 17:30:00	540	538	3	1	21.00	79.00	9	16	5	2	13	7	2	5	2	2	\N	\N	140	1	15	1	0
1208627	2024-12-01 13:00:00	533	547	2	2	36.00	64.00	13	13	4	6	8	13	1	5	2	6	\N	\N	140	1	15	1	0
1208626	2024-12-01 15:15:00	541	546	2	0	69.00	31.00	13	8	4	3	7	26	5	3	2	6	\N	\N	140	1	15	2	0
1208625	2024-12-01 20:00:00	548	543	2	0	41.00	59.00	2	7	1	2	28	10	0	4	3	2	\N	\N	140	1	15	2	0
1208661	2024-12-03 18:00:00	798	529	1	5	40.00	60.00	6	20	1	9	13	13	2	5	4	3	\N	\N	140	1	19	1	1
1208656	2024-12-04 20:00:00	531	541	2	1	37.00	63.00	9	10	3	5	21	9	5	2	3	3	\N	\N	140	1	19	0	0
1208633	2024-12-07 13:00:00	534	720	2	1	58.00	42.00	11	9	5	2	17	13	3	3	4	2	\N	\N	140	1	16	1	1
1208635	2024-12-07 15:15:00	543	529	2	2	38.00	62.00	12	9	6	3	15	14	6	4	1	2	\N	\N	140	1	16	0	1
1208632	2024-12-07 20:00:00	547	541	0	3	42.00	58.00	10	10	4	7	6	7	6	3	3	2	\N	\N	140	1	16	0	1
1208629	2024-12-08 15:15:00	531	533	2	0	42.00	58.00	12	11	4	1	15	10	3	3	2	1	\N	\N	140	1	16	1	0
1208637	2024-12-08 17:30:00	727	542	2	2	60.00	40.00	16	6	8	3	13	14	8	3	5	3	\N	\N	140	1	16	0	1
1212925	2024-12-09 20:00:00	546	540	1	0	41.00	59.00	15	9	6	1	14	15	3	3	3	6	\N	\N	140	1	16	1	0
1208645	2024-12-13 20:00:00	720	532	1	0	33.00	67.00	2	14	1	2	10	10	1	7	4	3	1	0	140	1	17	1	0
1208644	2024-12-14 15:15:00	798	547	2	1	31.00	69.00	8	13	2	1	10	14	2	4	5	2	1	0	140	1	17	1	1
1208640	2024-12-14 20:00:00	728	541	3	3	34.00	66.00	14	13	5	6	18	8	4	3	4	2	\N	\N	140	1	17	2	2
1208638	2024-12-15 13:00:00	530	546	1	0	57.00	43.00	11	7	3	1	13	15	8	3	3	1	\N	\N	140	1	17	0	0
1208642	2024-12-15 17:30:00	533	543	1	2	62.00	38.00	17	10	4	4	19	10	5	5	5	4	0	1	140	1	17	0	1
1208646	2024-12-15 17:30:00	548	534	0	0	61.00	39.00	15	9	4	3	17	12	8	6	2	3	\N	\N	140	1	17	0	0
1208599	2024-12-18 20:30:00	533	728	1	1	45.00	55.00	14	18	5	3	10	15	7	7	4	3	1	0	140	1	12	1	1
1212922	2024-12-18 20:30:00	540	532	1	1	46.00	54.00	10	14	3	4	13	11	4	7	1	0	\N	\N	140	1	13	1	0
1208649	2024-12-21 13:00:00	546	798	0	1	55.00	45.00	18	9	5	2	19	13	3	0	4	3	\N	\N	140	1	18	0	0
1208653	2024-12-21 17:30:00	727	531	1	2	53.00	47.00	6	13	3	8	10	13	4	3	0	1	\N	\N	140	1	18	1	1
1208654	2024-12-21 20:00:00	529	530	1	2	63.00	37.00	19	5	7	4	11	8	11	3	0	3	\N	\N	140	1	18	1	0
1208651	2024-12-22 15:15:00	541	536	4	2	59.00	41.00	16	10	8	5	5	14	6	6	1	2	\N	\N	140	1	18	3	1
1212927	2024-12-22 17:30:00	534	540	1	0	58.00	42.00	10	9	4	2	9	16	2	2	4	2	\N	\N	140	1	18	0	0
1208647	2024-12-22 20:00:00	543	728	1	1	56.00	44.00	14	10	5	4	9	14	5	5	0	4	\N	\N	140	1	18	1	0
1208663	2025-01-10 20:00:00	728	538	2	1	50.00	50.00	8	23	5	7	18	9	3	3	2	3	0	1	140	1	19	1	1
1208660	2025-01-11 13:00:00	542	547	0	1	43.00	57.00	11	3	2	1	16	11	6	3	1	4	\N	\N	140	1	19	0	0
1212928	2025-01-11 17:30:00	540	537	1	1	53.00	47.00	15	14	5	6	15	19	8	4	2	2	0	1	140	1	19	1	1
1208659	2025-01-11 20:00:00	536	532	1	1	54.00	46.00	15	5	5	1	16	8	10	1	1	2	\N	\N	140	1	19	0	0
1208657	2025-01-12 15:15:00	530	727	1	0	51.00	49.00	9	6	5	1	8	14	4	0	2	0	\N	\N	140	1	19	0	0
1212929	2025-01-17 20:00:00	540	720	2	1	36.00	64.00	12	11	4	4	13	16	1	7	2	2	\N	\N	140	1	20	1	0
1208665	2025-01-18 13:00:00	547	536	1	2	60.00	40.00	7	14	4	6	6	15	7	4	0	4	\N	\N	140	1	20	1	0
1208673	2025-01-18 17:30:00	543	542	1	3	50.00	50.00	7	9	2	5	12	24	2	3	4	5	1	0	140	1	20	1	1
1208669	2025-01-18 20:00:00	546	529	1	1	22.00	78.00	10	21	4	5	9	9	2	10	3	2	\N	\N	140	1	20	1	1
1208672	2025-01-19 15:15:00	541	534	4	1	61.00	39.00	25	6	13	2	11	13	8	2	0	1	0	1	140	1	20	3	1
1208671	2025-01-19 20:00:00	532	548	1	0	35.00	65.00	7	9	2	3	10	12	4	7	3	4	\N	\N	140	1	20	1	0
1208670	2025-01-20 20:00:00	533	798	4	0	44.00	56.00	14	9	7	2	9	12	6	5	1	3	\N	\N	140	1	20	4	0
1212932	2025-02-09 17:30:00	548	540	2	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	23	1	0
1208698	2025-02-09 20:00:00	536	529	1	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	23	1	1
1208693	2025-02-10 20:00:00	798	727	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	23	0	0
1208705	2025-02-14 20:00:00	547	546	1	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	24	0	1
1208709	2025-02-15 13:00:00	537	542	3	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	24	2	1
1208704	2025-02-15 15:15:00	727	541	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	24	0	1
1208701	2025-02-15 17:30:00	530	538	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	24	0	0
1208707	2025-02-15 20:00:00	533	532	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	24	1	0
1212933	2025-02-16 13:00:00	540	531	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	24	0	0
1208706	2025-02-16 15:15:00	720	536	0	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	24	0	2
1208708	2025-02-16 17:30:00	798	534	3	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	24	3	0
1208703	2025-02-16 20:00:00	543	548	3	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	24	0	0
1208702	2025-02-17 20:00:00	529	728	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	24	1	0
1208711	2025-02-21 20:00:00	538	727	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	25	0	0
1212934	2025-02-22 13:00:00	542	540	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	25	0	0
1208712	2025-02-22 15:15:00	728	533	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	25	0	0
1208713	2025-02-22 17:30:00	532	530	0	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	25	0	2
1208714	2025-02-22 20:00:00	534	529	0	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	25	0	0
1208710	2025-02-23 13:00:00	531	720	7	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	25	4	0
1208716	2025-02-23 15:15:00	541	547	2	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	25	1	0
1208715	2025-02-23 17:30:00	546	543	1	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	25	0	1
1208718	2025-02-23 20:00:00	548	537	3	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	25	1	0
1208717	2025-02-24 20:00:00	536	798	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	25	1	0
1208726	2025-02-28 20:00:00	720	534	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	26	0	1
1208724	2025-03-01 13:00:00	547	538	2	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	26	1	1
1208722	2025-03-01 15:15:00	728	536	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	26	0	0
1208720	2025-03-01 17:30:00	543	541	2	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	26	1	1
1208723	2025-03-01 20:00:00	530	531	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	26	0	0
1208725	2025-03-02 13:00:00	537	546	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	26	0	0
1208719	2025-03-02 15:15:00	529	548	4	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	26	2	0
1208727	2025-03-02 17:30:00	798	542	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	26	1	0
1208721	2025-03-02 20:00:00	727	532	3	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	26	3	2
1208731	2025-03-08 13:00:00	538	537	2	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	27	2	1
1208734	2025-03-08 15:15:00	542	533	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	27	1	0
1208733	2025-03-08 17:30:00	532	720	2	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	27	1	1
1208735	2025-03-09 13:00:00	546	530	2	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	27	0	0
1208736	2025-03-09 15:15:00	541	728	2	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	27	2	1
1208728	2025-03-09 17:30:00	531	798	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	27	0	0
1208730	2025-03-09 17:30:00	543	534	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	27	0	0
1208732	2025-03-09 20:00:00	548	536	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	27	0	0
1212936	2025-03-10 20:00:00	540	547	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	27	0	0
1208745	2025-03-14 20:00:00	534	542	2	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	28	0	1
1208742	2025-03-15 13:00:00	720	538	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	28	0	0
1212937	2025-03-15 15:15:00	798	540	2	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	28	0	0
1208744	2025-03-15 17:30:00	533	541	1	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	28	1	2
1208738	2025-03-15 20:00:00	547	532	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	28	0	0
1208741	2025-03-16 13:00:00	537	543	2	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	28	2	0
1208740	2025-03-16 15:15:00	536	531	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	28	0	0
1208743	2025-03-16 17:30:00	727	546	1	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	28	1	0
1208739	2025-03-16 17:30:00	728	548	2	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	28	0	1
1208737	2025-03-16 20:00:00	530	529	2	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	28	1	0
1208729	2025-03-27 20:00:00	529	727	3	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	27	2	0
1208751	2025-03-29 13:00:00	548	720	2	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	29	1	0
1212938	2025-03-29 15:15:00	540	530	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	29	0	1
1208752	2025-03-29 17:30:00	542	728	0	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	29	0	1
1208754	2025-03-29 20:00:00	541	537	3	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	29	1	2
1208750	2025-03-30 12:00:00	546	533	1	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	29	1	2
1208747	2025-03-30 14:15:00	529	547	4	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	29	1	0
1208746	2025-03-30 16:30:00	531	727	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	29	0	0
1208753	2025-03-30 16:30:00	532	798	1	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	29	0	0
1208748	2025-03-30 19:00:00	543	536	2	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	29	2	1
1208749	2025-03-31 19:00:00	538	534	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	29	1	0
1212939	2025-04-04 19:00:00	728	540	0	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	30	0	2
1208763	2025-04-05 12:00:00	547	542	0	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	30	0	0
1208756	2025-04-05 14:15:00	541	532	1	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	30	0	1
1208761	2025-04-05 16:30:00	798	538	1	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	30	1	0
1208755	2025-04-05 19:00:00	529	543	1	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	30	1	1
1208757	2025-04-06 12:00:00	534	548	1	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	30	0	1
1208760	2025-04-06 14:15:00	536	530	1	2	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	30	1	1
1208762	2025-04-06 16:30:00	720	546	0	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	30	0	3
1208759	2025-04-06 19:00:00	533	531	0	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	1	30	0	0
1208758	2025-04-07 19:00:00	537	727	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	30	\N	\N
1208772	2025-04-11 19:00:00	532	536	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	31	\N	\N
1208771	2025-04-12 12:00:00	548	798	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	31	\N	\N
1208767	2025-04-12 14:15:00	546	534	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	31	\N	\N
1212940	2025-04-12 16:30:00	538	540	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	31	\N	\N
1208769	2025-04-12 19:00:00	537	529	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	31	\N	\N
1208770	2025-04-13 12:00:00	727	547	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	31	\N	\N
1208768	2025-04-13 14:15:00	542	541	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	31	\N	\N
1208766	2025-04-13 16:30:00	543	533	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	31	\N	\N
1208764	2025-04-13 19:00:00	531	728	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	31	\N	\N
1208765	2025-04-14 19:00:00	530	720	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	31	\N	\N
1212941	2025-04-18 19:00:00	540	546	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	32	\N	\N
1208774	2025-04-19 12:00:00	728	532	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	32	\N	\N
1208773	2025-04-19 14:15:00	529	538	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	32	\N	\N
1208781	2025-04-19 16:30:00	798	537	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	32	\N	\N
1208776	2025-04-19 19:00:00	534	530	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	32	\N	\N
1208778	2025-04-20 12:00:00	720	727	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	32	\N	\N
1208779	2025-04-20 14:15:00	533	548	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	32	\N	\N
1208780	2025-04-20 16:30:00	536	542	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	32	\N	\N
1208775	2025-04-20 19:00:00	541	531	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	32	\N	\N
1208777	2025-04-21 19:00:00	547	543	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	32	\N	\N
1212942	2025-04-22 17:00:00	532	540	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	33	\N	\N
1208784	2025-04-22 19:30:00	529	798	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	33	\N	\N
1208782	2025-04-23 17:00:00	531	534	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	33	\N	\N
1208786	2025-04-23 17:00:00	538	533	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	33	\N	\N
1208789	2025-04-23 19:30:00	542	548	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	33	\N	\N
1208787	2025-04-23 19:30:00	546	541	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	33	\N	\N
1208790	2025-04-24 17:00:00	537	547	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	33	\N	\N
1208788	2025-04-24 17:00:00	727	536	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	33	\N	\N
1208783	2025-04-24 19:30:00	530	728	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	33	\N	\N
1208785	2025-04-24 19:30:00	543	720	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	33	\N	\N
1212935	2025-04-27 14:15:00	533	540	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	26	\N	\N
1208798	2025-05-04 00:00:00	533	727	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	34	\N	\N
1208792	2025-05-04 00:00:00	534	532	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	34	\N	\N
1208799	2025-05-04 00:00:00	536	537	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	34	\N	\N
1212943	2025-05-04 00:00:00	540	543	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	34	\N	\N
1208796	2025-05-04 00:00:00	541	538	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	34	\N	\N
1208793	2025-05-04 00:00:00	542	530	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	34	\N	\N
1208791	2025-05-04 00:00:00	547	798	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	34	\N	\N
1208794	2025-05-04 00:00:00	548	531	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	34	\N	\N
1208795	2025-05-04 00:00:00	720	529	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	34	\N	\N
1208797	2025-05-04 00:00:00	728	546	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	34	\N	\N
1208801	2025-05-11 00:00:00	529	541	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	35	\N	\N
1208800	2025-05-11 00:00:00	530	548	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	35	\N	\N
1208808	2025-05-11 00:00:00	531	542	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	35	\N	\N
1208807	2025-05-11 00:00:00	532	546	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	35	\N	\N
1208806	2025-05-11 00:00:00	534	728	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	35	\N	\N
1212944	2025-05-11 00:00:00	537	540	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	35	\N	\N
1208803	2025-05-11 00:00:00	538	536	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	35	\N	\N
1208802	2025-05-11 00:00:00	543	727	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	35	\N	\N
1208804	2025-05-11 00:00:00	547	533	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	35	\N	\N
1208805	2025-05-11 00:00:00	798	720	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	35	\N	\N
1208817	2025-05-14 00:00:00	533	537	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	36	\N	\N
1208816	2025-05-14 00:00:00	536	534	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	36	\N	\N
1212945	2025-05-14 00:00:00	540	529	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	36	\N	\N
1208815	2025-05-14 00:00:00	541	798	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	36	\N	\N
1208809	2025-05-14 00:00:00	542	532	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	36	\N	\N
1208810	2025-05-14 00:00:00	546	531	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	36	\N	\N
1208813	2025-05-14 00:00:00	548	538	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	36	\N	\N
1208814	2025-05-14 00:00:00	720	547	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	36	\N	\N
1208811	2025-05-14 00:00:00	727	530	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	36	\N	\N
1208812	2025-05-14 00:00:00	728	543	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	36	\N	\N
1208819	2025-05-18 00:00:00	529	533	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	37	\N	\N
1208818	2025-05-18 00:00:00	530	543	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	37	\N	\N
1208821	2025-05-18 00:00:00	532	531	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	37	\N	\N
1208826	2025-05-18 00:00:00	534	537	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	37	\N	\N
1208824	2025-05-18 00:00:00	536	541	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	37	\N	\N
1208820	2025-05-18 00:00:00	538	728	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	37	\N	\N
1208823	2025-05-18 00:00:00	548	547	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	37	\N	\N
1208825	2025-05-18 00:00:00	720	542	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	37	\N	\N
1212946	2025-05-18 00:00:00	727	540	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	37	\N	\N
1208822	2025-05-18 00:00:00	798	546	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	37	\N	\N
1208827	2025-05-25 00:00:00	531	529	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	38	\N	\N
1208835	2025-05-25 00:00:00	533	536	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	38	\N	\N
1208831	2025-05-25 00:00:00	537	720	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	38	\N	\N
1212947	2025-05-25 00:00:00	540	534	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	38	\N	\N
1208829	2025-05-25 00:00:00	541	548	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	38	\N	\N
1208830	2025-05-25 00:00:00	542	727	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	38	\N	\N
1208828	2025-05-25 00:00:00	543	532	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	38	\N	\N
1208833	2025-05-25 00:00:00	546	538	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	38	\N	\N
1208832	2025-05-25 00:00:00	547	530	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	38	\N	\N
1208834	2025-05-25 00:00:00	728	798	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	140	0	38	\N	\N
1351045	2025-03-30 19:00:00	121	120	0	0	58.00	42.00	13	13	3	5	18	22	2	2	3	3	\N	\N	71	1	1	0	0
1351044	2025-03-30 21:30:00	133	128	2	1	53.00	47.00	12	11	5	2	11	12	2	3	1	1	\N	\N	71	1	1	0	1
1351047	2025-03-31 23:00:00	794	129	2	2	62.00	38.00	18	13	7	6	14	13	9	2	1	3	\N	\N	71	1	1	1	2
1351055	2025-04-05 21:30:00	131	133	3	0	53.00	47.00	6	10	3	3	18	16	1	4	3	2	\N	\N	71	1	2	2	0
1351053	2025-04-06 19:00:00	124	794	2	1	45.00	55.00	15	17	5	5	15	12	6	6	1	0	\N	\N	71	1	2	1	0
1351062	2025-04-06 21:30:00	123	121	1	2	50.00	50.00	9	7	2	4	17	21	6	3	6	4	\N	\N	71	1	2	1	1
1351056	2025-04-06 23:30:00	128	118	2	2	55.00	45.00	21	10	6	3	13	16	9	3	5	2	\N	\N	71	1	2	0	1
1208494	2024-08-15 17:00:00	531	546	1	1	69.00	31.00	7	9	4	2	15	12	5	6	4	1	\N	\N	140	1	1	1	0
1208502	2024-08-17 17:00:00	727	537	1	1	61.00	39.00	16	10	6	4	14	12	6	4	3	2	\N	\N	140	1	1	0	1
1208500	2024-08-18 17:00:00	548	728	1	2	66.00	34.00	11	12	4	5	14	21	10	5	2	4	\N	\N	140	1	1	0	0
1208498	2024-08-19 19:30:00	533	530	2	2	45.00	55.00	9	9	3	4	7	12	2	3	1	3	\N	\N	140	1	1	2	2
1208511	2024-08-24 15:00:00	727	798	1	0	45.00	55.00	15	10	5	1	10	8	5	4	2	1	\N	\N	140	1	2	0	0
1212911	2024-08-24 19:30:00	540	548	0	1	34.00	66.00	13	8	4	3	14	18	7	4	2	2	\N	\N	140	1	2	0	0
1208509	2024-08-25 17:00:00	537	534	2	1	40.00	60.00	10	10	5	5	11	10	3	7	1	1	\N	\N	140	1	2	0	0
1208518	2024-08-26 19:30:00	533	538	4	3	45.00	55.00	24	20	9	9	8	7	7	4	4	3	\N	\N	140	1	3	1	2
1208512	2024-08-28 17:00:00	531	532	1	0	51.00	49.00	13	2	4	0	14	9	5	3	1	3	\N	\N	140	1	3	1	0
1212912	2024-08-28 19:30:00	530	540	0	0	62.00	38.00	25	8	7	1	6	9	9	3	0	2	\N	\N	140	1	3	0	0
1208516	2024-08-29 19:30:00	534	541	1	1	44.00	56.00	7	25	2	8	16	13	2	6	0	2	\N	\N	140	1	3	1	0
1212913	2024-08-31 17:15:00	540	728	2	1	47.00	53.00	10	17	3	5	14	16	3	7	3	2	\N	\N	140	1	4	1	1
1208526	2024-08-31 19:30:00	537	798	0	1	54.00	46.00	9	12	2	3	11	17	1	3	1	3	\N	\N	140	1	4	0	1
1208529	2024-09-01 17:00:00	536	547	0	2	49.00	51.00	16	11	5	4	6	14	7	5	3	2	\N	\N	140	1	4	0	1
1208531	2024-09-13 19:00:00	543	537	2	0	64.00	36.00	14	3	5	0	11	18	11	1	1	2	\N	\N	140	1	5	0	0
1208536	2024-09-14 16:30:00	536	546	1	0	61.00	39.00	10	15	4	4	19	15	3	4	3	4	1	0	140	1	5	1	0
1208532	2024-09-15 12:00:00	538	720	3	1	54.00	46.00	14	6	9	2	14	15	5	3	3	5	0	1	140	1	5	2	0
1208530	2024-09-15 19:00:00	530	532	3	0	53.00	47.00	14	5	4	1	10	8	7	3	1	2	\N	\N	140	1	5	1	0
1208513	2024-09-18 17:00:00	543	546	2	1	66.00	34.00	17	15	7	5	10	20	8	4	3	5	\N	\N	140	1	3	0	0
1208552	2024-09-19 17:00:00	537	531	0	2	48.00	52.00	14	10	3	4	12	11	4	7	3	0	\N	\N	140	1	7	0	0
1208546	2024-09-21 12:00:00	720	548	0	0	35.00	65.00	15	14	2	4	15	12	5	7	4	4	\N	\N	140	1	6	0	0
1212915	2024-09-21 19:00:00	541	540	4	1	73.00	27.00	31	10	14	1	7	5	9	4	4	3	\N	\N	140	1	6	0	0
1208539	2024-09-22 14:15:00	531	538	3	1	32.00	68.00	10	11	5	4	16	11	3	6	3	2	\N	\N	140	1	6	2	1
1208540	2024-09-23 19:00:00	543	798	1	2	62.00	38.00	16	7	6	6	12	14	6	3	3	3	\N	\N	140	1	6	1	1
1208556	2024-09-24 19:00:00	541	542	3	2	69.00	31.00	10	12	4	3	7	10	4	4	4	0	\N	\N	140	1	7	2	0
1208554	2024-09-26 17:00:00	534	543	1	1	55.00	45.00	8	13	2	5	21	10	1	4	4	2	\N	\N	140	1	7	1	1
1208553	2024-09-26 19:00:00	538	530	0	1	58.00	42.00	10	8	4	2	11	11	2	3	2	2	\N	\N	140	1	7	0	0
1208565	2024-09-28 14:15:00	728	537	1	1	53.00	47.00	15	13	6	3	12	7	5	5	2	1	\N	\N	140	1	8	1	0
1208559	2024-09-29 12:00:00	538	547	1	1	48.00	52.00	12	9	2	4	9	14	4	4	1	0	\N	\N	140	1	8	0	1
1212917	2024-09-29 16:30:00	543	540	1	0	53.00	47.00	20	8	11	1	14	20	8	4	2	4	\N	\N	140	1	8	0	0
1208569	2024-10-04 19:00:00	537	532	0	0	59.00	41.00	8	6	0	1	15	14	1	2	2	2	\N	\N	140	1	9	0	0
1208573	2024-10-05 16:30:00	534	538	0	1	61.00	39.00	25	8	5	1	9	13	11	2	3	8	0	2	140	1	9	0	1
1208570	2024-10-06 12:00:00	547	531	2	1	65.00	35.00	14	13	6	4	12	13	6	1	4	3	0	1	140	1	9	1	1
1208572	2024-10-06 16:30:00	536	543	1	0	52.00	48.00	14	11	5	3	15	15	4	1	6	3	1	0	140	1	9	0	0
1212919	2024-10-19 12:00:00	531	540	4	1	57.00	43.00	10	5	6	2	15	22	5	5	2	3	\N	\N	140	1	10	3	0
1208577	2024-10-19 19:00:00	538	541	1	2	47.00	53.00	13	10	5	3	16	13	6	2	2	1	\N	\N	140	1	10	0	1
1208575	2024-10-20 14:15:00	530	537	3	1	63.00	37.00	24	5	9	2	14	8	8	2	5	1	\N	\N	140	1	10	0	1
1208583	2024-10-21 19:00:00	532	534	2	3	47.00	53.00	14	11	7	6	12	12	11	2	3	9	1	0	140	1	10	1	1
1208592	2024-10-26 14:15:00	728	542	1	0	50.00	50.00	15	15	4	7	8	14	6	2	2	4	1	0	140	1	11	0	0
1208587	2024-10-26 19:00:00	541	529	0	4	41.00	59.00	9	15	4	7	15	17	10	3	2	5	\N	\N	140	1	11	0	0
1208586	2024-10-27 16:30:00	543	530	1	0	42.00	58.00	24	10	3	3	8	4	3	10	3	2	\N	\N	140	1	11	1	0
1208598	2024-11-01 20:00:00	542	798	1	0	52.00	48.00	13	7	3	2	19	12	7	2	3	2	\N	\N	140	1	12	0	0
1208596	2024-11-02 15:15:00	547	537	4	3	55.00	45.00	15	8	6	5	17	15	6	1	2	4	\N	\N	140	1	12	2	2
1208601	2024-11-03 17:30:00	536	548	0	2	55.00	45.00	8	9	0	3	6	17	5	9	2	1	\N	\N	140	1	12	0	1
1208609	2024-11-08 20:00:00	728	534	1	3	64.00	36.00	34	11	6	3	9	13	12	4	1	3	\N	\N	140	1	13	0	1
1208604	2024-11-09 20:00:00	537	536	1	0	43.00	57.00	8	13	4	2	7	10	0	6	2	1	0	1	140	1	13	0	0
1208606	2024-11-10 15:15:00	798	530	0	1	53.00	47.00	13	9	6	2	10	16	7	2	1	3	\N	\N	140	1	13	0	0
1208607	2024-11-10 20:00:00	548	529	1	0	30.00	70.00	14	11	6	0	17	6	7	6	3	1	\N	\N	140	1	13	1	0
1208619	2024-11-23 15:15:00	530	542	2	1	70.00	30.00	11	4	8	1	18	19	5	0	3	3	\N	\N	140	1	14	0	1
1212923	2024-11-23 17:30:00	547	540	4	1	76.00	24.00	12	9	5	1	4	19	6	3	0	3	\N	\N	140	1	14	4	0
1208618	2024-11-24 15:15:00	536	728	1	0	52.00	48.00	11	9	3	1	14	14	8	3	2	5	0	1	140	1	14	1	0
1208621	2024-11-29 20:00:00	798	532	2	1	48.00	52.00	9	7	3	1	9	14	3	6	1	1	\N	\N	140	1	15	1	1
1208622	2024-11-30 15:15:00	542	537	1	1	60.00	40.00	18	6	7	3	15	15	13	8	1	4	\N	\N	140	1	15	0	0
1208624	2024-11-30 20:00:00	720	530	0	5	45.00	55.00	9	13	1	9	6	11	3	5	1	2	\N	\N	140	1	15	0	3
1208623	2024-12-01 17:30:00	728	531	1	2	47.00	53.00	7	12	4	7	14	8	1	7	3	0	\N	\N	140	1	15	1	0
1208628	2024-12-02 20:00:00	536	727	1	1	65.00	35.00	12	7	5	3	11	15	5	1	1	1	\N	\N	140	1	15	0	0
1208631	2024-12-06 20:00:00	538	798	2	0	50.00	50.00	12	9	5	4	9	12	3	3	1	0	0	1	140	1	16	1	0
1208636	2024-12-07 17:30:00	532	728	0	1	61.00	39.00	14	6	6	1	5	12	9	4	2	2	\N	\N	140	1	16	0	1
1208634	2024-12-08 13:00:00	537	548	0	3	56.00	44.00	11	15	2	5	12	15	5	3	2	2	\N	\N	140	1	16	0	1
1208630	2024-12-08 20:00:00	530	536	4	3	57.00	43.00	14	4	9	3	11	8	5	3	4	3	\N	\N	140	1	16	1	2
1212926	2024-12-14 13:00:00	540	727	0	0	42.00	58.00	9	6	3	0	13	13	5	4	3	1	\N	\N	140	1	17	0	0
1208643	2024-12-14 17:30:00	536	538	1	0	45.00	55.00	8	10	3	2	12	9	3	4	7	3	\N	\N	140	1	17	0	0
1208641	2024-12-15 15:15:00	542	531	1	1	52.00	48.00	6	9	3	2	14	17	2	4	2	2	\N	\N	140	1	17	0	1
1208639	2024-12-15 20:00:00	529	537	0	1	80.00	20.00	20	6	4	4	5	13	8	2	0	2	\N	\N	140	1	17	0	1
1208650	2024-12-20 20:00:00	547	720	3	0	71.00	29.00	23	1	7	1	13	7	9	1	3	1	\N	\N	140	1	18	2	0
1208648	2024-12-21 15:15:00	538	548	2	0	41.00	59.00	11	7	7	1	19	13	4	7	3	5	\N	\N	140	1	18	2	0
1208655	2024-12-22 13:00:00	532	542	2	2	62.00	38.00	8	11	3	3	20	15	5	4	2	1	\N	\N	140	1	18	0	1
1208652	2024-12-22 17:30:00	537	533	2	5	36.00	64.00	5	18	3	9	17	15	1	5	1	2	2	0	140	1	18	2	2
1208600	2025-01-03 20:00:00	532	541	1	2	38.00	62.00	8	17	5	5	16	9	2	5	2	3	0	1	140	1	12	1	0
1208662	2025-01-11 15:15:00	720	543	1	0	42.00	58.00	12	14	1	3	21	10	1	8	2	4	\N	\N	140	1	19	0	0
1208664	2025-01-12 13:00:00	534	546	1	2	64.00	36.00	15	12	7	3	14	17	4	5	2	3	\N	\N	140	1	19	0	0
1208658	2025-01-13 20:00:00	548	533	1	0	57.00	43.00	6	15	3	5	17	6	3	7	4	2	\N	\N	140	1	19	0	0
1208668	2025-01-18 15:15:00	537	530	1	0	32.00	68.00	9	19	3	4	16	6	2	9	1	3	\N	\N	140	1	20	0	0
1208667	2025-01-19 13:00:00	538	531	1	2	59.00	41.00	3	14	1	6	14	6	3	4	1	0	1	0	140	1	20	0	0
1208666	2025-01-19 17:30:00	727	728	1	1	52.00	48.00	12	8	3	3	9	13	6	3	3	2	\N	\N	140	1	20	0	1
\.


--
-- Data for Name: players; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.players (id, name, "position", team_id) FROM stdin;
\.


--
-- Data for Name: players_statistics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.players_statistics (id, player_id, match_id, minutes, shots, shot_on_target, passes, key_passes, pass_accuracy, fouls_drawn, fouls_committed, goals, red_card, yellow_card) FROM stdin;
\.


--
-- Data for Name: season_teams; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.season_teams (season_id, team_id) FROM stdin;
\.


--
-- Data for Name: seasons; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.seasons (id, year, league_id, current, type, logo, start_date, end_date) FROM stdin;
1	2024	43	t	League	https://media.api-sports.io/football/leagues/43.png	2024-08-10 00:00:00	2025-05-05 00:00:00
2	2024	1033	t	League	https://media.api-sports.io/football/leagues/1033.png	2024-08-10 00:00:00	2025-05-24 00:00:00
3	2024	203	t	League	https://media.api-sports.io/football/leagues/203.png	2024-08-09 00:00:00	2025-06-01 00:00:00
4	2024	51	t	League	https://media.api-sports.io/football/leagues/51.png	2024-08-10 00:00:00	2025-04-26 00:00:00
5	2024	50	t	League	https://media.api-sports.io/football/leagues/50.png	2024-08-10 00:00:00	2025-04-26 00:00:00
6	2024	680	t	Cup	https://media.api-sports.io/football/leagues/680.png	2024-07-21 00:00:00	2025-04-16 00:00:00
7	2024	342	t	League	https://media.api-sports.io/football/leagues/342.png	2024-08-02 00:00:00	2025-04-13 00:00:00
8	2024	865	t	League	https://media.api-sports.io/football/leagues/865.png	2024-08-02 00:00:00	2025-05-18 00:00:00
9	2024	343	t	League	https://media.api-sports.io/football/leagues/343.png	2024-08-07 00:00:00	2025-04-15 00:00:00
10	2024	701	t	League	https://media.api-sports.io/football/leagues/701.png	2024-08-06 00:00:00	2025-04-29 00:00:00
11	2024	761	t	Cup	https://media.api-sports.io/football/leagues/761.png	2024-08-14 00:00:00	2025-04-08 00:00:00
12	2024	12	t	Cup	https://media.api-sports.io/football/leagues/12.png	2024-08-16 00:00:00	2025-04-08 00:00:00
13	2024	492	t	League	https://media.api-sports.io/football/leagues/492.png	2024-08-17 00:00:00	2025-05-24 00:00:00
14	2024	186	t	League	https://media.api-sports.io/football/leagues/186.png	2024-09-19 00:00:00	2025-05-31 00:00:00
15	2024	854	t	League	https://media.api-sports.io/football/leagues/854.png	2024-09-14 00:00:00	2025-05-17 00:00:00
16	2024	1025	t	League	https://media.api-sports.io/football/leagues/1025.png	2024-07-21 00:00:00	2024-11-17 00:00:00
17	2024	1026	t	League	https://media.api-sports.io/football/leagues/1026.png	2024-07-20 00:00:00	2024-11-16 00:00:00
18	2024	755	t	League	https://media.api-sports.io/football/leagues/755.png	2024-08-02 00:00:00	2025-05-31 00:00:00
19	2024	754	t	League	https://media.api-sports.io/football/leagues/754.png	2024-08-02 00:00:00	2025-05-31 00:00:00
20	2024	751	t	League	https://media.api-sports.io/football/leagues/751.png	2024-08-16 00:00:00	2025-06-01 00:00:00
21	2024	752	t	League	https://media.api-sports.io/football/leagues/752.png	2024-08-03 00:00:00	2025-05-31 00:00:00
22	2024	753	t	League	https://media.api-sports.io/football/leagues/753.png	2024-08-03 00:00:00	2025-05-31 00:00:00
23	2024	747	t	League	https://media.api-sports.io/football/leagues/747.png	2024-08-09 00:00:00	2025-06-01 00:00:00
24	2024	85	t	League	https://media.api-sports.io/football/leagues/85.png	2024-07-25 00:00:00	2025-05-18 00:00:00
25	2024	745	t	League	https://media.api-sports.io/football/leagues/745.png	2024-08-02 00:00:00	2025-05-18 00:00:00
26	2024	86	t	League	https://media.api-sports.io/football/leagues/86.png	2024-07-26 00:00:00	2025-05-17 00:00:00
27	2024	83	t	League	https://media.api-sports.io/football/leagues/83.png	2024-07-18 00:00:00	2025-05-17 00:00:00
28	2024	938	t	League	https://media.api-sports.io/football/leagues/938.png	2024-07-19 00:00:00	2025-05-17 00:00:00
29	2024	87	t	League	https://media.api-sports.io/football/leagues/87.png	2024-07-26 00:00:00	2025-05-17 00:00:00
30	2024	939	t	League	https://media.api-sports.io/football/leagues/939.png	2024-07-19 00:00:00	2025-05-17 00:00:00
31	2024	744	t	League	https://media.api-sports.io/football/leagues/744.png	2024-08-02 00:00:00	2025-05-17 00:00:00
32	2024	20	t	Cup	https://media.api-sports.io/football/leagues/20.png	2024-08-16 00:00:00	2025-04-09 00:00:00
33	2024	484	t	League	https://media.api-sports.io/football/leagues/484.png	2024-08-10 00:00:00	2025-05-18 00:00:00
34	2024	1041	t	League	https://media.api-sports.io/football/leagues/1041.png	2024-08-10 00:00:00	2025-05-10 00:00:00
35	2024	234	t	League	https://media.api-sports.io/football/leagues/234.png	2024-07-27 00:00:00	2025-05-04 00:00:00
36	2024	263	t	League	https://media.api-sports.io/football/leagues/263.png	2024-07-27 00:00:00	2025-04-20 00:00:00
37	2024	924	t	Cup	https://media.api-sports.io/football/leagues/924.png	2024-07-19 00:00:00	2024-08-04 00:00:00
38	2024	506	t	League	https://media.api-sports.io/football/leagues/506.png	2024-07-26 00:00:00	2025-05-16 00:00:00
39	2024	229	t	League	https://media.api-sports.io/football/leagues/229.png	2024-08-02 00:00:00	2025-06-06 00:00:00
40	2024	645	t	League	https://media.api-sports.io/football/leagues/645.png	2024-08-03 00:00:00	2025-05-31 00:00:00
41	2024	715	t	Cup	https://media.api-sports.io/football/leagues/715.png	2024-08-31 00:00:00	2025-05-23 00:00:00
42	2024	675	t	League	https://media.api-sports.io/football/leagues/675.png	2024-08-31 00:00:00	2025-05-31 00:00:00
43	2024	948	t	League	https://media.api-sports.io/football/leagues/948.png	2024-09-01 00:00:00	2025-05-11 00:00:00
44	2024	644	t	League	https://media.api-sports.io/football/leagues/644.png	2024-08-03 00:00:00	2025-06-01 00:00:00
45	2024	232	t	League	https://media.api-sports.io/football/leagues/232.png	2024-08-16 00:00:00	2025-06-15 00:00:00
46	2024	230	t	League	https://media.api-sports.io/football/leagues/230.png	2024-08-09 00:00:00	2025-06-14 00:00:00
47	2024	226	t	League	https://media.api-sports.io/football/leagues/226.png	2024-08-09 00:00:00	2025-06-08 00:00:00
48	2024	225	t	League	https://media.api-sports.io/football/leagues/225.png	2024-08-02 00:00:00	2025-06-08 00:00:00
49	2024	224	t	League	https://media.api-sports.io/football/leagues/224.png	2024-08-02 00:00:00	2025-06-07 00:00:00
50	2024	227	t	League	https://media.api-sports.io/football/leagues/227.png	2024-08-02 00:00:00	2025-06-14 00:00:00
51	2024	231	t	League	https://media.api-sports.io/football/leagues/231.png	2024-08-10 00:00:00	2025-06-07 00:00:00
52	2024	228	t	League	https://media.api-sports.io/football/leagues/228.png	2024-08-02 00:00:00	2025-06-06 00:00:00
53	2024	748	t	League	https://media.api-sports.io/football/leagues/748.png	2024-08-03 00:00:00	2025-05-18 00:00:00
54	2024	84	t	League	https://media.api-sports.io/football/leagues/84.png	2024-07-26 00:00:00	2025-05-18 00:00:00
55	2024	138	t	League	https://media.api-sports.io/football/leagues/138.png	2024-08-23 00:00:00	2025-04-27 00:00:00
56	2024	943	t	League	https://media.api-sports.io/football/leagues/943.png	2024-08-23 00:00:00	2025-04-27 00:00:00
57	2024	942	t	League	https://media.api-sports.io/football/leagues/942.png	2024-08-23 00:00:00	2025-04-27 00:00:00
58	2024	419	t	League	https://media.api-sports.io/football/leagues/419.png	2024-08-02 00:00:00	2025-05-23 00:00:00
59	2024	197	t	League	https://media.api-sports.io/football/leagues/197.png	2024-08-17 00:00:00	2025-05-22 00:00:00
60	2024	1128	t	League	https://media.api-sports.io/football/leagues/1128.png	2024-07-02 00:00:00	2024-09-24 00:00:00
61	2024	273	t	Cup	https://media.api-sports.io/football/leagues/273.png	2024-08-03 00:00:00	2025-04-02 00:00:00
62	2024	396	t	League	https://media.api-sports.io/football/leagues/396.png	2024-08-03 00:00:00	2025-04-06 00:00:00
63	2024	559	t	Cup	https://media.api-sports.io/football/leagues/559.png	2024-08-13 00:00:00	2025-03-09 00:00:00
64	2024	82	t	League	https://media.api-sports.io/football/leagues/82.png	2024-08-30 00:00:00	2025-05-11 00:00:00
65	2024	139	t	League	https://media.api-sports.io/football/leagues/139.png	2024-08-30 00:00:00	2025-05-10 00:00:00
66	2024	64	t	League	https://media.api-sports.io/football/leagues/64.png	2024-09-21 00:00:00	2025-05-07 00:00:00
67	2024	313	t	League	https://media.api-sports.io/football/leagues/313.png	2024-09-29 00:00:00	2025-05-18 00:00:00
68	2024	556	t	Cup	https://media.api-sports.io/football/leagues/556.png	2025-01-08 00:00:00	2025-01-12 00:00:00
69	2024	750	t	League	https://media.api-sports.io/football/leagues/750.png	2024-07-27 00:00:00	2025-05-31 00:00:00
70	2024	284	t	League	https://media.api-sports.io/football/leagues/284.png	2024-08-03 00:00:00	2025-05-17 00:00:00
71	2024	676	t	League	https://media.api-sports.io/football/leagues/676.png	2024-08-10 00:00:00	2025-05-31 00:00:00
72	2024	410	t	League	https://media.api-sports.io/football/leagues/410.png	2024-08-10 00:00:00	2025-05-18 00:00:00
73	2024	63	t	League	https://media.api-sports.io/football/leagues/63.png	2024-08-16 00:00:00	2025-05-16 00:00:00
74	2024	307	t	League	https://media.api-sports.io/football/leagues/307.png	2024-08-22 00:00:00	2025-05-26 00:00:00
75	2024	91	t	League	https://media.api-sports.io/football/leagues/91.png	2024-09-28 00:00:00	2025-05-17 00:00:00
76	2024	297	t	League	https://media.api-sports.io/football/leagues/297.png	2024-08-09 00:00:00	2025-04-26 00:00:00
77	2024	178	t	League	https://media.api-sports.io/football/leagues/178.png	2024-08-03 00:00:00	2025-06-07 00:00:00
78	2024	177	t	League	https://media.api-sports.io/football/leagues/177.png	2024-08-03 00:00:00	2025-05-31 00:00:00
79	2024	749	t	League	https://media.api-sports.io/football/leagues/749.png	2024-08-16 00:00:00	2025-05-16 00:00:00
80	2024	370	t	League	https://media.api-sports.io/football/leagues/370.png	2024-07-27 00:00:00	2025-05-03 00:00:00
81	2024	931	t	League	https://media.api-sports.io/football/leagues/931.png	2024-08-10 00:00:00	2025-04-26 00:00:00
82	2024	705	t	League	https://media.api-sports.io/football/leagues/705.png	2024-08-17 00:00:00	2025-05-17 00:00:00
83	2024	699	t	League	https://media.api-sports.io/football/leagues/699.png	2024-09-08 00:00:00	2025-05-04 00:00:00
84	2024	44	t	League	https://media.api-sports.io/football/leagues/44.png	2024-09-22 00:00:00	2025-05-11 00:00:00
85	2024	746	t	League	https://media.api-sports.io/football/leagues/746.png	2024-08-24 00:00:00	2025-06-15 00:00:00
86	2024	67	t	League	https://media.api-sports.io/football/leagues/67.png	2024-08-17 00:00:00	2025-05-17 00:00:00
87	2024	68	t	League	https://media.api-sports.io/football/leagues/68.png	2024-08-17 00:00:00	2025-05-17 00:00:00
88	2024	69	t	League	https://media.api-sports.io/football/leagues/69.png	2024-08-17 00:00:00	2025-05-17 00:00:00
89	2024	932	t	League	https://media.api-sports.io/football/leagues/932.png	2024-08-10 00:00:00	2025-04-26 00:00:00
90	2024	52	t	League	https://media.api-sports.io/football/leagues/52.png	2024-08-10 00:00:00	2025-04-26 00:00:00
91	2024	58	t	League	https://media.api-sports.io/football/leagues/58.png	2024-08-10 00:00:00	2025-04-26 00:00:00
92	2024	59	t	League	https://media.api-sports.io/football/leagues/59.png	2024-08-10 00:00:00	2025-04-26 00:00:00
93	2024	60	t	League	https://media.api-sports.io/football/leagues/60.png	2024-08-10 00:00:00	2025-04-26 00:00:00
94	2024	56	t	League	https://media.api-sports.io/football/leagues/56.png	2024-08-10 00:00:00	2025-04-26 00:00:00
95	2024	53	t	League	https://media.api-sports.io/football/leagues/53.png	2024-08-10 00:00:00	2025-04-26 00:00:00
96	2024	57	t	League	https://media.api-sports.io/football/leagues/57.png	2024-08-10 00:00:00	2025-04-26 00:00:00
97	2024	54	t	League	https://media.api-sports.io/football/leagues/54.png	2024-08-10 00:00:00	2025-04-26 00:00:00
98	2024	55	t	League	https://media.api-sports.io/football/leagues/55.png	2024-08-10 00:00:00	2025-04-26 00:00:00
99	2024	933	t	League	https://media.api-sports.io/football/leagues/933.png	2024-08-10 00:00:00	2025-04-26 00:00:00
100	2024	958	t	Cup	https://media.api-sports.io/football/leagues/958.png	2024-07-28 00:00:00	2025-03-21 00:00:00
101	2024	181	t	Cup	https://media.api-sports.io/football/leagues/181.png	2024-08-09 00:00:00	2025-04-19 00:00:00
102	2024	356	t	League	https://media.api-sports.io/football/leagues/356.png	2024-08-10 00:00:00	2025-05-24 00:00:00
103	2024	204	t	League	https://media.api-sports.io/football/leagues/204.png	2024-08-11 00:00:00	2025-05-10 00:00:00
104	2024	1034	t	League	https://media.api-sports.io/football/leagues/1034.png	2024-08-24 00:00:00	2025-05-18 00:00:00
105	2024	457	t	League	https://media.api-sports.io/football/leagues/457.png	2024-08-18 00:00:00	2025-04-13 00:00:00
106	2024	458	t	League	https://media.api-sports.io/football/leagues/458.png	2024-08-18 00:00:00	2025-04-13 00:00:00
107	2024	459	t	League	https://media.api-sports.io/football/leagues/459.png	2024-08-18 00:00:00	2025-04-13 00:00:00
108	2024	460	t	League	https://media.api-sports.io/football/leagues/460.png	2024-08-18 00:00:00	2025-04-13 00:00:00
109	2024	1129	t	Cup	https://media.api-sports.io/football/leagues/1129.png	2024-07-17 00:00:00	2025-04-30 00:00:00
110	2024	316	t	League	https://media.api-sports.io/football/leagues/316.png	2024-08-17 00:00:00	2025-06-15 00:00:00
111	2024	290	t	League	https://media.api-sports.io/football/leagues/290.png	2024-08-15 00:00:00	2025-04-24 00:00:00
112	2024	317	t	League	https://media.api-sports.io/football/leagues/317.png	2024-08-10 00:00:00	2025-06-07 00:00:00
113	2024	1023	t	League	https://media.api-sports.io/football/leagues/1023.png	2024-07-28 00:00:00	2025-05-25 00:00:00
114	2024	436	t	League	https://media.api-sports.io/football/leagues/436.png	2024-08-25 00:00:00	2025-05-25 00:00:00
115	2024	435	t	League	https://media.api-sports.io/football/leagues/435.png	2024-08-25 00:00:00	2025-05-25 00:00:00
116	2024	875	t	League	https://media.api-sports.io/football/leagues/875.png	2024-09-01 00:00:00	2025-05-04 00:00:00
117	2024	879	t	League	https://media.api-sports.io/football/leagues/879.png	2024-09-01 00:00:00	2025-05-04 00:00:00
118	2024	878	t	League	https://media.api-sports.io/football/leagues/878.png	2024-09-01 00:00:00	2025-05-04 00:00:00
119	2024	877	t	League	https://media.api-sports.io/football/leagues/877.png	2024-09-01 00:00:00	2025-05-04 00:00:00
120	2024	876	t	League	https://media.api-sports.io/football/leagues/876.png	2024-09-01 00:00:00	2025-05-04 00:00:00
121	2024	387	t	League	https://media.api-sports.io/football/leagues/387.png	2024-08-08 00:00:00	2025-04-27 00:00:00
122	2024	1029	t	League	https://media.api-sports.io/football/leagues/1029.png	2024-08-24 00:00:00	2025-05-17 00:00:00
123	2024	488	t	League	https://media.api-sports.io/football/leagues/488.png	2024-08-03 00:00:00	2025-05-17 00:00:00
124	2024	175	t	League	https://media.api-sports.io/football/leagues/175.png	2024-08-17 00:00:00	2025-05-31 00:00:00
125	2024	461	t	League	https://media.api-sports.io/football/leagues/461.png	2024-08-24 00:00:00	2025-05-17 00:00:00
126	2024	462	t	League	https://media.api-sports.io/football/leagues/462.png	2024-08-24 00:00:00	2025-05-17 00:00:00
127	2024	463	t	League	https://media.api-sports.io/football/leagues/463.png	2024-08-24 00:00:00	2025-05-17 00:00:00
128	2024	466	t	League	https://media.api-sports.io/football/leagues/466.png	2024-08-24 00:00:00	2025-05-17 00:00:00
129	2024	468	t	League	https://media.api-sports.io/football/leagues/468.png	2024-08-24 00:00:00	2025-05-17 00:00:00
130	2024	467	t	League	https://media.api-sports.io/football/leagues/467.png	2024-08-24 00:00:00	2025-05-17 00:00:00
131	2024	464	t	League	https://media.api-sports.io/football/leagues/464.png	2024-08-24 00:00:00	2025-05-17 00:00:00
132	2024	465	t	League	https://media.api-sports.io/football/leagues/465.png	2024-08-24 00:00:00	2025-05-17 00:00:00
133	2024	469	t	League	https://media.api-sports.io/football/leagues/469.png	2024-08-24 00:00:00	2025-05-17 00:00:00
134	2024	509	t	Cup	https://media.api-sports.io/football/leagues/509.png	2024-08-03 00:00:00	2024-10-05 00:00:00
135	2024	331	t	League	https://media.api-sports.io/football/leagues/331.png	2024-08-18 00:00:00	2025-04-15 00:00:00
136	2024	816	t	Cup	https://media.api-sports.io/football/leagues/816.png	2024-08-29 00:00:00	2024-11-20 00:00:00
137	2024	319	t	League	https://media.api-sports.io/football/leagues/319.png	2024-09-13 00:00:00	2025-04-26 00:00:00
138	2024	274	t	League	https://media.api-sports.io/football/leagues/274.png	2024-08-09 00:00:00	2025-05-25 00:00:00
139	2024	176	t	League	https://media.api-sports.io/football/leagues/176.png	2024-08-31 00:00:00	2025-05-24 00:00:00
140	2024	153	t	League	https://media.api-sports.io/football/leagues/153.png	2024-08-31 00:00:00	2025-04-27 00:00:00
141	2024	161	t	League	https://media.api-sports.io/football/leagues/161.png	2024-08-31 00:00:00	2025-04-27 00:00:00
142	2024	160	t	League	https://media.api-sports.io/football/leagues/160.png	2024-08-31 00:00:00	2025-04-27 00:00:00
143	2024	159	t	League	https://media.api-sports.io/football/leagues/159.png	2024-08-17 00:00:00	2025-04-27 00:00:00
144	2024	691	t	League	https://media.api-sports.io/football/leagues/691.png	2024-08-31 00:00:00	2025-04-27 00:00:00
145	2024	155	t	League	https://media.api-sports.io/football/leagues/155.png	2024-08-17 00:00:00	2025-04-27 00:00:00
146	2024	157	t	League	https://media.api-sports.io/football/leagues/157.png	2024-08-31 00:00:00	2025-04-27 00:00:00
147	2024	158	t	League	https://media.api-sports.io/football/leagues/158.png	2024-08-24 00:00:00	2025-04-13 00:00:00
148	2024	154	t	League	https://media.api-sports.io/football/leagues/154.png	2024-08-31 00:00:00	2025-04-27 00:00:00
149	2024	156	t	League	https://media.api-sports.io/football/leagues/156.png	2024-08-17 00:00:00	2025-04-27 00:00:00
150	2024	335	t	Cup	https://media.api-sports.io/football/leagues/335.png	2024-08-03 00:00:00	2025-04-02 00:00:00
151	2024	270	t	League	https://media.api-sports.io/football/leagues/270.png	2024-08-16 00:00:00	2024-12-02 00:00:00
152	2024	441	t	League	https://media.api-sports.io/football/leagues/441.png	2024-09-08 00:00:00	2025-05-11 00:00:00
153	2024	442	t	League	https://media.api-sports.io/football/leagues/442.png	2024-09-07 00:00:00	2025-05-11 00:00:00
154	2024	443	t	League	https://media.api-sports.io/football/leagues/443.png	2024-09-08 00:00:00	2025-05-11 00:00:00
155	2024	446	t	League	https://media.api-sports.io/football/leagues/446.png	2024-09-07 00:00:00	2025-05-11 00:00:00
156	2024	449	t	League	https://media.api-sports.io/football/leagues/449.png	2024-09-07 00:00:00	2025-05-11 00:00:00
157	2024	455	t	League	https://media.api-sports.io/football/leagues/455.png	2024-09-07 00:00:00	2025-05-11 00:00:00
158	2024	967	t	Cup	https://media.api-sports.io/football/leagues/967.png	2024-08-10 00:00:00	2024-08-21 00:00:00
159	2024	371	t	League	https://media.api-sports.io/football/leagues/371.png	2024-08-11 00:00:00	2025-05-18 00:00:00
160	2024	302	t	Cup	https://media.api-sports.io/football/leagues/302.png	2024-08-17 00:00:00	2025-03-22 00:00:00
161	2024	706	t	League	https://media.api-sports.io/football/leagues/706.png	2024-09-14 00:00:00	2025-05-10 00:00:00
162	2024	728	t	League	https://media.api-sports.io/football/leagues/728.png	2024-08-24 00:00:00	2025-05-25 00:00:00
163	2024	570	t	League	https://media.api-sports.io/football/leagues/570.png	2024-09-06 00:00:00	2025-06-07 00:00:00
164	2024	336	t	League	https://media.api-sports.io/football/leagues/336.png	2024-08-08 00:00:00	2025-05-17 00:00:00
165	2024	405	t	League	https://media.api-sports.io/football/leagues/405.png	2024-08-15 00:00:00	2025-05-18 00:00:00
166	2024	406	t	League	https://media.api-sports.io/football/leagues/406.png	2024-08-15 00:00:00	2025-05-25 00:00:00
167	2024	1036	t	Cup	https://media.api-sports.io/football/leagues/1036.png	2024-09-07 00:00:00	2024-11-16 00:00:00
168	2024	303	t	League	https://media.api-sports.io/football/leagues/303.png	2024-09-14 00:00:00	2025-05-30 00:00:00
169	2024	440	t	League	https://media.api-sports.io/football/leagues/440.png	2024-09-08 00:00:00	2025-05-11 00:00:00
170	2024	205	t	League	https://media.api-sports.io/football/leagues/205.png	2024-09-01 00:00:00	2025-05-03 00:00:00
171	2024	633	t	League	https://media.api-sports.io/football/leagues/633.png	2024-07-28 00:00:00	2025-05-25 00:00:00
172	2024	635	t	League	https://media.api-sports.io/football/leagues/635.png	2024-07-27 00:00:00	2025-05-25 00:00:00
173	2024	634	t	League	https://media.api-sports.io/football/leagues/634.png	2024-07-27 00:00:00	2025-05-25 00:00:00
174	2024	334	t	League	https://media.api-sports.io/football/leagues/334.png	2024-08-07 00:00:00	2025-05-30 00:00:00
175	2024	664	t	League	https://media.api-sports.io/football/leagues/664.png	2024-08-10 00:00:00	2025-04-06 00:00:00
176	2024	710	t	League	https://media.api-sports.io/football/leagues/710.png	2024-08-16 00:00:00	2024-12-01 00:00:00
177	2024	1037	t	League	https://media.api-sports.io/football/leagues/1037.png	2024-08-21 00:00:00	2024-10-09 00:00:00
178	2024	310	t	League	https://media.api-sports.io/football/leagues/310.png	2024-08-18 00:00:00	2025-05-01 00:00:00
179	2024	311	t	League	https://media.api-sports.io/football/leagues/311.png	2024-08-24 00:00:00	2025-04-19 00:00:00
180	2024	312	t	League	https://media.api-sports.io/football/leagues/312.png	2024-09-15 00:00:00	2025-05-18 00:00:00
181	2024	702	t	League	https://media.api-sports.io/football/leagues/702.png	2024-08-16 00:00:00	2025-04-14 00:00:00
182	2024	696	t	League	https://media.api-sports.io/football/leagues/696.png	2024-08-17 00:00:00	2025-05-03 00:00:00
183	2024	695	t	League	https://media.api-sports.io/football/leagues/695.png	2024-08-17 00:00:00	2025-05-03 00:00:00
184	2024	416	t	League	https://media.api-sports.io/football/leagues/416.png	2024-08-04 00:00:00	2025-03-30 00:00:00
185	2024	552	t	League	https://media.api-sports.io/football/leagues/552.png	2024-09-08 00:00:00	2025-04-27 00:00:00
186	2024	1027	t	League	https://media.api-sports.io/football/leagues/1027.png	2024-09-08 00:00:00	2025-04-26 00:00:00
187	2024	553	t	League	https://media.api-sports.io/football/leagues/553.png	2024-09-08 00:00:00	2025-04-26 00:00:00
188	2024	554	t	League	https://media.api-sports.io/football/leagues/554.png	2024-09-08 00:00:00	2025-04-26 00:00:00
189	2024	188	t	League	https://media.api-sports.io/football/leagues/188.png	2024-10-18 00:00:00	2025-05-04 00:00:00
190	2024	174	t	Cup	https://media.api-sports.io/football/leagues/174.png	2024-08-07 00:00:00	2025-04-23 00:00:00
191	2024	439	t	League	https://media.api-sports.io/football/leagues/439.png	2024-09-08 00:00:00	2025-05-11 00:00:00
192	2024	450	t	League	https://media.api-sports.io/football/leagues/450.png	2024-09-06 00:00:00	2025-05-11 00:00:00
193	2024	452	t	League	https://media.api-sports.io/football/leagues/452.png	2024-09-07 00:00:00	2025-05-11 00:00:00
194	2024	453	t	League	https://media.api-sports.io/football/leagues/453.png	2024-09-06 00:00:00	2025-05-11 00:00:00
195	2024	187	t	League	https://media.api-sports.io/football/leagues/187.png	2024-09-20 00:00:00	2025-05-23 00:00:00
196	2024	572	t	League	https://media.api-sports.io/football/leagues/572.png	2024-08-16 00:00:00	2025-05-31 00:00:00
197	2024	575	t	League	https://media.api-sports.io/football/leagues/575.png	2024-08-17 00:00:00	2025-06-08 00:00:00
198	2024	574	t	League	https://media.api-sports.io/football/leagues/574.png	2024-08-10 00:00:00	2025-06-15 00:00:00
199	2024	573	t	League	https://media.api-sports.io/football/leagues/573.png	2024-08-17 00:00:00	2025-06-07 00:00:00
200	2024	90	t	Cup	https://media.api-sports.io/football/leagues/90.png	2024-09-03 00:00:00	2025-04-21 00:00:00
201	2024	96	t	Cup	https://media.api-sports.io/football/leagues/96.png	2024-09-07 00:00:00	2025-04-23 00:00:00
202	2024	375	t	Cup	https://media.api-sports.io/football/leagues/375.png	2024-08-07 00:00:00	2025-04-02 00:00:00
203	2024	703	t	League	https://media.api-sports.io/football/leagues/703.png	2024-08-09 00:00:00	2025-05-06 00:00:00
204	2024	518	t	League	https://media.api-sports.io/football/leagues/518.png	2024-08-16 00:00:00	2025-04-25 00:00:00
205	2024	372	t	League	https://media.api-sports.io/football/leagues/372.png	2024-08-17 00:00:00	2025-05-17 00:00:00
206	2024	392	t	League	https://media.api-sports.io/football/leagues/392.png	2024-09-14 00:00:00	2025-04-06 00:00:00
207	2024	456	t	League	https://media.api-sports.io/football/leagues/456.png	2024-09-07 00:00:00	2025-05-11 00:00:00
208	2024	451	t	League	https://media.api-sports.io/football/leagues/451.png	2024-09-08 00:00:00	2025-05-11 00:00:00
209	2024	1130	t	League	https://media.api-sports.io/football/leagues/1130.png	2024-08-17 00:00:00	2025-06-01 00:00:00
210	2024	212	t	Cup	https://media.api-sports.io/football/leagues/212.png	2024-08-27 00:00:00	2025-05-28 00:00:00
211	2024	277	t	League	https://media.api-sports.io/football/leagues/277.png	2024-09-21 00:00:00	2025-04-06 00:00:00
212	2024	1044	t	Cup	https://media.api-sports.io/football/leagues/1044.png	2024-10-18 00:00:00	2025-03-15 00:00:00
213	2024	454	t	League	https://media.api-sports.io/football/leagues/454.png	2024-09-08 00:00:00	2025-05-11 00:00:00
214	2024	930	t	Cup	https://media.api-sports.io/football/leagues/930.png	2024-08-10 00:00:00	2024-12-06 00:00:00
215	2024	892	t	Cup	https://media.api-sports.io/football/leagues/892.png	2024-08-24 00:00:00	2025-03-12 00:00:00
216	2024	567	t	League	https://media.api-sports.io/football/leagues/567.png	2024-08-16 00:00:00	2025-05-24 00:00:00
217	2024	445	t	League	https://media.api-sports.io/football/leagues/445.png	2024-09-08 00:00:00	2025-05-11 00:00:00
218	2024	1132	t	Cup	https://media.api-sports.io/football/leagues/1132.png	2024-08-13 00:00:00	2025-04-17 00:00:00
219	2024	709	t	Cup	https://media.api-sports.io/football/leagues/709.png	2024-08-20 00:00:00	2025-04-01 00:00:00
220	2024	721	t	Cup	https://media.api-sports.io/football/leagues/721.png	2024-09-04 00:00:00	2025-04-23 00:00:00
221	2024	320	t	League	https://media.api-sports.io/football/leagues/320.png	2024-09-28 00:00:00	2025-04-26 00:00:00
222	2024	217	t	League	https://media.api-sports.io/football/leagues/217.png	2024-08-24 00:00:00	2025-05-31 00:00:00
223	2024	215	t	League	https://media.api-sports.io/football/leagues/215.png	2024-08-15 00:00:00	2025-05-31 00:00:00
224	2024	213	t	League	https://media.api-sports.io/football/leagues/213.png	2024-08-31 00:00:00	2025-05-31 00:00:00
225	2024	758	t	League	https://media.api-sports.io/football/leagues/758.png	2024-08-16 00:00:00	2025-03-16 00:00:00
226	2024	448	t	League	https://media.api-sports.io/football/leagues/448.png	2024-09-08 00:00:00	2025-05-11 00:00:00
227	2024	200	t	League	https://media.api-sports.io/football/leagues/200.png	2024-08-30 00:00:00	2025-03-16 00:00:00
228	2024	1039	t	Cup	https://media.api-sports.io/football/leagues/1039.png	2024-08-21 00:00:00	2025-04-22 00:00:00
229	2024	566	t	League	https://media.api-sports.io/football/leagues/566.png	2024-08-23 00:00:00	2025-05-07 00:00:00
230	2024	202	t	League	https://media.api-sports.io/football/leagues/202.png	2024-08-28 00:00:00	2025-05-17 00:00:00
231	2024	380	t	League	https://media.api-sports.io/football/leagues/380.png	2024-08-30 00:00:00	2025-05-25 00:00:00
232	2024	92	t	League	https://media.api-sports.io/football/leagues/92.png	2024-08-17 00:00:00	2025-05-24 00:00:00
233	2024	386	t	League	https://media.api-sports.io/football/leagues/386.png	2024-09-20 00:00:00	2025-04-01 00:00:00
234	2024	289	t	League	https://media.api-sports.io/football/leagues/289.png	2024-08-23 00:00:00	2025-05-18 00:00:00
235	2024	93	t	League	https://media.api-sports.io/football/leagues/93.png	2024-08-17 00:00:00	2025-05-24 00:00:00
236	2024	427	t	League	https://media.api-sports.io/football/leagues/427.png	2024-09-08 00:00:00	2025-05-04 00:00:00
237	2024	426	t	League	https://media.api-sports.io/football/leagues/426.png	2024-09-07 00:00:00	2025-05-04 00:00:00
238	2024	428	t	League	https://media.api-sports.io/football/leagues/428.png	2024-09-08 00:00:00	2025-05-04 00:00:00
239	2024	432	t	League	https://media.api-sports.io/football/leagues/432.png	2024-09-08 00:00:00	2025-05-04 00:00:00
240	2024	429	t	League	https://media.api-sports.io/football/leagues/429.png	2024-09-08 00:00:00	2025-05-04 00:00:00
241	2024	430	t	League	https://media.api-sports.io/football/leagues/430.png	2024-09-08 00:00:00	2025-05-04 00:00:00
242	2024	431	t	League	https://media.api-sports.io/football/leagues/431.png	2024-09-08 00:00:00	2025-05-04 00:00:00
243	2024	433	t	League	https://media.api-sports.io/football/leagues/433.png	2024-09-08 00:00:00	2025-05-04 00:00:00
244	2024	434	t	League	https://media.api-sports.io/football/leagues/434.png	2024-09-08 00:00:00	2025-05-04 00:00:00
245	2024	1133	t	League	https://media.api-sports.io/football/leagues/1133.png	2024-08-17 00:00:00	2024-11-10 00:00:00
246	2024	142	t	League	https://media.api-sports.io/football/leagues/142.png	2024-09-08 00:00:00	2025-05-18 00:00:00
247	2024	585	t	League	https://media.api-sports.io/football/leagues/585.png	2024-09-13 00:00:00	2025-05-24 00:00:00
248	2024	625	t	League	https://media.api-sports.io/football/leagues/625.png	2024-09-21 00:00:00	2024-12-07 00:00:00
249	2024	444	t	League	https://media.api-sports.io/football/leagues/444.png	2024-09-06 00:00:00	2025-05-11 00:00:00
250	2024	1052	t	League	https://media.api-sports.io/football/leagues/1052.png	2024-08-22 00:00:00	2024-10-20 00:00:00
251	2024	756	t	Cup	https://media.api-sports.io/football/leagues/756.png	2024-09-18 00:00:00	2025-04-23 00:00:00
252	2024	647	t	League	https://media.api-sports.io/football/leagues/647.png	2024-09-14 00:00:00	2025-03-01 00:00:00
253	2024	404	t	League	https://media.api-sports.io/football/leagues/404.png	2024-08-30 00:00:00	2025-04-13 00:00:00
254	2024	384	t	Cup	https://media.api-sports.io/football/leagues/384.png	2024-08-29 00:00:00	2025-04-22 00:00:00
255	2024	214	t	League	https://media.api-sports.io/football/leagues/214.png	2024-08-31 00:00:00	2025-05-31 00:00:00
256	2024	1134	t	League	https://media.api-sports.io/football/leagues/1134.png	2024-08-19 00:00:00	2024-09-20 00:00:00
257	2024	898	t	Cup	https://media.api-sports.io/football/leagues/898.png	2024-08-31 00:00:00	2025-04-16 00:00:00
258	2024	496	t	League	https://media.api-sports.io/football/leagues/496.png	2024-09-05 00:00:00	2025-04-26 00:00:00
259	2024	418	t	League	https://media.api-sports.io/football/leagues/418.png	2024-09-11 00:00:00	2025-05-22 00:00:00
260	2024	412	t	League	https://media.api-sports.io/football/leagues/412.png	2024-09-21 00:00:00	2025-05-24 00:00:00
261	2024	729	t	Cup	https://media.api-sports.io/football/leagues/729.png	2024-09-24 00:00:00	2025-05-24 00:00:00
262	2024	677	t	Cup	https://media.api-sports.io/football/leagues/677.png	2024-08-30 00:00:00	2024-12-20 00:00:00
263	2024	762	t	League	https://media.api-sports.io/football/leagues/762.png	2024-09-14 00:00:00	2025-06-14 00:00:00
264	2024	291	t	League	https://media.api-sports.io/football/leagues/291.png	2024-09-09 00:00:00	2025-05-21 00:00:00
265	2024	363	t	League	https://media.api-sports.io/football/leagues/363.png	2024-09-20 00:00:00	2025-06-28 00:00:00
266	2024	1135	t	League	https://media.api-sports.io/football/leagues/1135.png	2024-08-24 00:00:00	2024-11-16 00:00:00
267	2024	1136	t	Cup	https://media.api-sports.io/football/leagues/1136.png	2024-08-16 00:00:00	2025-05-22 00:00:00
268	2024	1138	t	League	https://media.api-sports.io/football/leagues/1138.png	2024-08-24 00:00:00	2024-11-23 00:00:00
269	2024	1139	t	League	https://media.api-sports.io/football/leagues/1139.png	2024-07-27 00:00:00	2024-09-17 00:00:00
270	2024	323	t	League	https://media.api-sports.io/football/leagues/323.png	2024-09-13 00:00:00	2025-04-07 00:00:00
271	2024	791	t	League	https://media.api-sports.io/football/leagues/791.png	2024-08-30 00:00:00	2025-05-24 00:00:00
272	2024	790	t	League	https://media.api-sports.io/football/leagues/790.png	2024-08-30 00:00:00	2025-05-24 00:00:00
273	2024	787	t	League	https://media.api-sports.io/football/leagues/787.png	2024-08-30 00:00:00	2025-05-24 00:00:00
274	2024	792	t	League	https://media.api-sports.io/football/leagues/792.png	2024-08-30 00:00:00	2025-05-24 00:00:00
275	2024	784	t	League	https://media.api-sports.io/football/leagues/784.png	2024-08-30 00:00:00	2025-05-24 00:00:00
276	2024	793	t	League	https://media.api-sports.io/football/leagues/793.png	2024-08-30 00:00:00	2025-05-24 00:00:00
277	2024	785	t	League	https://media.api-sports.io/football/leagues/785.png	2024-08-30 00:00:00	2025-05-24 00:00:00
278	2024	789	t	League	https://media.api-sports.io/football/leagues/789.png	2024-08-30 00:00:00	2025-05-24 00:00:00
279	2024	788	t	League	https://media.api-sports.io/football/leagues/788.png	2024-08-30 00:00:00	2025-05-24 00:00:00
280	2024	786	t	League	https://media.api-sports.io/football/leagues/786.png	2024-08-30 00:00:00	2025-05-24 00:00:00
281	2024	871	t	Cup	https://media.api-sports.io/football/leagues/871.png	2024-08-27 00:00:00	2025-04-07 00:00:00
282	2024	199	t	Cup	https://media.api-sports.io/football/leagues/199.png	2024-08-31 00:00:00	2025-05-16 00:00:00
283	2024	576	t	League	https://media.api-sports.io/football/leagues/576.png	2024-09-22 00:00:00	2025-04-27 00:00:00
284	2024	577	t	League	https://media.api-sports.io/football/leagues/577.png	2024-09-22 00:00:00	2025-04-27 00:00:00
285	2024	578	t	League	https://media.api-sports.io/football/leagues/578.png	2024-09-22 00:00:00	2025-04-16 00:00:00
286	2024	579	t	League	https://media.api-sports.io/football/leagues/579.png	2024-09-22 00:00:00	2025-04-27 00:00:00
287	2024	734	t	League	https://media.api-sports.io/football/leagues/734.png	2024-08-31 00:00:00	2025-05-03 00:00:00
288	2024	381	t	League	https://media.api-sports.io/football/leagues/381.png	2024-09-15 00:00:00	2025-05-18 00:00:00
289	2024	216	t	League	https://media.api-sports.io/football/leagues/216.png	2024-08-30 00:00:00	2025-05-31 00:00:00
290	2024	1140	t	Cup	https://media.api-sports.io/football/leagues/1140.png	2024-08-25 00:00:00	2025-05-21 00:00:00
291	2024	863	t	Cup	https://media.api-sports.io/football/leagues/863.png	2024-10-01 00:00:00	2024-12-19 00:00:00
292	2024	306	t	League	https://media.api-sports.io/football/leagues/306.png	2024-09-19 00:00:00	2025-04-17 00:00:00
293	2024	377	t	League	https://media.api-sports.io/football/leagues/377.png	2024-08-31 00:00:00	2025-05-10 00:00:00
294	2024	397	t	League	https://media.api-sports.io/football/leagues/397.png	2024-09-10 00:00:00	2025-05-24 00:00:00
295	2024	716	t	Cup	https://media.api-sports.io/football/leagues/716.png	2024-09-08 00:00:00	2025-01-30 00:00:00
296	2024	1141	t	League	https://media.api-sports.io/football/leagues/1141.png	2024-08-31 00:00:00	2024-10-26 00:00:00
297	2024	1142	t	League	https://media.api-sports.io/football/leagues/1142.png	2024-08-31 00:00:00	2024-11-28 00:00:00
298	2024	1143	t	League	https://media.api-sports.io/football/leagues/1143.png	2024-08-24 00:00:00	2024-11-20 00:00:00
299	2024	872	t	League	https://media.api-sports.io/football/leagues/872.png	2024-09-06 00:00:00	2025-04-06 00:00:00
300	2024	112	t	Cup	https://media.api-sports.io/football/leagues/112.png	2024-09-20 00:00:00	2025-05-04 00:00:00
301	2024	722	t	League	https://media.api-sports.io/football/leagues/722.png	2024-09-07 00:00:00	2025-04-13 00:00:00
302	2024	390	t	League	https://media.api-sports.io/football/leagues/390.png	2024-09-20 00:00:00	2025-04-11 00:00:00
303	2024	298	t	Cup	https://media.api-sports.io/football/leagues/298.png	2024-09-11 00:00:00	2025-04-09 00:00:00
304	2024	560	t	Cup	https://media.api-sports.io/football/leagues/560.png	2024-09-20 00:00:00	2025-04-02 00:00:00
305	2024	674	t	Cup	https://media.api-sports.io/football/leagues/674.png	2024-09-04 00:00:00	2025-04-15 00:00:00
306	2024	206	t	Cup	https://media.api-sports.io/football/leagues/206.png	2024-09-10 00:00:00	2025-04-21 00:00:00
307	2024	732	t	Cup	https://media.api-sports.io/football/leagues/732.png	2024-09-11 00:00:00	2025-04-02 00:00:00
308	2024	447	t	League	https://media.api-sports.io/football/leagues/447.png	2024-09-07 00:00:00	2025-05-11 00:00:00
309	2024	14	t	League	https://media.api-sports.io/football/leagues/14.png	2024-09-17 00:00:00	2025-04-24 00:00:00
310	2024	697	t	Cup	https://media.api-sports.io/football/leagues/697.png	2024-10-02 00:00:00	2025-03-15 00:00:00
311	2024	425	t	League	https://media.api-sports.io/football/leagues/425.png	2024-10-18 00:00:00	2025-01-03 00:00:00
312	2024	1058	t	Cup	https://media.api-sports.io/football/leagues/1058.png	2025-01-22 00:00:00	2025-01-26 00:00:00
313	2024	1168	t	Cup	https://media.api-sports.io/football/leagues/1168.png	2024-09-22 00:00:00	2024-12-18 00:00:00
314	2024	275	t	League	https://media.api-sports.io/football/leagues/275.png	2024-09-07 00:00:00	2025-02-28 00:00:00
315	2024	288	t	League	https://media.api-sports.io/football/leagues/288.png	2024-09-14 00:00:00	2025-05-24 00:00:00
316	2024	1145	t	League	https://media.api-sports.io/football/leagues/1145.png	2024-09-07 00:00:00	2024-12-04 00:00:00
317	2024	1146	t	Cup	https://media.api-sports.io/football/leagues/1146.png	2024-09-07 00:00:00	2024-11-09 00:00:00
318	2024	276	t	League	https://media.api-sports.io/football/leagues/276.png	2024-08-24 00:00:00	2025-06-22 00:00:00
319	2024	417	t	League	https://media.api-sports.io/football/leagues/417.png	2024-09-21 00:00:00	2025-04-21 00:00:00
320	2024	617	t	Cup	https://media.api-sports.io/football/leagues/617.png	2024-10-01 00:00:00	2024-12-02 00:00:00
321	2024	494	t	League	https://media.api-sports.io/football/leagues/494.png	2024-09-20 00:00:00	2025-05-04 00:00:00
322	2024	847	t	League	https://media.api-sports.io/football/leagues/847.png	2024-09-14 00:00:00	2025-03-30 00:00:00
323	2024	322	t	League	https://media.api-sports.io/football/leagues/322.png	2024-09-15 00:00:00	2025-04-20 00:00:00
324	2024	771	t	Cup	https://media.api-sports.io/football/leagues/771.png	2024-09-26 00:00:00	2024-10-05 00:00:00
325	2024	190	t	League	https://media.api-sports.io/football/leagues/190.png	2024-11-01 00:00:00	2025-04-20 00:00:00
326	2024	512	t	League	https://media.api-sports.io/football/leagues/512.png	2024-09-21 00:00:00	2025-04-05 00:00:00
327	2024	513	t	League	https://media.api-sports.io/football/leagues/513.png	2024-09-22 00:00:00	2025-04-06 00:00:00
328	2024	1038	t	Cup	https://media.api-sports.io/football/leagues/1038.png	2024-10-11 00:00:00	2024-10-14 00:00:00
329	2024	321	t	Cup	https://media.api-sports.io/football/leagues/321.png	2024-09-25 00:00:00	2025-01-29 00:00:00
330	2024	735	t	Cup	https://media.api-sports.io/football/leagues/735.png	2024-09-25 00:00:00	2024-11-13 00:00:00
331	2024	415	t	League	https://media.api-sports.io/football/leagues/415.png	2024-09-21 00:00:00	2025-06-08 00:00:00
332	2024	955	t	League	https://media.api-sports.io/football/leagues/955.png	2024-09-28 00:00:00	2024-11-24 00:00:00
333	2024	143	t	Cup	https://media.api-sports.io/football/leagues/143.png	2024-10-09 00:00:00	2025-04-25 00:00:00
334	2024	1148	t	League	https://media.api-sports.io/football/leagues/1148.png	2024-09-14 00:00:00	2024-11-24 00:00:00
335	2024	757	t	Cup	https://media.api-sports.io/football/leagues/757.png	2024-10-26 00:00:00	2025-05-03 00:00:00
336	2024	949	t	Cup	https://media.api-sports.io/football/leagues/949.png	2024-10-03 00:00:00	2024-10-19 00:00:00
337	2024	201	t	League	https://media.api-sports.io/football/leagues/201.png	2024-09-28 00:00:00	2025-03-16 00:00:00
338	2024	515	t	League	https://media.api-sports.io/football/leagues/515.png	2024-09-19 00:00:00	2025-05-31 00:00:00
339	2024	542	t	League	https://media.api-sports.io/football/leagues/542.png	2024-09-20 00:00:00	2025-04-04 00:00:00
340	2024	962	t	League	https://media.api-sports.io/football/leagues/962.png	2024-09-21 00:00:00	2025-03-02 00:00:00
341	2024	403	t	League	https://media.api-sports.io/football/leagues/403.png	2024-10-19 00:00:00	2025-03-17 00:00:00
342	2024	828	t	League	https://media.api-sports.io/football/leagues/828.png	2024-10-16 00:00:00	2025-03-16 00:00:00
343	2024	707	t	Cup	https://media.api-sports.io/football/leagues/707.png	2024-09-25 00:00:00	2025-04-23 00:00:00
344	2024	1149	t	League	https://media.api-sports.io/football/leagues/1149.png	2024-09-21 00:00:00	2024-11-24 00:00:00
345	2024	1150	t	League	https://media.api-sports.io/football/leagues/1150.png	2024-09-21 00:00:00	2024-12-08 00:00:00
346	2024	1151	t	League	https://media.api-sports.io/football/leagues/1151.png	2024-09-21 00:00:00	2024-11-02 00:00:00
347	2024	1152	t	League	https://media.api-sports.io/football/leagues/1152.png	2024-08-31 00:00:00	2025-05-31 00:00:00
348	2024	1153	t	Cup	https://media.api-sports.io/football/leagues/1153.png	2024-09-21 00:00:00	2024-09-29 00:00:00
349	2024	1154	t	League	https://media.api-sports.io/football/leagues/1154.png	2024-09-15 00:00:00	2024-11-03 00:00:00
350	2024	741	t	Cup	https://media.api-sports.io/football/leagues/741.png	2024-09-25 00:00:00	2024-11-24 00:00:00
351	2024	421	t	League	https://media.api-sports.io/football/leagues/421.png	2024-09-28 00:00:00	2025-05-11 00:00:00
352	2024	414	t	League	https://media.api-sports.io/football/leagues/414.png	2024-09-28 00:00:00	2025-04-06 00:00:00
353	2024	698	t	Cup	https://media.api-sports.io/football/leagues/698.png	2024-10-13 00:00:00	2025-04-13 00:00:00
354	2024	1155	t	League	https://media.api-sports.io/football/leagues/1155.png	2024-09-29 00:00:00	2024-12-08 00:00:00
355	2024	887	t	League	https://media.api-sports.io/football/leagues/887.png	2024-10-07 00:00:00	2025-05-27 00:00:00
356	2024	423	t	League	https://media.api-sports.io/football/leagues/423.png	2024-10-04 00:00:00	2025-05-23 00:00:00
357	2024	420	t	Cup	https://media.api-sports.io/football/leagues/420.png	2024-10-28 00:00:00	2025-04-23 00:00:00
358	2024	760	t	League	https://media.api-sports.io/football/leagues/760.png	2024-10-16 00:00:00	2025-03-30 00:00:00
359	2024	1156	t	Cup	https://media.api-sports.io/football/leagues/1156.png	2024-10-01 00:00:00	2025-04-01 00:00:00
360	2024	547	t	Cup	https://media.api-sports.io/football/leagues/547.png	2025-01-02 00:00:00	2025-01-06 00:00:00
361	2024	1157	t	League	https://media.api-sports.io/football/leagues/1157.png	2024-10-09 00:00:00	2025-02-08 00:00:00
362	2024	1158	t	Cup	https://media.api-sports.io/football/leagues/1158.png	2024-08-22 00:00:00	2024-11-24 00:00:00
363	2024	1159	t	Cup	https://media.api-sports.io/football/leagues/1159.png	2024-10-06 00:00:00	2024-10-20 00:00:00
364	2024	726	t	Cup	https://media.api-sports.io/football/leagues/726.png	2024-10-22 00:00:00	2025-02-20 00:00:00
365	2024	968	t	League	https://media.api-sports.io/football/leagues/968.png	2024-11-23 00:00:00	2025-04-15 00:00:00
366	2024	503	t	Cup	https://media.api-sports.io/football/leagues/503.png	2024-10-12 00:00:00	2024-12-22 00:00:00
367	2024	1160	t	Cup	https://media.api-sports.io/football/leagues/1160.png	2024-10-12 00:00:00	2025-04-16 00:00:00
368	2024	508	t	Cup	https://media.api-sports.io/football/leagues/508.png	2024-10-18 00:00:00	2024-11-23 00:00:00
369	2024	1048	t	League	https://media.api-sports.io/football/leagues/1048.png	2024-10-19 00:00:00	2025-03-30 00:00:00
370	2024	314	t	Cup	https://media.api-sports.io/football/leagues/314.png	2024-10-29 00:00:00	2025-04-16 00:00:00
371	2024	233	t	League	https://media.api-sports.io/football/leagues/233.png	2024-10-30 00:00:00	2025-06-01 00:00:00
372	2024	1161	t	Cup	https://media.api-sports.io/football/leagues/1161.png	2024-10-19 00:00:00	2024-10-27 00:00:00
373	2024	1162	t	Cup	https://media.api-sports.io/football/leagues/1162.png	2024-10-22 00:00:00	2025-04-15 00:00:00
374	2024	1053	t	League	https://media.api-sports.io/football/leagues/1053.png	2024-10-26 00:00:00	2024-11-10 00:00:00
375	2024	324	t	League	https://media.api-sports.io/football/leagues/324.png	2024-11-22 00:00:00	2025-04-04 00:00:00
376	2024	1054	t	League	https://media.api-sports.io/football/leagues/1054.png	2024-11-03 00:00:00	2024-11-30 00:00:00
377	2024	1163	t	Cup	https://media.api-sports.io/football/leagues/1163.png	2024-10-25 00:00:00	2025-05-09 00:00:00
378	2024	723	t	Cup	https://media.api-sports.io/football/leagues/723.png	2024-11-05 00:00:00	2024-11-27 00:00:00
379	2024	66	t	Cup	https://media.api-sports.io/football/leagues/66.png	2024-11-15 00:00:00	2025-05-23 00:00:00
380	2024	495	t	Cup	https://media.api-sports.io/football/leagues/495.png	2024-11-21 00:00:00	2025-04-25 00:00:00
381	2024	25	t	Cup	https://media.api-sports.io/football/leagues/25.png	2024-12-21 00:00:00	2025-01-04 00:00:00
382	2024	499	t	Cup	https://media.api-sports.io/football/leagues/499.png	2024-11-20 00:00:00	2025-04-26 00:00:00
383	2024	598	t	League	https://media.api-sports.io/football/leagues/598.png	2024-11-23 00:00:00	2025-03-27 00:00:00
384	2024	325	t	Cup	https://media.api-sports.io/football/leagues/325.png	2024-11-15 00:00:00	2024-12-31 00:00:00
385	2024	1164	t	Cup	https://media.api-sports.io/football/leagues/1164.png	2024-11-09 00:00:00	2024-11-23 00:00:00
386	2024	1165	t	Cup	https://media.api-sports.io/football/leagues/1165.png	2024-11-03 00:00:00	2024-12-07 00:00:00
387	2024	966	t	Cup	https://media.api-sports.io/football/leagues/966.png	2024-11-29 00:00:00	2025-05-11 00:00:00
388	2024	821	t	Cup	https://media.api-sports.io/football/leagues/821.png	2024-12-07 00:00:00	2025-05-10 00:00:00
389	2024	763	t	League	https://media.api-sports.io/football/leagues/763.png	2024-11-30 00:00:00	2025-04-14 00:00:00
390	2024	1068	t	Cup	https://media.api-sports.io/football/leagues/1068.png	2024-11-29 00:00:00	2025-04-05 00:00:00
391	2024	846	t	League	https://media.api-sports.io/football/leagues/846.png	2024-12-06 00:00:00	2025-05-28 00:00:00
392	2024	1055	t	League	https://media.api-sports.io/football/leagues/1055.png	2024-11-16 00:00:00	2024-11-23 00:00:00
393	2024	1121	t	League	https://media.api-sports.io/football/leagues/1121.png	2024-11-20 00:00:00	2024-11-24 00:00:00
394	2024	811	t	Cup	https://media.api-sports.io/football/leagues/811.png	2024-12-03 00:00:00	2025-04-15 00:00:00
395	2024	507	t	Cup	https://media.api-sports.io/football/leagues/507.png	2024-12-03 00:00:00	2025-03-28 00:00:00
396	2024	655	t	Cup	https://media.api-sports.io/football/leagues/655.png	2025-01-11 00:00:00	2025-04-17 00:00:00
397	2024	845	t	League	https://media.api-sports.io/football/leagues/845.png	2024-11-29 00:00:00	2025-06-25 00:00:00
398	2024	895	t	Cup	https://media.api-sports.io/football/leagues/895.png	2024-12-10 00:00:00	2025-04-23 00:00:00
399	2024	665	t	Cup	https://media.api-sports.io/football/leagues/665.png	2024-12-03 00:00:00	2025-04-22 00:00:00
400	2024	1084	t	League	https://media.api-sports.io/football/leagues/1084.png	2024-12-15 00:00:00	2025-06-01 00:00:00
401	2024	584	t	League	https://media.api-sports.io/football/leagues/584.png	2024-12-11 00:00:00	2025-04-11 00:00:00
402	2024	378	t	League	https://media.api-sports.io/football/leagues/378.png	2025-01-09 00:00:00	2025-03-28 00:00:00
403	2024	714	t	Cup	https://media.api-sports.io/football/leagues/714.png	2024-12-15 00:00:00	2025-03-28 00:00:00
404	2024	32	t	Cup	https://media.api-sports.io/football/leagues/32.png	2025-03-21 00:00:00	2025-11-18 00:00:00
405	2024	514	t	Cup	https://media.api-sports.io/football/leagues/514.png	2024-12-30 00:00:00	2025-04-15 00:00:00
406	2024	1170	t	Cup	https://media.api-sports.io/football/leagues/1170.png	2024-05-20 00:00:00	2025-04-14 00:00:00
407	2024	959	t	Cup	https://media.api-sports.io/football/leagues/959.png	2025-02-01 00:00:00	2025-05-06 00:00:00
408	2024	838	t	Cup	https://media.api-sports.io/football/leagues/838.png	2025-02-02 00:00:00	2025-02-06 00:00:00
409	2024	719	t	Cup	https://media.api-sports.io/football/leagues/719.png	2025-01-24 00:00:00	2025-01-28 00:00:00
410	2024	568	t	League	https://media.api-sports.io/football/leagues/568.png	2025-01-31 00:00:00	2025-06-15 00:00:00
411	2024	511	t	Cup	https://media.api-sports.io/football/leagues/511.png	2025-01-18 00:00:00	2025-04-05 00:00:00
412	2024	1049	t	Cup	https://media.api-sports.io/football/leagues/1049.png	2025-01-24 00:00:00	2025-04-09 00:00:00
413	2024	422	t	League	https://media.api-sports.io/football/leagues/422.png	2025-01-19 00:00:00	2025-05-19 00:00:00
414	2024	1171	t	Cup	https://media.api-sports.io/football/leagues/1171.png	2024-08-25 00:00:00	2025-05-17 00:00:00
415	2024	844	t	League	https://media.api-sports.io/football/leagues/844.png	2025-01-17 00:00:00	2025-04-05 00:00:00
416	2024	822	t	Cup	https://media.api-sports.io/football/leagues/822.png	2025-02-26 00:00:00	2025-04-04 00:00:00
417	2024	1173	t	Cup	https://media.api-sports.io/football/leagues/1173.png	2025-02-25 00:00:00	2025-04-18 00:00:00
418	2024	1174	t	Cup	https://media.api-sports.io/football/leagues/1174.png	2025-01-15 00:00:00	2025-04-02 00:00:00
419	2024	1064	t	League	https://media.api-sports.io/football/leagues/1064.png	2025-03-01 00:00:00	2025-06-15 00:00:00
420	2024	1061	t	League	https://media.api-sports.io/football/leagues/1061.png	2025-03-02 00:00:00	2025-06-14 00:00:00
421	2024	820	t	Cup	https://media.api-sports.io/football/leagues/820.png	2025-03-06 00:00:00	2025-04-23 00:00:00
422	2024	1022	t	League	https://media.api-sports.io/football/leagues/1022.png	2025-07-26 00:00:00	2025-08-03 00:00:00
423	2024	882	t	Cup	https://media.api-sports.io/football/leagues/882.png	2023-04-01 00:00:00	2024-02-28 00:00:00
424	2024	1001	f	Cup	https://media.api-sports.io/football/leagues/1001.png	2023-05-25 00:00:00	2023-06-04 00:00:00
425	2024	952	t	Cup	https://media.api-sports.io/football/leagues/952.png	2023-09-06 00:00:00	2023-09-12 00:00:00
426	2024	886	f	Cup	https://media.api-sports.io/football/leagues/886.png	2023-09-27 00:00:00	2024-03-26 00:00:00
427	2024	893	f	Cup	https://media.api-sports.io/football/leagues/893.png	2023-10-11 00:00:00	2024-03-26 00:00:00
428	2024	504	f	Cup	https://media.api-sports.io/football/leagues/504.png	2023-09-24 00:00:00	2024-05-31 00:00:00
429	2024	565	f	League	https://media.api-sports.io/football/leagues/565.png	2023-07-28 00:00:00	2024-05-20 00:00:00
430	2024	764	f	League	https://media.api-sports.io/football/leagues/764.png	2023-08-05 00:00:00	2024-06-30 00:00:00
431	2024	411	f	League	https://media.api-sports.io/football/leagues/411.png	2023-09-27 00:00:00	2024-04-21 00:00:00
432	2024	340	f	League	https://media.api-sports.io/football/leagues/340.png	2023-10-20 00:00:00	2024-07-06 00:00:00
433	2024	637	f	League	https://media.api-sports.io/football/leagues/637.png	2023-10-21 00:00:00	2024-06-29 00:00:00
434	2024	341	f	Cup	https://media.api-sports.io/football/leagues/341.png	2023-11-24 00:00:00	2024-07-07 00:00:00
435	2024	399	f	League	https://media.api-sports.io/football/leagues/399.png	2023-09-17 00:00:00	2024-06-09 00:00:00
436	2024	912	f	Cup	https://media.api-sports.io/football/leagues/912.png	2024-02-01 00:00:00	2024-02-11 00:00:00
437	2024	813	f	League	https://media.api-sports.io/football/leagues/813.png	2023-10-11 00:00:00	2024-04-07 00:00:00
438	2024	544	f	Cup	https://media.api-sports.io/football/leagues/544.png	2023-10-14 00:00:00	2024-06-01 00:00:00
439	2024	1046	t	Cup	https://media.api-sports.io/football/leagues/1046.png	2023-09-20 00:00:00	2024-02-17 00:00:00
440	2024	1047	t	Cup	https://media.api-sports.io/football/leagues/1047.png	2023-07-10 00:00:00	2024-04-09 00:00:00
441	2024	612	f	Cup	https://media.api-sports.io/football/leagues/612.png	2024-01-06 00:00:00	2024-06-09 00:00:00
442	2024	609	f	League	https://media.api-sports.io/football/leagues/609.png	2024-01-20 00:00:00	2024-04-06 00:00:00
443	2024	489	f	League	https://media.api-sports.io/football/leagues/489.png	2024-03-10 00:00:00	2024-11-17 00:00:00
444	2024	591	f	League	https://media.api-sports.io/football/leagues/591.png	2023-11-24 00:00:00	2024-05-21 00:00:00
445	2024	621	f	League	https://media.api-sports.io/football/leagues/621.png	2024-01-13 00:00:00	2024-04-06 00:00:00
446	2024	814	f	Cup	https://media.api-sports.io/football/leagues/814.png	2024-01-06 00:00:00	2024-02-01 00:00:00
447	2024	606	f	League	https://media.api-sports.io/football/leagues/606.png	2024-01-17 00:00:00	2024-04-06 00:00:00
448	2024	539	f	Cup	https://media.api-sports.io/football/leagues/539.png	2023-12-25 00:00:00	2023-12-28 00:00:00
449	2024	194	f	League	https://media.api-sports.io/football/leagues/194.png	2024-02-23 00:00:00	2024-09-06 00:00:00
450	2024	834	f	League	https://media.api-sports.io/football/leagues/834.png	2024-02-24 00:00:00	2024-09-07 00:00:00
451	2024	532	t	Cup	https://media.api-sports.io/football/leagues/532.png	2024-04-15 00:00:00	2024-05-03 00:00:00
452	2024	624	f	League	https://media.api-sports.io/football/leagues/624.png	2024-01-17 00:00:00	2024-04-07 00:00:00
453	2024	628	f	League	https://media.api-sports.io/football/leagues/628.png	2024-01-17 00:00:00	2024-04-07 00:00:00
454	2024	195	f	League	https://media.api-sports.io/football/leagues/195.png	2024-02-08 00:00:00	2024-09-07 00:00:00
455	2024	608	f	League	https://media.api-sports.io/football/leagues/608.png	2024-01-13 00:00:00	2024-06-05 00:00:00
456	2024	602	f	League	https://media.api-sports.io/football/leagues/602.png	2024-01-14 00:00:00	2024-04-07 00:00:00
457	2024	477	f	League	https://media.api-sports.io/football/leagues/477.png	2024-01-20 00:00:00	2024-04-06 00:00:00
458	2024	4	t	Cup	https://media.api-sports.io/football/leagues/4.png	2024-06-14 00:00:00	2024-07-14 00:00:00
459	2024	541	f	Cup	https://media.api-sports.io/football/leagues/541.png	2024-02-21 00:00:00	2024-02-28 00:00:00
460	2024	604	f	League	https://media.api-sports.io/football/leagues/604.png	2024-01-20 00:00:00	2024-04-06 00:00:00
461	2024	610	f	League	https://media.api-sports.io/football/leagues/610.png	2024-01-13 00:00:00	2024-04-07 00:00:00
462	2024	168	f	Cup	https://media.api-sports.io/football/leagues/168.png	2024-01-13 00:00:00	2024-03-27 00:00:00
463	2024	626	f	League	https://media.api-sports.io/football/leagues/626.png	2024-01-13 00:00:00	2024-04-13 00:00:00
464	2024	476	f	League	https://media.api-sports.io/football/leagues/476.png	2024-01-17 00:00:00	2024-04-14 00:00:00
465	2024	611	f	League	https://media.api-sports.io/football/leagues/611.png	2024-01-18 00:00:00	2024-04-13 00:00:00
466	2024	252	f	League	https://media.api-sports.io/football/leagues/252.png	2024-07-19 00:00:00	2024-12-14 00:00:00
467	2024	250	f	League	https://media.api-sports.io/football/leagues/250.png	2024-01-19 00:00:00	2024-06-02 00:00:00
468	2024	603	f	League	https://media.api-sports.io/football/leagues/603.png	2024-01-16 00:00:00	2024-04-13 00:00:00
469	2024	620	f	League	https://media.api-sports.io/football/leagues/620.png	2024-02-17 00:00:00	2024-04-27 00:00:00
470	2024	9	t	Cup	https://media.api-sports.io/football/leagues/9.png	2024-06-21 00:00:00	2024-07-15 00:00:00
471	2024	77	f	Cup	https://media.api-sports.io/football/leagues/77.png	2024-01-20 00:00:00	2024-04-06 00:00:00
472	2024	475	f	League	https://media.api-sports.io/football/leagues/475.png	2024-01-20 00:00:00	2024-04-07 00:00:00
473	2024	836	f	League	https://media.api-sports.io/football/leagues/836.png	2024-02-09 00:00:00	2024-08-17 00:00:00
474	2024	630	f	League	https://media.api-sports.io/football/leagues/630.png	2024-01-20 00:00:00	2024-04-06 00:00:00
475	2024	616	f	League	https://media.api-sports.io/football/leagues/616.png	2024-01-10 00:00:00	2024-04-10 00:00:00
476	2024	900	t	Cup	https://media.api-sports.io/football/leagues/900.png	2024-01-10 00:00:00	2024-01-15 00:00:00
477	2024	522	f	League	https://media.api-sports.io/football/leagues/522.png	2024-01-19 00:00:00	2024-04-14 00:00:00
478	2024	631	f	League	https://media.api-sports.io/football/leagues/631.png	2024-01-27 00:00:00	2024-04-06 00:00:00
479	2024	623	f	League	https://media.api-sports.io/football/leagues/623.png	2024-01-21 00:00:00	2024-04-21 00:00:00
480	2024	622	f	League	https://media.api-sports.io/football/leagues/622.png	2024-01-10 00:00:00	2024-04-06 00:00:00
481	2024	629	f	League	https://media.api-sports.io/football/leagues/629.png	2024-01-24 00:00:00	2024-04-07 00:00:00
482	2024	901	f	Cup	https://media.api-sports.io/football/leagues/901.png	2024-01-27 00:00:00	2024-04-06 00:00:00
483	2024	618	f	Cup	https://media.api-sports.io/football/leagues/618.png	2024-01-02 00:00:00	2024-01-25 00:00:00
484	2024	605	f	League	https://media.api-sports.io/football/leagues/605.png	2024-01-24 00:00:00	2024-04-27 00:00:00
485	2024	481	f	League	https://media.api-sports.io/football/leagues/481.png	2024-02-24 00:00:00	2024-09-14 00:00:00
486	2024	521	f	League	https://media.api-sports.io/football/leagues/521.png	2024-02-04 00:00:00	2024-07-24 00:00:00
487	2024	16	f	Cup	https://media.api-sports.io/football/leagues/16.png	2024-02-07 00:00:00	2024-06-02 00:00:00
488	2024	192	f	League	https://media.api-sports.io/football/leagues/192.png	2024-02-16 00:00:00	2024-09-07 00:00:00
489	2024	835	f	League	https://media.api-sports.io/football/leagues/835.png	2024-02-16 00:00:00	2024-08-25 00:00:00
490	2024	13	f	Cup	https://media.api-sports.io/football/leagues/13.png	2024-02-07 00:00:00	2024-11-30 00:00:00
491	2024	358	f	League	https://media.api-sports.io/football/leagues/358.png	2024-02-16 00:00:00	2024-11-02 00:00:00
492	2024	255	f	League	https://media.api-sports.io/football/leagues/255.png	2024-03-09 00:00:00	2024-11-23 00:00:00
493	2024	11	f	Cup	https://media.api-sports.io/football/leagues/11.png	2024-03-05 00:00:00	2024-11-23 00:00:00
494	2024	398	f	League	https://media.api-sports.io/football/leagues/398.png	2023-12-22 00:00:00	2024-05-29 00:00:00
495	2024	253	f	League	https://media.api-sports.io/football/leagues/253.png	2024-02-22 00:00:00	2024-12-07 00:00:00
496	2024	545	t	Cup	https://media.api-sports.io/football/leagues/545.png	2024-01-08 00:00:00	2024-01-22 00:00:00
497	2024	130	f	Cup	https://media.api-sports.io/football/leagues/130.png	2024-01-25 00:00:00	2024-12-04 00:00:00
498	2024	615	f	League	https://media.api-sports.io/football/leagues/615.png	2024-02-24 00:00:00	2024-06-08 00:00:00
499	2024	725	f	League	https://media.api-sports.io/football/leagues/725.png	2024-03-16 00:00:00	2024-11-16 00:00:00
500	2024	104	f	League	https://media.api-sports.io/football/leagues/104.png	2024-04-01 00:00:00	2024-12-01 00:00:00
501	2024	164	f	League	https://media.api-sports.io/football/leagues/164.png	2024-04-06 00:00:00	2024-10-27 00:00:00
502	2024	671	f	League	https://media.api-sports.io/football/leagues/671.png	2024-04-21 00:00:00	2024-10-05 00:00:00
503	2024	915	f	League	https://media.api-sports.io/football/leagues/915.png	2024-03-16 00:00:00	2024-11-23 00:00:00
504	2024	736	f	League	https://media.api-sports.io/football/leagues/736.png	2024-04-13 00:00:00	2024-11-10 00:00:00
505	2024	165	f	League	https://media.api-sports.io/football/leagues/165.png	2024-05-01 00:00:00	2024-09-28 00:00:00
506	2024	166	f	League	https://media.api-sports.io/football/leagues/166.png	2024-05-04 00:00:00	2024-09-14 00:00:00
507	2024	899	f	Cup	https://media.api-sports.io/football/leagues/899.png	2024-01-26 00:00:00	2024-03-30 00:00:00
508	2024	239	f	League	https://media.api-sports.io/football/leagues/239.png	2024-01-19 00:00:00	2024-12-22 00:00:00
509	2024	240	f	League	https://media.api-sports.io/football/leagues/240.png	2024-02-02 00:00:00	2024-12-15 00:00:00
510	2024	98	f	League	https://media.api-sports.io/football/leagues/98.png	2024-02-23 00:00:00	2024-12-08 00:00:00
511	2024	99	f	League	https://media.api-sports.io/football/leagues/99.png	2024-02-24 00:00:00	2024-12-07 00:00:00
512	2024	100	f	League	https://media.api-sports.io/football/leagues/100.png	2024-02-24 00:00:00	2024-12-07 00:00:00
513	2024	189	f	League	https://media.api-sports.io/football/leagues/189.png	2024-04-05 00:00:00	2024-09-21 00:00:00
514	2024	779	f	League	https://media.api-sports.io/football/leagues/779.png	2024-04-06 00:00:00	2024-10-27 00:00:00
515	2024	778	f	League	https://media.api-sports.io/football/leagues/778.png	2024-04-06 00:00:00	2024-10-26 00:00:00
516	2024	777	f	League	https://media.api-sports.io/football/leagues/777.png	2024-04-06 00:00:00	2024-10-26 00:00:00
517	2024	776	f	League	https://media.api-sports.io/football/leagues/776.png	2024-04-06 00:00:00	2024-10-27 00:00:00
518	2024	775	f	League	https://media.api-sports.io/football/leagues/775.png	2024-04-06 00:00:00	2024-10-26 00:00:00
519	2024	774	f	League	https://media.api-sports.io/football/leagues/774.png	2024-04-06 00:00:00	2024-10-27 00:00:00
520	2024	627	f	League	https://media.api-sports.io/football/leagues/627.png	2024-01-20 00:00:00	2024-04-14 00:00:00
521	2024	666	f	Cup	https://media.api-sports.io/football/leagues/666.png	2024-02-06 00:00:00	2024-12-30 00:00:00
522	2024	10	f	Cup	https://media.api-sports.io/football/leagues/10.png	2024-01-01 00:00:00	2024-12-21 00:00:00
523	2024	1051	t	Cup	https://media.api-sports.io/football/leagues/1051.png	2023-12-28 00:00:00	2024-01-01 00:00:00
524	2024	129	f	League	https://media.api-sports.io/football/leagues/129.png	2024-02-02 00:00:00	2024-12-07 00:00:00
525	2024	131	f	League	https://media.api-sports.io/football/leagues/131.png	2024-02-02 00:00:00	2024-12-21 00:00:00
526	2024	132	f	League	https://media.api-sports.io/football/leagues/132.png	2024-02-02 00:00:00	2024-12-14 00:00:00
527	2024	520	f	League	https://media.api-sports.io/football/leagues/520.png	2024-02-17 00:00:00	2024-04-26 00:00:00
528	2024	667	f	Cup	https://media.api-sports.io/football/leagues/667.png	2024-01-04 00:00:00	2024-12-30 00:00:00
529	2024	720	f	Cup	https://media.api-sports.io/football/leagues/720.png	2024-01-26 00:00:00	2024-05-21 00:00:00
530	2024	281	f	League	https://media.api-sports.io/football/leagues/281.png	2024-01-26 00:00:00	2024-10-30 00:00:00
531	2024	843	f	Cup	https://media.api-sports.io/football/leagues/843.png	2024-02-22 00:00:00	2024-05-11 00:00:00
532	2024	299	f	League	https://media.api-sports.io/football/leagues/299.png	2024-02-02 00:00:00	2024-12-08 00:00:00
533	2024	1032	t	League	https://media.api-sports.io/football/leagues/1032.png	2024-01-25 00:00:00	2024-05-05 00:00:00
534	2024	128	f	League	https://media.api-sports.io/football/leagues/128.png	2024-05-12 00:00:00	2024-12-15 00:00:00
535	2024	713	f	Cup	https://media.api-sports.io/football/leagues/713.png	2024-01-19 00:00:00	2024-01-25 00:00:00
536	2024	717	f	League	https://media.api-sports.io/football/leagues/717.png	2024-01-20 00:00:00	2024-04-21 00:00:00
537	2024	823	f	Cup	https://media.api-sports.io/football/leagues/823.png	2024-01-27 00:00:00	2024-10-30 00:00:00
538	2024	837	f	Cup	https://media.api-sports.io/football/leagues/837.png	2024-01-30 00:00:00	2024-04-17 00:00:00
539	2024	1057	t	Cup	https://media.api-sports.io/football/leagues/1057.png	2024-02-21 00:00:00	2024-03-11 00:00:00
540	2024	497	f	League	https://media.api-sports.io/football/leagues/497.png	2024-03-10 00:00:00	2024-11-24 00:00:00
541	2024	304	f	League	https://media.api-sports.io/football/leagues/304.png	2024-01-20 00:00:00	2024-11-30 00:00:00
542	2024	833	f	League	https://media.api-sports.io/football/leagues/833.png	2024-02-23 00:00:00	2024-09-07 00:00:00
543	2024	903	f	Cup	https://media.api-sports.io/football/leagues/903.png	2024-01-30 00:00:00	2024-02-09 00:00:00
544	2024	27	f	Cup	https://media.api-sports.io/football/leagues/27.png	2024-02-08 00:00:00	2024-05-25 00:00:00
545	2024	265	f	League	https://media.api-sports.io/football/leagues/265.png	2024-02-18 00:00:00	2024-11-10 00:00:00
546	2024	482	f	League	https://media.api-sports.io/football/leagues/482.png	2024-02-23 00:00:00	2024-09-07 00:00:00
547	2024	191	f	League	https://media.api-sports.io/football/leagues/191.png	2024-03-01 00:00:00	2024-09-14 00:00:00
548	2024	648	f	League	https://media.api-sports.io/football/leagues/648.png	2024-03-15 00:00:00	2024-09-07 00:00:00
549	2024	904	f	Cup	https://media.api-sports.io/football/leagues/904.png	2024-04-06 00:00:00	2024-04-09 00:00:00
550	2024	479	f	League	https://media.api-sports.io/football/leagues/479.png	2024-04-13 00:00:00	2024-11-09 00:00:00
551	2024	1060	t	Cup	https://media.api-sports.io/football/leagues/1060.png	2024-01-20 00:00:00	2024-02-11 00:00:00
552	2024	344	f	League	https://media.api-sports.io/football/leagues/344.png	2024-02-17 00:00:00	2024-12-23 00:00:00
553	2024	293	f	League	https://media.api-sports.io/football/leagues/293.png	2024-03-01 00:00:00	2024-11-24 00:00:00
554	2024	292	f	League	https://media.api-sports.io/football/leagues/292.png	2024-03-01 00:00:00	2024-11-24 00:00:00
555	2024	327	f	League	https://media.api-sports.io/football/leagues/327.png	2024-03-01 00:00:00	2024-12-16 00:00:00
556	2024	329	f	League	https://media.api-sports.io/football/leagues/329.png	2024-03-01 00:00:00	2024-11-30 00:00:00
557	2024	328	f	League	https://media.api-sports.io/football/leagues/328.png	2024-03-02 00:00:00	2024-11-24 00:00:00
558	2024	101	f	Cup	https://media.api-sports.io/football/leagues/101.png	2024-03-06 00:00:00	2024-11-02 00:00:00
559	2024	326	f	League	https://media.api-sports.io/football/leagues/326.png	2024-03-05 00:00:00	2024-12-16 00:00:00
560	2024	114	f	League	https://media.api-sports.io/football/leagues/114.png	2024-03-30 00:00:00	2024-11-24 00:00:00
561	2024	113	f	League	https://media.api-sports.io/football/leagues/113.png	2024-03-30 00:00:00	2024-11-24 00:00:00
562	2024	103	f	League	https://media.api-sports.io/football/leagues/103.png	2024-03-31 00:00:00	2024-12-08 00:00:00
563	2024	244	f	League	https://media.api-sports.io/football/leagues/244.png	2024-04-06 00:00:00	2024-11-02 00:00:00
564	2024	549	f	League	https://media.api-sports.io/football/leagues/549.png	2024-04-13 00:00:00	2024-11-23 00:00:00
565	2024	597	f	League	https://media.api-sports.io/football/leagues/597.png	2024-03-29 00:00:00	2024-10-19 00:00:00
566	2024	593	f	League	https://media.api-sports.io/football/leagues/593.png	2024-03-31 00:00:00	2024-10-19 00:00:00
567	2024	596	f	League	https://media.api-sports.io/football/leagues/596.png	2024-03-28 00:00:00	2024-10-19 00:00:00
568	2024	594	f	League	https://media.api-sports.io/football/leagues/594.png	2024-03-31 00:00:00	2024-10-19 00:00:00
569	2024	592	f	League	https://media.api-sports.io/football/leagues/592.png	2024-03-31 00:00:00	2024-10-20 00:00:00
570	2024	595	f	League	https://media.api-sports.io/football/leagues/595.png	2024-03-31 00:00:00	2024-10-20 00:00:00
571	2024	357	f	League	https://media.api-sports.io/football/leagues/357.png	2024-02-16 00:00:00	2024-11-16 00:00:00
572	2024	242	f	League	https://media.api-sports.io/football/leagues/242.png	2024-03-02 00:00:00	2024-12-14 00:00:00
573	2024	906	f	League	https://media.api-sports.io/football/leagues/906.png	2024-02-06 00:00:00	2024-12-17 00:00:00
574	2024	712	f	League	https://media.api-sports.io/football/leagues/712.png	2024-02-16 00:00:00	2024-08-17 00:00:00
575	2024	367	f	League	https://media.api-sports.io/football/leagues/367.png	2024-03-09 00:00:00	2024-10-26 00:00:00
576	2024	640	f	League	https://media.api-sports.io/football/leagues/640.png	2024-04-12 00:00:00	2024-10-18 00:00:00
577	2024	254	f	League	https://media.api-sports.io/football/leagues/254.png	2024-03-16 00:00:00	2024-11-24 00:00:00
578	2024	266	f	League	https://media.api-sports.io/football/leagues/266.png	2024-02-24 00:00:00	2024-12-07 00:00:00
579	2024	245	t	League	https://media.api-sports.io/football/leagues/245.png	2024-04-12 00:00:00	2024-10-19 00:00:00
580	2024	1062	f	League	https://media.api-sports.io/football/leagues/1062.png	2024-01-27 00:00:00	2024-05-12 00:00:00
581	2024	376	f	League	https://media.api-sports.io/football/leagues/376.png	2024-02-18 00:00:00	2024-09-29 00:00:00
582	2024	167	f	Cup	https://media.api-sports.io/football/leagues/167.png	2024-04-01 00:00:00	2024-08-23 00:00:00
583	2024	73	f	Cup	https://media.api-sports.io/football/leagues/73.png	2024-02-20 00:00:00	2024-11-10 00:00:00
584	2024	1063	f	Cup	https://media.api-sports.io/football/leagues/1063.png	2024-01-31 00:00:00	2024-04-03 00:00:00
585	2024	907	f	League	https://media.api-sports.io/football/leagues/907.png	2024-02-03 00:00:00	2024-02-10 00:00:00
586	2024	241	t	Cup	https://media.api-sports.io/football/leagues/241.png	2024-03-05 00:00:00	2024-12-15 00:00:00
587	2024	238	f	League	https://media.api-sports.io/football/leagues/238.png	2024-03-08 00:00:00	2024-11-08 00:00:00
588	2024	759	t	League	https://media.api-sports.io/football/leagues/759.png	2024-03-08 00:00:00	2024-09-28 00:00:00
589	2024	806	t	Cup	https://media.api-sports.io/football/leagues/806.png	2024-03-20 00:00:00	2024-06-30 00:00:00
590	2024	268	f	League	https://media.api-sports.io/football/leagues/268.png	2024-02-16 00:00:00	2024-08-04 00:00:00
591	2024	246	f	Cup	https://media.api-sports.io/football/leagues/246.png	2024-02-10 00:00:00	2024-09-21 00:00:00
592	2024	711	f	League	https://media.api-sports.io/football/leagues/711.png	2024-03-02 00:00:00	2024-10-31 00:00:00
593	2024	910	f	Cup	https://media.api-sports.io/football/leagues/910.png	2024-02-12 00:00:00	2024-02-26 00:00:00
594	2024	5	t	Cup	https://media.api-sports.io/football/leagues/5.png	2024-09-05 00:00:00	2026-03-31 00:00:00
595	2024	169	f	League	https://media.api-sports.io/football/leagues/169.png	2024-03-01 00:00:00	2024-11-02 00:00:00
596	2024	366	f	League	https://media.api-sports.io/football/leagues/366.png	2024-03-09 00:00:00	2024-10-25 00:00:00
597	2024	969	f	League	https://media.api-sports.io/football/leagues/969.png	2024-02-22 00:00:00	2024-08-03 00:00:00
598	2024	849	t	Cup	https://media.api-sports.io/football/leagues/849.png	2024-06-08 00:00:00	2024-06-11 00:00:00
599	2024	909	f	League	https://media.api-sports.io/football/leagues/909.png	2024-03-16 00:00:00	2024-11-10 00:00:00
600	2024	401	f	League	https://media.api-sports.io/football/leagues/401.png	2024-03-09 00:00:00	2024-11-24 00:00:00
601	2024	540	f	Cup	https://media.api-sports.io/football/leagues/540.png	2024-03-02 00:00:00	2024-03-17 00:00:00
602	2024	249	f	League	https://media.api-sports.io/football/leagues/249.png	2024-04-12 00:00:00	2024-08-10 00:00:00
603	2024	247	f	League	https://media.api-sports.io/football/leagues/247.png	2024-04-11 00:00:00	2024-08-10 00:00:00
604	2024	248	f	League	https://media.api-sports.io/football/leagues/248.png	2024-04-05 00:00:00	2024-08-10 00:00:00
605	2024	389	f	League	https://media.api-sports.io/football/leagues/389.png	2024-03-01 00:00:00	2024-11-09 00:00:00
606	2024	1066	t	Cup	https://media.api-sports.io/football/leagues/1066.png	2024-02-23 00:00:00	2024-03-03 00:00:00
607	2024	294	f	Cup	https://media.api-sports.io/football/leagues/294.png	2024-03-09 00:00:00	2024-11-30 00:00:00
608	2024	1067	t	League	https://media.api-sports.io/football/leagues/1067.png	2024-02-23 00:00:00	2024-11-01 00:00:00
609	2024	256	t	League	https://media.api-sports.io/football/leagues/256.png	2024-05-05 00:00:00	2024-08-03 00:00:00
610	2024	171	f	Cup	https://media.api-sports.io/football/leagues/171.png	2024-03-15 00:00:00	2024-11-23 00:00:00
611	2024	259	f	Cup	https://media.api-sports.io/football/leagues/259.png	2024-04-24 00:00:00	2024-09-26 00:00:00
612	2024	562	t	League	https://media.api-sports.io/football/leagues/562.png	2024-03-16 00:00:00	2024-11-30 00:00:00
613	2024	251	f	League	https://media.api-sports.io/football/leagues/251.png	2024-04-05 00:00:00	2024-10-14 00:00:00
614	2024	660	f	League	https://media.api-sports.io/football/leagues/660.png	2024-03-16 00:00:00	2024-11-09 00:00:00
615	2024	369	f	League	https://media.api-sports.io/football/leagues/369.png	2024-03-01 00:00:00	2024-12-09 00:00:00
616	2024	361	f	League	https://media.api-sports.io/football/leagues/361.png	2024-03-07 00:00:00	2024-11-08 00:00:00
617	2024	365	f	League	https://media.api-sports.io/football/leagues/365.png	2024-03-08 00:00:00	2024-11-09 00:00:00
618	2024	116	f	League	https://media.api-sports.io/football/leagues/116.png	2024-03-15 00:00:00	2024-12-07 00:00:00
619	2024	74	f	League	https://media.api-sports.io/football/leagues/74.png	2024-03-14 00:00:00	2024-09-22 00:00:00
620	2024	607	f	League	https://media.api-sports.io/football/leagues/607.png	2024-03-15 00:00:00	2024-06-11 00:00:00
621	2024	362	f	League	https://media.api-sports.io/football/leagues/362.png	2024-03-01 00:00:00	2024-11-23 00:00:00
622	2024	295	f	League	https://media.api-sports.io/football/leagues/295.png	2024-03-02 00:00:00	2024-11-02 00:00:00
623	2024	196	f	League	https://media.api-sports.io/football/leagues/196.png	2024-03-16 00:00:00	2024-09-21 00:00:00
624	2024	1069	f	League	https://media.api-sports.io/football/leagues/1069.png	2024-03-01 00:00:00	2024-06-21 00:00:00
625	2024	636	f	League	https://media.api-sports.io/football/leagues/636.png	2024-03-03 00:00:00	2024-12-17 00:00:00
626	2024	71	f	League	https://media.api-sports.io/football/leagues/71.png	2024-04-13 00:00:00	2024-12-08 00:00:00
627	2024	1070	t	Cup	https://media.api-sports.io/football/leagues/1070.png	2024-03-03 00:00:00	2024-03-16 00:00:00
628	2024	170	f	League	https://media.api-sports.io/football/leagues/170.png	2024-03-09 00:00:00	2024-11-03 00:00:00
629	2024	243	f	League	https://media.api-sports.io/football/leagues/243.png	2024-03-13 00:00:00	2024-10-30 00:00:00
630	2024	957	f	League	https://media.api-sports.io/football/leagues/957.png	2024-03-28 00:00:00	2024-09-01 00:00:00
631	2024	954	f	League	https://media.api-sports.io/football/leagues/954.png	2024-03-29 00:00:00	2024-08-31 00:00:00
632	2024	956	f	League	https://media.api-sports.io/football/leagues/956.png	2024-03-22 00:00:00	2024-08-31 00:00:00
633	2024	826	f	Cup	https://media.api-sports.io/football/leagues/826.png	2024-04-08 00:00:00	2024-04-11 00:00:00
634	2024	649	f	League	https://media.api-sports.io/football/leagues/649.png	2024-03-09 00:00:00	2024-11-16 00:00:00
635	2024	257	f	Cup	https://media.api-sports.io/football/leagues/257.png	2024-03-18 00:00:00	2024-09-26 00:00:00
636	2024	523	t	League	https://media.api-sports.io/football/leagues/523.png	2024-03-23 00:00:00	2024-10-20 00:00:00
637	2024	1071	f	League	https://media.api-sports.io/football/leagues/1071.png	2024-03-02 00:00:00	2024-08-24 00:00:00
638	2024	269	f	League	https://media.api-sports.io/football/leagues/269.png	2024-03-16 00:00:00	2024-12-12 00:00:00
639	2024	619	f	League	https://media.api-sports.io/football/leagues/619.png	2024-05-04 00:00:00	2024-07-31 00:00:00
640	2024	936	t	League	https://media.api-sports.io/football/leagues/936.png	2024-05-25 00:00:00	2024-08-25 00:00:00
641	2024	571	f	League	https://media.api-sports.io/football/leagues/571.png	2024-04-06 00:00:00	2024-11-10 00:00:00
642	2024	72	f	League	https://media.api-sports.io/football/leagues/72.png	2024-04-19 00:00:00	2024-11-26 00:00:00
643	2024	498	f	Cup	https://media.api-sports.io/football/leagues/498.png	2024-03-11 00:00:00	2024-09-29 00:00:00
644	2024	379	f	League	https://media.api-sports.io/football/leagues/379.png	2024-03-09 00:00:00	2024-05-26 00:00:00
645	2024	75	f	League	https://media.api-sports.io/football/leagues/75.png	2024-04-20 00:00:00	2024-10-19 00:00:00
646	2024	134	f	League	https://media.api-sports.io/football/leagues/134.png	2024-03-22 00:00:00	2024-12-01 00:00:00
647	2024	300	f	League	https://media.api-sports.io/football/leagues/300.png	2024-03-16 00:00:00	2024-11-30 00:00:00
648	2024	1013	t	Cup	https://media.api-sports.io/football/leagues/1013.png	2024-03-23 00:00:00	2024-08-17 00:00:00
649	2024	851	t	League	https://media.api-sports.io/football/leagues/851.png	2024-05-18 00:00:00	2024-08-24 00:00:00
650	2024	364	f	League	https://media.api-sports.io/football/leagues/364.png	2024-04-06 00:00:00	2024-11-10 00:00:00
651	2024	193	f	League	https://media.api-sports.io/football/leagues/193.png	2024-03-22 00:00:00	2024-09-28 00:00:00
652	2024	117	f	League	https://media.api-sports.io/football/leagues/117.png	2024-04-05 00:00:00	2024-11-23 00:00:00
653	2024	1073	f	League	https://media.api-sports.io/football/leagues/1073.png	2024-03-16 00:00:00	2024-06-16 00:00:00
654	2024	76	f	League	https://media.api-sports.io/football/leagues/76.png	2024-04-27 00:00:00	2024-09-29 00:00:00
655	2024	772	f	Cup	https://media.api-sports.io/football/leagues/772.png	2024-07-27 00:00:00	2024-08-25 00:00:00
656	2024	929	f	League	https://media.api-sports.io/football/leagues/929.png	2024-03-23 00:00:00	2024-10-20 00:00:00
657	2024	478	t	League	https://media.api-sports.io/football/leagues/478.png	2024-04-13 00:00:00	2024-08-04 00:00:00
658	2024	1030	t	League	https://media.api-sports.io/football/leagues/1030.png	2024-04-28 00:00:00	2024-07-28 00:00:00
659	2024	614	f	League	https://media.api-sports.io/football/leagues/614.png	2024-05-04 00:00:00	2024-07-27 00:00:00
660	2024	1075	f	League	https://media.api-sports.io/football/leagues/1075.png	2024-03-12 00:00:00	2024-11-28 00:00:00
661	2024	282	f	League	https://media.api-sports.io/football/leagues/282.png	2024-04-02 00:00:00	2024-10-20 00:00:00
662	2024	480	t	Cup	https://media.api-sports.io/football/leagues/480.png	2024-07-24 00:00:00	2024-08-09 00:00:00
663	2024	524	t	Cup	https://media.api-sports.io/football/leagues/524.png	2024-07-25 00:00:00	2024-08-10 00:00:00
664	2024	651	f	League	https://media.api-sports.io/football/leagues/651.png	2024-03-23 00:00:00	2024-11-16 00:00:00
665	2024	652	f	League	https://media.api-sports.io/football/leagues/652.png	2024-04-07 00:00:00	2024-11-03 00:00:00
666	2024	650	f	League	https://media.api-sports.io/football/leagues/650.png	2024-04-07 00:00:00	2024-11-03 00:00:00
667	2024	653	f	League	https://media.api-sports.io/football/leagues/653.png	2024-04-13 00:00:00	2024-10-19 00:00:00
668	2024	1076	f	League	https://media.api-sports.io/football/leagues/1076.png	2024-03-22 00:00:00	2024-08-17 00:00:00
669	2024	1077	f	Cup	https://media.api-sports.io/football/leagues/1077.png	2024-03-20 00:00:00	2024-03-26 00:00:00
670	2024	1081	f	Cup	https://media.api-sports.io/football/leagues/1081.png	2024-03-13 00:00:00	2024-03-22 00:00:00
671	2024	569	f	League	https://media.api-sports.io/football/leagues/569.png	2024-03-28 00:00:00	2024-11-28 00:00:00
672	2024	765	f	League	https://media.api-sports.io/football/leagues/765.png	2024-04-06 00:00:00	2024-07-14 00:00:00
673	2024	1082	f	Cup	https://media.api-sports.io/football/leagues/1082.png	2024-03-02 00:00:00	2024-04-27 00:00:00
674	2024	589	t	League	https://media.api-sports.io/football/leagues/589.png	2024-04-14 00:00:00	2024-12-01 00:00:00
675	2024	740	f	Cup	https://media.api-sports.io/football/leagues/740.png	2024-04-03 00:00:00	2024-09-28 00:00:00
676	2024	802	f	Cup	https://media.api-sports.io/football/leagues/802.png	2024-04-01 00:00:00	2024-10-05 00:00:00
677	2024	563	f	League	https://media.api-sports.io/football/leagues/563.png	2024-03-29 00:00:00	2024-11-09 00:00:00
678	2024	564	f	League	https://media.api-sports.io/football/leagues/564.png	2024-03-29 00:00:00	2024-11-10 00:00:00
679	2024	473	f	League	https://media.api-sports.io/football/leagues/473.png	2024-04-06 00:00:00	2024-10-26 00:00:00
680	2024	474	f	League	https://media.api-sports.io/football/leagues/474.png	2024-04-06 00:00:00	2024-10-26 00:00:00
681	2024	388	t	League	https://media.api-sports.io/football/leagues/388.png	2024-04-04 00:00:00	2024-10-24 00:00:00
682	2024	105	f	Cup	https://media.api-sports.io/football/leagues/105.png	2024-04-09 00:00:00	2024-12-07 00:00:00
683	2024	923	f	League	https://media.api-sports.io/football/leagues/923.png	2024-04-27 00:00:00	2024-09-02 00:00:00
684	2024	391	f	League	https://media.api-sports.io/football/leagues/391.png	2024-04-06 00:00:00	2024-11-10 00:00:00
685	2024	260	t	League	https://media.api-sports.io/football/leagues/260.png	2024-05-04 00:00:00	2024-07-28 00:00:00
686	2024	491	f	Cup	https://media.api-sports.io/football/leagues/491.png	2024-04-24 00:00:00	2024-11-02 00:00:00
687	2024	890	t	Cup	https://media.api-sports.io/football/leagues/890.png	2024-09-05 00:00:00	2025-03-25 00:00:00
688	2024	921	f	Cup	https://media.api-sports.io/football/leagues/921.png	2024-05-20 00:00:00	2024-06-05 00:00:00
689	2024	118	t	League	https://media.api-sports.io/football/leagues/118.png	2024-04-27 00:00:00	2024-05-04 00:00:00
690	2024	278	t	League	https://media.api-sports.io/football/leagues/278.png	2024-05-10 00:00:00	2025-04-26 00:00:00
691	2024	661	f	Cup	https://media.api-sports.io/football/leagues/661.png	2024-04-19 00:00:00	2024-09-29 00:00:00
692	2024	1085	t	Cup	https://media.api-sports.io/football/leagues/1085.png	2024-04-11 00:00:00	2024-05-05 00:00:00
693	2024	1086	t	League	https://media.api-sports.io/football/leagues/1086.png	2024-04-12 00:00:00	2024-11-15 00:00:00
694	2024	1087	f	League	https://media.api-sports.io/football/leagues/1087.png	2024-04-13 00:00:00	2024-10-26 00:00:00
695	2024	1088	t	League	https://media.api-sports.io/football/leagues/1088.png	2024-04-13 00:00:00	2024-08-03 00:00:00
696	2024	1090	f	League	https://media.api-sports.io/football/leagues/1090.png	2024-02-23 00:00:00	2024-08-10 00:00:00
697	2024	1091	f	League	https://media.api-sports.io/football/leagues/1091.png	2024-03-16 00:00:00	2024-08-31 00:00:00
698	2024	1092	f	League	https://media.api-sports.io/football/leagues/1092.png	2024-04-06 00:00:00	2024-09-22 00:00:00
699	2024	1093	f	League	https://media.api-sports.io/football/leagues/1093.png	2024-03-15 00:00:00	2024-09-01 00:00:00
700	2024	1094	f	League	https://media.api-sports.io/football/leagues/1094.png	2024-03-23 00:00:00	2024-08-31 00:00:00
701	2024	368	t	League	https://media.api-sports.io/football/leagues/368.png	2024-05-10 00:00:00	2025-05-25 00:00:00
702	2024	359	t	Cup	https://media.api-sports.io/football/leagues/359.png	2024-05-17 00:00:00	2024-11-10 00:00:00
703	2024	914	t	Cup	https://media.api-sports.io/football/leagues/914.png	2024-06-03 00:00:00	2024-06-16 00:00:00
704	2024	493	t	Cup	https://media.api-sports.io/football/leagues/493.png	2024-07-15 00:00:00	2024-07-28 00:00:00
705	2024	658	t	Cup	https://media.api-sports.io/football/leagues/658.png	2024-05-04 00:00:00	2024-10-30 00:00:00
706	2024	267	f	Cup	https://media.api-sports.io/football/leagues/267.png	2024-04-27 00:00:00	2024-11-20 00:00:00
707	2024	1080	t	League	https://media.api-sports.io/football/leagues/1080.png	2024-05-04 00:00:00	2024-10-27 00:00:00
708	2024	824	t	Cup	https://media.api-sports.io/football/leagues/824.png	2024-04-26 00:00:00	2024-05-24 00:00:00
709	2024	1095	f	League	https://media.api-sports.io/football/leagues/1095.png	2024-04-27 00:00:00	2024-09-29 00:00:00
710	2024	1096	t	League	https://media.api-sports.io/football/leagues/1096.png	2024-04-27 00:00:00	2024-07-07 00:00:00
711	2024	1097	f	Cup	https://media.api-sports.io/football/leagues/1097.png	2024-04-27 00:00:00	2024-08-24 00:00:00
712	2024	1098	f	League	https://media.api-sports.io/football/leagues/1098.png	2024-04-20 00:00:00	2024-09-15 00:00:00
713	2024	613	f	League	https://media.api-sports.io/football/leagues/613.png	2024-06-08 00:00:00	2024-08-11 00:00:00
714	2024	840	t	Cup	https://media.api-sports.io/football/leagues/840.png	2024-05-02 00:00:00	2024-06-01 00:00:00
715	2024	672	t	Cup	https://media.api-sports.io/football/leagues/672.png	2024-05-12 00:00:00	2024-12-05 00:00:00
716	2024	918	t	Cup	https://media.api-sports.io/football/leagues/918.png	2024-07-14 00:00:00	2024-07-27 00:00:00
717	2024	1031	t	League	https://media.api-sports.io/football/leagues/1031.png	2024-05-11 00:00:00	2024-10-20 00:00:00
718	2024	742	t	Cup	https://media.api-sports.io/football/leagues/742.png	2024-06-14 00:00:00	2024-10-13 00:00:00
719	2024	1100	t	League	https://media.api-sports.io/football/leagues/1100.png	2024-05-04 00:00:00	2024-07-24 00:00:00
720	2024	1101	t	Cup	https://media.api-sports.io/football/leagues/1101.png	2024-05-06 00:00:00	2024-05-19 00:00:00
721	2024	1102	f	Cup	https://media.api-sports.io/football/leagues/1102.png	2024-05-05 00:00:00	2024-05-18 00:00:00
722	2024	258	t	League	https://media.api-sports.io/football/leagues/258.png	2024-06-15 00:00:00	2024-10-06 00:00:00
723	2024	1103	f	League	https://media.api-sports.io/football/leagues/1103.png	2024-05-05 00:00:00	2024-10-11 00:00:00
724	2024	1104	f	League	https://media.api-sports.io/football/leagues/1104.png	2024-03-07 00:00:00	2024-12-06 00:00:00
725	2024	1106	t	League	https://media.api-sports.io/football/leagues/1106.png	2024-05-12 00:00:00	2024-08-04 00:00:00
726	2024	1107	f	League	https://media.api-sports.io/football/leagues/1107.png	2024-05-11 00:00:00	2024-10-05 00:00:00
727	2024	35	t	Cup	https://media.api-sports.io/football/leagues/35.png	2024-09-05 00:00:00	2026-03-31 00:00:00
728	2024	115	t	Cup	https://media.api-sports.io/football/leagues/115.png	2024-05-14 00:00:00	2025-05-29 00:00:00
729	2024	102	f	Cup	https://media.api-sports.io/football/leagues/102.png	2024-05-25 00:00:00	2024-11-23 00:00:00
730	2024	1035	t	Cup	https://media.api-sports.io/football/leagues/1035.png	2024-07-24 00:00:00	2024-11-06 00:00:00
731	2024	500	t	Cup	https://media.api-sports.io/football/leagues/500.png	2024-06-12 00:00:00	2024-08-24 00:00:00
732	2024	1108	t	League	https://media.api-sports.io/football/leagues/1108.png	2024-05-18 00:00:00	2024-07-02 00:00:00
733	2024	24	t	Cup	https://media.api-sports.io/football/leagues/24.png	2024-10-08 00:00:00	2025-01-05 00:00:00
734	2024	536	t	Cup	https://media.api-sports.io/football/leagues/536.png	2024-09-04 00:00:00	2025-03-24 00:00:00
735	2024	486	t	Cup	https://media.api-sports.io/football/leagues/486.png	2024-05-11 00:00:00	2025-05-07 00:00:00
736	2024	657	t	Cup	https://media.api-sports.io/football/leagues/657.png	2024-06-12 00:00:00	2025-05-06 00:00:00
737	2024	1110	t	League	https://media.api-sports.io/football/leagues/1110.png	2024-05-25 00:00:00	2024-08-17 00:00:00
738	2024	1112	t	League	https://media.api-sports.io/football/leagues/1112.png	2024-05-31 00:00:00	2024-09-30 00:00:00
739	2024	185	t	Cup	https://media.api-sports.io/football/leagues/185.png	2024-07-13 00:00:00	2024-12-15 00:00:00
740	2024	928	t	Cup	https://media.api-sports.io/football/leagues/928.png	2024-07-17 00:00:00	2024-07-29 00:00:00
741	2024	81	t	Cup	https://media.api-sports.io/football/leagues/81.png	2024-08-16 00:00:00	2025-05-24 00:00:00
742	2024	210	t	League	https://media.api-sports.io/football/leagues/210.png	2024-08-03 00:00:00	2025-05-24 00:00:00
743	2024	339	t	League	https://media.api-sports.io/football/leagues/339.png	2024-08-03 00:00:00	2025-04-27 00:00:00
744	2024	106	t	League	https://media.api-sports.io/football/leagues/106.png	2024-07-20 00:00:00	2025-05-24 00:00:00
745	2024	108	t	Cup	https://media.api-sports.io/football/leagues/108.png	2024-08-06 00:00:00	2025-05-02 00:00:00
746	2024	400	t	League	https://media.api-sports.io/football/leagues/400.png	2024-08-17 00:00:00	2025-05-17 00:00:00
747	2024	1113	t	Cup	https://media.api-sports.io/football/leagues/1113.png	2024-06-06 00:00:00	2024-07-20 00:00:00
748	2024	1114	t	League	https://media.api-sports.io/football/leagues/1114.png	2024-06-08 00:00:00	2024-10-13 00:00:00
749	2024	1115	t	League	https://media.api-sports.io/football/leagues/1115.png	2024-06-12 00:00:00	2024-10-11 00:00:00
750	2024	1116	t	League	https://media.api-sports.io/football/leagues/1116.png	2024-05-11 00:00:00	2024-07-22 00:00:00
751	2024	1117	f	League	https://media.api-sports.io/football/leagues/1117.png	2024-05-05 00:00:00	2024-07-19 00:00:00
752	2024	1118	f	League	https://media.api-sports.io/football/leagues/1118.png	2024-03-09 00:00:00	2024-08-03 00:00:00
753	2024	1119	t	League	https://media.api-sports.io/football/leagues/1119.png	2024-07-20 00:00:00	2024-10-26 00:00:00
754	2024	920	t	Cup	https://media.api-sports.io/football/leagues/920.png	2024-08-31 00:00:00	2024-09-22 00:00:00
755	2024	119	t	League	https://media.api-sports.io/football/leagues/119.png	2024-07-19 00:00:00	2025-05-25 00:00:00
756	2024	530	t	Cup	https://media.api-sports.io/football/leagues/530.png	2024-06-28 00:00:00	2024-07-03 00:00:00
757	2024	262	t	League	https://media.api-sports.io/football/leagues/262.png	2024-07-05 00:00:00	2025-04-21 00:00:00
758	2024	287	t	League	https://media.api-sports.io/football/leagues/287.png	2024-08-03 00:00:00	2025-04-05 00:00:00
759	2024	145	t	League	https://media.api-sports.io/football/leagues/145.png	2024-08-16 00:00:00	2025-04-19 00:00:00
760	2024	146	t	League	https://media.api-sports.io/football/leagues/146.png	2024-08-30 00:00:00	2025-05-17 00:00:00
761	2024	1120	t	League	https://media.api-sports.io/football/leagues/1120.png	2024-06-12 00:00:00	2024-08-14 00:00:00
762	2024	534	t	Cup	https://media.api-sports.io/football/leagues/534.png	2024-07-25 00:00:00	2024-08-05 00:00:00
763	2024	107	t	League	https://media.api-sports.io/football/leagues/107.png	2024-07-20 00:00:00	2025-05-24 00:00:00
764	2024	1122	t	Cup	https://media.api-sports.io/football/leagues/1122.png	2024-07-04 00:00:00	2024-07-18 00:00:00
765	2024	673	t	League	https://media.api-sports.io/football/leagues/673.png	2024-07-04 00:00:00	2025-04-19 00:00:00
766	2024	173	t	League	https://media.api-sports.io/football/leagues/173.png	2024-07-20 00:00:00	2025-05-24 00:00:00
767	2024	874	t	Cup	https://media.api-sports.io/football/leagues/874.png	2024-07-23 00:00:00	2024-10-05 00:00:00
768	2024	1028	t	Cup	https://media.api-sports.io/football/leagues/1028.png	2024-07-30 00:00:00	2024-12-03 00:00:00
769	2024	39	t	League	https://media.api-sports.io/football/leagues/39.png	2024-08-16 00:00:00	2025-05-25 00:00:00
770	2024	2	t	Cup	https://media.api-sports.io/football/leagues/2.png	2024-07-09 00:00:00	2025-04-16 00:00:00
771	2024	848	t	Cup	https://media.api-sports.io/football/leagues/848.png	2024-07-10 00:00:00	2025-04-17 00:00:00
772	2024	3	t	Cup	https://media.api-sports.io/football/leagues/3.png	2024-07-11 00:00:00	2025-04-17 00:00:00
773	2024	140	t	League	https://media.api-sports.io/football/leagues/140.png	2024-08-15 00:00:00	2025-05-25 00:00:00
774	2024	856	t	Cup	https://media.api-sports.io/football/leagues/856.png	2024-08-20 00:00:00	2024-12-03 00:00:00
775	2024	220	t	Cup	https://media.api-sports.io/football/leagues/220.png	2024-07-26 00:00:00	2025-05-01 00:00:00
776	2024	120	t	League	https://media.api-sports.io/football/leagues/120.png	2024-07-19 00:00:00	2025-05-23 00:00:00
777	2024	208	t	League	https://media.api-sports.io/football/leagues/208.png	2024-07-19 00:00:00	2025-05-23 00:00:00
778	2024	859	t	Cup	https://media.api-sports.io/football/leagues/859.png	2024-06-26 00:00:00	2024-07-07 00:00:00
779	2024	738	t	Cup	https://media.api-sports.io/football/leagues/738.png	2024-07-19 00:00:00	2025-02-28 00:00:00
780	2024	940	t	Cup	https://media.api-sports.io/football/leagues/940.png	2024-07-20 00:00:00	2024-07-30 00:00:00
781	2024	332	t	League	https://media.api-sports.io/football/leagues/332.png	2024-07-27 00:00:00	2025-05-17 00:00:00
782	2024	89	t	League	https://media.api-sports.io/football/leagues/89.png	2024-08-09 00:00:00	2025-05-09 00:00:00
783	2024	345	t	League	https://media.api-sports.io/football/leagues/345.png	2024-07-20 00:00:00	2025-04-19 00:00:00
784	2024	97	t	Cup	https://media.api-sports.io/football/leagues/97.png	2024-10-29 00:00:00	2025-01-11 00:00:00
785	2024	162	t	League	https://media.api-sports.io/football/leagues/162.png	2024-07-20 00:00:00	2025-05-07 00:00:00
786	2024	733	t	League	https://media.api-sports.io/football/leagues/733.png	2024-08-10 00:00:00	2025-05-31 00:00:00
787	2024	737	t	Cup	https://media.api-sports.io/football/leagues/737.png	2024-07-30 00:00:00	2025-05-01 00:00:00
788	2024	111	t	League	https://media.api-sports.io/football/leagues/111.png	2024-07-26 00:00:00	2025-04-12 00:00:00
789	2024	271	t	League	https://media.api-sports.io/football/leagues/271.png	2024-07-27 00:00:00	2025-05-24 00:00:00
790	2024	237	t	Cup	https://media.api-sports.io/football/leagues/237.png	2024-07-30 00:00:00	2025-04-15 00:00:00
791	2024	109	t	League	https://media.api-sports.io/football/leagues/109.png	2024-07-19 00:00:00	2025-06-07 00:00:00
792	2024	588	t	League	https://media.api-sports.io/football/leagues/588.png	2024-07-06 00:00:00	2025-02-16 00:00:00
793	2024	346	t	League	https://media.api-sports.io/football/leagues/346.png	2024-07-20 00:00:00	2025-05-24 00:00:00
794	2024	110	t	League	https://media.api-sports.io/football/leagues/110.png	2024-08-09 00:00:00	2025-04-19 00:00:00
795	2024	62	t	League	https://media.api-sports.io/football/leagues/62.png	2024-08-16 00:00:00	2025-05-10 00:00:00
796	2024	1124	t	League	https://media.api-sports.io/football/leagues/1124.png	2024-06-15 00:00:00	2024-08-18 00:00:00
797	2024	235	t	League	https://media.api-sports.io/football/leagues/235.png	2024-07-21 00:00:00	2025-05-24 00:00:00
798	2024	144	t	League	https://media.api-sports.io/football/leagues/144.png	2024-07-26 00:00:00	2025-05-25 00:00:00
799	2024	88	t	League	https://media.api-sports.io/football/leagues/88.png	2024-08-09 00:00:00	2025-05-18 00:00:00
800	2024	61	t	League	https://media.api-sports.io/football/leagues/61.png	2024-08-18 00:00:00	2025-05-18 00:00:00
801	2024	950	t	Cup	https://media.api-sports.io/football/leagues/950.png	2024-10-16 00:00:00	2024-11-03 00:00:00
802	2024	1020	t	League	https://media.api-sports.io/football/leagues/1020.png	2024-06-25 00:00:00	2024-09-30 00:00:00
803	2024	172	t	League	https://media.api-sports.io/football/leagues/172.png	2024-07-19 00:00:00	2025-04-18 00:00:00
804	2024	286	t	League	https://media.api-sports.io/football/leagues/286.png	2024-07-19 00:00:00	2025-04-05 00:00:00
805	2024	385	t	Cup	https://media.api-sports.io/football/leagues/385.png	2024-07-20 00:00:00	2024-12-24 00:00:00
806	2024	207	t	League	https://media.api-sports.io/football/leagues/207.png	2024-07-20 00:00:00	2025-04-19 00:00:00
807	2024	394	t	League	https://media.api-sports.io/football/leagues/394.png	2024-08-03 00:00:00	2025-05-10 00:00:00
808	2024	383	t	League	https://media.api-sports.io/football/leagues/383.png	2024-08-24 00:00:00	2025-05-24 00:00:00
809	2024	17	t	Cup	https://media.api-sports.io/football/leagues/17.png	2024-08-06 00:00:00	2025-04-27 00:00:00
810	2024	1017	t	League	https://media.api-sports.io/football/leagues/1017.png	2024-07-05 00:00:00	2025-04-20 00:00:00
811	2024	424	t	League	https://media.api-sports.io/football/leagues/424.png	2024-10-04 00:00:00	2025-03-22 00:00:00
812	2024	862	t	League	https://media.api-sports.io/football/leagues/862.png	2024-08-02 00:00:00	2025-04-12 00:00:00
813	2024	669	t	League	https://media.api-sports.io/football/leagues/669.png	2024-08-17 00:00:00	2025-05-24 00:00:00
814	2024	122	t	League	https://media.api-sports.io/football/leagues/122.png	2024-08-02 00:00:00	2025-04-12 00:00:00
815	2024	501	t	Cup	https://media.api-sports.io/football/leagues/501.png	2024-07-03 00:00:00	2024-12-06 00:00:00
816	2024	40	t	League	https://media.api-sports.io/football/leagues/40.png	2024-08-09 00:00:00	2025-05-03 00:00:00
817	2024	41	t	League	https://media.api-sports.io/football/leagues/41.png	2024-08-09 00:00:00	2025-05-03 00:00:00
818	2024	42	t	League	https://media.api-sports.io/football/leagues/42.png	2024-08-09 00:00:00	2025-05-03 00:00:00
819	2024	141	t	League	https://media.api-sports.io/football/leagues/141.png	2024-08-15 00:00:00	2025-06-01 00:00:00
820	2024	218	t	League	https://media.api-sports.io/football/leagues/218.png	2024-08-02 00:00:00	2025-05-24 00:00:00
821	2024	48	t	Cup	https://media.api-sports.io/football/leagues/48.png	2024-08-13 00:00:00	2025-03-16 00:00:00
822	2024	561	t	League	https://media.api-sports.io/football/leagues/561.png	2024-08-24 00:00:00	2025-04-26 00:00:00
823	2024	46	t	Cup	https://media.api-sports.io/football/leagues/46.png	2024-08-20 00:00:00	2025-04-13 00:00:00
824	2024	395	t	League	https://media.api-sports.io/football/leagues/395.png	2024-08-09 00:00:00	2025-04-26 00:00:00
825	2024	296	t	League	https://media.api-sports.io/football/leagues/296.png	2024-08-10 00:00:00	2025-04-27 00:00:00
826	2024	374	t	League	https://media.api-sports.io/football/leagues/374.png	2024-08-11 00:00:00	2025-05-24 00:00:00
827	2024	1125	t	League	https://media.api-sports.io/football/leagues/1125.png	2024-06-29 00:00:00	2024-09-22 00:00:00
828	2024	219	t	League	https://media.api-sports.io/football/leagues/219.png	2024-08-03 00:00:00	2025-05-25 00:00:00
829	2024	947	t	Cup	https://media.api-sports.io/football/leagues/947.png	2024-08-17 00:00:00	2025-05-01 00:00:00
830	2024	179	t	League	https://media.api-sports.io/football/leagues/179.png	2024-08-03 00:00:00	2025-04-12 00:00:00
831	2024	283	t	League	https://media.api-sports.io/football/leagues/283.png	2024-07-12 00:00:00	2025-05-24 00:00:00
832	2024	373	t	League	https://media.api-sports.io/football/leagues/373.png	2024-07-20 00:00:00	2025-05-24 00:00:00
833	2024	355	t	League	https://media.api-sports.io/football/leagues/355.png	2024-08-04 00:00:00	2025-05-24 00:00:00
834	2024	333	t	League	https://media.api-sports.io/football/leagues/333.png	2024-07-26 00:00:00	2025-05-24 00:00:00
835	2024	183	t	League	https://media.api-sports.io/football/leagues/183.png	2024-08-03 00:00:00	2025-05-03 00:00:00
836	2024	180	t	League	https://media.api-sports.io/football/leagues/180.png	2024-08-02 00:00:00	2025-05-02 00:00:00
837	2024	184	t	League	https://media.api-sports.io/football/leagues/184.png	2024-08-03 00:00:00	2025-05-03 00:00:00
838	2024	330	t	League	https://media.api-sports.io/football/leagues/330.png	2024-08-08 00:00:00	2025-05-15 00:00:00
839	2024	407	t	League	https://media.api-sports.io/football/leagues/407.png	2024-08-09 00:00:00	2025-04-26 00:00:00
840	2024	408	t	League	https://media.api-sports.io/football/leagues/408.png	2024-08-09 00:00:00	2025-04-26 00:00:00
841	2024	211	t	League	https://media.api-sports.io/football/leagues/211.png	2024-08-16 00:00:00	2025-05-31 00:00:00
842	2024	382	t	League	https://media.api-sports.io/football/leagues/382.png	2024-08-22 00:00:00	2025-05-16 00:00:00
843	2024	338	t	League	https://media.api-sports.io/football/leagues/338.png	2024-07-27 00:00:00	2025-04-13 00:00:00
844	2024	147	t	Cup	https://media.api-sports.io/football/leagues/147.png	2024-07-26 00:00:00	2025-05-14 00:00:00
845	2024	1065	t	League	https://media.api-sports.io/football/leagues/1065.png	2024-08-02 00:00:00	2025-05-23 00:00:00
846	2024	18	t	Cup	https://media.api-sports.io/football/leagues/18.png	2024-08-14 00:00:00	2025-04-16 00:00:00
847	2024	308	t	League	https://media.api-sports.io/football/leagues/308.png	2024-08-19 00:00:00	2025-05-18 00:00:00
848	2024	349	t	League	https://media.api-sports.io/football/leagues/349.png	2024-08-02 00:00:00	2025-06-15 00:00:00
849	2024	348	t	League	https://media.api-sports.io/football/leagues/348.png	2024-08-09 00:00:00	2025-06-07 00:00:00
850	2024	685	t	League	https://media.api-sports.io/football/leagues/685.png	2024-08-10 00:00:00	2025-06-07 00:00:00
851	2024	638	t	League	https://media.api-sports.io/football/leagues/638.png	2024-08-09 00:00:00	2025-06-15 00:00:00
852	2024	209	t	Cup	https://media.api-sports.io/football/leagues/209.png	2024-08-16 00:00:00	2025-04-26 00:00:00
853	2024	135	t	League	https://media.api-sports.io/football/leagues/135.png	2024-08-17 00:00:00	2025-05-25 00:00:00
854	2024	78	t	League	https://media.api-sports.io/football/leagues/78.png	2024-08-23 00:00:00	2025-05-17 00:00:00
855	2024	318	t	League	https://media.api-sports.io/football/leagues/318.png	2024-08-23 00:00:00	2025-04-22 00:00:00
856	2024	668	t	League	https://media.api-sports.io/football/leagues/668.png	2024-08-09 00:00:00	2025-06-14 00:00:00
857	2024	686	t	League	https://media.api-sports.io/football/leagues/686.png	2024-08-03 00:00:00	2025-06-15 00:00:00
858	2024	354	t	League	https://media.api-sports.io/football/leagues/354.png	2024-08-02 00:00:00	2025-06-15 00:00:00
859	2024	353	t	League	https://media.api-sports.io/football/leagues/353.png	2024-08-02 00:00:00	2025-06-15 00:00:00
860	2024	352	t	League	https://media.api-sports.io/football/leagues/352.png	2024-08-09 00:00:00	2025-06-14 00:00:00
861	2024	351	t	League	https://media.api-sports.io/football/leagues/351.png	2024-08-09 00:00:00	2025-06-14 00:00:00
862	2024	350	t	League	https://media.api-sports.io/football/leagues/350.png	2024-08-09 00:00:00	2025-06-14 00:00:00
863	2024	730	t	League	https://media.api-sports.io/football/leagues/730.png	2024-07-27 00:00:00	2025-04-12 00:00:00
864	2024	236	t	League	https://media.api-sports.io/football/leagues/236.png	2024-07-13 00:00:00	2025-05-24 00:00:00
865	2024	79	t	League	https://media.api-sports.io/football/leagues/79.png	2024-08-02 00:00:00	2025-05-18 00:00:00
866	2024	315	t	League	https://media.api-sports.io/football/leagues/315.png	2024-08-03 00:00:00	2025-05-31 00:00:00
867	2024	393	t	League	https://media.api-sports.io/football/leagues/393.png	2024-08-16 00:00:00	2025-04-05 00:00:00
868	2024	487	t	League	https://media.api-sports.io/football/leagues/487.png	2024-08-28 00:00:00	2025-05-11 00:00:00
869	2024	223	t	League	https://media.api-sports.io/football/leagues/223.png	2024-08-03 00:00:00	2025-06-07 00:00:00
870	2024	222	t	League	https://media.api-sports.io/football/leagues/222.png	2024-08-02 00:00:00	2025-06-06 00:00:00
871	2024	221	t	League	https://media.api-sports.io/football/leagues/221.png	2024-08-02 00:00:00	2025-06-07 00:00:00
872	2024	347	t	Cup	https://media.api-sports.io/football/leagues/347.png	2024-07-20 00:00:00	2025-04-02 00:00:00
873	2024	891	t	Cup	https://media.api-sports.io/football/leagues/891.png	2024-08-09 00:00:00	2025-04-08 00:00:00
874	2024	946	t	League	https://media.api-sports.io/football/leagues/946.png	2024-08-23 00:00:00	2025-05-31 00:00:00
875	2024	525	t	Cup	https://media.api-sports.io/football/leagues/525.png	2024-09-04 00:00:00	2025-04-26 00:00:00
876	2024	510	t	League	https://media.api-sports.io/football/leagues/510.png	2024-08-03 00:00:00	2025-05-24 00:00:00
877	2024	121	t	Cup	https://media.api-sports.io/football/leagues/121.png	2024-08-05 00:00:00	2025-05-07 00:00:00
878	2024	127	t	League	https://media.api-sports.io/football/leagues/127.png	2024-08-09 00:00:00	2025-04-05 00:00:00
879	2024	126	t	League	https://media.api-sports.io/football/leagues/126.png	2024-08-10 00:00:00	2025-04-05 00:00:00
880	2024	125	t	League	https://media.api-sports.io/football/leagues/125.png	2024-08-09 00:00:00	2025-04-05 00:00:00
881	2024	124	t	League	https://media.api-sports.io/football/leagues/124.png	2024-08-09 00:00:00	2025-04-05 00:00:00
882	2024	799	t	League	https://media.api-sports.io/football/leagues/799.png	2024-08-17 00:00:00	2025-06-14 00:00:00
883	2024	798	t	League	https://media.api-sports.io/football/leagues/798.png	2024-08-17 00:00:00	2025-06-14 00:00:00
884	2024	797	t	League	https://media.api-sports.io/football/leagues/797.png	2024-08-17 00:00:00	2025-06-14 00:00:00
885	2024	796	t	League	https://media.api-sports.io/football/leagues/796.png	2024-08-17 00:00:00	2025-06-14 00:00:00
886	2024	1126	f	League	https://media.api-sports.io/football/leagues/1126.png	2024-03-02 00:00:00	2024-11-24 00:00:00
887	2024	1127	t	Cup	https://media.api-sports.io/football/leagues/1127.png	2024-04-25 00:00:00	2024-09-07 00:00:00
888	2024	783	t	League	https://media.api-sports.io/football/leagues/783.png	2024-08-03 00:00:00	2025-06-07 00:00:00
889	2024	782	t	League	https://media.api-sports.io/football/leagues/782.png	2024-08-03 00:00:00	2025-06-07 00:00:00
890	2024	781	t	League	https://media.api-sports.io/football/leagues/781.png	2024-08-03 00:00:00	2025-06-07 00:00:00
891	2024	780	t	League	https://media.api-sports.io/football/leagues/780.png	2024-08-02 00:00:00	2025-06-07 00:00:00
892	2024	261	t	League	https://media.api-sports.io/football/leagues/261.png	2024-08-04 00:00:00	2025-05-25 00:00:00
893	2024	305	t	League	https://media.api-sports.io/football/leagues/305.png	2024-08-09 00:00:00	2025-04-18 00:00:00
894	2024	95	t	League	https://media.api-sports.io/football/leagues/95.png	2024-08-11 00:00:00	2025-05-17 00:00:00
895	2024	94	t	League	https://media.api-sports.io/football/leagues/94.png	2024-08-09 00:00:00	2025-05-17 00:00:00
896	2024	301	t	League	https://media.api-sports.io/football/leagues/301.png	2024-08-23 00:00:00	2025-05-05 00:00:00
897	2024	137	t	Cup	https://media.api-sports.io/football/leagues/137.png	2024-08-03 00:00:00	2025-04-23 00:00:00
898	2024	45	t	Cup	https://media.api-sports.io/football/leagues/45.png	2024-08-02 00:00:00	2025-04-26 00:00:00
899	2024	739	t	League	https://media.api-sports.io/football/leagues/739.png	2024-08-09 00:00:00	2025-04-17 00:00:00
900	2024	704	t	Cup	https://media.api-sports.io/football/leagues/704.png	2024-08-21 00:00:00	2025-04-09 00:00:00
901	2024	182	t	Cup	https://media.api-sports.io/football/leagues/182.png	2024-07-30 00:00:00	2025-03-30 00:00:00
902	2024	272	t	League	https://media.api-sports.io/football/leagues/272.png	2024-07-28 00:00:00	2025-05-25 00:00:00
903	2024	285	t	Cup	https://media.api-sports.io/football/leagues/285.png	2024-07-10 00:00:00	2025-04-22 00:00:00
904	2024	731	t	League	https://media.api-sports.io/football/leagues/731.png	2024-07-26 00:00:00	2025-04-19 00:00:00
905	2024	148	t	League	https://media.api-sports.io/football/leagues/148.png	2024-08-24 00:00:00	2025-05-04 00:00:00
906	2024	149	t	League	https://media.api-sports.io/football/leagues/149.png	2024-08-31 00:00:00	2025-04-27 00:00:00
907	2024	150	t	League	https://media.api-sports.io/football/leagues/150.png	2024-08-31 00:00:00	2025-04-27 00:00:00
908	2024	47	t	Cup	https://media.api-sports.io/football/leagues/47.png	2024-08-24 00:00:00	2025-04-05 00:00:00
909	2024	136	t	League	https://media.api-sports.io/football/leagues/136.png	2024-08-16 00:00:00	2025-05-09 00:00:00
910	2024	599	t	League	https://media.api-sports.io/football/leagues/599.png	2024-08-03 00:00:00	2025-05-24 00:00:00
911	2024	600	t	League	https://media.api-sports.io/football/leagues/600.png	2024-08-03 00:00:00	2025-05-24 00:00:00
912	2024	601	t	League	https://media.api-sports.io/football/leagues/601.png	2024-08-03 00:00:00	2025-05-24 00:00:00
913	2024	151	t	League	https://media.api-sports.io/football/leagues/151.png	2024-08-31 00:00:00	2025-04-27 00:00:00
914	2024	152	t	League	https://media.api-sports.io/football/leagues/152.png	2024-08-31 00:00:00	2025-04-27 00:00:00
915	2024	689	t	League	https://media.api-sports.io/football/leagues/689.png	2024-08-24 00:00:00	2025-04-27 00:00:00
916	2024	690	t	League	https://media.api-sports.io/football/leagues/690.png	2024-08-24 00:00:00	2025-04-27 00:00:00
917	2024	80	t	League	https://media.api-sports.io/football/leagues/80.png	2024-08-02 00:00:00	2025-05-17 00:00:00
918	2024	163	t	League	https://media.api-sports.io/football/leagues/163.png	2024-08-02 00:00:00	2025-04-06 00:00:00
919	2024	533	t	Cup	https://media.api-sports.io/football/leagues/533.png	2024-09-27 00:00:00	2024-09-27 00:00:00
920	2024	551	t	Cup	https://media.api-sports.io/football/leagues/551.png	2024-08-03 00:00:00	2024-08-03 00:00:00
921	2024	1042	t	Cup	https://media.api-sports.io/football/leagues/1042.png	2024-08-18 00:00:00	2024-08-18 00:00:00
922	2024	885	t	Cup	https://media.api-sports.io/football/leagues/885.png	2024-09-25 00:00:00	2024-09-25 00:00:00
923	2024	1131	t	League	https://media.api-sports.io/football/leagues/1131.png	2024-08-11 00:00:00	2024-08-11 00:00:00
924	2024	1137	t	League	https://media.api-sports.io/football/leagues/1137.png	2024-08-25 00:00:00	2024-08-25 00:00:00
925	2024	1144	t	Cup	https://media.api-sports.io/football/leagues/1144.png	2024-08-31 00:00:00	2024-08-31 00:00:00
926	2024	809	t	Cup	https://media.api-sports.io/football/leagues/809.png	2024-09-18 00:00:00	2024-09-18 00:00:00
927	2024	1050	t	Cup	https://media.api-sports.io/football/leagues/1050.png	2024-12-13 00:00:00	2024-12-13 00:00:00
928	2024	516	t	Cup	https://media.api-sports.io/football/leagues/516.png	2025-01-17 00:00:00	2025-01-17 00:00:00
929	2024	896	t	Cup	https://media.api-sports.io/football/leagues/896.png	2024-12-13 00:00:00	2024-12-13 00:00:00
930	2024	656	t	Cup	https://media.api-sports.io/football/leagues/656.png	2025-02-04 00:00:00	2025-02-04 00:00:00
931	2024	1056	t	League	https://media.api-sports.io/football/leagues/1056.png	2024-12-01 00:00:00	2024-12-01 00:00:00
932	2024	1166	t	Cup	https://media.api-sports.io/football/leagues/1166.png	2024-11-24 00:00:00	2024-11-24 00:00:00
933	2024	546	t	Cup	https://media.api-sports.io/football/leagues/546.png	2025-02-07 00:00:00	2025-02-07 00:00:00
934	2024	708	t	Cup	https://media.api-sports.io/football/leagues/708.png	2024-12-26 00:00:00	2024-12-26 00:00:00
935	2024	905	t	Cup	https://media.api-sports.io/football/leagues/905.png	2025-01-18 00:00:00	2025-01-18 00:00:00
936	2024	1167	t	Cup	https://media.api-sports.io/football/leagues/1167.png	2024-07-18 00:00:00	2024-07-18 00:00:00
937	2024	961	t	Cup	https://media.api-sports.io/football/leagues/961.png	2025-01-23 00:00:00	2025-01-23 00:00:00
938	2024	944	t	Cup	https://media.api-sports.io/football/leagues/944.png	2025-01-14 00:00:00	2025-01-14 00:00:00
939	2024	853	t	Cup	https://media.api-sports.io/football/leagues/853.png	2025-02-01 00:00:00	2025-02-01 00:00:00
940	2024	654	t	Cup	https://media.api-sports.io/football/leagues/654.png	2025-02-20 00:00:00	2025-02-20 00:00:00
941	2024	1178	f	Cup	https://media.api-sports.io/football/leagues/1178.png	2025-03-05 00:00:00	2025-03-05 00:00:00
942	2024	831	f	Cup	https://media.api-sports.io/football/leagues/831.png	2023-10-07 00:00:00	2023-10-07 00:00:00
943	2024	632	f	Cup	https://media.api-sports.io/football/leagues/632.png	2024-02-03 00:00:00	2024-02-03 00:00:00
944	2024	548	f	Cup	https://media.api-sports.io/football/leagues/548.png	2024-02-17 00:00:00	2024-02-17 00:00:00
945	2024	517	f	Cup	https://media.api-sports.io/football/leagues/517.png	2023-12-23 00:00:00	2023-12-23 00:00:00
946	2024	639	f	Cup	https://media.api-sports.io/football/leagues/639.png	2024-04-01 00:00:00	2024-04-01 00:00:00
947	2024	972	f	Cup	https://media.api-sports.io/football/leagues/972.png	2024-02-25 00:00:00	2024-02-25 00:00:00
948	2024	1059	t	Cup	https://media.api-sports.io/football/leagues/1059.png	2024-01-17 00:00:00	2024-01-17 00:00:00
949	2024	641	f	Cup	https://media.api-sports.io/football/leagues/641.png	2024-03-15 00:00:00	2024-03-15 00:00:00
950	2024	842	f	Cup	https://media.api-sports.io/football/leagues/842.png	2024-01-31 00:00:00	2024-01-31 00:00:00
951	2024	839	f	Cup	https://media.api-sports.io/football/leagues/839.png	2024-02-25 00:00:00	2024-02-25 00:00:00
952	2024	819	t	Cup	https://media.api-sports.io/football/leagues/819.png	2024-01-20 00:00:00	2024-01-20 00:00:00
953	2024	527	f	Cup	https://media.api-sports.io/football/leagues/527.png	2024-02-11 00:00:00	2024-02-11 00:00:00
954	2024	812	f	Cup	https://media.api-sports.io/football/leagues/812.png	2024-03-02 00:00:00	2024-03-02 00:00:00
955	2024	818	f	Cup	https://media.api-sports.io/football/leagues/818.png	2024-02-25 00:00:00	2024-02-25 00:00:00
956	2024	810	f	Cup	https://media.api-sports.io/football/leagues/810.png	2024-03-13 00:00:00	2024-03-13 00:00:00
957	2024	866	f	Cup	https://media.api-sports.io/football/leagues/866.png	2024-07-25 00:00:00	2024-07-25 00:00:00
958	2024	1089	f	Cup	https://media.api-sports.io/football/leagues/1089.png	2024-04-13 00:00:00	2024-04-13 00:00:00
959	2024	1105	t	Cup	https://media.api-sports.io/football/leagues/1105.png	2024-05-09 00:00:00	2024-05-09 00:00:00
960	2024	555	t	Cup	https://media.api-sports.io/football/leagues/555.png	2024-07-06 00:00:00	2024-07-06 00:00:00
961	2024	864	t	Cup	https://media.api-sports.io/football/leagues/864.png	2024-07-08 00:00:00	2024-07-08 00:00:00
962	2024	550	t	Cup	https://media.api-sports.io/football/leagues/550.png	2024-08-03 00:00:00	2024-08-03 00:00:00
963	2024	531	t	Cup	https://media.api-sports.io/football/leagues/531.png	2024-08-14 00:00:00	2024-08-14 00:00:00
964	2024	529	t	Cup	https://media.api-sports.io/football/leagues/529.png	2024-08-17 00:00:00	2024-08-17 00:00:00
965	2024	1123	f	Cup	https://media.api-sports.io/football/leagues/1123.png	2024-04-12 00:00:00	2024-04-12 00:00:00
966	2024	663	t	Cup	https://media.api-sports.io/football/leagues/663.png	2024-07-13 00:00:00	2024-07-13 00:00:00
967	2024	884	t	Cup	https://media.api-sports.io/football/leagues/884.png	2024-08-28 00:00:00	2024-08-28 00:00:00
968	2024	727	t	Cup	https://media.api-sports.io/football/leagues/727.png	2024-07-07 00:00:00	2024-07-07 00:00:00
969	2024	1019	t	Cup	https://media.api-sports.io/football/leagues/1019.png	2024-07-05 00:00:00	2024-07-05 00:00:00
970	2024	659	t	Cup	https://media.api-sports.io/football/leagues/659.png	2024-07-15 00:00:00	2024-07-15 00:00:00
971	2024	937	t	Cup	https://media.api-sports.io/football/leagues/937.png	2024-08-11 00:00:00	2024-08-11 00:00:00
972	2024	857	t	Cup	https://media.api-sports.io/football/leagues/857.png	2024-06-30 00:00:00	2024-06-30 00:00:00
973	2024	528	t	Cup	https://media.api-sports.io/football/leagues/528.png	2024-08-10 00:00:00	2024-08-10 00:00:00
974	2024	852	t	Cup	https://media.api-sports.io/football/leagues/852.png	2024-08-17 00:00:00	2024-08-17 00:00:00
975	2024	526	t	Cup	https://media.api-sports.io/football/leagues/526.png	2024-08-10 00:00:00	2024-08-10 00:00:00
976	2024	817	t	Cup	https://media.api-sports.io/football/leagues/817.png	2024-08-20 00:00:00	2024-08-20 00:00:00
977	2025	850	f	Cup	https://media.api-sports.io/football/leagues/850.png	2023-03-24 00:00:00	2024-11-19 00:00:00
978	2025	36	t	Cup	https://media.api-sports.io/football/leagues/36.png	2024-03-20 00:00:00	2024-11-19 00:00:00
979	2025	1083	t	Cup	https://media.api-sports.io/football/leagues/1083.png	2024-04-05 00:00:00	2024-12-03 00:00:00
980	2025	504	t	Cup	https://media.api-sports.io/football/leagues/504.png	2024-09-22 00:00:00	2025-04-02 00:00:00
981	2025	565	t	League	https://media.api-sports.io/football/leagues/565.png	2024-08-02 00:00:00	2025-03-30 00:00:00
982	2025	826	t	Cup	https://media.api-sports.io/football/leagues/826.png	2024-08-13 00:00:00	2024-08-17 00:00:00
983	2025	869	t	Cup	https://media.api-sports.io/football/leagues/869.png	2024-07-09 00:00:00	2024-07-21 00:00:00
984	2025	831	t	Cup	https://media.api-sports.io/football/leagues/831.png	2024-08-31 00:00:00	2024-08-31 00:00:00
985	2025	399	t	League	https://media.api-sports.io/football/leagues/399.png	2024-08-31 00:00:00	2025-04-27 00:00:00
986	2025	886	t	Cup	https://media.api-sports.io/football/leagues/886.png	2024-10-09 00:00:00	2025-06-10 00:00:00
987	2025	764	t	League	https://media.api-sports.io/football/leagues/764.png	2024-08-16 00:00:00	2025-06-19 00:00:00
988	2025	893	f	Cup	https://media.api-sports.io/football/leagues/893.png	2024-10-09 00:00:00	2025-03-25 00:00:00
989	2025	1147	t	League	https://media.api-sports.io/football/leagues/1147.png	2024-09-07 00:00:00	2024-11-24 00:00:00
990	2025	340	t	League	https://media.api-sports.io/football/leagues/340.png	2024-09-14 00:00:00	2025-06-22 00:00:00
991	2025	341	t	Cup	https://media.api-sports.io/football/leagues/341.png	2024-10-19 00:00:00	2025-04-22 00:00:00
992	2025	637	t	League	https://media.api-sports.io/football/leagues/637.png	2024-10-26 00:00:00	2025-06-21 00:00:00
993	2025	765	t	League	https://media.api-sports.io/football/leagues/765.png	2024-09-28 00:00:00	2025-04-02 00:00:00
994	2025	539	t	Cup	https://media.api-sports.io/football/leagues/539.png	2024-10-20 00:00:00	2024-10-24 00:00:00
995	2025	965	t	Cup	https://media.api-sports.io/football/leagues/965.png	2025-02-12 00:00:00	2025-03-01 00:00:00
996	2025	1040	t	Cup	https://media.api-sports.io/football/leagues/1040.png	2025-02-21 00:00:00	2025-06-03 00:00:00
997	2025	602	t	League	https://media.api-sports.io/football/leagues/602.png	2025-01-11 00:00:00	2025-03-22 00:00:00
998	2025	610	t	League	https://media.api-sports.io/football/leagues/610.png	2025-01-18 00:00:00	2025-03-29 00:00:00
999	2025	630	t	League	https://media.api-sports.io/football/leagues/630.png	2025-01-11 00:00:00	2025-03-29 00:00:00
1000	2025	773	t	Cup	https://media.api-sports.io/football/leagues/773.png	2025-01-23 00:00:00	2025-02-16 00:00:00
1001	2025	904	t	Cup	https://media.api-sports.io/football/leagues/904.png	2025-02-20 00:00:00	2025-02-27 00:00:00
1002	2025	612	t	Cup	https://media.api-sports.io/football/leagues/612.png	2025-01-04 00:00:00	2025-03-23 00:00:00
1003	2025	606	t	League	https://media.api-sports.io/football/leagues/606.png	2025-01-11 00:00:00	2025-03-29 00:00:00
1004	2025	616	t	League	https://media.api-sports.io/football/leagues/616.png	2025-01-11 00:00:00	2025-03-29 00:00:00
1005	2025	398	t	League	https://media.api-sports.io/football/leagues/398.png	2024-11-29 00:00:00	2025-05-29 00:00:00
1006	2025	411	t	League	https://media.api-sports.io/football/leagues/411.png	2024-12-07 00:00:00	2025-05-28 00:00:00
1007	2025	603	t	League	https://media.api-sports.io/football/leagues/603.png	2025-01-11 00:00:00	2025-03-29 00:00:00
1008	2025	624	t	League	https://media.api-sports.io/football/leagues/624.png	2025-01-11 00:00:00	2025-03-16 00:00:00
1009	2025	621	t	League	https://media.api-sports.io/football/leagues/621.png	2025-01-11 00:00:00	2025-03-29 00:00:00
1010	2025	522	t	League	https://media.api-sports.io/football/leagues/522.png	2025-01-25 00:00:00	2025-04-02 00:00:00
1011	2025	626	t	League	https://media.api-sports.io/football/leagues/626.png	2025-01-11 00:00:00	2025-03-29 00:00:00
1012	2025	77	t	Cup	https://media.api-sports.io/football/leagues/77.png	2025-01-11 00:00:00	2025-03-15 00:00:00
1013	2025	628	t	League	https://media.api-sports.io/football/leagues/628.png	2025-01-15 00:00:00	2025-03-30 00:00:00
1014	2025	1123	t	Cup	https://media.api-sports.io/football/leagues/1123.png	2025-01-17 00:00:00	2025-01-17 00:00:00
1015	2025	1089	t	Cup	https://media.api-sports.io/football/leagues/1089.png	2025-01-18 00:00:00	2025-01-18 00:00:00
1016	2025	836	t	League	https://media.api-sports.io/football/leagues/836.png	2025-02-07 00:00:00	2025-08-24 00:00:00
1017	2025	520	t	League	https://media.api-sports.io/football/leagues/520.png	2025-01-25 00:00:00	2025-03-29 00:00:00
1018	2025	591	t	League	https://media.api-sports.io/football/leagues/591.png	2024-12-06 00:00:00	2025-06-01 00:00:00
1019	2025	604	t	League	https://media.api-sports.io/football/leagues/604.png	2025-01-11 00:00:00	2025-03-22 00:00:00
1020	2025	609	t	League	https://media.api-sports.io/football/leagues/609.png	2025-01-18 00:00:00	2025-03-22 00:00:00
1021	2025	1063	t	Cup	https://media.api-sports.io/football/leagues/1063.png	2025-01-22 00:00:00	2025-03-30 00:00:00
1022	2025	195	t	League	https://media.api-sports.io/football/leagues/195.png	2025-02-06 00:00:00	2025-08-23 00:00:00
1023	2025	476	t	League	https://media.api-sports.io/football/leagues/476.png	2025-01-15 00:00:00	2025-04-06 00:00:00
1024	2025	475	t	League	https://media.api-sports.io/football/leagues/475.png	2025-01-15 00:00:00	2025-03-27 00:00:00
1025	2025	38	t	Cup	https://media.api-sports.io/football/leagues/38.png	2025-06-11 00:00:00	2025-06-18 00:00:00
1026	2025	622	t	League	https://media.api-sports.io/football/leagues/622.png	2025-01-11 00:00:00	2025-03-27 00:00:00
1027	2025	814	t	Cup	https://media.api-sports.io/football/leagues/814.png	2025-01-04 00:00:00	2025-01-30 00:00:00
1028	2025	813	t	League	https://media.api-sports.io/football/leagues/813.png	2024-12-14 00:00:00	2025-04-26 00:00:00
1029	2025	541	t	Cup	https://media.api-sports.io/football/leagues/541.png	2025-02-19 00:00:00	2025-02-26 00:00:00
1030	2025	901	t	Cup	https://media.api-sports.io/football/leagues/901.png	2025-02-01 00:00:00	2025-04-05 00:00:00
1031	2025	608	t	League	https://media.api-sports.io/football/leagues/608.png	2025-01-11 00:00:00	2025-03-30 00:00:00
1032	2025	629	t	League	https://media.api-sports.io/football/leagues/629.png	2025-01-18 00:00:00	2025-03-15 00:00:00
1033	2025	168	t	Cup	https://media.api-sports.io/football/leagues/168.png	2025-02-01 00:00:00	2025-03-25 00:00:00
1034	2025	618	t	Cup	https://media.api-sports.io/football/leagues/618.png	2025-01-02 00:00:00	2025-01-25 00:00:00
1035	2025	605	t	League	https://media.api-sports.io/football/leagues/605.png	2025-01-18 00:00:00	2025-04-06 00:00:00
1036	2025	632	t	Cup	https://media.api-sports.io/football/leagues/632.png	2025-02-02 00:00:00	2025-02-02 00:00:00
1037	2025	482	t	League	https://media.api-sports.io/football/leagues/482.png	2025-02-21 00:00:00	2025-08-23 00:00:00
1038	2025	548	t	Cup	https://media.api-sports.io/football/leagues/548.png	2025-02-08 00:00:00	2025-02-08 00:00:00
1039	2025	15	t	Cup	https://media.api-sports.io/football/leagues/15.png	2025-06-15 00:00:00	2025-06-27 00:00:00
1040	2025	16	t	Cup	https://media.api-sports.io/football/leagues/16.png	2025-02-05 00:00:00	2025-04-08 00:00:00
1041	2025	627	t	League	https://media.api-sports.io/football/leagues/627.png	2025-01-18 00:00:00	2025-04-02 00:00:00
1042	2025	611	t	League	https://media.api-sports.io/football/leagues/611.png	2025-01-18 00:00:00	2025-04-05 00:00:00
1043	2025	623	t	League	https://media.api-sports.io/football/leagues/623.png	2025-01-18 00:00:00	2025-04-06 00:00:00
1044	2025	1062	t	League	https://media.api-sports.io/football/leagues/1062.png	2025-01-22 00:00:00	2025-04-06 00:00:00
1045	2025	477	t	League	https://media.api-sports.io/football/leagues/477.png	2025-01-22 00:00:00	2025-03-16 00:00:00
1046	2025	252	t	League	https://media.api-sports.io/football/leagues/252.png	2025-07-04 00:00:00	2025-07-04 00:00:00
1047	2025	250	t	League	https://media.api-sports.io/football/leagues/250.png	2025-01-24 00:00:00	2025-05-30 00:00:00
1048	2025	833	t	League	https://media.api-sports.io/football/leagues/833.png	2025-02-21 00:00:00	2025-08-24 00:00:00
1049	2025	191	t	League	https://media.api-sports.io/football/leagues/191.png	2025-02-22 00:00:00	2025-08-17 00:00:00
1050	2025	251	t	League	https://media.api-sports.io/football/leagues/251.png	2025-03-28 00:00:00	2025-04-07 00:00:00
1051	2025	1169	t	Cup	https://media.api-sports.io/football/leagues/1169.png	2024-12-08 00:00:00	2024-12-17 00:00:00
1052	2025	843	t	Cup	https://media.api-sports.io/football/leagues/843.png	2025-01-22 00:00:00	2025-04-23 00:00:00
1053	2025	481	t	League	https://media.api-sports.io/football/leagues/481.png	2025-02-13 00:00:00	2025-08-10 00:00:00
1054	2025	194	t	League	https://media.api-sports.io/football/leagues/194.png	2025-02-21 00:00:00	2025-08-15 00:00:00
1055	2025	834	t	League	https://media.api-sports.io/football/leagues/834.png	2025-02-22 00:00:00	2025-08-16 00:00:00
1056	2025	1090	t	League	https://media.api-sports.io/football/leagues/1090.png	2025-03-14 00:00:00	2025-08-09 00:00:00
1057	2025	517	t	Cup	https://media.api-sports.io/football/leagues/517.png	2024-12-21 00:00:00	2024-12-21 00:00:00
1058	2025	521	t	League	https://media.api-sports.io/football/leagues/521.png	2025-03-08 00:00:00	2025-04-19 00:00:00
1059	2025	631	t	League	https://media.api-sports.io/football/leagues/631.png	2025-02-04 00:00:00	2025-04-05 00:00:00
1060	2025	620	t	League	https://media.api-sports.io/football/leagues/620.png	2025-02-09 00:00:00	2025-04-06 00:00:00
1061	2025	899	t	Cup	https://media.api-sports.io/football/leagues/899.png	2025-01-11 00:00:00	2025-03-29 00:00:00
1062	2025	98	t	League	https://media.api-sports.io/football/leagues/98.png	2025-02-14 00:00:00	2025-12-06 00:00:00
1063	2025	358	t	League	https://media.api-sports.io/football/leagues/358.png	2025-02-14 00:00:00	2025-10-17 00:00:00
1064	2025	99	t	League	https://media.api-sports.io/football/leagues/99.png	2025-02-15 00:00:00	2025-11-29 00:00:00
1065	2025	100	t	League	https://media.api-sports.io/football/leagues/100.png	2025-02-15 00:00:00	2025-11-29 00:00:00
1066	2025	13	t	Cup	https://media.api-sports.io/football/leagues/13.png	2025-02-05 00:00:00	2025-05-28 00:00:00
1067	2025	615	t	League	https://media.api-sports.io/football/leagues/615.png	2025-02-01 00:00:00	2025-04-08 00:00:00
1068	2025	835	t	League	https://media.api-sports.io/football/leagues/835.png	2025-02-08 00:00:00	2025-08-30 00:00:00
1069	2025	839	t	Cup	https://media.api-sports.io/football/leagues/839.png	2025-02-22 00:00:00	2025-02-22 00:00:00
1070	2025	253	t	League	https://media.api-sports.io/football/leagues/253.png	2025-02-22 00:00:00	2025-10-19 00:00:00
1071	2025	11	t	Cup	https://media.api-sports.io/football/leagues/11.png	2025-03-05 00:00:00	2025-05-28 00:00:00
1072	2025	489	t	League	https://media.api-sports.io/football/leagues/489.png	2025-03-08 00:00:00	2025-10-25 00:00:00
1073	2025	255	t	League	https://media.api-sports.io/football/leagues/255.png	2025-03-08 00:00:00	2025-10-25 00:00:00
1074	2025	648	t	League	https://media.api-sports.io/football/leagues/648.png	2025-03-14 00:00:00	2025-09-06 00:00:00
1075	2025	1095	t	League	https://media.api-sports.io/football/leagues/1095.png	2025-04-25 00:00:00	2025-07-26 00:00:00
1076	2025	926	t	Cup	https://media.api-sports.io/football/leagues/926.png	2025-07-12 00:00:00	2025-07-25 00:00:00
1077	2025	101	t	Cup	https://media.api-sports.io/football/leagues/101.png	2025-03-20 00:00:00	2025-04-16 00:00:00
1078	2025	823	t	Cup	https://media.api-sports.io/football/leagues/823.png	2025-01-26 00:00:00	2025-04-23 00:00:00
1079	2025	725	t	League	https://media.api-sports.io/football/leagues/725.png	2025-03-21 00:00:00	2025-11-15 00:00:00
1080	2025	774	t	League	https://media.api-sports.io/football/leagues/774.png	2025-03-29 00:00:00	2025-10-25 00:00:00
1081	2025	775	t	League	https://media.api-sports.io/football/leagues/775.png	2025-03-29 00:00:00	2025-10-25 00:00:00
1082	2025	776	t	League	https://media.api-sports.io/football/leagues/776.png	2025-03-29 00:00:00	2025-10-25 00:00:00
1083	2025	777	t	League	https://media.api-sports.io/football/leagues/777.png	2025-03-29 00:00:00	2025-10-25 00:00:00
1084	2025	778	t	League	https://media.api-sports.io/football/leagues/778.png	2025-03-29 00:00:00	2025-10-25 00:00:00
1085	2025	779	t	League	https://media.api-sports.io/football/leagues/779.png	2025-03-29 00:00:00	2025-10-25 00:00:00
1086	2025	736	t	League	https://media.api-sports.io/football/leagues/736.png	2025-04-13 00:00:00	2025-11-15 00:00:00
1087	2025	192	t	League	https://media.api-sports.io/football/leagues/192.png	2025-02-07 00:00:00	2025-08-31 00:00:00
1088	2025	130	t	Cup	https://media.api-sports.io/football/leagues/130.png	2025-01-23 00:00:00	2025-06-07 00:00:00
1089	2025	189	t	League	https://media.api-sports.io/football/leagues/189.png	2025-03-30 00:00:00	2025-08-31 00:00:00
1090	2025	1092	t	League	https://media.api-sports.io/football/leagues/1092.png	2025-04-05 00:00:00	2025-08-30 00:00:00
1091	2025	129	t	League	https://media.api-sports.io/football/leagues/129.png	2025-02-08 00:00:00	2025-10-11 00:00:00
1092	2025	903	t	Cup	https://media.api-sports.io/football/leagues/903.png	2025-01-30 00:00:00	2025-02-09 00:00:00
1093	2025	304	t	League	https://media.api-sports.io/football/leagues/304.png	2025-01-18 00:00:00	2025-05-11 00:00:00
1094	2025	10	t	Cup	https://media.api-sports.io/football/leagues/10.png	2025-01-04 00:00:00	2025-11-18 00:00:00
1095	2025	666	t	Cup	https://media.api-sports.io/football/leagues/666.png	2025-01-02 00:00:00	2025-07-02 00:00:00
1096	2025	639	t	Cup	https://media.api-sports.io/football/leagues/639.png	2025-03-31 00:00:00	2025-03-31 00:00:00
1097	2025	164	t	League	https://media.api-sports.io/football/leagues/164.png	2025-04-05 00:00:00	2025-09-14 00:00:00
1098	2025	671	t	League	https://media.api-sports.io/football/leagues/671.png	2025-04-15 00:00:00	2025-09-20 00:00:00
1099	2025	165	t	League	https://media.api-sports.io/football/leagues/165.png	2025-05-02 00:00:00	2025-09-13 00:00:00
1100	2025	667	t	Cup	https://media.api-sports.io/football/leagues/667.png	2025-01-03 00:00:00	2025-04-12 00:00:00
1101	2025	166	t	League	https://media.api-sports.io/football/leagues/166.png	2025-05-03 00:00:00	2025-09-13 00:00:00
1102	2025	527	t	Cup	https://media.api-sports.io/football/leagues/527.png	2025-01-25 00:00:00	2025-01-25 00:00:00
1103	2025	131	t	League	https://media.api-sports.io/football/leagues/131.png	2025-02-08 00:00:00	2025-06-21 00:00:00
1104	2025	402	t	League	https://media.api-sports.io/football/leagues/402.png	2025-01-10 00:00:00	2025-02-19 00:00:00
1105	2025	810	t	Cup	https://media.api-sports.io/football/leagues/810.png	2025-03-12 00:00:00	2025-03-12 00:00:00
1106	2025	128	t	League	https://media.api-sports.io/football/leagues/128.png	2025-01-23 00:00:00	2025-05-04 00:00:00
1107	2025	132	t	League	https://media.api-sports.io/football/leagues/132.png	2025-03-07 00:00:00	2025-09-13 00:00:00
1108	2025	842	t	Cup	https://media.api-sports.io/football/leagues/842.png	2025-01-26 00:00:00	2025-01-26 00:00:00
1109	2025	837	t	Cup	https://media.api-sports.io/football/leagues/837.png	2025-02-01 00:00:00	2025-03-29 00:00:00
1110	2025	972	t	Cup	https://media.api-sports.io/football/leagues/972.png	2025-02-07 00:00:00	2025-02-07 00:00:00
1111	2025	497	t	League	https://media.api-sports.io/football/leagues/497.png	2025-03-08 00:00:00	2025-11-23 00:00:00
1112	2025	281	t	League	https://media.api-sports.io/football/leagues/281.png	2025-02-07 00:00:00	2025-06-29 00:00:00
1113	2025	367	t	League	https://media.api-sports.io/football/leagues/367.png	2025-03-07 00:00:00	2025-10-25 00:00:00
1114	2025	366	t	League	https://media.api-sports.io/football/leagues/366.png	2025-03-07 00:00:00	2025-10-25 00:00:00
1115	2025	713	t	Cup	https://media.api-sports.io/football/leagues/713.png	2025-01-30 00:00:00	2025-02-07 00:00:00
1116	2025	240	t	League	https://media.api-sports.io/football/leagues/240.png	2025-02-01 00:00:00	2025-05-17 00:00:00
1117	2025	299	t	League	https://media.api-sports.io/football/leagues/299.png	2025-01-24 00:00:00	2025-04-25 00:00:00
1118	2025	239	t	League	https://media.api-sports.io/football/leagues/239.png	2025-01-24 00:00:00	2025-05-25 00:00:00
1119	2025	818	t	Cup	https://media.api-sports.io/football/leagues/818.png	2025-02-22 00:00:00	2025-02-22 00:00:00
1120	2025	293	t	League	https://media.api-sports.io/football/leagues/293.png	2025-02-22 00:00:00	2025-11-23 00:00:00
1121	2025	544	t	Cup	https://media.api-sports.io/football/leagues/544.png	2025-02-02 00:00:00	2025-04-20 00:00:00
1122	2025	242	t	League	https://media.api-sports.io/football/leagues/242.png	2025-02-16 00:00:00	2025-09-28 00:00:00
1123	2025	267	t	Cup	https://media.api-sports.io/football/leagues/267.png	2025-01-26 00:00:00	2025-05-10 00:00:00
1124	2025	607	t	League	https://media.api-sports.io/football/leagues/607.png	2025-02-08 00:00:00	2025-04-05 00:00:00
1125	2025	641	t	Cup	https://media.api-sports.io/football/leagues/641.png	2025-03-08 00:00:00	2025-03-08 00:00:00
1126	2025	265	t	League	https://media.api-sports.io/football/leagues/265.png	2025-02-16 00:00:00	2025-12-07 00:00:00
1127	2025	254	t	League	https://media.api-sports.io/football/leagues/254.png	2025-03-15 00:00:00	2025-11-02 00:00:00
1128	2025	963	t	Cup	https://media.api-sports.io/football/leagues/963.png	2025-02-07 00:00:00	2025-02-17 00:00:00
1129	2025	1180	t	Cup	https://media.api-sports.io/football/leagues/1180.png	2025-02-21 00:00:00	2025-04-27 00:00:00
1130	2025	640	t	League	https://media.api-sports.io/football/leagues/640.png	2025-04-26 00:00:00	2025-08-09 00:00:00
1131	2025	1012	t	Cup	https://media.api-sports.io/football/leagues/1012.png	2025-04-03 00:00:00	2025-04-11 00:00:00
1132	2025	268	t	League	https://media.api-sports.io/football/leagues/268.png	2025-01-31 00:00:00	2025-05-03 00:00:00
1133	2025	357	t	League	https://media.api-sports.io/football/leagues/357.png	2025-02-14 00:00:00	2025-11-01 00:00:00
1134	2025	292	t	League	https://media.api-sports.io/football/leagues/292.png	2025-02-15 00:00:00	2025-10-18 00:00:00
1135	2025	169	t	League	https://media.api-sports.io/football/leagues/169.png	2025-02-22 00:00:00	2025-11-22 00:00:00
1136	2025	327	t	League	https://media.api-sports.io/football/leagues/327.png	2025-02-28 00:00:00	2025-12-13 00:00:00
1137	2025	326	t	League	https://media.api-sports.io/football/leagues/326.png	2025-03-08 00:00:00	2025-12-12 00:00:00
1138	2025	549	t	League	https://media.api-sports.io/football/leagues/549.png	2025-03-22 00:00:00	2025-11-16 00:00:00
1139	2025	167	t	Cup	https://media.api-sports.io/football/leagues/167.png	2025-03-28 00:00:00	2025-04-14 00:00:00
1140	2025	114	t	League	https://media.api-sports.io/football/leagues/114.png	2025-03-29 00:00:00	2025-11-08 00:00:00
1141	2025	113	t	League	https://media.api-sports.io/football/leagues/113.png	2025-03-29 00:00:00	2025-11-09 00:00:00
1142	2025	103	t	League	https://media.api-sports.io/football/leagues/103.png	2025-03-29 00:00:00	2025-11-30 00:00:00
1143	2025	104	t	League	https://media.api-sports.io/football/leagues/104.png	2025-03-31 00:00:00	2025-11-08 00:00:00
1144	2025	244	t	League	https://media.api-sports.io/football/leagues/244.png	2025-04-05 00:00:00	2025-08-31 00:00:00
1145	2025	564	t	League	https://media.api-sports.io/football/leagues/564.png	2025-03-28 00:00:00	2025-11-08 00:00:00
1146	2025	563	t	League	https://media.api-sports.io/football/leagues/563.png	2025-03-28 00:00:00	2025-11-09 00:00:00
1147	2025	473	t	League	https://media.api-sports.io/football/leagues/473.png	2025-03-29 00:00:00	2025-10-25 00:00:00
1148	2025	474	t	League	https://media.api-sports.io/football/leagues/474.png	2025-03-29 00:00:00	2025-10-25 00:00:00
1149	2025	592	t	League	https://media.api-sports.io/football/leagues/592.png	2025-03-28 00:00:00	2025-10-18 00:00:00
1150	2025	595	t	League	https://media.api-sports.io/football/leagues/595.png	2025-03-29 00:00:00	2025-10-19 00:00:00
1151	2025	597	t	League	https://media.api-sports.io/football/leagues/597.png	2025-03-29 00:00:00	2025-10-19 00:00:00
1152	2025	593	t	League	https://media.api-sports.io/football/leagues/593.png	2025-03-29 00:00:00	2025-10-18 00:00:00
1153	2025	596	t	League	https://media.api-sports.io/football/leagues/596.png	2025-03-28 00:00:00	2025-10-19 00:00:00
1154	2025	594	t	League	https://media.api-sports.io/football/leagues/594.png	2025-04-12 00:00:00	2025-06-29 00:00:00
1155	2025	27	t	Cup	https://media.api-sports.io/football/leagues/27.png	2025-02-09 00:00:00	2025-04-06 00:00:00
1156	2025	812	t	Cup	https://media.api-sports.io/football/leagues/812.png	2025-02-22 00:00:00	2025-02-22 00:00:00
1157	2025	909	t	League	https://media.api-sports.io/football/leagues/909.png	2025-03-07 00:00:00	2025-10-05 00:00:00
1158	2025	6	t	Cup	https://media.api-sports.io/football/leagues/6.png	2025-12-21 00:00:00	2025-12-31 00:00:00
1159	2025	906	t	League	https://media.api-sports.io/football/leagues/906.png	2025-02-18 00:00:00	2025-10-29 00:00:00
1160	2025	1104	t	League	https://media.api-sports.io/football/leagues/1104.png	2025-03-27 00:00:00	2025-12-04 00:00:00
1161	2025	1082	t	Cup	https://media.api-sports.io/football/leagues/1082.png	2025-03-01 00:00:00	2025-04-12 00:00:00
1162	2025	196	t	League	https://media.api-sports.io/football/leagues/196.png	2025-03-14 00:00:00	2025-08-23 00:00:00
1163	2025	266	t	League	https://media.api-sports.io/football/leagues/266.png	2025-02-23 00:00:00	2025-11-02 00:00:00
1164	2025	246	t	Cup	https://media.api-sports.io/football/leagues/246.png	2025-02-09 00:00:00	2025-04-16 00:00:00
1165	2025	329	t	League	https://media.api-sports.io/football/leagues/329.png	2025-02-28 00:00:00	2025-11-08 00:00:00
1166	2025	369	t	League	https://media.api-sports.io/football/leagues/369.png	2025-03-07 00:00:00	2025-06-28 00:00:00
1167	2025	257	t	Cup	https://media.api-sports.io/football/leagues/257.png	2025-03-18 00:00:00	2025-04-03 00:00:00
1168	2025	73	t	Cup	https://media.api-sports.io/football/leagues/73.png	2025-02-18 00:00:00	2025-03-14 00:00:00
1169	2025	540	t	Cup	https://media.api-sports.io/football/leagues/540.png	2025-03-01 00:00:00	2025-03-16 00:00:00
1170	2025	1094	t	League	https://media.api-sports.io/football/leagues/1094.png	2025-03-21 00:00:00	2025-08-23 00:00:00
1171	2025	413	t	League	https://media.api-sports.io/football/leagues/413.png	2025-02-10 00:00:00	2025-03-02 00:00:00
1172	2025	571	t	League	https://media.api-sports.io/football/leagues/571.png	2025-03-07 00:00:00	2025-11-09 00:00:00
1173	2025	479	t	League	https://media.api-sports.io/football/leagues/479.png	2025-04-05 00:00:00	2025-10-18 00:00:00
1174	2025	365	t	League	https://media.api-sports.io/football/leagues/365.png	2025-03-05 00:00:00	2025-11-09 00:00:00
1175	2025	712	t	League	https://media.api-sports.io/football/leagues/712.png	2025-02-23 00:00:00	2025-06-22 00:00:00
1176	2025	71	t	League	https://media.api-sports.io/football/leagues/71.png	2025-03-29 00:00:00	2025-12-21 00:00:00
1177	2025	772	t	Cup	https://media.api-sports.io/football/leagues/772.png	2025-07-29 00:00:00	2025-08-07 00:00:00
1178	2025	969	t	League	https://media.api-sports.io/football/leagues/969.png	2025-02-19 00:00:00	2025-04-27 00:00:00
1179	2025	858	t	Cup	https://media.api-sports.io/football/leagues/858.png	2025-03-21 00:00:00	2025-03-26 00:00:00
1180	2025	389	t	League	https://media.api-sports.io/football/leagues/389.png	2025-03-01 00:00:00	2025-10-26 00:00:00
1181	2025	1172	t	Cup	https://media.api-sports.io/football/leagues/1172.png	2025-02-12 00:00:00	2025-03-16 00:00:00
1182	2025	295	t	League	https://media.api-sports.io/football/leagues/295.png	2025-03-01 00:00:00	2025-11-08 00:00:00
1183	2025	294	t	Cup	https://media.api-sports.io/football/leagues/294.png	2025-03-08 00:00:00	2025-04-16 00:00:00
1184	2025	711	t	League	https://media.api-sports.io/football/leagues/711.png	2025-03-02 00:00:00	2025-11-30 00:00:00
1185	2025	259	t	Cup	https://media.api-sports.io/football/leagues/259.png	2025-04-29 00:00:00	2025-05-08 00:00:00
1186	2025	614	t	League	https://media.api-sports.io/football/leagues/614.png	2025-04-13 00:00:00	2025-06-08 00:00:00
1187	2025	1069	t	League	https://media.api-sports.io/football/leagues/1069.png	2025-02-21 00:00:00	2025-05-03 00:00:00
1188	2025	376	t	League	https://media.api-sports.io/football/leagues/376.png	2025-02-22 00:00:00	2025-09-21 00:00:00
1189	2025	72	t	League	https://media.api-sports.io/football/leagues/72.png	2025-04-04 00:00:00	2025-11-22 00:00:00
1190	2025	362	t	League	https://media.api-sports.io/football/leagues/362.png	2025-02-28 00:00:00	2025-06-30 00:00:00
1191	2025	1076	t	League	https://media.api-sports.io/football/leagues/1076.png	2025-04-05 00:00:00	2025-08-02 00:00:00
1192	2025	401	t	League	https://media.api-sports.io/football/leagues/401.png	2025-02-28 00:00:00	2025-04-06 00:00:00
1193	2025	1093	t	League	https://media.api-sports.io/football/leagues/1093.png	2025-03-14 00:00:00	2025-08-09 00:00:00
1194	2025	1091	t	League	https://media.api-sports.io/football/leagues/1091.png	2025-03-15 00:00:00	2025-08-30 00:00:00
1195	2025	243	t	League	https://media.api-sports.io/football/leagues/243.png	2025-03-19 00:00:00	2025-08-13 00:00:00
1196	2025	247	t	League	https://media.api-sports.io/football/leagues/247.png	2025-04-19 00:00:00	2025-08-16 00:00:00
1197	2025	248	t	League	https://media.api-sports.io/football/leagues/248.png	2025-04-12 00:00:00	2025-08-16 00:00:00
1198	2025	249	t	League	https://media.api-sports.io/football/leagues/249.png	2025-04-17 00:00:00	2025-08-16 00:00:00
1199	2025	269	t	League	https://media.api-sports.io/football/leagues/269.png	2025-03-08 00:00:00	2025-04-07 00:00:00
1200	2025	361	t	League	https://media.api-sports.io/football/leagues/361.png	2025-03-07 00:00:00	2025-06-29 00:00:00
1201	2025	971	t	Cup	https://media.api-sports.io/football/leagues/971.png	2025-03-08 00:00:00	2025-04-12 00:00:00
1202	2025	1175	t	Cup	https://media.api-sports.io/football/leagues/1175.png	2025-03-01 00:00:00	2025-03-01 00:00:00
1203	2025	1176	t	Cup	https://media.api-sports.io/football/leagues/1176.png	2025-03-01 00:00:00	2025-03-01 00:00:00
1204	2025	1177	t	Cup	https://media.api-sports.io/football/leagues/1177.png	2025-03-01 00:00:00	2025-03-01 00:00:00
1205	2025	1126	t	League	https://media.api-sports.io/football/leagues/1126.png	2025-02-27 00:00:00	2025-11-09 00:00:00
1206	2025	134	t	League	https://media.api-sports.io/football/leagues/134.png	2025-03-16 00:00:00	2025-07-13 00:00:00
1207	2025	1077	t	Cup	https://media.api-sports.io/football/leagues/1077.png	2025-03-19 00:00:00	2025-03-25 00:00:00
1208	2025	915	t	League	https://media.api-sports.io/football/leagues/915.png	2025-03-22 00:00:00	2025-10-18 00:00:00
1209	2025	802	t	Cup	https://media.api-sports.io/football/leagues/802.png	2025-04-01 00:00:00	2025-05-21 00:00:00
1210	2025	1087	t	League	https://media.api-sports.io/football/leagues/1087.png	2025-04-21 00:00:00	2025-08-02 00:00:00
1211	2025	619	t	League	https://media.api-sports.io/football/leagues/619.png	2025-05-03 00:00:00	2025-06-21 00:00:00
1212	2025	328	t	League	https://media.api-sports.io/football/leagues/328.png	2025-03-01 00:00:00	2025-11-09 00:00:00
1213	2025	116	t	League	https://media.api-sports.io/football/leagues/116.png	2025-03-13 00:00:00	2025-11-29 00:00:00
1214	2025	569	t	League	https://media.api-sports.io/football/leagues/569.png	2025-03-04 00:00:00	2025-06-13 00:00:00
1215	2025	76	t	League	https://media.api-sports.io/football/leagues/76.png	2025-04-12 00:00:00	2025-07-19 00:00:00
1216	2025	75	t	League	https://media.api-sports.io/football/leagues/75.png	2025-04-12 00:00:00	2025-08-31 00:00:00
1217	2025	636	t	League	https://media.api-sports.io/football/leagues/636.png	2025-03-04 00:00:00	2025-06-22 00:00:00
1218	2025	1098	t	League	https://media.api-sports.io/football/leagues/1098.png	2025-04-18 00:00:00	2025-06-21 00:00:00
1219	2025	660	t	League	https://media.api-sports.io/football/leagues/660.png	2025-03-15 00:00:00	2025-10-02 00:00:00
1220	2025	170	t	League	https://media.api-sports.io/football/leagues/170.png	2025-03-15 00:00:00	2025-11-08 00:00:00
1221	2025	238	t	League	https://media.api-sports.io/football/leagues/238.png	2025-03-07 00:00:00	2025-11-21 00:00:00
1222	2025	491	t	Cup	https://media.api-sports.io/football/leagues/491.png	2025-04-07 00:00:00	2025-04-07 00:00:00
1223	2025	1071	t	League	https://media.api-sports.io/football/leagues/1071.png	2025-03-29 00:00:00	2025-06-14 00:00:00
1224	2025	171	t	Cup	https://media.api-sports.io/football/leagues/171.png	2025-03-14 00:00:00	2025-04-18 00:00:00
1225	2025	740	t	Cup	https://media.api-sports.io/football/leagues/740.png	2025-03-10 00:00:00	2025-07-23 00:00:00
1226	2025	957	t	League	https://media.api-sports.io/football/leagues/957.png	2025-03-29 00:00:00	2025-08-30 00:00:00
1227	2025	954	t	League	https://media.api-sports.io/football/leagues/954.png	2025-03-28 00:00:00	2025-08-30 00:00:00
1228	2025	956	t	League	https://media.api-sports.io/football/leagues/956.png	2025-03-15 00:00:00	2025-08-30 00:00:00
1229	2025	649	t	League	https://media.api-sports.io/football/leagues/649.png	2025-03-07 00:00:00	2025-11-08 00:00:00
1230	2025	907	t	League	https://media.api-sports.io/football/leagues/907.png	2025-03-08 00:00:00	2025-06-14 00:00:00
1231	2025	1097	t	Cup	https://media.api-sports.io/football/leagues/1097.png	2025-04-19 00:00:00	2025-06-28 00:00:00
1232	2025	364	t	League	https://media.api-sports.io/football/leagues/364.png	2025-03-28 00:00:00	2025-11-08 00:00:00
1233	2025	1179	t	Cup	https://media.api-sports.io/football/leagues/1179.png	2025-03-11 00:00:00	2025-04-15 00:00:00
1234	2025	613	t	League	https://media.api-sports.io/football/leagues/613.png	2025-04-30 00:00:00	2025-06-29 00:00:00
1235	2025	117	t	League	https://media.api-sports.io/football/leagues/117.png	2025-03-28 00:00:00	2025-04-13 00:00:00
1236	2025	1073	t	League	https://media.api-sports.io/football/leagues/1073.png	2025-03-29 00:00:00	2025-06-28 00:00:00
1237	2025	973	t	Cup	https://media.api-sports.io/football/leagues/973.png	2025-03-30 00:00:00	2025-04-07 00:00:00
1238	2025	74	t	League	https://media.api-sports.io/football/leagues/74.png	2025-03-23 00:00:00	2025-06-18 00:00:00
1239	2025	498	t	Cup	https://media.api-sports.io/football/leagues/498.png	2025-03-15 00:00:00	2025-04-13 00:00:00
1240	2025	910	t	Cup	https://media.api-sports.io/football/leagues/910.png	2025-03-17 00:00:00	2025-03-31 00:00:00
1241	2025	1103	t	League	https://media.api-sports.io/football/leagues/1103.png	2025-05-09 00:00:00	2025-09-12 00:00:00
1242	2025	1075	t	League	https://media.api-sports.io/football/leagues/1075.png	2025-04-03 00:00:00	2025-06-07 00:00:00
1243	2025	282	t	League	https://media.api-sports.io/football/leagues/282.png	2025-04-05 00:00:00	2025-07-05 00:00:00
1244	2025	929	t	League	https://media.api-sports.io/football/leagues/929.png	2025-03-22 00:00:00	2025-08-03 00:00:00
1245	2025	923	t	League	https://media.api-sports.io/football/leagues/923.png	2025-04-19 00:00:00	2025-08-24 00:00:00
1246	2025	102	t	Cup	https://media.api-sports.io/football/leagues/102.png	2025-06-11 00:00:00	2025-06-11 00:00:00
1247	2025	1117	t	League	https://media.api-sports.io/football/leagues/1117.png	2025-05-05 00:00:00	2025-06-30 00:00:00
1248	2025	653	t	League	https://media.api-sports.io/football/leagues/653.png	2025-04-12 00:00:00	2025-10-19 00:00:00
1249	2025	650	t	League	https://media.api-sports.io/football/leagues/650.png	2025-03-28 00:00:00	2025-11-01 00:00:00
1250	2025	652	t	League	https://media.api-sports.io/football/leagues/652.png	2025-03-30 00:00:00	2025-11-02 00:00:00
1251	2025	651	t	League	https://media.api-sports.io/football/leagues/651.png	2025-03-22 00:00:00	2025-09-13 00:00:00
1252	2025	193	t	League	https://media.api-sports.io/football/leagues/193.png	2025-03-14 00:00:00	2025-09-06 00:00:00
1253	2025	1118	t	League	https://media.api-sports.io/football/leagues/1118.png	2025-03-23 00:00:00	2025-07-06 00:00:00
1254	2025	379	t	League	https://media.api-sports.io/football/leagues/379.png	2025-03-23 00:00:00	2025-03-30 00:00:00
1255	2025	1107	t	League	https://media.api-sports.io/football/leagues/1107.png	2025-05-17 00:00:00	2025-08-09 00:00:00
1256	2025	391	t	League	https://media.api-sports.io/football/leagues/391.png	2025-04-05 00:00:00	2025-12-20 00:00:00
1257	2025	1181	t	Cup	https://media.api-sports.io/football/leagues/1181.png	2025-03-22 00:00:00	2025-03-22 00:00:00
1258	2025	1182	t	League	https://media.api-sports.io/football/leagues/1182.png	2025-04-17 00:00:00	2025-10-18 00:00:00
1259	2025	300	t	League	https://media.api-sports.io/football/leagues/300.png	2025-03-28 00:00:00	2025-04-13 00:00:00
1260	2025	105	t	Cup	https://media.api-sports.io/football/leagues/105.png	2025-03-26 00:00:00	2025-04-13 00:00:00
1261	2025	538	t	Cup	https://media.api-sports.io/football/leagues/538.png	2025-04-26 00:00:00	2025-05-08 00:00:00
1263	2025	970	t	Cup	https://media.api-sports.io/football/leagues/970.png	2025-03-27 00:00:00	2025-04-06 00:00:00
1264	2025	1081	t	Cup	https://media.api-sports.io/football/leagues/1081.png	2025-04-30 00:00:00	2025-05-09 00:00:00
1265	2025	1102	t	Cup	https://media.api-sports.io/football/leagues/1102.png	2025-05-04 00:00:00	2025-05-11 00:00:00
1266	2025	1001	t	Cup	https://media.api-sports.io/football/leagues/1001.png	2025-05-29 00:00:00	2025-06-03 00:00:00
1267	2025	344	t	League	https://media.api-sports.io/football/leagues/344.png	2025-03-28 00:00:00	2025-04-13 00:00:00
1268	2025	866	t	Cup	https://media.api-sports.io/football/leagues/866.png	2025-07-24 00:00:00	2025-07-24 00:00:00
1269	2025	720	t	Cup	https://media.api-sports.io/football/leagues/720.png	2025-04-10 00:00:00	2025-05-23 00:00:00
1270	2025	921	t	Cup	https://media.api-sports.io/football/leagues/921.png	2025-05-18 00:00:00	2025-05-25 00:00:00
1271	2025	1178	t	Cup	https://media.api-sports.io/football/leagues/1178.png	2025-07-05 00:00:00	2025-07-05 00:00:00
1272	2025	743	t	Cup	https://media.api-sports.io/football/leagues/743.png	2025-07-02 00:00:00	2025-07-13 00:00:00
1274	2025	661	t	Cup	https://media.api-sports.io/football/leagues/661.png	2025-04-10 00:00:00	2025-04-10 00:00:00
1275	2025	717	t	League	https://media.api-sports.io/football/leagues/717.png	2025-01-19 00:00:00	2025-04-26 00:00:00
1276	2025	1183	t	Cup	https://media.api-sports.io/football/leagues/1183.png	2025-03-26 00:00:00	2025-05-14 00:00:00
1277	2025	1184	t	Cup	https://media.api-sports.io/football/leagues/1184.png	2025-04-02 00:00:00	2025-04-03 00:00:00
\.


--
-- Data for Name: teams; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teams (id, name, short_name, city, img_url) FROM stdin;
10	England	ENG	England	https://media.api-sports.io/football/teams/10.png
33	Manchester United	MUN	England	https://media.api-sports.io/football/teams/33.png
34	Newcastle	NEW	England	https://media.api-sports.io/football/teams/34.png
35	Bournemouth	BOU	England	https://media.api-sports.io/football/teams/35.png
36	Fulham	FUL	England	https://media.api-sports.io/football/teams/36.png
37	Huddersfield	HUD	England	https://media.api-sports.io/football/teams/37.png
38	Watford	WAT	England	https://media.api-sports.io/football/teams/38.png
39	Wolves	WOL	England	https://media.api-sports.io/football/teams/39.png
40	Liverpool	LIV	England	https://media.api-sports.io/football/teams/40.png
41	Southampton	SOU	England	https://media.api-sports.io/football/teams/41.png
42	Arsenal	ARS	England	https://media.api-sports.io/football/teams/42.png
44	Burnley	BUR	England	https://media.api-sports.io/football/teams/44.png
45	Everton	EVE	England	https://media.api-sports.io/football/teams/45.png
46	Leicester	LEI	England	https://media.api-sports.io/football/teams/46.png
47	Tottenham	TOT	England	https://media.api-sports.io/football/teams/47.png
48	West Ham	WES	England	https://media.api-sports.io/football/teams/48.png
49	Chelsea	CHE	England	https://media.api-sports.io/football/teams/49.png
50	Manchester City	MAC	England	https://media.api-sports.io/football/teams/50.png
51	Brighton	BRI	England	https://media.api-sports.io/football/teams/51.png
52	Crystal Palace	CRY	England	https://media.api-sports.io/football/teams/52.png
53	Reading	REA	England	https://media.api-sports.io/football/teams/53.png
54	Birmingham	BIR	England	https://media.api-sports.io/football/teams/54.png
55	Brentford	BRE	England	https://media.api-sports.io/football/teams/55.png
56	Bristol City	BRI	England	https://media.api-sports.io/football/teams/56.png
57	Ipswich	IPS	England	https://media.api-sports.io/football/teams/57.png
58	Millwall	MIL	England	https://media.api-sports.io/football/teams/58.png
59	Preston	PRE	England	https://media.api-sports.io/football/teams/59.png
60	West Brom	WES	England	https://media.api-sports.io/football/teams/60.png
61	Wigan	WIG	England	https://media.api-sports.io/football/teams/61.png
62	Sheffield Utd	SHE	England	https://media.api-sports.io/football/teams/62.png
63	Leeds	LEE	England	https://media.api-sports.io/football/teams/63.png
64	Hull City	HUL	England	https://media.api-sports.io/football/teams/64.png
65	Nottingham Forest	NOT	England	https://media.api-sports.io/football/teams/65.png
66	Aston Villa	AST	England	https://media.api-sports.io/football/teams/66.png
67	Blackburn	BLA	England	https://media.api-sports.io/football/teams/67.png
68	Bolton	BOL	England	https://media.api-sports.io/football/teams/68.png
69	Derby	DER	England	https://media.api-sports.io/football/teams/69.png
70	Middlesbrough	MID	England	https://media.api-sports.io/football/teams/70.png
71	Norwich	NOR	England	https://media.api-sports.io/football/teams/71.png
72	QPR	QPR	England	https://media.api-sports.io/football/teams/72.png
73	Rotherham	ROT	England	https://media.api-sports.io/football/teams/73.png
74	Sheffield Wednesday	SHE	England	https://media.api-sports.io/football/teams/74.png
75	Stoke City	STO	England	https://media.api-sports.io/football/teams/75.png
746	Sunderland	SUN	England	https://media.api-sports.io/football/teams/746.png
747	Barnsley	BAR	England	https://media.api-sports.io/football/teams/747.png
748	Burton Albion	BUR	England	https://media.api-sports.io/football/teams/748.png
1333	AFC Wimbledon	WIM	England	https://media.api-sports.io/football/teams/1333.png
1334	Bristol Rovers	BRI	England	https://media.api-sports.io/football/teams/1334.png
1335	Charlton	CHA	England	https://media.api-sports.io/football/teams/1335.png
1336	Fleetwood Town	FLE	England	https://media.api-sports.io/football/teams/1336.png
1337	Northampton	NOR	England	https://media.api-sports.io/football/teams/1337.png
1338	Oxford United	OXF	England	https://media.api-sports.io/football/teams/1338.png
1339	Rochdale	ROC	England	https://media.api-sports.io/football/teams/1339.png
1340	Scunthorpe	SCU	England	https://media.api-sports.io/football/teams/1340.png
1341	Southend	SOU	England	https://media.api-sports.io/football/teams/1341.png
1342	Walsall	WAL	England	https://media.api-sports.io/football/teams/1342.png
1343	Bradford	BRA	England	https://media.api-sports.io/football/teams/1343.png
1344	Bury	BUR	England	https://media.api-sports.io/football/teams/1344.png
1345	Chesterfield	CHE	England	https://media.api-sports.io/football/teams/1345.png
1346	Coventry	COV	England	https://media.api-sports.io/football/teams/1346.png
1347	Gillingham	GIL	England	https://media.api-sports.io/football/teams/1347.png
1348	Milton Keynes Dons	MIL	England	https://media.api-sports.io/football/teams/1348.png
1349	Oldham	OLD	England	https://media.api-sports.io/football/teams/1349.png
1350	Peterborough	PET	England	https://media.api-sports.io/football/teams/1350.png
1351	Port Vale	POR	England	https://media.api-sports.io/football/teams/1351.png
1352	Shrewsbury	SHR	England	https://media.api-sports.io/football/teams/1352.png
1353	Swindon Town	SWI	England	https://media.api-sports.io/football/teams/1353.png
1354	Doncaster	DON	England	https://media.api-sports.io/football/teams/1354.png
1355	Portsmouth	POR	England	https://media.api-sports.io/football/teams/1355.png
1356	Blackpool	BLA	England	https://media.api-sports.io/football/teams/1356.png
1357	Plymouth	PLY	England	https://media.api-sports.io/football/teams/1357.png
1358	Wycombe	WYC	England	https://media.api-sports.io/football/teams/1358.png
1359	Luton	LUT	England	https://media.api-sports.io/football/teams/1359.png
1360	Accrington ST	ACC	England	https://media.api-sports.io/football/teams/1360.png
1361	Colchester	COL	England	https://media.api-sports.io/football/teams/1361.png
1362	Crawley Town	CRA	England	https://media.api-sports.io/football/teams/1362.png
1363	Crewe	CRE	England	https://media.api-sports.io/football/teams/1363.png
1364	Exeter City	EXE	England	https://media.api-sports.io/football/teams/1364.png
1365	Grimsby	GRI	England	https://media.api-sports.io/football/teams/1365.png
1366	Hartlepool	HAR	England	https://media.api-sports.io/football/teams/1366.png
1368	Stevenage	STE	England	https://media.api-sports.io/football/teams/1368.png
1369	Barnet	BAR	England	https://media.api-sports.io/football/teams/1369.png
1370	Cambridge United	CAM	England	https://media.api-sports.io/football/teams/1370.png
1371	Carlisle	CAR	England	https://media.api-sports.io/football/teams/1371.png
1372	Cheltenham	CHE	England	https://media.api-sports.io/football/teams/1372.png
1373	Leyton Orient	LEY	England	https://media.api-sports.io/football/teams/1373.png
1374	Mansfield Town	MAN	England	https://media.api-sports.io/football/teams/1374.png
1375	Morecambe	MOR	England	https://media.api-sports.io/football/teams/1375.png
1376	Notts County	NOT	England	https://media.api-sports.io/football/teams/1376.png
1377	Yeovil Town	YEO	England	https://media.api-sports.io/football/teams/1377.png
1378	Forest Green	FOR	England	https://media.api-sports.io/football/teams/1378.png
1379	Lincoln	LNC	England	https://media.api-sports.io/football/teams/1379.png
1380	Macclesfield	MAC	England	https://media.api-sports.io/football/teams/1380.png
1381	Tranmere	TRA	England	https://media.api-sports.io/football/teams/1381.png
1721	England W	\N	England	https://media.api-sports.io/football/teams/1721.png
1818	Aldershot Town	ALD	England	https://media.api-sports.io/football/teams/1818.png
1819	Barrow	BAR	England	https://media.api-sports.io/football/teams/1819.png
1820	Chester	CHE	England	https://media.api-sports.io/football/teams/1820.png
1821	Dagenham & Redbridge	DAG	England	https://media.api-sports.io/football/teams/1821.png
1822	Eastleigh	EAS	England	https://media.api-sports.io/football/teams/1822.png
1823	Gateshead	GAT	England	https://media.api-sports.io/football/teams/1823.png
1824	Guiseley AFC	GUI	England	https://media.api-sports.io/football/teams/1824.png
1825	Maidstone Utd	MAI	England	https://media.api-sports.io/football/teams/1825.png
1826	Southport	SOU	England	https://media.api-sports.io/football/teams/1826.png
1827	Torquay	TOR	England	https://media.api-sports.io/football/teams/1827.png
1828	York	YOR	England	https://media.api-sports.io/football/teams/1828.png
1829	Dover	DOV	England	https://media.api-sports.io/football/teams/1829.png
1830	Boreham Wood	BOR	England	https://media.api-sports.io/football/teams/1830.png
1831	Braintree	BRA	England	https://media.api-sports.io/football/teams/1831.png
1832	Bromley	BRO	England	https://media.api-sports.io/football/teams/1832.png
1833	North Ferriby United	NOR	England	https://media.api-sports.io/football/teams/1833.png
1834	Solihull Moors	SOL	England	https://media.api-sports.io/football/teams/1834.png
1835	Sutton Utd	SUT	England	https://media.api-sports.io/football/teams/1835.png
1836	Woking	WOK	England	https://media.api-sports.io/football/teams/1836.png
1838	Maidenhead	MAI	England	https://media.api-sports.io/football/teams/1838.png
1839	AFC Fylde	FYL	England	https://media.api-sports.io/football/teams/1839.png
1840	Ebbsfleet United	EBB	England	https://media.api-sports.io/football/teams/1840.png
1841	FC Halifax Town	HAL	England	https://media.api-sports.io/football/teams/1841.png
1842	Harrogate Town	HAR	England	https://media.api-sports.io/football/teams/1842.png
1843	Havant & Wville	HAV	England	https://media.api-sports.io/football/teams/1843.png
1844	Salford City	\N	England	https://media.api-sports.io/football/teams/1844.png
1845	Birmingham City W	\N	England	https://media.api-sports.io/football/teams/1845.png
1846	Bristol City W	\N	England	https://media.api-sports.io/football/teams/1846.png
1847	Liverpool W	\N	England	https://media.api-sports.io/football/teams/1847.png
1848	Sunderland W	\N	England	https://media.api-sports.io/football/teams/1848.png
1849	Yeovil Town W	\N	England	https://media.api-sports.io/football/teams/1849.png
1850	Arsenal W	\N	England	https://media.api-sports.io/football/teams/1850.png
1851	Notts County W	\N	England	https://media.api-sports.io/football/teams/1851.png
1852	Reading W	\N	England	https://media.api-sports.io/football/teams/1852.png
1853	Chelsea W	\N	England	https://media.api-sports.io/football/teams/1853.png
1854	Manchester City W	\N	England	https://media.api-sports.io/football/teams/1854.png
1855	Everton W	\N	England	https://media.api-sports.io/football/teams/1855.png
1856	West Ham W	\N	England	https://media.api-sports.io/football/teams/1856.png
1857	Brighton W	\N	England	https://media.api-sports.io/football/teams/1857.png
4677	Alfreton Town	ALF	England	https://media.api-sports.io/football/teams/4677.png
4678	Billericay Town	BIL	England	https://media.api-sports.io/football/teams/4678.png
4679	Chorley	CHO	England	https://media.api-sports.io/football/teams/4679.png
4680	Hampton & Richmond	HAM	England	https://media.api-sports.io/football/teams/4680.png
4681	Haringey Borough	\N	England	https://media.api-sports.io/football/teams/4681.png
4682	Hitchin Town	HIT	England	https://media.api-sports.io/football/teams/4682.png
4683	Metropolitan Police	MET	England	https://media.api-sports.io/football/teams/4683.png
4684	Oxford City	OXF	England	https://media.api-sports.io/football/teams/4684.png
4685	Slough Town	\N	England	https://media.api-sports.io/football/teams/4685.png
4686	Stockport County	STO	England	https://media.api-sports.io/football/teams/4686.png
4687	Weston-super-Mare	WES	England	https://media.api-sports.io/football/teams/4687.png
4688	AFC Telford United	TEL	England	https://media.api-sports.io/football/teams/4688.png
4689	Chelmsford City	CHE	England	https://media.api-sports.io/football/teams/4689.png
4690	Dartford	DAR	England	https://media.api-sports.io/football/teams/4690.png
4691	Gainsborough Trinity	GAI	England	https://media.api-sports.io/football/teams/4691.png
4692	Hereford	\N	England	https://media.api-sports.io/football/teams/4692.png
4693	Heybridge Swifts	HEY	England	https://media.api-sports.io/football/teams/4693.png
4694	Hyde United	HYD	England	https://media.api-sports.io/football/teams/4694.png
4695	Kidderminster Harriers	KID	England	https://media.api-sports.io/football/teams/4695.png
4696	Leatherhead	\N	England	https://media.api-sports.io/football/teams/4696.png
4697	Nantwich Town	NAN	England	https://media.api-sports.io/football/teams/4697.png
4698	SL Aquaforce	\N	England	https://media.api-sports.io/football/teams/4698.png
4699	Truro City	TRU	England	https://media.api-sports.io/football/teams/4699.png
4700	Altrincham	ALT	England	https://media.api-sports.io/football/teams/4700.png
4701	Brackley Town	BRA	England	https://media.api-sports.io/football/teams/4701.png
4702	Chesham United	CHE	England	https://media.api-sports.io/football/teams/4702.png
4703	Curzon Ashton	CUR	England	https://media.api-sports.io/football/teams/4703.png
4704	Eastbourne Borough	EAS	England	https://media.api-sports.io/football/teams/4704.png
4705	Harrow Borough	HAR	England	https://media.api-sports.io/football/teams/4705.png
4706	Merstham	\N	England	https://media.api-sports.io/football/teams/4706.png
4707	Spennymoor Town	\N	England	https://media.api-sports.io/football/teams/4707.png
4708	St Albans City	ALB	England	https://media.api-sports.io/football/teams/4708.png
4709	Stamford	STA	England	https://media.api-sports.io/football/teams/4709.png
4710	Stourbridge	STO	England	https://media.api-sports.io/football/teams/4710.png
4711	Taunton Town	\N	England	https://media.api-sports.io/football/teams/4711.png
4712	Westfields	\N	England	https://media.api-sports.io/football/teams/4712.png
4713	Whitehawk	WHI	England	https://media.api-sports.io/football/teams/4713.png
4898	Manchester United W	\N	England	https://media.api-sports.io/football/teams/4898.png
4899	Tottenham Hotspur W	\N	England	https://media.api-sports.io/football/teams/4899.png
6759	Berwick Rangers	BER	England	https://media.api-sports.io/football/teams/6759.png
7189	Arsenal U21	ARS	England	https://media.api-sports.io/football/teams/7189.png
7190	Aston Villa U21	AST	England	https://media.api-sports.io/football/teams/7190.png
7191	Brighton U21	\N	England	https://media.api-sports.io/football/teams/7191.png
7192	Chelsea U21	CHE	England	https://media.api-sports.io/football/teams/7192.png
7193	Everton U21	EVE	England	https://media.api-sports.io/football/teams/7193.png
7194	Fulham U21	FUL	England	https://media.api-sports.io/football/teams/7194.png
7195	Leicester City U21	LEI	England	https://media.api-sports.io/football/teams/7195.png
7196	Liverpool U21	LIV	England	https://media.api-sports.io/football/teams/7196.png
7197	Manchester City U21	MAC	England	https://media.api-sports.io/football/teams/7197.png
7198	Manchester United U21	MUN	England	https://media.api-sports.io/football/teams/7198.png
7199	Newcastle United U21	\N	England	https://media.api-sports.io/football/teams/7199.png
7200	Norwich City U21	NOR	England	https://media.api-sports.io/football/teams/7200.png
7201	Southampton U21	SOU	England	https://media.api-sports.io/football/teams/7201.png
7202	Tottenham Hotspur U21	TOT	England	https://media.api-sports.io/football/teams/7202.png
7203	West Ham United U21	WES	England	https://media.api-sports.io/football/teams/7203.png
7204	Wolves U21	WOL	England	https://media.api-sports.io/football/teams/7204.png
7205	AFC Sudbury	SUD	England	https://media.api-sports.io/football/teams/7205.png
7206	Ashford United	\N	England	https://media.api-sports.io/football/teams/7206.png
7207	Aveley	\N	England	https://media.api-sports.io/football/teams/7207.png
7208	Aylesbury United	\N	England	https://media.api-sports.io/football/teams/7208.png
7209	Barking	\N	England	https://media.api-sports.io/football/teams/7209.png
7210	Barnstaple Town	\N	England	https://media.api-sports.io/football/teams/7210.png
7211	Basildon United	\N	England	https://media.api-sports.io/football/teams/7211.png
7212	Bedfont Sports	\N	England	https://media.api-sports.io/football/teams/7212.png
7213	Bedworth United	\N	England	https://media.api-sports.io/football/teams/7213.png
7214	Berkhamsted	\N	England	https://media.api-sports.io/football/teams/7214.png
7215	Bideford	BID	England	https://media.api-sports.io/football/teams/7215.png
7216	Brentwood Town	\N	England	https://media.api-sports.io/football/teams/7216.png
7217	Burgess Hill Town	\N	England	https://media.api-sports.io/football/teams/7217.png
7218	Cambridge City	CAM	England	https://media.api-sports.io/football/teams/7218.png
7219	Chipstead	\N	England	https://media.api-sports.io/football/teams/7219.png
7220	Cinderford Town	\N	England	https://media.api-sports.io/football/teams/7220.png
7221	Corby Town	COR	England	https://media.api-sports.io/football/teams/7221.png
7222	Didcot Town	\N	England	https://media.api-sports.io/football/teams/7222.png
7223	Droylsden	DRO	England	https://media.api-sports.io/football/teams/7223.png
7224	East Grinstead Town	\N	England	https://media.api-sports.io/football/teams/7224.png
7225	FC Romania	\N	England	https://media.api-sports.io/football/teams/7225.png
7226	Frome Town	FRO	England	https://media.api-sports.io/football/teams/7226.png
7227	Glossop North End	\N	England	https://media.api-sports.io/football/teams/7227.png
7228	Grays Athletic	GRA	England	https://media.api-sports.io/football/teams/7228.png
7229	Great Wakering Rovers	\N	England	https://media.api-sports.io/football/teams/7229.png
7230	Guernsey	\N	England	https://media.api-sports.io/football/teams/7230.png
7231	Hastings United	HAS	England	https://media.api-sports.io/football/teams/7231.png
7232	Herne Bay	\N	England	https://media.api-sports.io/football/teams/7232.png
7233	Highworth Town	\N	England	https://media.api-sports.io/football/teams/7233.png
7234	Histon	HIS	England	https://media.api-sports.io/football/teams/7234.png
7235	Hythe Town	HYT	England	https://media.api-sports.io/football/teams/7235.png
7236	Ilkeston Town	ILK	England	https://media.api-sports.io/football/teams/7236.png
7237	Kendal Town	\N	England	https://media.api-sports.io/football/teams/7237.png
7238	Larkhall Athletic	\N	England	https://media.api-sports.io/football/teams/7238.png
7239	Leek Town	LEE	England	https://media.api-sports.io/football/teams/7239.png
7240	Market Drayton Town	\N	England	https://media.api-sports.io/football/teams/7240.png
7241	Melksham Town	\N	England	https://media.api-sports.io/football/teams/7241.png
7242	Newcastle Town	\N	England	https://media.api-sports.io/football/teams/7242.png
7243	Northwood	\N	England	https://media.api-sports.io/football/teams/7243.png
7244	Paulton Rovers	\N	England	https://media.api-sports.io/football/teams/7244.png
7245	Phoenix Sports	\N	England	https://media.api-sports.io/football/teams/7245.png
7246	Pickering Town	\N	England	https://media.api-sports.io/football/teams/7246.png
7247	Pontefract Collieries	\N	England	https://media.api-sports.io/football/teams/7247.png
7248	Romford	\N	England	https://media.api-sports.io/football/teams/7248.png
7249	Sevenoaks Town	\N	England	https://media.api-sports.io/football/teams/7249.png
7250	Sittingbourne	\N	England	https://media.api-sports.io/football/teams/7250.png
7251	South Park	\N	England	https://media.api-sports.io/football/teams/7251.png
7252	Stocksbridge Park Steels	STO	England	https://media.api-sports.io/football/teams/7252.png
7253	Sutton Coldfield Town	\N	England	https://media.api-sports.io/football/teams/7253.png
7254	Thatcham Town	\N	England	https://media.api-sports.io/football/teams/7254.png
7255	Tilbury	\N	England	https://media.api-sports.io/football/teams/7255.png
7256	Tooting & Mitcham United	\N	England	https://media.api-sports.io/football/teams/7256.png
7257	Uxbridge	\N	England	https://media.api-sports.io/football/teams/7257.png
7258	VCD Athletic	\N	England	https://media.api-sports.io/football/teams/7258.png
7259	Waltham Abbey	\N	England	https://media.api-sports.io/football/teams/7259.png
7260	Wantage Town	\N	England	https://media.api-sports.io/football/teams/7260.png
7261	Westfield (Surrey)	\N	England	https://media.api-sports.io/football/teams/7261.png
7262	Whyteleafe	\N	England	https://media.api-sports.io/football/teams/7262.png
7263	Willand Rovers	\N	England	https://media.api-sports.io/football/teams/7263.png
7264	Witham Town	\N	England	https://media.api-sports.io/football/teams/7264.png
7265	Workington	WOR	England	https://media.api-sports.io/football/teams/7265.png
7266	Worksop Town	\N	England	https://media.api-sports.io/football/teams/7266.png
7267	Yaxley	\N	England	https://media.api-sports.io/football/teams/7267.png
7610	AFC Dunstable	\N	England	https://media.api-sports.io/football/teams/7610.png
7611	AFC Kempston Rovers	\N	England	https://media.api-sports.io/football/teams/7611.png
7612	AFC Totton	AFC	England	https://media.api-sports.io/football/teams/7612.png
7613	Ashford Town (Middlesex)	\N	England	https://media.api-sports.io/football/teams/7613.png
7614	Barton Rovers	\N	England	https://media.api-sports.io/football/teams/7614.png
7615	Basingstoke Town	BAS	England	https://media.api-sports.io/football/teams/7615.png
7616	Bedford Town	BED	England	https://media.api-sports.io/football/teams/7616.png
7617	Belper Town	\N	England	https://media.api-sports.io/football/teams/7617.png
7618	Biggleswade	\N	England	https://media.api-sports.io/football/teams/7618.png
7619	Bracknell Town	\N	England	https://media.api-sports.io/football/teams/7619.png
7620	Brighouse Town	\N	England	https://media.api-sports.io/football/teams/7620.png
7621	Bristol Manor Farm	\N	England	https://media.api-sports.io/football/teams/7621.png
7622	Bury Town	BUR	England	https://media.api-sports.io/football/teams/7622.png
7623	Canvey Island	CAN	England	https://media.api-sports.io/football/teams/7623.png
7624	Carlton Town	\N	England	https://media.api-sports.io/football/teams/7624.png
7625	Chalfont St Peter	\N	England	https://media.api-sports.io/football/teams/7625.png
7626	Chasetown	\N	England	https://media.api-sports.io/football/teams/7626.png
7627	Chertsey Town	\N	England	https://media.api-sports.io/football/teams/7627.png
7628	Chichester City	\N	England	https://media.api-sports.io/football/teams/7628.png
7629	Cirencester Town	\N	England	https://media.api-sports.io/football/teams/7629.png
7630	City of Liverpool	\N	England	https://media.api-sports.io/football/teams/7630.png
7631	Cleethorpes Town	\N	England	https://media.api-sports.io/football/teams/7631.png
7632	Clitheroe	\N	England	https://media.api-sports.io/football/teams/7632.png
7633	Coggeshall Town	\N	England	https://media.api-sports.io/football/teams/7633.png
7634	Coleshill Town	\N	England	https://media.api-sports.io/football/teams/7634.png
7635	Colne	\N	England	https://media.api-sports.io/football/teams/7635.png
7636	Cray Valley PM	CRA	England	https://media.api-sports.io/football/teams/7636.png
7637	Daventry Town	DAV	England	https://media.api-sports.io/football/teams/7637.png
7638	Dereham Town	\N	England	https://media.api-sports.io/football/teams/7638.png
7639	Dunston UTS	\N	England	https://media.api-sports.io/football/teams/7639.png
7640	Evesham United	\N	England	https://media.api-sports.io/football/teams/7640.png
7641	Faversham Town	\N	England	https://media.api-sports.io/football/teams/7641.png
7642	Felixstowe & Walton Utd	\N	England	https://media.api-sports.io/football/teams/7642.png
7643	Frickley Athletic	FRI	England	https://media.api-sports.io/football/teams/7643.png
7644	Halesowen Town	\N	England	https://media.api-sports.io/football/teams/7644.png
7645	Hanwell Town	\N	England	https://media.api-sports.io/football/teams/7645.png
7646	Harlow Town	\N	England	https://media.api-sports.io/football/teams/7646.png
7647	Haywards Heath Town	\N	England	https://media.api-sports.io/football/teams/7647.png
7648	Hertford Town	\N	England	https://media.api-sports.io/football/teams/7648.png
7649	Hullbridge Sports	\N	England	https://media.api-sports.io/football/teams/7649.png
6	Brazil	BRA	Brazil	https://media.api-sports.io/football/teams/6.png
7650	Kidlington	\N	England	https://media.api-sports.io/football/teams/7650.png
7651	Kidsgrove Athletic	KID	England	https://media.api-sports.io/football/teams/7651.png
7652	Lincoln United	\N	England	https://media.api-sports.io/football/teams/7652.png
7653	Loughborough Dynamo	\N	England	https://media.api-sports.io/football/teams/7653.png
7654	Maldon & Tiptree	\N	England	https://media.api-sports.io/football/teams/7654.png
7655	Mangotsfield United	MAN	England	https://media.api-sports.io/football/teams/7655.png
7656	Marine	MAR	England	https://media.api-sports.io/football/teams/7656.png
7657	Marlow	\N	England	https://media.api-sports.io/football/teams/7657.png
7658	Marske United	MAR	England	https://media.api-sports.io/football/teams/7658.png
7659	Moneyfields	\N	England	https://media.api-sports.io/football/teams/7659.png
7660	Mossley	MOS	England	https://media.api-sports.io/football/teams/7660.png
7661	North Leigh	\N	England	https://media.api-sports.io/football/teams/7661.png
7662	Ossett United	\N	England	https://media.api-sports.io/football/teams/7662.png
7663	Prescot Cables	\N	England	https://media.api-sports.io/football/teams/7663.png
7664	Ramsbottom United	RAM	England	https://media.api-sports.io/football/teams/7664.png
7665	Ramsgate	\N	England	https://media.api-sports.io/football/teams/7665.png
7666	Runcorn Linnets	\N	England	https://media.api-sports.io/football/teams/7666.png
7667	Sheffield	SHE	England	https://media.api-sports.io/football/teams/7667.png
7668	Sholing	\N	England	https://media.api-sports.io/football/teams/7668.png
7669	Slimbridge	\N	England	https://media.api-sports.io/football/teams/7669.png
7670	Soham Town Rangers	SOH	England	https://media.api-sports.io/football/teams/7670.png
7671	Spalding United	\N	England	https://media.api-sports.io/football/teams/7671.png
7672	St Neots Town	NEO	England	https://media.api-sports.io/football/teams/7672.png
7673	Staines Town	STA	England	https://media.api-sports.io/football/teams/7673.png
7674	Tadcaster Albion	\N	England	https://media.api-sports.io/football/teams/7674.png
7675	Thame United	\N	England	https://media.api-sports.io/football/teams/7675.png
7676	Three Bridges	\N	England	https://media.api-sports.io/football/teams/7676.png
7677	Trafford	TRA	England	https://media.api-sports.io/football/teams/7677.png
7678	Ware	\N	England	https://media.api-sports.io/football/teams/7678.png
7679	Welwyn Garden City	\N	England	https://media.api-sports.io/football/teams/7679.png
7680	Whitstable Town	WHI	England	https://media.api-sports.io/football/teams/7680.png
7681	Widnes	\N	England	https://media.api-sports.io/football/teams/7681.png
7682	Winchester City	\N	England	https://media.api-sports.io/football/teams/7682.png
7683	Wisbech Town	\N	England	https://media.api-sports.io/football/teams/7683.png
7690	AFC Hornchurch	HOR	England	https://media.api-sports.io/football/teams/7690.png
7691	AFC Rushden & Diamonds	\N	England	https://media.api-sports.io/football/teams/7691.png
7692	Alvechurch	\N	England	https://media.api-sports.io/football/teams/7692.png
7693	Ashton United	\N	England	https://media.api-sports.io/football/teams/7693.png
7694	Atherton Collieries	\N	England	https://media.api-sports.io/football/teams/7694.png
7695	Bamber Bridge	\N	England	https://media.api-sports.io/football/teams/7695.png
7696	Banbury United	BAN	England	https://media.api-sports.io/football/teams/7696.png
7697	Barwell	BRW	England	https://media.api-sports.io/football/teams/7697.png
7698	Basford United	\N	England	https://media.api-sports.io/football/teams/7698.png
7699	Beaconsfield Town	\N	England	https://media.api-sports.io/football/teams/7699.png
7700	Biggleswade Town	BIG	England	https://media.api-sports.io/football/teams/7700.png
7701	Bishop's Stortford	BIS	England	https://media.api-sports.io/football/teams/7701.png
7702	Blackfield & Langley	\N	England	https://media.api-sports.io/football/teams/7702.png
7703	Bognor Regis Town	BOG	England	https://media.api-sports.io/football/teams/7703.png
7704	Brightlingsea Regent	\N	England	https://media.api-sports.io/football/teams/7704.png
7705	Bromsgrove Sporting	\N	England	https://media.api-sports.io/football/teams/7705.png
7706	Buxton	BUX	England	https://media.api-sports.io/football/teams/7706.png
7707	Carshalton Athletic	CAR	England	https://media.api-sports.io/football/teams/7707.png
7708	Cheshunt	\N	England	https://media.api-sports.io/football/teams/7708.png
7709	Coalville Town	COA	England	https://media.api-sports.io/football/teams/7709.png
7710	Corinthian-Casuals	\N	England	https://media.api-sports.io/football/teams/7710.png
7711	Cray Wanderers	\N	England	https://media.api-sports.io/football/teams/7711.png
7712	Dorchester Town	DOR	England	https://media.api-sports.io/football/teams/7712.png
7713	East Thurrock United	EAS	England	https://media.api-sports.io/football/teams/7713.png
7714	Enfield Town	ENF	England	https://media.api-sports.io/football/teams/7714.png
7715	Farnborough	FAR	England	https://media.api-sports.io/football/teams/7715.png
7716	Folkestone Invicta	FOL	England	https://media.api-sports.io/football/teams/7716.png
7717	Gosport Borough	GOS	England	https://media.api-sports.io/football/teams/7717.png
7718	Grantham Town	GRA	England	https://media.api-sports.io/football/teams/7718.png
7719	Hartley Wintney	HAR	England	https://media.api-sports.io/football/teams/7719.png
7720	Hayes & Yeading United	HAY	England	https://media.api-sports.io/football/teams/7720.png
7721	Hednesford Town	HED	England	https://media.api-sports.io/football/teams/7721.png
7722	Hendon	HEN	England	https://media.api-sports.io/football/teams/7722.png
7723	Horsham	\N	England	https://media.api-sports.io/football/teams/7723.png
7724	Kings Langley	\N	England	https://media.api-sports.io/football/teams/7724.png
7725	Kingstonian	KIN	England	https://media.api-sports.io/football/teams/7725.png
7726	Lancaster City	\N	England	https://media.api-sports.io/football/teams/7726.png
7727	Leiston	LEI	England	https://media.api-sports.io/football/teams/7727.png
7728	Lewes	LEW	England	https://media.api-sports.io/football/teams/7728.png
7729	Lowestoft Town	LOW	England	https://media.api-sports.io/football/teams/7729.png
7730	Margate	MAR	England	https://media.api-sports.io/football/teams/7730.png
7731	Matlock Town	MAT	England	https://media.api-sports.io/football/teams/7731.png
7733	Mickleover Sports	\N	England	https://media.api-sports.io/football/teams/7733.png
7734	Morpeth Town	\N	England	https://media.api-sports.io/football/teams/7734.png
7735	Needham Market	\N	England	https://media.api-sports.io/football/teams/7735.png
7736	Nuneaton Borough	\N	England	https://media.api-sports.io/football/teams/7736.png
7737	Peterborough Sports	\N	England	https://media.api-sports.io/football/teams/7737.png
7738	Poole Town	POO	England	https://media.api-sports.io/football/teams/7738.png
7739	Potters Bar Town	\N	England	https://media.api-sports.io/football/teams/7739.png
7740	Radcliffe	\N	England	https://media.api-sports.io/football/teams/7740.png
7741	Redditch United	RED	England	https://media.api-sports.io/football/teams/7741.png
7742	Royston Town	\N	England	https://media.api-sports.io/football/teams/7742.png
7743	Rushall Olympic	RUS	England	https://media.api-sports.io/football/teams/7743.png
7744	Salisbury	\N	England	https://media.api-sports.io/football/teams/7744.png
7745	Scarborough Athletic	SCA	England	https://media.api-sports.io/football/teams/7745.png
7746	South Shields	\N	England	https://media.api-sports.io/football/teams/7746.png
7747	St Ives Town	IVE	England	https://media.api-sports.io/football/teams/7747.png
7748	Stafford Rangers	STA	England	https://media.api-sports.io/football/teams/7748.png
7749	Stalybridge Celtic	STA	England	https://media.api-sports.io/football/teams/7749.png
7750	Stratford Town	\N	England	https://media.api-sports.io/football/teams/7750.png
7751	Swindon Supermarine	\N	England	https://media.api-sports.io/football/teams/7751.png
7752	Tamworth	TAM	England	https://media.api-sports.io/football/teams/7752.png
7753	Tiverton Town	TIV	England	https://media.api-sports.io/football/teams/7753.png
7754	United of Manchester	UNI	England	https://media.api-sports.io/football/teams/7754.png
7755	Walton Casuals	\N	England	https://media.api-sports.io/football/teams/7755.png
7756	Warrington Town	\N	England	https://media.api-sports.io/football/teams/7756.png
7757	Whitby Town	WHI	England	https://media.api-sports.io/football/teams/7757.png
7758	Wimborne Town	\N	England	https://media.api-sports.io/football/teams/7758.png
7759	Wingate & Finchley	WIN	England	https://media.api-sports.io/football/teams/7759.png
7760	Witton Albion	WIT	England	https://media.api-sports.io/football/teams/7760.png
7761	Worthing	\N	England	https://media.api-sports.io/football/teams/7761.png
7762	Yate Town	\N	England	https://media.api-sports.io/football/teams/7762.png
7764	Bowers & Pitsea	\N	England	https://media.api-sports.io/football/teams/7764.png
7892	Chelsea U19	CHE	England	https://media.api-sports.io/football/teams/7892.png
7895	Derby County U19	\N	England	https://media.api-sports.io/football/teams/7895.png
7909	Liverpool U19	\N	England	https://media.api-sports.io/football/teams/7909.png
7914	Manchester City U19	MAC	England	https://media.api-sports.io/football/teams/7914.png
7937	Tottenham Hotspur U19	\N	England	https://media.api-sports.io/football/teams/7937.png
7960	Manchester United U19	MUN	England	https://media.api-sports.io/football/teams/7960.png
8146	Boston United	BOS	England	https://media.api-sports.io/football/teams/8146.png
8147	Chippenham Town	CHI	England	https://media.api-sports.io/football/teams/8147.png
8148	Darlington	\N	England	https://media.api-sports.io/football/teams/8148.png
8149	Dulwich Hamlet	DUL	England	https://media.api-sports.io/football/teams/8149.png
8190	England U21	ENG	England	https://media.api-sports.io/football/teams/8190.png
8650	Blyth Spartans	BLY	England	https://media.api-sports.io/football/teams/8650.png
8651	Bradford (Park Avenue)	BRA	England	https://media.api-sports.io/football/teams/8651.png
8652	Farsley Celtic	\N	England	https://media.api-sports.io/football/teams/8652.png
8653	Gloucester City	GLO	England	https://media.api-sports.io/football/teams/8653.png
8654	Kettering Town	\N	England	https://media.api-sports.io/football/teams/8654.png
8655	King's Lynn Town	KIN	England	https://media.api-sports.io/football/teams/8655.png
8656	Leamington	LEA	England	https://media.api-sports.io/football/teams/8656.png
8657	Bath City	BAT	England	https://media.api-sports.io/football/teams/8657.png
8658	Concord Rangers	CON	England	https://media.api-sports.io/football/teams/8658.png
8659	Dorking Wanderers	\N	England	https://media.api-sports.io/football/teams/8659.png
8660	Hemel Hempstead Town	HEM	England	https://media.api-sports.io/football/teams/8660.png
8661	Hungerford Town	HUN	England	https://media.api-sports.io/football/teams/8661.png
8662	Tonbridge Angels	TON	England	https://media.api-sports.io/football/teams/8662.png
8663	Wealdstone	WEA	England	https://media.api-sports.io/football/teams/8663.png
8664	Welling United	WEL	England	https://media.api-sports.io/football/teams/8664.png
8665	Weymouth	WEY	England	https://media.api-sports.io/football/teams/8665.png
8666	1874 Northwich	\N	England	https://media.api-sports.io/football/teams/8666.png
8667	AFC Croydon Athletic	\N	England	https://media.api-sports.io/football/teams/8667.png
8668	AFC Hayes	\N	England	https://media.api-sports.io/football/teams/8668.png
8669	AFC Liverpool	\N	England	https://media.api-sports.io/football/teams/8669.png
8670	AFC Mansfield	\N	England	https://media.api-sports.io/football/teams/8670.png
8671	AFC Portchester	\N	England	https://media.api-sports.io/football/teams/8671.png
8672	AFC Stoneham	\N	England	https://media.api-sports.io/football/teams/8672.png
8673	AFC Wulfrunians	\N	England	https://media.api-sports.io/football/teams/8673.png
8674	Abbey Hey	\N	England	https://media.api-sports.io/football/teams/8674.png
8675	Abbey Rangers	\N	England	https://media.api-sports.io/football/teams/8675.png
8676	Abingdon United	\N	England	https://media.api-sports.io/football/teams/8676.png
8677	Albion Sports	\N	England	https://media.api-sports.io/football/teams/8677.png
8678	Alresford Town	\N	England	https://media.api-sports.io/football/teams/8678.png
8679	Amesbury Town	\N	England	https://media.api-sports.io/football/teams/8679.png
8680	Andover New Street	\N	England	https://media.api-sports.io/football/teams/8680.png
8681	Anstey Nomads	\N	England	https://media.api-sports.io/football/teams/8681.png
8682	Ardley United	\N	England	https://media.api-sports.io/football/teams/8682.png
8683	Arlesey Town	ARL	England	https://media.api-sports.io/football/teams/8683.png
8684	Arundel	\N	England	https://media.api-sports.io/football/teams/8684.png
8685	Ascot United	\N	England	https://media.api-sports.io/football/teams/8685.png
8686	Ashington AFC	\N	England	https://media.api-sports.io/football/teams/8686.png
8687	Ashton Athletic	ASH	England	https://media.api-sports.io/football/teams/8687.png
8688	Athersley Recreation	\N	England	https://media.api-sports.io/football/teams/8688.png
8689	Atherstone Town	\N	England	https://media.api-sports.io/football/teams/8689.png
8690	Avro	\N	England	https://media.api-sports.io/football/teams/8690.png
8691	Aylesbury Vale Dynamos	\N	England	https://media.api-sports.io/football/teams/8691.png
8692	Badshot Lea	\N	England	https://media.api-sports.io/football/teams/8692.png
8693	Baffins Milton Rovers	\N	England	https://media.api-sports.io/football/teams/8693.png
8694	Baldock Town	\N	England	https://media.api-sports.io/football/teams/8694.png
8695	Balham	\N	England	https://media.api-sports.io/football/teams/8695.png
8696	Banstead Athletic	\N	England	https://media.api-sports.io/football/teams/8696.png
8697	Barkingside	\N	England	https://media.api-sports.io/football/teams/8697.png
8698	Barnoldswick Town	\N	England	https://media.api-sports.io/football/teams/8698.png
8699	Barton Town Old Boys	\N	England	https://media.api-sports.io/football/teams/8699.png
8700	Bashley	BAS	England	https://media.api-sports.io/football/teams/8700.png
8701	Bearsted	\N	England	https://media.api-sports.io/football/teams/8701.png
8702	Beckenham Town	\N	England	https://media.api-sports.io/football/teams/8702.png
8703	Bemerton Heath Harleq.	\N	England	https://media.api-sports.io/football/teams/8703.png
8704	Bexhill United	\N	England	https://media.api-sports.io/football/teams/8704.png
8705	Biggleswade United	\N	England	https://media.api-sports.io/football/teams/8705.png
8706	Billingham Town	\N	England	https://media.api-sports.io/football/teams/8706.png
8707	Binfield	\N	England	https://media.api-sports.io/football/teams/8707.png
8708	Bishop Auckland	\N	England	https://media.api-sports.io/football/teams/8708.png
8709	Bishop's Cleeve	\N	England	https://media.api-sports.io/football/teams/8709.png
8710	Bitton	\N	England	https://media.api-sports.io/football/teams/8710.png
8711	Boldmere St. Michaels	\N	England	https://media.api-sports.io/football/teams/8711.png
8712	Bootle	\N	England	https://media.api-sports.io/football/teams/8712.png
8713	Bottesford Town	\N	England	https://media.api-sports.io/football/teams/8713.png
8714	Bournemouth FC	\N	England	https://media.api-sports.io/football/teams/8714.png
8715	Brackley Town Saints	\N	England	https://media.api-sports.io/football/teams/8715.png
8716	Bradford Town	\N	England	https://media.api-sports.io/football/teams/8716.png
8717	Brantham Athletic	\N	England	https://media.api-sports.io/football/teams/8717.png
8718	Bridgwater Town	\N	England	https://media.api-sports.io/football/teams/8718.png
8719	Bridlington Town	\N	England	https://media.api-sports.io/football/teams/8719.png
8720	Bridon Ropes	\N	England	https://media.api-sports.io/football/teams/8720.png
8721	Bridport	\N	England	https://media.api-sports.io/football/teams/8721.png
8722	Brimscombe & Thrupp	\N	England	https://media.api-sports.io/football/teams/8722.png
8723	Brislington	BRI	England	https://media.api-sports.io/football/teams/8723.png
8724	Broadbridge Heath	\N	England	https://media.api-sports.io/football/teams/8724.png
8725	Broadfields United	\N	England	https://media.api-sports.io/football/teams/8725.png
8726	Brockenhurst	\N	England	https://media.api-sports.io/football/teams/8726.png
8727	Buckland Athletic	\N	England	https://media.api-sports.io/football/teams/8727.png
8728	Bugbrooke St Michaels	\N	England	https://media.api-sports.io/football/teams/8728.png
8729	Burnham	BUR	England	https://media.api-sports.io/football/teams/8729.png
8730	Burscough	\N	England	https://media.api-sports.io/football/teams/8730.png
8731	CB Hounslow United	\N	England	https://media.api-sports.io/football/teams/8731.png
8732	Cadbury Heath	\N	England	https://media.api-sports.io/football/teams/8732.png
8733	Camberley Town	\N	England	https://media.api-sports.io/football/teams/8733.png
8734	Campion	\N	England	https://media.api-sports.io/football/teams/8734.png
8735	Canterbury City	CAN	England	https://media.api-sports.io/football/teams/8735.png
8736	Charnock Richard	\N	England	https://media.api-sports.io/football/teams/8736.png
8737	Chatham Town	CHA	England	https://media.api-sports.io/football/teams/8737.png
8738	Cheddar	\N	England	https://media.api-sports.io/football/teams/8738.png
8739	Cheltenham Saracens	\N	England	https://media.api-sports.io/football/teams/8739.png
8740	Chipping Sodbury Town	\N	England	https://media.api-sports.io/football/teams/8740.png
8741	Christchurch	\N	England	https://media.api-sports.io/football/teams/8741.png
8742	Clacton	\N	England	https://media.api-sports.io/football/teams/8742.png
8743	Clanfield 85	\N	England	https://media.api-sports.io/football/teams/8743.png
8744	Clapton	\N	England	https://media.api-sports.io/football/teams/8744.png
8745	Clevedon Town	CLE	England	https://media.api-sports.io/football/teams/8745.png
8746	Cobham	\N	England	https://media.api-sports.io/football/teams/8746.png
8747	Cockfosters	\N	England	https://media.api-sports.io/football/teams/8747.png
8748	Coggeshall United	\N	England	https://media.api-sports.io/football/teams/8748.png
8749	Colliers Wood United	\N	England	https://media.api-sports.io/football/teams/8749.png
8750	Colney Heath	\N	England	https://media.api-sports.io/football/teams/8750.png
8751	Congleton Town	\N	England	https://media.api-sports.io/football/teams/8751.png
8752	Consett	\N	England	https://media.api-sports.io/football/teams/8752.png
8753	Corinthian	\N	England	https://media.api-sports.io/football/teams/8753.png
8754	Coventry Sphinx	\N	England	https://media.api-sports.io/football/teams/8754.png
8755	Coventry United	\N	England	https://media.api-sports.io/football/teams/8755.png
8756	Cowes Sports	\N	England	https://media.api-sports.io/football/teams/8756.png
8757	Crawley Down Gatwick	\N	England	https://media.api-sports.io/football/teams/8757.png
8758	Crawley Green	\N	England	https://media.api-sports.io/football/teams/8758.png
8759	Cribbs	\N	England	https://media.api-sports.io/football/teams/8759.png
8760	Crowborough Athletic	\N	England	https://media.api-sports.io/football/teams/8760.png
8761	Croydon	\N	England	https://media.api-sports.io/football/teams/8761.png
8762	Deal Town	\N	England	https://media.api-sports.io/football/teams/8762.png
8763	Deeping Rangers	\N	England	https://media.api-sports.io/football/teams/8763.png
8764	Desborough Town	\N	England	https://media.api-sports.io/football/teams/8764.png
8765	Dunkirk	\N	England	https://media.api-sports.io/football/teams/8765.png
8766	Dunstable Town	DUN	England	https://media.api-sports.io/football/teams/8766.png
8767	Easington Sports	\N	England	https://media.api-sports.io/football/teams/8767.png
8768	East Preston	\N	England	https://media.api-sports.io/football/teams/8768.png
8769	Eastbourne Town	\N	England	https://media.api-sports.io/football/teams/8769.png
8770	Eastbourne United	\N	England	https://media.api-sports.io/football/teams/8770.png
8771	Eccleshill United	\N	England	https://media.api-sports.io/football/teams/8771.png
8772	Edgware Town	\N	England	https://media.api-sports.io/football/teams/8772.png
8773	Egham Town	EGH	England	https://media.api-sports.io/football/teams/8773.png
8774	Ely City	\N	England	https://media.api-sports.io/football/teams/8774.png
8775	Enfield 1893	\N	England	https://media.api-sports.io/football/teams/8775.png
8776	Erith & Belvedere	\N	England	https://media.api-sports.io/football/teams/8776.png
8777	Erith Town	\N	England	https://media.api-sports.io/football/teams/8777.png
8778	Exmouth	\N	England	https://media.api-sports.io/football/teams/8778.png
8779	Eynesbury Rovers	\N	England	https://media.api-sports.io/football/teams/8779.png
8780	Fairford Town	\N	England	https://media.api-sports.io/football/teams/8780.png
8781	Fakenham Town	\N	England	https://media.api-sports.io/football/teams/8781.png
8782	Fareham Town	\N	England	https://media.api-sports.io/football/teams/8782.png
8783	Farnham Town	\N	England	https://media.api-sports.io/football/teams/8783.png
8784	Fisher	\N	England	https://media.api-sports.io/football/teams/8784.png
8785	Flackwell Heath	\N	England	https://media.api-sports.io/football/teams/8785.png
8786	Fleet Town	\N	England	https://media.api-sports.io/football/teams/8786.png
8787	Framlingham Town	\N	England	https://media.api-sports.io/football/teams/8787.png
8788	Frimley Green	\N	England	https://media.api-sports.io/football/teams/8788.png
8789	Garforth Town	\N	England	https://media.api-sports.io/football/teams/8789.png
8790	Glebe	\N	England	https://media.api-sports.io/football/teams/8790.png
8791	Godmanchester Rovers	\N	England	https://media.api-sports.io/football/teams/8791.png
8792	Goole	\N	England	https://media.api-sports.io/football/teams/8792.png
8793	Gorleston	\N	England	https://media.api-sports.io/football/teams/8793.png
8794	Great Yarmouth Town	\N	England	https://media.api-sports.io/football/teams/8794.png
8795	Greenwich Borough	\N	England	https://media.api-sports.io/football/teams/8795.png
8796	Gresley	\N	England	https://media.api-sports.io/football/teams/8796.png
8797	Grimsby Borough	\N	England	https://media.api-sports.io/football/teams/8797.png
8798	Guildford City	\N	England	https://media.api-sports.io/football/teams/8798.png
8799	Guisborough Town	\N	England	https://media.api-sports.io/football/teams/8799.png
8800	Hackney Wick	\N	England	https://media.api-sports.io/football/teams/8800.png
8801	Hadleigh United	\N	England	https://media.api-sports.io/football/teams/8801.png
8802	Hadley	\N	England	https://media.api-sports.io/football/teams/8802.png
8803	Hall Road Rangers	\N	England	https://media.api-sports.io/football/teams/8803.png
8804	Hallam	\N	England	https://media.api-sports.io/football/teams/8804.png
8805	Hallen	\N	England	https://media.api-sports.io/football/teams/8805.png
8806	Halstead Town	\N	England	https://media.api-sports.io/football/teams/8806.png
8807	Hamble Club	\N	England	https://media.api-sports.io/football/teams/8807.png
8808	Hamworthy United	\N	England	https://media.api-sports.io/football/teams/8808.png
8809	Handsworth Parramore	\N	England	https://media.api-sports.io/football/teams/8809.png
8810	Hanley Town	\N	England	https://media.api-sports.io/football/teams/8810.png
8811	Hanworth Villa	\N	England	https://media.api-sports.io/football/teams/8811.png
8812	Harborough Town	\N	England	https://media.api-sports.io/football/teams/8812.png
8813	Harefield United	\N	England	https://media.api-sports.io/football/teams/8813.png
8814	Harpenden Town	\N	England	https://media.api-sports.io/football/teams/8814.png
8815	Harrogate Railway	\N	England	https://media.api-sports.io/football/teams/8815.png
8816	Harwich & Parkeston	\N	England	https://media.api-sports.io/football/teams/8816.png
8817	Hassocks	\N	England	https://media.api-sports.io/football/teams/8817.png
8818	Haughmond	\N	England	https://media.api-sports.io/football/teams/8818.png
8819	Haverhill Rovers	\N	England	https://media.api-sports.io/football/teams/8819.png
8820	Heanor Town	\N	England	https://media.api-sports.io/football/teams/8820.png
8821	Heather St Johns	\N	England	https://media.api-sports.io/football/teams/8821.png
8822	Hebburn Town	\N	England	https://media.api-sports.io/football/teams/8822.png
8823	Hemsworth MW	\N	England	https://media.api-sports.io/football/teams/8823.png
8824	Hengrove Athletic	\N	England	https://media.api-sports.io/football/teams/8824.png
8826	Hoddesdon Town	\N	England	https://media.api-sports.io/football/teams/8826.png
8827	Holbeach United	\N	England	https://media.api-sports.io/football/teams/8827.png
8828	Hollands & Blair	\N	England	https://media.api-sports.io/football/teams/8828.png
8829	Holmer Green	\N	England	https://media.api-sports.io/football/teams/8829.png
8830	Horley Town	\N	England	https://media.api-sports.io/football/teams/8830.png
8831	Horndean	\N	England	https://media.api-sports.io/football/teams/8831.png
8832	Horsham YMCA	\N	England	https://media.api-sports.io/football/teams/8832.png
8833	Hythe & Dibden	\N	England	https://media.api-sports.io/football/teams/8833.png
8834	Ilford	\N	England	https://media.api-sports.io/football/teams/8834.png
8835	Irlam	\N	England	https://media.api-sports.io/football/teams/8835.png
8836	K Sports	\N	England	https://media.api-sports.io/football/teams/8836.png
8837	Keynsham Town	\N	England	https://media.api-sports.io/football/teams/8837.png
8838	Kirby Muxloe	\N	England	https://media.api-sports.io/football/teams/8838.png
8839	Kirkley & Pakefield	\N	England	https://media.api-sports.io/football/teams/8839.png
8840	Knaphill	\N	England	https://media.api-sports.io/football/teams/8840.png
8841	Knaresborough Town	\N	England	https://media.api-sports.io/football/teams/8841.png
8842	Lancing	\N	England	https://media.api-sports.io/football/teams/8842.png
8843	Langney Wanderers	\N	England	https://media.api-sports.io/football/teams/8843.png
8844	Leicester Nirvana	\N	England	https://media.api-sports.io/football/teams/8844.png
8845	Leicester Road	\N	England	https://media.api-sports.io/football/teams/8845.png
8846	Leighton Town	\N	England	https://media.api-sports.io/football/teams/8846.png
8847	Leverstock Green	\N	England	https://media.api-sports.io/football/teams/8847.png
8848	Leyton Athletic	\N	England	https://media.api-sports.io/football/teams/8848.png
8849	Lichfield City	\N	England	https://media.api-sports.io/football/teams/8849.png
8850	Lingfield	\N	England	https://media.api-sports.io/football/teams/8850.png
8851	Litherland Remyca	\N	England	https://media.api-sports.io/football/teams/8851.png
8852	Little Common	\N	England	https://media.api-sports.io/football/teams/8852.png
8853	Liversedge	\N	England	https://media.api-sports.io/football/teams/8853.png
8854	London Colney	\N	England	https://media.api-sports.io/football/teams/8854.png
8855	London Tigers	\N	England	https://media.api-sports.io/football/teams/8855.png
8856	Long Eaton United	\N	England	https://media.api-sports.io/football/teams/8856.png
8857	Long Melford	\N	England	https://media.api-sports.io/football/teams/8857.png
8858	Longlevens	\N	England	https://media.api-sports.io/football/teams/8858.png
8859	Longridge Town	\N	England	https://media.api-sports.io/football/teams/8859.png
8860	Lordswood	\N	England	https://media.api-sports.io/football/teams/8860.png
8861	Loughborough University	\N	England	https://media.api-sports.io/football/teams/8861.png
8862	Lower Breck	\N	England	https://media.api-sports.io/football/teams/8862.png
8863	Loxwood	\N	England	https://media.api-sports.io/football/teams/8863.png
8864	Lutterworth Town	\N	England	https://media.api-sports.io/football/teams/8864.png
8865	Lydney Town	\N	England	https://media.api-sports.io/football/teams/8865.png
8866	Lye Town	\N	England	https://media.api-sports.io/football/teams/8866.png
8867	Lymington Town	\N	England	https://media.api-sports.io/football/teams/8867.png
8868	Malmesbury Victoria	\N	England	https://media.api-sports.io/football/teams/8868.png
8869	Maltby Main	\N	England	https://media.api-sports.io/football/teams/8869.png
8870	Malvern Town	\N	England	https://media.api-sports.io/football/teams/8870.png
8871	March Town United	\N	England	https://media.api-sports.io/football/teams/8871.png
8872	Melton Town	\N	England	https://media.api-sports.io/football/teams/8872.png
8873	Mildenhall Town	\N	England	https://media.api-sports.io/football/teams/8873.png
8874	Molesey	\N	England	https://media.api-sports.io/football/teams/8874.png
8875	Mulbarton Wanderers	\N	England	https://media.api-sports.io/football/teams/8875.png
8876	Newcastle Benfield	\N	England	https://media.api-sports.io/football/teams/8876.png
8877	Newhaven	\N	England	https://media.api-sports.io/football/teams/8877.png
8878	Newmarket Town	\N	England	https://media.api-sports.io/football/teams/8878.png
8879	Newport Pagnell Town	\N	England	https://media.api-sports.io/football/teams/8879.png
8880	Newton Aycliffe	\N	England	https://media.api-sports.io/football/teams/8880.png
8881	North Greenford United	\N	England	https://media.api-sports.io/football/teams/8881.png
8882	North Shields	\N	England	https://media.api-sports.io/football/teams/8882.png
8883	Northallerton Town	\N	England	https://media.api-sports.io/football/teams/8883.png
8884	Northampton ON Chenecks	\N	England	https://media.api-sports.io/football/teams/8884.png
8885	Northwich Victoria	NOR	England	https://media.api-sports.io/football/teams/8885.png
8886	Norwich CBS	\N	England	https://media.api-sports.io/football/teams/8886.png
8887	Norwich United	\N	England	https://media.api-sports.io/football/teams/8887.png
8888	Nostell MW	\N	England	https://media.api-sports.io/football/teams/8888.png
8889	Oadby Town	\N	England	https://media.api-sports.io/football/teams/8889.png
8890	Odd Down	\N	England	https://media.api-sports.io/football/teams/8890.png
8891	Oxhey Jets	\N	England	https://media.api-sports.io/football/teams/8891.png
8892	Padiham	\N	England	https://media.api-sports.io/football/teams/8892.png
8893	Pagham	\N	England	https://media.api-sports.io/football/teams/8893.png
8894	Peacehaven & Telscombe	\N	England	https://media.api-sports.io/football/teams/8894.png
8895	Penistone Church	\N	England	https://media.api-sports.io/football/teams/8895.png
8896	Penrith AFC	\N	England	https://media.api-sports.io/football/teams/8896.png
8897	Peterborough N Star	\N	England	https://media.api-sports.io/football/teams/8897.png
8898	Pinchbeck United	\N	England	https://media.api-sports.io/football/teams/8898.png
8899	Plymouth Parkway	\N	England	https://media.api-sports.io/football/teams/8899.png
8900	Portland United	\N	England	https://media.api-sports.io/football/teams/8900.png
8901	Potton United	\N	England	https://media.api-sports.io/football/teams/8901.png
8902	Punjab United	\N	England	https://media.api-sports.io/football/teams/8902.png
8903	Quorn	\N	England	https://media.api-sports.io/football/teams/8903.png
8904	Racing Club Warwick	\N	England	https://media.api-sports.io/football/teams/8904.png
8905	Radford	\N	England	https://media.api-sports.io/football/teams/8905.png
8906	Raynes Park Vale	\N	England	https://media.api-sports.io/football/teams/8906.png
8907	Reading City	\N	England	https://media.api-sports.io/football/teams/8907.png
8908	Redbridge	\N	England	https://media.api-sports.io/football/teams/8908.png
8909	Redhill	\N	England	https://media.api-sports.io/football/teams/8909.png
8910	Roman Glass St George	\N	England	https://media.api-sports.io/football/teams/8910.png
8911	Romsey Town	\N	England	https://media.api-sports.io/football/teams/8911.png
8912	Romulus	\N	England	https://media.api-sports.io/football/teams/8912.png
8913	Rothwell Corinthians	\N	England	https://media.api-sports.io/football/teams/8913.png
8914	Royal Wootton	\N	England	https://media.api-sports.io/football/teams/8914.png
8915	Rugby Town	\N	England	https://media.api-sports.io/football/teams/8915.png
8916	Runcorn Town	\N	England	https://media.api-sports.io/football/teams/8916.png
8917	Rusthall	\N	England	https://media.api-sports.io/football/teams/8917.png
8918	Rylands	\N	England	https://media.api-sports.io/football/teams/8918.png
8919	Saffron Walden Town	\N	England	https://media.api-sports.io/football/teams/8919.png
8920	Saltash United	\N	England	https://media.api-sports.io/football/teams/8920.png
8921	Saltdean United	\N	England	https://media.api-sports.io/football/teams/8921.png
8922	Sawbridgeworth Town	\N	England	https://media.api-sports.io/football/teams/8922.png
8923	Seaham Red Star	\N	England	https://media.api-sports.io/football/teams/8923.png
8924	Selsey	\N	England	https://media.api-sports.io/football/teams/8924.png
8925	Selston	\N	England	https://media.api-sports.io/football/teams/8925.png
8926	Shaftesbury Town	\N	England	https://media.api-sports.io/football/teams/8926.png
8927	Sheerwater	\N	England	https://media.api-sports.io/football/teams/8927.png
8928	Sheppey United	\N	England	https://media.api-sports.io/football/teams/8928.png
8929	Shepshed Dynamo	\N	England	https://media.api-sports.io/football/teams/8929.png
8930	Shepton Mallet	\N	England	https://media.api-sports.io/football/teams/8930.png
8931	Sherwood Colliery	\N	England	https://media.api-sports.io/football/teams/8931.png
8932	Shildon AFC	\N	England	https://media.api-sports.io/football/teams/8932.png
8933	Shoreham	\N	England	https://media.api-sports.io/football/teams/8933.png
8934	Shortwood United	SHO	England	https://media.api-sports.io/football/teams/8934.png
8935	Shrivenham	\N	England	https://media.api-sports.io/football/teams/8935.png
8936	Silsden	\N	England	https://media.api-sports.io/football/teams/8936.png
8937	Skelmersdale United	SKE	England	https://media.api-sports.io/football/teams/8937.png
8938	Sleaford Town	\N	England	https://media.api-sports.io/football/teams/8938.png
8939	Solent University	\N	England	https://media.api-sports.io/football/teams/8939.png
8940	South Normanton Athletic	\N	England	https://media.api-sports.io/football/teams/8940.png
8941	Southall	\N	England	https://media.api-sports.io/football/teams/8941.png
8942	Southend Manor	\N	England	https://media.api-sports.io/football/teams/8942.png
8943	Spelthorne Sports	\N	England	https://media.api-sports.io/football/teams/8943.png
8944	Sporting Bengal United	\N	England	https://media.api-sports.io/football/teams/8944.png
8945	Sporting Khalsa	\N	England	https://media.api-sports.io/football/teams/8945.png
8946	Squires Gate	\N	England	https://media.api-sports.io/football/teams/8946.png
8947	St Austell	\N	England	https://media.api-sports.io/football/teams/8947.png
8948	St Margaretsbury	\N	England	https://media.api-sports.io/football/teams/8948.png
8949	Stansted	\N	England	https://media.api-sports.io/football/teams/8949.png
8950	Stanway Rovers	\N	England	https://media.api-sports.io/football/teams/8950.png
8951	Staveley MW	\N	England	https://media.api-sports.io/football/teams/8951.png
8952	Steyning Town	\N	England	https://media.api-sports.io/football/teams/8952.png
8953	Stockton Town	\N	England	https://media.api-sports.io/football/teams/8953.png
8954	Stone Old Alleynians	\N	England	https://media.api-sports.io/football/teams/8954.png
8955	Stotfold	\N	England	https://media.api-sports.io/football/teams/8955.png
8956	Stourport Swifts	\N	England	https://media.api-sports.io/football/teams/8956.png
8957	Stowmarket Town	\N	England	https://media.api-sports.io/football/teams/8957.png
8958	Street	\N	England	https://media.api-sports.io/football/teams/8958.png
8959	Sunderland RCA	\N	England	https://media.api-sports.io/football/teams/8959.png
8960	Sunderland Ryhope CW	\N	England	https://media.api-sports.io/football/teams/8960.png
8961	Sutton Athletic	\N	England	https://media.api-sports.io/football/teams/8961.png
8962	Sutton Common Rovers	\N	England	https://media.api-sports.io/football/teams/8962.png
8963	Swaffham Town	\N	England	https://media.api-sports.io/football/teams/8963.png
8964	Tadley Calleva	\N	England	https://media.api-sports.io/football/teams/8964.png
8965	Takeley	\N	England	https://media.api-sports.io/football/teams/8965.png
8966	Tavistock	\N	England	https://media.api-sports.io/football/teams/8966.png
8967	Thackley	\N	England	https://media.api-sports.io/football/teams/8967.png
8968	Thame Rangers	\N	England	https://media.api-sports.io/football/teams/8968.png
8969	Thetford Town	\N	England	https://media.api-sports.io/football/teams/8969.png
8970	Thornaby	\N	England	https://media.api-sports.io/football/teams/8970.png
8971	Thornbury Town	\N	England	https://media.api-sports.io/football/teams/8971.png
8972	Tividale	\N	England	https://media.api-sports.io/football/teams/8972.png
8973	Tooting Bec	\N	England	https://media.api-sports.io/football/teams/8973.png
8974	Tower Hamlets	\N	England	https://media.api-sports.io/football/teams/8974.png
8975	Tring Athletic	\N	England	https://media.api-sports.io/football/teams/8975.png
8976	Tuffley Rovers	\N	England	https://media.api-sports.io/football/teams/8976.png
8977	Tunbridge Wells	\N	England	https://media.api-sports.io/football/teams/8977.png
8978	Uckfield Town	\N	England	https://media.api-sports.io/football/teams/8978.png
8979	United Services	\N	England	https://media.api-sports.io/football/teams/8979.png
8980	Varndeanians	\N	England	https://media.api-sports.io/football/teams/8980.png
8981	Vauxhall Motors	VAU	England	https://media.api-sports.io/football/teams/8981.png
8982	Virginia Water	\N	England	https://media.api-sports.io/football/teams/8982.png
8983	Walsall Wood	\N	England	https://media.api-sports.io/football/teams/8983.png
8984	Walsham Le Willows	\N	England	https://media.api-sports.io/football/teams/8984.png
8985	Walthamstow	\N	England	https://media.api-sports.io/football/teams/8985.png
8986	Walton & Hersham	\N	England	https://media.api-sports.io/football/teams/8986.png
8987	Wednesfield	\N	England	https://media.api-sports.io/football/teams/8987.png
8988	Welling Town	\N	England	https://media.api-sports.io/football/teams/8988.png
8989	Wellingborough Town	\N	England	https://media.api-sports.io/football/teams/8989.png
8990	Wellington AFC	\N	England	https://media.api-sports.io/football/teams/8990.png
8991	Wembley	\N	England	https://media.api-sports.io/football/teams/8991.png
8992	West Auckland Town	\N	England	https://media.api-sports.io/football/teams/8992.png
8993	West Didsbury & Chorlton	\N	England	https://media.api-sports.io/football/teams/8993.png
8994	West Essex	\N	England	https://media.api-sports.io/football/teams/8994.png
8995	Westbury United	\N	England	https://media.api-sports.io/football/teams/8995.png
8996	Whickham	\N	England	https://media.api-sports.io/football/teams/8996.png
8997	Whitchurch Alport	\N	England	https://media.api-sports.io/football/teams/8997.png
8998	White Ensign	\N	England	https://media.api-sports.io/football/teams/8998.png
8999	Whitley Bay	\N	England	https://media.api-sports.io/football/teams/8999.png
9000	Whitton United	\N	England	https://media.api-sports.io/football/teams/9000.png
9001	Whitworths	\N	England	https://media.api-sports.io/football/teams/9001.png
9002	Windsor	\N	England	https://media.api-sports.io/football/teams/9002.png
9003	Winsford United	\N	England	https://media.api-sports.io/football/teams/9003.png
9004	Winslow United	\N	England	https://media.api-sports.io/football/teams/9004.png
9005	Winterton Rangers	\N	England	https://media.api-sports.io/football/teams/9005.png
9006	Wolverhampton Casuals	\N	England	https://media.api-sports.io/football/teams/9006.png
9007	Wolves Sporting	\N	England	https://media.api-sports.io/football/teams/9007.png
9008	Woodbridge Town	\N	England	https://media.api-sports.io/football/teams/9008.png
9009	Woodford Town	\N	England	https://media.api-sports.io/football/teams/9009.png
9010	Worcester City	WOR	England	https://media.api-sports.io/football/teams/9010.png
9011	Wroxham	\N	England	https://media.api-sports.io/football/teams/9011.png
9012	Yorkshire Amateur	\N	England	https://media.api-sports.io/football/teams/9012.png
10157	Darlington 1883	\N	England	https://media.api-sports.io/football/teams/10157.png
10158	Farsley Celtic FC	\N	England	https://media.api-sports.io/football/teams/10158.png
10159	Nuneaton Town	NUN	England	https://media.api-sports.io/football/teams/10159.png
10174	Great Britain U23	\N	England	https://media.api-sports.io/football/teams/10174.png
10309	England U20	ENG	England	https://media.api-sports.io/football/teams/10309.png
10332	England U19	\N	England	https://media.api-sports.io/football/teams/10332.png
11910	Middlesbrough U21	MID	England	https://media.api-sports.io/football/teams/11910.png
11911	Stoke City U21	STO	England	https://media.api-sports.io/football/teams/11911.png
11912	Swansea City U21	\N	England	https://media.api-sports.io/football/teams/11912.png
11913	West Bromwich Albion U21	WES	England	https://media.api-sports.io/football/teams/11913.png
11914	Reading U21	REA	England	https://media.api-sports.io/football/teams/11914.png
11915	Sunderland U21	SUN	England	https://media.api-sports.io/football/teams/11915.png
11916	Blackburn Rovers U23	\N	England	https://media.api-sports.io/football/teams/11916.png
11917	Brighton U23	\N	England	https://media.api-sports.io/football/teams/11917.png
11918	Chelsea U23	\N	England	https://media.api-sports.io/football/teams/11918.png
11919	Derby County U23	\N	England	https://media.api-sports.io/football/teams/11919.png
11920	Everton U23	\N	England	https://media.api-sports.io/football/teams/11920.png
11921	Leicester City U23	\N	England	https://media.api-sports.io/football/teams/11921.png
11922	Middlesbrough U23	\N	England	https://media.api-sports.io/football/teams/11922.png
11923	Norwich City U23	\N	England	https://media.api-sports.io/football/teams/11923.png
11924	Reading U23	\N	England	https://media.api-sports.io/football/teams/11924.png
11925	Southampton U23	\N	England	https://media.api-sports.io/football/teams/11925.png
11926	Stoke City U23	\N	England	https://media.api-sports.io/football/teams/11926.png
11927	Sunderland U23	\N	England	https://media.api-sports.io/football/teams/11927.png
11928	Swansea City U23	\N	England	https://media.api-sports.io/football/teams/11928.png
11929	West Bromwich Albion U23	\N	England	https://media.api-sports.io/football/teams/11929.png
11930	West Ham United U23	\N	England	https://media.api-sports.io/football/teams/11930.png
11931	Wolves U23	\N	England	https://media.api-sports.io/football/teams/11931.png
11932	Hereford United	HER	England	https://media.api-sports.io/football/teams/11932.png
11933	AFC Blackpool	\N	England	https://media.api-sports.io/football/teams/11933.png
11934	AFC Bridgnorth	\N	England	https://media.api-sports.io/football/teams/11934.png
11935	AFC Darwen	\N	England	https://media.api-sports.io/football/teams/11935.png
11936	AFC Emley	\N	England	https://media.api-sports.io/football/teams/11936.png
11937	Almondsbury UWE	\N	England	https://media.api-sports.io/football/teams/11937.png
11938	Alsager Town	\N	England	https://media.api-sports.io/football/teams/11938.png
11939	Ampthill Town	\N	England	https://media.api-sports.io/football/teams/11939.png
11940	Andover Town	\N	England	https://media.api-sports.io/football/teams/11940.png
11941	Armthorpe Welfare	\N	England	https://media.api-sports.io/football/teams/11941.png
11942	Ashton & Backwell United	\N	England	https://media.api-sports.io/football/teams/11942.png
11943	Aylesbury	\N	England	https://media.api-sports.io/football/teams/11943.png
11944	Bacup Borough	\N	England	https://media.api-sports.io/football/teams/11944.png
11945	Bardon Hill Sports	\N	England	https://media.api-sports.io/football/teams/11945.png
11946	Barrow Town	\N	England	https://media.api-sports.io/football/teams/11946.png
11947	Bedfont & Feltham	\N	England	https://media.api-sports.io/football/teams/11947.png
11948	Bedford	\N	England	https://media.api-sports.io/football/teams/11948.png
11949	Bedlington Terriers FC	\N	England	https://media.api-sports.io/football/teams/11949.png
11950	Billingham Synthonia	\N	England	https://media.api-sports.io/football/teams/11950.png
11951	Bishop Sutton	\N	England	https://media.api-sports.io/football/teams/11951.png
11952	Blaby & Whetstone	\N	England	https://media.api-sports.io/football/teams/11952.png
11953	Bodmin Town	\N	England	https://media.api-sports.io/football/teams/11953.png
11954	Bolehall Swifts	\N	England	https://media.api-sports.io/football/teams/11954.png
11955	Brigg Town	BRG	England	https://media.api-sports.io/football/teams/11955.png
11956	Brocton	\N	England	https://media.api-sports.io/football/teams/11956.png
11957	Broxbourne Borough	\N	England	https://media.api-sports.io/football/teams/11957.png
11958	Burnham Ramblers	\N	England	https://media.api-sports.io/football/teams/11958.png
11959	Cadbury Athletic	\N	England	https://media.api-sports.io/football/teams/11959.png
11960	Chadderton	\N	England	https://media.api-sports.io/football/teams/11960.png
11961	Chessington & Hook Utd.	\N	England	https://media.api-sports.io/football/teams/11961.png
11962	Chinnor	\N	England	https://media.api-sports.io/football/teams/11962.png
11963	Clipstone	\N	England	https://media.api-sports.io/football/teams/11963.png
11964	Codicote	\N	England	https://media.api-sports.io/football/teams/11964.png
11965	Cogenhoe United	\N	England	https://media.api-sports.io/football/teams/11965.png
11966	Continental Star	\N	England	https://media.api-sports.io/football/teams/11966.png
11967	Cove	\N	England	https://media.api-sports.io/football/teams/11967.png
11968	Crook Town AFC	\N	England	https://media.api-sports.io/football/teams/11968.png
11969	Debenham LC	\N	England	https://media.api-sports.io/football/teams/11969.png
11970	Diss Town	\N	England	https://media.api-sports.io/football/teams/11970.png
11971	Durham City	\N	England	https://media.api-sports.io/football/teams/11971.png
11972	Ellesmere Rangers	\N	England	https://media.api-sports.io/football/teams/11972.png
11973	Ellistown & Ibstock Utd.	\N	England	https://media.api-sports.io/football/teams/11973.png
11974	Epsom & Ewell FC	\N	England	https://media.api-sports.io/football/teams/11974.png
11975	Eton Manor	\N	England	https://media.api-sports.io/football/teams/11975.png
11976	Fawley	\N	England	https://media.api-sports.io/football/teams/11976.png
11977	Folland Sports	\N	England	https://media.api-sports.io/football/teams/11977.png
11978	Gillingham Town	\N	England	https://media.api-sports.io/football/teams/11978.png
11979	Glasshoughton Welfare	\N	England	https://media.api-sports.io/football/teams/11979.png
11980	Godalming Town	\N	England	https://media.api-sports.io/football/teams/11980.png
11981	Gornal Athletic	\N	England	https://media.api-sports.io/football/teams/11981.png
11982	Hailsham Town	\N	England	https://media.api-sports.io/football/teams/11982.png
11983	Harrowby United	\N	England	https://media.api-sports.io/football/teams/11983.png
11984	Haverhill Borough	\N	England	https://media.api-sports.io/football/teams/11984.png
11985	Heath Hayes	\N	England	https://media.api-sports.io/football/teams/11985.png
11986	Heaton Stannington	\N	England	https://media.api-sports.io/football/teams/11986.png
11987	Highmoor Ibis	\N	England	https://media.api-sports.io/football/teams/11987.png
11988	Hillingdon Borough	\N	England	https://media.api-sports.io/football/teams/11988.png
11989	Hinckley AFC	\N	England	https://media.api-sports.io/football/teams/11989.png
11990	Holker Old Boys	\N	England	https://media.api-sports.io/football/teams/11990.png
11991	Holmesdale	\N	England	https://media.api-sports.io/football/teams/11991.png
11992	Holwell Sports	\N	England	https://media.api-sports.io/football/teams/11992.png
11993	Holyport	\N	England	https://media.api-sports.io/football/teams/11993.png
11994	Hook Norton	\N	England	https://media.api-sports.io/football/teams/11994.png
11995	Huntingdon Town	\N	England	https://media.api-sports.io/football/teams/11995.png
11996	Ipswich Wanderers	\N	England	https://media.api-sports.io/football/teams/11996.png
11997	Jarrow Roofing Boldon	\N	England	https://media.api-sports.io/football/teams/11997.png
11998	Littlehampton Town	\N	England	https://media.api-sports.io/football/teams/11998.png
11999	London Bari	\N	England	https://media.api-sports.io/football/teams/11999.png
12000	Long Buckby	\N	England	https://media.api-sports.io/football/teams/12000.png
12001	Longwell Green Sports	\N	England	https://media.api-sports.io/football/teams/12001.png
12002	Maine Road	\N	England	https://media.api-sports.io/football/teams/12002.png
12003	Mile Oak	\N	England	https://media.api-sports.io/football/teams/12003.png
12004	Milton United	\N	England	https://media.api-sports.io/football/teams/12004.png
12005	Nelson	\N	England	https://media.api-sports.io/football/teams/12005.png
12006	New Mills	\N	England	https://media.api-sports.io/football/teams/12006.png
12007	New Milton Town	\N	England	https://media.api-sports.io/football/teams/12007.png
12008	Newport Isle of Wight FC	\N	England	https://media.api-sports.io/football/teams/12008.png
12009	Northampton Spencer	\N	England	https://media.api-sports.io/football/teams/12009.png
12010	Norton & Stockton	\N	England	https://media.api-sports.io/football/teams/12010.png
12011	Ossett Albion	\N	England	https://media.api-sports.io/football/teams/12011.png
12012	Ossett Town	\N	England	https://media.api-sports.io/football/teams/12012.png
12013	Parkgate	\N	England	https://media.api-sports.io/football/teams/12013.png
12014	Pegasus Juniors	\N	England	https://media.api-sports.io/football/teams/12014.png
12015	Petersfield Town	\N	England	https://media.api-sports.io/football/teams/12015.png
12016	Rainworth Miners Welfare	\N	England	https://media.api-sports.io/football/teams/12016.png
12017	Raunds Town FC	\N	England	https://media.api-sports.io/football/teams/12017.png
12018	Reading Town	\N	England	https://media.api-sports.io/football/teams/12018.png
12019	Retford United	\N	England	https://media.api-sports.io/football/teams/12019.png
12020	Ringmer	\N	England	https://media.api-sports.io/football/teams/12020.png
12021	Risborough Rangers	\N	England	https://media.api-sports.io/football/teams/12021.png
12022	Rocester	\N	England	https://media.api-sports.io/football/teams/12022.png
12023	Rochester United	\N	England	https://media.api-sports.io/football/teams/12023.png
12024	Seven Acre & Sidcup	\N	England	https://media.api-sports.io/football/teams/12024.png
12025	Shawbury United	\N	England	https://media.api-sports.io/football/teams/12025.png
12026	Sherborne Town	\N	England	https://media.api-sports.io/football/teams/12026.png
12027	Shirebrook Town	\N	England	https://media.api-sports.io/football/teams/12027.png
12028	Sileby Rangers	\N	England	https://media.api-sports.io/football/teams/12028.png
12029	Southam United FC	\N	England	https://media.api-sports.io/football/teams/12029.png
12030	St Andrews	\N	England	https://media.api-sports.io/football/teams/12030.png
12031	St Francis Rangers	STF	England	https://media.api-sports.io/football/teams/12031.png
12032	St Helens Town	\N	England	https://media.api-sports.io/football/teams/12032.png
12033	Sun Postal Sports	\N	England	https://media.api-sports.io/football/teams/12033.png
12034	Thamesmead Town	THA	England	https://media.api-sports.io/football/teams/12034.png
12035	Thrapston Town	\N	England	https://media.api-sports.io/football/teams/12035.png
12036	Thurrock	\N	England	https://media.api-sports.io/football/teams/12036.png
12037	Tipton Town	\N	England	https://media.api-sports.io/football/teams/12037.png
12038	Verwood Town	\N	England	https://media.api-sports.io/football/teams/12038.png
12039	Washington	\N	England	https://media.api-sports.io/football/teams/12039.png
12040	Welton Rovers	\N	England	https://media.api-sports.io/football/teams/12040.png
12041	West Allotment Celtic	\N	England	https://media.api-sports.io/football/teams/12041.png
12042	Whitchurch United	\N	England	https://media.api-sports.io/football/teams/12042.png
12043	Wick & Barnham United	\N	England	https://media.api-sports.io/football/teams/12043.png
12044	Wincanton Town	\N	England	https://media.api-sports.io/football/teams/12044.png
12045	Winterbourne United	\N	England	https://media.api-sports.io/football/teams/12045.png
12046	Witheridge	\N	England	https://media.api-sports.io/football/teams/12046.png
12047	Wivenhoe Town	\N	England	https://media.api-sports.io/football/teams/12047.png
12048	Worthing United	\N	England	https://media.api-sports.io/football/teams/12048.png
12049	Alton Town	\N	England	https://media.api-sports.io/football/teams/12049.png
12050	Arnold Town	\N	England	https://media.api-sports.io/football/teams/12050.png
12051	Ash United	\N	England	https://media.api-sports.io/football/teams/12051.png
12052	Bewdley Town	\N	England	https://media.api-sports.io/football/teams/12052.png
12053	Black Country Rangers	\N	England	https://media.api-sports.io/football/teams/12053.png
12054	Borrowash Victoria	\N	England	https://media.api-sports.io/football/teams/12054.png
12055	Cammell Laird	\N	England	https://media.api-sports.io/football/teams/12055.png
12056	Causeway United	\N	England	https://media.api-sports.io/football/teams/12056.png
12057	Corsham Town	\N	England	https://media.api-sports.io/football/teams/12057.png
12058	Cradley Town	\N	England	https://media.api-sports.io/football/teams/12058.png
12059	Croydon Athletic	\N	England	https://media.api-sports.io/football/teams/12059.png
12060	Downton	\N	England	https://media.api-sports.io/football/teams/12060.png
12061	Dudley Town	\N	England	https://media.api-sports.io/football/teams/12061.png
12062	Epsom Athletic	\N	England	https://media.api-sports.io/football/teams/12062.png
12063	Graham St Prims	\N	England	https://media.api-sports.io/football/teams/12063.png
12064	Hatfield Town	\N	England	https://media.api-sports.io/football/teams/12064.png
12065	Ilfracombe Town	\N	England	https://media.api-sports.io/football/teams/12065.png
12066	Lincoln Moorlands	\N	England	https://media.api-sports.io/football/teams/12066.png
12067	Newbury	\N	England	https://media.api-sports.io/football/teams/12067.png
12068	Norton United	\N	England	https://media.api-sports.io/football/teams/12068.png
12069	Nuneaton Griff	\N	England	https://media.api-sports.io/football/teams/12069.png
12070	Pewsey Vale	\N	England	https://media.api-sports.io/football/teams/12070.png
12071	Radstock Town	\N	England	https://media.api-sports.io/football/teams/12071.png
12072	Rochdale Town	\N	England	https://media.api-sports.io/football/teams/12072.png
12073	Rushden & Diamonds	\N	England	https://media.api-sports.io/football/teams/12073.png
12074	Stafford Town	\N	England	https://media.api-sports.io/football/teams/12074.png
12075	Staines Lammas	\N	England	https://media.api-sports.io/football/teams/12075.png
12076	Stapenhill	\N	England	https://media.api-sports.io/football/teams/12076.png
12077	Stockport Sports	\N	England	https://media.api-sports.io/football/teams/12077.png
12078	Studley	\N	England	https://media.api-sports.io/football/teams/12078.png
12079	Team Bury	\N	England	https://media.api-sports.io/football/teams/12079.png
12080	Torpoint Athletic	\N	England	https://media.api-sports.io/football/teams/12080.png
12081	Totton & Eling	\N	England	https://media.api-sports.io/football/teams/12081.png
12082	Wellington	\N	England	https://media.api-sports.io/football/teams/12082.png
12083	Wigan Robin Park	\N	England	https://media.api-sports.io/football/teams/12083.png
12084	Woodstock Sports	\N	England	https://media.api-sports.io/football/teams/12084.png
12085	Abingdon Town	\N	England	https://media.api-sports.io/football/teams/12085.png
12086	Ashton Town	\N	England	https://media.api-sports.io/football/teams/12086.png
12087	Berkhamsted Town	\N	England	https://media.api-sports.io/football/teams/12087.png
12088	Blackstones	\N	England	https://media.api-sports.io/football/teams/12088.png
12089	Calne Town FC	\N	England	https://media.api-sports.io/football/teams/12089.png
12090	Carterton	\N	England	https://media.api-sports.io/football/teams/12090.png
12091	Cheadle Town	\N	England	https://media.api-sports.io/football/teams/12091.png
12092	Darlington Railway	\N	England	https://media.api-sports.io/football/teams/12092.png
12093	Dorking	\N	England	https://media.api-sports.io/football/teams/12093.png
12094	Earlswood Town	\N	England	https://media.api-sports.io/football/teams/12094.png
12095	East Cowes Victoria	\N	England	https://media.api-sports.io/football/teams/12095.png
12096	Eastwood Town	\N	England	https://media.api-sports.io/football/teams/12096.png
12097	Formby	\N	England	https://media.api-sports.io/football/teams/12097.png
12098	Greenhouse London	\N	England	https://media.api-sports.io/football/teams/12098.png
12099	Hinckley United	\N	England	https://media.api-sports.io/football/teams/12099.png
12100	Holbrook Sports	\N	England	https://media.api-sports.io/football/teams/12100.png
12101	Hucknall Town	\N	England	https://media.api-sports.io/football/teams/12101.png
12102	Irchester United	\N	England	https://media.api-sports.io/football/teams/12102.png
12103	London APSA	\N	England	https://media.api-sports.io/football/teams/12103.png
12104	London Lions	\N	England	https://media.api-sports.io/football/teams/12104.png
12105	Louth Town	\N	England	https://media.api-sports.io/football/teams/12105.png
12106	Oldland Abbotonians	\N	England	https://media.api-sports.io/football/teams/12106.png
12107	Rushden & Higham United	\N	England	https://media.api-sports.io/football/teams/12107.png
12108	Rye United	\N	England	https://media.api-sports.io/football/teams/12108.png
12109	Salisbury City	SAL	England	https://media.api-sports.io/football/teams/12109.png
12110	Sandhurst Town	\N	England	https://media.api-sports.io/football/teams/12110.png
12111	Sidley United	\N	England	https://media.api-sports.io/football/teams/12111.png
12112	St Blazey	\N	England	https://media.api-sports.io/football/teams/12112.png
12113	Stewarts & Lloyds FC	\N	England	https://media.api-sports.io/football/teams/12113.png
12114	Team Northumbria	\N	England	https://media.api-sports.io/football/teams/12114.png
12115	Teversal	\N	England	https://media.api-sports.io/football/teams/12115.png
12116	Tow Law Town	\N	England	https://media.api-sports.io/football/teams/12116.png
12117	Wakefield	\N	England	https://media.api-sports.io/football/teams/12117.png
12118	Wells City	\N	England	https://media.api-sports.io/football/teams/12118.png
12119	Whitehaven	\N	England	https://media.api-sports.io/football/teams/12119.png
12120	Woodford United	\N	England	https://media.api-sports.io/football/teams/12120.png
12121	Worksop Parramore	WOR	England	https://media.api-sports.io/football/teams/12121.png
12122	AFC Uckfield	\N	England	https://media.api-sports.io/football/teams/12122.png
12123	Atherton Laburnum Rovers	\N	England	https://media.api-sports.io/football/teams/12123.png
12124	Bartley Green	\N	England	https://media.api-sports.io/football/teams/12124.png
12125	Bethnal Green United	\N	England	https://media.api-sports.io/football/teams/12125.png
12126	Birtley Town	\N	England	https://media.api-sports.io/football/teams/12126.png
12127	Bloxwich United	\N	England	https://media.api-sports.io/football/teams/12127.png
12128	Bridgnorth Town	\N	England	https://media.api-sports.io/football/teams/12128.png
12129	Broxbourne Borough V&E	\N	England	https://media.api-sports.io/football/teams/12129.png
12130	Celtic Nation	\N	England	https://media.api-sports.io/football/teams/12130.png
12131	Chard Town	\N	England	https://media.api-sports.io/football/teams/12131.png
12132	Chester-le-Street Town	\N	England	https://media.api-sports.io/football/teams/12132.png
12133	Cranfield United	\N	England	https://media.api-sports.io/football/teams/12133.png
12134	Daisy Hill	\N	England	https://media.api-sports.io/football/teams/12134.png
12135	Dinnington Town	\N	England	https://media.api-sports.io/football/teams/12135.png
12136	Dudley Sports	\N	England	https://media.api-sports.io/football/teams/12136.png
12137	Eccleshall	\N	England	https://media.api-sports.io/football/teams/12137.png
12138	Elmore	\N	England	https://media.api-sports.io/football/teams/12138.png
12139	Esh Winning	\N	England	https://media.api-sports.io/football/teams/12139.png
12140	Fleet Spurs	\N	England	https://media.api-sports.io/football/teams/12140.png
12141	GE Hamble	\N	England	https://media.api-sports.io/football/teams/12141.png
12142	Hayling United	\N	England	https://media.api-sports.io/football/teams/12142.png
12143	Langford	\N	England	https://media.api-sports.io/football/teams/12143.png
12144	Old Woodstock Town	\N	England	https://media.api-sports.io/football/teams/12144.png
12145	Pilkington XXX	\N	England	https://media.api-sports.io/football/teams/12145.png
12146	Ringwood Town	\N	England	https://media.api-sports.io/football/teams/12146.png
12147	Rossington Main	\N	England	https://media.api-sports.io/football/teams/12147.png
12148	Selby Town FC	\N	England	https://media.api-sports.io/football/teams/12148.png
12149	Shifnal Town FC	\N	England	https://media.api-sports.io/football/teams/12149.png
12150	Spennymoor	\N	England	https://media.api-sports.io/football/teams/12150.png
12151	Stokesley SC	\N	England	https://media.api-sports.io/football/teams/12151.png
12152	Stone Dominoes	\N	England	https://media.api-sports.io/football/teams/12152.png
12153	Warlingham	\N	England	https://media.api-sports.io/football/teams/12153.png
12154	Willenhall Town	\N	England	https://media.api-sports.io/football/teams/12154.png
12155	Witney Town	\N	England	https://media.api-sports.io/football/teams/12155.png
12156	Wodson Park	\N	England	https://media.api-sports.io/football/teams/12156.png
12157	Wokingham & Emmbrook	\N	England	https://media.api-sports.io/football/teams/12157.png
12158	Banstead	\N	England	https://media.api-sports.io/football/teams/12158.png
12159	Daventry United	\N	England	https://media.api-sports.io/football/teams/12159.png
12160	Scarborough	\N	England	https://media.api-sports.io/football/teams/12160.png
12161	Woodley Sports	\N	England	https://media.api-sports.io/football/teams/12161.png
12162	Andover	\N	England	https://media.api-sports.io/football/teams/12162.png
12163	Bedfont Town	\N	England	https://media.api-sports.io/football/teams/12163.png
12515	New Zealand U17	\N	England	https://media.api-sports.io/football/teams/12515.png
14219	Aston Villa W	\N	England	https://media.api-sports.io/football/teams/14219.png
14405	Alfold	\N	England	https://media.api-sports.io/football/teams/14405.png
14406	Benfleet	\N	England	https://media.api-sports.io/football/teams/14406.png
14407	Billingshurst	\N	England	https://media.api-sports.io/football/teams/14407.png
14408	Bovey Tracey	\N	England	https://media.api-sports.io/football/teams/14408.png
14409	Burton Park Wanderers	\N	England	https://media.api-sports.io/football/teams/14409.png
14410	Chelmsley Town	\N	England	https://media.api-sports.io/football/teams/14410.png
14411	Hashtag United	\N	England	https://media.api-sports.io/football/teams/14411.png
14412	Helston Athletic	\N	England	https://media.api-sports.io/football/teams/14412.png
14413	Kennington	\N	England	https://media.api-sports.io/football/teams/14413.png
14414	Little Oakley	\N	England	https://media.api-sports.io/football/teams/14414.png
14415	Long Crendon	\N	England	https://media.api-sports.io/football/teams/14415.png
14416	Millbrook	\N	England	https://media.api-sports.io/football/teams/14416.png
14417	New Salamis	\N	England	https://media.api-sports.io/football/teams/14417.png
14418	Newark Flowserve	\N	England	https://media.api-sports.io/football/teams/14418.png
14419	Newent Town	\N	England	https://media.api-sports.io/football/teams/14419.png
14420	Newton Abbot Spurs	\N	England	https://media.api-sports.io/football/teams/14420.png
14421	Oakwood	\N	England	https://media.api-sports.io/football/teams/14421.png
14422	Park View	\N	England	https://media.api-sports.io/football/teams/14422.png
14423	Shelley	\N	England	https://media.api-sports.io/football/teams/14423.png
14424	Stansfeld	\N	England	https://media.api-sports.io/football/teams/14424.png
14425	Torrington	\N	England	https://media.api-sports.io/football/teams/14425.png
14426	West Bridgford	\N	England	https://media.api-sports.io/football/teams/14426.png
14427	Westside	\N	England	https://media.api-sports.io/football/teams/14427.png
14428	Wythenshawe Amateurs	\N	England	https://media.api-sports.io/football/teams/14428.png
14429	Highgate United	\N	England	https://media.api-sports.io/football/teams/14429.png
14430	Leeds United U21	\N	England	https://media.api-sports.io/football/teams/14430.png
14450	OJM Black Country	\N	England	https://media.api-sports.io/football/teams/14450.png
14513	Nottingham U23	\N	England	https://media.api-sports.io/football/teams/14513.png
14547	Campion AFC	\N	England	https://media.api-sports.io/football/teams/14547.png
14551	Ipswich U23	\N	England	https://media.api-sports.io/football/teams/14551.png
14652	Crystal Palace U23	\N	England	https://media.api-sports.io/football/teams/14652.png
14723	Manchester Utd U23	\N	England	https://media.api-sports.io/football/teams/14723.png
14737	Newcastle United U23	\N	England	https://media.api-sports.io/football/teams/14737.png
14739	Nottingham Forest U23	\N	England	https://media.api-sports.io/football/teams/14739.png
15375	Blackburn Rovers U18	\N	England	https://media.api-sports.io/football/teams/15375.png
15376	Burnley U18	\N	England	https://media.api-sports.io/football/teams/15376.png
15377	Derby County U18	\N	England	https://media.api-sports.io/football/teams/15377.png
15378	Everton U18	\N	England	https://media.api-sports.io/football/teams/15378.png
15379	Leeds United U18	\N	England	https://media.api-sports.io/football/teams/15379.png
15380	Liverpool U18	\N	England	https://media.api-sports.io/football/teams/15380.png
15381	Manchester City U18	\N	England	https://media.api-sports.io/football/teams/15381.png
15382	Manchester United U18	\N	England	https://media.api-sports.io/football/teams/15382.png
15383	Middlesbrough U18	\N	England	https://media.api-sports.io/football/teams/15383.png
15384	Newcastle United U18	\N	England	https://media.api-sports.io/football/teams/15384.png
15385	Stoke City U18	\N	England	https://media.api-sports.io/football/teams/15385.png
15386	Sunderland U18	\N	England	https://media.api-sports.io/football/teams/15386.png
15387	Wolves U18	\N	England	https://media.api-sports.io/football/teams/15387.png
15388	Arsenal U18	\N	England	https://media.api-sports.io/football/teams/15388.png
15389	Aston Villa U18	\N	England	https://media.api-sports.io/football/teams/15389.png
15390	Brighton U18	\N	England	https://media.api-sports.io/football/teams/15390.png
15391	Chelsea U18	\N	England	https://media.api-sports.io/football/teams/15391.png
15392	Crystal Palace U18	\N	England	https://media.api-sports.io/football/teams/15392.png
15393	Fulham U18	\N	England	https://media.api-sports.io/football/teams/15393.png
15394	Leicester City U18	\N	England	https://media.api-sports.io/football/teams/15394.png
15395	Norwich City U18	\N	England	https://media.api-sports.io/football/teams/15395.png
15396	Reading U18	\N	England	https://media.api-sports.io/football/teams/15396.png
15397	Southampton U18	\N	England	https://media.api-sports.io/football/teams/15397.png
15398	Tottenham Hotspur U18	\N	England	https://media.api-sports.io/football/teams/15398.png
15399	West Bromwich Albion U18	\N	England	https://media.api-sports.io/football/teams/15399.png
15400	West Ham United U18	\N	England	https://media.api-sports.io/football/teams/15400.png
15401	Blackburn Rovers W	\N	England	https://media.api-sports.io/football/teams/15401.png
15402	Charlton Athletic W	\N	England	https://media.api-sports.io/football/teams/15402.png
15403	Durham W	\N	England	https://media.api-sports.io/football/teams/15403.png
15404	Leicester City WFC	\N	England	https://media.api-sports.io/football/teams/15404.png
15405	London Bees W	\N	England	https://media.api-sports.io/football/teams/15405.png
15406	London City Lionesses	\N	England	https://media.api-sports.io/football/teams/15406.png
15407	Sheffield United W	\N	England	https://media.api-sports.io/football/teams/15407.png
15408	Coventry United W	\N	England	https://media.api-sports.io/football/teams/15408.png
15409	Crystal Palace W	\N	England	https://media.api-sports.io/football/teams/15409.png
15410	Lewes W	\N	England	https://media.api-sports.io/football/teams/15410.png
15411	Actonians W	\N	England	https://media.api-sports.io/football/teams/15411.png
15412	Cardiff City W	\N	England	https://media.api-sports.io/football/teams/15412.png
15413	Cheltenham Town W	\N	England	https://media.api-sports.io/football/teams/15413.png
15414	Chichester & Selsey W	\N	England	https://media.api-sports.io/football/teams/15414.png
15415	Crawley Wasps W	\N	England	https://media.api-sports.io/football/teams/15415.png
15416	Crewe Alexandra LFC W	\N	England	https://media.api-sports.io/football/teams/15416.png
15417	Derby County W	\N	England	https://media.api-sports.io/football/teams/15417.png
15418	Durham Cestria W	\N	England	https://media.api-sports.io/football/teams/15418.png
15419	Fylde W	\N	England	https://media.api-sports.io/football/teams/15419.png
15420	Hounslow W	\N	England	https://media.api-sports.io/football/teams/15420.png
15421	Huddersfield Town W	\N	England	https://media.api-sports.io/football/teams/15421.png
15422	Ipswich Town W	\N	England	https://media.api-sports.io/football/teams/15422.png
15423	Leek Town Ladies W	\N	England	https://media.api-sports.io/football/teams/15423.png
15424	Lincoln City W	\N	England	https://media.api-sports.io/football/teams/15424.png
15425	Liverpool Feds W	\N	England	https://media.api-sports.io/football/teams/15425.png
15426	Loughborough Foxes W	\N	England	https://media.api-sports.io/football/teams/15426.png
15427	Luton Town W	\N	England	https://media.api-sports.io/football/teams/15427.png
15428	Plymouth Argyle W	\N	England	https://media.api-sports.io/football/teams/15428.png
15429	Portishead W	\N	England	https://media.api-sports.io/football/teams/15429.png
15430	Southampton WFC W	\N	England	https://media.api-sports.io/football/teams/15430.png
15431	Wem Town W	\N	England	https://media.api-sports.io/football/teams/15431.png
15432	West Bromwich Albion W	\N	England	https://media.api-sports.io/football/teams/15432.png
15433	Wolverhampton W	\N	England	https://media.api-sports.io/football/teams/15433.png
15434	Woodlands W	\N	England	https://media.api-sports.io/football/teams/15434.png
15435	AFC Wimbledon W	\N	England	https://media.api-sports.io/football/teams/15435.png
15436	Barnsley W	\N	England	https://media.api-sports.io/football/teams/15436.png
15437	Billericay Town W	\N	England	https://media.api-sports.io/football/teams/15437.png
15438	Brighouse Town W	\N	England	https://media.api-sports.io/football/teams/15438.png
15439	Burnley W	\N	England	https://media.api-sports.io/football/teams/15439.png
15440	Chesham United W	\N	England	https://media.api-sports.io/football/teams/15440.png
15441	Chester-le-Street Town W	\N	England	https://media.api-sports.io/football/teams/15441.png
15442	Chorley W	\N	England	https://media.api-sports.io/football/teams/15442.png
15443	Gillingham W	\N	England	https://media.api-sports.io/football/teams/15443.png
15444	Hashtag United W	\N	England	https://media.api-sports.io/football/teams/15444.png
15445	Hull City W	\N	England	https://media.api-sports.io/football/teams/15445.png
15446	Keynsham Town W	\N	England	https://media.api-sports.io/football/teams/15446.png
15447	Leyton Orient W	\N	England	https://media.api-sports.io/football/teams/15447.png
15448	Middlesbrough W	\N	England	https://media.api-sports.io/football/teams/15448.png
15449	Milton Keynes Dons W	\N	England	https://media.api-sports.io/football/teams/15449.png
15450	Nottingham Forest W	\N	England	https://media.api-sports.io/football/teams/15450.png
15451	Oxford United W	\N	England	https://media.api-sports.io/football/teams/15451.png
15452	Portsmouth W	\N	England	https://media.api-sports.io/football/teams/15452.png
15453	Sheffield W	\N	England	https://media.api-sports.io/football/teams/15453.png
15454	Southampton W	\N	England	https://media.api-sports.io/football/teams/15454.png
15455	Stoke City W	\N	England	https://media.api-sports.io/football/teams/15455.png
15457	Watford W	\N	England	https://media.api-sports.io/football/teams/15457.png
15513	AFC Bournemouth W	\N	England	https://media.api-sports.io/football/teams/15513.png
15514	Maidenhead United W	\N	England	https://media.api-sports.io/football/teams/15514.png
15515	Newcastle United W	\N	England	https://media.api-sports.io/football/teams/15515.png
15529	Boldmere St. Michaels W	\N	England	https://media.api-sports.io/football/teams/15529.png
15530	Exeter City W	\N	England	https://media.api-sports.io/football/teams/15530.png
15531	Harlow Town W	\N	England	https://media.api-sports.io/football/teams/15531.png
15532	Solihull Moors W	\N	England	https://media.api-sports.io/football/teams/15532.png
15533	Stourbridge W	\N	England	https://media.api-sports.io/football/teams/15533.png
15591	Kent	\N	England	https://media.api-sports.io/football/teams/15591.png
15593	Enfield Town W	\N	England	https://media.api-sports.io/football/teams/15593.png
15594	United of Manchester W	\N	England	https://media.api-sports.io/football/teams/15594.png
15631	Arsenal U23	\N	England	https://media.api-sports.io/football/teams/15631.png
15632	Aston Villa U23	\N	England	https://media.api-sports.io/football/teams/15632.png
15633	Burnley U23	\N	England	https://media.api-sports.io/football/teams/15633.png
15634	Fulham U23	\N	England	https://media.api-sports.io/football/teams/15634.png
15635	Leeds United U23	\N	England	https://media.api-sports.io/football/teams/15635.png
15636	Liverpool U23	\N	England	https://media.api-sports.io/football/teams/15636.png
15637	Manchester City U23	\N	England	https://media.api-sports.io/football/teams/15637.png
15638	Tottenham Hotspur U23	\N	England	https://media.api-sports.io/football/teams/15638.png
15639	Barnsley U23	\N	England	https://media.api-sports.io/football/teams/15639.png
15640	Birmingham City U23	\N	England	https://media.api-sports.io/football/teams/15640.png
15641	Bristol City U23	\N	England	https://media.api-sports.io/football/teams/15641.png
15642	Cardiff City U23	\N	England	https://media.api-sports.io/football/teams/15642.png
15643	Charlton Athletic U23	\N	England	https://media.api-sports.io/football/teams/15643.png
15644	Colchester United U23	\N	England	https://media.api-sports.io/football/teams/15644.png
15645	Coventry City U23	\N	England	https://media.api-sports.io/football/teams/15645.png
15646	Crewe Alexandra U23	\N	England	https://media.api-sports.io/football/teams/15646.png
15647	Hull City U23	\N	England	https://media.api-sports.io/football/teams/15647.png
15648	Millwall U23	\N	England	https://media.api-sports.io/football/teams/15648.png
15649	Queens Park Rangers U23	\N	England	https://media.api-sports.io/football/teams/15649.png
15650	Sheffield United U23	\N	England	https://media.api-sports.io/football/teams/15650.png
15651	Sheffield Wednesday U23	\N	England	https://media.api-sports.io/football/teams/15651.png
15652	Watford U23	\N	England	https://media.api-sports.io/football/teams/15652.png
15653	Wigan Athletic U23	\N	England	https://media.api-sports.io/football/teams/15653.png
16623	Great Britain	\N	England	https://media.api-sports.io/football/teams/16623.png
16983	Athletic Newham	\N	England	https://media.api-sports.io/football/teams/16983.png
16984	Brixham	\N	England	https://media.api-sports.io/football/teams/16984.png
16985	Eastwood Community	\N	England	https://media.api-sports.io/football/teams/16985.png
16986	Hereford Lads Club	\N	England	https://media.api-sports.io/football/teams/16986.png
16987	Jersey Bulls	\N	England	https://media.api-sports.io/football/teams/16987.png
16988	Kensington Borough	\N	England	https://media.api-sports.io/football/teams/16988.png
16989	Lakenheath	\N	England	https://media.api-sports.io/football/teams/16989.png
16990	Milton Keynes Irish	\N	England	https://media.api-sports.io/football/teams/16990.png
16991	Mousehole	\N	England	https://media.api-sports.io/football/teams/16991.png
16992	North Ferriby	\N	England	https://media.api-sports.io/football/teams/16992.png
16993	Prestwich Heys	\N	England	https://media.api-sports.io/football/teams/16993.png
16994	Redcar Athletic	\N	England	https://media.api-sports.io/football/teams/16994.png
16995	Skegness Town	\N	England	https://media.api-sports.io/football/teams/16995.png
16996	St. Panteleimon	\N	England	https://media.api-sports.io/football/teams/16996.png
16997	Uttoxeter Town	\N	England	https://media.api-sports.io/football/teams/16997.png
16998	Wythenshawe Town	\N	England	https://media.api-sports.io/football/teams/16998.png
17000	Crystal Palace U21	CRY	England	https://media.api-sports.io/football/teams/17000.png
17021	Bury AFC	\N	England	https://media.api-sports.io/football/teams/17021.png
17044	Golcar United	\N	England	https://media.api-sports.io/football/teams/17044.png
17078	Rayners Lane	\N	England	https://media.api-sports.io/football/teams/17078.png
17425	Birmingham City U18	\N	England	https://media.api-sports.io/football/teams/17425.png
17426	Nottingham Forest U18	\N	England	https://media.api-sports.io/football/teams/17426.png
17451	Peterborough United U23	\N	England	https://media.api-sports.io/football/teams/17451.png
17794	AFC Bournemouth U23	\N	England	https://media.api-sports.io/football/teams/17794.png
17795	Exeter City U23	\N	England	https://media.api-sports.io/football/teams/17795.png
17796	Huddersfield Town U23	\N	England	https://media.api-sports.io/football/teams/17796.png
17797	Mansfield Town U23	\N	England	https://media.api-sports.io/football/teams/17797.png
17798	Oxford United 23	\N	England	https://media.api-sports.io/football/teams/17798.png
17799	Plymouth Argyle U23	\N	England	https://media.api-sports.io/football/teams/17799.png
17800	Salford City U23	\N	England	https://media.api-sports.io/football/teams/17800.png
17801	Southend United U23	\N	England	https://media.api-sports.io/football/teams/17801.png
17802	Stevenage U23	\N	England	https://media.api-sports.io/football/teams/17802.png
17949	England U17	\N	England	https://media.api-sports.io/football/teams/17949.png
17954	Germany U17	\N	England	https://media.api-sports.io/football/teams/17954.png
18189	Alnwick Town	\N	England	https://media.api-sports.io/football/teams/18189.png
18190	Ashford Town (Middx)	\N	England	https://media.api-sports.io/football/teams/18190.png
18191	Blackburn Community	\N	England	https://media.api-sports.io/football/teams/18191.png
18192	Bournemouth Sports	\N	England	https://media.api-sports.io/football/teams/18192.png
18193	Bradford City	\N	England	https://media.api-sports.io/football/teams/18193.png
18194	Bridgwater United	\N	England	https://media.api-sports.io/football/teams/18194.png
18195	Clapton Community	\N	England	https://media.api-sports.io/football/teams/18195.png
18196	Doncaster Belles	\N	England	https://media.api-sports.io/football/teams/18196.png
18197	Eastleigh Community	\N	England	https://media.api-sports.io/football/teams/18197.png
18198	Hartlepool United	\N	England	https://media.api-sports.io/football/teams/18198.png
18199	Herts Vipers	\N	England	https://media.api-sports.io/football/teams/18199.png
18200	Ilminster Town	\N	England	https://media.api-sports.io/football/teams/18200.png
18201	Knowle	\N	England	https://media.api-sports.io/football/teams/18201.png
18202	Leafield Athletic	\N	England	https://media.api-sports.io/football/teams/18202.png
18203	Liskeard Athletic	\N	England	https://media.api-sports.io/football/teams/18203.png
18204	London Seaward	\N	England	https://media.api-sports.io/football/teams/18204.png
18205	Loughborough Lightning	\N	England	https://media.api-sports.io/football/teams/18205.png
18206	Millwall Lionesses	\N	England	https://media.api-sports.io/football/teams/18206.png
18207	Mossley Hill	\N	England	https://media.api-sports.io/football/teams/18207.png
18208	Netherton United	\N	England	https://media.api-sports.io/football/teams/18208.png
18209	Northampton Town	\N	England	https://media.api-sports.io/football/teams/18209.png
18210	Norwich City	\N	England	https://media.api-sports.io/football/teams/18210.png
18211	Peterborough United	\N	England	https://media.api-sports.io/football/teams/18211.png
18212	Queens Park Rangers	\N	England	https://media.api-sports.io/football/teams/18212.png
18213	Shifnal Town	\N	England	https://media.api-sports.io/football/teams/18213.png
18214	Shrewsbury Town	\N	England	https://media.api-sports.io/football/teams/18214.png
18215	Sir Tom Finney	\N	England	https://media.api-sports.io/football/teams/18215.png
18216	Southend Utd Community	\N	England	https://media.api-sports.io/football/teams/18216.png
18217	Steyning Town Community	\N	England	https://media.api-sports.io/football/teams/18217.png
18218	Stoneham	\N	England	https://media.api-sports.io/football/teams/18218.png
18219	Sutton United	\N	England	https://media.api-sports.io/football/teams/18219.png
18220	Torquay United	\N	England	https://media.api-sports.io/football/teams/18220.png
18221	Wymondham Town	\N	England	https://media.api-sports.io/football/teams/18221.png
18222	AFC Telford United W	\N	England	https://media.api-sports.io/football/teams/18222.png
18223	Abingdon Town W	\N	England	https://media.api-sports.io/football/teams/18223.png
18224	Abingdon United W	\N	England	https://media.api-sports.io/football/teams/18224.png
18225	Ascot United W	\N	England	https://media.api-sports.io/football/teams/18225.png
18226	Bedford W	\N	England	https://media.api-sports.io/football/teams/18226.png
18227	Bedworth United W	\N	England	https://media.api-sports.io/football/teams/18227.png
18228	Bromley W	\N	England	https://media.api-sports.io/football/teams/18228.png
18229	Burton Albion W	\N	England	https://media.api-sports.io/football/teams/18229.png
18230	Cambridge City W	\N	England	https://media.api-sports.io/football/teams/18230.png
18231	Cambridge United W	\N	England	https://media.api-sports.io/football/teams/18231.png
18232	Cheadle Town W	\N	England	https://media.api-sports.io/football/teams/18232.png
18233	Dorking Wanderers W	\N	England	https://media.api-sports.io/football/teams/18233.png
18234	Farsley Celtic W	\N	England	https://media.api-sports.io/football/teams/18234.png
18235	Fleetwood Town W	\N	England	https://media.api-sports.io/football/teams/18235.png
18236	Fulham W	\N	England	https://media.api-sports.io/football/teams/18236.png
18237	Harrogate Town W	\N	England	https://media.api-sports.io/football/teams/18237.png
18238	Herne Bay W	\N	England	https://media.api-sports.io/football/teams/18238.png
18239	Leeds W	\N	England	https://media.api-sports.io/football/teams/18239.png
18240	Lichfield City W	\N	England	https://media.api-sports.io/football/teams/18240.png
18241	Lincoln United W	\N	England	https://media.api-sports.io/football/teams/18241.png
18242	Long Eaton United W	\N	England	https://media.api-sports.io/football/teams/18242.png
18243	Lye Town W	\N	England	https://media.api-sports.io/football/teams/18243.png
18244	New Milton Town W	\N	England	https://media.api-sports.io/football/teams/18244.png
18245	Norton & Stockton W	\N	England	https://media.api-sports.io/football/teams/18245.png
18246	Salford City W	\N	England	https://media.api-sports.io/football/teams/18246.png
18247	Sherborne Town W	\N	England	https://media.api-sports.io/football/teams/18247.png
18248	South Shields W	\N	England	https://media.api-sports.io/football/teams/18248.png
18249	Sporting Khalsa W	\N	England	https://media.api-sports.io/football/teams/18249.png
18250	St Austell W	\N	England	https://media.api-sports.io/football/teams/18250.png
18251	Stevenage W	\N	England	https://media.api-sports.io/football/teams/18251.png
18252	Sutton Coldfield Town W	\N	England	https://media.api-sports.io/football/teams/18252.png
18253	Swindon Town W	\N	England	https://media.api-sports.io/football/teams/18253.png
18254	Wakefield W	\N	England	https://media.api-sports.io/football/teams/18254.png
18255	Worthing W	\N	England	https://media.api-sports.io/football/teams/18255.png
18473	Brentford B	\N	England	https://media.api-sports.io/football/teams/18473.png
18829	Westchester United U18	\N	England	https://media.api-sports.io/football/teams/18829.png
19061	England U19 W	\N	England	https://media.api-sports.io/football/teams/19061.png
19210	Brentford U23	\N	England	https://media.api-sports.io/football/teams/19210.png
19242	Isle of Man	\N	England	https://media.api-sports.io/football/teams/19242.png
19265	Roffey	\N	England	https://media.api-sports.io/football/teams/19265.png
19548	Belper United	\N	England	https://media.api-sports.io/football/teams/19548.png
19549	Buckhurst Hill	\N	England	https://media.api-sports.io/football/teams/19549.png
19550	Carlisle City	\N	England	https://media.api-sports.io/football/teams/19550.png
19551	Darlaston Town	\N	England	https://media.api-sports.io/football/teams/19551.png
19552	Falmouth Town	\N	England	https://media.api-sports.io/football/teams/19552.png
19553	Hereford Pegasus	\N	England	https://media.api-sports.io/football/teams/19553.png
19554	Hilltop	\N	England	https://media.api-sports.io/football/teams/19554.png
19555	Kimberley Miners Welfare	\N	England	https://media.api-sports.io/football/teams/19555.png
19556	Laverstock & Ford	\N	England	https://media.api-sports.io/football/teams/19556.png
19557	Midhurst & Easebourne	\N	England	https://media.api-sports.io/football/teams/19557.png
19558	Shefford Town & Campton	\N	England	https://media.api-sports.io/football/teams/19558.png
19559	Warminster Town	\N	England	https://media.api-sports.io/football/teams/19559.png
19560	Worcester Raiders	\N	England	https://media.api-sports.io/football/teams/19560.png
19744	Blackburn Rovers U21	\N	England	https://media.api-sports.io/football/teams/19744.png
19745	Derby County U21	\N	England	https://media.api-sports.io/football/teams/19745.png
19746	Nottingham Forest U21	\N	England	https://media.api-sports.io/football/teams/19746.png
19834	Liskeard Athletic	\N	England	https://media.api-sports.io/football/teams/19834.png
19835	Sheringham	\N	England	https://media.api-sports.io/football/teams/19835.png
19837	Shelbourne W	\N	England	https://media.api-sports.io/football/teams/19837.png
19875	Accrington Stanley Res.	\N	England	https://media.api-sports.io/football/teams/19875.png
19876	Blackpool Res.	\N	England	https://media.api-sports.io/football/teams/19876.png
19877	Bolton Wanderers Res.	\N	England	https://media.api-sports.io/football/teams/19877.png
19878	Fleetwood Town Res.	\N	England	https://media.api-sports.io/football/teams/19878.png
19879	Huddersfield Town Res.	\N	England	https://media.api-sports.io/football/teams/19879.png
19880	Preston North End Res.	\N	England	https://media.api-sports.io/football/teams/19880.png
19881	Wrexham Res.	\N	England	https://media.api-sports.io/football/teams/19881.png
20000	AFC Bournemouth U21	\N	England	https://media.api-sports.io/football/teams/20000.png
20016	Cardiff City U21	\N	England	https://media.api-sports.io/football/teams/20016.png
20017	Huddersfield Town U21	\N	England	https://media.api-sports.io/football/teams/20017.png
20018	Peterborough United U21	\N	England	https://media.api-sports.io/football/teams/20018.png
20019	Watford U21	\N	England	https://media.api-sports.io/football/teams/20019.png
20078	Birmingham City U21	\N	England	https://media.api-sports.io/football/teams/20078.png
20079	Brentford U21	\N	England	https://media.api-sports.io/football/teams/20079.png
20080	Bristol City U21	\N	England	https://media.api-sports.io/football/teams/20080.png
20081	Burnley U21	\N	England	https://media.api-sports.io/football/teams/20081.png
20082	Charlton Athletic U21	\N	England	https://media.api-sports.io/football/teams/20082.png
20083	Colchester United U21	\N	England	https://media.api-sports.io/football/teams/20083.png
20084	Hull City U21	\N	England	https://media.api-sports.io/football/teams/20084.png
20085	Queens Park Rangers U21	\N	England	https://media.api-sports.io/football/teams/20085.png
20086	Sheffield United U21	\N	England	https://media.api-sports.io/football/teams/20086.png
20091	Barnsley U21	\N	England	https://media.api-sports.io/football/teams/20091.png
20092	Coventry City U21	\N	England	https://media.api-sports.io/football/teams/20092.png
20093	Crewe Alexandra U21	\N	England	https://media.api-sports.io/football/teams/20093.png
20094	Ipswich Town U21	\N	England	https://media.api-sports.io/football/teams/20094.png
20095	Millwall U21	\N	England	https://media.api-sports.io/football/teams/20095.png
20096	Sheffield Wednesday U21	\N	England	https://media.api-sports.io/football/teams/20096.png
20097	Wigan Athletic U21	\N	England	https://media.api-sports.io/football/teams/20097.png
20604	Aylesford	\N	England	https://media.api-sports.io/football/teams/20604.png
20605	Bishops Lydeard	\N	England	https://media.api-sports.io/football/teams/20605.png
20606	Darwen	\N	England	https://media.api-sports.io/football/teams/20606.png
20607	Frampton Rangers	\N	England	https://media.api-sports.io/football/teams/20607.png
20608	Hackney	\N	England	https://media.api-sports.io/football/teams/20608.png
20609	Merseyrail	\N	England	https://media.api-sports.io/football/teams/20609.png
20610	Penrith	\N	England	https://media.api-sports.io/football/teams/20610.png
20611	Redcar Town	\N	England	https://media.api-sports.io/football/teams/20611.png
20612	Sedgley & Gornal United	\N	England	https://media.api-sports.io/football/teams/20612.png
20613	Tranmere Rovers	\N	England	https://media.api-sports.io/football/teams/20613.png
20614	Wallsend	\N	England	https://media.api-sports.io/football/teams/20614.png
20615	York City LFC	\N	England	https://media.api-sports.io/football/teams/20615.png
20616	Coventry Sphinx W	\N	England	https://media.api-sports.io/football/teams/20616.png
20617	Dartford W	\N	England	https://media.api-sports.io/football/teams/20617.png
20618	Dulwich Hamlet W	\N	England	https://media.api-sports.io/football/teams/20618.png
20619	King's Lynn Town W	\N	England	https://media.api-sports.io/football/teams/20619.png
20620	Moneyfields W	\N	England	https://media.api-sports.io/football/teams/20620.png
20621	Mulbarton Wanderers W	\N	England	https://media.api-sports.io/football/teams/20621.png
20622	Stockport County W	\N	England	https://media.api-sports.io/football/teams/20622.png
20623	Warminster Town W	\N	England	https://media.api-sports.io/football/teams/20623.png
20624	Worcester City W	\N	England	https://media.api-sports.io/football/teams/20624.png
20628	Pucklechurch Sports	\N	England	https://media.api-sports.io/football/teams/20628.png
20629	Asfordby Amateurs	\N	England	https://media.api-sports.io/football/teams/20629.png
20630	Dronfield Town	\N	England	https://media.api-sports.io/football/teams/20630.png
20631	Oughtibridge WM	\N	England	https://media.api-sports.io/football/teams/20631.png
20632	Warrington Wolves	\N	England	https://media.api-sports.io/football/teams/20632.png
20633	Ashford United W	\N	England	https://media.api-sports.io/football/teams/20633.png
20634	Bowers & Pitsea W	\N	England	https://media.api-sports.io/football/teams/20634.png
20635	Colney Heath W	\N	England	https://media.api-sports.io/football/teams/20635.png
20636	Consett W	\N	England	https://media.api-sports.io/football/teams/20636.png
20637	Ebbsfleet United W	\N	England	https://media.api-sports.io/football/teams/20637.png
20638	Needham Market W	\N	England	https://media.api-sports.io/football/teams/20638.png
20639	Royston Town W	\N	England	https://media.api-sports.io/football/teams/20639.png
20640	Weymouth W	\N	England	https://media.api-sports.io/football/teams/20640.png
21385	Chester City	\N	England	https://media.api-sports.io/football/teams/21385.png
21466	England U18	\N	England	https://media.api-sports.io/football/teams/21466.png
21515	Euxton Villa	\N	England	https://media.api-sports.io/football/teams/21515.png
21621	FC MK	\N	England	https://media.api-sports.io/football/teams/21621.png
21700	Ashby Ivanhoe	\N	England	https://media.api-sports.io/football/teams/21700.png
21701	Aylestone Park	\N	England	https://media.api-sports.io/football/teams/21701.png
21702	Boro Rangers	\N	England	https://media.api-sports.io/football/teams/21702.png
21703	Downham Town	\N	England	https://media.api-sports.io/football/teams/21703.png
21704	Frenford	\N	England	https://media.api-sports.io/football/teams/21704.png
21705	Harleston Town	\N	England	https://media.api-sports.io/football/teams/21705.png
21706	Hartpury University	\N	England	https://media.api-sports.io/football/teams/21706.png
21707	Heacham	\N	England	https://media.api-sports.io/football/teams/21707.png
21708	Lydd Town	\N	England	https://media.api-sports.io/football/teams/21708.png
21709	Nailsea & Tickenham	\N	England	https://media.api-sports.io/football/teams/21709.png
21710	Okehampton Argyle	\N	England	https://media.api-sports.io/football/teams/21710.png
21711	Pilkington	\N	England	https://media.api-sports.io/football/teams/21711.png
21712	Real Bedford	\N	England	https://media.api-sports.io/football/teams/21712.png
21713	Rugby Borough	\N	England	https://media.api-sports.io/football/teams/21713.png
21714	Snodland Town	\N	England	https://media.api-sports.io/football/teams/21714.png
21715	Stockport Town	\N	England	https://media.api-sports.io/football/teams/21715.png
21716	Wallingford & Crowmarsh	\N	England	https://media.api-sports.io/football/teams/21716.png
21717	Wendron United	\N	England	https://media.api-sports.io/football/teams/21717.png
21904	Cheadle Heath Nomads	\N	England	https://media.api-sports.io/football/teams/21904.png
22068	Barrow Res.	\N	England	https://media.api-sports.io/football/teams/22068.png
22069	Derby County Res.	\N	England	https://media.api-sports.io/football/teams/22069.png
22070	Lincoln City Res.	\N	England	https://media.api-sports.io/football/teams/22070.png
22071	Mansfield Town Res.	\N	England	https://media.api-sports.io/football/teams/22071.png
22072	Notts County Res.	\N	England	https://media.api-sports.io/football/teams/22072.png
22073	Salford City Res.	\N	England	https://media.api-sports.io/football/teams/22073.png
22074	Sunderland Res.	\N	England	https://media.api-sports.io/football/teams/22074.png
22173	Fleetwood Town U21	\N	England	https://media.api-sports.io/football/teams/22173.png
22174	Luton Town U21	\N	England	https://media.api-sports.io/football/teams/22174.png
22254	England U16	\N	England	https://media.api-sports.io/football/teams/22254.png
22371	Arsenal U19	\N	England	https://media.api-sports.io/football/teams/22371.png
22607	AEK Boco	\N	England	https://media.api-sports.io/football/teams/22607.png
22608	AFC Sudbury Ladies	\N	England	https://media.api-sports.io/football/teams/22608.png
22609	AFC Whyteleafe	\N	England	https://media.api-sports.io/football/teams/22609.png
22610	Arnold Eagles	\N	England	https://media.api-sports.io/football/teams/22610.png
22611	Ashmount Leigh	\N	England	https://media.api-sports.io/football/teams/22611.png
22612	Beaumont Park	\N	England	https://media.api-sports.io/football/teams/22612.png
22613	Blackpool Ladies	\N	England	https://media.api-sports.io/football/teams/22613.png
22614	Bolton Wanderers	\N	England	https://media.api-sports.io/football/teams/22614.png
22615	Brunsmeer Athletic	\N	England	https://media.api-sports.io/football/teams/22615.png
22616	Coundon Court	\N	England	https://media.api-sports.io/football/teams/22616.png
22617	Crusaders	\N	England	https://media.api-sports.io/football/teams/22617.png
22618	Denham United	\N	England	https://media.api-sports.io/football/teams/22618.png
22619	Downend Flyers FC	\N	England	https://media.api-sports.io/football/teams/22619.png
22620	Dunton & Broughton Utd	\N	England	https://media.api-sports.io/football/teams/22620.png
22621	Dussindale & Hellesdon	\N	England	https://media.api-sports.io/football/teams/22621.png
22622	Forest Green Rovers	\N	England	https://media.api-sports.io/football/teams/22622.png
22623	Gloucester City LFC	\N	England	https://media.api-sports.io/football/teams/22623.png
22624	Hartlepool Pools Youth	\N	England	https://media.api-sports.io/football/teams/22624.png
22625	Headstone Manor	\N	England	https://media.api-sports.io/football/teams/22625.png
22626	Hull United	\N	England	https://media.api-sports.io/football/teams/22626.png
22627	Inkberrow	\N	England	https://media.api-sports.io/football/teams/22627.png
22628	Islington Borough	\N	England	https://media.api-sports.io/football/teams/22628.png
22629	Lawford	\N	England	https://media.api-sports.io/football/teams/22629.png
22630	Leamington Lions	\N	England	https://media.api-sports.io/football/teams/22630.png
22631	Leeds Modernians	\N	England	https://media.api-sports.io/football/teams/22631.png
22632	Long Itchington	\N	England	https://media.api-sports.io/football/teams/22632.png
22633	Mancunian Unity	\N	England	https://media.api-sports.io/football/teams/22633.png
22634	Marine Academy Plymouth	\N	England	https://media.api-sports.io/football/teams/22634.png
22635	Montpelier Villa	\N	England	https://media.api-sports.io/football/teams/22635.png
22636	Nottingham Trent	\N	England	https://media.api-sports.io/football/teams/22636.png
22637	Oxford City WFC	\N	England	https://media.api-sports.io/football/teams/22637.png
22638	Plympton	\N	England	https://media.api-sports.io/football/teams/22638.png
22639	Poulton Victoria	\N	England	https://media.api-sports.io/football/teams/22639.png
22640	QK	\N	England	https://media.api-sports.io/football/teams/22640.png
22641	Richmond & Kew	\N	England	https://media.api-sports.io/football/teams/22641.png
22642	Rotherham United	\N	England	https://media.api-sports.io/football/teams/22642.png
22643	Royal Wootton Bassett	\N	England	https://media.api-sports.io/football/teams/22643.png
22644	Rushden & Diamonds LFC	\N	England	https://media.api-sports.io/football/teams/22644.png
22645	Solihull Sporting	\N	England	https://media.api-sports.io/football/teams/22645.png
22646	Sport London e Benfica	\N	England	https://media.api-sports.io/football/teams/22646.png
22647	St Josephs Rockware	\N	England	https://media.api-sports.io/football/teams/22647.png
22648	Sticker	\N	England	https://media.api-sports.io/football/teams/22648.png
22649	Sunderland West End	\N	England	https://media.api-sports.io/football/teams/22649.png
22650	Teignmouth	\N	England	https://media.api-sports.io/football/teams/22650.png
22651	Watford Development	\N	England	https://media.api-sports.io/football/teams/22651.png
22652	Wigan Athletic	\N	England	https://media.api-sports.io/football/teams/22652.png
22653	Winchester City Flyers	\N	England	https://media.api-sports.io/football/teams/22653.png
22654	Woodley United	\N	England	https://media.api-sports.io/football/teams/22654.png
22655	Wyberton Wildcats	\N	England	https://media.api-sports.io/football/teams/22655.png
22656	Wycombe Wanderers	\N	England	https://media.api-sports.io/football/teams/22656.png
22657	Wythenshawe	\N	England	https://media.api-sports.io/football/teams/22657.png
22658	York Railway Institute	\N	England	https://media.api-sports.io/football/teams/22658.png
22659	AFC Portchester W	\N	England	https://media.api-sports.io/football/teams/22659.png
22660	Anstey Nomads W	\N	England	https://media.api-sports.io/football/teams/22660.png
22661	Basford United W	\N	England	https://media.api-sports.io/football/teams/22661.png
22662	Birtley Town W	\N	England	https://media.api-sports.io/football/teams/22662.png
22663	Bitton W	\N	England	https://media.api-sports.io/football/teams/22663.png
22664	Brantham Athletic W	\N	England	https://media.api-sports.io/football/teams/22664.png
22665	Brentford W	\N	England	https://media.api-sports.io/football/teams/22665.png
22666	Bristol Rovers W	\N	England	https://media.api-sports.io/football/teams/22666.png
22667	Bugbrooke St Michaels W	\N	England	https://media.api-sports.io/football/teams/22667.png
22668	Bury W	\N	England	https://media.api-sports.io/football/teams/22668.png
22669	Chester W	\N	England	https://media.api-sports.io/football/teams/22669.png
22670	Chesterfield W	\N	England	https://media.api-sports.io/football/teams/22670.png
22671	Colne W	\N	England	https://media.api-sports.io/football/teams/22671.png
22672	Fakenham Town W	\N	England	https://media.api-sports.io/football/teams/22672.png
22673	Gateshead W	\N	England	https://media.api-sports.io/football/teams/22673.png
22674	Guisborough Town W	\N	England	https://media.api-sports.io/football/teams/22674.png
22675	Haringey Borough W	\N	England	https://media.api-sports.io/football/teams/22675.png
22676	Harpenden Town W	\N	England	https://media.api-sports.io/football/teams/22676.png
22677	Haywards Heath Town W	\N	England	https://media.api-sports.io/football/teams/22677.png
22678	Helston Athletic W	\N	England	https://media.api-sports.io/football/teams/22678.png
22679	Hertford Town W	\N	England	https://media.api-sports.io/football/teams/22679.png
22680	Kidderminster Harriers W	\N	England	https://media.api-sports.io/football/teams/22680.png
22681	Langford W	\N	England	https://media.api-sports.io/football/teams/22681.png
22682	Mansfield Town W	\N	England	https://media.api-sports.io/football/teams/22682.png
22683	Margate W	\N	England	https://media.api-sports.io/football/teams/22683.png
22684	Notts County W	\N	England	https://media.api-sports.io/football/teams/22684.png
22685	Ossett United W	\N	England	https://media.api-sports.io/football/teams/22685.png
22686	Port Vale W	\N	England	https://media.api-sports.io/football/teams/22686.png
22687	Real Bedford W	\N	England	https://media.api-sports.io/football/teams/22687.png
22688	Saltdean United W	\N	England	https://media.api-sports.io/football/teams/22688.png
22689	Selsey W	\N	England	https://media.api-sports.io/football/teams/22689.png
22690	Sittingbourne W	\N	England	https://media.api-sports.io/football/teams/22690.png
22691	Spennymoor Town W	\N	England	https://media.api-sports.io/football/teams/22691.png
22692	Thetford Town W	\N	England	https://media.api-sports.io/football/teams/22692.png
22693	Thrapston Town W	\N	England	https://media.api-sports.io/football/teams/22693.png
22694	United Services W	\N	England	https://media.api-sports.io/football/teams/22694.png
22695	Wakefield AFC W	\N	England	https://media.api-sports.io/football/teams/22695.png
22696	West Didsbury & Chorlton W	\N	England	https://media.api-sports.io/football/teams/22696.png
22697	Wodson Park W	\N	England	https://media.api-sports.io/football/teams/22697.png
22698	Wroxham W	\N	England	https://media.api-sports.io/football/teams/22698.png
22700	Halifax	\N	England	https://media.api-sports.io/football/teams/22700.png
22701	Chatham Town W	\N	England	https://media.api-sports.io/football/teams/22701.png
22702	Rugby Borough W	\N	England	https://media.api-sports.io/football/teams/22702.png
23159	AFC Bournemouth U18	\N	England	https://media.api-sports.io/football/teams/23159.png
23160	AFC Fylde U18	\N	England	https://media.api-sports.io/football/teams/23160.png
23161	AFC Wimbledon U18	\N	England	https://media.api-sports.io/football/teams/23161.png
23162	Barking U18	\N	England	https://media.api-sports.io/football/teams/23162.png
23163	Barnsley U18	\N	England	https://media.api-sports.io/football/teams/23163.png
23164	Brentford U18	\N	England	https://media.api-sports.io/football/teams/23164.png
23165	Bristol City U18	\N	England	https://media.api-sports.io/football/teams/23165.png
23166	Burton Albion U18	\N	England	https://media.api-sports.io/football/teams/23166.png
23167	Cardiff City U18	\N	England	https://media.api-sports.io/football/teams/23167.png
23168	Charlton Athletic U18	\N	England	https://media.api-sports.io/football/teams/23168.png
23169	Cheltenham Town U18	\N	England	https://media.api-sports.io/football/teams/23169.png
23170	Coventry City U18	\N	England	https://media.api-sports.io/football/teams/23170.png
23171	Crewe Alexandra U18	\N	England	https://media.api-sports.io/football/teams/23171.png
23172	Fleetwood Town U18	\N	England	https://media.api-sports.io/football/teams/23172.png
23173	Gillingham U18	\N	England	https://media.api-sports.io/football/teams/23173.png
23174	Grimsby Town U18	\N	England	https://media.api-sports.io/football/teams/23174.png
23175	Harrogate Town U18	\N	England	https://media.api-sports.io/football/teams/23175.png
23176	Hemel Hempstead Town U18	\N	England	https://media.api-sports.io/football/teams/23176.png
23177	Huddersfield Town U18	\N	England	https://media.api-sports.io/football/teams/23177.png
23178	Hull City U18	\N	England	https://media.api-sports.io/football/teams/23178.png
23179	Ipswich Town U18	\N	England	https://media.api-sports.io/football/teams/23179.png
23180	Leyton Orient U18	\N	England	https://media.api-sports.io/football/teams/23180.png
23181	Lincoln City U18	\N	England	https://media.api-sports.io/football/teams/23181.png
23182	Luton Town U18	\N	England	https://media.api-sports.io/football/teams/23182.png
23183	Millwall U18	\N	England	https://media.api-sports.io/football/teams/23183.png
23184	Oxford United U18	\N	England	https://media.api-sports.io/football/teams/23184.png
23185	Plymouth Argyle U18	\N	England	https://media.api-sports.io/football/teams/23185.png
23186	Preston North End U18	\N	England	https://media.api-sports.io/football/teams/23186.png
23187	Queens Park Rangers U18	\N	England	https://media.api-sports.io/football/teams/23187.png
23188	Rotherham U18	\N	England	https://media.api-sports.io/football/teams/23188.png
23189	Sheffield United U18	\N	England	https://media.api-sports.io/football/teams/23189.png
23190	Sheffield Wednesday U18	\N	England	https://media.api-sports.io/football/teams/23190.png
23191	Stockport County U18	\N	England	https://media.api-sports.io/football/teams/23191.png
23192	Swansea City U18	\N	England	https://media.api-sports.io/football/teams/23192.png
23193	Swindon Town U18	\N	England	https://media.api-sports.io/football/teams/23193.png
23194	Watford U18	\N	England	https://media.api-sports.io/football/teams/23194.png
24331	Amersham Town	\N	England	https://media.api-sports.io/football/teams/24331.png
24332	Berks County	\N	England	https://media.api-sports.io/football/teams/24332.png
24333	Beverley Town	\N	England	https://media.api-sports.io/football/teams/24333.png
24334	Blyth Town	\N	England	https://media.api-sports.io/football/teams/24334.png
24335	Bourne Town	\N	England	https://media.api-sports.io/football/teams/24335.png
24336	British Airways	\N	England	https://media.api-sports.io/football/teams/24336.png
24337	Cornard United	\N	England	https://media.api-sports.io/football/teams/24337.png
24338	Easington Colliery	\N	England	https://media.api-sports.io/football/teams/24338.png
24339	Hamworthy Recreation	\N	England	https://media.api-sports.io/football/teams/24339.png
24340	Ivybridge Town	\N	England	https://media.api-sports.io/football/teams/24340.png
24341	Larkfield & New Hythe	\N	England	https://media.api-sports.io/football/teams/24341.png
24342	Millbrook FC	\N	England	https://media.api-sports.io/football/teams/24342.png
24343	Newark Town	\N	England	https://media.api-sports.io/football/teams/24343.png
24344	Newcastle Blue Star	\N	England	https://media.api-sports.io/football/teams/24344.png
24345	Pershore Town	\N	England	https://media.api-sports.io/football/teams/24345.png
24346	Portishead Town	\N	England	https://media.api-sports.io/football/teams/24346.png
24347	South Liverpool	\N	England	https://media.api-sports.io/football/teams/24347.png
24348	Sporting Club Inkberrow	\N	England	https://media.api-sports.io/football/teams/24348.png
24349	St Helens	\N	England	https://media.api-sports.io/football/teams/24349.png
24350	Wick	\N	England	https://media.api-sports.io/football/teams/24350.png
24351	Wormley Rovers	\N	England	https://media.api-sports.io/football/teams/24351.png
24354	AFC Whyteleafe	\N	England	https://media.api-sports.io/football/teams/24354.png
24355	Boston Town	\N	England	https://media.api-sports.io/football/teams/24355.png
24846	Bromley U21	\N	England	https://media.api-sports.io/football/teams/24846.png
24847	Exeter U21	\N	England	https://media.api-sports.io/football/teams/24847.png
24848	Preston North End U21	\N	England	https://media.api-sports.io/football/teams/24848.png
24849	Stockport County U21	\N	England	https://media.api-sports.io/football/teams/24849.png
24970	Aston Villa U19	\N	England	https://media.api-sports.io/football/teams/24970.png
25122	Wokingham Town	\N	England	https://media.api-sports.io/football/teams/25122.png
25134	Accrington Stanley	\N	England	https://media.api-sports.io/football/teams/25134.png
25135	Bradworthy	\N	England	https://media.api-sports.io/football/teams/25135.png
25136	Bungay Town	\N	England	https://media.api-sports.io/football/teams/25136.png
25137	Bursledon	\N	England	https://media.api-sports.io/football/teams/25137.png
25138	Camden & Islington Utd	\N	England	https://media.api-sports.io/football/teams/25138.png
25139	Comets	\N	England	https://media.api-sports.io/football/teams/25139.png
25140	Costessey Sports	\N	England	https://media.api-sports.io/football/teams/25140.png
25141	Handsworth	\N	England	https://media.api-sports.io/football/teams/25141.png
25142	Havant & Waterlooville	\N	England	https://media.api-sports.io/football/teams/25142.png
25143	Hutton	\N	England	https://media.api-sports.io/football/teams/25143.png
25144	Leicester City LFC	\N	England	https://media.api-sports.io/football/teams/25144.png
25145	Long Stratton	\N	England	https://media.api-sports.io/football/teams/25145.png
25146	MSB Woolton	\N	England	https://media.api-sports.io/football/teams/25146.png
25147	Penn & Tylers Green	\N	England	https://media.api-sports.io/football/teams/25147.png
25148	Preston North End	\N	England	https://media.api-sports.io/football/teams/25148.png
25149	Redditch Borough	\N	England	https://media.api-sports.io/football/teams/25149.png
25150	River City	\N	England	https://media.api-sports.io/football/teams/25150.png
25151	Saltash Burough	\N	England	https://media.api-sports.io/football/teams/25151.png
25152	South London	\N	England	https://media.api-sports.io/football/teams/25152.png
25153	St Agnes	\N	England	https://media.api-sports.io/football/teams/25153.png
25154	Stanway Pegasus	\N	England	https://media.api-sports.io/football/teams/25154.png
25155	Alvechurch W	\N	England	https://media.api-sports.io/football/teams/25155.png
25156	Barking W	\N	England	https://media.api-sports.io/football/teams/25156.png
25157	Curzon Ashton W	\N	England	https://media.api-sports.io/football/teams/25157.png
25158	Darlington W	\N	England	https://media.api-sports.io/football/teams/25158.png
25159	Farnham Town W	\N	England	https://media.api-sports.io/football/teams/25159.png
25160	Fleet Town W	\N	England	https://media.api-sports.io/football/teams/25160.png
25161	Hereford W	\N	England	https://media.api-sports.io/football/teams/25161.png
25162	Horsham W	\N	England	https://media.api-sports.io/football/teams/25162.png
25163	Macclesfield W	\N	England	https://media.api-sports.io/football/teams/25163.png
25164	Nantwich Town W	\N	England	https://media.api-sports.io/football/teams/25164.png
25165	Newport Pagnell Town W	\N	England	https://media.api-sports.io/football/teams/25165.png
25166	Redditch United W	\N	England	https://media.api-sports.io/football/teams/25166.png
25167	Rossington Main W	\N	England	https://media.api-sports.io/football/teams/25167.png
25168	Saltash United W	\N	England	https://media.api-sports.io/football/teams/25168.png
25169	Sholing W	\N	England	https://media.api-sports.io/football/teams/25169.png
25170	St Albans City W	\N	England	https://media.api-sports.io/football/teams/25170.png
25171	St Helens W	\N	England	https://media.api-sports.io/football/teams/25171.png
25172	Stamford W	\N	England	https://media.api-sports.io/football/teams/25172.png
25173	Thornaby W	\N	England	https://media.api-sports.io/football/teams/25173.png
25174	Walsall W	\N	England	https://media.api-sports.io/football/teams/25174.png
25175	Washington W	\N	England	https://media.api-sports.io/football/teams/25175.png
25176	Wormley Rovers W	\N	England	https://media.api-sports.io/football/teams/25176.png
25183	Bishop's Cleeve W	\N	England	https://media.api-sports.io/football/teams/25183.png
25184	Hednesford Town W	\N	England	https://media.api-sports.io/football/teams/25184.png
25185	Ilkeston Town W	\N	England	https://media.api-sports.io/football/teams/25185.png
25186	Poole Town W	\N	England	https://media.api-sports.io/football/teams/25186.png
25187	Sleaford Town W	\N	England	https://media.api-sports.io/football/teams/25187.png
25188	Wellingborough Town W	\N	England	https://media.api-sports.io/football/teams/25188.png
25227	England U17 W	\N	England	https://media.api-sports.io/football/teams/25227.png
25407	Carlisle United U18	\N	England	https://media.api-sports.io/football/teams/25407.png
25408	Chesterfield U18	\N	England	https://media.api-sports.io/football/teams/25408.png
25409	Exeter City U18	\N	England	https://media.api-sports.io/football/teams/25409.png
25410	Notts County U18	\N	England	https://media.api-sports.io/football/teams/25410.png
25411	Portsmouth U18	\N	England	https://media.api-sports.io/football/teams/25411.png
25412	Stevenage U18	\N	England	https://media.api-sports.io/football/teams/25412.png
25423	Accrington Stanley U18	\N	England	https://media.api-sports.io/football/teams/25423.png
25424	Burgess Hill Town U18	\N	England	https://media.api-sports.io/football/teams/25424.png
25425	Hertford Town U18	\N	England	https://media.api-sports.io/football/teams/25425.png
25426	Merstham U18	\N	England	https://media.api-sports.io/football/teams/25426.png
25427	Woking U18	\N	England	https://media.api-sports.io/football/teams/25427.png
25428	Wrexham U18	\N	England	https://media.api-sports.io/football/teams/25428.png
118	Bahia	BAH	Brazil	https://media.api-sports.io/football/teams/118.png
119	Internacional	INT	Brazil	https://media.api-sports.io/football/teams/119.png
120	Botafogo	BOT	Brazil	https://media.api-sports.io/football/teams/120.png
121	Palmeiras	PAL	Brazil	https://media.api-sports.io/football/teams/121.png
122	Parana	PAR	Brazil	https://media.api-sports.io/football/teams/122.png
123	Sport Recife	SPO	Brazil	https://media.api-sports.io/football/teams/123.png
124	Fluminense	FLU	Brazil	https://media.api-sports.io/football/teams/124.png
125	America Mineiro	AME	Brazil	https://media.api-sports.io/football/teams/125.png
126	Sao Paulo	PAU	Brazil	https://media.api-sports.io/football/teams/126.png
127	Flamengo	FLA	Brazil	https://media.api-sports.io/football/teams/127.png
128	Santos	SAN	Brazil	https://media.api-sports.io/football/teams/128.png
129	Ceara	CEA	Brazil	https://media.api-sports.io/football/teams/129.png
130	Gremio	GRE	Brazil	https://media.api-sports.io/football/teams/130.png
131	Corinthians	COR	Brazil	https://media.api-sports.io/football/teams/131.png
132	Chapecoense-sc	CHA	Brazil	https://media.api-sports.io/football/teams/132.png
133	Vasco DA Gama	VAS	Brazil	https://media.api-sports.io/football/teams/133.png
134	Atletico Paranaense	ATL	Brazil	https://media.api-sports.io/football/teams/134.png
135	Cruzeiro	CRU	Brazil	https://media.api-sports.io/football/teams/135.png
136	Vitoria	VIT	Brazil	https://media.api-sports.io/football/teams/136.png
137	Figueirense	FIG	Brazil	https://media.api-sports.io/football/teams/137.png
138	Guarani Campinas	GUA	Brazil	https://media.api-sports.io/football/teams/138.png
139	Ponte Preta	PON	Brazil	https://media.api-sports.io/football/teams/139.png
140	Criciuma	CRI	Brazil	https://media.api-sports.io/football/teams/140.png
141	Brasil DE Pelotas	GEB	Brazil	https://media.api-sports.io/football/teams/141.png
142	Vila Nova	VIL	Brazil	https://media.api-sports.io/football/teams/142.png
143	Oeste	OES	Brazil	https://media.api-sports.io/football/teams/143.png
144	Atletico Goianiense	ATL	Brazil	https://media.api-sports.io/football/teams/144.png
145	Avai	AVA	Brazil	https://media.api-sports.io/football/teams/145.png
146	CRB	CRB	Brazil	https://media.api-sports.io/football/teams/146.png
147	Coritiba	COR	Brazil	https://media.api-sports.io/football/teams/147.png
148	Londrina	LON	Brazil	https://media.api-sports.io/football/teams/148.png
149	Paysandu	PAY	Brazil	https://media.api-sports.io/football/teams/149.png
150	CSA	CSA	Brazil	https://media.api-sports.io/football/teams/150.png
151	Goias	GOI	Brazil	https://media.api-sports.io/football/teams/151.png
152	Juventude	JUV	Brazil	https://media.api-sports.io/football/teams/152.png
153	BOA	BOA	Brazil	https://media.api-sports.io/football/teams/153.png
154	Fortaleza EC	FOR	Brazil	https://media.api-sports.io/football/teams/154.png
155	Sampaio Correa	SAM	Brazil	https://media.api-sports.io/football/teams/155.png
156	Sao Bento	\N	Brazil	https://media.api-sports.io/football/teams/156.png
752	Luverdense	LUV	Brazil	https://media.api-sports.io/football/teams/752.png
753	Santa Cruz	\N	Brazil	https://media.api-sports.io/football/teams/753.png
754	ABC	ABC	Brazil	https://media.api-sports.io/football/teams/754.png
755	Nautico Recife	NAU	Brazil	https://media.api-sports.io/football/teams/755.png
760	Real	\N	Brazil	https://media.api-sports.io/football/teams/760.png
794	RB Bragantino	BRA	Brazil	https://media.api-sports.io/football/teams/794.png
795	Joinville	JOI	Brazil	https://media.api-sports.io/football/teams/795.png
796	Tupi	TUP	Brazil	https://media.api-sports.io/football/teams/796.png
1062	Atletico-MG	ATL	Brazil	https://media.api-sports.io/football/teams/1062.png
1193	Cuiaba	CUI	Brazil	https://media.api-sports.io/football/teams/1193.png
1194	Cianorte	CIA	Brazil	https://media.api-sports.io/football/teams/1194.png
1195	Ferroviario	FER	Brazil	https://media.api-sports.io/football/teams/1195.png
1196	Uberlandia	\N	Brazil	https://media.api-sports.io/football/teams/1196.png
1197	Botafogo PB	BOT	Brazil	https://media.api-sports.io/football/teams/1197.png
1198	remo	REM	Brazil	https://media.api-sports.io/football/teams/1198.png
1199	Novo Hamburgo	HAM	Brazil	https://media.api-sports.io/football/teams/1199.png
1200	Fluminense De Feira	\N	Brazil	https://media.api-sports.io/football/teams/1200.png
1201	Inter De Limeira	\N	Brazil	https://media.api-sports.io/football/teams/1201.png
1202	Aparecidense	APA	Brazil	https://media.api-sports.io/football/teams/1202.png
1203	Altos	\N	Brazil	https://media.api-sports.io/football/teams/1203.png
1204	Tubarao	\N	Brazil	https://media.api-sports.io/football/teams/1204.png
1205	Salgueiro	SAC	Brazil	https://media.api-sports.io/football/teams/1205.png
1206	Corumbaense	\N	Brazil	https://media.api-sports.io/football/teams/1206.png
1207	ASA	ASA	Brazil	https://media.api-sports.io/football/teams/1207.png
1208	Gurupi	GUR	Brazil	https://media.api-sports.io/football/teams/1208.png
1210	Murici Fc	\N	Brazil	https://media.api-sports.io/football/teams/1210.png
1211	Brusque	BRU	Brazil	https://media.api-sports.io/football/teams/1211.png
1212	PSTC Procopense	\N	Brazil	https://media.api-sports.io/football/teams/1212.png
1213	Sinop Fc	\N	Brazil	https://media.api-sports.io/football/teams/1213.png
1214	Portuguesa	POR	Brazil	https://media.api-sports.io/football/teams/1214.png
1216	Guarani De Juazeiro	GUA	Brazil	https://media.api-sports.io/football/teams/1216.png
1217	Gremio Osasco Audax	AUD	Brazil	https://media.api-sports.io/football/teams/1217.png
1218	Sao Raimundo	\N	Brazil	https://media.api-sports.io/football/teams/1218.png
1219	Sao Francisco	\N	Brazil	https://media.api-sports.io/football/teams/1219.png
1220	Sete De Dourados	\N	Brazil	https://media.api-sports.io/football/teams/1220.png
1221	Ypiranga-RS	\N	Brazil	https://media.api-sports.io/football/teams/1221.png
1222	Gama	\N	Brazil	https://media.api-sports.io/football/teams/1222.png
1223	Operario-PR	\N	Brazil	https://media.api-sports.io/football/teams/1223.png
1224	Juazeirense	JUA	Brazil	https://media.api-sports.io/football/teams/1224.png
1225	Vitoria Da Conquista	VIT	Brazil	https://media.api-sports.io/football/teams/1225.png
1226	Dom Bosco	\N	Brazil	https://media.api-sports.io/football/teams/1226.png
1227	River-Pi	\N	Brazil	https://media.api-sports.io/football/teams/1227.png
1228	Galvez	\N	Brazil	https://media.api-sports.io/football/teams/1228.png
1229	Genus	GEN	Brazil	https://media.api-sports.io/football/teams/1229.png
1726	Brazil W	\N	Brazil	https://media.api-sports.io/football/teams/1726.png
1793	Rio Preto W	\N	Brazil	https://media.api-sports.io/football/teams/1793.png
1794	Flamengo W	\N	Brazil	https://media.api-sports.io/football/teams/1794.png
1795	Ferroviaria W	\N	Brazil	https://media.api-sports.io/football/teams/1795.png
1796	Sao Jose W	\N	Brazil	https://media.api-sports.io/football/teams/1796.png
1797	Foz Cataratas W	\N	Brazil	https://media.api-sports.io/football/teams/1797.png
1798	Corinthians W	\N	Brazil	https://media.api-sports.io/football/teams/1798.png
1799	Iranduba W	\N	Brazil	https://media.api-sports.io/football/teams/1799.png
1800	Sao Francisco W	\N	Brazil	https://media.api-sports.io/football/teams/1800.png
1801	Portuguesa W	\N	Brazil	https://media.api-sports.io/football/teams/1801.png
1802	America Mineiro W	\N	Brazil	https://media.api-sports.io/football/teams/1802.png
1803	Vasco Da Gama W	\N	Brazil	https://media.api-sports.io/football/teams/1803.png
1804	Ec Vitoria W	\N	Brazil	https://media.api-sports.io/football/teams/1804.png
1805	Duque De Caxias W	\N	Brazil	https://media.api-sports.io/football/teams/1805.png
1806	Vitoria Das Tab. W	\N	Brazil	https://media.api-sports.io/football/teams/1806.png
1807	Tiradentes W	\N	Brazil	https://media.api-sports.io/football/teams/1807.png
1808	Caucaia W	\N	Brazil	https://media.api-sports.io/football/teams/1808.png
1809	Pinheirense W	\N	Brazil	https://media.api-sports.io/football/teams/1809.png
1810	Viana W	\N	Brazil	https://media.api-sports.io/football/teams/1810.png
1811	Santos W	\N	Brazil	https://media.api-sports.io/football/teams/1811.png
1812	Adeco W	\N	Brazil	https://media.api-sports.io/football/teams/1812.png
1813	Gremio Osasco Audax W	\N	Brazil	https://media.api-sports.io/football/teams/1813.png
1814	Kindermann W	\N	Brazil	https://media.api-sports.io/football/teams/1814.png
1815	Sport Recife W	\N	Brazil	https://media.api-sports.io/football/teams/1815.png
1816	Ponte Preta W	\N	Brazil	https://media.api-sports.io/football/teams/1816.png
1817	Gremio W	\N	Brazil	https://media.api-sports.io/football/teams/1817.png
1989	Santa Rita	\N	Brazil	https://media.api-sports.io/football/teams/1989.png
2203	Americano Campos	\N	Brazil	https://media.api-sports.io/football/teams/2203.png
2204	AO Itabaiana	\N	Brazil	https://media.api-sports.io/football/teams/2204.png
2205	Avenida	\N	Brazil	https://media.api-sports.io/football/teams/2205.png
2206	Boavista SC	BOA	Brazil	https://media.api-sports.io/football/teams/2206.png
2207	Bragantino PA	\N	Brazil	https://media.api-sports.io/football/teams/2207.png
2208	Brasiliense	BRA	Brazil	https://media.api-sports.io/football/teams/2208.png
2209	Campinense	\N	Brazil	https://media.api-sports.io/football/teams/2209.png
2210	Central SC	CEN	Brazil	https://media.api-sports.io/football/teams/2210.png
2211	Fast Clube-Am	\N	Brazil	https://media.api-sports.io/football/teams/2211.png
2212	Foz Do Iguacu	\N	Brazil	https://media.api-sports.io/football/teams/2212.png
2213	Imperatriz	\N	Brazil	https://media.api-sports.io/football/teams/2213.png
2214	Manaus FC	\N	Brazil	https://media.api-sports.io/football/teams/2214.png
2215	Mixto	MIX	Brazil	https://media.api-sports.io/football/teams/2215.png
2216	Moto Club	\N	Brazil	https://media.api-sports.io/football/teams/2216.png
2217	Operario Ferroviario	\N	Brazil	https://media.api-sports.io/football/teams/2217.png
2218	Palmas	\N	Brazil	https://media.api-sports.io/football/teams/2218.png
2219	Real Desportivo Ariquemes	\N	Brazil	https://media.api-sports.io/football/teams/2219.png
2220	Rio Branco	RIO	Brazil	https://media.api-sports.io/football/teams/2220.png
2221	River AC	\N	Brazil	https://media.api-sports.io/football/teams/2221.png
2222	Santa Cruz RN	\N	Brazil	https://media.api-sports.io/football/teams/2222.png
2223	Sao Raimundo PA	\N	Brazil	https://media.api-sports.io/football/teams/2223.png
2224	Sergipe	SER	Brazil	https://media.api-sports.io/football/teams/2224.png
2225	Serra Talhada	SER	Brazil	https://media.api-sports.io/football/teams/2225.png
2226	Sobradinho EC	\N	Brazil	https://media.api-sports.io/football/teams/2226.png
2227	Tombense	TOM	Brazil	https://media.api-sports.io/football/teams/2227.png
2228	Uniao Trabalhadores	URT	Brazil	https://media.api-sports.io/football/teams/2228.png
2229	Uniclinic Atletico Clube	\N	Brazil	https://media.api-sports.io/football/teams/2229.png
2230	Votuporanguense	\N	Brazil	https://media.api-sports.io/football/teams/2230.png
2231	Ypiranga-PE	YPI	Brazil	https://media.api-sports.io/football/teams/2231.png
2232	Sao Jose	\N	Brazil	https://media.api-sports.io/football/teams/2232.png
2233	America-RN	AME	Brazil	https://media.api-sports.io/football/teams/2233.png
2618	Botafogo SP	BOT	Brazil	https://media.api-sports.io/football/teams/2618.png
3825	Foz-Athletico W	\N	Brazil	https://media.api-sports.io/football/teams/3825.png
3826	Internacional RS W	\N	Brazil	https://media.api-sports.io/football/teams/3826.png
3827	Minas ICESP W	\N	Brazil	https://media.api-sports.io/football/teams/3827.png
3828	Vitória BA W	\N	Brazil	https://media.api-sports.io/football/teams/3828.png
3829	Vitória PE W	\N	Brazil	https://media.api-sports.io/football/teams/3829.png
4655	Grêmio Barueri	BAR	Brazil	https://media.api-sports.io/football/teams/4655.png
4857	Resende	RES	Brazil	https://media.api-sports.io/football/teams/4857.png
6370	Vasco da Gama AC	\N	Brazil	https://media.api-sports.io/football/teams/6370.png
7767	Aimoré	AIM	Brazil	https://media.api-sports.io/football/teams/7767.png
7768	Atlético Acreano	\N	Brazil	https://media.api-sports.io/football/teams/7768.png
7769	Caldense	CAL	Brazil	https://media.api-sports.io/football/teams/7769.png
7770	Caxias	SER	Brazil	https://media.api-sports.io/football/teams/7770.png
7771	Ceilândia	\N	Brazil	https://media.api-sports.io/football/teams/7771.png
7772	Confiança	CON	Brazil	https://media.api-sports.io/football/teams/7772.png
7773	Cordino	\N	Brazil	https://media.api-sports.io/football/teams/7773.png
7774	Floresta	\N	Brazil	https://media.api-sports.io/football/teams/7774.png
7775	Globo	\N	Brazil	https://media.api-sports.io/football/teams/7775.png
7776	Independente PA	\N	Brazil	https://media.api-sports.io/football/teams/7776.png
7777	Interporto	INT	Brazil	https://media.api-sports.io/football/teams/7777.png
7778	Itapemirim	\N	Brazil	https://media.api-sports.io/football/teams/7778.png
7779	Ituano	ITU	Brazil	https://media.api-sports.io/football/teams/7779.png
7780	Madureira	MAD	Brazil	https://media.api-sports.io/football/teams/7780.png
7781	Nacional AM	NAC	Brazil	https://media.api-sports.io/football/teams/7781.png
7782	Nova Iguaçu	NOV	Brazil	https://media.api-sports.io/football/teams/7782.png
7783	Novoperário	\N	Brazil	https://media.api-sports.io/football/teams/7783.png
7784	Parnahyba	PAR	Brazil	https://media.api-sports.io/football/teams/7784.png
7785	Santos AP	\N	Brazil	https://media.api-sports.io/football/teams/7785.png
7786	São Caetano	CAE	Brazil	https://media.api-sports.io/football/teams/7786.png
7787	Treze	TRE	Brazil	https://media.api-sports.io/football/teams/7787.png
7788	União Rondonópolis	\N	Brazil	https://media.api-sports.io/football/teams/7788.png
7814	Volta Redonda	VOL	Brazil	https://media.api-sports.io/football/teams/7814.png
7815	Macaé	\N	Brazil	https://media.api-sports.io/football/teams/7815.png
7816	Mogi Mirim	MOG	Brazil	https://media.api-sports.io/football/teams/7816.png
7817	Guaratinguetá	AME	Brazil	https://media.api-sports.io/football/teams/7817.png
7818	Acadêmica Vitória	ACA	Brazil	https://media.api-sports.io/football/teams/7818.png
7819	América PE	AME	Brazil	https://media.api-sports.io/football/teams/7819.png
7820	Anapolina	NAP	Brazil	https://media.api-sports.io/football/teams/7820.png
7821	Atlético Roraima	\N	Brazil	https://media.api-sports.io/football/teams/7821.png
7822	Bahia de Feira	BDF	Brazil	https://media.api-sports.io/football/teams/7822.png
7823	Barcelona RO	\N	Brazil	https://media.api-sports.io/football/teams/7823.png
7824	CAP	\N	Brazil	https://media.api-sports.io/football/teams/7824.png
7825	Coruripe	\N	Brazil	https://media.api-sports.io/football/teams/7825.png
7826	Ferroviária	\N	Brazil	https://media.api-sports.io/football/teams/7826.png
7827	Gaúcho	\N	Brazil	https://media.api-sports.io/football/teams/7827.png
7828	Hercílio Luz	\N	Brazil	https://media.api-sports.io/football/teams/7828.png
7829	Iporá	\N	Brazil	https://media.api-sports.io/football/teams/7829.png
7830	Itaboraí	\N	Brazil	https://media.api-sports.io/football/teams/7830.png
7831	Jacuipense	JAC	Brazil	https://media.api-sports.io/football/teams/7831.png
7832	Maranhão	MAR	Brazil	https://media.api-sports.io/football/teams/7832.png
7833	Maringá	MAR	Brazil	https://media.api-sports.io/football/teams/7833.png
7834	Novorizontino	\N	Brazil	https://media.api-sports.io/football/teams/7834.png
7835	Portuguesa RJ	\N	Brazil	https://media.api-sports.io/football/teams/7835.png
7836	Serrano PB	\N	Brazil	https://media.api-sports.io/football/teams/7836.png
7837	Vitória ES	\N	Brazil	https://media.api-sports.io/football/teams/7837.png
7838	4 de Julho	\N	Brazil	https://media.api-sports.io/football/teams/7838.png
7839	ASSU	\N	Brazil	https://media.api-sports.io/football/teams/7839.png
7840	Baré	\N	Brazil	https://media.api-sports.io/football/teams/7840.png
7841	Belo Jardim	\N	Brazil	https://media.api-sports.io/football/teams/7841.png
7842	Espírito Santo	\N	Brazil	https://media.api-sports.io/football/teams/7842.png
7843	Flamengo Arcoverde	\N	Brazil	https://media.api-sports.io/football/teams/7843.png
7844	Internacional SC	\N	Brazil	https://media.api-sports.io/football/teams/7844.png
7845	Itumbiara	ITU	Brazil	https://media.api-sports.io/football/teams/7845.png
7846	Linense	LIN	Brazil	https://media.api-sports.io/football/teams/7846.png
7847	Macapá	\N	Brazil	https://media.api-sports.io/football/teams/7847.png
7848	Mirassol	\N	Brazil	https://media.api-sports.io/football/teams/7848.png
7849	Plácido de Castro	PLA	Brazil	https://media.api-sports.io/football/teams/7849.png
7850	Prudentópolis	PRU	Brazil	https://media.api-sports.io/football/teams/7850.png
7851	Sparta	\N	Brazil	https://media.api-sports.io/football/teams/7851.png
7852	Anápolis	ANA	Brazil	https://media.api-sports.io/football/teams/7852.png
7853	Atlético PE	\N	Brazil	https://media.api-sports.io/football/teams/7853.png
7854	Bangu	BAN	Brazil	https://media.api-sports.io/football/teams/7854.png
7855	Comercial MS	\N	Brazil	https://media.api-sports.io/football/teams/7855.png
7856	Desportiva ES	DES	Brazil	https://media.api-sports.io/football/teams/7856.png
7857	Guarany de Sobral	\N	Brazil	https://media.api-sports.io/football/teams/7857.png
7858	Jacobina	\N	Brazil	https://media.api-sports.io/football/teams/7858.png
7859	Luziânia	\N	Brazil	https://media.api-sports.io/football/teams/7859.png
7860	Metropolitano	MET	Brazil	https://media.api-sports.io/football/teams/7860.png
7861	Potiguar Mossoró	POT	Brazil	https://media.api-sports.io/football/teams/7861.png
7862	Princesa Solimões	PRI	Brazil	https://media.api-sports.io/football/teams/7862.png
7863	RB Brasil	\N	Brazil	https://media.api-sports.io/football/teams/7863.png
7864	Sousa	\N	Brazil	https://media.api-sports.io/football/teams/7864.png
7865	São Bernardo	BER	Brazil	https://media.api-sports.io/football/teams/7865.png
7866	São Paulo RS	SC	Brazil	https://media.api-sports.io/football/teams/7866.png
7867	Tocantins Miracema	\N	Brazil	https://media.api-sports.io/football/teams/7867.png
7868	Trem	\N	Brazil	https://media.api-sports.io/football/teams/7868.png
7869	Villa Nova	VIN	Brazil	https://media.api-sports.io/football/teams/7869.png
7870	XV de Piracicaba	NOV	Brazil	https://media.api-sports.io/football/teams/7870.png
7871	Araguaia	\N	Brazil	https://media.api-sports.io/football/teams/7871.png
7873	Goianésia	GOI	Brazil	https://media.api-sports.io/football/teams/7873.png
7874	Icasa	ICA	Brazil	https://media.api-sports.io/football/teams/7874.png
7875	J. Malucelli	MAL	Brazil	https://media.api-sports.io/football/teams/7875.png
7876	Náutico RR	NAU	Brazil	https://media.api-sports.io/football/teams/7876.png
7877	Rondoniense	\N	Brazil	https://media.api-sports.io/football/teams/7877.png
7878	Tocantinópolis	\N	Brazil	https://media.api-sports.io/football/teams/7878.png
7879	Águia de Marabá	AGU	Brazil	https://media.api-sports.io/football/teams/7879.png
8136	Vénus	\N	Brazil	https://media.api-sports.io/football/teams/8136.png
9124	CEO	\N	Brazil	https://media.api-sports.io/football/teams/9124.png
9125	Dimensão Saúde	\N	Brazil	https://media.api-sports.io/football/teams/9125.png
9126	Jacyobá	\N	Brazil	https://media.api-sports.io/football/teams/9126.png
9127	CSE	\N	Brazil	https://media.api-sports.io/football/teams/9127.png
9128	Miguelense	\N	Brazil	https://media.api-sports.io/football/teams/9128.png
9129	Sete de Setembro	\N	Brazil	https://media.api-sports.io/football/teams/9129.png
9980	Cruzeiro W	\N	Brazil	https://media.api-sports.io/football/teams/9980.png
9981	Palmeiras W	\N	Brazil	https://media.api-sports.io/football/teams/9981.png
9982	São Paulo W	\N	Brazil	https://media.api-sports.io/football/teams/9982.png
9994	Toledo	\N	Brazil	https://media.api-sports.io/football/teams/9994.png
9995	Afogados	\N	Brazil	https://media.api-sports.io/football/teams/9995.png
9996	Aquidauanense	\N	Brazil	https://media.api-sports.io/football/teams/9996.png
9997	Atlético Alagoinhas	\N	Brazil	https://media.api-sports.io/football/teams/9997.png
9998	Barbalha	\N	Brazil	https://media.api-sports.io/football/teams/9998.png
9999	CEOV Operário	\N	Brazil	https://media.api-sports.io/football/teams/9999.png
10000	Caucaia	\N	Brazil	https://media.api-sports.io/football/teams/10000.png
10001	Frei Paulistano	\N	Brazil	https://media.api-sports.io/football/teams/10001.png
10002	Lagarto	LAG	Brazil	https://media.api-sports.io/football/teams/10002.png
10003	Santo André	SAN	Brazil	https://media.api-sports.io/football/teams/10003.png
10004	São Luiz	SAO	Brazil	https://media.api-sports.io/football/teams/10004.png
10005	Vilhenense	\N	Brazil	https://media.api-sports.io/football/teams/10005.png
10006	Águia Negra	AGU	Brazil	https://media.api-sports.io/football/teams/10006.png
10018	Água Santa	\N	Brazil	https://media.api-sports.io/football/teams/10018.png
10019	Juventus	\N	Brazil	https://media.api-sports.io/football/teams/10019.png
10020	Atibaia	\N	Brazil	https://media.api-sports.io/football/teams/10020.png
10021	Monte Azul	\N	Brazil	https://media.api-sports.io/football/teams/10021.png
10022	Penapolense	PEN	Brazil	https://media.api-sports.io/football/teams/10022.png
10023	Portuguesa Santista	\N	Brazil	https://media.api-sports.io/football/teams/10023.png
10024	Rio Claro	CLA	Brazil	https://media.api-sports.io/football/teams/10024.png
10025	Sertãozinho	\N	Brazil	https://media.api-sports.io/football/teams/10025.png
10026	Taubaté	\N	Brazil	https://media.api-sports.io/football/teams/10026.png
10027	Olímpia	OLI	Brazil	https://media.api-sports.io/football/teams/10027.png
10028	Barretos	\N	Brazil	https://media.api-sports.io/football/teams/10028.png
10029	Batatais	TAT	Brazil	https://media.api-sports.io/football/teams/10029.png
10030	Capivariano	\N	Brazil	https://media.api-sports.io/football/teams/10030.png
10031	Comercial	COM	Brazil	https://media.api-sports.io/football/teams/10031.png
10032	Desportivo Brasil	\N	Brazil	https://media.api-sports.io/football/teams/10032.png
10033	EC São Bernardo	NAR	Brazil	https://media.api-sports.io/football/teams/10033.png
10034	Grêmio Osasco	\N	Brazil	https://media.api-sports.io/football/teams/10034.png
10035	Marília	\N	Brazil	https://media.api-sports.io/football/teams/10035.png
10036	Nacional SP	\N	Brazil	https://media.api-sports.io/football/teams/10036.png
10037	Noroeste	\N	Brazil	https://media.api-sports.io/football/teams/10037.png
10038	Paulista	PAU	Brazil	https://media.api-sports.io/football/teams/10038.png
10039	Primavera SP	\N	Brazil	https://media.api-sports.io/football/teams/10039.png
10040	Rio Preto	\N	Brazil	https://media.api-sports.io/football/teams/10040.png
10041	Velo Clube	\N	Brazil	https://media.api-sports.io/football/teams/10041.png
10042	Esportivo	BEN	Brazil	https://media.api-sports.io/football/teams/10042.png
10043	Pelotas	PEL	Brazil	https://media.api-sports.io/football/teams/10043.png
10044	Bagé	\N	Brazil	https://media.api-sports.io/football/teams/10044.png
10045	Brasil Farroupilha	\N	Brazil	https://media.api-sports.io/football/teams/10045.png
10046	Cruzeiro RS	EC	Brazil	https://media.api-sports.io/football/teams/10046.png
10047	Glória	\N	Brazil	https://media.api-sports.io/football/teams/10047.png
10048	Guarani RS	\N	Brazil	https://media.api-sports.io/football/teams/10048.png
10049	Guarany de Bagé	GUA	Brazil	https://media.api-sports.io/football/teams/10049.png
10050	Igrejinha	\N	Brazil	https://media.api-sports.io/football/teams/10050.png
10051	Inter Santa Maria	\N	Brazil	https://media.api-sports.io/football/teams/10051.png
10052	Lajeadense	LAJ	Brazil	https://media.api-sports.io/football/teams/10052.png
10053	Passo Fundo	PAS	Brazil	https://media.api-sports.io/football/teams/10053.png
10054	São Gabriel	\N	Brazil	https://media.api-sports.io/football/teams/10054.png
10055	Tupi RS	\N	Brazil	https://media.api-sports.io/football/teams/10055.png
10056	União RS	\N	Brazil	https://media.api-sports.io/football/teams/10056.png
10057	Veranópolis	VER	Brazil	https://media.api-sports.io/football/teams/10057.png
10171	Brazil  U23	\N	Brazil	https://media.api-sports.io/football/teams/10171.png
10478	Humaitá	\N	Brazil	https://media.api-sports.io/football/teams/10478.png
10670	Atlético Cajazeirense	\N	Brazil	https://media.api-sports.io/football/teams/10670.png
10671	CRAC	CRA	Brazil	https://media.api-sports.io/football/teams/10671.png
10672	Cabofriense	CAB	Brazil	https://media.api-sports.io/football/teams/10672.png
10673	Cascavel	\N	Brazil	https://media.api-sports.io/football/teams/10673.png
10674	Goiânia	\N	Brazil	https://media.api-sports.io/football/teams/10674.png
10675	Ji-Paraná	\N	Brazil	https://media.api-sports.io/football/teams/10675.png
10676	Juventude MA	\N	Brazil	https://media.api-sports.io/football/teams/10676.png
10677	Marcílio Dias	MAR	Brazil	https://media.api-sports.io/football/teams/10677.png
10678	Nacional PR	NAC	Brazil	https://media.api-sports.io/football/teams/10678.png
10679	Real Noroeste	\N	Brazil	https://media.api-sports.io/football/teams/10679.png
10680	Tupynambás	\N	Brazil	https://media.api-sports.io/football/teams/10680.png
10685	Brasília	BRA	Brazil	https://media.api-sports.io/football/teams/10685.png
10686	Estanciano	\N	Brazil	https://media.api-sports.io/football/teams/10686.png
10687	Ivinhema	\N	Brazil	https://media.api-sports.io/football/teams/10687.png
10688	Operário MT	\N	Brazil	https://media.api-sports.io/football/teams/10688.png
10689	Parauapebas	\N	Brazil	https://media.api-sports.io/football/teams/10689.png
10690	Rio Branco ES	\N	Brazil	https://media.api-sports.io/football/teams/10690.png
10852	Andirá	\N	Brazil	https://media.api-sports.io/football/teams/10852.png
10853	Independência	\N	Brazil	https://media.api-sports.io/football/teams/10853.png
10854	Náuas	\N	Brazil	https://media.api-sports.io/football/teams/10854.png
10855	São Francisco	\N	Brazil	https://media.api-sports.io/football/teams/10855.png
10856	Alto Acre	\N	Brazil	https://media.api-sports.io/football/teams/10856.png
10857	Amax	\N	Brazil	https://media.api-sports.io/football/teams/10857.png
10858	Oratório	\N	Brazil	https://media.api-sports.io/football/teams/10858.png
10859	Santana	\N	Brazil	https://media.api-sports.io/football/teams/10859.png
10860	São Paulo AP	\N	Brazil	https://media.api-sports.io/football/teams/10860.png
10861	Independente AP	\N	Brazil	https://media.api-sports.io/football/teams/10861.png
10862	Amazonas	\N	Brazil	https://media.api-sports.io/football/teams/10862.png
10863	Iranduba	\N	Brazil	https://media.api-sports.io/football/teams/10863.png
10864	São Raimundo AM	\N	Brazil	https://media.api-sports.io/football/teams/10864.png
10865	Peñarol	\N	Brazil	https://media.api-sports.io/football/teams/10865.png
10866	Rio Negro AM	\N	Brazil	https://media.api-sports.io/football/teams/10866.png
10867	Sul América	\N	Brazil	https://media.api-sports.io/football/teams/10867.png
10868	Manicoré	\N	Brazil	https://media.api-sports.io/football/teams/10868.png
10869	Holanda	\N	Brazil	https://media.api-sports.io/football/teams/10869.png
10870	Nacional Borbense	\N	Brazil	https://media.api-sports.io/football/teams/10870.png
11054	Flamengo U20	\N	Brazil	https://media.api-sports.io/football/teams/11054.png
12277	Ipatinga	BET	Brazil	https://media.api-sports.io/football/teams/12277.png
12278	Duque de Caxias	DUQ	Brazil	https://media.api-sports.io/football/teams/12278.png
12279	Baraúnas	BAR	Brazil	https://media.api-sports.io/football/teams/12279.png
12280	Serrano BA	SER	Brazil	https://media.api-sports.io/football/teams/12280.png
12281	Vilhena	VIL	Brazil	https://media.api-sports.io/football/teams/12281.png
12282	Estrela do Norte	\N	Brazil	https://media.api-sports.io/football/teams/12282.png
12283	Guarani de Palhoça	\N	Brazil	https://media.api-sports.io/football/teams/12283.png
12284	Itaporã	\N	Brazil	https://media.api-sports.io/football/teams/12284.png
12285	Aracruz	ARA	Brazil	https://media.api-sports.io/football/teams/12285.png
12286	Araxá	ARA	Brazil	https://media.api-sports.io/football/teams/12286.png
12287	Paragominas	PAR	Brazil	https://media.api-sports.io/football/teams/12287.png
12288	Tiradentes CE	TIR	Brazil	https://media.api-sports.io/football/teams/12288.png
12289	Ypiranga PE	\N	Brazil	https://media.api-sports.io/football/teams/12289.png
12290	Araguaína	\N	Brazil	https://media.api-sports.io/football/teams/12290.png
12291	Arapongas	ARA	Brazil	https://media.api-sports.io/football/teams/12291.png
12292	CENE	CEN	Brazil	https://media.api-sports.io/football/teams/12292.png
12293	Cerâmica	\N	Brazil	https://media.api-sports.io/football/teams/12293.png
12294	Comercial PI	\N	Brazil	https://media.api-sports.io/football/teams/12294.png
12295	Friburguense	FRI	Brazil	https://media.api-sports.io/football/teams/12295.png
12296	Guarani MG	\N	Brazil	https://media.api-sports.io/football/teams/12296.png
12297	Horizonte	HOR	Brazil	https://media.api-sports.io/football/teams/12297.png
12298	Nacional MG	NAC	Brazil	https://media.api-sports.io/football/teams/12298.png
12299	Petrolina	\N	Brazil	https://media.api-sports.io/football/teams/12299.png
12300	Concórdia	\N	Brazil	https://media.api-sports.io/football/teams/12300.png
12301	Feirense	\N	Brazil	https://media.api-sports.io/football/teams/12301.png
12502	Brazil U17	\N	Brazil	https://media.api-sports.io/football/teams/12502.png
12905	Doce Mel	\N	Brazil	https://media.api-sports.io/football/teams/12905.png
12906	Atlanta	\N	Brazil	https://media.api-sports.io/football/teams/12906.png
12907	CSP	\N	Brazil	https://media.api-sports.io/football/teams/12907.png
12908	Nacional de Patos	\N	Brazil	https://media.api-sports.io/football/teams/12908.png
12909	Perilima	\N	Brazil	https://media.api-sports.io/football/teams/12909.png
12910	Sport PB	\N	Brazil	https://media.api-sports.io/football/teams/12910.png
12911	São Paulo Crystal	\N	Brazil	https://media.api-sports.io/football/teams/12911.png
12912	Juventus SC	GRE	Brazil	https://media.api-sports.io/football/teams/12912.png
12913	Cascavel CR	\N	Brazil	https://media.api-sports.io/football/teams/12913.png
12914	Rio Branco PR	RIO	Brazil	https://media.api-sports.io/football/teams/12914.png
12915	União PR	\N	Brazil	https://media.api-sports.io/football/teams/12915.png
12916	GAS	\N	Brazil	https://media.api-sports.io/football/teams/12916.png
12917	Rio Negro RR	\N	Brazil	https://media.api-sports.io/football/teams/12917.png
12918	Pinheiro	\N	Brazil	https://media.api-sports.io/football/teams/12918.png
12919	São José MA	\N	Brazil	https://media.api-sports.io/football/teams/12919.png
12920	Pacajus	\N	Brazil	https://media.api-sports.io/football/teams/12920.png
12921	Capital Brasilia	\N	Brazil	https://media.api-sports.io/football/teams/12921.png
12922	Ceilandense	\N	Brazil	https://media.api-sports.io/football/teams/12922.png
12923	Formosa	\N	Brazil	https://media.api-sports.io/football/teams/12923.png
12924	Paranoá	\N	Brazil	https://media.api-sports.io/football/teams/12924.png
12925	Real FC	\N	Brazil	https://media.api-sports.io/football/teams/12925.png
12926	Taguatinga	\N	Brazil	https://media.api-sports.io/football/teams/12926.png
12927	Unaí Itapuã	\N	Brazil	https://media.api-sports.io/football/teams/12927.png
12928	Linhares	\N	Brazil	https://media.api-sports.io/football/teams/12928.png
12929	Rio Branco-VN	\N	Brazil	https://media.api-sports.io/football/teams/12929.png
12930	São Mateus	\N	Brazil	https://media.api-sports.io/football/teams/12930.png
12931	ABPN Canaã	\N	Brazil	https://media.api-sports.io/football/teams/12931.png
12932	Cajazeiras	\N	Brazil	https://media.api-sports.io/football/teams/12932.png
12933	Olímpia BA	\N	Brazil	https://media.api-sports.io/football/teams/12933.png
12934	UNIRB	\N	Brazil	https://media.api-sports.io/football/teams/12934.png
12935	Galícia	\N	Brazil	https://media.api-sports.io/football/teams/12935.png
12936	Andraus Brasil	\N	Brazil	https://media.api-sports.io/football/teams/12936.png
12937	Apucarana	\N	Brazil	https://media.api-sports.io/football/teams/12937.png
12938	Araucária	\N	Brazil	https://media.api-sports.io/football/teams/12938.png
12939	Azuriz	\N	Brazil	https://media.api-sports.io/football/teams/12939.png
12940	Batel	\N	Brazil	https://media.api-sports.io/football/teams/12940.png
12941	Independiente FSJ	\N	Brazil	https://media.api-sports.io/football/teams/12941.png
12942	Rolândia	\N	Brazil	https://media.api-sports.io/football/teams/12942.png
12943	Guajará	\N	Brazil	https://media.api-sports.io/football/teams/12943.png
12944	Guaporé	\N	Brazil	https://media.api-sports.io/football/teams/12944.png
12945	Pimentense	\N	Brazil	https://media.api-sports.io/football/teams/12945.png
12946	Porto Velho	\N	Brazil	https://media.api-sports.io/football/teams/12946.png
12947	União Cacoalense	\N	Brazil	https://media.api-sports.io/football/teams/12947.png
12948	Força e Luz	\N	Brazil	https://media.api-sports.io/football/teams/12948.png
12949	Palmeira	\N	Brazil	https://media.api-sports.io/football/teams/12949.png
12950	ABC U20	\N	Brazil	https://media.api-sports.io/football/teams/12950.png
12951	AD Confiança U20	\N	Brazil	https://media.api-sports.io/football/teams/12951.png
12952	Atlético Mineiro U20	\N	Brazil	https://media.api-sports.io/football/teams/12952.png
12953	Avaí U20	\N	Brazil	https://media.api-sports.io/football/teams/12953.png
12954	Bahia U20	\N	Brazil	https://media.api-sports.io/football/teams/12954.png
12955	Bragantino PA U20	\N	Brazil	https://media.api-sports.io/football/teams/12955.png
12956	Ceará U20	\N	Brazil	https://media.api-sports.io/football/teams/12956.png
12957	Coritiba U20	\N	Brazil	https://media.api-sports.io/football/teams/12957.png
12958	Fluminense PI U20	\N	Brazil	https://media.api-sports.io/football/teams/12958.png
12959	Galvez U20	\N	Brazil	https://media.api-sports.io/football/teams/12959.png
12960	Gama U20	\N	Brazil	https://media.api-sports.io/football/teams/12960.png
12961	Goiás U20	\N	Brazil	https://media.api-sports.io/football/teams/12961.png
12962	Internacional U20	\N	Brazil	https://media.api-sports.io/football/teams/12962.png
12963	Jaciobá U20	\N	Brazil	https://media.api-sports.io/football/teams/12963.png
12964	Londrina U20	\N	Brazil	https://media.api-sports.io/football/teams/12964.png
12965	Moto Club MA U20	\N	Brazil	https://media.api-sports.io/football/teams/12965.png
12966	Nacional AM U20	\N	Brazil	https://media.api-sports.io/football/teams/12966.png
12967	Palmas FR U20	\N	Brazil	https://media.api-sports.io/football/teams/12967.png
12968	Palmeiras U20	\N	Brazil	https://media.api-sports.io/football/teams/12968.png
12969	Perilima U20	\N	Brazil	https://media.api-sports.io/football/teams/12969.png
12970	Serra U20	\N	Brazil	https://media.api-sports.io/football/teams/12970.png
12971	Sport Recife U20	\N	Brazil	https://media.api-sports.io/football/teams/12971.png
12972	São José PA U20	\N	Brazil	https://media.api-sports.io/football/teams/12972.png
12973	São Paulo U20	\N	Brazil	https://media.api-sports.io/football/teams/12973.png
12974	São Raimundo RR U20	\N	Brazil	https://media.api-sports.io/football/teams/12974.png
12975	Trem U20	\N	Brazil	https://media.api-sports.io/football/teams/12975.png
12976	Tupi U20	\N	Brazil	https://media.api-sports.io/football/teams/12976.png
12977	União ABC U20	\N	Brazil	https://media.api-sports.io/football/teams/12977.png
12978	União MT U20	\N	Brazil	https://media.api-sports.io/football/teams/12978.png
12979	Vasco da Gama U20	\N	Brazil	https://media.api-sports.io/football/teams/12979.png
12980	Vilhenense U20	\N	Brazil	https://media.api-sports.io/football/teams/12980.png
12981	América Mineiro U20	\N	Brazil	https://media.api-sports.io/football/teams/12981.png
12983	Assisense U20	\N	Brazil	https://media.api-sports.io/football/teams/12983.png
12984	Athletico PR U20	\N	Brazil	https://media.api-sports.io/football/teams/12984.png
12985	Atlético Cearense U20	\N	Brazil	https://media.api-sports.io/football/teams/12985.png
12986	Atlético GO U20	\N	Brazil	https://media.api-sports.io/football/teams/12986.png
12987	Botafogo SP U20	\N	Brazil	https://media.api-sports.io/football/teams/12987.png
12988	Brasil de Pelotas U20	\N	Brazil	https://media.api-sports.io/football/teams/12988.png
12989	CRB U20	\N	Brazil	https://media.api-sports.io/football/teams/12989.png
12990	CSA U20	\N	Brazil	https://media.api-sports.io/football/teams/12990.png
12991	Canaã U20	\N	Brazil	https://media.api-sports.io/football/teams/12991.png
12992	Capital TO U20	\N	Brazil	https://media.api-sports.io/football/teams/12992.png
12993	Capivariano U20	\N	Brazil	https://media.api-sports.io/football/teams/12993.png
12994	Carajás U20	\N	Brazil	https://media.api-sports.io/football/teams/12994.png
12995	Chapecoense U20	\N	Brazil	https://media.api-sports.io/football/teams/12995.png
12996	Comercial U20	\N	Brazil	https://media.api-sports.io/football/teams/12996.png
12997	Confiança PB U20	\N	Brazil	https://media.api-sports.io/football/teams/12997.png
12998	Corinthians U20	\N	Brazil	https://media.api-sports.io/football/teams/12998.png
12999	Criciuma U20	\N	Brazil	https://media.api-sports.io/football/teams/12999.png
13000	Cruzeiro U20	\N	Brazil	https://media.api-sports.io/football/teams/13000.png
13001	Cuiabá U20	\N	Brazil	https://media.api-sports.io/football/teams/13001.png
13002	Desportiva Paraense U20	\N	Brazil	https://media.api-sports.io/football/teams/13002.png
13003	Desportivo Brasil U20	\N	Brazil	https://media.api-sports.io/football/teams/13003.png
13004	Dimensão Saúde U20	\N	Brazil	https://media.api-sports.io/football/teams/13004.png
13005	EC São Bernardo U20	\N	Brazil	https://media.api-sports.io/football/teams/13005.png
13006	Ferroviária U20	\N	Brazil	https://media.api-sports.io/football/teams/13006.png
13007	Flamengo SP U20	\N	Brazil	https://media.api-sports.io/football/teams/13007.png
13008	Fluminense U20	\N	Brazil	https://media.api-sports.io/football/teams/13008.png
13009	Fortaleza U20	\N	Brazil	https://media.api-sports.io/football/teams/13009.png
13010	Francana U20	\N	Brazil	https://media.api-sports.io/football/teams/13010.png
13011	Grêmio U20	\N	Brazil	https://media.api-sports.io/football/teams/13011.png
13012	Guarani U20	\N	Brazil	https://media.api-sports.io/football/teams/13012.png
13013	Guarulhos U20	\N	Brazil	https://media.api-sports.io/football/teams/13013.png
13014	Inter Limeira U20	\N	Brazil	https://media.api-sports.io/football/teams/13014.png
13015	Itapirense U20	\N	Brazil	https://media.api-sports.io/football/teams/13015.png
13016	Ituano U20	\N	Brazil	https://media.api-sports.io/football/teams/13016.png
13017	Jacuipense U20	\N	Brazil	https://media.api-sports.io/football/teams/13017.png
13018	Jaguariúna U20	\N	Brazil	https://media.api-sports.io/football/teams/13018.png
13019	Joinville U20	\N	Brazil	https://media.api-sports.io/football/teams/13019.png
13020	Juventude U20	\N	Brazil	https://media.api-sports.io/football/teams/13020.png
13021	Juventus U20	\N	Brazil	https://media.api-sports.io/football/teams/13021.png
13022	Linense U20	\N	Brazil	https://media.api-sports.io/football/teams/13022.png
13023	Linhares U20	\N	Brazil	https://media.api-sports.io/football/teams/13023.png
13024	Manthiqueira U20	\N	Brazil	https://media.api-sports.io/football/teams/13024.png
13025	Marília U20	\N	Brazil	https://media.api-sports.io/football/teams/13025.png
13026	Mauá U20	\N	Brazil	https://media.api-sports.io/football/teams/13026.png
13027	Mirassol U20	\N	Brazil	https://media.api-sports.io/football/teams/13027.png
13028	Nacional SP U20	\N	Brazil	https://media.api-sports.io/football/teams/13028.png
13029	Nautico U20	\N	Brazil	https://media.api-sports.io/football/teams/13029.png
13030	Noroeste U20	\N	Brazil	https://media.api-sports.io/football/teams/13030.png
13031	Nova Andradina U20	\N	Brazil	https://media.api-sports.io/football/teams/13031.png
13032	Nova Iguaçu U20	\N	Brazil	https://media.api-sports.io/football/teams/13032.png
13033	Novorizontino U20	\N	Brazil	https://media.api-sports.io/football/teams/13033.png
13034	Oeste U20	\N	Brazil	https://media.api-sports.io/football/teams/13034.png
13035	Olímpico SE U20	\N	Brazil	https://media.api-sports.io/football/teams/13035.png
13036	Operário PR U20	\N	Brazil	https://media.api-sports.io/football/teams/13036.png
13037	Osasco Audax U20	\N	Brazil	https://media.api-sports.io/football/teams/13037.png
22365	Sabugy	\N	Brazil	https://media.api-sports.io/football/teams/22365.png
13038	Osvaldo Cruz U20	\N	Brazil	https://media.api-sports.io/football/teams/13038.png
13039	Palmeira U20	\N	Brazil	https://media.api-sports.io/football/teams/13039.png
13040	Paraná U20	\N	Brazil	https://media.api-sports.io/football/teams/13040.png
13041	Paulista U20	\N	Brazil	https://media.api-sports.io/football/teams/13041.png
13042	Penapolense U20	\N	Brazil	https://media.api-sports.io/football/teams/13042.png
13043	Petrolina U20	\N	Brazil	https://media.api-sports.io/football/teams/13043.png
13044	Ponte Preta U20	\N	Brazil	https://media.api-sports.io/football/teams/13044.png
13045	Portuguesa U20	\N	Brazil	https://media.api-sports.io/football/teams/13045.png
13046	Primavera SP U20	\N	Brazil	https://media.api-sports.io/football/teams/13046.png
13047	RB Brasil U20	\N	Brazil	https://media.api-sports.io/football/teams/13047.png
13048	Real FC U20	\N	Brazil	https://media.api-sports.io/football/teams/13048.png
13049	Resende FC U20	\N	Brazil	https://media.api-sports.io/football/teams/13049.png
13050	Retrô U20	\N	Brazil	https://media.api-sports.io/football/teams/13050.png
13051	Rio Claro SP U20	\N	Brazil	https://media.api-sports.io/football/teams/13051.png
13052	Ríver U20	\N	Brazil	https://media.api-sports.io/football/teams/13052.png
13053	Santa Cruz U20	\N	Brazil	https://media.api-sports.io/football/teams/13053.png
13054	Santo André U20	\N	Brazil	https://media.api-sports.io/football/teams/13054.png
13055	Santos U20	\N	Brazil	https://media.api-sports.io/football/teams/13055.png
13056	Sergipe U20	\N	Brazil	https://media.api-sports.io/football/teams/13056.png
13057	Sertãozinho U20	\N	Brazil	https://media.api-sports.io/football/teams/13057.png
13058	Socorrense U20	\N	Brazil	https://media.api-sports.io/football/teams/13058.png
13059	São Bento U20	\N	Brazil	https://media.api-sports.io/football/teams/13059.png
13060	São Bernardo FC U20	\N	Brazil	https://media.api-sports.io/football/teams/13060.png
13061	São Caetano U20	\N	Brazil	https://media.api-sports.io/football/teams/13061.png
13062	Taboão da Serra SP U20	\N	Brazil	https://media.api-sports.io/football/teams/13062.png
13063	Tanabi SP U20	\N	Brazil	https://media.api-sports.io/football/teams/13063.png
13064	Taubaté U20	\N	Brazil	https://media.api-sports.io/football/teams/13064.png
13065	Timon MA U20	\N	Brazil	https://media.api-sports.io/football/teams/13065.png
13066	Trindade U20	\N	Brazil	https://media.api-sports.io/football/teams/13066.png
13067	União Mogi U20	\N	Brazil	https://media.api-sports.io/football/teams/13067.png
13068	União Suzano SP U20	\N	Brazil	https://media.api-sports.io/football/teams/13068.png
13069	Velo Clube U20	\N	Brazil	https://media.api-sports.io/football/teams/13069.png
13070	Vila Nova U20	\N	Brazil	https://media.api-sports.io/football/teams/13070.png
13071	Visão Celeste U20	\N	Brazil	https://media.api-sports.io/football/teams/13071.png
13072	Vitória U20	\N	Brazil	https://media.api-sports.io/football/teams/13072.png
13073	Vitória da Conquista U20	\N	Brazil	https://media.api-sports.io/football/teams/13073.png
13074	Volta Redonda U20	\N	Brazil	https://media.api-sports.io/football/teams/13074.png
13075	Votuporanguense U20	\N	Brazil	https://media.api-sports.io/football/teams/13075.png
13076	XV de Jaú U20	\N	Brazil	https://media.api-sports.io/football/teams/13076.png
13077	XV de Piracicaba U20	\N	Brazil	https://media.api-sports.io/football/teams/13077.png
13078	Água Santa U20	\N	Brazil	https://media.api-sports.io/football/teams/13078.png
13079	CAP Uberlândia	\N	Brazil	https://media.api-sports.io/football/teams/13079.png
13080	Democrata GV	\N	Brazil	https://media.api-sports.io/football/teams/13080.png
13081	Democrata SL	\N	Brazil	https://media.api-sports.io/football/teams/13081.png
13082	Mamoré	\N	Brazil	https://media.api-sports.io/football/teams/13082.png
13083	Nacional AC MG	\N	Brazil	https://media.api-sports.io/football/teams/13083.png
13084	Pouso Alegre	\N	Brazil	https://media.api-sports.io/football/teams/13084.png
13085	Serranense	\N	Brazil	https://media.api-sports.io/football/teams/13085.png
13086	Betim	\N	Brazil	https://media.api-sports.io/football/teams/13086.png
13087	Campo Grande	\N	Brazil	https://media.api-sports.io/football/teams/13087.png
13088	Esporte Limoeiro	\N	Brazil	https://media.api-sports.io/football/teams/13088.png
13089	Maracanã	\N	Brazil	https://media.api-sports.io/football/teams/13089.png
13090	Maranguape	\N	Brazil	https://media.api-sports.io/football/teams/13090.png
13091	União CE	\N	Brazil	https://media.api-sports.io/football/teams/13091.png
13092	Crato	CRA	Brazil	https://media.api-sports.io/football/teams/13092.png
13093	Flamengo PI	FLA	Brazil	https://media.api-sports.io/football/teams/13093.png
13094	Piauí	\N	Brazil	https://media.api-sports.io/football/teams/13094.png
13095	Picos	\N	Brazil	https://media.api-sports.io/football/teams/13095.png
13096	Timon	\N	Brazil	https://media.api-sports.io/football/teams/13096.png
13097	Decisão	\N	Brazil	https://media.api-sports.io/football/teams/13097.png
13098	Retrô	\N	Brazil	https://media.api-sports.io/football/teams/13098.png
13099	Chapadão	\N	Brazil	https://media.api-sports.io/football/teams/13099.png
13100	Maracaju	\N	Brazil	https://media.api-sports.io/football/teams/13100.png
13101	Nova Andradina	\N	Brazil	https://media.api-sports.io/football/teams/13101.png
13102	Ponta Porã	\N	Brazil	https://media.api-sports.io/football/teams/13102.png
13103	Costa Rica 	\N	Brazil	https://media.api-sports.io/football/teams/13103.png
13104	América RJ	\N	Brazil	https://media.api-sports.io/football/teams/13104.png
13105	Angra dos Reis	\N	Brazil	https://media.api-sports.io/football/teams/13105.png
13106	Artsul	\N	Brazil	https://media.api-sports.io/football/teams/13106.png
13107	Audax Rio	AUD	Brazil	https://media.api-sports.io/football/teams/13107.png
13108	Barra da Tijuca	\N	Brazil	https://media.api-sports.io/football/teams/13108.png
13109	Bonsucesso	BON	Brazil	https://media.api-sports.io/football/teams/13109.png
13110	Campos AA	\N	Brazil	https://media.api-sports.io/football/teams/13110.png
13111	Gonçalense	\N	Brazil	https://media.api-sports.io/football/teams/13111.png
22366	Spartax	\N	Brazil	https://media.api-sports.io/football/teams/22366.png
13112	Goytacaz	\N	Brazil	https://media.api-sports.io/football/teams/13112.png
13113	Nova Cidade	\N	Brazil	https://media.api-sports.io/football/teams/13113.png
13114	Olaria	OLA	Brazil	https://media.api-sports.io/football/teams/13114.png
13115	Sampaio Corrêa RJ	\N	Brazil	https://media.api-sports.io/football/teams/13115.png
13116	Serra Macaense	MAC	Brazil	https://media.api-sports.io/football/teams/13116.png
13117	Serrano RJ	\N	Brazil	https://media.api-sports.io/football/teams/13117.png
13118	São Gonçalo EC RJ	\N	Brazil	https://media.api-sports.io/football/teams/13118.png
13119	Tigres do Brasil	\N	Brazil	https://media.api-sports.io/football/teams/13119.png
13120	América de Pedrinhas	\N	Brazil	https://media.api-sports.io/football/teams/13120.png
13121	Boca Júnior	\N	Brazil	https://media.api-sports.io/football/teams/13121.png
13122	Dorense	\N	Brazil	https://media.api-sports.io/football/teams/13122.png
13123	Carajás	\N	Brazil	https://media.api-sports.io/football/teams/13123.png
13124	Castanhal	\N	Brazil	https://media.api-sports.io/football/teams/13124.png
13125	Itupiranga	\N	Brazil	https://media.api-sports.io/football/teams/13125.png
13126	Tapajós	\N	Brazil	https://media.api-sports.io/football/teams/13126.png
13127	Grêmio Anápolis	GRE	Brazil	https://media.api-sports.io/football/teams/13127.png
13128	Jaraguá EC	\N	Brazil	https://media.api-sports.io/football/teams/13128.png
13129	Coimbra	\N	Brazil	https://media.api-sports.io/football/teams/13129.png
13130	Nova Mutum EC	\N	Brazil	https://media.api-sports.io/football/teams/13130.png
13131	Poconé	\N	Brazil	https://media.api-sports.io/football/teams/13131.png
13132	Araguacema	\N	Brazil	https://media.api-sports.io/football/teams/13132.png
13133	Atlético Cerrado	\N	Brazil	https://media.api-sports.io/football/teams/13133.png
13134	Capital	\N	Brazil	https://media.api-sports.io/football/teams/13134.png
13135	Nova Conquista	\N	Brazil	https://media.api-sports.io/football/teams/13135.png
13136	América RJ U20	\N	Brazil	https://media.api-sports.io/football/teams/13136.png
13137	Athletico PR U20	\N	Brazil	https://media.api-sports.io/football/teams/13137.png
13138	Capital TO U20	\N	Brazil	https://media.api-sports.io/football/teams/13138.png
13139	Ceará U20	\N	Brazil	https://media.api-sports.io/football/teams/13139.png
13140	Chapecoense U20	\N	Brazil	https://media.api-sports.io/football/teams/13140.png
13141	Goiás U20	\N	Brazil	https://media.api-sports.io/football/teams/13141.png
13142	Grêmio U20	\N	Brazil	https://media.api-sports.io/football/teams/13142.png
13143	Vasco da Gama U20	\N	Brazil	https://media.api-sports.io/football/teams/13143.png
13974	Santa Cruz	\N	Brazil	https://media.api-sports.io/football/teams/13974.png
13975	Athletic Club	\N	Brazil	https://media.api-sports.io/football/teams/13975.png
14000	CFRJ / Maricá	\N	Brazil	https://media.api-sports.io/football/teams/14000.png
14001	Rio São Paulo	\N	Brazil	https://media.api-sports.io/football/teams/14001.png
15103	Barcelona BA	\N	Brazil	https://media.api-sports.io/football/teams/15103.png
15104	Jequié	\N	Brazil	https://media.api-sports.io/football/teams/15104.png
15105	Teixeira de Freitas	\N	Brazil	https://media.api-sports.io/football/teams/15105.png
15106	Colo Colo	\N	Brazil	https://media.api-sports.io/football/teams/15106.png
15505	Iguatu	\N	Brazil	https://media.api-sports.io/football/teams/15505.png
15506	Itapipoca	ITA	Brazil	https://media.api-sports.io/football/teams/15506.png
15507	Pacatuba	\N	Brazil	https://media.api-sports.io/football/teams/15507.png
15603	Aliança AL	\N	Brazil	https://media.api-sports.io/football/teams/15603.png
15604	Atlético Gloriense	\N	Brazil	https://media.api-sports.io/football/teams/15604.png
15605	Maruinense	\N	Brazil	https://media.api-sports.io/football/teams/15605.png
15606	IAPE	\N	Brazil	https://media.api-sports.io/football/teams/15606.png
15607	Timon MA	\N	Brazil	https://media.api-sports.io/football/teams/15607.png
15608	Pinheiros	\N	Brazil	https://media.api-sports.io/football/teams/15608.png
15609	Vilavelhense	\N	Brazil	https://media.api-sports.io/football/teams/15609.png
15610	Gavião	\N	Brazil	https://media.api-sports.io/football/teams/15610.png
15611	Tuna Luso	\N	Brazil	https://media.api-sports.io/football/teams/15611.png
15612	Samambaia	\N	Brazil	https://media.api-sports.io/football/teams/15612.png
15613	Santa Maria	\N	Brazil	https://media.api-sports.io/football/teams/15613.png
15614	Próspera Criciuma	\N	Brazil	https://media.api-sports.io/football/teams/15614.png
15615	Ação	\N	Brazil	https://media.api-sports.io/football/teams/15615.png
15616	Grêmio Sorriso	\N	Brazil	https://media.api-sports.io/football/teams/15616.png
15617	Fluminense PI	\N	Brazil	https://media.api-sports.io/football/teams/15617.png
15618	Tiradentes PI	\N	Brazil	https://media.api-sports.io/football/teams/15618.png
15621	Bandeirante SP	\N	Brazil	https://media.api-sports.io/football/teams/15621.png
15622	São José EC	\N	Brazil	https://media.api-sports.io/football/teams/15622.png
16042	Avaí U23	\N	Brazil	https://media.api-sports.io/football/teams/16042.png
16043	CRB U23	\N	Brazil	https://media.api-sports.io/football/teams/16043.png
16044	Ceará U23	\N	Brazil	https://media.api-sports.io/football/teams/16044.png
16045	Corinthians U23	\N	Brazil	https://media.api-sports.io/football/teams/16045.png
16046	Coritiba U23	\N	Brazil	https://media.api-sports.io/football/teams/16046.png
16047	Fluminense U23	FLU	Brazil	https://media.api-sports.io/football/teams/16047.png
16048	Fortaleza U23	\N	Brazil	https://media.api-sports.io/football/teams/16048.png
16049	Grêmio U23	\N	Brazil	https://media.api-sports.io/football/teams/16049.png
16050	Juventude U23	\N	Brazil	https://media.api-sports.io/football/teams/16050.png
16051	Paraná U23	\N	Brazil	https://media.api-sports.io/football/teams/16051.png
16052	Paysandu U23	\N	Brazil	https://media.api-sports.io/football/teams/16052.png
16053	RB Bragantino U23	\N	Brazil	https://media.api-sports.io/football/teams/16053.png
16054	Sampaio Corrêa U23	\N	Brazil	https://media.api-sports.io/football/teams/16054.png
16055	Santa Cruz U23	\N	Brazil	https://media.api-sports.io/football/teams/16055.png
16056	Santos U23	\N	Brazil	https://media.api-sports.io/football/teams/16056.png
16057	Vila Nova U23	\N	Brazil	https://media.api-sports.io/football/teams/16057.png
16058	Botafogo SP B	\N	Brazil	https://media.api-sports.io/football/teams/16058.png
16059	Guarani B	\N	Brazil	https://media.api-sports.io/football/teams/16059.png
16060	Ponte Preta B	\N	Brazil	https://media.api-sports.io/football/teams/16060.png
16200	Brazil U20	BRA	Brazil	https://media.api-sports.io/football/teams/16200.png
16439	Bacabal	\N	Brazil	https://media.api-sports.io/football/teams/16439.png
16446	Vera Cruz	\N	Brazil	https://media.api-sports.io/football/teams/16446.png
16460	Cliper	\N	Brazil	https://media.api-sports.io/football/teams/16460.png
16461	JC	\N	Brazil	https://media.api-sports.io/football/teams/16461.png
16465	Jataiense	\N	Brazil	https://media.api-sports.io/football/teams/16465.png
16471	Floresta CE U20	\N	Brazil	https://media.api-sports.io/football/teams/16471.png
16472	Planaltina U20	\N	Brazil	https://media.api-sports.io/football/teams/16472.png
16473	Presidente Médici U20	\N	Brazil	https://media.api-sports.io/football/teams/16473.png
16474	Real Ariquemes U20	\N	Brazil	https://media.api-sports.io/football/teams/16474.png
16478	Castelo TO U20	\N	Brazil	https://media.api-sports.io/football/teams/16478.png
16479	Santa Cruz RS	SAN	Brazil	https://media.api-sports.io/football/teams/16479.png
16480	Dourados Atlético	\N	Brazil	https://media.api-sports.io/football/teams/16480.png
16481	Três Lagoas	\N	Brazil	https://media.api-sports.io/football/teams/16481.png
16482	União ABC	\N	Brazil	https://media.api-sports.io/football/teams/16482.png
16495	Real Brasília	\N	Brazil	https://media.api-sports.io/football/teams/16495.png
16496	Bahia W	\N	Brazil	https://media.api-sports.io/football/teams/16496.png
16497	Botafogo W	\N	Brazil	https://media.api-sports.io/football/teams/16497.png
16499	Napoli W	\N	Brazil	https://media.api-sports.io/football/teams/16499.png
16669	Botafogo BA	BOT	Brazil	https://media.api-sports.io/football/teams/16669.png
16670	Camaçari	\N	Brazil	https://media.api-sports.io/football/teams/16670.png
16671	Camaçariense	\N	Brazil	https://media.api-sports.io/football/teams/16671.png
16672	Grapiuna Itabuna	\N	Brazil	https://media.api-sports.io/football/teams/16672.png
16732	Bahia U23	\N	Brazil	https://media.api-sports.io/football/teams/16732.png
16733	Cuiabá U23	\N	Brazil	https://media.api-sports.io/football/teams/16733.png
16734	Figueirense U23	\N	Brazil	https://media.api-sports.io/football/teams/16734.png
16735	Ponte Preta U23	\N	Brazil	https://media.api-sports.io/football/teams/16735.png
16736	Vitória U23	\N	Brazil	https://media.api-sports.io/football/teams/16736.png
16737	Planaltina DF U20	\N	Brazil	https://media.api-sports.io/football/teams/16737.png
16750	Cariri	\N	Brazil	https://media.api-sports.io/football/teams/16750.png
16751	Aymorés	\N	Brazil	https://media.api-sports.io/football/teams/16751.png
16752	Uniao Luziense	\N	Brazil	https://media.api-sports.io/football/teams/16752.png
17427	AA Iguaçu	\N	Brazil	https://media.api-sports.io/football/teams/17427.png
17428	Verê	\N	Brazil	https://media.api-sports.io/football/teams/17428.png
17734	Santos B	\N	Brazil	https://media.api-sports.io/football/teams/17734.png
17736	7 de Abril	\N	Brazil	https://media.api-sports.io/football/teams/17736.png
17737	Carapebus	\N	Brazil	https://media.api-sports.io/football/teams/17737.png
17738	Pérolas Negras	\N	Brazil	https://media.api-sports.io/football/teams/17738.png
17926	Barra Mansa	\N	Brazil	https://media.api-sports.io/football/teams/17926.png
18271	Barra	\N	Brazil	https://media.api-sports.io/football/teams/18271.png
18272	Camboriú	\N	Brazil	https://media.api-sports.io/football/teams/18272.png
18273	Sport Sinop	\N	Brazil	https://media.api-sports.io/football/teams/18273.png
18274	Corí-Sabbá	FLO	Brazil	https://media.api-sports.io/football/teams/18274.png
18275	Oeirense	\N	Brazil	https://media.api-sports.io/football/teams/18275.png
18296	Goiatuba EC	\N	Brazil	https://media.api-sports.io/football/teams/18296.png
18297	Morrinhos	\N	Brazil	https://media.api-sports.io/football/teams/18297.png
18298	América SE	\N	Brazil	https://media.api-sports.io/football/teams/18298.png
18299	Falcon	\N	Brazil	https://media.api-sports.io/football/teams/18299.png
18303	Matonense	\N	Brazil	https://media.api-sports.io/football/teams/18303.png
18304	USAC	\N	Brazil	https://media.api-sports.io/football/teams/18304.png
18306	Auto Esporte	\N	Brazil	https://media.api-sports.io/football/teams/18306.png
18307	Nova Venécia	\N	Brazil	https://media.api-sports.io/football/teams/18307.png
18308	Manauara	\N	Brazil	https://media.api-sports.io/football/teams/18308.png
18309	Operário AM	\N	Brazil	https://media.api-sports.io/football/teams/18309.png
18316	Potyguar	\N	Brazil	https://media.api-sports.io/football/teams/18316.png
18317	Tuntum	\N	Brazil	https://media.api-sports.io/football/teams/18317.png
18318	Caruaru City	\N	Brazil	https://media.api-sports.io/football/teams/18318.png
18319	Íbis	\N	Brazil	https://media.api-sports.io/football/teams/18319.png
18320	ASSU U20	\N	Brazil	https://media.api-sports.io/football/teams/18320.png
18321	Andirá U20	\N	Brazil	https://media.api-sports.io/football/teams/18321.png
18322	Aparecidense U20	\N	Brazil	https://media.api-sports.io/football/teams/18322.png
18323	Aquidauanense U20	\N	Brazil	https://media.api-sports.io/football/teams/18323.png
18324	Aster Brasil U20	\N	Brazil	https://media.api-sports.io/football/teams/18324.png
18325	CSE U20	\N	Brazil	https://media.api-sports.io/football/teams/18325.png
18326	Camaçariense U20	\N	Brazil	https://media.api-sports.io/football/teams/18326.png
18327	Castanhal U20	\N	Brazil	https://media.api-sports.io/football/teams/18327.png
18328	Chapadinha U20	\N	Brazil	https://media.api-sports.io/football/teams/18328.png
18329	Concórdia U20	\N	Brazil	https://media.api-sports.io/football/teams/18329.png
18330	Desportiva Aliança U20	\N	Brazil	https://media.api-sports.io/football/teams/18330.png
18331	Falcon U20	\N	Brazil	https://media.api-sports.io/football/teams/18331.png
18333	Forte U20	\N	Brazil	https://media.api-sports.io/football/teams/18333.png
18334	Grêmio São-Carlense U20	\N	Brazil	https://media.api-sports.io/football/teams/18334.png
18335	IAPE U20	\N	Brazil	https://media.api-sports.io/football/teams/18335.png
18336	Ibrachina U20	\N	Brazil	https://media.api-sports.io/football/teams/18336.png
18337	Jaú U20	\N	Brazil	https://media.api-sports.io/football/teams/18337.png
18338	Lagarto U20	\N	Brazil	https://media.api-sports.io/football/teams/18338.png
18339	Matogrossense U20	\N	Brazil	https://media.api-sports.io/football/teams/18339.png
18340	Matonense U20	\N	Brazil	https://media.api-sports.io/football/teams/18340.png
18341	Mauaense U20	\N	Brazil	https://media.api-sports.io/football/teams/18341.png
18342	Mixto U20	\N	Brazil	https://media.api-sports.io/football/teams/18342.png
18343	Monte Azul U20	\N	Brazil	https://media.api-sports.io/football/teams/18343.png
18344	Portuguesa Santista U20	\N	Brazil	https://media.api-sports.io/football/teams/18344.png
18345	RB Bragantino U20	\N	Brazil	https://media.api-sports.io/football/teams/18345.png
18346	Real Brasília U20	\N	Brazil	https://media.api-sports.io/football/teams/18346.png
18347	Rondoniense U20	\N	Brazil	https://media.api-sports.io/football/teams/18347.png
18348	SKA Brasil U20	\N	Brazil	https://media.api-sports.io/football/teams/18348.png
18349	Santana U20	\N	Brazil	https://media.api-sports.io/football/teams/18349.png
18350	Serranense U20	\N	Brazil	https://media.api-sports.io/football/teams/18350.png
18351	São Carlos U20	\N	Brazil	https://media.api-sports.io/football/teams/18351.png
18352	São José EC U20	\N	Brazil	https://media.api-sports.io/football/teams/18352.png
18353	Taguatinga U20	\N	Brazil	https://media.api-sports.io/football/teams/18353.png
18354	Taquarussú U20	\N	Brazil	https://media.api-sports.io/football/teams/18354.png
18355	União Iacanga U20	\N	Brazil	https://media.api-sports.io/football/teams/18355.png
18356	União São João U20	\N	Brazil	https://media.api-sports.io/football/teams/18356.png
18361	Bela Vista TO	\N	Brazil	https://media.api-sports.io/football/teams/18361.png
18362	União Carmolandense	\N	Brazil	https://media.api-sports.io/football/teams/18362.png
18363	Cruzeiro Arapiraca	\N	Brazil	https://media.api-sports.io/football/teams/18363.png
18364	Moreninhas	\N	Brazil	https://media.api-sports.io/football/teams/18364.png
18365	Naviraiense	\N	Brazil	https://media.api-sports.io/football/teams/18365.png
18376	Amazônia PA	\N	Brazil	https://media.api-sports.io/football/teams/18376.png
18377	Caeté	\N	Brazil	https://media.api-sports.io/football/teams/18377.png
18382	Alianca	\N	Brazil	https://media.api-sports.io/football/teams/18382.png
18391	ADESG	\N	Brazil	https://media.api-sports.io/football/teams/18391.png
18465	Coxim	\N	Brazil	https://media.api-sports.io/football/teams/18465.png
18466	EC Lemense	\N	Brazil	https://media.api-sports.io/football/teams/18466.png
18725	CRESSPOM	\N	Brazil	https://media.api-sports.io/football/teams/18725.png
18726	ESMAC	\N	Brazil	https://media.api-sports.io/football/teams/18726.png
18727	Atlético Mineiro W	\N	Brazil	https://media.api-sports.io/football/teams/18727.png
18728	RB Bragantino W	\N	Brazil	https://media.api-sports.io/football/teams/18728.png
18745	Aruko Sports	\N	Brazil	https://media.api-sports.io/football/teams/18745.png
18746	Laranja Mecânica	\N	Brazil	https://media.api-sports.io/football/teams/18746.png
18795	Uberaba	\N	Brazil	https://media.api-sports.io/football/teams/18795.png
18796	Varginha EC	\N	Brazil	https://media.api-sports.io/football/teams/18796.png
18799	Pague Menos	\N	Brazil	https://media.api-sports.io/football/teams/18799.png
18810	CTE Colatina	\N	Brazil	https://media.api-sports.io/football/teams/18810.png
18830	Flamengo BA	\N	Brazil	https://media.api-sports.io/football/teams/18830.png
18831	Itabuna	\N	Brazil	https://media.api-sports.io/football/teams/18831.png
18832	Jacobinense	\N	Brazil	https://media.api-sports.io/football/teams/18832.png
18833	Juazeiro BA	\N	Brazil	https://media.api-sports.io/football/teams/18833.png
18862	Academia	\N	Brazil	https://media.api-sports.io/football/teams/18862.png
19054	Botafogo U23	\N	Brazil	https://media.api-sports.io/football/teams/19054.png
19055	Brasil de Pelotas U23	\N	Brazil	https://media.api-sports.io/football/teams/19055.png
19056	CSA U23	\N	Brazil	https://media.api-sports.io/football/teams/19056.png
19057	Criciuma U23	\N	Brazil	https://media.api-sports.io/football/teams/19057.png
19058	Nautico U23	\N	Brazil	https://media.api-sports.io/football/teams/19058.png
19059	Sport Recife U23	\N	Brazil	https://media.api-sports.io/football/teams/19059.png
19079	Brazil U20 W	\N	Brazil	https://media.api-sports.io/football/teams/19079.png
19634	Atlético Catarinense	\N	Brazil	https://media.api-sports.io/football/teams/19634.png
19635	Blumenau	\N	Brazil	https://media.api-sports.io/football/teams/19635.png
19636	Carlos Renaux	\N	Brazil	https://media.api-sports.io/football/teams/19636.png
19637	Nação	\N	Brazil	https://media.api-sports.io/football/teams/19637.png
20006	CEAC / Araruama	\N	Brazil	https://media.api-sports.io/football/teams/20006.png
20007	Paduano	\N	Brazil	https://media.api-sports.io/football/teams/20007.png
20008	São Gonçalo / Niterói	\N	Brazil	https://media.api-sports.io/football/teams/20008.png
20390	Remo U20	\N	Brazil	https://media.api-sports.io/football/teams/20390.png
20708	Inhumas	\N	Brazil	https://media.api-sports.io/football/teams/20708.png
20709	Queimadense	\N	Brazil	https://media.api-sports.io/football/teams/20709.png
20710	Serra Branca	\N	Brazil	https://media.api-sports.io/football/teams/20710.png
20711	Chapadinha	\N	Brazil	https://media.api-sports.io/football/teams/20711.png
20713	Grêmio Prudente	\N	Brazil	https://media.api-sports.io/football/teams/20713.png
20714	Itapirense	\N	Brazil	https://media.api-sports.io/football/teams/20714.png
20715	Alecrim	\N	Brazil	https://media.api-sports.io/football/teams/20715.png
20716	Cacerense	\N	Brazil	https://media.api-sports.io/football/teams/20716.png
20717	Porto Vitória	\N	Brazil	https://media.api-sports.io/football/teams/20717.png
20718	Ferroviário PI	\N	Brazil	https://media.api-sports.io/football/teams/20718.png
20719	Náutico MS	\N	Brazil	https://media.api-sports.io/football/teams/20719.png
20720	Operário AC MS	\N	Brazil	https://media.api-sports.io/football/teams/20720.png
20723	Cametá	\N	Brazil	https://media.api-sports.io/football/teams/20723.png
20724	Parintins	\N	Brazil	https://media.api-sports.io/football/teams/20724.png
20744	AC Guaratinguetá U20	\N	Brazil	https://media.api-sports.io/football/teams/20744.png
20745	Alecrim U20	\N	Brazil	https://media.api-sports.io/football/teams/20745.png
20746	América RN U20	\N	Brazil	https://media.api-sports.io/football/teams/20746.png
20747	Barretos U20	\N	Brazil	https://media.api-sports.io/football/teams/20747.png
20748	Botafogo PB U20	\N	Brazil	https://media.api-sports.io/football/teams/20748.png
20749	CSP U20	\N	Brazil	https://media.api-sports.io/football/teams/20749.png
20750	Camboriú U20	\N	Brazil	https://media.api-sports.io/football/teams/20750.png
20751	Catanduva U20	\N	Brazil	https://media.api-sports.io/football/teams/20751.png
20752	Ceilândia U20	\N	Brazil	https://media.api-sports.io/football/teams/20752.png
20753	Comercial MS U20	\N	Brazil	https://media.api-sports.io/football/teams/20753.png
20754	Cruzeiro AL U20	\N	Brazil	https://media.api-sports.io/football/teams/20754.png
20755	Figueirense U20	\N	Brazil	https://media.api-sports.io/football/teams/20755.png
20756	Hercílio Luz U20	\N	Brazil	https://media.api-sports.io/football/teams/20756.png
20757	Imperatriz U20	\N	Brazil	https://media.api-sports.io/football/teams/20757.png
20758	Inter de Minas U20	\N	Brazil	https://media.api-sports.io/football/teams/20758.png
20759	Itabaiana U20	\N	Brazil	https://media.api-sports.io/football/teams/20759.png
20760	Juazeirense U20	\N	Brazil	https://media.api-sports.io/football/teams/20760.png
20761	Lemense U20	\N	Brazil	https://media.api-sports.io/football/teams/20761.png
20762	Madureira U20	\N	Brazil	https://media.api-sports.io/football/teams/20762.png
20763	Maringá U20	\N	Brazil	https://media.api-sports.io/football/teams/20763.png
20764	Pague Menos U20	\N	Brazil	https://media.api-sports.io/football/teams/20764.png
20765	Parauapebas U20	\N	Brazil	https://media.api-sports.io/football/teams/20765.png
20766	Picos PI U20	\N	Brazil	https://media.api-sports.io/football/teams/20766.png
20767	Pinheirense U20	\N	Brazil	https://media.api-sports.io/football/teams/20767.png
20768	Porto Velho EC U20	\N	Brazil	https://media.api-sports.io/football/teams/20768.png
20769	Porto Vitória U20	\N	Brazil	https://media.api-sports.io/football/teams/20769.png
20770	Rio Preto U20	\N	Brazil	https://media.api-sports.io/football/teams/20770.png
20771	Rosário Central U20	\N	Brazil	https://media.api-sports.io/football/teams/20771.png
20772	Sampaio Corrêa U20	\N	Brazil	https://media.api-sports.io/football/teams/20772.png
20773	Sharjah Brasil U20	\N	Brazil	https://media.api-sports.io/football/teams/20773.png
20774	Tupã U20	\N	Brazil	https://media.api-sports.io/football/teams/20774.png
20775	União Suzano U20	\N	Brazil	https://media.api-sports.io/football/teams/20775.png
20776	VOCEM U20	\N	Brazil	https://media.api-sports.io/football/teams/20776.png
20777	Zumbi U20	\N	Brazil	https://media.api-sports.io/football/teams/20777.png
20778	Crateús	\N	Brazil	https://media.api-sports.io/football/teams/20778.png
20781	Maguary PE	\N	Brazil	https://media.api-sports.io/football/teams/20781.png
20782	Porto	\N	Brazil	https://media.api-sports.io/football/teams/20782.png
20816	EC Lemense U20	\N	Brazil	https://media.api-sports.io/football/teams/20816.png
21006	Athletico Paranaense W	\N	Brazil	https://media.api-sports.io/football/teams/21006.png
21007	Real Ariquemes	\N	Brazil	https://media.api-sports.io/football/teams/21007.png
21008	Ceará W	\N	Brazil	https://media.api-sports.io/football/teams/21008.png
21125	River RR	\N	Brazil	https://media.api-sports.io/football/teams/21125.png
21165	Itabirito	\N	Brazil	https://media.api-sports.io/football/teams/21165.png
21166	North Esporte	\N	Brazil	https://media.api-sports.io/football/teams/21166.png
21169	Leonico	\N	Brazil	https://media.api-sports.io/football/teams/21169.png
21170	Grêmio Maringá	\N	Brazil	https://media.api-sports.io/football/teams/21170.png
21171	Patriotas	\N	Brazil	https://media.api-sports.io/football/teams/21171.png
21206	Caçador	\N	Brazil	https://media.api-sports.io/football/teams/21206.png
21207	Santa Catarina	\N	Brazil	https://media.api-sports.io/football/teams/21207.png
21209	Caravaggio	\N	Brazil	https://media.api-sports.io/football/teams/21209.png
21230	Progresso	\N	Brazil	https://media.api-sports.io/football/teams/21230.png
21233	Monsoon	\N	Brazil	https://media.api-sports.io/football/teams/21233.png
21234	AFA	\N	Brazil	https://media.api-sports.io/football/teams/21234.png
21258	Potiguar RN	\N	Brazil	https://media.api-sports.io/football/teams/21258.png
21463	Bulgaria U18	\N	Brazil	https://media.api-sports.io/football/teams/21463.png
22011	ADH Brasil	\N	Brazil	https://media.api-sports.io/football/teams/22011.png
22041	Sparta U20	\N	Brazil	https://media.api-sports.io/football/teams/22041.png
22042	São Paulo AP U20	\N	Brazil	https://media.api-sports.io/football/teams/22042.png
22095	ASEEV	\N	Brazil	https://media.api-sports.io/football/teams/22095.png
22096	Aparecida GO	\N	Brazil	https://media.api-sports.io/football/teams/22096.png
22097	Centro Oeste	\N	Brazil	https://media.api-sports.io/football/teams/22097.png
22098	Santa Helena	\N	Brazil	https://media.api-sports.io/football/teams/22098.png
22210	Mirassol B	\N	Brazil	https://media.api-sports.io/football/teams/22210.png
22211	RB Bragantino B	\N	Brazil	https://media.api-sports.io/football/teams/22211.png
22212	Santo André B	\N	Brazil	https://media.api-sports.io/football/teams/22212.png
22353	Rio de Janeiro	\N	Brazil	https://media.api-sports.io/football/teams/22353.png
22354	SE Belford Roxo	\N	Brazil	https://media.api-sports.io/football/teams/22354.png
22361	Confianca PB	\N	Brazil	https://media.api-sports.io/football/teams/22361.png
22362	EC de Patos	\N	Brazil	https://media.api-sports.io/football/teams/22362.png
22363	Guarabira	\N	Brazil	https://media.api-sports.io/football/teams/22363.png
22364	Picuiense	\N	Brazil	https://media.api-sports.io/football/teams/22364.png
22367	Pombal EC	\N	Brazil	https://media.api-sports.io/football/teams/22367.png
22427	Brazil U23	\N	Brazil	https://media.api-sports.io/football/teams/22427.png
22721	Avaí B	\N	Brazil	https://media.api-sports.io/football/teams/22721.png
22722	Chapecoense B	\N	Brazil	https://media.api-sports.io/football/teams/22722.png
22818	Planaltina DF	\N	Brazil	https://media.api-sports.io/football/teams/22818.png
22819	Carmópolis	\N	Brazil	https://media.api-sports.io/football/teams/22819.png
22820	Olímpico SE	\N	Brazil	https://media.api-sports.io/football/teams/22820.png
22821	Jaguaré	\N	Brazil	https://media.api-sports.io/football/teams/22821.png
22822	Penedense	\N	Brazil	https://media.api-sports.io/football/teams/22822.png
22825	Primavera MG	\N	Brazil	https://media.api-sports.io/football/teams/22825.png
22826	Unidos do Alvorada	\N	Brazil	https://media.api-sports.io/football/teams/22826.png
22827	Batalhão	\N	Brazil	https://media.api-sports.io/football/teams/22827.png
22828	Portuguesa MS	\N	Brazil	https://media.api-sports.io/football/teams/22828.png
22829	Aster Brasil SP U20	\N	Brazil	https://media.api-sports.io/football/teams/22829.png
22830	Atlético Gloriense U20	\N	Brazil	https://media.api-sports.io/football/teams/22830.png
22831	Bangu U20	\N	Brazil	https://media.api-sports.io/football/teams/22831.png
22832	Canaã DF U20	\N	Brazil	https://media.api-sports.io/football/teams/22832.png
22833	Coimbra U20	\N	Brazil	https://media.api-sports.io/football/teams/22833.png
22834	Comercial de Tietê U20	\N	Brazil	https://media.api-sports.io/football/teams/22834.png
22835	Conquista U20	\N	Brazil	https://media.api-sports.io/football/teams/22835.png
22836	Inter de Bebedouro U20	\N	Brazil	https://media.api-sports.io/football/teams/22836.png
22837	Ivinhema U20	\N	Brazil	https://media.api-sports.io/football/teams/22837.png
22838	Macapá U20	\N	Brazil	https://media.api-sports.io/football/teams/22838.png
22839	Nova Mutum U20	\N	Brazil	https://media.api-sports.io/football/teams/22839.png
22840	Nova Venécia U20	\N	Brazil	https://media.api-sports.io/football/teams/22840.png
22841	Patriotas U20	\N	Brazil	https://media.api-sports.io/football/teams/22841.png
22842	Portuguesa RJ U20	\N	Brazil	https://media.api-sports.io/football/teams/22842.png
22843	Potyguar Seridoense U20	\N	Brazil	https://media.api-sports.io/football/teams/22843.png
22844	Queimadense U20	\N	Brazil	https://media.api-sports.io/football/teams/22844.png
22845	Rio Branco AC U20	\N	Brazil	https://media.api-sports.io/football/teams/22845.png
22846	Santa Cruz SE U20	\N	Brazil	https://media.api-sports.io/football/teams/22846.png
22847	Serra Branca U20	\N	Brazil	https://media.api-sports.io/football/teams/22847.png
22848	Sfera U20	\N	Brazil	https://media.api-sports.io/football/teams/22848.png
22849	Tiradentes PI U20	\N	Brazil	https://media.api-sports.io/football/teams/22849.png
22850	CA Lemense	\N	Brazil	https://media.api-sports.io/football/teams/22850.png
22851	Catanduva	\N	Brazil	https://media.api-sports.io/football/teams/22851.png
22852	União São João	\N	Brazil	https://media.api-sports.io/football/teams/22852.png
22872	Canaã	\N	Brazil	https://media.api-sports.io/football/teams/22872.png
22873	Santa Rosa	\N	Brazil	https://media.api-sports.io/football/teams/22873.png
22875	Botafogo U20	\N	Brazil	https://media.api-sports.io/football/teams/22875.png
22945	America SP	\N	Brazil	https://media.api-sports.io/football/teams/22945.png
22946	Francana	\N	Brazil	https://media.api-sports.io/football/teams/22946.png
22947	Grêmio Sãocarlense	\N	Brazil	https://media.api-sports.io/football/teams/22947.png
22948	Independente SP	\N	Brazil	https://media.api-sports.io/football/teams/22948.png
22949	Jabaquara	\N	Brazil	https://media.api-sports.io/football/teams/22949.png
22950	Joseense	\N	Brazil	https://media.api-sports.io/football/teams/22950.png
22951	Rio Branco SP	\N	Brazil	https://media.api-sports.io/football/teams/22951.png
22952	SKA Brasil	\N	Brazil	https://media.api-sports.io/football/teams/22952.png
22953	Taquaritinga	\N	Brazil	https://media.api-sports.io/football/teams/22953.png
22954	Uniao Barbarense	\N	Brazil	https://media.api-sports.io/football/teams/22954.png
22955	Vocem	\N	Brazil	https://media.api-sports.io/football/teams/22955.png
22956	XV de Jau	\N	Brazil	https://media.api-sports.io/football/teams/22956.png
22960	Zumbi	\N	Brazil	https://media.api-sports.io/football/teams/22960.png
22961	CRB II	\N	Brazil	https://media.api-sports.io/football/teams/22961.png
23157	Fluminense W	\N	Brazil	https://media.api-sports.io/football/teams/23157.png
23158	Monte Roraima	\N	Brazil	https://media.api-sports.io/football/teams/23158.png
23197	Aparecida EC U20	\N	Brazil	https://media.api-sports.io/football/teams/23197.png
23198	Cerrado EC U20	\N	Brazil	https://media.api-sports.io/football/teams/23198.png
23199	Guanabara City U20	\N	Brazil	https://media.api-sports.io/football/teams/23199.png
23200	Guapo M19 U20	\N	Brazil	https://media.api-sports.io/football/teams/23200.png
23201	Itaberai U20	\N	Brazil	https://media.api-sports.io/football/teams/23201.png
23202	Jataiense U20	\N	Brazil	https://media.api-sports.io/football/teams/23202.png
23203	Royal U20	\N	Brazil	https://media.api-sports.io/football/teams/23203.png
23228	AA Iguacu U20	\N	Brazil	https://media.api-sports.io/football/teams/23228.png
23229	Andraus Brasil U20	\N	Brazil	https://media.api-sports.io/football/teams/23229.png
23230	Apucarana Sports U20	\N	Brazil	https://media.api-sports.io/football/teams/23230.png
23231	Arapongas U20	\N	Brazil	https://media.api-sports.io/football/teams/23231.png
23232	Araucaria U20	\N	Brazil	https://media.api-sports.io/football/teams/23232.png
23233	Azuriz U20	\N	Brazil	https://media.api-sports.io/football/teams/23233.png
23234	Batel U20	\N	Brazil	https://media.api-sports.io/football/teams/23234.png
23235	Cambé U20	\N	Brazil	https://media.api-sports.io/football/teams/23235.png
23236	Campo Mourao U20	\N	Brazil	https://media.api-sports.io/football/teams/23236.png
23237	Cascavel U20	\N	Brazil	https://media.api-sports.io/football/teams/23237.png
23238	Cianorte U20	\N	Brazil	https://media.api-sports.io/football/teams/23238.png
23239	Gremio Maringa U20	\N	Brazil	https://media.api-sports.io/football/teams/23239.png
23240	Hope Internacional U20	\N	Brazil	https://media.api-sports.io/football/teams/23240.png
23241	Independente FSJ U20	\N	Brazil	https://media.api-sports.io/football/teams/23241.png
23242	Iraty U20	\N	Brazil	https://media.api-sports.io/football/teams/23242.png
23243	Parana S.T.C. U20	\N	Brazil	https://media.api-sports.io/football/teams/23243.png
23244	Prudentópolis U20	\N	Brazil	https://media.api-sports.io/football/teams/23244.png
23245	Rio Branco PR U20	\N	Brazil	https://media.api-sports.io/football/teams/23245.png
23246	Rolândia U20	\N	Brazil	https://media.api-sports.io/football/teams/23246.png
23247	Valeriodoce	\N	Brazil	https://media.api-sports.io/football/teams/23247.png
23262	Petrópolis	\N	Brazil	https://media.api-sports.io/football/teams/23262.png
23274	Atlético Alagoinhas U20	\N	Brazil	https://media.api-sports.io/football/teams/23274.png
23275	Bahia de Feira U20	\N	Brazil	https://media.api-sports.io/football/teams/23275.png
23276	Barcelona BA U20	\N	Brazil	https://media.api-sports.io/football/teams/23276.png
23277	Catuense U20	\N	Brazil	https://media.api-sports.io/football/teams/23277.png
23278	Estrela De Marco U20	\N	Brazil	https://media.api-sports.io/football/teams/23278.png
23279	Grapiuna U20	\N	Brazil	https://media.api-sports.io/football/teams/23279.png
23280	Itabuna EC U20	\N	Brazil	https://media.api-sports.io/football/teams/23280.png
23281	Jacobina U20	\N	Brazil	https://media.api-sports.io/football/teams/23281.png
23282	Jequie U20	\N	Brazil	https://media.api-sports.io/football/teams/23282.png
23283	Leonico U20	\N	Brazil	https://media.api-sports.io/football/teams/23283.png
23284	SSA U20	\N	Brazil	https://media.api-sports.io/football/teams/23284.png
23285	Ypiranga BA U20	\N	Brazil	https://media.api-sports.io/football/teams/23285.png
23290	Futebol Com Vida	\N	Brazil	https://media.api-sports.io/football/teams/23290.png
23306	ABECAT Ouvidorense	\N	Brazil	https://media.api-sports.io/football/teams/23306.png
23307	Trindade	\N	Brazil	https://media.api-sports.io/football/teams/23307.png
23308	Paranavaí	\N	Brazil	https://media.api-sports.io/football/teams/23308.png
23321	Barra SC U20	\N	Brazil	https://media.api-sports.io/football/teams/23321.png
23322	Brusque U20	\N	Brazil	https://media.api-sports.io/football/teams/23322.png
23323	Internacional SC U20	\N	Brazil	https://media.api-sports.io/football/teams/23323.png
23324	Marcilio Dias U20	\N	Brazil	https://media.api-sports.io/football/teams/23324.png
23325	Nação U20	\N	Brazil	https://media.api-sports.io/football/teams/23325.png
23385	Audax RJ U20	\N	Brazil	https://media.api-sports.io/football/teams/23385.png
23386	Boavista U20	\N	Brazil	https://media.api-sports.io/football/teams/23386.png
23387	Sampaio Correa FE U20	\N	Brazil	https://media.api-sports.io/football/teams/23387.png
23465	Aguai U20	\N	Brazil	https://media.api-sports.io/football/teams/23465.png
23466	Bandeirante U20	\N	Brazil	https://media.api-sports.io/football/teams/23466.png
23467	Brasilis U20	\N	Brazil	https://media.api-sports.io/football/teams/23467.png
23468	CA Joseense U20	\N	Brazil	https://media.api-sports.io/football/teams/23468.png
23469	CA Taquaritinga U20	\N	Brazil	https://media.api-sports.io/football/teams/23469.png
23470	Clube Vital U20	\N	Brazil	https://media.api-sports.io/football/teams/23470.png
23471	Cosmopolitano Sports U20	\N	Brazil	https://media.api-sports.io/football/teams/23471.png
23472	Elosport U20	\N	Brazil	https://media.api-sports.io/football/teams/23472.png
23473	Fernandopolis U20	\N	Brazil	https://media.api-sports.io/football/teams/23473.png
23474	GE Osasco U20	\N	Brazil	https://media.api-sports.io/football/teams/23474.png
23475	Gremio Prudente U20	\N	Brazil	https://media.api-sports.io/football/teams/23475.png
23476	Guacuano U20	\N	Brazil	https://media.api-sports.io/football/teams/23476.png
23477	Independente SP U20	\N	Brazil	https://media.api-sports.io/football/teams/23477.png
23478	Jabaquara U20	\N	Brazil	https://media.api-sports.io/football/teams/23478.png
23479	Jose Bonifacio EC U20	\N	Brazil	https://media.api-sports.io/football/teams/23479.png
23480	Metropolitano FC U20	\N	Brazil	https://media.api-sports.io/football/teams/23480.png
23481	Paulinia FU U20	\N	Brazil	https://media.api-sports.io/football/teams/23481.png
23482	Pinda U20	\N	Brazil	https://media.api-sports.io/football/teams/23482.png
23483	Porto Football U20	\N	Brazil	https://media.api-sports.io/football/teams/23483.png
23484	Presidente Prudente U20	\N	Brazil	https://media.api-sports.io/football/teams/23484.png
23485	Referencia U20	\N	Brazil	https://media.api-sports.io/football/teams/23485.png
23486	Rio Branco U20	\N	Brazil	https://media.api-sports.io/football/teams/23486.png
23487	Aguia FC U20	\N	Brazil	https://media.api-sports.io/football/teams/23487.png
23488	America PE U20	\N	Brazil	https://media.api-sports.io/football/teams/23488.png
23489	Atletico Torres U20	\N	Brazil	https://media.api-sports.io/football/teams/23489.png
23490	Belo Jardim U20	\N	Brazil	https://media.api-sports.io/football/teams/23490.png
23491	CA Porto U20	\N	Brazil	https://media.api-sports.io/football/teams/23491.png
23492	Central SC U20	\N	Brazil	https://media.api-sports.io/football/teams/23492.png
23493	Centro Limoeirense U20	\N	Brazil	https://media.api-sports.io/football/teams/23493.png
23494	Ibis Sport Club U20	\N	Brazil	https://media.api-sports.io/football/teams/23494.png
23495	Ipojuca U20	\N	Brazil	https://media.api-sports.io/football/teams/23495.png
23496	Jaguar U20	\N	Brazil	https://media.api-sports.io/football/teams/23496.png
23497	Santa Fe U20	\N	Brazil	https://media.api-sports.io/football/teams/23497.png
23498	Serrano PE U20	\N	Brazil	https://media.api-sports.io/football/teams/23498.png
23499	Sete de Setembro U20	\N	Brazil	https://media.api-sports.io/football/teams/23499.png
23560	Atlético Matogrossense	\N	Brazil	https://media.api-sports.io/football/teams/23560.png
23561	Campo Novo	\N	Brazil	https://media.api-sports.io/football/teams/23561.png
23562	Cáceres	\N	Brazil	https://media.api-sports.io/football/teams/23562.png
23563	Juara	\N	Brazil	https://media.api-sports.io/football/teams/23563.png
23564	Paulistano MT	\N	Brazil	https://media.api-sports.io/football/teams/23564.png
23565	Rondonopolis EC	\N	Brazil	https://media.api-sports.io/football/teams/23565.png
23566	Santa Cruz MT	\N	Brazil	https://media.api-sports.io/football/teams/23566.png
23567	Capixaba SC	\N	Brazil	https://media.api-sports.io/football/teams/23567.png
23568	Sport Brasil ES	\N	Brazil	https://media.api-sports.io/football/teams/23568.png
23569	AEA	\N	Brazil	https://media.api-sports.io/football/teams/23569.png
23570	Atletico Mogi	\N	Brazil	https://media.api-sports.io/football/teams/23570.png
23571	Barcelona EC	\N	Brazil	https://media.api-sports.io/football/teams/23571.png
23572	Colorado Caieiras	\N	Brazil	https://media.api-sports.io/football/teams/23572.png
23573	ECUS	\N	Brazil	https://media.api-sports.io/football/teams/23573.png
23574	Fernandopolis	\N	Brazil	https://media.api-sports.io/football/teams/23574.png
23575	Flamengo SP	\N	Brazil	https://media.api-sports.io/football/teams/23575.png
23576	Inter de Bebedouro	\N	Brazil	https://media.api-sports.io/football/teams/23576.png
23577	Manthiqueira	\N	Brazil	https://media.api-sports.io/football/teams/23577.png
23578	Maua	\N	Brazil	https://media.api-sports.io/football/teams/23578.png
23579	Mauaense	\N	Brazil	https://media.api-sports.io/football/teams/23579.png
23580	Sao Carlos	\N	Brazil	https://media.api-sports.io/football/teams/23580.png
23581	Tanabi	\N	Brazil	https://media.api-sports.io/football/teams/23581.png
23582	Tupa	\N	Brazil	https://media.api-sports.io/football/teams/23582.png
23583	Uniao Mogi	\N	Brazil	https://media.api-sports.io/football/teams/23583.png
23591	Porto BA	\N	Brazil	https://media.api-sports.io/football/teams/23591.png
23592	SSA	\N	Brazil	https://media.api-sports.io/football/teams/23592.png
23608	Botafogo DF U20	\N	Brazil	https://media.api-sports.io/football/teams/23608.png
23609	Brasiliense U20	\N	Brazil	https://media.api-sports.io/football/teams/23609.png
23610	CFZ Brasilia U20	\N	Brazil	https://media.api-sports.io/football/teams/23610.png
23611	Ceilandense U20	\N	Brazil	https://media.api-sports.io/football/teams/23611.png
23612	Grêmio Valparaíso U20	\N	Brazil	https://media.api-sports.io/football/teams/23612.png
23613	Legiao U20	\N	Brazil	https://media.api-sports.io/football/teams/23613.png
23614	Luziânia U20	\N	Brazil	https://media.api-sports.io/football/teams/23614.png
23615	Paranoa U20	\N	Brazil	https://media.api-sports.io/football/teams/23615.png
23616	Samambaia U20	\N	Brazil	https://media.api-sports.io/football/teams/23616.png
23617	Unai DF U20	\N	Brazil	https://media.api-sports.io/football/teams/23617.png
23634	CAAC Brasil	\N	Brazil	https://media.api-sports.io/football/teams/23634.png
23635	EC Resende	\N	Brazil	https://media.api-sports.io/football/teams/23635.png
23636	EC Vera Cruz	\N	Brazil	https://media.api-sports.io/football/teams/23636.png
23637	Niteroiense	\N	Brazil	https://media.api-sports.io/football/teams/23637.png
23638	Paraty	\N	Brazil	https://media.api-sports.io/football/teams/23638.png
23639	Riostrense	\N	Brazil	https://media.api-sports.io/football/teams/23639.png
23640	Santa Cruz RJ	\N	Brazil	https://media.api-sports.io/football/teams/23640.png
23641	Uni Souza	\N	Brazil	https://media.api-sports.io/football/teams/23641.png
23642	Uniao Central	\N	Brazil	https://media.api-sports.io/football/teams/23642.png
23643	Athletic Club MG U20	\N	Brazil	https://media.api-sports.io/football/teams/23643.png
23644	Betim U20	\N	Brazil	https://media.api-sports.io/football/teams/23644.png
23645	Boston City U20	\N	Brazil	https://media.api-sports.io/football/teams/23645.png
23646	Contagem U20	\N	Brazil	https://media.api-sports.io/football/teams/23646.png
23647	Futgol U20	\N	Brazil	https://media.api-sports.io/football/teams/23647.png
23648	Ipatinga U20	\N	Brazil	https://media.api-sports.io/football/teams/23648.png
23649	Minas Boca U20	\N	Brazil	https://media.api-sports.io/football/teams/23649.png
23650	Santarritense U20	\N	Brazil	https://media.api-sports.io/football/teams/23650.png
23651	Tres Coracoes U20	\N	Brazil	https://media.api-sports.io/football/teams/23651.png
23652	XV de Novembro U20	\N	Brazil	https://media.api-sports.io/football/teams/23652.png
23664	São Cristóvão RJ	\N	Brazil	https://media.api-sports.io/football/teams/23664.png
23665	Zinza	\N	Brazil	https://media.api-sports.io/football/teams/23665.png
23667	América de Propriá U20	\N	Brazil	https://media.api-sports.io/football/teams/23667.png
23668	Dorense U20	\N	Brazil	https://media.api-sports.io/football/teams/23668.png
23686	ASA U20	\N	Brazil	https://media.api-sports.io/football/teams/23686.png
23687	Azzurra U20	\N	Brazil	https://media.api-sports.io/football/teams/23687.png
23688	CEO U20	\N	Brazil	https://media.api-sports.io/football/teams/23688.png
23689	Canoense U20	\N	Brazil	https://media.api-sports.io/football/teams/23689.png
23690	Coruripe U20	\N	Brazil	https://media.api-sports.io/football/teams/23690.png
23691	DZM Passo U20	\N	Brazil	https://media.api-sports.io/football/teams/23691.png
23692	Flamengo Ipiranga U20	\N	Brazil	https://media.api-sports.io/football/teams/23692.png
23693	Gaviao Izidorense U20	\N	Brazil	https://media.api-sports.io/football/teams/23693.png
23694	Grota do Facao U20	\N	Brazil	https://media.api-sports.io/football/teams/23694.png
23695	Guarani Paripueira U20	\N	Brazil	https://media.api-sports.io/football/teams/23695.png
23696	Guarany Alagoano U20	\N	Brazil	https://media.api-sports.io/football/teams/23696.png
23697	Independente Atalaia U20	\N	Brazil	https://media.api-sports.io/football/teams/23697.png
23698	Lajense U20	\N	Brazil	https://media.api-sports.io/football/teams/23698.png
23699	Liga do Sertao U20	\N	Brazil	https://media.api-sports.io/football/teams/23699.png
23700	M10 Rio Largo U20	\N	Brazil	https://media.api-sports.io/football/teams/23700.png
23701	Murici U20	\N	Brazil	https://media.api-sports.io/football/teams/23701.png
23702	Paulo Jacinto U20	\N	Brazil	https://media.api-sports.io/football/teams/23702.png
23703	Penedense U20	\N	Brazil	https://media.api-sports.io/football/teams/23703.png
23704	Ponte Preta AL U20	\N	Brazil	https://media.api-sports.io/football/teams/23704.png
23705	Santa Cruz AL U20	\N	Brazil	https://media.api-sports.io/football/teams/23705.png
23706	Sao Domingos U20	\N	Brazil	https://media.api-sports.io/football/teams/23706.png
23707	Satuba U20	\N	Brazil	https://media.api-sports.io/football/teams/23707.png
23708	São Sebastião U20	\N	Brazil	https://media.api-sports.io/football/teams/23708.png
23709	Talismã Sertãozinho U20	\N	Brazil	https://media.api-sports.io/football/teams/23709.png
23710	UNEC U20	\N	Brazil	https://media.api-sports.io/football/teams/23710.png
23711	Ubertec U20	\N	Brazil	https://media.api-sports.io/football/teams/23711.png
23719	Acopiara U20	\N	Brazil	https://media.api-sports.io/football/teams/23719.png
23720	Alianca U20	\N	Brazil	https://media.api-sports.io/football/teams/23720.png
23721	Alvinegro U20	\N	Brazil	https://media.api-sports.io/football/teams/23721.png
23722	CA Cearense U20	\N	Brazil	https://media.api-sports.io/football/teams/23722.png
23723	Cariri U20	\N	Brazil	https://media.api-sports.io/football/teams/23723.png
23724	Caucaia U20	\N	Brazil	https://media.api-sports.io/football/teams/23724.png
23725	Crato U20	\N	Brazil	https://media.api-sports.io/football/teams/23725.png
23726	Ferroviario U20	\N	Brazil	https://media.api-sports.io/football/teams/23726.png
23727	Horizonte U20	\N	Brazil	https://media.api-sports.io/football/teams/23727.png
23728	Icasa U20	\N	Brazil	https://media.api-sports.io/football/teams/23728.png
23729	Iguatu U20	\N	Brazil	https://media.api-sports.io/football/teams/23729.png
23730	Itapipoca U20	\N	Brazil	https://media.api-sports.io/football/teams/23730.png
23731	Itarema U20	\N	Brazil	https://media.api-sports.io/football/teams/23731.png
23732	Juventus CE U20	\N	Brazil	https://media.api-sports.io/football/teams/23732.png
23733	Pacatuba U20	\N	Brazil	https://media.api-sports.io/football/teams/23733.png
23734	Santa Cruz CE U20	\N	Brazil	https://media.api-sports.io/football/teams/23734.png
23735	Sao Gerardo U20	\N	Brazil	https://media.api-sports.io/football/teams/23735.png
23736	Terra e Mar U20	\N	Brazil	https://media.api-sports.io/football/teams/23736.png
23737	Tiradentes CE U20	\N	Brazil	https://media.api-sports.io/football/teams/23737.png
23738	Tirol U20	\N	Brazil	https://media.api-sports.io/football/teams/23738.png
23742	Belenense	\N	Brazil	https://media.api-sports.io/football/teams/23742.png
23743	Fonte Nova	\N	Brazil	https://media.api-sports.io/football/teams/23743.png
23744	Pedreira	\N	Brazil	https://media.api-sports.io/football/teams/23744.png
23745	Tesla	\N	Brazil	https://media.api-sports.io/football/teams/23745.png
23746	Tiradentes PA	\N	Brazil	https://media.api-sports.io/football/teams/23746.png
24036	Auto Esporte PB U20	\N	Brazil	https://media.api-sports.io/football/teams/24036.png
24037	Cruzeiro Itaporanga U20	\N	Brazil	https://media.api-sports.io/football/teams/24037.png
24038	Esporte de Patos U20	\N	Brazil	https://media.api-sports.io/football/teams/24038.png
24039	Femar U20	\N	Brazil	https://media.api-sports.io/football/teams/24039.png
24040	Grêmio Serrano U20	\N	Brazil	https://media.api-sports.io/football/teams/24040.png
24041	Guarabira U20	\N	Brazil	https://media.api-sports.io/football/teams/24041.png
24042	Internacional PB U20	\N	Brazil	https://media.api-sports.io/football/teams/24042.png
24043	Picuiense U20	\N	Brazil	https://media.api-sports.io/football/teams/24043.png
24044	Pombal U20	\N	Brazil	https://media.api-sports.io/football/teams/24044.png
24045	Sabugy U20	\N	Brazil	https://media.api-sports.io/football/teams/24045.png
24046	Sao Paulo Crystal U20	\N	Brazil	https://media.api-sports.io/football/teams/24046.png
24047	Sousa U20	\N	Brazil	https://media.api-sports.io/football/teams/24047.png
24048	Spartax U20	\N	Brazil	https://media.api-sports.io/football/teams/24048.png
24049	Sport PB U20	\N	Brazil	https://media.api-sports.io/football/teams/24049.png
24050	Treze U20	\N	Brazil	https://media.api-sports.io/football/teams/24050.png
24092	Itarema	\N	Brazil	https://media.api-sports.io/football/teams/24092.png
24093	Quixada	\N	Brazil	https://media.api-sports.io/football/teams/24093.png
24094	Terra e Mar	\N	Brazil	https://media.api-sports.io/football/teams/24094.png
24095	Tianguá	\N	Brazil	https://media.api-sports.io/football/teams/24095.png
24096	Aliança	\N	Brazil	https://media.api-sports.io/football/teams/24096.png
24119	Cabense	\N	Brazil	https://media.api-sports.io/football/teams/24119.png
24120	Centro Limoeirense	\N	Brazil	https://media.api-sports.io/football/teams/24120.png
24121	Ipojuca	\N	Brazil	https://media.api-sports.io/football/teams/24121.png
24468	America MG U17	\N	Brazil	https://media.api-sports.io/football/teams/24468.png
24469	Athletico PR U17	\N	Brazil	https://media.api-sports.io/football/teams/24469.png
24470	Atletico GO U17	\N	Brazil	https://media.api-sports.io/football/teams/24470.png
24471	Atlético Mineiro U17	\N	Brazil	https://media.api-sports.io/football/teams/24471.png
24472	Bahia U17	\N	Brazil	https://media.api-sports.io/football/teams/24472.png
24473	Botafogo U17	\N	Brazil	https://media.api-sports.io/football/teams/24473.png
24474	Ceara U17	\N	Brazil	https://media.api-sports.io/football/teams/24474.png
24475	Corinthians U17	\N	Brazil	https://media.api-sports.io/football/teams/24475.png
24476	Cruzeiro U17	\N	Brazil	https://media.api-sports.io/football/teams/24476.png
24477	Cuiaba U17	\N	Brazil	https://media.api-sports.io/football/teams/24477.png
24478	Flamengo RJ U17	\N	Brazil	https://media.api-sports.io/football/teams/24478.png
24479	Fluminense U17	\N	Brazil	https://media.api-sports.io/football/teams/24479.png
24480	Fortaleza U17	\N	Brazil	https://media.api-sports.io/football/teams/24480.png
24481	Goias U17	\N	Brazil	https://media.api-sports.io/football/teams/24481.png
24482	Gremio U17	\N	Brazil	https://media.api-sports.io/football/teams/24482.png
24483	Internacional U17	\N	Brazil	https://media.api-sports.io/football/teams/24483.png
24484	Palmeiras U17	\N	Brazil	https://media.api-sports.io/football/teams/24484.png
24485	RB Bragantino U17	\N	Brazil	https://media.api-sports.io/football/teams/24485.png
24486	Santos U17	\N	Brazil	https://media.api-sports.io/football/teams/24486.png
24487	Sao Paulo U17	\N	Brazil	https://media.api-sports.io/football/teams/24487.png
24524	Nacional de Patos U20	\N	Brazil	https://media.api-sports.io/football/teams/24524.png
24599	Cruzeiro PB	\N	Brazil	https://media.api-sports.io/football/teams/24599.png
24764	America GO	\N	Brazil	https://media.api-sports.io/football/teams/24764.png
24765	Bela Vista	\N	Brazil	https://media.api-sports.io/football/teams/24765.png
24766	Cerrado	\N	Brazil	https://media.api-sports.io/football/teams/24766.png
24767	Guanabara City	\N	Brazil	https://media.api-sports.io/football/teams/24767.png
24768	Itaberai	\N	Brazil	https://media.api-sports.io/football/teams/24768.png
24769	Mineiros	\N	Brazil	https://media.api-sports.io/football/teams/24769.png
24770	Pires do Rio	\N	Brazil	https://media.api-sports.io/football/teams/24770.png
24771	Rio Verde	\N	Brazil	https://media.api-sports.io/football/teams/24771.png
24772	Rioverdense	\N	Brazil	https://media.api-sports.io/football/teams/24772.png
24773	Tupy FC	\N	Brazil	https://media.api-sports.io/football/teams/24773.png
24774	Uruacu	\N	Brazil	https://media.api-sports.io/football/teams/24774.png
24793	RB do Norte	\N	Brazil	https://media.api-sports.io/football/teams/24793.png
24794	Taruma	\N	Brazil	https://media.api-sports.io/football/teams/24794.png
24801	Amadense	\N	Brazil	https://media.api-sports.io/football/teams/24801.png
24802	Aracaju FC	\N	Brazil	https://media.api-sports.io/football/teams/24802.png
24803	Barra SE	\N	Brazil	https://media.api-sports.io/football/teams/24803.png
24804	Boquinhense	\N	Brazil	https://media.api-sports.io/football/teams/24804.png
24805	Botafogo ASF	\N	Brazil	https://media.api-sports.io/football/teams/24805.png
24806	Caninde	\N	Brazil	https://media.api-sports.io/football/teams/24806.png
24807	Coritiba SE	\N	Brazil	https://media.api-sports.io/football/teams/24807.png
24808	Cotinguiba	\N	Brazil	https://media.api-sports.io/football/teams/24808.png
24809	Desportiva Aracaju	\N	Brazil	https://media.api-sports.io/football/teams/24809.png
24810	Flamengo SE	\N	Brazil	https://media.api-sports.io/football/teams/24810.png
24811	Força Jovem SE	\N	Brazil	https://media.api-sports.io/football/teams/24811.png
24812	Guarany SE	\N	Brazil	https://media.api-sports.io/football/teams/24812.png
24813	Independente Simão Dias	\N	Brazil	https://media.api-sports.io/football/teams/24813.png
24814	Propriá	\N	Brazil	https://media.api-sports.io/football/teams/24814.png
24815	Riachao	\N	Brazil	https://media.api-sports.io/football/teams/24815.png
24816	Santa Cruz SE	\N	Brazil	https://media.api-sports.io/football/teams/24816.png
24817	Sete de Junho	\N	Brazil	https://media.api-sports.io/football/teams/24817.png
24818	Socorrense	\N	Brazil	https://media.api-sports.io/football/teams/24818.png
24819	Socorro Sport	\N	Brazil	https://media.api-sports.io/football/teams/24819.png
24823	Cambé	\N	Brazil	https://media.api-sports.io/football/teams/24823.png
24824	Campo Mourão	\N	Brazil	https://media.api-sports.io/football/teams/24824.png
24825	Hope Internacional	\N	Brazil	https://media.api-sports.io/football/teams/24825.png
24826	Iraty	\N	Brazil	https://media.api-sports.io/football/teams/24826.png
24827	Oeste Brasil	\N	Brazil	https://media.api-sports.io/football/teams/24827.png
24828	Portuguesa Londrinense	\N	Brazil	https://media.api-sports.io/football/teams/24828.png
24829	Estrela Potiguar U20	\N	Brazil	https://media.api-sports.io/football/teams/24829.png
24830	Força e Luz U20	\N	Brazil	https://media.api-sports.io/football/teams/24830.png
24831	Fábrica de Craques U20	\N	Brazil	https://media.api-sports.io/football/teams/24831.png
24832	Globo U20	\N	Brazil	https://media.api-sports.io/football/teams/24832.png
24833	Laguna U20	\N	Brazil	https://media.api-sports.io/football/teams/24833.png
24834	Parnamirim U20	\N	Brazil	https://media.api-sports.io/football/teams/24834.png
24835	QFC U20	\N	Brazil	https://media.api-sports.io/football/teams/24835.png
24836	Riachuelo U20	\N	Brazil	https://media.api-sports.io/football/teams/24836.png
24837	Rio Grande U20	\N	Brazil	https://media.api-sports.io/football/teams/24837.png
24910	Botafogo DF	\N	Brazil	https://media.api-sports.io/football/teams/24910.png
24911	GREVAL	\N	Brazil	https://media.api-sports.io/football/teams/24911.png
24912	Legião	\N	Brazil	https://media.api-sports.io/football/teams/24912.png
24913	Riacho City	\N	Brazil	https://media.api-sports.io/football/teams/24913.png
24914	SESP Samambaense	\N	Brazil	https://media.api-sports.io/football/teams/24914.png
24915	Taguatinga EC	\N	Brazil	https://media.api-sports.io/football/teams/24915.png
24916	America TO	\N	Brazil	https://media.api-sports.io/football/teams/24916.png
24917	Araguari	\N	Brazil	https://media.api-sports.io/football/teams/24917.png
24918	Contagem	\N	Brazil	https://media.api-sports.io/football/teams/24918.png
24919	Essube	\N	Brazil	https://media.api-sports.io/football/teams/24919.png
24920	Inter de Minas	\N	Brazil	https://media.api-sports.io/football/teams/24920.png
24921	Nacional Uberaba	\N	Brazil	https://media.api-sports.io/football/teams/24921.png
24922	Poços de Caldas	\N	Brazil	https://media.api-sports.io/football/teams/24922.png
24923	Social	\N	Brazil	https://media.api-sports.io/football/teams/24923.png
24924	Tres Coracoes	\N	Brazil	https://media.api-sports.io/football/teams/24924.png
24925	Villa Real	\N	Brazil	https://media.api-sports.io/football/teams/24925.png
24926	Aimore U20	\N	Brazil	https://media.api-sports.io/football/teams/24926.png
24927	Apafut U20	\N	Brazil	https://media.api-sports.io/football/teams/24927.png
24928	Caxias U20	\N	Brazil	https://media.api-sports.io/football/teams/24928.png
24929	Esportivo U20	\N	Brazil	https://media.api-sports.io/football/teams/24929.png
24930	Futebol Com Vida U20	\N	Brazil	https://media.api-sports.io/football/teams/24930.png
24931	Gramadense U20	\N	Brazil	https://media.api-sports.io/football/teams/24931.png
24932	Monsoon U20	\N	Brazil	https://media.api-sports.io/football/teams/24932.png
24933	Novo Hamburgo U20	\N	Brazil	https://media.api-sports.io/football/teams/24933.png
24934	Real SC U20	\N	Brazil	https://media.api-sports.io/football/teams/24934.png
24935	SERC Brasil U20	\N	Brazil	https://media.api-sports.io/football/teams/24935.png
24936	Sao Luiz U20	\N	Brazil	https://media.api-sports.io/football/teams/24936.png
24937	Ypiranga Erechim U20	\N	Brazil	https://media.api-sports.io/football/teams/24937.png
24969	Akademija Pandev U19	\N	Brazil	https://media.api-sports.io/football/teams/24969.png
24998	CA Vila Rica	\N	Brazil	https://media.api-sports.io/football/teams/24998.png
24999	Capitao Poco	\N	Brazil	https://media.api-sports.io/football/teams/24999.png
25000	Izabelense	\N	Brazil	https://media.api-sports.io/football/teams/25000.png
25001	Pinheirense	\N	Brazil	https://media.api-sports.io/football/teams/25001.png
25002	Santos PA	\N	Brazil	https://media.api-sports.io/football/teams/25002.png
25003	Uniao Paraense	\N	Brazil	https://media.api-sports.io/football/teams/25003.png
25004	ESMAC	\N	Brazil	https://media.api-sports.io/football/teams/25004.png
25005	FF Sport Nova Cruz	\N	Brazil	https://media.api-sports.io/football/teams/25005.png
25006	Guarany Alagoano	\N	Brazil	https://media.api-sports.io/football/teams/25006.png
25007	Igaci	\N	Brazil	https://media.api-sports.io/football/teams/25007.png
25008	Sao Domingos AL	\N	Brazil	https://media.api-sports.io/football/teams/25008.png
25009	Castelo	\N	Brazil	https://media.api-sports.io/football/teams/25009.png
25010	GEL	\N	Brazil	https://media.api-sports.io/football/teams/25010.png
25011	Tupy	\N	Brazil	https://media.api-sports.io/football/teams/25011.png
25015	Náutico RR U20	\N	Brazil	https://media.api-sports.io/football/teams/25015.png
25016	Tuna Luso PA U20	\N	Brazil	https://media.api-sports.io/football/teams/25016.png
25043	Americano Bacabal	\N	Brazil	https://media.api-sports.io/football/teams/25043.png
25044	Expressinho	\N	Brazil	https://media.api-sports.io/football/teams/25044.png
25045	Sao Luis	\N	Brazil	https://media.api-sports.io/football/teams/25045.png
25046	Viana / Real Codó	\N	Brazil	https://media.api-sports.io/football/teams/25046.png
25072	Parnamirim	\N	Brazil	https://media.api-sports.io/football/teams/25072.png
25073	QFC	\N	Brazil	https://media.api-sports.io/football/teams/25073.png
25074	Rio Grande RN	\N	Brazil	https://media.api-sports.io/football/teams/25074.png
25075	Univap Apodi	\N	Brazil	https://media.api-sports.io/football/teams/25075.png
25076	Apafut	\N	Brazil	https://media.api-sports.io/football/teams/25076.png
25077	FBC Riograndense RS	\N	Brazil	https://media.api-sports.io/football/teams/25077.png
25078	Farroupilha	\N	Brazil	https://media.api-sports.io/football/teams/25078.png
25079	Gramadense	\N	Brazil	https://media.api-sports.io/football/teams/25079.png
25080	SC Rio Grande	\N	Brazil	https://media.api-sports.io/football/teams/25080.png
25081	Aguia FC	\N	Brazil	https://media.api-sports.io/football/teams/25081.png
25082	Cha Grande	\N	Brazil	https://media.api-sports.io/football/teams/25082.png
25083	Pesqueira	\N	Brazil	https://media.api-sports.io/football/teams/25083.png
25084	1º de Maio	\N	Brazil	https://media.api-sports.io/football/teams/25084.png
25115	FC Porto	\N	Brazil	https://media.api-sports.io/football/teams/25115.png
25116	Fluminense-SC	\N	Brazil	https://media.api-sports.io/football/teams/25116.png
25117	Jaraguá	\N	Brazil	https://media.api-sports.io/football/teams/25117.png
25123	Laguna	\N	Brazil	https://media.api-sports.io/football/teams/25123.png
25125	Atletico-MG U23	\N	Brazil	https://media.api-sports.io/football/teams/25125.png
25126	Goias U23	\N	Brazil	https://media.api-sports.io/football/teams/25126.png
25127	Mirassol U23	\N	Brazil	https://media.api-sports.io/football/teams/25127.png
25128	Vasco U23	\N	Brazil	https://media.api-sports.io/football/teams/25128.png
25129	Tupan	\N	Brazil	https://media.api-sports.io/football/teams/25129.png
25178	Mageense	\N	Brazil	https://media.api-sports.io/football/teams/25178.png
25181	ITZ Sport	\N	Brazil	https://media.api-sports.io/football/teams/25181.png
25182	Santa Quitéria	\N	Brazil	https://media.api-sports.io/football/teams/25182.png
25190	Sena Madureira U20	\N	Brazil	https://media.api-sports.io/football/teams/25190.png
25196	Atletico Barbarense U20	\N	Brazil	https://media.api-sports.io/football/teams/25196.png
25197	Atletico JM9 U20	\N	Brazil	https://media.api-sports.io/football/teams/25197.png
25198	Barbarense PA U20	\N	Brazil	https://media.api-sports.io/football/teams/25198.png
25199	Belenense U20	\N	Brazil	https://media.api-sports.io/football/teams/25199.png
25200	CRT-23 Benevides U20	\N	Brazil	https://media.api-sports.io/football/teams/25200.png
25201	Castelo dos Sonhos U20	\N	Brazil	https://media.api-sports.io/football/teams/25201.png
25202	Comercial PA U20	\N	Brazil	https://media.api-sports.io/football/teams/25202.png
25203	Craques do Futuro U20	\N	Brazil	https://media.api-sports.io/football/teams/25203.png
25204	Cruzeirao U20	\N	Brazil	https://media.api-sports.io/football/teams/25204.png
25205	EC Tailandia U20	\N	Brazil	https://media.api-sports.io/football/teams/25205.png
25206	ESMAC U20	\N	Brazil	https://media.api-sports.io/football/teams/25206.png
25207	Estrela PA U20	\N	Brazil	https://media.api-sports.io/football/teams/25207.png
25208	Fonte Nova U20	\N	Brazil	https://media.api-sports.io/football/teams/25208.png
25209	Juventude Barcarenense U20	\N	Brazil	https://media.api-sports.io/football/teams/25209.png
25210	Maracana Taua U20	\N	Brazil	https://media.api-sports.io/football/teams/25210.png
25211	Meninos de Ouro U20	\N	Brazil	https://media.api-sports.io/football/teams/25211.png
25212	Paysandu PA U20	\N	Brazil	https://media.api-sports.io/football/teams/25212.png
25213	Ponte Nova U20	\N	Brazil	https://media.api-sports.io/football/teams/25213.png
25214	Real Naval U20	\N	Brazil	https://media.api-sports.io/football/teams/25214.png
25215	Sport Belem U20	\N	Brazil	https://media.api-sports.io/football/teams/25215.png
25216	Tailandia AC U20	\N	Brazil	https://media.api-sports.io/football/teams/25216.png
25217	Terra Alta U20	\N	Brazil	https://media.api-sports.io/football/teams/25217.png
25218	Tiradentes PA U20	\N	Brazil	https://media.api-sports.io/football/teams/25218.png
25219	Trabalhista U20	\N	Brazil	https://media.api-sports.io/football/teams/25219.png
25220	Venus U20	\N	Brazil	https://media.api-sports.io/football/teams/25220.png
25221	Vila Rica SC U20	\N	Brazil	https://media.api-sports.io/football/teams/25221.png
25222	Águia de Marabá U20	\N	Brazil	https://media.api-sports.io/football/teams/25222.png
25223	Gremio 2	\N	Brazil	https://media.api-sports.io/football/teams/25223.png
25224	Internacional 2	\N	Brazil	https://media.api-sports.io/football/teams/25224.png
25225	Juventude II	\N	Brazil	https://media.api-sports.io/football/teams/25225.png
25226	Brazil U17 W	\N	Brazil	https://media.api-sports.io/football/teams/25226.png
25382	Ceara B	\N	Brazil	https://media.api-sports.io/football/teams/25382.png
25383	Fortaleza B	\N	Brazil	https://media.api-sports.io/football/teams/25383.png
25417	Atlético Piauiense	\N	Brazil	https://media.api-sports.io/football/teams/25417.png
25431	América SE U20	\N	Brazil	https://media.api-sports.io/football/teams/25431.png
25432	Araguacema U20	\N	Brazil	https://media.api-sports.io/football/teams/25432.png
25433	Capitão Poço U20	\N	Brazil	https://media.api-sports.io/football/teams/25433.png
25434	Dom Bosco U20	\N	Brazil	https://media.api-sports.io/football/teams/25434.png
25435	Dourados U20	\N	Brazil	https://media.api-sports.io/football/teams/25435.png
25436	Gênus U20	\N	Brazil	https://media.api-sports.io/football/teams/25436.png
25437	Mazagão U20	\N	Brazil	https://media.api-sports.io/football/teams/25437.png
25438	Monte Roraima U20	\N	Brazil	https://media.api-sports.io/football/teams/25438.png
25439	Operário AC MS U20	\N	Brazil	https://media.api-sports.io/football/teams/25439.png
25440	Piauí U20	\N	Brazil	https://media.api-sports.io/football/teams/25440.png
25441	Rio Branco ES U20	\N	Brazil	https://media.api-sports.io/football/teams/25441.png
25442	Santa Cruz AC U20	\N	Brazil	https://media.api-sports.io/football/teams/25442.png
25443	Santa Fé SP U20	\N	Brazil	https://media.api-sports.io/football/teams/25443.png
25444	União TO U20	\N	Brazil	https://media.api-sports.io/football/teams/25444.png
25445	Votoraty U20	\N	Brazil	https://media.api-sports.io/football/teams/25445.png
25473	Cristal	\N	Brazil	https://media.api-sports.io/football/teams/25473.png
25474	Portuguesa AP	\N	Brazil	https://media.api-sports.io/football/teams/25474.png
25483	Rolim de Moura	\N	Brazil	https://media.api-sports.io/football/teams/25483.png
25519	Viana	\N	Brazil	https://media.api-sports.io/football/teams/25519.png
25565	CSA B	\N	Brazil	https://media.api-sports.io/football/teams/25565.png
25591	Sete	\N	Brazil	https://media.api-sports.io/football/teams/25591.png
25593	Americano U20	\N	Brazil	https://media.api-sports.io/football/teams/25593.png
25594	Artsul U20	\N	Brazil	https://media.api-sports.io/football/teams/25594.png
25595	Maricá U20	\N	Brazil	https://media.api-sports.io/football/teams/25595.png
25729	Goianesia U20	\N	Brazil	https://media.api-sports.io/football/teams/25729.png
25730	Gremio Anapolis U20	\N	Brazil	https://media.api-sports.io/football/teams/25730.png
25731	Itauçu U20	\N	Brazil	https://media.api-sports.io/football/teams/25731.png
25770	Assisense	\N	Brazil	https://media.api-sports.io/football/teams/25770.png
25771	Guarulhos	\N	Brazil	https://media.api-sports.io/football/teams/25771.png
25772	Santacruzense	\N	Brazil	https://media.api-sports.io/football/teams/25772.png
25786	Alecrim U17	\N	Brazil	https://media.api-sports.io/football/teams/25786.png
25787	Amazonas U17	\N	Brazil	https://media.api-sports.io/football/teams/25787.png
25788	Atletico-PI U17	\N	Brazil	https://media.api-sports.io/football/teams/25788.png
25789	Batalhao U17	\N	Brazil	https://media.api-sports.io/football/teams/25789.png
25790	Capital U17	\N	Brazil	https://media.api-sports.io/football/teams/25790.png
25791	Chapecoense-SC U17	\N	Brazil	https://media.api-sports.io/football/teams/25791.png
25792	Coimbra U17	\N	Brazil	https://media.api-sports.io/football/teams/25792.png
25793	Falcon U17	\N	Brazil	https://media.api-sports.io/football/teams/25793.png
25794	Galvez U17	\N	Brazil	https://media.api-sports.io/football/teams/25794.png
25795	Hope Internacional U17	\N	Brazil	https://media.api-sports.io/football/teams/25795.png
25796	Ismailly-MS U17	\N	Brazil	https://media.api-sports.io/football/teams/25796.png
25797	Juventude U17	\N	Brazil	https://media.api-sports.io/football/teams/25797.png
25798	Mazagao U17	\N	Brazil	https://media.api-sports.io/football/teams/25798.png
25799	Monte Roraima U17	\N	Brazil	https://media.api-sports.io/football/teams/25799.png
25800	Olhodaguense U17	\N	Brazil	https://media.api-sports.io/football/teams/25800.png
25801	Porto Velho U17	\N	Brazil	https://media.api-sports.io/football/teams/25801.png
25802	Porto Vitoria U17	\N	Brazil	https://media.api-sports.io/football/teams/25802.png
25803	Remo U17	\N	Brazil	https://media.api-sports.io/football/teams/25803.png
25804	SE Juventude U17	\N	Brazil	https://media.api-sports.io/football/teams/25804.png
25805	Sport Recife U17	\N	Brazil	https://media.api-sports.io/football/teams/25805.png
25806	VF4 U17	\N	Brazil	https://media.api-sports.io/football/teams/25806.png
25807	Vasco U17	\N	Brazil	https://media.api-sports.io/football/teams/25807.png
25808	Ypiranga BA	\N	Brazil	https://media.api-sports.io/football/teams/25808.png
25810	Atlântico U20	\N	Brazil	https://media.api-sports.io/football/teams/25810.png
25811	Botafogo BA U20	\N	Brazil	https://media.api-sports.io/football/teams/25811.png
25812	Feirense U20	\N	Brazil	https://media.api-sports.io/football/teams/25812.png
25813	Fluminense de Feira U20	\N	Brazil	https://media.api-sports.io/football/teams/25813.png
25814	Galícia U20	\N	Brazil	https://media.api-sports.io/football/teams/25814.png
25815	Porto BA U20	\N	Brazil	https://media.api-sports.io/football/teams/25815.png
25816	Teixeira de Freitas U20	\N	Brazil	https://media.api-sports.io/football/teams/25816.png
25824	3B da Amazônia	\N	Brazil	https://media.api-sports.io/football/teams/25824.png
25825	Juventude W	\N	Brazil	https://media.api-sports.io/football/teams/25825.png
25889	Itabirito U20	\N	Brazil	https://media.api-sports.io/football/teams/25889.png
25890	Mamoré U20	\N	Brazil	https://media.api-sports.io/football/teams/25890.png
25891	Uberaba U20	\N	Brazil	https://media.api-sports.io/football/teams/25891.png
25892	Villa Real U20	\N	Brazil	https://media.api-sports.io/football/teams/25892.png
9	Spain	SPA	Spain	https://media.api-sports.io/football/teams/9.png
529	Barcelona	BAR	Spain	https://media.api-sports.io/football/teams/529.png
530	Atletico Madrid	MAD	Spain	https://media.api-sports.io/football/teams/530.png
531	Athletic Club	BIL	Spain	https://media.api-sports.io/football/teams/531.png
532	Valencia	VAL	Spain	https://media.api-sports.io/football/teams/532.png
533	Villarreal	VIL	Spain	https://media.api-sports.io/football/teams/533.png
534	Las Palmas	PAL	Spain	https://media.api-sports.io/football/teams/534.png
535	Malaga	MAL	Spain	https://media.api-sports.io/football/teams/535.png
536	Sevilla	SEV	Spain	https://media.api-sports.io/football/teams/536.png
537	Leganes	LEG	Spain	https://media.api-sports.io/football/teams/537.png
538	Celta Vigo	CEL	Spain	https://media.api-sports.io/football/teams/538.png
539	Levante	LEV	Spain	https://media.api-sports.io/football/teams/539.png
540	Espanyol	ESP	Spain	https://media.api-sports.io/football/teams/540.png
541	Real Madrid	REA	Spain	https://media.api-sports.io/football/teams/541.png
542	Alaves	ALA	Spain	https://media.api-sports.io/football/teams/542.png
543	Real Betis	BET	Spain	https://media.api-sports.io/football/teams/543.png
544	Deportivo La Coruna	COR	Spain	https://media.api-sports.io/football/teams/544.png
545	Eibar	EIB	Spain	https://media.api-sports.io/football/teams/545.png
546	Getafe	GET	Spain	https://media.api-sports.io/football/teams/546.png
547	Girona	GIR	Spain	https://media.api-sports.io/football/teams/547.png
548	Real Sociedad	RSO	Spain	https://media.api-sports.io/football/teams/548.png
593	Europa Fc	\N	Spain	https://media.api-sports.io/football/teams/593.png
711	Alcorcon	ALC	Spain	https://media.api-sports.io/football/teams/711.png
712	Barcelona B	BAR	Spain	https://media.api-sports.io/football/teams/712.png
713	Cordoba	COR	Spain	https://media.api-sports.io/football/teams/713.png
714	Gimnastic	GIM	Spain	https://media.api-sports.io/football/teams/714.png
715	Granada CF	GRA	Spain	https://media.api-sports.io/football/teams/715.png
716	Lugo	LUG	Spain	https://media.api-sports.io/football/teams/716.png
717	Numancia	NUM	Spain	https://media.api-sports.io/football/teams/717.png
718	Oviedo	OVI	Spain	https://media.api-sports.io/football/teams/718.png
719	Tenerife	TEN	Spain	https://media.api-sports.io/football/teams/719.png
720	Valladolid	VAL	Spain	https://media.api-sports.io/football/teams/720.png
721	Lorca FC	\N	Spain	https://media.api-sports.io/football/teams/721.png
722	Albacete	ALB	Spain	https://media.api-sports.io/football/teams/722.png
723	Almeria	ALM	Spain	https://media.api-sports.io/football/teams/723.png
724	Cadiz	CAD	Spain	https://media.api-sports.io/football/teams/724.png
725	Cultural Leonesa	CUL	Spain	https://media.api-sports.io/football/teams/725.png
726	Huesca	HUE	Spain	https://media.api-sports.io/football/teams/726.png
727	Osasuna	OSA	Spain	https://media.api-sports.io/football/teams/727.png
728	Rayo Vallecano	RAY	Spain	https://media.api-sports.io/football/teams/728.png
729	Reus	REU	Spain	https://media.api-sports.io/football/teams/729.png
730	Sevilla Atletico	SEV	Spain	https://media.api-sports.io/football/teams/730.png
731	Sporting Gijon	GIJ	Spain	https://media.api-sports.io/football/teams/731.png
732	Zaragoza	ZAR	Spain	https://media.api-sports.io/football/teams/732.png
797	Elche	ELC	Spain	https://media.api-sports.io/football/teams/797.png
798	Mallorca	MAL	Spain	https://media.api-sports.io/football/teams/798.png
799	Mirandes	MIR	Spain	https://media.api-sports.io/football/teams/799.png
800	Ucam Murcia	\N	Spain	https://media.api-sports.io/football/teams/800.png
860	Extremadura	\N	Spain	https://media.api-sports.io/football/teams/860.png
861	Rayo Majadahonda	\N	Spain	https://media.api-sports.io/football/teams/861.png
1736	Spain W	\N	Spain	https://media.api-sports.io/football/teams/1736.png
1904	Ud Tacuense W	\N	Spain	https://media.api-sports.io/football/teams/1904.png
1905	Athletic Club W	\N	Spain	https://media.api-sports.io/football/teams/1905.png
1906	Oiartzun Ke W	\N	Spain	https://media.api-sports.io/football/teams/1906.png
1907	Real Betis W	\N	Spain	https://media.api-sports.io/football/teams/1907.png
1908	Santa Teresa W	\N	Spain	https://media.api-sports.io/football/teams/1908.png
1909	Valencia W	\N	Spain	https://media.api-sports.io/football/teams/1909.png
1910	Atletico Madrid W	\N	Spain	https://media.api-sports.io/football/teams/1910.png
1911	Levante W	\N	Spain	https://media.api-sports.io/football/teams/1911.png
1912	Real Sociedad W	\N	Spain	https://media.api-sports.io/football/teams/1912.png
1913	Granad. Tenerife W	\N	Spain	https://media.api-sports.io/football/teams/1913.png
1914	Rayo Vallecano W	\N	Spain	https://media.api-sports.io/football/teams/1914.png
1915	Fundacion Albacete W	\N	Spain	https://media.api-sports.io/football/teams/1915.png
1916	Sporting Huelva W	\N	Spain	https://media.api-sports.io/football/teams/1916.png
1917	Zaragoza W	\N	Spain	https://media.api-sports.io/football/teams/1917.png
1918	Barcelona W	\N	Spain	https://media.api-sports.io/football/teams/1918.png
1919	Espanyol W	\N	Spain	https://media.api-sports.io/football/teams/1919.png
1920	Sevilla W	\N	Spain	https://media.api-sports.io/football/teams/1920.png
1921	Madrid CFF W	\N	Spain	https://media.api-sports.io/football/teams/1921.png
1922	Malaga W	\N	Spain	https://media.api-sports.io/football/teams/1922.png
1923	Edf Logrono W	\N	Spain	https://media.api-sports.io/football/teams/1923.png
4665	Racing Santander	SAN	Spain	https://media.api-sports.io/football/teams/4665.png
4666	Hércules	HER	Spain	https://media.api-sports.io/football/teams/4666.png
4890	Santa Eulália	\N	Spain	https://media.api-sports.io/football/teams/4890.png
4906	Fuenlabrada	FUE	Spain	https://media.api-sports.io/football/teams/4906.png
4907	Ponferradina	PON	Spain	https://media.api-sports.io/football/teams/4907.png
5250	Badalona	BAD	Spain	https://media.api-sports.io/football/teams/5250.png
5251	Barakaldo	BAR	Spain	https://media.api-sports.io/football/teams/5251.png
5252	CD Calahorra	\N	Spain	https://media.api-sports.io/football/teams/5252.png
5253	CF Talavera	\N	Spain	https://media.api-sports.io/football/teams/5253.png
5254	Castellón	\N	Spain	https://media.api-sports.io/football/teams/5254.png
5255	Ceuta	\N	Spain	https://media.api-sports.io/football/teams/5255.png
5256	Compostela	COM	Spain	https://media.api-sports.io/football/teams/5256.png
5257	Conquense	CON	Spain	https://media.api-sports.io/football/teams/5257.png
5258	Cornellà	\N	Spain	https://media.api-sports.io/football/teams/5258.png
5259	Don Benito	\N	Spain	https://media.api-sports.io/football/teams/5259.png
5260	Durango	\N	Spain	https://media.api-sports.io/football/teams/5260.png
5261	Ebro	\N	Spain	https://media.api-sports.io/football/teams/5261.png
5262	FC Cartagena	CAR	Spain	https://media.api-sports.io/football/teams/5262.png
5263	Gernika	\N	Spain	https://media.api-sports.io/football/teams/5263.png
5264	Gimnástica Torrelavega	\N	Spain	https://media.api-sports.io/football/teams/5264.png
5265	Langreo	\N	Spain	https://media.api-sports.io/football/teams/5265.png
5266	Lleida Esportiu	LLE	Spain	https://media.api-sports.io/football/teams/5266.png
5267	Marbella	\N	Spain	https://media.api-sports.io/football/teams/5267.png
5268	Melilla	MEL	Spain	https://media.api-sports.io/football/teams/5268.png
5269	Mensajero	\N	Spain	https://media.api-sports.io/football/teams/5269.png
5270	Mutilvera	\N	Spain	https://media.api-sports.io/football/teams/5270.png
5271	Navalcarnero	\N	Spain	https://media.api-sports.io/football/teams/5271.png
5272	Ontinyent	ONT	Spain	https://media.api-sports.io/football/teams/5272.png
5273	Poblense	\N	Spain	https://media.api-sports.io/football/teams/5273.png
5274	Real Jaén	JAE	Spain	https://media.api-sports.io/football/teams/5274.png
5275	Real Murcia	MUR	Spain	https://media.api-sports.io/football/teams/5275.png
5276	Rápido Bouzas	\N	Spain	https://media.api-sports.io/football/teams/5276.png
5277	Sant Andreu	SAN	Spain	https://media.api-sports.io/football/teams/5277.png
5278	Teruel	\N	Spain	https://media.api-sports.io/football/teams/5278.png
5279	Tudelano	TUD	Spain	https://media.api-sports.io/football/teams/5279.png
5280	UD Logroñés	LOG	Spain	https://media.api-sports.io/football/teams/5280.png
5281	Unionistas de Salamanca	\N	Spain	https://media.api-sports.io/football/teams/5281.png
5282	Villanovense	VIL	Spain	https://media.api-sports.io/football/teams/5282.png
5283	Yeclano	\N	Spain	https://media.api-sports.io/football/teams/5283.png
6376	Deportivo de La Coruña W	\N	Spain	https://media.api-sports.io/football/teams/6376.png
6377	Tacón W	\N	Spain	https://media.api-sports.io/football/teams/6377.png
6688	Mora	\N	Spain	https://media.api-sports.io/football/teams/6688.png
7522	Antoniano	\N	Spain	https://media.api-sports.io/football/teams/7522.png
7523	Atlético Porcuna	\N	Spain	https://media.api-sports.io/football/teams/7523.png
7524	Melilla CD	\N	Spain	https://media.api-sports.io/football/teams/7524.png
7525	Ramón y Cajal	\N	Spain	https://media.api-sports.io/football/teams/7525.png
7884	Atlético Madrid U19	MAD	Spain	https://media.api-sports.io/football/teams/7884.png
7885	Barcelona U19	BAR	Spain	https://media.api-sports.io/football/teams/7885.png
7897	Domžale U19	\N	Spain	https://media.api-sports.io/football/teams/7897.png
7899	Elfsborg U19	\N	Spain	https://media.api-sports.io/football/teams/7899.png
7915	Midtjylland U19	\N	Spain	https://media.api-sports.io/football/teams/7915.png
7916	Minsk U19	\N	Spain	https://media.api-sports.io/football/teams/7916.png
7926	Real Madrid U19	REA	Spain	https://media.api-sports.io/football/teams/7926.png
7927	Real Zaragoza U19	\N	Spain	https://media.api-sports.io/football/teams/7927.png
7928	Salzburg U19	\N	Spain	https://media.api-sports.io/football/teams/7928.png
7939	Viitorul U19	\N	Spain	https://media.api-sports.io/football/teams/7939.png
7952	HJK U19	\N	Spain	https://media.api-sports.io/football/teams/7952.png
7987	Legia Warszawa U19	\N	Spain	https://media.api-sports.io/football/teams/7987.png
7992	Saburtalo U19	\N	Spain	https://media.api-sports.io/football/teams/7992.png
8000	Zimbru U19	\N	Spain	https://media.api-sports.io/football/teams/8000.png
8001	Željezničar U19	\N	Spain	https://media.api-sports.io/football/teams/8001.png
8151	Andratx	\N	Spain	https://media.api-sports.io/football/teams/8151.png
8152	Barquereño	\N	Spain	https://media.api-sports.io/football/teams/8152.png
8153	Becerril Campos	\N	Spain	https://media.api-sports.io/football/teams/8153.png
8154	Comillas	\N	Spain	https://media.api-sports.io/football/teams/8154.png
8155	El Palmar	\N	Spain	https://media.api-sports.io/football/teams/8155.png
8156	El Álamo	\N	Spain	https://media.api-sports.io/football/teams/8156.png
8157	FC Andorra	\N	Spain	https://media.api-sports.io/football/teams/8157.png
8158	Fraga	\N	Spain	https://media.api-sports.io/football/teams/8158.png
8159	Gran Tarajal	\N	Spain	https://media.api-sports.io/football/teams/8159.png
8160	Intercity	\N	Spain	https://media.api-sports.io/football/teams/8160.png
8161	Lobón	\N	Spain	https://media.api-sports.io/football/teams/8161.png
8162	Pedroñeras	\N	Spain	https://media.api-sports.io/football/teams/8162.png
8163	Peña Azagresa	\N	Spain	https://media.api-sports.io/football/teams/8163.png
8164	Pontellas	\N	Spain	https://media.api-sports.io/football/teams/8164.png
8165	Tolosa	\N	Spain	https://media.api-sports.io/football/teams/8165.png
8166	Urraca	\N	Spain	https://media.api-sports.io/football/teams/8166.png
8224	Spain U21	SPA	Spain	https://media.api-sports.io/football/teams/8224.png
9380	Amorebieta	AMO	Spain	https://media.api-sports.io/football/teams/9380.png
9381	Atlético Baleares	BAL	Spain	https://media.api-sports.io/football/teams/9381.png
9382	Badajoz	\N	Spain	https://media.api-sports.io/football/teams/9382.png
9383	Bergantiños	\N	Spain	https://media.api-sports.io/football/teams/9383.png
9384	Cacereño	CAC	Spain	https://media.api-sports.io/football/teams/9384.png
9385	Coruxo	COR	Spain	https://media.api-sports.io/football/teams/9385.png
9386	Escobedo	\N	Spain	https://media.api-sports.io/football/teams/9386.png
9387	Gimnástica Segoviana	\N	Spain	https://media.api-sports.io/football/teams/9387.png
9388	Guijuelo	GUI	Spain	https://media.api-sports.io/football/teams/9388.png
9389	Haro Deportivo	\N	Spain	https://media.api-sports.io/football/teams/9389.png
9390	Ibiza	\N	Spain	https://media.api-sports.io/football/teams/9390.png
9391	Illueca	\N	Spain	https://media.api-sports.io/football/teams/9391.png
9392	L'Hospitalet	HOS	Spain	https://media.api-sports.io/football/teams/9392.png
9393	La Nucía	\N	Spain	https://media.api-sports.io/football/teams/9393.png
9394	Laredo	\N	Spain	https://media.api-sports.io/football/teams/9394.png
9395	Las Rozas	\N	Spain	https://media.api-sports.io/football/teams/9395.png
9396	Lealtad	\N	Spain	https://media.api-sports.io/football/teams/9396.png
9397	Leioa	\N	Spain	https://media.api-sports.io/football/teams/9397.png
9398	Linares Deportivo	\N	Spain	https://media.api-sports.io/football/teams/9398.png
9399	Llagostera	LLA	Spain	https://media.api-sports.io/football/teams/9399.png
9400	Lorca Deportiva	\N	Spain	https://media.api-sports.io/football/teams/9400.png
9401	Marino de Luanco	MAR	Spain	https://media.api-sports.io/football/teams/9401.png
9402	Mérida	MER	Spain	https://media.api-sports.io/football/teams/9402.png
9403	Olot	\N	Spain	https://media.api-sports.io/football/teams/9403.png
9404	Orihuela	ORI	Spain	https://media.api-sports.io/football/teams/9404.png
9405	Peña Deportiva	\N	Spain	https://media.api-sports.io/football/teams/9405.png
9406	Peña Sport	PEN	Spain	https://media.api-sports.io/football/teams/9406.png
9407	Pontevedra	\N	Spain	https://media.api-sports.io/football/teams/9407.png
9408	Portugalete	\N	Spain	https://media.api-sports.io/football/teams/9408.png
9409	Racing Ferrol	FER	Spain	https://media.api-sports.io/football/teams/9409.png
9410	Recreativo Huelva	REC	Spain	https://media.api-sports.io/football/teams/9410.png
9411	SD Logroñés	SDL	Spain	https://media.api-sports.io/football/teams/9411.png
9412	SS Reyes	\N	Spain	https://media.api-sports.io/football/teams/9412.png
9413	Sestao River	SES	Spain	https://media.api-sports.io/football/teams/9413.png
9414	Socuéllamos	\N	Spain	https://media.api-sports.io/football/teams/9414.png
9415	Tamaraceite	\N	Spain	https://media.api-sports.io/football/teams/9415.png
9416	Tarazona	\N	Spain	https://media.api-sports.io/football/teams/9416.png
9417	Villarrubia	\N	Spain	https://media.api-sports.io/football/teams/9417.png
9418	Zamora	\N	Spain	https://media.api-sports.io/football/teams/9418.png
9479	Villafranca	\N	Spain	https://media.api-sports.io/football/teams/9479.png
9570	Atlético Madrid II	MAD	Spain	https://media.api-sports.io/football/teams/9570.png
9571	Celta de Vigo II	CEL	Spain	https://media.api-sports.io/football/teams/9571.png
9572	Getafe II	GET	Spain	https://media.api-sports.io/football/teams/9572.png
9573	Internacional de Madrid	\N	Spain	https://media.api-sports.io/football/teams/9573.png
9574	Las Palmas II	PAL	Spain	https://media.api-sports.io/football/teams/9574.png
9575	Real Madrid II	REA	Spain	https://media.api-sports.io/football/teams/9575.png
9576	Real Oviedo II	\N	Spain	https://media.api-sports.io/football/teams/9576.png
9577	Sporting Gijón II	\N	Spain	https://media.api-sports.io/football/teams/9577.png
9578	Arenas Getxo	\N	Spain	https://media.api-sports.io/football/teams/9578.png
9579	Athletic Club II	BIL	Spain	https://media.api-sports.io/football/teams/9579.png
9580	Burgos	BUR	Spain	https://media.api-sports.io/football/teams/9580.png
9581	Calahorra	\N	Spain	https://media.api-sports.io/football/teams/9581.png
9582	Deportivo Alavés II	\N	Spain	https://media.api-sports.io/football/teams/9582.png
9583	Izarra	\N	Spain	https://media.api-sports.io/football/teams/9583.png
9584	Osasuna II	\N	Spain	https://media.api-sports.io/football/teams/9584.png
9585	Real Sociedad II	RSO	Spain	https://media.api-sports.io/football/teams/9585.png
9586	Real Unión	REA	Spain	https://media.api-sports.io/football/teams/9586.png
9587	Real Valladolid II	\N	Spain	https://media.api-sports.io/football/teams/9587.png
9588	Salamanca UDS	\N	Spain	https://media.api-sports.io/football/teams/9588.png
9589	Ejea	\N	Spain	https://media.api-sports.io/football/teams/9589.png
9590	Espanyol II	ESP	Spain	https://media.api-sports.io/football/teams/9590.png
9591	Levante II	LEV	Spain	https://media.api-sports.io/football/teams/9591.png
9592	Prat	PRA	Spain	https://media.api-sports.io/football/teams/9592.png
9593	Sabadell	SAB	Spain	https://media.api-sports.io/football/teams/9593.png
9594	Valencia II	VAL	Spain	https://media.api-sports.io/football/teams/9594.png
9595	Villarreal II	VIL	Spain	https://media.api-sports.io/football/teams/9595.png
9596	Linense	\N	Spain	https://media.api-sports.io/football/teams/9596.png
9597	Algeciras	ALG	Spain	https://media.api-sports.io/football/teams/9597.png
9598	Cádiz II	\N	Spain	https://media.api-sports.io/football/teams/9598.png
9599	Granada II	GRA	Spain	https://media.api-sports.io/football/teams/9599.png
9600	San Fernando CD	FER	Spain	https://media.api-sports.io/football/teams/9600.png
9601	Sanluqueño	SAN	Spain	https://media.api-sports.io/football/teams/9601.png
9602	Villarrobledo	\N	Spain	https://media.api-sports.io/football/teams/9602.png
9603	Alondras	\N	Spain	https://media.api-sports.io/football/teams/9603.png
9604	Arenteiro	\N	Spain	https://media.api-sports.io/football/teams/9604.png
9605	Arosa	\N	Spain	https://media.api-sports.io/football/teams/9605.png
9606	Arzúa	\N	Spain	https://media.api-sports.io/football/teams/9606.png
9607	As Pontes	\N	Spain	https://media.api-sports.io/football/teams/9607.png
9608	Barco	\N	Spain	https://media.api-sports.io/football/teams/9608.png
9609	Choco	\N	Spain	https://media.api-sports.io/football/teams/9609.png
9610	Deportivo La Coruña II	\N	Spain	https://media.api-sports.io/football/teams/9610.png
9611	Estradense	\N	Spain	https://media.api-sports.io/football/teams/9611.png
9612	Ourense CF	\N	Spain	https://media.api-sports.io/football/teams/9612.png
9613	Paiosaco	\N	Spain	https://media.api-sports.io/football/teams/9613.png
9614	Polvorín	\N	Spain	https://media.api-sports.io/football/teams/9614.png
9615	Silva	\N	Spain	https://media.api-sports.io/football/teams/9615.png
9616	Somozas	\N	Spain	https://media.api-sports.io/football/teams/9616.png
9617	UD Ourense	\N	Spain	https://media.api-sports.io/football/teams/9617.png
9618	Villalbés	\N	Spain	https://media.api-sports.io/football/teams/9618.png
9619	Caudal	CAU	Spain	https://media.api-sports.io/football/teams/9619.png
9620	Ceares	\N	Spain	https://media.api-sports.io/football/teams/9620.png
9621	Colunga	\N	Spain	https://media.api-sports.io/football/teams/9621.png
9622	Condal	\N	Spain	https://media.api-sports.io/football/teams/9622.png
9623	Covadonga	VAD	Spain	https://media.api-sports.io/football/teams/9623.png
9624	Gijón Industrial	\N	Spain	https://media.api-sports.io/football/teams/9624.png
9625	L'Entregu	\N	Spain	https://media.api-sports.io/football/teams/9625.png
9626	Lenense	\N	Spain	https://media.api-sports.io/football/teams/9626.png
9627	Llanera	\N	Spain	https://media.api-sports.io/football/teams/9627.png
9628	Llanes	\N	Spain	https://media.api-sports.io/football/teams/9628.png
9629	Mosconia	\N	Spain	https://media.api-sports.io/football/teams/9629.png
9630	Navarro	\N	Spain	https://media.api-sports.io/football/teams/9630.png
9631	Praviano	\N	Spain	https://media.api-sports.io/football/teams/9631.png
9632	Real Avilés	\N	Spain	https://media.api-sports.io/football/teams/9632.png
9633	San Martín	\N	Spain	https://media.api-sports.io/football/teams/9633.png
9634	Siero	\N	Spain	https://media.api-sports.io/football/teams/9634.png
9635	Tuilla	\N	Spain	https://media.api-sports.io/football/teams/9635.png
9636	Vallobín	\N	Spain	https://media.api-sports.io/football/teams/9636.png
9637	Atlético Albericia	\N	Spain	https://media.api-sports.io/football/teams/9637.png
9638	Barreda	\N	Spain	https://media.api-sports.io/football/teams/9638.png
9639	Bezana	\N	Spain	https://media.api-sports.io/football/teams/9639.png
9640	Cartes	\N	Spain	https://media.api-sports.io/football/teams/9640.png
9641	Cayón	\N	Spain	https://media.api-sports.io/football/teams/9641.png
9642	Guarnizo	\N	Spain	https://media.api-sports.io/football/teams/9642.png
9643	Racing Santander II	\N	Spain	https://media.api-sports.io/football/teams/9643.png
9644	Ribamontán al Mar	\N	Spain	https://media.api-sports.io/football/teams/9644.png
9645	Selaya	\N	Spain	https://media.api-sports.io/football/teams/9645.png
9646	Siete Villas	\N	Spain	https://media.api-sports.io/football/teams/9646.png
9647	Solares	\N	Spain	https://media.api-sports.io/football/teams/9647.png
9648	Sámano	\N	Spain	https://media.api-sports.io/football/teams/9648.png
9649	Textil Escudo	\N	Spain	https://media.api-sports.io/football/teams/9649.png
9650	Torina	\N	Spain	https://media.api-sports.io/football/teams/9650.png
9651	Tropezón	TRO	Spain	https://media.api-sports.io/football/teams/9651.png
9652	Vimenor	\N	Spain	https://media.api-sports.io/football/teams/9652.png
9653	Vitoria	\N	Spain	https://media.api-sports.io/football/teams/9653.png
9654	Ariznabarra	\N	Spain	https://media.api-sports.io/football/teams/9654.png
9655	Balmaseda	\N	Spain	https://media.api-sports.io/football/teams/9655.png
9656	Basconia	\N	Spain	https://media.api-sports.io/football/teams/9656.png
9657	Beasain	\N	Spain	https://media.api-sports.io/football/teams/9657.png
9658	Deusto	\N	Spain	https://media.api-sports.io/football/teams/9658.png
9659	JD Somorrostro	\N	Spain	https://media.api-sports.io/football/teams/9659.png
9660	Lagun Onak	\N	Spain	https://media.api-sports.io/football/teams/9660.png
9661	Pasaia KE	\N	Spain	https://media.api-sports.io/football/teams/9661.png
9662	Real Sociedad III	\N	Spain	https://media.api-sports.io/football/teams/9662.png
9663	San Ignacio	SAN	Spain	https://media.api-sports.io/football/teams/9663.png
9664	Santurtzi	\N	Spain	https://media.api-sports.io/football/teams/9664.png
9665	Santutxu	\N	Spain	https://media.api-sports.io/football/teams/9665.png
9666	Sodupe	\N	Spain	https://media.api-sports.io/football/teams/9666.png
9667	Urduliz	\N	Spain	https://media.api-sports.io/football/teams/9667.png
9668	Banyoles	\N	Spain	https://media.api-sports.io/football/teams/9668.png
9669	Castelldefels	\N	Spain	https://media.api-sports.io/football/teams/9669.png
9670	Cerdanyola del Vallès	\N	Spain	https://media.api-sports.io/football/teams/9670.png
9671	Figueres	\N	Spain	https://media.api-sports.io/football/teams/9671.png
9672	Granollers	\N	Spain	https://media.api-sports.io/football/teams/9672.png
9673	Horta	\N	Spain	https://media.api-sports.io/football/teams/9673.png
9674	Igualada	\N	Spain	https://media.api-sports.io/football/teams/9674.png
9675	Manresa	\N	Spain	https://media.api-sports.io/football/teams/9675.png
9676	Peralada	\N	Spain	https://media.api-sports.io/football/teams/9676.png
9677	Pobla Mafumet	\N	Spain	https://media.api-sports.io/football/teams/9677.png
9678	San Cristóbal	\N	Spain	https://media.api-sports.io/football/teams/9678.png
9679	Santfeliuenc	\N	Spain	https://media.api-sports.io/football/teams/9679.png
9680	Sants	\N	Spain	https://media.api-sports.io/football/teams/9680.png
9681	Terrassa	\N	Spain	https://media.api-sports.io/football/teams/9681.png
9682	Vilafranca	\N	Spain	https://media.api-sports.io/football/teams/9682.png
9683	Vilassar Mar	\N	Spain	https://media.api-sports.io/football/teams/9683.png
9684	Roda	\N	Spain	https://media.api-sports.io/football/teams/9684.png
9685	Acero	\N	Spain	https://media.api-sports.io/football/teams/9685.png
9686	Alcoyano	ALC	Spain	https://media.api-sports.io/football/teams/9686.png
9687	Alzira	\N	Spain	https://media.api-sports.io/football/teams/9687.png
9688	Atzeneta	\N	Spain	https://media.api-sports.io/football/teams/9688.png
9689	Benigànim	\N	Spain	https://media.api-sports.io/football/teams/9689.png
9690	Crevillente	\N	Spain	https://media.api-sports.io/football/teams/9690.png
9691	Elche II	ELC	Spain	https://media.api-sports.io/football/teams/9691.png
9692	Eldense	\N	Spain	https://media.api-sports.io/football/teams/9692.png
9693	Hércules II	\N	Spain	https://media.api-sports.io/football/teams/9693.png
9694	Jove Español	\N	Spain	https://media.api-sports.io/football/teams/9694.png
9695	Novelda	\N	Spain	https://media.api-sports.io/football/teams/9695.png
9696	Olímpic Xàtiva	XAT	Spain	https://media.api-sports.io/football/teams/9696.png
9697	Paterna	\N	Spain	https://media.api-sports.io/football/teams/9697.png
9698	RC Catarroja	\N	Spain	https://media.api-sports.io/football/teams/9698.png
9699	Saguntino	\N	Spain	https://media.api-sports.io/football/teams/9699.png
9700	Silla	\N	Spain	https://media.api-sports.io/football/teams/9700.png
9701	Vilamarxant	\N	Spain	https://media.api-sports.io/football/teams/9701.png
9702	Villarreal III	\N	Spain	https://media.api-sports.io/football/teams/9702.png
9703	Santa Ana	\N	Spain	https://media.api-sports.io/football/teams/9703.png
9704	AD Parla	\N	Spain	https://media.api-sports.io/football/teams/9704.png
9705	Alcobendas Sport	\N	Spain	https://media.api-sports.io/football/teams/9705.png
9706	Alcorcón II	\N	Spain	https://media.api-sports.io/football/teams/9706.png
9707	Atlético Pinto	\N	Spain	https://media.api-sports.io/football/teams/9707.png
9708	Carabanchel	\N	Spain	https://media.api-sports.io/football/teams/9708.png
9709	Flat Earth	\N	Spain	https://media.api-sports.io/football/teams/9709.png
9710	Leganés II	\N	Spain	https://media.api-sports.io/football/teams/9710.png
9711	Moratalaz	\N	Spain	https://media.api-sports.io/football/teams/9711.png
9712	Móstoles	\N	Spain	https://media.api-sports.io/football/teams/9712.png
9713	Pozuelo Alarcón	\N	Spain	https://media.api-sports.io/football/teams/9713.png
9714	RSD Alcalá	\N	Spain	https://media.api-sports.io/football/teams/9714.png
9715	Rayo Vallecano II	\N	Spain	https://media.api-sports.io/football/teams/9715.png
9716	San Fernando Henares	\N	Spain	https://media.api-sports.io/football/teams/9716.png
9717	Torrejón	\N	Spain	https://media.api-sports.io/football/teams/9717.png
9718	Trival Valderas	\N	Spain	https://media.api-sports.io/football/teams/9718.png
9719	Unión Adarve	\N	Spain	https://media.api-sports.io/football/teams/9719.png
9720	Villaverde-Boetticher	\N	Spain	https://media.api-sports.io/football/teams/9720.png
9721	Almazán	\N	Spain	https://media.api-sports.io/football/teams/9721.png
9722	Arandina	\N	Spain	https://media.api-sports.io/football/teams/9722.png
9723	Atlético Astorga	\N	Spain	https://media.api-sports.io/football/teams/9723.png
9724	Atlético Tordesillas	\N	Spain	https://media.api-sports.io/football/teams/9724.png
9725	Bembibre	\N	Spain	https://media.api-sports.io/football/teams/9725.png
9726	Bupolsa	\N	Spain	https://media.api-sports.io/football/teams/9726.png
9727	Burgos Promesas	\N	Spain	https://media.api-sports.io/football/teams/9727.png
9728	Cristo Atlético	\N	Spain	https://media.api-sports.io/football/teams/9728.png
9729	Cultural Leonesa II	\N	Spain	https://media.api-sports.io/football/teams/9729.png
9730	La Bañeza	\N	Spain	https://media.api-sports.io/football/teams/9730.png
9731	La Granja	\N	Spain	https://media.api-sports.io/football/teams/9731.png
9732	La Virgen del Camino	\N	Spain	https://media.api-sports.io/football/teams/9732.png
9733	Mirandés II	\N	Spain	https://media.api-sports.io/football/teams/9733.png
9734	Numancia II	\N	Spain	https://media.api-sports.io/football/teams/9734.png
9735	Real Burgos	\N	Spain	https://media.api-sports.io/football/teams/9735.png
9736	Real Ávila	\N	Spain	https://media.api-sports.io/football/teams/9736.png
9737	Salamanca II	\N	Spain	https://media.api-sports.io/football/teams/9737.png
9738	UD Santa Marta	\N	Spain	https://media.api-sports.io/football/teams/9738.png
9739	Vélez	\N	Spain	https://media.api-sports.io/football/teams/9739.png
9740	Alhaurín	\N	Spain	https://media.api-sports.io/football/teams/9740.png
9741	Almería II	ALM	Spain	https://media.api-sports.io/football/teams/9741.png
9742	Antequera	\N	Spain	https://media.api-sports.io/football/teams/9742.png
9743	Ciudad de Torredonjimeno	\N	Spain	https://media.api-sports.io/football/teams/9743.png
9744	El Ejido	\N	Spain	https://media.api-sports.io/football/teams/9744.png
9745	El Palo	PAL	Spain	https://media.api-sports.io/football/teams/9745.png
9746	Huétor Tájar	\N	Spain	https://media.api-sports.io/football/teams/9746.png
9747	Huétor Vega	\N	Spain	https://media.api-sports.io/football/teams/9747.png
9748	Loja	\N	Spain	https://media.api-sports.io/football/teams/9748.png
9749	Mancha Real	\N	Spain	https://media.api-sports.io/football/teams/9749.png
9750	Maracena	\N	Spain	https://media.api-sports.io/football/teams/9750.png
9751	Motril	\N	Spain	https://media.api-sports.io/football/teams/9751.png
9752	Málaga II	\N	Spain	https://media.api-sports.io/football/teams/9752.png
9753	Polideportivo Almería	\N	Spain	https://media.api-sports.io/football/teams/9753.png
9754	Torreperogil	\N	Spain	https://media.api-sports.io/football/teams/9754.png
9755	Arcos	\N	Spain	https://media.api-sports.io/football/teams/9755.png
9756	Ciudad de Lucena	LUC	Spain	https://media.api-sports.io/football/teams/9756.png
9757	Conil	\N	Spain	https://media.api-sports.io/football/teams/9757.png
9758	Coria CF	\N	Spain	https://media.api-sports.io/football/teams/9758.png
9759	Córdoba II	COR	Spain	https://media.api-sports.io/football/teams/9759.png
9760	Gerena	\N	Spain	https://media.api-sports.io/football/teams/9760.png
9761	Lebrijana	\N	Spain	https://media.api-sports.io/football/teams/9761.png
9762	Los Barrios	\N	Spain	https://media.api-sports.io/football/teams/9762.png
9763	Pozoblanco	\N	Spain	https://media.api-sports.io/football/teams/9763.png
9764	Puente Genil	\N	Spain	https://media.api-sports.io/football/teams/9764.png
9765	Real Betis II	\N	Spain	https://media.api-sports.io/football/teams/9765.png
9766	Rota	\N	Spain	https://media.api-sports.io/football/teams/9766.png
9767	San Roque Lepe	\N	Spain	https://media.api-sports.io/football/teams/9767.png
9768	Sevilla III	\N	Spain	https://media.api-sports.io/football/teams/9768.png
9769	Utrera	\N	Spain	https://media.api-sports.io/football/teams/9769.png
9770	Xerez	\N	Spain	https://media.api-sports.io/football/teams/9770.png
9771	Xerez Deportivo	\N	Spain	https://media.api-sports.io/football/teams/9771.png
9772	Écija	ECI	Spain	https://media.api-sports.io/football/teams/9772.png
9773	Alcúdia	\N	Spain	https://media.api-sports.io/football/teams/9773.png
9774	Binissalem	\N	Spain	https://media.api-sports.io/football/teams/9774.png
9775	Collerense	\N	Spain	https://media.api-sports.io/football/teams/9775.png
9776	Constància	CON	Spain	https://media.api-sports.io/football/teams/9776.png
9777	Esporles	\N	Spain	https://media.api-sports.io/football/teams/9777.png
9778	Felanitx	\N	Spain	https://media.api-sports.io/football/teams/9778.png
9779	Ferriolense	\N	Spain	https://media.api-sports.io/football/teams/9779.png
9780	Formentera	\N	Spain	https://media.api-sports.io/football/teams/9780.png
9781	Ibiza Islas Pitiusas	\N	Spain	https://media.api-sports.io/football/teams/9781.png
9782	Llosetense	\N	Spain	https://media.api-sports.io/football/teams/9782.png
9783	Mallorca II	\N	Spain	https://media.api-sports.io/football/teams/9783.png
9784	Manacor	\N	Spain	https://media.api-sports.io/football/teams/9784.png
9785	Platges Calvià	\N	Spain	https://media.api-sports.io/football/teams/9785.png
9786	Portmany	\N	Spain	https://media.api-sports.io/football/teams/9786.png
9787	San Rafael	\N	Spain	https://media.api-sports.io/football/teams/9787.png
9788	Santa Catalina Atlético	\N	Spain	https://media.api-sports.io/football/teams/9788.png
9789	Santanyí	\N	Spain	https://media.api-sports.io/football/teams/9789.png
9790	Sóller	\N	Spain	https://media.api-sports.io/football/teams/9790.png
9791	Atlético Paso	\N	Spain	https://media.api-sports.io/football/teams/9791.png
9792	Atlético Tacoronte	\N	Spain	https://media.api-sports.io/football/teams/9792.png
9793	Buzanada	\N	Spain	https://media.api-sports.io/football/teams/9793.png
9794	Güímar	\N	Spain	https://media.api-sports.io/football/teams/9794.png
9795	Ibarra	\N	Spain	https://media.api-sports.io/football/teams/9795.png
9796	La Cuadra	\N	Spain	https://media.api-sports.io/football/teams/9796.png
9797	Lanzarote	\N	Spain	https://media.api-sports.io/football/teams/9797.png
9798	Las Palmas III	\N	Spain	https://media.api-sports.io/football/teams/9798.png
9799	Marino	\N	Spain	https://media.api-sports.io/football/teams/9799.png
9800	Panadería Pulido	\N	Spain	https://media.api-sports.io/football/teams/9800.png
9801	Santa Úrsula	\N	Spain	https://media.api-sports.io/football/teams/9801.png
9802	Tenerife II	\N	Spain	https://media.api-sports.io/football/teams/9802.png
9803	Tenisca	\N	Spain	https://media.api-sports.io/football/teams/9803.png
9804	UD San Fernando	\N	Spain	https://media.api-sports.io/football/teams/9804.png
9805	Unión Viera	\N	Spain	https://media.api-sports.io/football/teams/9805.png
9806	Vera	\N	Spain	https://media.api-sports.io/football/teams/9806.png
9807	Villa Santa Brígida	\N	Spain	https://media.api-sports.io/football/teams/9807.png
9808	Atlético Pulpileño	\N	Spain	https://media.api-sports.io/football/teams/9808.png
9809	CAP Ciudad de Murcia	\N	Spain	https://media.api-sports.io/football/teams/9809.png
9810	Cartagena FC	\N	Spain	https://media.api-sports.io/football/teams/9810.png
9811	Deportiva Minera	\N	Spain	https://media.api-sports.io/football/teams/9811.png
9812	EDMF Churra	\N	Spain	https://media.api-sports.io/football/teams/9812.png
9813	Huércal Overa	\N	Spain	https://media.api-sports.io/football/teams/9813.png
9814	Los Garres	\N	Spain	https://media.api-sports.io/football/teams/9814.png
9815	Mar Menor	\N	Spain	https://media.api-sports.io/football/teams/9815.png
9816	Mazarrón FC	\N	Spain	https://media.api-sports.io/football/teams/9816.png
9817	Muleño	\N	Spain	https://media.api-sports.io/football/teams/9817.png
9818	Olímpico Totana	\N	Spain	https://media.api-sports.io/football/teams/9818.png
9819	Plus Ultra	\N	Spain	https://media.api-sports.io/football/teams/9819.png
9820	Real Murcia II	\N	Spain	https://media.api-sports.io/football/teams/9820.png
9821	SFC Minerva	\N	Spain	https://media.api-sports.io/football/teams/9821.png
9822	UCAM Murcia II	\N	Spain	https://media.api-sports.io/football/teams/9822.png
9823	Águilas	\N	Spain	https://media.api-sports.io/football/teams/9823.png
9824	Aceuchal	\N	Spain	https://media.api-sports.io/football/teams/9824.png
9825	Arroyo	ARR	Spain	https://media.api-sports.io/football/teams/9825.png
9826	Azuaga	\N	Spain	https://media.api-sports.io/football/teams/9826.png
9827	CD Coria	\N	Spain	https://media.api-sports.io/football/teams/9827.png
9828	Calamonte	\N	Spain	https://media.api-sports.io/football/teams/9828.png
9829	Diocesano	\N	Spain	https://media.api-sports.io/football/teams/9829.png
9830	Extremadura UD II	\N	Spain	https://media.api-sports.io/football/teams/9830.png
9831	Fuente Cantos	\N	Spain	https://media.api-sports.io/football/teams/9831.png
9832	Jerez	\N	Spain	https://media.api-sports.io/football/teams/9832.png
9833	Llerenense	\N	Spain	https://media.api-sports.io/football/teams/9833.png
9834	Miajadas	\N	Spain	https://media.api-sports.io/football/teams/9834.png
9835	Montijo	\N	Spain	https://media.api-sports.io/football/teams/9835.png
9836	Moralo	\N	Spain	https://media.api-sports.io/football/teams/9836.png
9837	Olivenza	\N	Spain	https://media.api-sports.io/football/teams/9837.png
9838	Plasencia	\N	Spain	https://media.api-sports.io/football/teams/9838.png
9839	RCP Valverdeño	\N	Spain	https://media.api-sports.io/football/teams/9839.png
9840	Trujillo	\N	Spain	https://media.api-sports.io/football/teams/9840.png
9841	Valdivia	\N	Spain	https://media.api-sports.io/football/teams/9841.png
9842	Ardoi	\N	Spain	https://media.api-sports.io/football/teams/9842.png
9843	Baztán	\N	Spain	https://media.api-sports.io/football/teams/9843.png
9844	Beti Kozkor	\N	Spain	https://media.api-sports.io/football/teams/9844.png
9845	Beti Onak	\N	Spain	https://media.api-sports.io/football/teams/9845.png
9846	Burladés	\N	Spain	https://media.api-sports.io/football/teams/9846.png
9847	Cirbonero	\N	Spain	https://media.api-sports.io/football/teams/9847.png
9848	Corellano	\N	Spain	https://media.api-sports.io/football/teams/9848.png
9849	Cortes	\N	Spain	https://media.api-sports.io/football/teams/9849.png
9850	Fontellas	\N	Spain	https://media.api-sports.io/football/teams/9850.png
9851	Huarte	\N	Spain	https://media.api-sports.io/football/teams/9851.png
9852	Lourdes	\N	Spain	https://media.api-sports.io/football/teams/9852.png
9853	Murchante	\N	Spain	https://media.api-sports.io/football/teams/9853.png
9854	Pamplona	\N	Spain	https://media.api-sports.io/football/teams/9854.png
9855	San Juan	\N	Spain	https://media.api-sports.io/football/teams/9855.png
9856	Subiza	\N	Spain	https://media.api-sports.io/football/teams/9856.png
9857	Txantrea	\N	Spain	https://media.api-sports.io/football/teams/9857.png
9858	Valle Egüés	\N	Spain	https://media.api-sports.io/football/teams/9858.png
9859	Alberite	\N	Spain	https://media.api-sports.io/football/teams/9859.png
9860	Alfaro	\N	Spain	https://media.api-sports.io/football/teams/9860.png
9861	Anguiano	\N	Spain	https://media.api-sports.io/football/teams/9861.png
9862	Arnedo	\N	Spain	https://media.api-sports.io/football/teams/9862.png
9863	Berceo	\N	Spain	https://media.api-sports.io/football/teams/9863.png
9864	Calahorra II	\N	Spain	https://media.api-sports.io/football/teams/9864.png
9865	Calasancio	\N	Spain	https://media.api-sports.io/football/teams/9865.png
9866	Casalarreina	\N	Spain	https://media.api-sports.io/football/teams/9866.png
9867	La Calzada	\N	Spain	https://media.api-sports.io/football/teams/9867.png
9868	Náxara	\N	Spain	https://media.api-sports.io/football/teams/9868.png
9869	Oyonesa	\N	Spain	https://media.api-sports.io/football/teams/9869.png
9870	Pradejón	\N	Spain	https://media.api-sports.io/football/teams/9870.png
9871	River Ebro	\N	Spain	https://media.api-sports.io/football/teams/9871.png
9872	UD Logroñés II	\N	Spain	https://media.api-sports.io/football/teams/9872.png
9873	Varea	\N	Spain	https://media.api-sports.io/football/teams/9873.png
9874	Vianés	\N	Spain	https://media.api-sports.io/football/teams/9874.png
9875	Villegas	\N	Spain	https://media.api-sports.io/football/teams/9875.png
9876	Yagüe	\N	Spain	https://media.api-sports.io/football/teams/9876.png
9877	Almudévar	\N	Spain	https://media.api-sports.io/football/teams/9877.png
9878	Atlético Monzón	\N	Spain	https://media.api-sports.io/football/teams/9878.png
9879	Barbastro	\N	Spain	https://media.api-sports.io/football/teams/9879.png
9880	Belchite 97	\N	Spain	https://media.api-sports.io/football/teams/9880.png
9881	Binéfar	\N	Spain	https://media.api-sports.io/football/teams/9881.png
9882	Borja	\N	Spain	https://media.api-sports.io/football/teams/9882.png
9883	Brea	\N	Spain	https://media.api-sports.io/football/teams/9883.png
9884	CDJ Tamarite	\N	Spain	https://media.api-sports.io/football/teams/9884.png
9885	Calamocha	\N	Spain	https://media.api-sports.io/football/teams/9885.png
9886	Cuarte	\N	Spain	https://media.api-sports.io/football/teams/9886.png
9887	Real Zaragoza II	ZAR	Spain	https://media.api-sports.io/football/teams/9887.png
9888	Robres	\N	Spain	https://media.api-sports.io/football/teams/9888.png
9889	San Juan Mozarrifar	\N	Spain	https://media.api-sports.io/football/teams/9889.png
9890	Sariñena	SAR	Spain	https://media.api-sports.io/football/teams/9890.png
9891	Utebo	\N	Spain	https://media.api-sports.io/football/teams/9891.png
9892	Valdefierro	\N	Spain	https://media.api-sports.io/football/teams/9892.png
9893	Villanueva CF	\N	Spain	https://media.api-sports.io/football/teams/9893.png
9894	Almagro	\N	Spain	https://media.api-sports.io/football/teams/9894.png
9895	Albacete II	\N	Spain	https://media.api-sports.io/football/teams/9895.png
9896	Almansa	\N	Spain	https://media.api-sports.io/football/teams/9896.png
9897	Atlético Ibañés	\N	Spain	https://media.api-sports.io/football/teams/9897.png
9898	Azuqueca	\N	Spain	https://media.api-sports.io/football/teams/9898.png
9899	Calvo Sotelo	\N	Spain	https://media.api-sports.io/football/teams/9899.png
9900	Guadalajara	\N	Spain	https://media.api-sports.io/football/teams/9900.png
9901	Illescas	\N	Spain	https://media.api-sports.io/football/teams/9901.png
9902	La Roda	ROD	Spain	https://media.api-sports.io/football/teams/9902.png
9903	La Solana	\N	Spain	https://media.api-sports.io/football/teams/9903.png
9904	Madridejos	\N	Spain	https://media.api-sports.io/football/teams/9904.png
9905	Manchego	\N	Spain	https://media.api-sports.io/football/teams/9905.png
9906	Quintanar del Rey	\N	Spain	https://media.api-sports.io/football/teams/9906.png
9907	Tarancón	\N	Spain	https://media.api-sports.io/football/teams/9907.png
9908	Toledo	TOL	Spain	https://media.api-sports.io/football/teams/9908.png
9909	Torrijos	\N	Spain	https://media.api-sports.io/football/teams/9909.png
9910	Villacañas	\N	Spain	https://media.api-sports.io/football/teams/9910.png
9990	Cartagena II	\N	Spain	https://media.api-sports.io/football/teams/9990.png
10139	AD Ceuta FC	\N	Spain	https://media.api-sports.io/football/teams/10139.png
10140	Mérida AD	\N	Spain	https://media.api-sports.io/football/teams/10140.png
10143	Internacional	\N	Spain	https://media.api-sports.io/football/teams/10143.png
10182	Spain U23	\N	Spain	https://media.api-sports.io/football/teams/10182.png
10349	Spain U19	SPA	Spain	https://media.api-sports.io/football/teams/10349.png
12520	Spain U17	\N	Spain	https://media.api-sports.io/football/teams/12520.png
15223	Santa Teresa	\N	Spain	https://media.api-sports.io/football/teams/15223.png
15224	Real Madrid W	\N	Spain	https://media.api-sports.io/football/teams/15224.png
15225	Eibar W	\N	Spain	https://media.api-sports.io/football/teams/15225.png
15303	Agrupación Estudiantil	\N	Spain	https://media.api-sports.io/football/teams/15303.png
15304	Atios	\N	Spain	https://media.api-sports.io/football/teams/15304.png
15305	Fisterra	\N	Spain	https://media.api-sports.io/football/teams/15305.png
15306	Ribadumia	\N	Spain	https://media.api-sports.io/football/teams/15306.png
15307	Viveiro	\N	Spain	https://media.api-sports.io/football/teams/15307.png
15308	Cabecense	\N	Spain	https://media.api-sports.io/football/teams/15308.png
15309	Castilleja	\N	Spain	https://media.api-sports.io/football/teams/15309.png
15310	La Palma	\N	Spain	https://media.api-sports.io/football/teams/15310.png
15311	Cardassar	\N	Spain	https://media.api-sports.io/football/teams/15311.png
15312	Génova	\N	Spain	https://media.api-sports.io/football/teams/15312.png
15313	PE Sant Jordi	\N	Spain	https://media.api-sports.io/football/teams/15313.png
15314	Bullense	\N	Spain	https://media.api-sports.io/football/teams/15314.png
15315	La Unión Atlético	\N	Spain	https://media.api-sports.io/football/teams/15315.png
15316	Lorca	LAH	Spain	https://media.api-sports.io/football/teams/15316.png
15317	Racing Murcia	\N	Spain	https://media.api-sports.io/football/teams/15317.png
15318	Campanario	\N	Spain	https://media.api-sports.io/football/teams/15318.png
15319	Chinato	\N	Spain	https://media.api-sports.io/football/teams/15319.png
15320	Bidezarra	\N	Spain	https://media.api-sports.io/football/teams/15320.png
15321	Cantolagua	\N	Spain	https://media.api-sports.io/football/teams/15321.png
15322	River Ega	\N	Spain	https://media.api-sports.io/football/teams/15322.png
15323	Agoncillo	\N	Spain	https://media.api-sports.io/football/teams/15323.png
15324	Racing Rioja	\N	Spain	https://media.api-sports.io/football/teams/15324.png
15325	Tedeón	\N	Spain	https://media.api-sports.io/football/teams/15325.png
15326	Cariñena	\N	Spain	https://media.api-sports.io/football/teams/15326.png
15327	Huesca II	\N	Spain	https://media.api-sports.io/football/teams/15327.png
15328	Sabiñánigo	\N	Spain	https://media.api-sports.io/football/teams/15328.png
15329	Épila	\N	Spain	https://media.api-sports.io/football/teams/15329.png
15330	Huracán Balazote	\N	Spain	https://media.api-sports.io/football/teams/15330.png
15331	Manzanares	\N	Spain	https://media.api-sports.io/football/teams/15331.png
15332	Marchamalo	\N	Spain	https://media.api-sports.io/football/teams/15332.png
15333	Avilés Stadium	\N	Spain	https://media.api-sports.io/football/teams/15333.png
15334	Real Titánico	\N	Spain	https://media.api-sports.io/football/teams/15334.png
15335	Valdesoto	\N	Spain	https://media.api-sports.io/football/teams/15335.png
15336	Castro	\N	Spain	https://media.api-sports.io/football/teams/15336.png
15337	Revilla	\N	Spain	https://media.api-sports.io/football/teams/15337.png
15338	Rinconeda Polanco	\N	Spain	https://media.api-sports.io/football/teams/15338.png
15339	Cayón	\N	Spain	https://media.api-sports.io/football/teams/15339.png
15340	Anaitasuna	\N	Spain	https://media.api-sports.io/football/teams/15340.png
15341	Aurrerá Ondarroa	\N	Spain	https://media.api-sports.io/football/teams/15341.png
15342	Urgatzi	\N	Spain	https://media.api-sports.io/football/teams/15342.png
15343	Girona II	\N	Spain	https://media.api-sports.io/football/teams/15343.png
15344	Grama	\N	Spain	https://media.api-sports.io/football/teams/15344.png
15345	Montañesa	\N	Spain	https://media.api-sports.io/football/teams/15345.png
15346	Valls	\N	Spain	https://media.api-sports.io/football/teams/15346.png
15347	Benicarló	\N	Spain	https://media.api-sports.io/football/teams/15347.png
15348	Torrent	\N	Spain	https://media.api-sports.io/football/teams/15348.png
15349	Villajoyosa	\N	Spain	https://media.api-sports.io/football/teams/15349.png
15350	Complutense	\N	Spain	https://media.api-sports.io/football/teams/15350.png
15351	Móstoles CF	\N	Spain	https://media.api-sports.io/football/teams/15351.png
15352	Real Aranjuez	\N	Spain	https://media.api-sports.io/football/teams/15352.png
15353	Villanueva Pardillo	\N	Spain	https://media.api-sports.io/football/teams/15353.png
15354	Colegios Diocesanos	\N	Spain	https://media.api-sports.io/football/teams/15354.png
15355	Cultural Cebrereña	\N	Spain	https://media.api-sports.io/football/teams/15355.png
15356	Peñaranda	\N	Spain	https://media.api-sports.io/football/teams/15356.png
15357	Alhaurino	\N	Spain	https://media.api-sports.io/football/teams/15357.png
15358	Estepona	\N	Spain	https://media.api-sports.io/football/teams/15358.png
15359	Juventud Torremolinos	\N	Spain	https://media.api-sports.io/football/teams/15359.png
15472	Arucas	\N	Spain	https://media.api-sports.io/football/teams/15472.png
15473	Atlético Victoria	\N	Spain	https://media.api-sports.io/football/teams/15473.png
15474	Guía	\N	Spain	https://media.api-sports.io/football/teams/15474.png
15523	AUGC Deportiva	\N	Spain	https://media.api-sports.io/football/teams/15523.png
15524	Buñol	\N	Spain	https://media.api-sports.io/football/teams/15524.png
15525	CF Rusadir	\N	Spain	https://media.api-sports.io/football/teams/15525.png
15526	Miengo	\N	Spain	https://media.api-sports.io/football/teams/15526.png
15527	Rincón	\N	Spain	https://media.api-sports.io/football/teams/15527.png
15528	Tomares	\N	Spain	https://media.api-sports.io/football/teams/15528.png
17007	Barbate	\N	Spain	https://media.api-sports.io/football/teams/17007.png
17168	Deportivo Alavés	\N	Spain	https://media.api-sports.io/football/teams/17168.png
17169	Villarreal W	\N	Spain	https://media.api-sports.io/football/teams/17169.png
17315	Amurrio Club	\N	Spain	https://media.api-sports.io/football/teams/17315.png
17316	Berron	\N	Spain	https://media.api-sports.io/football/teams/17316.png
17498	Andorra CF	\N	Spain	https://media.api-sports.io/football/teams/17498.png
17499	Atarfe Industrial	\N	Spain	https://media.api-sports.io/football/teams/17499.png
17500	Atl. Benamiel	\N	Spain	https://media.api-sports.io/football/teams/17500.png
17501	Atlético Arnoia	\N	Spain	https://media.api-sports.io/football/teams/17501.png
17502	Atlético Mansillés	\N	Spain	https://media.api-sports.io/football/teams/17502.png
17510	Don Álvaro	\N	Spain	https://media.api-sports.io/football/teams/17510.png
17516	Galapagar	\N	Spain	https://media.api-sports.io/football/teams/17516.png
17522	Guineueta	\N	Spain	https://media.api-sports.io/football/teams/17522.png
17528	L'Escala	\N	Spain	https://media.api-sports.io/football/teams/17528.png
17529	La Union	\N	Spain	https://media.api-sports.io/football/teams/17529.png
17531	Miguelturreño	\N	Spain	https://media.api-sports.io/football/teams/17531.png
17532	Murense	\N	Spain	https://media.api-sports.io/football/teams/17532.png
17534	Noia	\N	Spain	https://media.api-sports.io/football/teams/17534.png
17535	Noja	NOJ	Spain	https://media.api-sports.io/football/teams/17535.png
17538	Palencia CF	\N	Spain	https://media.api-sports.io/football/teams/17538.png
17558	Torre del Mar	\N	Spain	https://media.api-sports.io/football/teams/17558.png
17559	Torrellano	\N	Spain	https://media.api-sports.io/football/teams/17559.png
17560	Tres Cantos	\N	Spain	https://media.api-sports.io/football/teams/17560.png
17562	UD San Pedro	\N	Spain	https://media.api-sports.io/football/teams/17562.png
17567	Villaviciosa Odón	\N	Spain	https://media.api-sports.io/football/teams/17567.png
17577	Juvenil Ponteareas	\N	Spain	https://media.api-sports.io/football/teams/17577.png
17578	Sofán	\N	Spain	https://media.api-sports.io/football/teams/17578.png
17579	Langreo II	\N	Spain	https://media.api-sports.io/football/teams/17579.png
17580	Luarca	\N	Spain	https://media.api-sports.io/football/teams/17580.png
17581	Roces	\N	Spain	https://media.api-sports.io/football/teams/17581.png
17582	Colindres	\N	Spain	https://media.api-sports.io/football/teams/17582.png
17584	Beti Gazte	\N	Spain	https://media.api-sports.io/football/teams/17584.png
17585	Uritarra	\N	Spain	https://media.api-sports.io/football/teams/17585.png
17586	Ascó	\N	Spain	https://media.api-sports.io/football/teams/17586.png
17587	Callosa Deportiva	\N	Spain	https://media.api-sports.io/football/teams/17587.png
17588	Castellón II	\N	Spain	https://media.api-sports.io/football/teams/17588.png
17589	Colonia Moscardó	\N	Spain	https://media.api-sports.io/football/teams/17589.png
17590	Madrid 2021 FP	\N	Spain	https://media.api-sports.io/football/teams/17590.png
17591	Ursaria	\N	Spain	https://media.api-sports.io/football/teams/17591.png
17592	Ciudad Rodrigo	\N	Spain	https://media.api-sports.io/football/teams/17592.png
17593	Ribert	\N	Spain	https://media.api-sports.io/football/teams/17593.png
17594	Intergym	\N	Spain	https://media.api-sports.io/football/teams/17594.png
17595	Cartaya	\N	Spain	https://media.api-sports.io/football/teams/17595.png
17596	Ceuta II	\N	Spain	https://media.api-sports.io/football/teams/17596.png
17597	Campos	\N	Spain	https://media.api-sports.io/football/teams/17597.png
17598	Inter Ibiza	\N	Spain	https://media.api-sports.io/football/teams/17598.png
17599	Mercadal	\N	Spain	https://media.api-sports.io/football/teams/17599.png
17600	Rotlet Molinar	\N	Spain	https://media.api-sports.io/football/teams/17600.png
17601	Serverense	\N	Spain	https://media.api-sports.io/football/teams/17601.png
17602	Son Veri	\N	Spain	https://media.api-sports.io/football/teams/17602.png
17603	Herbania	\N	Spain	https://media.api-sports.io/football/teams/17603.png
17604	Las Zocas	\N	Spain	https://media.api-sports.io/football/teams/17604.png
17605	Unión Sur Yaiza	\N	Spain	https://media.api-sports.io/football/teams/17605.png
17606	Archena Sport	\N	Spain	https://media.api-sports.io/football/teams/17606.png
17607	Bala Azul	\N	Spain	https://media.api-sports.io/football/teams/17607.png
17608	UD Caravaca	\N	Spain	https://media.api-sports.io/football/teams/17608.png
17609	Avance Ezcabarte	\N	Spain	https://media.api-sports.io/football/teams/17609.png
17610	Azkoyen	\N	Spain	https://media.api-sports.io/football/teams/17610.png
17611	Gares	\N	Spain	https://media.api-sports.io/football/teams/17611.png
17612	Cenicero	\N	Spain	https://media.api-sports.io/football/teams/17612.png
17613	Rapid de Murillo	\N	Spain	https://media.api-sports.io/football/teams/17613.png
17614	Biescas	\N	Spain	https://media.api-sports.io/football/teams/17614.png
17615	Caspe	\N	Spain	https://media.api-sports.io/football/teams/17615.png
17616	Giner Torrero	\N	Spain	https://media.api-sports.io/football/teams/17616.png
17617	Santa Anastasia	\N	Spain	https://media.api-sports.io/football/teams/17617.png
17618	Hogar Alcarreño	\N	Spain	https://media.api-sports.io/football/teams/17618.png
17619	San Clemente	\N	Spain	https://media.api-sports.io/football/teams/17619.png
17621	Badajoz II	\N	Spain	https://media.api-sports.io/football/teams/17621.png
17702	Villarreal U19	\N	Spain	https://media.api-sports.io/football/teams/17702.png
17715	Cartagena LU II	\N	Spain	https://media.api-sports.io/football/teams/17715.png
18003	Betis de Hadú	\N	Spain	https://media.api-sports.io/football/teams/18003.png
18087	Aldeano	\N	Spain	https://media.api-sports.io/football/teams/18087.png
18088	Atlético Espeleño	\N	Spain	https://media.api-sports.io/football/teams/18088.png
18090	Ceuta 6 de Junio	\N	Spain	https://media.api-sports.io/football/teams/18090.png
18091	Hernani	\N	Spain	https://media.api-sports.io/football/teams/18091.png
18092	Huracán Melilla	\N	Spain	https://media.api-sports.io/football/teams/18092.png
18093	Injerto	\N	Spain	https://media.api-sports.io/football/teams/18093.png
18094	Jaraíz	\N	Spain	https://media.api-sports.io/football/teams/18094.png
18095	Laguna	\N	Spain	https://media.api-sports.io/football/teams/18095.png
18096	Mollerussa	\N	Spain	https://media.api-sports.io/football/teams/18096.png
18097	Nalón	\N	Spain	https://media.api-sports.io/football/teams/18097.png
18098	Penya Independent	\N	Spain	https://media.api-sports.io/football/teams/18098.png
18099	San Agustín	\N	Spain	https://media.api-sports.io/football/teams/18099.png
18100	Unami	\N	Spain	https://media.api-sports.io/football/teams/18100.png
18101	Utrillas	\N	Spain	https://media.api-sports.io/football/teams/18101.png
18102	Victoria CF	\N	Spain	https://media.api-sports.io/football/teams/18102.png
18103	Villa de Fortuna	\N	Spain	https://media.api-sports.io/football/teams/18103.png
18167	Jerez Industrial	\N	Spain	https://media.api-sports.io/football/teams/18167.png
18169	Racing Guía Norte Astur	\N	Spain	https://media.api-sports.io/football/teams/18169.png
18171	Santboià	\N	Spain	https://media.api-sports.io/football/teams/18171.png
19066	Spain U19 W	\N	Spain	https://media.api-sports.io/football/teams/19066.png
19074	Spain U18	\N	Spain	https://media.api-sports.io/football/teams/19074.png
19078	Spain U20 W	\N	Spain	https://media.api-sports.io/football/teams/19078.png
19649	Atletico Arteixo	\N	Spain	https://media.api-sports.io/football/teams/19649.png
19650	Atlético Arteixo	\N	Spain	https://media.api-sports.io/football/teams/19650.png
19697	Muro	\N	Spain	https://media.api-sports.io/football/teams/19697.png
19710	San Serván	\N	Spain	https://media.api-sports.io/football/teams/19710.png
19895	Alhama	\N	Spain	https://media.api-sports.io/football/teams/19895.png
19896	FC Levante Badalona	\N	Spain	https://media.api-sports.io/football/teams/19896.png
19924	Levante U20	\N	Spain	https://media.api-sports.io/football/teams/19924.png
19926	Valencia U20	\N	Spain	https://media.api-sports.io/football/teams/19926.png
19927	Villarreal U20	\N	Spain	https://media.api-sports.io/football/teams/19927.png
20255	Celta de Vigo III	\N	Spain	https://media.api-sports.io/football/teams/20255.png
20256	Ayamonte	\N	Spain	https://media.api-sports.io/football/teams/20256.png
20257	Bollullos	\N	Spain	https://media.api-sports.io/football/teams/20257.png
20258	Gama	\N	Spain	https://media.api-sports.io/football/teams/20258.png
20259	Aurrerá Vitoria	\N	Spain	https://media.api-sports.io/football/teams/20259.png
20260	Padura	\N	Spain	https://media.api-sports.io/football/teams/20260.png
20261	Touring	\N	Spain	https://media.api-sports.io/football/teams/20261.png
20262	Badalona II	\N	Spain	https://media.api-sports.io/football/teams/20262.png
20263	Rapitenca	\N	Spain	https://media.api-sports.io/football/teams/20263.png
20264	Tona	\N	Spain	https://media.api-sports.io/football/teams/20264.png
20265	CF Gandía	\N	Spain	https://media.api-sports.io/football/teams/20265.png
20266	Patacona	\N	Spain	https://media.api-sports.io/football/teams/20266.png
20267	Rayo Ibense	\N	Spain	https://media.api-sports.io/football/teams/20267.png
20268	Canillas	\N	Spain	https://media.api-sports.io/football/teams/20268.png
20269	Collado Villalba	\N	Spain	https://media.api-sports.io/football/teams/20269.png
20270	RSC Internacional	\N	Spain	https://media.api-sports.io/football/teams/20270.png
20271	Ponferradina II	\N	Spain	https://media.api-sports.io/football/teams/20271.png
20272	Arenas Armilla	\N	Spain	https://media.api-sports.io/football/teams/20272.png
20273	CE Sant Jordi	\N	Spain	https://media.api-sports.io/football/teams/20273.png
20274	Inter Manacor	\N	Spain	https://media.api-sports.io/football/teams/20274.png
20275	Estrella	\N	Spain	https://media.api-sports.io/football/teams/20275.png
20276	Alcantarilla	\N	Spain	https://media.api-sports.io/football/teams/20276.png
20277	Cieza	\N	Spain	https://media.api-sports.io/football/teams/20277.png
20278	Unión Molinense	\N	Spain	https://media.api-sports.io/football/teams/20278.png
20279	Atlético Pueblonuevo	\N	Spain	https://media.api-sports.io/football/teams/20279.png
20280	La Estrella	\N	Spain	https://media.api-sports.io/football/teams/20280.png
20281	Montehermoso	\N	Spain	https://media.api-sports.io/football/teams/20281.png
20282	Alesves	\N	Spain	https://media.api-sports.io/football/teams/20282.png
20283	Lagunak	\N	Spain	https://media.api-sports.io/football/teams/20283.png
20284	Oberena	\N	Spain	https://media.api-sports.io/football/teams/20284.png
20285	Peña Balsamaiso	\N	Spain	https://media.api-sports.io/football/teams/20285.png
20286	Racing Rioja II	\N	Spain	https://media.api-sports.io/football/teams/20286.png
20287	La Almunia	\N	Spain	https://media.api-sports.io/football/teams/20287.png
20288	Atlético Tomelloso	\N	Spain	https://media.api-sports.io/football/teams/20288.png
20289	Talavera II	\N	Spain	https://media.api-sports.io/football/teams/20289.png
20375	Real Unión de Tenerife	\N	Spain	https://media.api-sports.io/football/teams/20375.png
20437	Alcora	\N	Spain	https://media.api-sports.io/football/teams/20437.png
20438	Algar	\N	Spain	https://media.api-sports.io/football/teams/20438.png
20439	Amigó	\N	Spain	https://media.api-sports.io/football/teams/20439.png
20440	Atlético Lugones	\N	Spain	https://media.api-sports.io/football/teams/20440.png
20441	Autol	\N	Spain	https://media.api-sports.io/football/teams/20441.png
20442	Barbadás	\N	Spain	https://media.api-sports.io/football/teams/20442.png
20443	Cazalegas	\N	Spain	https://media.api-sports.io/football/teams/20443.png
20444	Dinamo San Juan	\N	Spain	https://media.api-sports.io/football/teams/20444.png
20445	Fuentes	\N	Spain	https://media.api-sports.io/football/teams/20445.png
20446	Los Yébenes SB	\N	Spain	https://media.api-sports.io/football/teams/20446.png
20447	Montilla	\N	Spain	https://media.api-sports.io/football/teams/20447.png
20448	Santa Amalia	\N	Spain	https://media.api-sports.io/football/teams/20448.png
20449	Turégano	\N	Spain	https://media.api-sports.io/football/teams/20449.png
20450	Universitario FC	\N	Spain	https://media.api-sports.io/football/teams/20450.png
20451	Velarde	\N	Spain	https://media.api-sports.io/football/teams/20451.png
21510	CP Ejido	\N	Spain	https://media.api-sports.io/football/teams/21510.png
21905	Chiclana	\N	Spain	https://media.api-sports.io/football/teams/21905.png
22018	Granada	\N	Spain	https://media.api-sports.io/football/teams/22018.png
22110	Montecasillas	\N	Spain	https://media.api-sports.io/football/teams/22110.png
22116	Racing Cartagena MM	\N	Spain	https://media.api-sports.io/football/teams/22116.png
22122	Teror	\N	Spain	https://media.api-sports.io/football/teams/22122.png
22128	Betanzos	\N	Spain	https://media.api-sports.io/football/teams/22128.png
22129	Pontevedra II	\N	Spain	https://media.api-sports.io/football/teams/22129.png
22130	Sarriana	\N	Spain	https://media.api-sports.io/football/teams/22130.png
22131	Barcia	\N	Spain	https://media.api-sports.io/football/teams/22131.png
22132	Atlético Mineros	\N	Spain	https://media.api-sports.io/football/teams/22132.png
22133	Añorga	\N	Spain	https://media.api-sports.io/football/teams/22133.png
22134	Deportivo Alavés III	\N	Spain	https://media.api-sports.io/football/teams/22134.png
22135	Derio	\N	Spain	https://media.api-sports.io/football/teams/22135.png
22136	Reddis	\N	Spain	https://media.api-sports.io/football/teams/22136.png
22137	Burriana	\N	Spain	https://media.api-sports.io/football/teams/22137.png
22138	Castellonense	\N	Spain	https://media.api-sports.io/football/teams/22138.png
22139	Ontinyent 1931	\N	Spain	https://media.api-sports.io/football/teams/22139.png
22140	Soneja	\N	Spain	https://media.api-sports.io/football/teams/22140.png
22141	Utiel	\N	Spain	https://media.api-sports.io/football/teams/22141.png
22142	Real Madrid III	\N	Spain	https://media.api-sports.io/football/teams/22142.png
22143	Laguna de Duero	\N	Spain	https://media.api-sports.io/football/teams/22143.png
22144	Villaralbo	\N	Spain	https://media.api-sports.io/football/teams/22144.png
22145	Atlético Melilla	\N	Spain	https://media.api-sports.io/football/teams/22145.png
22146	Alaior	\N	Spain	https://media.api-sports.io/football/teams/22146.png
22147	Arenal	\N	Spain	https://media.api-sports.io/football/teams/22147.png
22148	San Bartolomé	\N	Spain	https://media.api-sports.io/football/teams/22148.png
22149	Castuera	\N	Spain	https://media.api-sports.io/football/teams/22149.png
22150	Lerinés	\N	Spain	https://media.api-sports.io/football/teams/22150.png
22180	Balsicas Atlético	\N	Spain	https://media.api-sports.io/football/teams/22180.png
22414	Athletic Club U21	\N	Spain	https://media.api-sports.io/football/teams/22414.png
22422	Valencia U21	\N	Spain	https://media.api-sports.io/football/teams/22422.png
22494	Polillas Atlético	\N	Spain	https://media.api-sports.io/football/teams/22494.png
22500	Spain U16	\N	Spain	https://media.api-sports.io/football/teams/22500.png
22566	Boiro	\N	Spain	https://media.api-sports.io/football/teams/22566.png
22567	Deportivo Murcia	\N	Spain	https://media.api-sports.io/football/teams/22567.png
22568	Hernán Cortés	\N	Spain	https://media.api-sports.io/football/teams/22568.png
22569	Mijas Las Lagunas	\N	Spain	https://media.api-sports.io/football/teams/22569.png
22570	Monte	\N	Spain	https://media.api-sports.io/football/teams/22570.png
22571	Quintanar	\N	Spain	https://media.api-sports.io/football/teams/22571.png
22572	Rubí	\N	Spain	https://media.api-sports.io/football/teams/22572.png
22573	Sauzal	\N	Spain	https://media.api-sports.io/football/teams/22573.png
22574	Tardienta	\N	Spain	https://media.api-sports.io/football/teams/22574.png
22575	Unión Zona Norte	\N	Spain	https://media.api-sports.io/football/teams/22575.png
22576	Zirauki	\N	Spain	https://media.api-sports.io/football/teams/22576.png
22905	Palamós	\N	Spain	https://media.api-sports.io/football/teams/22905.png
24076	Sevilla U20	\N	Spain	https://media.api-sports.io/football/teams/24076.png
24571	Aretxabaleta	\N	Spain	https://media.api-sports.io/football/teams/24571.png
24572	Eibar II	\N	Spain	https://media.api-sports.io/football/teams/24572.png
24573	San Viator	\N	Spain	https://media.api-sports.io/football/teams/24573.png
24574	Atlètic Lleida	\N	Spain	https://media.api-sports.io/football/teams/24574.png
24575	Europa II	\N	Spain	https://media.api-sports.io/football/teams/24575.png
24576	Sabadell II	\N	Spain	https://media.api-sports.io/football/teams/24576.png
24577	Briviesca	\N	Spain	https://media.api-sports.io/football/teams/24577.png
24578	Mojados	\N	Spain	https://media.api-sports.io/football/teams/24578.png
24579	Migjorn	\N	Spain	https://media.api-sports.io/football/teams/24579.png
24580	Porreres	\N	Spain	https://media.api-sports.io/football/teams/24580.png
24581	Zuera	\N	Spain	https://media.api-sports.io/football/teams/24581.png
24609	Valladares	\N	Spain	https://media.api-sports.io/football/teams/24609.png
24610	Villalonga	\N	Spain	https://media.api-sports.io/football/teams/24610.png
24611	Los Llanos	\N	Spain	https://media.api-sports.io/football/teams/24611.png
24613	Puebla Calzada	\N	Spain	https://media.api-sports.io/football/teams/24613.png
24614	Atlético Artajonés	\N	Spain	https://media.api-sports.io/football/teams/24614.png
24615	Rotxapea	\N	Spain	https://media.api-sports.io/football/teams/24615.png
24653	Noblejas	\N	Spain	https://media.api-sports.io/football/teams/24653.png
24654	Valdepeñas	\N	Spain	https://media.api-sports.io/football/teams/24654.png
24655	Santomera	\N	Spain	https://media.api-sports.io/football/teams/24655.png
24656	Águilas II	\N	Spain	https://media.api-sports.io/football/teams/24656.png
24708	Aravaca	\N	Spain	https://media.api-sports.io/football/teams/24708.png
24709	Cala Pozuelo	\N	Spain	https://media.api-sports.io/football/teams/24709.png
24723	Atlético Central	\N	Spain	https://media.api-sports.io/football/teams/24723.png
24724	Recreativo Huelva II	\N	Spain	https://media.api-sports.io/football/teams/24724.png
24778	Racing CF Benidorm	\N	Spain	https://media.api-sports.io/football/teams/24778.png
24779	Vall de Uxó	\N	Spain	https://media.api-sports.io/football/teams/24779.png
24960	Marbelli	\N	Spain	https://media.api-sports.io/football/teams/24960.png
24961	Martos	\N	Spain	https://media.api-sports.io/football/teams/24961.png
24962	Malaga City	\N	Spain	https://media.api-sports.io/football/teams/24962.png
24979	Girona U19	\N	Spain	https://media.api-sports.io/football/teams/24979.png
24987	Stjarnan U19	\N	Spain	https://media.api-sports.io/football/teams/24987.png
25023	Eibar III	\N	Spain	https://media.api-sports.io/football/teams/25023.png
25024	Príncipe Alfonso	\N	Spain	https://media.api-sports.io/football/teams/25024.png
25030	Astur	\N	Spain	https://media.api-sports.io/football/teams/25030.png
25031	Dolorense	\N	Spain	https://media.api-sports.io/football/teams/25031.png
25032	Gévora	\N	Spain	https://media.api-sports.io/football/teams/25032.png
25033	Manises	\N	Spain	https://media.api-sports.io/football/teams/25033.png
25034	Ontiñena	\N	Spain	https://media.api-sports.io/football/teams/25034.png
25035	Parla Escuela	\N	Spain	https://media.api-sports.io/football/teams/25035.png
25036	Playas Sotavento	\N	Spain	https://media.api-sports.io/football/teams/25036.png
25037	Promesas EDF	\N	Spain	https://media.api-sports.io/football/teams/25037.png
25038	San Tirso	\N	Spain	https://media.api-sports.io/football/teams/25038.png
25039	Sonseca	\N	Spain	https://media.api-sports.io/football/teams/25039.png
25040	Sporting Mahón	\N	Spain	https://media.api-sports.io/football/teams/25040.png
25041	Vic	\N	Spain	https://media.api-sports.io/football/teams/25041.png
25042	Villamuriel	\N	Spain	https://media.api-sports.io/football/teams/25042.png
25179	Inter Sevilla	\N	Spain	https://media.api-sports.io/football/teams/25179.png
25233	Spain U17 W	\N	Spain	https://media.api-sports.io/football/teams/25233.png
\.


--
-- Data for Name: teams_players; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.teams_players (team_id, player_id) FROM stdin;
\.


--
-- Name: countries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.countries_id_seq', 1, false);


--
-- Name: leagues_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.leagues_id_seq', 1, false);


--
-- Name: matches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.matches_id_seq', 1, false);


--
-- Name: players_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.players_id_seq', 1, false);


--
-- Name: players_statistics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.players_statistics_id_seq', 1, false);


--
-- Name: seasons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seasons_id_seq', 1277, true);


--
-- Name: teams_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.teams_id_seq', 1, false);


--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);


--
-- Name: leagues leagues_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leagues
    ADD CONSTRAINT leagues_pkey PRIMARY KEY (id);


--
-- Name: matches matches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_pkey PRIMARY KEY (id);


--
-- Name: players players_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_pkey PRIMARY KEY (id);


--
-- Name: players_statistics players_statistics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players_statistics
    ADD CONSTRAINT players_statistics_pkey PRIMARY KEY (id);


--
-- Name: season_teams season_teams_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.season_teams
    ADD CONSTRAINT season_teams_pkey PRIMARY KEY (season_id, team_id);


--
-- Name: seasons seasons_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seasons
    ADD CONSTRAINT seasons_pkey PRIMARY KEY (id);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: teams_players teams_players_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams_players
    ADD CONSTRAINT teams_players_pkey PRIMARY KEY (team_id, player_id);


--
-- Name: leagues leagues_country_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.leagues
    ADD CONSTRAINT leagues_country_id_fkey FOREIGN KEY (country_id) REFERENCES public.countries(id);


--
-- Name: matches matches_away_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_away_team_id_fkey FOREIGN KEY (away_team_id) REFERENCES public.teams(id);


--
-- Name: matches matches_home_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_home_team_id_fkey FOREIGN KEY (home_team_id) REFERENCES public.teams(id);


--
-- Name: matches matches_league_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matches
    ADD CONSTRAINT matches_league_id_fkey FOREIGN KEY (league_id) REFERENCES public.leagues(id);


--
-- Name: players_statistics players_statistics_match_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players_statistics
    ADD CONSTRAINT players_statistics_match_id_fkey FOREIGN KEY (match_id) REFERENCES public.matches(id);


--
-- Name: players_statistics players_statistics_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players_statistics
    ADD CONSTRAINT players_statistics_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(id);


--
-- Name: players players_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.players
    ADD CONSTRAINT players_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: season_teams season_teams_season_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.season_teams
    ADD CONSTRAINT season_teams_season_id_fkey FOREIGN KEY (season_id) REFERENCES public.seasons(id);


--
-- Name: season_teams season_teams_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.season_teams
    ADD CONSTRAINT season_teams_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- Name: seasons seasons_league_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.seasons
    ADD CONSTRAINT seasons_league_id_fkey FOREIGN KEY (league_id) REFERENCES public.leagues(id);


--
-- Name: teams_players teams_players_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams_players
    ADD CONSTRAINT teams_players_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.players(id);


--
-- Name: teams_players teams_players_team_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.teams_players
    ADD CONSTRAINT teams_players_team_id_fkey FOREIGN KEY (team_id) REFERENCES public.teams(id);


--
-- PostgreSQL database dump complete
--

