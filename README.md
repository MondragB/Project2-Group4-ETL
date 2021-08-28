![Movie-1200-630](https://user-images.githubusercontent.com/62668061/131230271-4f4985b6-760b-4bcf-9dfb-a769f9215736.jpeg)
# Movies Data - ETL (Extract, Transform, and Load)

There is a lot of very important and useful data available these days, but it is often dispersed among multiple data sources and not well organized. **Extracting** the data from it's sources, **transforming** it by cleaning or reformatting it, and **loading** or storing the resulting data into a well designed database is a critical process for data-driven organizations. This process is referred to as ETL.

## Background

For this project our data revolves around the use of one main source with multiple data files. A big portion of this project will be getting a good normalization of the data and making it atomic. The data will then be transformed to ensure only relevant information from each file makes it into the final database. Once the data is extracted, and cleaned/transformed, it will be loaded into a Postgres database.

This database is meant to serve avid movie watchers, reviewers and even data analyst. The final database will contain data on the cast, the crew, revenue, ratings and even keywords which allow this dataset to be pretty universal in terms scope. You can build and view trends, you will be able to compare and contrast different movies and even build something like a movie watching guide based on factors of your choosing.

## Table of Contents

- [Movies Data - ETL (Extract, Transform, and Load)](#movies-data---etl-extract-transform-and-load)
  - [Background](#background)
  - [Table of Contents](#table-of-contents)
  - [ETL Process](#etl-process)
    - [Step 1: Extract](#step-1-extract)
    - [Step 2: Transform](#step-2-transform)
    - [Step 3: Load](#step-3-load)
  - [Schema Sample](#schema-sample)
  - [Setup](#setup)
  - [Team](#team)

## ETL Process

- A beneficial tool that we used in order to understand and build strong relationships for this database was the use of an ERD (Entity Relationship Diagram) built in [Quick DBD](https://www.quickdatabasediagrams.com/).
- This allowed to somewhat work backwards by choosing the kind of data that was relevent and showed us far we had to normalize the data.

Here is one example of how a part of our ERD looks like.
![ERD Example](/ERD/images/Cast_Crew.PNG)

### Step 1: Extract

- Downloaded credits, keywords, movies_metadata and ratings `.csv files` from the [Kaggle Movie Dataset](https://www.kaggle.com/rounakbanik/the-movies-dataset)
- Read the `.csv file` into Jupyter Notebook for cleaning and transformation

### Step 2: Transform

- After extracting the `.csv files` there was one major problem we noticed. Within each of the `.csvs` there were these dictionary formatted data that was stored as a string. In order to fully extract the data we would need to normalize this columns before loading into the database.
- This is where ERD really shines, since we already had a good understanding on the type of data we would need, we just needed to build dataframes with the correct data in order to fill these tables.
- For each `.csv` we grabbed every column that contained the dictionary-styled data and we fed that through a loop that used the nifty `eval()` to split the data into a list.
- Once that value is iterated over we append that to a dataframe that eventually gets all their values concatenated.
- From this point we do some extra work like adding an index to certain frames so we can have proper Primary Keys and matching column names so we do not run into trouble when loading the data into their respective table.
- We also make use of the `.drop_duplicate()`, various versions of the `.loc()` (for filtering) and `.dropna()` on the frames in order to ensure that we are only getting complete and readable data.

### Step 3: Load

- Due to the sizes of some of the tables we thought it would be better to break down into smaller sections that can be run when needed.
- Each of the files is already ready to run, just make sure that connection string `rds_connection_string = postgres://YourUserName:YourPassword@YourHostname:YourPortNumber}/YourDatabaseName` is set your details.
- Once the data frames were all properly formatted, cleaned and tranformed, the tables were loaded into a Postgres database named `etl_db` via Jupyter Notebook.
- After the files were reformatted, a connection to Postgres was created using `sqlalchemy` and `create_engine` imports.
- The tables were converted to sql format using `to.sql()` with a connection open previous to these lines of code.

## Schema Sample

```SQL
CREATE TABLE "movies_data" (
    "id" integer NOT NULL,
    "imdb_id" varchar(12) NOT NULL,
    "budget" float NOT NULL,
    "original_language" varchar(2) NOT NULL,
    "original_title" varchar(100) NOT NULL,
    "overview" varchar(200) NOT NULL,
    "popularity" float NOT NULL,
    "release_date" date NOT NULL,
    "revenue" float NOT NULL,
    "runtime" integer NOT NULL,
    "status" boolean NOT NULL,
    "title" varchar(100) NOT NULL,
    "video" boolean NOT NULL,
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
ALTER TABLE "cast_movie_junction"
ADD CONSTRAINT "fk_cast_movie_junction_movie_id" FOREIGN KEY("movie_id") REFERENCES "movies_data" ("id");
ALTER TABLE "cast_movie_junction"
ADD CONSTRAINT "fk_cast_movie_junction_actor_id" FOREIGN KEY("actor_id") REFERENCES "actors" ("actor_id");
ALTER TABLE "crew_movie_junction"
ADD CONSTRAINT "fk_crew_movie_junction_movie_id" FOREIGN KEY("movie_id") REFERENCES "movies_data" ("id");
ALTER TABLE "crew_movie_junction"
ADD CONSTRAINT "fk_crew_movie_junction_crew_id" FOREIGN KEY("crew_id") REFERENCES "crew" ("crew_id");
```

## Setup

1. Clone the repository to your local drive by:
    - Clicking on the green "Code" buttom at the top of the page and copy the `HTTPS` link.
    - Open your terminal and navigate to the directory you want this repository to live in
      - i.e. `cd Documents/ETL-Project/`
    - Type `git clone` and paste the `HTTPS` link you copied from the GitHub website into your terminal and hit enter.
2. You will need to have Pandas, Numpy, and Sqlalchemy alongside PostgresSQL installed on your machine in order to create and make queries on this database.
3. From the ETL folder in your machine open up terminal/bash, type `jupyter notebook` and hit enter. This will open a tab in your default browser where you will see all the folders and files in the ETL folder.
4. Click on the `table_and_relation_queries.sql` file and run all the queries located in here.
5. This will create the `etl_db` on your local machine.
6. To view the database open the PgAdmin program and click connect.
7. `etl_db` should be listed and you can click on it to view collections, as well as click on any of the collections to view a single record.

## Example Queries

```
SELECT * from production_countries WHERE country = ('Germany') or country = ('Spain') or country = ('France');
SELECT * from movies_data WHERE budget < 1000000;
SELECT title, budget, release_date, revenue, runtime, original_language FROM movies_data ORDER BY revenue DESC;
   
```

## Team

Created by:

- [@Wdepalma](https://github.com/Wdepalma)  
- [@MondragB](https://github.com/MondragB)  
- [@rflammia-py](https://github.com/rflammia-py)  
- [@Mbutler22](https://github.com/Mbutler22)  
- [@ssrivastav0494](https://github.com/ssrivastav0494)
