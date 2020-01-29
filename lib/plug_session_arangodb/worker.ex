defmodule PlugSessionArangodb.Worker do
  def start_link(name) do
    config = Application.get_env(:arangox, :session, [])
    {:ok, client} = Arangox.start_link(client: Arangox.MintClient, endpoints: config[:endpoints], username: config[:username], password: config[:password], database: config[:database], pool_size: 3)
    true = Process.register(client, name)
    {:ok, client}
  end

  def get(sid) do
    {:ok, _request, response} = Arangox.put(pid(), "/_api/simple/first-example", %{ "collection" => "sessions", "example" => %{ "session_id": sid }})

    { sid, response.body["document"]["session_data"] }
  end

  def create(data) do
    {:ok, _request, response} = Arangox.post(pid(), "/_api/document/sessions", %{ "session_data": data })

    session_id = :crypto.hash(:md5, response.body["_key"]) |> Base.encode16(case: :upper)
    {:ok, _request, _response} = Arangox.patch(pid(), "/_api/document/sessions/" <> response.body["_key"], %{ "session_id": session_id })

    session_id
  end

  def update(sid, data) do
    {:ok, _request, response} = Arangox.put(pid(), "/_api/simple/first-example", %{ "collection" => "sessions", "example" => %{ "session_id": sid }})

    {:ok, _request, _response} = Arangox.put(pid(), "/_api/document/sessions/" <> response.body["document"]["_key"], %{ "session_id": sid, "session_data": data })

    sid
  end

  def remove(sid) do
    {:ok, _request, response} = Arangox.put(pid(), "/_api/simple/first-example", %{ "collection" => "sessions", "example" => %{ "session_id": sid }})

    {:ok, _request, _response} = Arangox.delete(pid(), "/_api/document/sessions/" <> response.body["document"]["_key"])
    :ok
  end

  def pid do
    :phoenix_session_arangodb
  end
end
