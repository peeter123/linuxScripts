#!/bin/bash
export sdate=$1

if [[ -z "$@" ]]; then
    echo >&2 "You must supply an argument!"
    echo >&2 "Usage suspend.sh \"time in words\" see php date"
    exit 1
fi

echo "---MARK: `date +%d-%m-%Y`---"

# Get root
sudo killall -qw rtcwake

date=`/usr/bin/php << 'EOF'
<?php
$date = strtotime(GETENV("sdate"));
echo "\r".$date;
EOF`

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
