PGDMP      	                |            ud    16.1    16.1 e    '           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            (           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            )           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            *           1262    24785    ud    DATABASE     v   CREATE DATABASE ud WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';
    DROP DATABASE ud;
                postgres    false            �            1255    25698    check_booking_dates()    FUNCTION       CREATE FUNCTION public.check_booking_dates() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Проверка, что даты бронирования попадают в диапазон дат тура
    IF NEW.tour_start_date < (
        SELECT start_date FROM tours WHERE id = NEW.tour_id
    ) OR NEW.tour_end_date > (
        SELECT end_date FROM tours WHERE id = NEW.tour_id
    ) THEN
        RAISE EXCEPTION 'Booking dates must be within the tour dates';
    END IF;
    RETURN NEW;
END;
$$;
 ,   DROP FUNCTION public.check_booking_dates();
       public          postgres    false            �            1259    25462    booked_excursions    TABLE     v   CREATE TABLE public.booked_excursions (
    id integer NOT NULL,
    booking_id integer,
    excursions_id integer
);
 %   DROP TABLE public.booked_excursions;
       public         heap    postgres    false            �            1259    25461    booked_excursions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.booked_excursions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.booked_excursions_id_seq;
       public          postgres    false    234            +           0    0    booked_excursions_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.booked_excursions_id_seq OWNED BY public.booked_excursions.id;
          public          postgres    false    233            �            1259    24971    booking    TABLE     �   CREATE TABLE public.booking (
    id integer NOT NULL,
    tourist_id integer NOT NULL,
    tour_id integer NOT NULL,
    tour_start_date date NOT NULL,
    tour_end_date date NOT NULL
);
    DROP TABLE public.booking;
       public         heap    postgres    false            �            1259    24970    booking_id_seq    SEQUENCE     �   CREATE SEQUENCE public.booking_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.booking_id_seq;
       public          postgres    false    232            ,           0    0    booking_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.booking_id_seq OWNED BY public.booking.id;
          public          postgres    false    231            �            1259    24882    transfer_companies    TABLE     �   CREATE TABLE public.transfer_companies (
    id integer NOT NULL,
    title character varying(40) NOT NULL,
    contact_information character varying(120) NOT NULL,
    type character varying(120) NOT NULL
);
 &   DROP TABLE public.transfer_companies;
       public         heap    postgres    false            �            1259    24881    bus_companies_id_seq    SEQUENCE     �   CREATE SEQUENCE public.bus_companies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.bus_companies_id_seq;
       public          postgres    false    226            -           0    0    bus_companies_id_seq    SEQUENCE OWNED BY     R   ALTER SEQUENCE public.bus_companies_id_seq OWNED BY public.transfer_companies.id;
          public          postgres    false    225            �            1259    24938 
   excursions    TABLE     �   CREATE TABLE public.excursions (
    id integer NOT NULL,
    title character varying(60) NOT NULL,
    description character varying(120) NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    place character varying(120) NOT NULL
);
    DROP TABLE public.excursions;
       public         heap    postgres    false            �            1259    24937    excursions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.excursions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.excursions_id_seq;
       public          postgres    false    230            .           0    0    excursions_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.excursions_id_seq OWNED BY public.excursions.id;
          public          postgres    false    229            �            1259    24843    hotel_rooms    TABLE     �   CREATE TABLE public.hotel_rooms (
    id integer NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    hotel_id integer NOT NULL,
    booking_id integer NOT NULL,
    category character varying(40) NOT NULL
);
    DROP TABLE public.hotel_rooms;
       public         heap    postgres    false            �            1259    24842    hotel_rooms_id_seq    SEQUENCE     �   CREATE SEQUENCE public.hotel_rooms_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.hotel_rooms_id_seq;
       public          postgres    false    222            /           0    0    hotel_rooms_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.hotel_rooms_id_seq OWNED BY public.hotel_rooms.id;
          public          postgres    false    221            �            1259    24836    hotels    TABLE     C  CREATE TABLE public.hotels (
    id integer NOT NULL,
    title character varying(50) NOT NULL,
    address character varying(120) NOT NULL,
    contact_information character varying(120) NOT NULL,
    number_of_rooms integer NOT NULL,
    country character varying(50) NOT NULL,
    city character varying(50) NOT NULL
);
    DROP TABLE public.hotels;
       public         heap    postgres    false            �            1259    24835    hotels_id_seq    SEQUENCE     �   CREATE SEQUENCE public.hotels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.hotels_id_seq;
       public          postgres    false    220            0           0    0    hotels_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.hotels_id_seq OWNED BY public.hotels.id;
          public          postgres    false    219            �            1259    24815    tourists    TABLE     f  CREATE TABLE public.tourists (
    id integer NOT NULL,
    firstname character varying(30) NOT NULL,
    lastname character varying(30) NOT NULL,
    birth_date date NOT NULL,
    gender character varying(10) NOT NULL,
    phone_number character varying(30) NOT NULL,
    passport bigint NOT NULL,
    main integer,
    "father name" character varying[]
);
    DROP TABLE public.tourists;
       public         heap    postgres    false            �            1259    24814    tourists_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tourists_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.tourists_id_seq;
       public          postgres    false    216            1           0    0    tourists_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.tourists_id_seq OWNED BY public.tourists.id;
          public          postgres    false    215            �            1259    24829    tours    TABLE     :  CREATE TABLE public.tours (
    id integer NOT NULL,
    title character varying(30) NOT NULL,
    description character varying(120) NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    country character varying(30) NOT NULL,
    city character varying(30) NOT NULL,
    visa_needed boolean
);
    DROP TABLE public.tours;
       public         heap    postgres    false            �            1259    24828    tours_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tours_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.tours_id_seq;
       public          postgres    false    218            2           0    0    tours_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.tours_id_seq OWNED BY public.tours.id;
          public          postgres    false    217            �            1259    24908 	   transfers    TABLE     %  CREATE TABLE public.transfers (
    id integer NOT NULL,
    transfer_company_id integer,
    start_date date NOT NULL,
    end_date date NOT NULL,
    place_of_departure character varying(120) NOT NULL,
    place_of_arrival character varying(120) NOT NULL,
    booking_id integer NOT NULL
);
    DROP TABLE public.transfers;
       public         heap    postgres    false            �            1259    24907    transfers_id_seq    SEQUENCE     �   CREATE SEQUENCE public.transfers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.transfers_id_seq;
       public          postgres    false    228            3           0    0    transfers_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.transfers_id_seq OWNED BY public.transfers.id;
          public          postgres    false    227            �            1259    24861    visas    TABLE     �   CREATE TABLE public.visas (
    id integer NOT NULL,
    destination_country character varying(40) NOT NULL,
    date_of_issue date NOT NULL,
    expiry_date date NOT NULL,
    tourist_id integer NOT NULL
);
    DROP TABLE public.visas;
       public         heap    postgres    false            �            1259    24860    visas_id_seq    SEQUENCE     �   CREATE SEQUENCE public.visas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.visas_id_seq;
       public          postgres    false    224            4           0    0    visas_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.visas_id_seq OWNED BY public.visas.id;
          public          postgres    false    223            Q           2604    25465    booked_excursions id    DEFAULT     |   ALTER TABLE ONLY public.booked_excursions ALTER COLUMN id SET DEFAULT nextval('public.booked_excursions_id_seq'::regclass);
 C   ALTER TABLE public.booked_excursions ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    233    234    234            P           2604    24974 
   booking id    DEFAULT     h   ALTER TABLE ONLY public.booking ALTER COLUMN id SET DEFAULT nextval('public.booking_id_seq'::regclass);
 9   ALTER TABLE public.booking ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    232    231    232            O           2604    24941    excursions id    DEFAULT     n   ALTER TABLE ONLY public.excursions ALTER COLUMN id SET DEFAULT nextval('public.excursions_id_seq'::regclass);
 <   ALTER TABLE public.excursions ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    229    230    230            K           2604    24846    hotel_rooms id    DEFAULT     p   ALTER TABLE ONLY public.hotel_rooms ALTER COLUMN id SET DEFAULT nextval('public.hotel_rooms_id_seq'::regclass);
 =   ALTER TABLE public.hotel_rooms ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    222    222            J           2604    24839 	   hotels id    DEFAULT     f   ALTER TABLE ONLY public.hotels ALTER COLUMN id SET DEFAULT nextval('public.hotels_id_seq'::regclass);
 8   ALTER TABLE public.hotels ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    219    220            H           2604    24818    tourists id    DEFAULT     j   ALTER TABLE ONLY public.tourists ALTER COLUMN id SET DEFAULT nextval('public.tourists_id_seq'::regclass);
 :   ALTER TABLE public.tourists ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    215    216            I           2604    24832    tours id    DEFAULT     d   ALTER TABLE ONLY public.tours ALTER COLUMN id SET DEFAULT nextval('public.tours_id_seq'::regclass);
 7   ALTER TABLE public.tours ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    217    218            M           2604    24885    transfer_companies id    DEFAULT     y   ALTER TABLE ONLY public.transfer_companies ALTER COLUMN id SET DEFAULT nextval('public.bus_companies_id_seq'::regclass);
 D   ALTER TABLE public.transfer_companies ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    225    226    226            N           2604    24911    transfers id    DEFAULT     l   ALTER TABLE ONLY public.transfers ALTER COLUMN id SET DEFAULT nextval('public.transfers_id_seq'::regclass);
 ;   ALTER TABLE public.transfers ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    227    228    228            L           2604    24864    visas id    DEFAULT     d   ALTER TABLE ONLY public.visas ALTER COLUMN id SET DEFAULT nextval('public.visas_id_seq'::regclass);
 7   ALTER TABLE public.visas ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    223    224            $          0    25462    booked_excursions 
   TABLE DATA           J   COPY public.booked_excursions (id, booking_id, excursions_id) FROM stdin;
    public          postgres    false    234   �{       "          0    24971    booking 
   TABLE DATA           Z   COPY public.booking (id, tourist_id, tour_id, tour_start_date, tour_end_date) FROM stdin;
    public          postgres    false    232   1}                  0    24938 
   excursions 
   TABLE DATA           Y   COPY public.excursions (id, title, description, start_date, end_date, place) FROM stdin;
    public          postgres    false    230   �~                 0    24843    hotel_rooms 
   TABLE DATA           _   COPY public.hotel_rooms (id, start_date, end_date, hotel_id, booking_id, category) FROM stdin;
    public          postgres    false    222   ��                 0    24836    hotels 
   TABLE DATA           i   COPY public.hotels (id, title, address, contact_information, number_of_rooms, country, city) FROM stdin;
    public          postgres    false    220   F�                 0    24815    tourists 
   TABLE DATA           |   COPY public.tourists (id, firstname, lastname, birth_date, gender, phone_number, passport, main, "father name") FROM stdin;
    public          postgres    false    216   ��                 0    24829    tours 
   TABLE DATA           i   COPY public.tours (id, title, description, start_date, end_date, country, city, visa_needed) FROM stdin;
    public          postgres    false    218   ��                 0    24882    transfer_companies 
   TABLE DATA           R   COPY public.transfer_companies (id, title, contact_information, type) FROM stdin;
    public          postgres    false    226   ��                 0    24908 	   transfers 
   TABLE DATA           �   COPY public.transfers (id, transfer_company_id, start_date, end_date, place_of_departure, place_of_arrival, booking_id) FROM stdin;
    public          postgres    false    228   ŧ                 0    24861    visas 
   TABLE DATA           `   COPY public.visas (id, destination_country, date_of_issue, expiry_date, tourist_id) FROM stdin;
    public          postgres    false    224   ȫ       5           0    0    booked_excursions_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.booked_excursions_id_seq', 96, true);
          public          postgres    false    233            6           0    0    booking_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.booking_id_seq', 52, true);
          public          postgres    false    231            7           0    0    bus_companies_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.bus_companies_id_seq', 29, true);
          public          postgres    false    225            8           0    0    excursions_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.excursions_id_seq', 82, true);
          public          postgres    false    229            9           0    0    hotel_rooms_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.hotel_rooms_id_seq', 79, true);
          public          postgres    false    221            :           0    0    hotels_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.hotels_id_seq', 87, true);
          public          postgres    false    219            ;           0    0    tourists_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.tourists_id_seq', 1281, true);
          public          postgres    false    215            <           0    0    tours_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.tours_id_seq', 156, true);
          public          postgres    false    217            =           0    0    transfers_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.transfers_id_seq', 73, true);
          public          postgres    false    227            >           0    0    visas_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.visas_id_seq', 96, true);
          public          postgres    false    223            R           2606    25702    tourists birth_constraint    CHECK CONSTRAINT     o   ALTER TABLE public.tourists
    ADD CONSTRAINT birth_constraint CHECK ((birth_date < CURRENT_DATE)) NOT VALID;
 >   ALTER TABLE public.tourists DROP CONSTRAINT birth_constraint;
       public          postgres    false    216    216            v           2606    25467 (   booked_excursions booked_excursions_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.booked_excursions
    ADD CONSTRAINT booked_excursions_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.booked_excursions DROP CONSTRAINT booked_excursions_pkey;
       public            postgres    false    234            r           2606    24976    booking booking_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.booking DROP CONSTRAINT booking_pkey;
       public            postgres    false    232            j           2606    24887 %   transfer_companies bus_companies_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.transfer_companies
    ADD CONSTRAINT bus_companies_pkey PRIMARY KEY (id);
 O   ALTER TABLE ONLY public.transfer_companies DROP CONSTRAINT bus_companies_pkey;
       public            postgres    false    226            X           2606    25697    booking date_constraint    CHECK CONSTRAINT     s   ALTER TABLE public.booking
    ADD CONSTRAINT date_constraint CHECK ((tour_start_date < tour_end_date)) NOT VALID;
 <   ALTER TABLE public.booking DROP CONSTRAINT date_constraint;
       public          postgres    false    232    232    232    232            V           2606    25704    transfers date_constraint    CHECK CONSTRAINT     k   ALTER TABLE public.transfers
    ADD CONSTRAINT date_constraint CHECK ((start_date < end_date)) NOT VALID;
 >   ALTER TABLE public.transfers DROP CONSTRAINT date_constraint;
       public          postgres    false    228    228    228    228            T           2606    25705    tours date_constraint    CHECK CONSTRAINT     g   ALTER TABLE public.tours
    ADD CONSTRAINT date_constraint CHECK ((start_date < end_date)) NOT VALID;
 :   ALTER TABLE public.tours DROP CONSTRAINT date_constraint;
       public          postgres    false    218    218    218    218            W           2606    25714    excursions excursion_constraint    CHECK CONSTRAINT     r   ALTER TABLE public.excursions
    ADD CONSTRAINT excursion_constraint CHECK ((start_date <= end_date)) NOT VALID;
 D   ALTER TABLE public.excursions DROP CONSTRAINT excursion_constraint;
       public          postgres    false    230    230    230    230            p           2606    24943    excursions excursions_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.excursions
    ADD CONSTRAINT excursions_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.excursions DROP CONSTRAINT excursions_pkey;
       public            postgres    false    230            e           2606    24848    hotel_rooms hotel_rooms_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.hotel_rooms
    ADD CONSTRAINT hotel_rooms_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.hotel_rooms DROP CONSTRAINT hotel_rooms_pkey;
       public            postgres    false    222            b           2606    24841    hotels hotels_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.hotels
    ADD CONSTRAINT hotels_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.hotels DROP CONSTRAINT hotels_pkey;
       public            postgres    false    220            S           2606    25701    tourists main_constraint    CHECK CONSTRAINT     _   ALTER TABLE public.tourists
    ADD CONSTRAINT main_constraint CHECK ((main <> id)) NOT VALID;
 =   ALTER TABLE public.tourists DROP CONSTRAINT main_constraint;
       public          postgres    false    216    216    216    216            Z           2606    25707 !   tourists tourists_passport_id_key 
   CONSTRAINT     `   ALTER TABLE ONLY public.tourists
    ADD CONSTRAINT tourists_passport_id_key UNIQUE (passport);
 K   ALTER TABLE ONLY public.tourists DROP CONSTRAINT tourists_passport_id_key;
       public            postgres    false    216            \           2606    24822 "   tourists tourists_phone_number_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.tourists
    ADD CONSTRAINT tourists_phone_number_key UNIQUE (phone_number);
 L   ALTER TABLE ONLY public.tourists DROP CONSTRAINT tourists_phone_number_key;
       public            postgres    false    216            ^           2606    24820    tourists tourists_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.tourists
    ADD CONSTRAINT tourists_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.tourists DROP CONSTRAINT tourists_pkey;
       public            postgres    false    216            `           2606    24834    tours tours_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.tours
    ADD CONSTRAINT tours_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.tours DROP CONSTRAINT tours_pkey;
       public            postgres    false    218            n           2606    24913    transfers transfers_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT transfers_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.transfers DROP CONSTRAINT transfers_pkey;
       public            postgres    false    228            U           2606    25703    visas visa_constraint    CHECK CONSTRAINT     m   ALTER TABLE public.visas
    ADD CONSTRAINT visa_constraint CHECK ((date_of_issue < expiry_date)) NOT VALID;
 :   ALTER TABLE public.visas DROP CONSTRAINT visa_constraint;
       public          postgres    false    224    224    224    224            h           2606    24866    visas visas_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.visas
    ADD CONSTRAINT visas_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.visas DROP CONSTRAINT visas_pkey;
       public            postgres    false    224            s           1259    25366    fki_booking_tour_id_fkey    INDEX     O   CREATE INDEX fki_booking_tour_id_fkey ON public.booking USING btree (tour_id);
 ,   DROP INDEX public.fki_booking_tour_id_fkey;
       public            postgres    false    232            t           1259    25372    fki_booking_tourist_id_fkey    INDEX     U   CREATE INDEX fki_booking_tourist_id_fkey ON public.booking USING btree (tourist_id);
 /   DROP INDEX public.fki_booking_tourist_id_fkey;
       public            postgres    false    232            c           1259    25346    fki_hotel_rooms_hotel_id_fkey    INDEX     Y   CREATE INDEX fki_hotel_rooms_hotel_id_fkey ON public.hotel_rooms USING btree (hotel_id);
 1   DROP INDEX public.fki_hotel_rooms_hotel_id_fkey;
       public            postgres    false    222            k           1259    25328    fki_transfers_booking_id_fkey    INDEX     Y   CREATE INDEX fki_transfers_booking_id_fkey ON public.transfers USING btree (booking_id);
 1   DROP INDEX public.fki_transfers_booking_id_fkey;
       public            postgres    false    228            l           1259    25334    fki_transfers_bus_id_fkey    INDEX     ^   CREATE INDEX fki_transfers_bus_id_fkey ON public.transfers USING btree (transfer_company_id);
 -   DROP INDEX public.fki_transfers_bus_id_fkey;
       public            postgres    false    228            f           1259    25412    fki_vias_tourist_id    INDEX     K   CREATE INDEX fki_vias_tourist_id ON public.visas USING btree (tourist_id);
 '   DROP INDEX public.fki_vias_tourist_id;
       public            postgres    false    224            �           2620    25699    booking before_booking_insert    TRIGGER     �   CREATE TRIGGER before_booking_insert BEFORE INSERT ON public.booking FOR EACH ROW EXECUTE FUNCTION public.check_booking_dates();
 6   DROP TRIGGER before_booking_insert ON public.booking;
       public          postgres    false    235    232                       2606    25468 3   booked_excursions booked_excursions_booking_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.booked_excursions
    ADD CONSTRAINT booked_excursions_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.booking(id) ON UPDATE CASCADE ON DELETE CASCADE;
 ]   ALTER TABLE ONLY public.booked_excursions DROP CONSTRAINT booked_excursions_booking_id_fkey;
       public          postgres    false    232    4722    234            �           2606    25473 6   booked_excursions booked_excursions_excursions_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.booked_excursions
    ADD CONSTRAINT booked_excursions_excursions_id_fkey FOREIGN KEY (excursions_id) REFERENCES public.excursions(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 `   ALTER TABLE ONLY public.booked_excursions DROP CONSTRAINT booked_excursions_excursions_id_fkey;
       public          postgres    false    4720    234    230            }           2606    25361    booking booking_tour_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_tour_id_fkey FOREIGN KEY (tour_id) REFERENCES public.tours(id) ON UPDATE CASCADE ON DELETE CASCADE;
 F   ALTER TABLE ONLY public.booking DROP CONSTRAINT booking_tour_id_fkey;
       public          postgres    false    232    4704    218            ~           2606    25367    booking booking_tourist_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_tourist_id_fkey FOREIGN KEY (tourist_id) REFERENCES public.tourists(id) ON UPDATE CASCADE ON DELETE CASCADE;
 I   ALTER TABLE ONLY public.booking DROP CONSTRAINT booking_tourist_id_fkey;
       public          postgres    false    216    4702    232            x           2606    25341 %   hotel_rooms hotel_rooms_hotel_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.hotel_rooms
    ADD CONSTRAINT hotel_rooms_hotel_id_fkey FOREIGN KEY (hotel_id) REFERENCES public.hotels(id) ON UPDATE CASCADE ON DELETE CASCADE;
 O   ALTER TABLE ONLY public.hotel_rooms DROP CONSTRAINT hotel_rooms_hotel_id_fkey;
       public          postgres    false    4706    222    220            w           2606    25402    tourists tourists_main_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tourists
    ADD CONSTRAINT tourists_main_id_fkey FOREIGN KEY (main) REFERENCES public.tourists(id) ON UPDATE CASCADE ON DELETE CASCADE NOT VALID;
 H   ALTER TABLE ONLY public.tourists DROP CONSTRAINT tourists_main_id_fkey;
       public          postgres    false    4702    216    216            {           2606    25323 #   transfers transfers_booking_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT transfers_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.booking(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 M   ALTER TABLE ONLY public.transfers DROP CONSTRAINT transfers_booking_id_fkey;
       public          postgres    false    4722    232    228            y           2606    25397 %   hotel_rooms transfers_booking_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.hotel_rooms
    ADD CONSTRAINT transfers_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES public.booking(id) NOT VALID;
 O   ALTER TABLE ONLY public.hotel_rooms DROP CONSTRAINT transfers_booking_id_fkey;
       public          postgres    false    222    4722    232            |           2606    25329    transfers transfers_bus_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT transfers_bus_id_fkey FOREIGN KEY (transfer_company_id) REFERENCES public.transfer_companies(id) ON UPDATE CASCADE ON DELETE RESTRICT;
 I   ALTER TABLE ONLY public.transfers DROP CONSTRAINT transfers_bus_id_fkey;
       public          postgres    false    226    228    4714            z           2606    25407    visas visa_tourist_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.visas
    ADD CONSTRAINT visa_tourist_id FOREIGN KEY (tourist_id) REFERENCES public.tourists(id) NOT VALID;
 ?   ALTER TABLE ONLY public.visas DROP CONSTRAINT visa_tourist_id;
       public          postgres    false    4702    216    224            $   �  x���1��d1��$o/鿎�9ؙ5�TZ�jm�����K�ʭ�S{���Ok���:��e]����2ׅ��}����W؈m��8؈� �3��`�f����� ^@,�6�A�g����\0�3�A���q �� �e�����c���p?�f�[`��� ��@��X(�6@!�
� ��2�0��uR��@E�4P�+T�Jո�@�\i���i����@��i���4Pw��;��!��N���@��i��<i��y�@�<i�ٞ4�Oh�'4�ISK�x�@�<i����@��z�/��_��,���P~	��_ޟ=�<?�~y}���3�=������wR�M7���W)Ħ�N!6�����3x�      "   �  x�}�Ar�0�u�K:�#�}����{:�,�Γ�(����K����~��^���K� R�*�*A�&H�u���e�{�b'�:y�&�E
��Q$�:zy�-�)lN�L��uJ�(�>	&��h���e�;��̣>n�K�<\'�<�y\���x���$��3�vt5K�<�'��p��� �q>���8dm�01�qt�㐵ѫ`	�&�<�3F�]%\�J8>	��yb+QM�.NL�a������2�ܓ`XA�F���K�L���>�&�.�'�B#��������J6���d�F�J@�)����Z�K�p�p� �����ݖ+|����i����.=��yx���C�^rD�����m�2��/��d          $
  x��Zkn9�m�B��֣���a,+�d`��N���=���$K��I��F[Ud�E6ɦ���.��ȏ�b���H|K�]��3����W�*6����3�Y��ĳ��Ľ�Ķ��;�����E� S��'V�X�G��/��=�F��\��3�b��3�~?�K���K������O���~�I���'��L���#�O �-L
L����͋�s�rg��B�bk&�9��08�hI���w�FN J��EF�X�+����pE8i��8b���dw������x�"��!'�j�����/�����Z�"D�r݌���������A0��8�2�o���3��w.���6���9iX`_��=yC+)��G��GT,��m��a�3�*~T,H ��X��~�Ũ�8�.4���d{��O���|��=�%Ⱦ�iJ/̈@2�	'#ئxjJ��nH�,6:�{<��ŏh���)'m���o+�T~*P��[K-����=��Sy,��^��	 h��°>���r�C��d�(�8ə�O���qK�8�r8���qW0���N��L�%K#YYbAϙ�|	�A�hQs[��I�H�x�%x����c`Q�ahy�0�E8��E�m���)�(���('� �֖Ϲ�9�h���o��b�߁.J�x�mx�{EI�Z��q�%�Ƕf��t��&��*��IͰ���Fz-a��M߸��ӟ֡�� +��%��tB߭�?rӐ�)=̥|;���C�j���p2�pV�Z	���i�~��;�����[�0-e��׎*0�R��P,���P	fASN֖;q��9�)��-zp���G
�������}N�&���ʦft(�2�9�Qs�/�:2N� .(k���k�NX|@�##����d��M�_��c��-�9��7$eT�H7AZ�Z���M:����)����1ܓn�h!�K�v��f����9�7oi���3y=0� ��KWF�q2�ޮ����
��ԩ�1'���ŉ:�ʫ�H������/0���a�R��0'�ݑ>6T�y�����\���2�A�%��$2���aD�����McJ͆�|X_S�Ez�����Y����WVGǬo���Rvk\'���%1�]>V3�`��dJ$�����h6�
�$R�Awp����ĭ��7���d`,%X��1��#�D��a�W���w����nma���jp=u���	�	��_����7t8J2C�D��wJ��U�CN�G"��Q�*��6�P�@�����M\8��'à�p�Ud54�[��&ճ����0E"]Ɠ�����,��(�;Ͱ���<d�'��:1�Զ$���RVҁ���[2!�*L��n����*��v�m ?��柎ya�m��N�þ�Ã�m¡��%5�m�� u��������֭J"�Gb�56V�����
ݙ��2N�YO0��R������x�Ķ{�!�M�1^�yy�'3�9�0�t�E�Vby%N����R-n�k��t�Nܨ:�n��m(�͔���)�hx��'/D�r2}����%��m#�V;�d:��5��n���PGӚ�/p�I���'�F����m�P�#����}�\;�Ek�d��':�'�`'�V*敄�6�sɄ�q$S7�`"�6��Xg6l���L9E3��[�t�.Ȑ�귁-������:c�w:�!���9�	n_��J�5�Ձ�O{^����.c}�pڊ��$��w�
� �����b�=�d7�hOQ�[P��X.�>�U�q'%����ݘ������꿔���Z�"�w~*��5�!'�QGbڝ|�x���Ȼ?�[�*O�"0`F�ld\4����@���
�Z$Rx_������0mD"�G���Lj��(�Sm��Rx���v%���j�im�ɎWT���dW���W9o$Ӯ��\-`.��$h��9�W��Hĺ�tU��g�3��|"�p�{�ë�t��C���Ƌ��P�D>������I�(~�0v��5��L�<�����u�G<�-LL��.����l:L��@��LL˔�.��lA������]~~������u#*3�QLLC��.��r̩�|c�8��v={��JҨ���]K�Ľ��_�-��ځ^{Y�jw91["]�J��M�\%����}f$�����k�-@�_6�u�;�cN��حj2��.��o=�%�{Z��~��8�W��k*8��'�~��g�	���o>B�Y�z��j�N&."Q�q������R	I$���%2u��z� �9���/���U0yG����Z���겄:ǖ�M��5��%e'���i]]�I��}S����BL�Nk�s2���49TҝƐ��d�L=p2�7�?��)N-+��W��5���9�	������bٜܖG��L���h����7�Il0U�]��m�9�	���:`�V�0�iN�L]�o��z��p3�ϝv�&��b��=�	�'��j�"�r28�SH-�CF9{�f%y��6�'-�8��:%ki����xu�X��WK��W����F�q�ܿ~:>>��gJ�         @  x�}�M�T9EǮ����/�Ko�1�	3$րLZݬ�Վ���8H���䨎*u�B+�^yU���@��������q�w}�<�����ã��k���������_\�5��"���������Akk�a��3^�5V�y��hde�X쪲pt���
��5��+�ƪ`Ƿh��k�Є�|`�SFTk�t���]�Rmѓ�*�u�0��=�V�Dѕ��հ2&��<5h���$��1I�/O�Ȱ2��yj����F�{3"��}�J��<@+aj5
�G�t�r��va6�w`VƄ��;��.Д�6aw
�a-&ބ�{�+c�M؝b@4��I7awJ ɰS߄�{
Ȇ�1�M؝�bX�KY6awj �a9�M؟q>�+a��y��ʘ0
�T*���(
�=���1q�)j��1I�)B�ZL��� �aeL=
��aeL#
�T�Z�s%
�q �a%LT��{��u�J��Ea��@ðFa�׀�aeL�y
��aeL�y���a-&��|��Ѱ2&��<%�dXS��<��lX�iDa�7�䍉K��� ּ3q���q>
�ci�m�Z�քQ���C"%�MLѕ�H�zst�{�ŉ%����9�FW�bڪ�����ՉG��)M�IJ���[u�u�ެ��P��E_�8?��$�y����:	Ea��@�:	Ga�B�v�N"Q����$���ҡ:I��<%�|�N2�0O)�l�IK�{󛩇ꤛ0h?T'݄�㴡c�N�	�����n�<ՠ�Cu�M��z۪�n�|���:�&�S��I7a��U'݄��B�Cu������	��^         `  x��ZKs��^����@� ��;��H�3���J�!B�
��P+۪Sw�֒�δ�SY�g�,ґ,�V��B��?�9�A ��$�|8����Jѫ�"~��G��F�;�����4��EoX�|>����#������0�+�l�#X]�9g�w�)f���Y8��poI�>�T�ʴ�n��i�%MQJ�k��\���8~R���=8p�-ۥh+^����� ��@���`��E���v�zI5��� ���x�u��c��c[f�zE+yhT���� ���߁��~�$��^�����Y������ߖ�W0�{E7�&�lE-��^Q�R��+N����#d$:��Y�L�2:�"��^t
i*���Ã%�UU��=�9K��6w����誊�TMp$����_���b0D�ʪV�~��'����;���daL�=\��.J�
L �Y�M��H$V�:I%#N ���q�V�BN���5���_c@����7���\݀T�a{��¶��m߫���R�1�V�b_�*}��LS���4����]�#���C"��� oc(��U�N��P<���8��$��1��q¦�6x[�1}rM����W����Z��:V?������1fJh�[�O��Q��a���\c��o��Bn�(�AH�c�3%��a)�-��uy{m�����lF��M��"X�^ �Y���I�)��
�@Ȁ���ĻB�%�����Yj��_n�	h���NF��w1`~�<t�G�x�a��0�-� U�L@�`N£)�	�Z/齅�.0�7�3r��;�ՖA`.9�d�O��A�/O����\ܫ��~�Dk�*��H�E����7JW�0Լ謬����7�����fо�_j�	_�}z}�>����r�9(4�m��C��u�8n��`}&� ��Ra��nF'TB�S����\��
����j�Ã�nBP�â���U���/HQ�Q��B�m�-�`(�Z��A�����,ü�G�<T�r��n���;�4le�s`�ح�V���珣wp���=�C#�~�ϖW8{<�e,�������q�fJu��T	}ׅ 0q��&�~#��d��\� Fe��`�A��yH��t>ƁB���A�}y��8�}6Ԭ��GR4������y�EQ�c���ۜ���E��iKQ46m�p}̯p��:�+C�8)�V��p�$zy�\�َp�LrAWE\�A ��ۛ��	J�է�,�I����Pz�4��pCx3O*mMƣ��ԏ��j��SJW�P���\��oR*Կ�E��L�X	&P b`�?��~�X~���OJa�RL5����N��`�Y�+�@o�@I�|(zQ��Jjh����c��ӧɚ���^�Ճ�1��L��9�k6N(l�a��:p��Ц�r�	����0 �1��a��~8��<V�+0�,0iv�����!�L@o:�� ����-�v�]�2mkd[��� ����/�i2��OwD����y:52H�A�����紗���xX�؅�������fG,q�����U�L������T�w�Ͻ��L�2=a3@��ˉ�N⬶
�o(�춳�M5~0nN����E�9��N���J5�h��R@@���/u/��ة��k����?�j���i��S�,r4Ý �Y��ҫ��+U#`��b���C'{5�k�̱!0�L0)��zv��V��d�B��꫗��\U}��V�w����V��^e�P�����{�zY7
��o%s Nu�S$q��m�@Ġ�ԃK�T�l7	U5��Q!{w��H�2��*�$#�h���1nY�-��V\ަ�^܅�<}�}Sn��XuHc��ֽ'�]�Y��b����m �t�|����
�˂�RS��������-�~�A�/�x*��7�.
^�DD{n���#���sW��-�c���N趪Z( 6+`;Ac��u�P������� Z�'���}�@���G���L�F���S�wS�a�S�$0t\�C��t�ڪi�@�mU����Jئ.X�g��_�}K�}
��٘�� �2,��ɾ��9Qg����Z��;~��{e[��>uư������Qlg���P�39޽j�6�t6)�9��t���U���T����rY�{����\�aGc�ۣ%�'� h���/�vغ��y�;���oT*al�����rmM,5����� ��k(���?J���Q���S�@�a�E�d�o�ޥ6b2�T��&g��?Mv���,��7X�����x�˄�i�%�,�6�w<�Z~�vy@�%��t�|E���v�p�Q�d��k��i��l�\S�[%�&��ax�v�12� ��_�V/w s�4��*�LB��LH�L<���`-__!��L$��`�(U��==Q٭f ��R����)ӪǺ�������k@Ka�>D�O�H�K&��9|��Q��"l����Ajf����+��a;MI�휵A�$��1`���U��7��,�c��)�p�:�ꂷ�#��>Y�b{��uk|�	�e(��L0���aR��x�qF�<��J�4�j��-�HG����\��\-�;��yX k���*�ةH4���&�L���A�4��6̍u��H�>y��B,m/��d�E��|�������U�zʰ�����E�r�6��޶-f�����}9!���&��x�Xe��b�����0e����uB����]�G6����̼�C�TY���
�>�M)
�`�Cn�7��5e~t*��N���)Q��JU��ː�`RX�&�2M�Lu����p�q,��	j�(�E���c�����G�uJ�����(��M��f8Y�)�#m�����&��T������q���t%�Fb�WZ�q�4�k������#���x���oD�`l��e����b+�m*�o� ��2߬V�e�P�Apz��-J!py����� ��s@$b�`�i���I�~�>i���	Z��[M'r2u������$9��s|f�K�RV�h}:�G��V6��p�w�1?�~_`���vy��$>���dF�fQ�y[�ԩ��Z��	I�N���GR`AD��b0E�J���4�γ�c�BL^�M�-��s��L���jܥ�zK�����VR{7Ge��bG�S�{�%���h҄B��jH�
d�p�:_��5Z>�UVa,�BR|E�Cj�E$�L�
�W�`�`��� ؛���m�U�� ��V\����mi�*��xJ�s$WD-2o���G^\�4���B�����	�_�ST(��Sm|��j!6^b*�-!�������Ä���D V�7�j�v�0>)i�l�����l�'io08��C�\�?I	x�         �  x�}X�r�6}��B�v ���'��;���4m�K&q����jG�j��/�Գ� HJ�5ql���s�]H�&���q�1ޖ_�L�*�M�����W�o���*�����<��B��o�O�w����d=�*�j{
��o�7@�������=
�	�5�]܍���&����1�˄;(*T�
.�6��hmL����n ����tH�شڴ�V1�ܠJ��s����?�=��	�50>����]��`�ou���B��`�0�i���{>��A���>3ӵZ���}׍`+�����@�)��&q�)�@M���IO�W#�����n�NA��(tL����ZS�E�
N!Tb� [��wf�=�J �a�����\u�x��p���(���v�_��\8r��a�L-LkbcB�� ����kf8W�mߚZ��1̝8&N��h����A�x�o��~��Ga!�,ò�͟�W�g6`I�@�i�$7�nRn����ߋ���=br�λ%���oɄ/%G���䰒�\I%?�tG�L�1׮�K�2	�fJ%w�������<D�+i�k�vFgM	�)$�/s���?�/{�$U{|��0S������a�b�<��=��'�)ʦZ�vf��3m=�}�ټ���+����%��S�V���u��z��fϳ�ّw��6Y��V+c-�k���,�������Q��� S��9_ےW�O��n>?il~$�?"?LsT��QW�?]7ϭs3�qr��Ӵ{�?p�If��h���[�ȭ�k�nL�g��1��v�1f��usM͹��M@��}�^O���=#�z�������"A{	�Ye�R04���I^��CJ���oxM�h��F�c��)��Bʷ�,�g�r�;/��W��X.�'��S���*�(_��˅��ګ�����}G���Br$+V�ut.Aʫ��E�-�~K�pg�gX,r��������%�j���"'��7㏐��}��P��_�x��EcY���;^]?�RY��S��<Fj!��%J6��6���!�.���|c�#�A��!;�k�t�������N�g�2f�LH��-FD6��t�YV�U�)�w]1{`U�_	����LMVYtE9��ݪ!I΁����r�D�����>����L�힡�؊r��N�w���Ig?T�R�:�i���ߎx*�2�#O�� x���a�E D֭�em��rM�ٲ+ÉN)�AqO��U���3]�QbS��"��jS:��g��K���c�]�����#�O�3y�B�ue03	�u���H���4]�+��{�5�Bޤì�M:X��Y���EDt��j0#!��I69	R�ri���مD�.���-��Ď����4�uD�y�\�Xp��ԵI];P�v��ŅDX�Ŭ�g�ۏ8�fgB���b$7�ŕ$�s�n�v�)an�0����ծ�y�N7��?�xl޲�4��ɗg�EL�Q��w���<��+oN�������VS��         �  x��Xkr�6�M��pG/����0�U�����$m3qǝ���P�������]HB���?�H,��׷X�ۭH�P�Z�L?S�J�R��=��X���/.#u�������ӘW����R���o{����*l���i�B�?x��8�:����a�-���a��׌`�r=�P����m,�Q+�����J'� R��c���(��}�|�A�� �w����n��k���gD�)�|'R�0'a��!y~��>,}A�/��+����������v`���-�K^�(:R��+D��qO =�_��m�%;�w�%}��K���Ȭ��L�mo}[�B�}�Z�!�1%�5y�����*å�O8�,y[����Ev�%s��}iB:��m�O+����0	j!\
(��~;|��B��s�k�/����2���l7��}'�I�8A�A��
���
�
3۲��T�PyuI�"�)�SzE�k�]@��fTw����!-�b�9%�����!�ت�#�
�G�
�pW�:rȝt���##�Ư��P@�s��썇���jY���\m�\c�+5��$.�D�-6���Ӓ��_�(SB��72���
6gw�5�d�#�(;-bޜ����^f?���6��9�Ι/pjEE�ƈw
��bEZ�#��n�tŵ�pG��m�hZp_ˢjr��;a����e���Xԑ>���1�/hB��7$Z�$��`/e꛰qh3���=%�glx.-��^wPy ��J8M6���Պ�p�H�M���	�^�ԟ�W)�j��m���ӄ�]]Ar����2]�k⓰?{o)�4�k�y��wk2�6[j���搲l]�e��>����i��*�5�r�5��*֠��;m"���
��7�BI;���xX�F��c+�A{�:^��� 'S�$8^��p����X3ᦽ��C0U͵�����{�ro�s�=΀�1�˓-��VA�P��pgnX���L����I�y�ͭBwJ=�;�p��ԌZ~A�VJl@�!��nm���Y�arn���,vt��S��Z��o1�a��G��K� �K�]h�A� 5
6�o\4��pr}2��S��H	���HR�c�o4su���q9�:RErљ ��6e����Ӿ����f,gGB�x"��׭�b�H��I��r�r�r�/θ]��?y��i3�C��%<��9���OJ�8�4[���l�QnG�ڃS�5O���`������Y�Z_��Y�v*��dTQ&� �����/ǆ�Z���D�:w �Qq���N�;n�#{�YʈmJ��4��{�F�T�%���ʣ��0Eݣ^�7S�<;��rs7���}��P>���"��k�|疙;uS'�6l\�ޥlp�N����صέfg����EIN&A/ߪ�y�/?�L\iTًm�ɠ<57���ٳ��[ҙfC^{\U`�s���.6��N�3��$����Bg57�B1��'F+A�~wpp�/G>�           x��T�n�0]�|E��j켗eD��hFb�M�1Ś(���iv�T��_�>F�_�������21a�(��9�>�\���������A�ȕ��k|��C�¯�r�.,
�yó�R�~�c^5��Ҟ�$+�\tZ9[�Z"�:Wg�Z��/^��dK�ע��H�A\06k��uU�L��@}B�I�"õ:m���,�WM��i���i�xm�$��&)*���������,���=<Oi��H��$#x]��|"xa�}c&>�.��M�,yγ�}���L�R԰�18p�|v��T�b n䵼��K7�Jn�L7�L���$�����Muw��t��Q��^�`W���A:��<��s:2 �q(�=��ȶ��h�R�7��ԗ|��4��A���v�N���<���i:t�hd�.���m��\ɕ%�?o�/�s+����n�RG�dq`c��~�MA/s���L�3pV�̾?�1���ݵ��>ڳ,�7��<�         �  x���M��D���)��	��?�]8=�3���D�`1=3�5WȺr���ݻW�d?���qJ.���K�8��O_��������v���{=��zh(@��4���-�����t����
y�Xl2?/}f�A�r,7Y^������@��?���ԧa��$C�Jl7Y��O���nhS�M&۹��0����~7�xj��$?�����sJ	d�XiRb]�M_��g�	!-��ҳ��OJ�������f��ǿ*��nc��t��;~|�������g_��[�����@"}�Xo�be��X_����"���k���b��|�����F�n8h��>Bl3Y��>�Đ�>B�7Y_�)$	���c�ɶ&\ �ڎ�&�E���$Q�Ǥ�2T���>L��Y�#�B\�%��L��P�$�:�x5\X u:0֚����
�#A��d��6@�{L�C�B��(��d��
��G��&�~�h��h��$�%@
�m&e3_�@:��ROl�(Α�ߊe ���Ex��^�HI�:v�����E(��y˃��E����˃��ET�s���A�+�"j;v���`���v�L��ԝ\�$F=v�� �Xe��8��q����99�ؙ˃�{��2:�x.V���*����9�Y�����Xv��}�f�r�\�x<Gy3W�!W'��@�V�ͩ�s4Q_���@fg ��V;�� ����h�/f� ��I�s4 W�U�$���+b���BAg��+Uw¥k79�x�_{ \%;�x�Vh3[�8�x�6�p�R�x<G��F��4g��L���/f���G��	�8�x�x3Z��eJ�ܤ�&KW�&�-g�B�U��u�b��ԭ�=�+]�+�~e��҇�~�e��8re �ڗ�@-:q�ʀ�]p�Zt�@�ԽU0Am<q�ʀ�M��AO�2@��Tq؉�Vm�b�;w[�x⼕���X��ݒ3O�2p�+]�:��q+�������N��
��&�k�W_��+�T�         �  x���ݎ5���KP���.<�ή��J�"Q	n�ٟa�Yvy�Q���nw��;_�>��k���S�!|�_�#��τ�6.Iڅ�+��fZꊖ��Ր�u��ꉖ��Q�⒵j�Gv�g��U�RXhV��8� 9ư�q�J���M��/Y?��M�v~c��3]��sV����w�k>��p��/�ܲ��9����K'}H;��o�*�E��+3�����QU���\B�]�=�p�{f�U��!�CAp3O�}�_�ۦ�� nI���������PźfCv��@��fCv���p���\��!���~�B>r������?��������rf�A�xiKs�r]��W�J��EZ2Sά	�*ҵy��֘��r^-A�˷\�=��*�C�X�!1�H����)=�X�C�*N�4�/��V��E}�]����|þ'�?��(Ve:ʆ�oA:��S���,���=���	ƚ;�Iϙ��irXW��� ��4%��^��~���@���4T����Cō q'�7��ձ���,�9�!H��|̷�	RD�OB�X�yJ_S�!�����K���\P_s�!'U����u?����3Y���R�v<p>�ӁQ���B�4f����A1
sZi��|��i��#������n�N�?�ԣ�!��:����ͽ�e�6��yT���
H'vr���Q�2[���#=�6E��$T�X|�W|��'i��5CZE�{>�˸꿍�j: ʆ䯡�s��5��)�oc:"Fq�̿�*f>��-��;g�P:����t3&�D^�!��������wq�N�D'g�=|Ù�����0�R^�Aq��J?����!tA'��:m,BAw��Qфt�-6y�%M��AOr�A-E8h��-J0rh��-9t���A�o���~�:Z� h�N����,u��`���A��FlRG��֩c�F���"�%�9��s{�J-Ft0f�:(!`�u� A0n�:����L�oPG
�ۢ�FhXq�:Z�0�t�:����V~�:Z�p�j�:Z�`�z�:Z��`�uPuNə:�ݠ�(ֵԱ�		�W����mSUߜSÉM�ha���u,`���U�hA���-�ꚳz8}�:Z��s�u,pB���hq��ܒ:����LΟ��"|w�: ���&u�a�i�:�z��^nRG^mQG�L^�PG��Y���)+SǗ_ �L��     