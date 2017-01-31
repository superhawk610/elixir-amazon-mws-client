defmodule MWSClient do

  use HTTPoison.Base

  alias MWSClient.Config
  alias MWSClient.Operation
  alias MWSClient.Request
  alias MWSClient.Feed

  @default_market "ATVPDKIKX0DER"

  # TODO: make wrappers for all calls here

  def submit_product_feed(data, config = %Config{}, opts \\ [marketplace_id: @default_market,
                                                             purge_and_replace: false]) do
    xml = TemplateBuilder.template_for("submit_product_feed", data)
    Feed.submit_product_feed(xml, opts)
    |> request(config)
  end

  def request(operation = %Operation{}, config = %Config{}) do
    uri = Request.to_uri(operation, config)

    {status, response} = if operation.body do
      post(uri, operation.body, operation.headers)
    else
      post(uri, uri.query, operation.headers)
    end
    parse_response({status, response})
  end

  defp parse_response({status, response}) do
    case {status, response} do
      {:ok, resp} -> MWSClient.Parser.parse(resp)
      {:error, err} -> raise RequestError, message: inspect(err)
    end
  end
end
