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
ALTER TABLE "cast_movie_junction"
ADD CONSTRAINT "fk_cast_movie_junction_movie_id" FOREIGN KEY("movie_id") REFERENCES "movies_data" ("id");
ALTER TABLE "cast_movie_junction"
ADD CONSTRAINT "fk_cast_movie_junction_actor_id" FOREIGN KEY("actor_id") REFERENCES "actors" ("actor_id");
ALTER TABLE "crew_movie_junction"
ADD CONSTRAINT "fk_crew_movie_junction_movie_id" FOREIGN KEY("movie_id") REFERENCES "movies_data" ("id");
ALTER TABLE "crew_movie_junction"
ADD CONSTRAINT "fk_crew_movie_junction_crew_id" FOREIGN KEY("crew_id") REFERENCES "crew" ("crew_id");