#FROM python:3.6
FROM ubuntu:latest
#RUN adduser -D visualdata
RUN useradd -ms /bin/bash visualdata
#support for Ubuntu
RUN apt-get update -y
RUN apt-get install -y python-pip python-dev build-essential

WORKDIR /home/visualdata

COPY requirements.txt requirements.txt
#RUN python -m venv venv
#RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install gunicorn
# install npm
#RUN apt-get install -y -qq npm
#RUN ln -s /usr/bin/nodejs /usr/bin/node
# install bower
#RUN npm install --global bower
#RUN npm install -g d3-workbench
#RUN pip install pymysql

COPY app app
COPY migrations migrations
COPY visualdata.py config.py boot.sh ./
RUN chmod a+x boot.sh

ENV FLASK_APP visualdata.py

#RUN chown -R visualdata:visualdata ./
USER visualdata

EXPOSE 8000
ENTRYPOINT ["./boot.sh"]
