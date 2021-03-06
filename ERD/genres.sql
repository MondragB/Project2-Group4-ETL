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
ALTER TABLE "genre_movie_junction"
ADD CONSTRAINT "fk_genre_movie_junction_movie_id" FOREIGN KEY("movie_id") REFERENCES "movies_data" ("id");
ALTER TABLE "genre_movie_junction"
ADD CONSTRAINT "fk_genre_movie_junction_genre_id" FOREIGN KEY("genre_id") REFERENCES "genres" ("genre_id");