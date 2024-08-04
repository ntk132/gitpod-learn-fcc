#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
$PSQL "TRUNCATE teams, games;"

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WIN_GOALS OPP_GOALS
do
  
  if [[ $YEAR != year ]]
  then
    # get win | opp id
    WIN_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
    OPP_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")
    if [[ -z $WIN_ID && -z $OPP_ID ]]
    then
      INS_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER'), ('$OPPONENT');")
      if [[ $INS_TEAM_RESULT == "INSERT 0 2" ]]
      then
        WIN_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
        OPP_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")
      fi
    elif [[ -z $WIN_ID ]]
    then
      # insert winner team
      WIN_ID=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER');SELECT team_id FROM teams WHERE name='$WINNER';")

    elif [[ -z $OPP_ID ]]
    then
      # insert opponent team
      OPP_ID=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT');SELECT team_id FROM teams WHERE name='$OPPONENT';")
    fi
    INS_GAME_RESULT=$($PSQL "INSERT INTO games("year", round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WIN_ID, $OPP_ID, $WIN_GOALS, $OPP_GOALS);")
    if [[ $INS_GAME_RESULT == "INSERT 0 1" ]]
    then
      echo $YEAR: $ROUND: $WINNER "*"$WIN_GOALS - $OPP_GOALS $OPPONENT
    fi
  fi
done
