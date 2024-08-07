#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# generate ramdom number
SECRET_NUMBER=$((1 + $RANDOM % 1000))
GUESS_COUNT=0
FIND_OUT=false

# check username
echo Enter your username:
read USERNAME

USER_ID=$($PSQL "SELECT user_id FROM users WHERE name = '$USERNAME'")
# if not found user
if [[ -z $USER_ID ]]
then
  echo Welcome, $USERNAME! It looks like this is your first time here.
  # insert new user
  INSERT_USER_RESULT=$($PSQL "INSERT INTO users(name) VALUES('$USERNAME');")
  if [[ $INSERT_USER_RESULT == "INSERT 0 1" ]]
  then
    USER_ID=$($PSQL "SELECT user_id FROM users WHERE name = '$USERNAME'")
  fi
else
  # retrieve user info
  PLAYED_GAMES=$($PSQL "SELECT COUNT(*) FROM guesses WHERE user_id = $USER_ID;")
  BEST_GAME=$($PSQL "SELECT MIN(guess_count) FROM guesses WHERE user_id = $USER_ID;")
  echo Welcome back, $USERNAME! You have played $PLAYED_GAMES games, and your best game took $BEST_GAME guesses.
fi

function READ_NUMBER () {
  if [[ $1 ]]
  then
    echo $1
  fi

  read NUMBER
  while [[ ! $NUMBER =~ ^[0-9]+$ ]]
  do
    echo That is not an integer, guess again:
    read NUMBER
  done
}

# retrieve input value
READ_NUMBER "Guess the secret number between 1 and 1000:"
while [[ $FIND_OUT != true ]]
do
  GUESS_COUNT=$((GUESS_COUNT+1))
  if [[ $SECRET_NUMBER -lt $NUMBER ]]
  then
    READ_NUMBER "It's lower than that, guess again:"
  elif [[ $SECRET_NUMBER -gt $NUMBER ]]
  then
    READ_NUMBER "It's higher than that, guess again:"
  elif [[ $SECRET_NUMBER -eq $NUMBER ]]
  then
    echo You guessed it in $GUESS_COUNT tries. The secret number was $SECRET_NUMBER. Nice job!
    # insert new guess result
    INSERT_GUESS_RESULT=$($PSQL "INSERT INTO guesses(guess_count, secret_number, user_id) VALUES($GUESS_COUNT, $SECRET_NUMBER, $USER_ID);")
    FIND_OUT=true
  fi
done

# CREATE DATABASE number_guess;
# \c number_guess
# CREATE TABLE users(user_id SERIAL PRIMARY KEY, name VARCHAR(22) NOT NULL UNIQUE);
# CREATE TABLE guesses(guess_id SERIAL PRIMARY KEY, guess_count INT, secret_number INT, user_id INT NOT NULL REFERENCES users(user_id));

# INSERT INTO users(name) VALUES($USERNAME);
# INSERT INTO guesses(guess_count, secret_number, user_id) VALUES($GUESS_COUNT, $SECRET_NUMBER, $USER_ID);

# Test data
# INSERT INTO users(name) VALUES('Test');
# INSERT INTO guesses(guess_count, secret_number, user_id) VALUES(6, 325, 1), (10, 758, 1), (3, 123, 1);
