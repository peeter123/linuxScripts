#!/bin/bash

function print_help() {
    echo "convert.sh - convert image and audio file to mkv video"
    echo " "
    echo "convert.sh [options]"
    echo " "
    echo "options:"
    echo "-h, --help                show brief help"
    echo "-i, --image=FILE          specify an image to use"
    echo "-a, --audio=FILE          specify an action to use"
    echo "-o, --output=FILE         specify the output file"
}

while test $# -gt 0; do
        case "$1" in
                -h|--help)
                        print_help
                        exit 0
                        ;;
                -i)
                        shift
                        if test $# -gt 0; then
                                export IMAGE=$1
                        else
                                echo "no process specified"
                                exit 1
                        fi
                        shift
                        ;;
                --image*)
                        export IMAGE=`echo $1 | sed -e 's/^[^=]*=//g'`
                        shift
                        ;;
                -a)
                        shift
                        if test $# -gt 0; then
                                export AUDIO=$1
                        else
                                echo "no process specified"
                                exit 1
                        fi
                        shift
                        ;;
                --audio*)
                        export AUDIO=`echo $1 | sed -e 's/^[^=]*=//g'`
                        shift
                        ;;
                -o)
                        shift
                        if test $# -gt 0; then
                                export OUTPUT=$1
                        else
                                echo "no output dir specified"
                                exit 1
                        fi
                        shift
                        ;;
                --output*)
                        export OUTPUT=`echo $1 | sed -e 's/^[^=]*=//g'`
                        shift
                        ;;
                *)
                        break
                        ;;
        esac
done

if [[ -n "$AUDIO" && -n "$IMAGE" && -n "$OUTPUT" ]]; then
    ffmpeg -loop 1 -i $IMAGE -i $AUDIO -c:v libx264 -tune stillimage -c:a mp3 -strict experimental -b:a 192k -pix_fmt yuv420p -shortest $OUTPUT
else
    print_help
fi
