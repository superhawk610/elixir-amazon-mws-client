defmodule MWSClient.Parser do

  @moduledoc """
  Get back an enumerator based on the headers
  """

  def parse(%{body: body, headers: headers, status_code: status_code}) do
    resp = case get_content_type(headers) do
      "text/xml" -> XmlToMap.naive_map(body)
      "text/plain;charset=" <> _charset ->
        body |> String.split("\r\n") |> CSV.decode(separator: ?\t, headers: true)
    end
    wrap_response(status_code, resp)
  end

  defp get_content_type(headers) do
    Enum.find_value headers, fn
      {"Content-Type", value} -> value
      _ -> false
    end
  end

  defp wrap_response(status_code, resp) do
    if status_code in [200, 201] do
      {:success, resp}
    else
      {:error, resp}
    end
  end

end