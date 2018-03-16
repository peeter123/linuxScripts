#!/bin/bash
export sdate=$1

if [[ -z "$@" ]]; then
    echo >&2 "You must supply an argument!"
    echo >&2 "Usage shutdown.sh \"time(see php date)\""
    exit 1
fi

date=`/usr/bin/php << 'EOF'
<?php
$date = strtotime(GETENV("sdate"));
echo "\r".$date;
EOF`

# Check if a valid date has been supplied
if ! [[ "$date" = *[[:digit:]]* ]]; then
    echo >&2 "[`date +%H:%M:%S`] Invalid date supplied"
    exit 1
fi

# Get root
sudo killall -qw rtcwake

echo "---MARK: `date +%d-%m-%Y`---"

# Set the alarm to wake-up the system
echo "[`date +%H:%M:%S`] `sudo rtcwake -d rtc0 -m no -t $date`"

# Check if a valid date has been supplied
if [[ "`sudo rtcwake -m show`" == "alarm: off" ]]; then
    echo >&2 "[`date +%H:%M:%S`] Invalid date supplied"
    exit 1
fi

# Feedback
echo -e "[`date +%H:%M:%S`] Booting at:\n           `sudo rtcwake -m show` UTC"

# Give rtcwake some time to make its stuff
sleep 1

# More feedback
echo "[`date +%H:%M:%S`] Shutting down now..."

# Suspend
sudo shutdown -h now
