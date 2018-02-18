#================================================================================
# BUILD IMAGE
#================================================================================
FROM elixir:1.5.3 as build

ENV HOME=/app
ENV MIX_ENV=prod REPLACE_OS_VARS=true SHELL=/bin/bash

RUN mix local.hex --force && \
    mix local.rebar --force

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs

WORKDIR /app

# Cache elixir deps.
COPY mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

# Cache node deps.
RUN mkdir assets
COPY assets/package.json assets/package-lock.json ./assets/
RUN cd assets && npm install

COPY . .

# Build and digest static assets
RUN cd assets && ./node_modules/brunch/bin/brunch b -p && \
    cd .. && mix phx.digest

RUN mix release --env=prod

#================================================================================
# RUN IMAGE
#================================================================================
FROM elixir:1.5.3 as run

ENV HOME=/app
ENV MIX_ENV=prod REPLACE_OS_VARS=true SHELL=/bin/bash

WORKDIR /app

COPY --from=build /app/_build/prod/rel/shovik_com .

ENTRYPOINT ["/app/bin/shovik_com"]
