FROM hexpm/elixir:1.12.2-erlang-24.0.5-ubuntu-xenial-20210114

ARG APP_HOME
ARG LOCAL_USER
ARG EXP_PORT

RUN mkdir $APP_HOME

WORKDIR $APP_HOME

RUN apt-get update \
    && apt-get -y install sudo \
    && apt-get -y install curl \
    && apt-get -y install apt-utils \
    && apt-get -y install inotify-tools

RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - \
    && sudo apt-get install -y nodejs

RUN useradd -ms /bin/bash $LOCAL_USER -u 1000 -U
USER $LOCAL_USER

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install hex phx_new 1.5.12 --force

EXPOSE $EXP_PORT