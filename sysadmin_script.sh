#!/bin/bash

# A simple script with some common addministrative tasks using "bash menus"

PS3="Select a task: "  
select ITEM in "Add User" "List all Processes" "Kill Process" "Install Program" "Quit"
do

if [[ $REPLY -eq 1 ]]
then
    read -p "Enter the username: " username
    output="$( grep -w $username /etc/passwd )"
    if [[ -n "$output" ]]
    then
        echo "$username username already exists."
    else
        sudo useradd -m -s /bin/bash "$username"
        if [[ $? -eq 0 ]]
        then
            echo "The user $username was added successfully" 
            tail -n 1 /etc/passwd
        else
            echo "There was an error adding the user $username."
        fi
    fi

elif [[ $REPLY -eq 2 ]] 
then
    echo "Listing all Processess..."
    sleep 2
    ps -ef

elif [[ $REPLY -eq 3 ]] 
then
    read -p "Enter Process to Kill: " process
    pkill $process

elif [[ $REPLY -eq 4 ]]
then
    read -p "Enter the program to install: " program
    sudo apt update && sudo apt install $program

elif [[ $REPLY -eq 5 ]]
then
    echo "Quitting..."
    sleep 2
    exit

else
    echo "Invalid menu selection" 
fi

done
