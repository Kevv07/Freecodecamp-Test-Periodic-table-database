#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
JOINED="FROM elements JOIN properties ON elements.atomic_number = properties.atomic_number JOIN types ON properties.type_id = types.type_id;"
if [[ -z $1 ]]
  then
    echo "Please provide an element as an argument."
  fi

 #check if atomic number
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1" 2>/dev/null)
# check if symbol
    ELEMENT_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol = '$1'" 2>/dev/null )
# check if name
    ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE name = '$1'" 2>/dev/null )


#  BY Atomic number
  if [[ ! -z $ATOMIC_NUMBER ]]
    then
      ELE_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $1")
      ELE_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $1")
      ELE_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $1")
      ELE_TYPE=$($PSQL "SELECT type FROM types FULL JOIN properties ON types.type_id = properties.type_id WHERE atomic_number = $1")
      ELE_MELT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $1")
      ELE_BOIL=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $1")

      echo "The element with atomic number $(echo $ATOMIC_NUMBER | sed -r 's/^ *| *$//g') is $(echo $ELE_NAME | sed -r 's/^ *| *$//g') ($(echo $ELE_SYMBOL | sed -r 's/^ *| *$//g')). It's a $(echo $ELE_TYPE | sed -r 's/^ *| *$//g'), with a mass of $(echo $ELE_MASS | sed -r 's/^ *| *$//g') amu. $(echo $ELE_NAME | sed -r 's/^ *| *$//g') has a melting point of $(echo $ELE_MELT | sed -r 's/^ *| *$//g') celsius and a boiling point of $(echo $ELE_BOIL | sed -r 's/^ *| *$//g') celsius."
      
    fi

#  BY symbol


  if [[ ! -z $ELEMENT_SYMBOL ]]
    then
      ELE_NAME=$($PSQL "SELECT name FROM elements FULL JOIN properties ON elements.atomic_number = properties.atomic_number WHERE symbol = '$1'")
      ELE_ATO=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1'")
      ELE_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ELE_ATO")
      ELE_TYPE=$($PSQL "SELECT type FROM types FULL JOIN properties ON types.type_id = properties.type_id WHERE atomic_number = $ELE_ATO")
      ELE_MELT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ELE_ATO")
      ELE_BOIL=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ELE_ATO")

      echo "The element with atomic number $(echo $ELE_ATO | sed -r 's/^ *| *$//g') is $(echo $ELE_NAME | sed -r 's/^ *| *$//g') ($(echo $ELEMENT_SYMBOL | sed -r 's/^ *| *$//g')). It's a $(echo $ELE_TYPE | sed -r 's/^ *| *$//g'), with a mass of $(echo $ELE_MASS | sed -r 's/^ *| *$//g') amu. $(echo $ELE_NAME | sed -r 's/^ *| *$//g') has a melting point of $(echo $ELE_MELT | sed -r 's/^ *| *$//g') celsius and a boiling point of $(echo $ELE_BOIL | sed -r 's/^ *| *$//g') celsius."

    fi

#  BY name


  if [[ ! -z $ELEMENT_NAME ]]
    then
      ELE_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name = '$1'")
      ELE_ATO=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$1'")
      ELE_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ELE_ATO")
      ELE_TYPE=$($PSQL "SELECT type FROM types FULL JOIN properties ON types.type_id = properties.type_id WHERE atomic_number = $ELE_ATO")
      ELE_MELT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ELE_ATO")
      ELE_BOIL=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ELE_ATO")

      echo "The element with atomic number $(echo $ELE_ATO | sed -r 's/^ *| *$//g') is $(echo $ELEMENT_NAME | sed -r 's/^ *| *$//g') ($(echo $ELE_SYMBOL | sed -r 's/^ *| *$//g')). It's a $(echo $ELE_TYPE | sed -r 's/^ *| *$//g'), with a mass of $(echo $ELE_MASS | sed -r 's/^ *| *$//g') amu. $(echo $ELEMENT_NAME | sed -r 's/^ *| *$//g') has a melting point of $(echo $ELE_MELT | sed -r 's/^ *| *$//g') celsius and a boiling point of $(echo $ELE_BOIL | sed -r 's/^ *| *$//g') celsius."
      
    fi

if [[ -z $ELEMENT_NAME && -z $ELEMENT_SYMBOL && -z $ATOMIC_NUMBER && ! -z $1 ]]
  then
   echo "I could not find that element in the database."
  fi