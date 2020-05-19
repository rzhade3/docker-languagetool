#!/bin/bash

LANGUAGE=$1 # Specified language in workflow file
FILEPATH=$2 # filepath specified in workflow file

# Since the cloned repo is in the workspace directory, need to get a path there
PATH_IN_CONTAINER="$GITHUB_WORKSPACE/$FILEPATH"
LOGFILE="$(date +%s).txt"

java -jar /LanguageTool/languagetool-commandline.jar -l $1 --json $PATH_IN_CONTAINER >> $LOGFILE
python3 /parse_log.py $FILEPATH $LOGFILE
