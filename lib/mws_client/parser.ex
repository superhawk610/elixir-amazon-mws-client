defmodule MWSClient.Parser do
  @moduledoc """
  Parse the response body based on the headers.
  """

  @doc """
  Parse the response from MWS into a usable format
  """
  @spec parse(HTTPoison.Response.t()) :: map() | list()
  def parse(%{body: body, headers: headers}) do
    case get_content_type(headers) do
      "text/xml" <> _charset ->
        XmlToMap.naive_map(body)

      "application/xml" ->
        XmlToMap.naive_map(body)

      "text/plain;charset=" <> _charset ->
        body
        |> String.split("\r\n")
        |> Stream.map(&"#{&1}\n")
        |> CSV.decode!(separator: ?\t, headers: true)
        |> Enum.to_list()
    end
  end

  # Helpers

  defp get_content_type(headers) do
    Enum.find_value(headers, fn
      {"Content-Type", value} -> value
      _ -> false
    end)
  end
end
