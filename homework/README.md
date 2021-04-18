# Homework

Play with the COVID vaccination data found in the [country_vaccinations.csv](country_vaccinations.csv) file.
The original data source is available on [kaggle](https://www.kaggle.com/gpreda/covid-world-vaccination-progress).

## Hints

* You can create a single-node Cassandra by running the following commands:
  ```bash
  # Create a docker container named chw
  docker run -d --name chw cassandra:3.
  
  # Copy the sample data to the root folder of the container
  docker cp country_vaccinations.csv chw:/
  
  # Open the CQL shell inside the docker container
  docker exec -it chw cqlsh
  ```
* Execute the following statements to create the table
  ```sql
  -- Create the Cassandra keyspace
  CREATE KEYSPACE covid WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};
  
  -- Switch to the new keyspace
  USE covid;
  
  -- Example CREATE TABLE statement
  CREATE TABLE vaccinations(
    country text,
    iso_code text,
    date1 date,
    total_vaccinations decimal,
    people_vaccinated decimal,
    people_fully_vaccinated decimal,
    daily_vaccinations_raw decimal,
    daily_vaccinations decimal,
    total_vaccinations_per_hundred decimal,
    people_vaccinated_per_hundred decimal,
    people_fully_vaccinated_per_hundred decimal,
    daily_vaccinations_per_million decimal,
    vaccines text,
    source_name text,
    source_website text,
    PRIMARY KEY (country, iso_code, date1)
  );
  
  -- Import data
  COPY vaccinations (
    country,iso_code,date1,total_vaccinations,people_vaccinated,people_fully_vaccinated,
    daily_vaccinations_raw,daily_vaccinations,total_vaccinations_per_hundred,people_vaccinated_per_hundred,
    people_fully_vaccinated_per_hundred,daily_vaccinations_per_million,vaccines,source_name,source_website)
  FROM 'country_vaccinations.csv'
  WITH HEADER = TRUE;
  ```