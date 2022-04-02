# Vaccination Data

Play with the COVID vaccination data found in the [country_vaccinations.csv](country_vaccinations.csv) file. 

The original data source is available on [kaggle](https://www.kaggle.com/gpreda/covid-world-vaccination-progress). It was slighly cleaned (removed fields without some specific data).

## Hints

* Execute the following statements to create the table
  ```bash
  # Open the Cassandra CLI
  cqlsh
  ```

  ```sql
  -- Create the Cassandra keyspace
  CREATE KEYSPACE covid WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};
  
  -- Switch to the new keyspace
  USE covid;
  
  -- Example CREATE TABLE statement
  CREATE TABLE vaccinations (
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
  -- you can try different PRIMARY KEYS
  
  -- Import data
  COPY vaccinations (
    country,iso_code,date1,total_vaccinations,people_vaccinated,people_fully_vaccinated,
    daily_vaccinations_raw,daily_vaccinations,total_vaccinations_per_hundred,people_vaccinated_per_hundred,
    people_fully_vaccinated_per_hundred,daily_vaccinations_per_million,vaccines,source_name,source_website)
  FROM 'country_vaccinations.csv'
  WITH HEADER = TRUE;
  ```

* Try to run different queries. Some of them will fail.

```sql
SELECT * FROM vaccinations WHERE country = 'Hungary';
/* 
  There will be many pages, you have to press ENTER several times 
  when the text --- MORE --- apprears. 
  Alternatively, you can press Ctrl+C to quit 
*/

SELECT * FROM vaccinations WHERE country >= 'Hungary';

SELECT * FROM vaccinations 
WHERE country = 'Hungary' AND iso_code = 'HUN' AND date1 >= '2022-03-15';
```
