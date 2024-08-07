#!/bin/bash

# ALTER TABLE properties RENAME COLUMN weight TO atomic_mass;
# ALTER TABLE properties ADD FOREIGN KEY(atomic_number) REFERENCES elements(atomic_number);

# ALTER TABLE properties RENAME COLUMN melting_point TO melting_point_celsius;
# ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL;

# ALTER TABLE properties RENAME COLUMN boiling_point TO boiling_point_celsius;
# ALTER TABLE properties ALTER COLUMN boiling_point_celsius SET NOT NULL;


# ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL;
# ALTER TABLE elements ADD UNIQUE(symbol);

# ALTER TABLE elements ALTER COLUMN name SET NOT NULL;
# ALTER TABLE elements ADD UNIQUE(name);


# CREATE TABLE types(type_id SERIAL PRIMARY KEY, type VARCHAR(10) NOT NULL);
# INSERT INTO types(type) VALUES('nonmetal'), ('metal'), ('metalloid');

# ALTER TABLE properties ADD COLUMN type_id INT REFERENCES type(type_id);

# ALTER TABLE properties ALTER COLUMN atomic_mass TYPE DECIMAL;
# UPDATE properties SET atomic_mass = TRIM(TRAILING '0' FROM CAST(atomic_mass AS TEXT))::DECIMAL;

# UPDATE properties SET type_id = 1 WHERE type = 'nonmetal';
# UPDATE properties SET type_id = 2 WHERE type = 'metal';
# UPDATE properties SET type_id = 3 WHERE type = 'metalloid';
# ALTER TABLE properties ALTER COLUMN type_id SET NOT NULL;


# DELETE FROM properties WHERE atomic_number = 1000;
# DELETE FROM elements WHERE atomic_number = 1000;
# ALTER TABLE properties DROP COLUMN type;


# INSERT INTO elements(atomic_number, symbol, name) VALUES(9, 'F', 'Fluorine'), (10, 'Ne', 'Neon');
# INSERT INTO properties(atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES(9, 18.998, -220, -188.1, 1), (10, 20.18, -248.6, -246.1, 1);
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
#PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ $1 ]]
then
  # if input is number
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    ELEMENT_RESULT=$($PSQL "SELECT atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number = $1;")
  else
    # input is letters
    ELEMENT_RESULT=$($PSQL "SELECT atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol = '$1' OR name = '$1';")
  fi

  if [[ -z $ELEMENT_RESULT ]]
  then
    echo I could not find that element in the database.
  else
    IFS="|"
    echo "$ELEMENT_RESULT" | (read ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT_CELSIUS BOILING_POINT_CELSIUS TYPE;
    # echo $ATOMIC_NUMBER
    # echo $SYMBOL
    # echo $NAME
    # echo $TYPE
    # echo $ATOMIC_MASS
    # echo $MELTING_POINT_CELSIUS
    # echo $BOILING_POINT_CELSIUS
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius."
    )
  fi
else
  echo Please provide an element as an argument.
fi