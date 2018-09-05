FROM python:3.6-alpine3.7

RUN adduser -D visualdata


#for Plotly
#RUN echo "http://dl-8.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
#RUN apk --no-cache --update-cache add gcc gfortran python python-dev py-pip build-base wget freetype-dev libpng-dev openblas-dev
#RUN ln -s /usr/include/locale.h /usr/include/xlocale.h
#RUN apk --no-cache add --virtual .builddeps gcc gfortran musl-dev     && pip install numpy==1.14.0 && pip install pandas && pip install plotly  && apk del .builddeps     && rm -rf /root/.cache

WORKDIR /home/visualdata

COPY requirements.txt requirements.txt
#RUN python -m venv venv
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install gunicorn
#RUN venv/bin/pip install install python3-pymysql

COPY app app
COPY migrations migrations
COPY visualdata.py config.py boot.sh ./
RUN chmod a+x boot.sh

ENV FLASK_APP visualdata.py

#RUN chown -R visualdata:visualdata ./
#USER visualdata

EXPOSE 8000
ENTRYPOINT ["./boot.sh"]
