## Filtering

```sql
USE nobel;

SELECT * FROM laureates LIMIT 10;

SELECT * FROM laureates WHERE borncountrycode = 'HU';

SELECT * FROM laureates WHERE borncountrycode IN ('HU', 'AT');
```

```sql
SELECT * FROM laureates WHERE year = 2010;

-- not recommended (does not scale)
SELECT * FROM laureates WHERE year = 2010
ALLOW FILTERING;

CREATE INDEX ON laureates (year);

SELECT * FROM laureates WHERE year = 2010;
```

## Ordering

```sql
USE nobel;

SELECT * FROM laureates WHERE borncountrycode = 'HU';
-- notice that records are sorted by laureateid (clustering key)

SELECT * FROM laureates WHERE borncountrycode IN ('HU','AT');
-- notice that records are sorted by laureateid only within the partition key

-- we can reverse the ordering
SELECT * FROM laureates WHERE borncountrycode = 'HU'
ORDER BY laureateid DESC;

-- Let's sort by year
SELECT * FROM laureates WHERE borncountrycode = 'HU'
ORDER BY year;

-- We can only order by clustering key

CREATE TABLE laureates_by_category (
  year int,
  laureateid int,
  borncity text,
  borncountrycode text,
  category text,
  firstname text,
  surname text,
  PRIMARY KEY (category, year, laureateid))
WITH CLUSTERING ORDER BY (year DESC);

COPY laureates_by_category (year, category, laureateid, firstname, surname, borncountrycode, borncity)
FROM '/nobel/laureates.csv';

SELECT * FROM laureates_by_category WHERE category = 'physics';
SELECT * FROM laureates_by_category WHERE category = 'physics' LIMIT 5;
SELECT * FROM laureates_by_category WHERE category = 'physics' ORDER BY year LIMIT 5;
```