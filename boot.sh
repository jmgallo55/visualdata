#!/bin/sh
# this script is used to boot a Docker container
#source venv/bin/activate
flask db upgrade
#while true; do
#    flask db upgrade
#    if [[ "$?" == "0" ]]; then
#        break
#    fi
#    echo Deploy command failed, retrying in 5 secs...
#    sleep 5
#done
flask translate compile
exec gunicorn -b :8000 --access-logfile - --error-logfile - visualdata:app
