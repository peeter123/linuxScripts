#!/bin/bash
export sdate=$1

if [[ -z "$@" ]]; then
    echo >&2 "You must supply an argument!"
    echo >&2 "Usage suspend.sh \"time(see php date)\""
    exit 1
fi

date=`/usr/bin/php << 'EOF'
<?php
$date = strtotime(GETENV("sdate"));
echo "\r".$date;
EOF`

# Check if a valid date has been supplied
if ! [[ "$date" = *[[:digit:]]* ]]; then
    echo >&2 "Invalid date supplied"
    exit 1
fi

# Get root
sudo killall -qw rtcwake

echo "---MARK: `date +%d-%m-%Y`---"

# Set the alarm to wake-up the system
echo "[`date +%H:%M:%S`] `sudo rtcwake -d rtc0 -m no -t $date`"

# Feedback
echo "[`date +%H:%M:%S`] Resuming at:"
echo "[`date +%H:%M:%S`] `sudo rtcwake -m show`"

# Give rtcwake some time to make its stuff
sleep 1

# More feedback
echo "[`date +%H:%M:%S`] Suspending now..."

# Suspend
sudo pm-suspend

# Any commands you want to launch after wakeup can be placed here
# Remember: sudo may have expired by now
echo "[`date +%H:%M:%S`] Good morning!"
