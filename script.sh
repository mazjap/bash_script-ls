#!/bin/bash

# Variables
file1=file1.txt
output=script_log.txt

users=( ["jordan"]="12345" ["steve"]="54321" ["abc"]="123" ["1"]="1" )

# Functions

log() {
    date=`date +%m-%d-%Y_%I:%M:%r`
    echo "${date} ${1}" >> ${output}
}

# Setup

log "${0} was run"

flags=()

if [[ -z $1 ]]; then
    echo "No args added"
    exit 1
else
    for (( i=0 ; i<=${#1} ; i++ )); do
        char=${1:i:i}
        if [[ ${char} != "-" ]]; then
            flags+=${char}
        fi
    done
fi

log "running script with flag(s) ${flags}"

# Application Start

echo "Enter username:" && read username
echo "Enter password:" && read password

if [[ ${username} == "" ]] || [[ $password == "" ]]; then
    echo "The entered Username and/or Password was empty. Please try again."
    log "User's password or username was empty"
    exit 1
fi

# Validate username and pass

isValid=0

for (( i=0 ; i<=${#users} ; i++ )); do
    pass="$users[username]"
    if [[ ${username} == ${users:i:i} ]] && [[ ${password} == pass ]]; then
        isValid=1
    fi
done


if isValid==1; then
    echo "Welcome ${username}"
    log "User ${username} logged in successfully."
else
    echo "You done foffed up, ${username}. Better dip before things get hairy."
    log "Username ${username} was incorrect, user was threatened and refused access."
    exit 1
fi


for file in *; do
    echo `basename "$file"`
done

if [[ "${flags[@]}" =~ "a" ]]; then
    find "." -path '.*' -print
fi