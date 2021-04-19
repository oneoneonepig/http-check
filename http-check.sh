#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
REGEX_INT='^[0-9]+$'

WEBSITE=$1
INTERVAL=0.5

if [[ -z $WEBSITE ]]; then
        echo "Please provide an URL as parameter"
        echo "Example: $0 https://google.com"
        exit
fi

echo -e "Now testing $WEBSITE every $INTERVAL second(s)..."

while true
do
        HTTP_CODE=$(curl -s -L -w %{http_code} -o /dev/null -m $INTERVAL $WEBSITE)
        if ! [[ $HTTP_CODE =~ $REGEX_INT ]]; then
                echo $HTTP_CODE
                break
        elif [[ $HTTP_CODE ]]; then
                echo -e -n "${GREEN}O${NC}"
        else
                echo -e -n "${RED}X${NC}"
        fi
        sleep $INTERVAL
done
