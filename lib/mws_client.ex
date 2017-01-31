defmodule MWSClient do
  use HTTPoison.Base

  alias MWSClient.Config
  alias MWSClient.Operation
  alias MWSClient.Request

  def request(operation = %Operation{}, config = %Config{}) do
    uri = Request.to_uri(operation, config)
    case post(uri, uri.query) do
      {:ok, resp} -> MWSClient.Parser.parse(resp)
      {:error, err} -> raise RequestError, message: inspect(err)
    end
  end
end
