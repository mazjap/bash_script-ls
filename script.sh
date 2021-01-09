#!/bin/bash

# Supports 'l' and 'a' flags to list files with new lines and to show all files 

# Variables
file1=file1.txt
output=script_log.txt

touch $file1

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
    echo "Flags are required. Try running 'sh ${0} -af'"
    exit 1 # Remove after submitting assignment
else
    for (( i=0 ; i<=${#1} ; i++ )); do
        char=${1:i:i}
        if [[ ${char} != "-" ]]; then
            flags+=${char}
        fi
    done
fi

echo "Running ${0}" # Remove
log "running script with flag(s) ${flags}"

# Application Start

echo "Enter username:" && read username # Take username as arg[2]
echo "Enter password:" && read password # Prompt pass if username is valid

if [[ ${username} == "" ]] || [[ $password == "" ]]; then
    echo "The entered Username and/or Password was empty. Please try again."
    log "User's password or username was empty"
    exit 1
fi

# Validate username and pass

isValid=false

for (( i=0 ; i<=${#users} ; i++ )); do
    pass="$users[username]"
    if [[ ${username} == ${users:i:i} ]] && [[ ${password} == pass ]]; then
        isValid=true
        break
    fi
done


if [[ $isValid==true ]]; then
    echo "Welcome ${username}"
    log "User ${username} logged in successfully."
else
    echo "You done foffed up, ${username}. Better dip before things get hairy."
    log "Username ${username} was incorrect, user was threatened and refused access."
    exit 1
fi

if [[ "${flags[@]}" =~ "a" ]]; then
    shopt -s dotglob
fi

if [[ "${flags[@]}" =~ "l" ]]; then
    for file in *; do
        echo `basename "$file"`
    done
else
    text=""
    for file in *; do
        text+=" `basename "$file"`"
    done

    echo $text
fi


# To meet assignment requirements

# Create logs directory and change directory
mkdir logs
cd logs

# Move log file from base to logs directory
mv "../$output" $output

# Append text to log file
echo "Adding text" >> "../$file1"
log "file was moved to new directory"

# Print working directory
echo $PWD

mv "$output" "../$output"
log "file was moved back to prev directory"
cd ../

rm -rf logs
log "remove logs directory"

# Make TXT directory
TXT="TXT"

if [[ ! -d "$TXT" ]]; then
    mkdir $TXT
fi

cd $TXT

# Move files to TXT directory
cat "../${file1}" >> $file1
cat "../${output}" >> $output

rm "../${file1}"
rm "../${output}"

echo $PWD

echo "Script finished. If variable 1 and variable 2 are in TXT folder you passed"