#!/bin/bash
# Error codes
ARGUMENT_NOT_DIRECTORY=10
FILE_NOT_FOUND=11
# Check that the argument passed to this script is a directory.
# If it's not, then exit with an error code.
if [ ! -d "$1" ]
then
    echo -e "\e[1;37mArg "$1" is NOT a directory!\e[0m"
    exit $ARGUMENT_NOT_DIRECTORY
fi
# Count the number of mp3 files in this directory.
mp3num=`ls "$1" | grep -c \\.mp3`
# If no mp3 files are found in this directory,
# then exit without error.
if [ $mp3num -lt 1 ]
then
    echo -e "\e[1;36m"$1" \e[1;37m--> (No mp3 files found)\e[0m"
    exit 0
else
    echo -e "\e[1;36m"$1" \e[1;37m--> (\e[1;32m"$mp3num"\e[1;37m mp3 files)\e[0m"
fi
# Run mp3gain on the mp3 files in this directory.
echo -e ""
echo -e "\e[1;37mForcing (re)calculation of Replay Gain values for mp3 files and adding them as APE2 tags into the mp3 file...\e[0m"
echo -e ""
# add fresh APE tags back into the files -a for album -r for track and -k to prevent clipping
mp3gain -p -a -r -k "$1"/*.mp3
echo -e ""
echo -e "\e[1;37mDone.\e[0m"
echo -e ""
echo -e "\e[1;37mAdding ID3 tags with the same calculated info from above...\e[0m"
echo -e ""
# the -d is for debug messages if there are any errors
./ape2id3.py "$1"/*.mp3
echo -e ""
echo -e "\e[1;37mDone.\e[0m"
echo -e ""
echo -e "\e[1;37mReplay gain tags (both APE and ID3) successfully added recursively.\e[0m"
echo -e ""
