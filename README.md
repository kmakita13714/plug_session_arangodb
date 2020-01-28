# PlugSessionArangodb

The ArangoDB Plug.Session adapter for the Phoenix framework.

## Usage

```elixir
# mix.exs
defp deps do
  [{:plug_session_arangodb, "~> 0.1.0" }]
end
```

## config.exs

```elixir
config :arangox, :session,
  endpoints: "http://localhost:8529",
  username: "username",
  password: "password",
  database: "database"
```

## endpoint.ex  

```elixir
plug Plug.Session,
  store: :arangodb
```
