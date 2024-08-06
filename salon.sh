#! /bin/bash
#PSQL="psql --username=freecodecamp --dbname=salon -c"
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
# : '
# CREATE DATABASE salon;

# \c salon

# CREATE TABLE customers(customer_id SERIAL PRIMARY KEY);
# CREATE TABLE appointments(appointment_id SERIAL PRIMARY KEY);
# CREATE TABLE services(service_id SERIAL PRIMARY KEY);

# ALTER TABLE appointments ADD COLUMN customer_id INT REFERENCES customers(customer_id);
# ALTER TABLE appointments ADD COLUMN service_id INT REFERENCES services(service_id);
# ALTER TABLE appointments ADD COLUMN name VARCHAR(15);
# ALTER TABLE appointments ADD COLUMN time VARCHAR(10);

# ALTER TABLE customers ADD COLUMN phone VARCHAR(15) NOT NULL UNIQUE;
# ALTER TABLE customers ADD COLUMN name VARCHAR(15) NOT NULL;

# ALTER TABLE services ADD COLUMN name VARCHAR(5) NOT NULL UNIQUE;
# ALTER TABLE services ADD COLUMN available BOOLEAN DEFAULT TRUE;

# INSERT INTO services(type) VALUES('cut'), ('color'), ('perm'), ('style'), ('trim');
# '

echo -e "\n~~~~~ MY SALON ~~~~~\n"

SERVICES_LIST() {
  # get all services
  SELECT_SERVICE_RESULT=$($PSQL "SELECT service_id, name FROM services;")
  echo "$SELECT_SERVICE_RESULT" | while read SERVICE_ID BAR NAME
  do
    echo "$SERVICE_ID) $NAME"
  done
}

MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  else
    echo -e "\nWelcome to My Salon, how can I help you?\n"
  fi
  
  SERVICES_LIST

  read SERVICE_ID_SELECTED
  if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
  then
    MAIN_MENU "I could not find that service. What would you like today?"
  else
    SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED;")
    echo $SERVICE_NAME
    if [[ -z $SERVICE_NAME ]]
    then
      MAIN_MENU "I could not find that service. What would you like today?"
    else
      echo -e "\nWhat's your phone number?"
      read CUSTOMER_PHONE
      CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE';")
      if [[ -z $CUSTOMER_ID ]]
      then
        echo -e "\nI don't have a record for that phone number, what's your name?"
        read CUSTOMER_NAME
        # insert new customer
        INSERT_CUSTOMER_RESULLT=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME');")
        CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE';")
      fi
      CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE';")
      echo -e "\nWhat time would you like your $(echo $SERVICE_NAME | sed -E 's/^ *| *$//g'), $(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')?"
      read SERVICE_TIME
      # insert new appointmnet
      INSERT_APPOIMNET_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
      echo -e "\nI have put you down for a $(echo $SERVICE_NAME | sed -E 's/^ *| *$//g') at $(echo $SERVICE_TIME | sed -E 's/^ *| *$//g'), $(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')."
    fi
  fi
}

MAIN_MENU