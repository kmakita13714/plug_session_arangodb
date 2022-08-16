defmodule PlugSessionArangodb.Worker do
  def start_link(name) do
    config = Application.get_env(:arangox, :session, [])
    {:ok, client} = Arangox.start_link(client: Arangox.MintClient, endpoints: config[:endpoints], username: config[:username], password: config[:password], database: config[:database], pool_size: config[:pool_size])
    true = Process.register(client, name)

    case Arangox.get(pid(), "/_api/collection/" <> config[:collection]) do
      {:error, error} ->
        {:ok, response} = Arangox.post(pid(), "/_api/collection", %{ "name" => config[:collection], "keyOptions" => %{ "type" => "uuid" }})
      _ ->
        nil
    end

    {:ok, client}
  end

  def get(sid) do
    IO.inspect("get")
    IO.inspect(sid)
    config = Application.get_env(:arangox, :session, [])

    {:ok, response} = Arangox.get(pid(), "/_db/" <> config[:database] <> "/_api/document/" <> config[:collection] <> "/" <> sid)
    IO.inspect(response)

    { sid, response.body["session_data"] }
  end

  def create(data) do
    IO.inspect("create")
    IO.inspect(data)
    config = Application.get_env(:arangox, :session, [])

    {:ok, response} = Arangox.post(pid(), "/_db/" <> config[:database] <> "/_api/document/" <> config[:collection], %{ "session_data": data })
    IO.inspect(response)

    response.body["_key"]
  end

  def update(sid, data) do
    IO.inspect("update")
    IO.inspect(sid)
    IO.inspect(data)
    config = Application.get_env(:arangox, :session, [])

    {:ok, response} = Arangox.put(pid(), "/_db/" <> config[:database] <> "/_api/document/" <> config[:collection] <> "/" <> sid, %{ "session_data": data })
    IO.inspect(response)

    sid
  end

  def remove(sid) do
    IO.inspect("remove")
    IO.inspect(sid)
    config = Application.get_env(:arangox, :session, [])

    {:ok, response} = Arangox.delete(pid(), "/_db/" <> config[:database] <> "/_api/document/" <> config[:collection] <> "/" <> sid)
    IO.inspect(response)

    :ok
  end

  def pid do
    :phoenix_session_arangodb
  end
end
