FROM python:3.10.8-slim-buster

RUN mkdir -p /usr/src/tdd
WORKDIR /usr/src/tdd

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1 

RUN apt-get update \
  && apt-get -y install netcat gcc \
  && apt-get clean

COPY pyproject.toml .
COPY poetry.lock .
RUN pip install --upgrade pip
RUN pip install poetry==1.3.2
RUN poetry install --no-root
# add app
COPY . .

COPY ./entrypoint.sh .
RUN chmod +x /usr/src/tdd/entrypoint.sh

ENTRYPOINT ["/usr/src/tdd/entrypoint.sh"]