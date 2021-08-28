CREATE TABLE "production_companies" (
    "name" varchar(30000) NOT NULL,
    "comp_id" integer NOT NULL,
    CONSTRAINT "pk_production_companies" PRIMARY KEY ("comp_id")
);
CREATE TABLE "production_countries" (
    "iso_3166_1" varchar(2) NOT NULL,
    "country" varchar(30000) NOT NULL,
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
ALTER TABLE "country_movie_junction"
ADD CONSTRAINT "fk_country_movie_junction_movie_id" FOREIGN KEY("movie_id") REFERENCES "movies_data" ("id");
ALTER TABLE "country_movie_junction"
ADD CONSTRAINT "fk_country_movie_junction_iso_3166" FOREIGN KEY("iso_3166_1") REFERENCES "production_countries" ("iso_3166_1");
ALTER TABLE "company_movie_junction"
ADD CONSTRAINT "fk_company_movie_junction_movie_id" FOREIGN KEY("movie_id") REFERENCES "movies_data" ("id");
ALTER TABLE "company_movie_junction"
ADD CONSTRAINT "fk_company_movie_junction_comp_id" FOREIGN KEY("comp_id") REFERENCES "production_companies" ("comp_id");
