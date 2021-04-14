# pull the official base image
#FROM python:3.6-alpine

FROM python:3.6.8-alpine3.8

# set work directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install dependencies
RUN apk add --update alpine-sdk && apk add libffi-dev openssl-dev
RUN pip install --upgrade pip 

#RUN apk add --no-cache build-essential libssl-dev libffi-dev python-dev
#RUN pip install --upgrade pip setuptools wheel

COPY ./requirements.txt /usr/src/app
RUN pip install -r requirements.txt
#RUN pip install --upgrade pip 

# copy project
COPY . /usr/src/app

EXPOSE 8000
CMD ["python", "manage.py", "makemigrations"]
CMD ["python", "manage.py", "migrate"]
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
