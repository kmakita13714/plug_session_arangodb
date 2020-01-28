defmodule Plug.Session.ARANGODB do
  import PlugSessionArangodb.Worker

  @behaviour Plug.Session.Store


  def init(opts) do
    opts
  end


  def get(_conn, sid, _init_options) do
    get(sid)
  end

  def put(_conn, nil, data, _init_options) do
    create(data)
  end

  def put(_conn, sid, data, _init_options) do
    update(sid, data)
  end

  def delete(_conn, sid, _init_options) do
    remove(sid)
  end
end
