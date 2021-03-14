## Collections

#### Create table

* Column `phones` is a map

```sql 
CREATE TABLE contacts
(
  id int, 
  name text, 
  phones map<text, text>, 
  PRIMARY KEY (id)
);
```

#### Insert values

* Observe brackets in the map field

```sql
INSERT INTO contacts 
  (id, name, phones) 
VALUES 
  (1, 'Cassandra Smiths', {'Home':'+36 1 1234567','Mobile':'+36 30 7894561'});

SELECT * FROM contacts;

UPDATE contacts 
SET phones = phones + {'Other':'+1 205 7897897'} 
WHERE id = 1;

INSERT INTO contacts 
  (id, name, phones) 
VALUES 
  (2, 'Noah Sequel', {'Work':'+36 1 4326112'});

UPDATE contacts 
SET phones = phones - {'Other'} 
WHERE id = 1;
```

### Internal representation

| Row Key |                             |                                  |                                     |                                    |
| -------:|:---------------------------:|:--------------------------------:|:-----------------------------------:|:----------------------------------:|
| 1       | **name**<br>Cassandra Smith | **phones:Home**<br>+36 1 1234567 | **phones:Mobile**<br>+36 30 7894561 | **phones:Other**<br>+1 205 7897897 |
| 2       | **name**<br>Noah Sequel     | **phones:Work**<br>+36 1 4326112 |                                     |                                    |

## User defined types

```sql
CREATE TYPE article
(
  id int, 
  name text, 
  price decimal
);

CREATE TABLE invoice 
(
  id int PRIMARY KEY, 
  buyer text, 
  items list<frozen<article>>
);

INSERT INTO invoice (id, buyer, items) 
VALUES (1, 'Joe', [
  {id: 1, name: 'Book', price: 11.99}, 
  {id: 2, name: 'Computer', price: 3333}
]);

SELECT * FROM invoice;

UPDATE invoice 
SET items = items + [{id: 3, name: 'Cable', price: 1.00}] 
WHERE id = 1;

DELETE items[1] FROM invoice WHERE id = 1;
```
