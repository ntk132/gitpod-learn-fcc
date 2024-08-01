--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

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

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

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
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(30) NOT NULL,
    galaxy_cd integer,
    distance numeric(5,3),
    detail text,
    is_live boolean
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.galaxy_galaxy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.galaxy_galaxy_id_seq OWNER TO freecodecamp;

--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.galaxy_galaxy_id_seq OWNED BY public.galaxy.galaxy_id;


--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    name character varying(30) NOT NULL,
    moon_cd integer,
    planet_id integer NOT NULL,
    distance numeric(5,3),
    detail text,
    is_live boolean
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.moon_moon_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moon_moon_id_seq OWNER TO freecodecamp;

--
-- Name: moon_moon_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.moon_moon_id_seq OWNED BY public.moon.moon_id;


--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    name character varying(30) NOT NULL,
    planet_cd integer,
    star_id integer NOT NULL,
    distance numeric(5,3),
    detail text,
    is_live boolean
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.planet_planet_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planet_planet_id_seq OWNER TO freecodecamp;

--
-- Name: planet_planet_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.planet_planet_id_seq OWNED BY public.planet.planet_id;


--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    name character varying(30) NOT NULL,
    star_cd integer,
    galaxy_id integer NOT NULL,
    distance numeric(5,3),
    detail text,
    is_live boolean
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.star_star_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.star_star_id_seq OWNER TO freecodecamp;

--
-- Name: star_star_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.star_star_id_seq OWNED BY public.star.star_id;


--
-- Name: tmp_tb; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.tmp_tb (
    tmp_cd integer NOT NULL,
    tmp_txt character varying(20) NOT NULL,
    tmp_tb_id integer NOT NULL,
    name character varying(30) NOT NULL
);


ALTER TABLE public.tmp_tb OWNER TO freecodecamp;

--
-- Name: tmp_tb_tmp_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.tmp_tb_tmp_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tmp_tb_tmp_id_seq OWNER TO freecodecamp;

--
-- Name: tmp_tb_tmp_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.tmp_tb_tmp_id_seq OWNED BY public.tmp_tb.tmp_tb_id;


--
-- Name: galaxy galaxy_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy ALTER COLUMN galaxy_id SET DEFAULT nextval('public.galaxy_galaxy_id_seq'::regclass);


--
-- Name: moon moon_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon ALTER COLUMN moon_id SET DEFAULT nextval('public.moon_moon_id_seq'::regclass);


--
-- Name: planet planet_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet ALTER COLUMN planet_id SET DEFAULT nextval('public.planet_planet_id_seq'::regclass);


--
-- Name: star star_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star ALTER COLUMN star_id SET DEFAULT nextval('public.star_star_id_seq'::regclass);


--
-- Name: tmp_tb tmp_tb_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.tmp_tb ALTER COLUMN tmp_tb_id SET DEFAULT nextval('public.tmp_tb_tmp_id_seq'::regclass);


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 1, 8.277, NULL, true);
INSERT INTO public.galaxy VALUES (2, 'LMC', 2, 7.597, NULL, true);
INSERT INTO public.galaxy VALUES (3, 'Andromeda', 3, 7.590, NULL, false);
INSERT INTO public.galaxy VALUES (4, 'Cigar Galaxy', 4, 2.315, 'galaxy note', false);
INSERT INTO public.galaxy VALUES (5, 'Pinwheel Galaxy', 5, 23.952, NULL, true);
INSERT INTO public.galaxy VALUES (6, 'Sembrero Galaxy', 6, 7.235, 'galaxy note', true);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (7, 'Moon', 1, 3, 0.000, 'moon', true);
INSERT INTO public.moon VALUES (8, 'Io', 2, 8, 2.200, '', true);
INSERT INTO public.moon VALUES (9, 'Europa', 3, 8, 3.333, '', true);
INSERT INTO public.moon VALUES (10, 'Ganymede', 4, 8, 4.321, '', true);
INSERT INTO public.moon VALUES (11, 'Callisto', 5, 8, 5.123, '', true);
INSERT INTO public.moon VALUES (12, 'Fake Moon', 6, 3, 0.000, 'not a moon', false);
INSERT INTO public.moon VALUES (13, 'Charon', 7, 13, 0.000, '', false);
INSERT INTO public.moon VALUES (14, 'Mordor Macula', 8, 13, 9.672, '', true);
INSERT INTO public.moon VALUES (15, 'Hydra', 9, 13, 8.257, '', true);
INSERT INTO public.moon VALUES (16, 'Nix', 10, 13, 9.321, '', true);
INSERT INTO public.moon VALUES (17, 'Kerberos', 11, 13, 11.123, '', true);
INSERT INTO public.moon VALUES (18, 'Styx', 12, 13, 12.120, '', false);
INSERT INTO public.moon VALUES (27, 'Dione', 13, 10, 0.000, '', false);
INSERT INTO public.moon VALUES (28, 'Enceladus', 14, 10, 9.672, '', true);
INSERT INTO public.moon VALUES (29, 'Epimetheus', 15, 13, 8.257, '', true);
INSERT INTO public.moon VALUES (30, 'Prometheus', 16, 13, 9.321, '', true);
INSERT INTO public.moon VALUES (31, 'Mimas', 17, 13, 11.123, '', true);
INSERT INTO public.moon VALUES (32, 'Rhea', 18, 13, 12.120, '', false);
INSERT INTO public.moon VALUES (33, 'Janus', 19, 10, 19.910, '', false);
INSERT INTO public.moon VALUES (34, 'Tethys', 20, 10, 20.020, '', false);
INSERT INTO public.moon VALUES (35, 'Titan', 21, 10, 21.321, '', false);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 'Mercury', 1, 1, 1.100, '', false);
INSERT INTO public.planet VALUES (2, 'Venus', 2, 1, 2.220, '', false);
INSERT INTO public.planet VALUES (3, 'Earth', 3, 1, 0.000, 'Greenland', true);
INSERT INTO public.planet VALUES (4, 'Mars', 4, 1, 4.321, 'no water', false);
INSERT INTO public.planet VALUES (8, 'Jupiter', 5, 2, 5.100, '', false);
INSERT INTO public.planet VALUES (9, 'Cenus', 6, 2, 6.212, '', false);
INSERT INTO public.planet VALUES (10, 'Saturn', 7, 3, 7.562, '', false);
INSERT INTO public.planet VALUES (11, 'Uranus', 8, 4, 4.321, 'no', false);
INSERT INTO public.planet VALUES (12, 'Ceres', 9, 2, 9.900, '', false);
INSERT INTO public.planet VALUES (13, 'Pluto', 10, 3, 10.002, '', false);
INSERT INTO public.planet VALUES (14, 'Kepler', 11, 5, 11.110, '', false);
INSERT INTO public.planet VALUES (15, 'Glise', 12, 6, 12.123, '', false);


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 'Solar', 1, 1, 1.111, 'one star', true);
INSERT INTO public.star VALUES (2, 'Alpha', 2, 1, 2.220, 'two stars', true);
INSERT INTO public.star VALUES (3, 'Ross', 3, 2, 3.333, 'three stars', false);
INSERT INTO public.star VALUES (4, 'Wolf', 4, 3, 4.400, 'four stars', false);
INSERT INTO public.star VALUES (5, 'GJ', 5, 4, 5.432, 'five stars', false);
INSERT INTO public.star VALUES (6, 'YZ', 6, 4, 6.123, 'six stars', true);


--
-- Data for Name: tmp_tb; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.tmp_tb VALUES (1, 'one', 1, '1');
INSERT INTO public.tmp_tb VALUES (2, 'two', 2, '2');
INSERT INTO public.tmp_tb VALUES (3, 'three', 3, '3');


--
-- Name: galaxy_galaxy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.galaxy_galaxy_id_seq', 6, true);


--
-- Name: moon_moon_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.moon_moon_id_seq', 35, true);


--
-- Name: planet_planet_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.planet_planet_id_seq', 15, true);


--
-- Name: star_star_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.star_star_id_seq', 6, true);


--
-- Name: tmp_tb_tmp_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.tmp_tb_tmp_id_seq', 3, true);


--
-- Name: galaxy galaxy_galaxy_cd_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_galaxy_cd_key UNIQUE (galaxy_cd);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_moon_cd_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_moon_cd_key UNIQUE (moon_cd);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: planet planet_planet_cd_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_planet_cd_key UNIQUE (planet_cd);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: star star_star_cd_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_star_cd_key UNIQUE (star_cd);


--
-- Name: tmp_tb tmp_tb_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.tmp_tb
    ADD CONSTRAINT tmp_tb_pkey PRIMARY KEY (tmp_tb_id);


--
-- Name: tmp_tb tmp_tb_tmp_cd_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.tmp_tb
    ADD CONSTRAINT tmp_tb_tmp_cd_key UNIQUE (tmp_cd);


--
-- Name: moon moon_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet planet_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_star_id_fkey FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- Name: star star_galaxy_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_galaxy_id_fkey FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- PostgreSQL database dump complete
--

