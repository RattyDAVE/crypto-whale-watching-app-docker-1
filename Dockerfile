FROM python:3.6.5-slim

# setup virtual env vars
ENV VIRTUAL_ENV=/opt/crypto_app

# create python virtual env
RUN python3 -m venv $VIRTUAL_ENV

# set path
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# update/upgrade and install git
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
    git-all

# make active dir for git install
WORKDIR $VIRTUAL_ENV

# clone pmaji/crypto-whale-watching-app repo
#RUN git clone --branch feature/css https://github.com/Netmonster/crypto-whale-watching-app-docker crypto-whale-watching-app
# https://github.com/pmaji/crypto-whale-watching-app.git

# Dev stuff
RUN mkdir ${VIRTUAL_ENV}/crypto-whale-watching-app

# set new working dir to 
WORKDIR ${VIRTUAL_ENV}/crypto-whale-watching-app

# install dependencies:

ADD . ${VIRTUAL_ENV}/crypto-whale-watching-app/
RUN pip install -r requirements.txt

# run the application:
CMD ["python", "app.py"]