# ShovikCom

Alex Kovshovik's website, deployed at https://shovik.com

### Run website locally

  - Install dependencies with `mix deps.get`
  - Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  - Install Node.js dependencies with `cd assets && npm install`
  - Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

### Deployment

The easiest way to deploy this website is to build a Docker image:

  - `docker build -t shovik_com:latest .`
  - `docker run --rm -it shovik_com:latest foreground`
  - Docker run requires a few environment variables to run: see Alex's Rancher configuration.

Built using Elixir and Phoenix Framework.

## Learn more

  - Official website: http://www.phoenixframework.org/
  - Guides: http://phoenixframework.org/docs/overview
  - Docs: https://hexdocs.pm/phoenix
  - Mailing list: http://groups.google.com/group/phoenix-talk
  - Source: https://github.com/phoenixframework/phoenix
