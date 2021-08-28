CREATE TABLE "movies_data" (
    "id" integer NOT NULL,
    "imdb_id" varchar(12),
    "budget" float,
    "original_language" varchar(2),
    "original_title" varchar(255),
    "overview" varchar(1000),
    "popularity" float,
    "release_date" date,
    "revenue" float,
    "runtime" integer,
    "status" varchar(255),
    "title" varchar(255) NOT NULL,
    "video" varchar(255),
    CONSTRAINT "pk_movies_data" PRIMARY KEY ("id")
);
CREATE TABLE "cast_movie_junction" (
    "rec_key" SERIAL NOT NULL,
    "movie_id" integer NOT NULL,
    "character" varchar(30) NOT NULL,
    "order" integer NOT NULL,
    "actor_id" integer NOT NULL,
    CONSTRAINT "pk_cast_movie_junction" PRIMARY KEY ("rec_key")
);
CREATE TABLE "actors" (
    "actor_id" integer NOT NULL,
    "name" varchar(255) NOT NULL,
    "gender" varchar(255) NOT NULL,
    CONSTRAINT "pk_actors" PRIMARY KEY ("actor_id")
);
CREATE TABLE "crew_movie_junction" (
    "rec_key" SERIAL NOT NULL,
    "movie_id" integer NOT NULL,
    "department" varchar(255) NOT NULL,
    "job" varchar(255) NOT NULL,
    "crew_id" integer NOT NULL
);
CREATE TABLE "crew" (
    "crew_id" integer NOT NULL,
    "name" varchar(255) NOT NULL,
    "gender" varchar(255) NOT NULL,
    CONSTRAINT "pk_crew" PRIMARY KEY ("crew_id")
);
CREATE TABLE "production_companies" (
    "name" varchar(30) NOT NULL,
    "comp_id" integer NOT NULL,
    CONSTRAINT "pk_production_companies" PRIMARY KEY ("comp_id")
);
CREATE TABLE "production_countries" (
    "iso_3166_1" varchar(2) NOT NULL,
    "country" varchar(30) NOT NULL,
    CONSTRAINT "pk_production_countries" PRIMARY KEY ("iso_3166_1")
);
CREATE TABLE "country_movie_junction" (
    "rec_key" serial NOT NULL,
    "movie_id" integer NOT NULL,
    "iso_3166_1" varchar(2) NOT NULL,
    CONSTRAINT "pk_country_movie_junction" PRIMARY KEY ("rec_key")
);
CREATE TABLE "company_movie_junction" (
    "rec_key" serial NOT NULL,
    "movie_id" integer NOT NULL,
    "comp_id" integer NOT NULL,
    CONSTRAINT "pk_company_movie_junction" PRIMARY KEY ("rec_key")
);
CREATE TABLE "genres" (
    "genre_id" integer NOT NULL,
    "genre" varchar(30) NOT NULL,
    CONSTRAINT "pk_genres" PRIMARY KEY ("genre_id")
);
CREATE TABLE "genre_movie_junction" (
    "rec_key" SERIAL NOT NULL,
    "movie_id" integer NOT NULL,
    "genre_id" integer NOT NULL,
    CONSTRAINT "pk_genre_movie_junction" PRIMARY KEY ("rec_key")
);
CREATE TABLE "spoken_languages" (
    "iso_639_1" varchar(2) NOT NULL,
    "language" varchar(30) NOT NULL,
    CONSTRAINT "pk_spoken_languages" PRIMARY KEY ("iso_639_1")
);
CREATE TABLE "lang_movie_junction" (
    "rec_key" SERIAL NOT NULL,
    "movie_id" integer NOT NULL,
    "iso_639_1" varchar(2) NOT NULL,
    CONSTRAINT "pk_lang_movie_juction" PRIMARY KEY ("rec_key")
);
CREATE TABLE "ratings" (
    "movie_id" integer NOT NULL,
    "ratings_count" integer NOT NULL,
    "avg_rating" float NOT NULL,
    "median_rating" float NOT NULL,
    CONSTRAINT "pk_ratings" PRIMARY KEY ("movie_id")
);
ALTER TABLE "ratings"
ADD CONSTRAINT "fk_ratings_movie_id" FOREIGN KEY("movie_id") REFERENCES "movies_data" ("id");
ALTER TABLE "lang_movie_junction"
ADD CONSTRAINT "fk_lang_movie_junction_movie_id" FOREIGN KEY("movie_id") REFERENCES "movies_data" ("id");
ALTER TABLE "lang_movie_junction"
ADD CONSTRAINT "fk_lang_movie_junction_iso_639_1" FOREIGN KEY("iso_639_1") REFERENCES "spoken_languages" ("iso_639_1");
ALTER TABLE "genre_movie_junction"
ADD CONSTRAINT "fk_genre_movie_junction_movie_id" FOREIGN KEY("movie_id") REFERENCES "movies_data" ("id");
ALTER TABLE "genre_movie_junction"
ADD CONSTRAINT "fk_genre_movie_junction_genre_id" FOREIGN KEY("genre_id") REFERENCES "genres" ("genre_id");
ALTER TABLE "country_movie_junction"
ADD CONSTRAINT "fk_country_movie_junction_movie_id" FOREIGN KEY("movie_id") REFERENCES "movies_data" ("id");
ALTER TABLE "country_movie_junction"
ADD CONSTRAINT "fk_country_movie_junction_iso_3166" FOREIGN KEY("iso_3166_1") REFERENCES "production_countries" ("iso_3166_1");
ALTER TABLE "company_movie_junction"
ADD CONSTRAINT "fk_company_movie_junction_movie_id" FOREIGN KEY("movie_id") REFERENCES "movies_data" ("id");
ALTER TABLE "company_movie_junction"
ADD CONSTRAINT "fk_company_movie_junction_comp_id" FOREIGN KEY("comp_id") REFERENCES "production_companies" ("comp_id");
ALTER TABLE "cast_movie_junction"
ADD CONSTRAINT "fk_cast_movie_junction_movie_id" FOREIGN KEY("movie_id") REFERENCES "movies_data" ("id");
ALTER TABLE "cast_movie_junction"
ADD CONSTRAINT "fk_cast_movie_junction_actor_id" FOREIGN KEY("actor_id") REFERENCES "actors" ("actor_id");
ALTER TABLE "crew_movie_junction"
ADD CONSTRAINT "fk_crew_movie_junction_movie_id" FOREIGN KEY("movie_id") REFERENCES "movies_data" ("id");
ALTER TABLE "crew_movie_junction"
ADD CONSTRAINT "fk_crew_movie_junction_crew_id" FOREIGN KEY("crew_id") REFERENCES "crew" ("crew_id");