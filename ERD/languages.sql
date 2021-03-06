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
ALTER TABLE "lang_movie_junction"
ADD CONSTRAINT "fk_lang_movie_junction_movie_id" FOREIGN KEY("movie_id") REFERENCES "movies_data" ("id");
ALTER TABLE "lang_movie_junction"
ADD CONSTRAINT "fk_lang_movie_junction_iso_639_1" FOREIGN KEY("iso_639_1") REFERENCES "spoken_languages" ("iso_639_1");