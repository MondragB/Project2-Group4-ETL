CREATE TABLE "ratings" (
    "movie_id" integer NOT NULL,
    "ratings_count" integer NOT NULL,
    "avg_rating" float NOT NULL,
    "median_rating" float NOT NULL,
    CONSTRAINT "pk_ratings" PRIMARY KEY ("movie_id")
);
ALTER TABLE "ratings"
ADD CONSTRAINT "fk_ratings_movie_id" FOREIGN KEY("movie_id") REFERENCES "movies_data" ("id");