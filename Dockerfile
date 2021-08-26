ARG ELIXIR_VER

FROM hexpm/elixir:$ELIXIR_VER

ARG PHOENIX_VER
ARG APP_HOME
ARG LOCAL_USER
ARG EXP_PORT

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

RUN apt-get update \
    && apt-get -y install sudo \
    && apt-get -y install curl \
    && apt-get -y install apt-utils \
    && apt-get -y install inotify-tools \
    && apt-get -y install build-essential

RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - \
    && sudo apt-get install -y nodejs

RUN useradd -ms /bin/bash $LOCAL_USER -u 1000 -U
USER $LOCAL_USER

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install hex phx_new $PHOENIX_VER --force

EXPOSE $EXP_PORT