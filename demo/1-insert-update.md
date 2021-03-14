## Execute CQL statements

```bash
# Log in to node1
./01-start.sh

# Log in to node1 shell
./node1-shell.sh

# Open CQL shell
cqlsh
```

## Create Keyspace

* Keyspace is like a database in RDBMS
* It can hold several tables

```sql
CREATE KEYSPACE demo
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};
USE demo;
```

## Inserting and Updating

#### Create Table

* Primary key is mandatory

```sql
CREATE TABLE user
(
  id int,
  name text,
  PRIMARY KEY (id)
);
```

```sql
INSERT INTO user (id, name)
VALUES ( 1, 'Ada Lovelace');

-- Key violation ?
INSERT INTO user (id, name)
VALUES ( 1, 'Charles Babbage');

SELECT * FROM user;

-- Nothing to update
UPDATE user
SET name = 'Linus Torvalds'
WHERE id = 2;
```
