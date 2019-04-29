defmodule Segment.Server do
  @moduledoc """
  Provides the api for sending data to Segment.io.

  All functions are implemented as Genserver casts so that they are out-of-band
  for clients.
  """

  use GenServer
  alias Segment.{Track, Identify, Screen, Alias, Group, Page, Context}

  require Logger

  @adapter Application.get_env(:segment, :http_adapter) || Segment.HTTP.HTTPoison

  def start_link(args) do
    GenServer.start_link(__MODULE__, args, name: __MODULE__)
  end

  def send_track(t = %Track{}) do
    send(t)
  end

  def send_track(user_id, event, properties \\ %{}, context \\ Context.new()) do
    t = %Track{userId: user_id, event: event, properties: properties, context: context}
    send_track(t)
  end

  def send_identify(i = %Identify{}) do
    send(i)
  end

  def send_identify(user_id, traits \\ %{}, context \\ Context.new()) do
    i = %Identify{userId: user_id, traits: traits, context: context}
    send_identify(i)
  end

  def send_screen(s = %Screen{}) do
    send(s)
  end

  def send_screen(user_id, name \\ "", properties \\ %{}, context \\ Context.new()) do
    s = %Screen{userId: user_id, name: name, properties: properties, context: context}
    send_screen(s)
  end

  def send_alias(a = %Alias{}) do
    send(a)
  end

  def send_alias(user_id, previous_id, context \\ Context.new()) do
    a = %Alias{userId: user_id, previousId: previous_id, context: context}
    send_alias(a)
  end

  def send_group(g = %Group{}) do
    send(g)
  end

  def send_group(user_id, group_id, traits \\ %{}, context \\ Context.new()) do
    g = %Group{userId: user_id, groupId: group_id, traits: traits, context: context}
    send_group(g)
  end

  def send_page(p = %Page{}) do
    send(p)
  end

  def send_page(user_id, name \\ "", properties \\ %{}, context \\ Context.new()) do
    p = %Page{userId: user_id, name: name, properties: properties, context: context}
    send_page(p)
  end

  defp send(event) do
    GenServer.cast(__MODULE__, event)
  end

  def handle_cast(event, state) do
    resp =
      @adapter.post!(
        event.method,
        Poison.encode!(event),
        [],
        ssl: [{:versions, [:"tlsv1.2"]}]
      )

    Logger.debug(fn -> "#{inspect(resp)}" end)
    {:noreply, state}
  end
end
