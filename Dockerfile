FROM python:3.6-alpine

RUN adduser -D visualdata

RUN pip install --upgrade pip

WORKDIR /home/visualdata

COPY requirements.txt requirements.txt
RUN python -m venv venv
RUN venv/bin/pip install -r requirements.txt
RUN venv/bin/pip install gunicorn
#RUN venv/bin/pip install install python3-pymysql

COPY app app
COPY migrations migrations
COPY visualdata.py config.py boot.sh ./
RUN chmod a+x boot.sh

ENV FLASK_APP visualdata.py

RUN chown -R visualdata:visualdata ./
USER visualdata

EXPOSE 8000
ENTRYPOINT ["./boot.sh"]
