FROM python:3.8-slim
ARG port

USER root
COPY . /moppp
WORKDIR /moppp

ENV PORT=$port

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils \
    && apt-get -y install curl \
    && apt-get install libgomp1

RUN chgrp -R 0 /moppp \
    && chmod -R g=u /moppp \
    && pip install pip --upgrade \
    && pip install -r requirements.txt
EXPOSE $PORT

CMD gunicorn api:server --bind 0.0.0.0:$PORT --preload
