defmodule MWSClient.Utils do
  @moduledoc """
  Module that holds utility functions. Can be imported.
  """

  alias MWSClient.Operation

  @doc """
  `URI.encode_query/1` explicitly does not percent-encode spaces, but Amazon requires `%20`
   instead of `+` in the query, so we essentially have to rewrite `URI.encode_query/1` and
   `URI.pair/1`.
  """
  def percent_encode_query(query_map) do
    Enum.map_join(query_map, "&", &pair/1)
  end

  @doc """
  takes a map of params, removes a key and with the values of that key,
  should it be a list, enumerates over each element in the list
  and puts them back into the map with key of "prefix.appendage.element_index"
  """
  def restructure(params, prefix, appendage) do
    {list, params} = Map.pop(params, prefix)
    Map.merge(params, numbered_params("#{prefix}.#{appendage}", list))
  end

  def add(params, options, white_list \\ []) do
    camelized_options =
      options
      |> Enum.reject(fn {key, value} -> value == nil || invalid_key?(key, white_list) end)
      |> Enum.map(fn {key, value} -> {Inflex.camelize(key), value} end)
      |> Enum.into(%{})

    Map.merge(params, camelized_options)
  end

  @doc """
  Convert all the given informatin to an `%MWSClient.Operation{}`
  """
  @spec to_operation(
          params :: map(),
          version :: String.t(),
          path :: String.t(),
          body :: nil | binary() | [],
          headers :: list()
        ) :: Operation.t()
  def to_operation(params, version, path, body \\ nil, headers \\ []) do
    %Operation{
      params: Map.merge(params, %{"Version" => version}),
      path: path,
      body: body,
      headers: headers
    }
  end

  @spec content_md5(term()) :: binary()
  def content_md5(data) do
    :erlang.md5(data) |> Base.encode64()
  end

  # See comment on `percent_encode_query/1`.
  def pair({k, v}) do
    encoded_key = URI.encode(to_string(k), &URI.char_unreserved?/1)
    encoded_value = URI.encode(to_string(v), &URI.char_unreserved?/1)

    "#{encoded_key}=#{encoded_value}"
  end

  # Helpers

  defp numbered_params(_key, nil), do: %{}

  defp numbered_params(key, list) do
    list
    |> Enum.with_index(1)
    |> Enum.reduce(%{}, fn {value, index}, acc ->
      Map.put(acc, "#{key}.#{index}", value)
    end)
  end

  defp invalid_key?(_key, []), do: false

  defp invalid_key?(key, white_list) do
    Enum.all?(white_list, &(&1 != key))
  end
end
