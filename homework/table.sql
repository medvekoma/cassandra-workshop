CREATE TABLE vaccinations(
  country text static,
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
  PRIMARY KEY (iso_code, date1, people_vaccinated)
)
WITH CLUSTERING ORDER BY (date1 DESC, people_vaccinated DESC);

COPY vaccinations (country,iso_code,date1,total_vaccinations,people_vaccinated,people_fully_vaccinated,daily_vaccinations_raw,daily_vaccinations,total_vaccinations_per_hundred,people_vaccinated_per_hundred,people_fully_vaccinated_per_hundred,daily_vaccinations_per_million,vaccines,source_name,source_website)
FROM 'country_vaccinations.csv'
WITH HEADER = TRUE
AND NULL=0.0;