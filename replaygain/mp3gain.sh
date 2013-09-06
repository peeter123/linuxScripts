#!/bin/bash
# Define error codes
ARGUMENT_NOT_DIRECTORY=10
FILE_NOT_FOUND=11
# Check that the argument passed to this script is a directory.
# If it's not, then exit with an error code.
if [ ! -d "$1" ]
then
    echo -e "\e[1;37;44m Arg "$1" is NOT a directory!\e[0m"
    exit $ARGUMENT_NOT_DIRECTORY
fi

echo -e "\e[1;37m********************************************************\e[0m"
echo -e "\e[1;37mCalling tag-mp3-with-rg.sh on each directory in:\e[0m"
echo -e "\e[1;36m"$1"\e[0m"
echo ""
find "$1" -type d -exec ./tag-mp3-with-rg.sh '{}' \;

