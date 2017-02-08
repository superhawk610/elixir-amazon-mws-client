defmodule MWSClient do

  use HTTPoison.Base

  alias MWSClient.Config
  alias MWSClient.Operation
  alias MWSClient.Request
  alias MWSClient.Products
  alias MWSClient.Feed
  alias MWSClient.Subscriptions
  alias MWSClient.Orders

  @default_opts [marketplace_id: "ATVPDKIKX0DER"]

  # TODO: make wrappers for all calls here

  ### FEEDS
  def submit_product_feed(data, config = %Config{}, opts \\ [marketplace_id: "ATVPDKIKX0DER",
                                                             purge_and_replace: false]) do
    template_opts = %{seller_id: config.seller_id, purge_and_replace: opts[:purge_and_replace]}
    xml = TemplateBuilder.submit_product_feed(data, template_opts)
    Feed.submit_product_feed(xml, opts)
    |> request(config)
  end

  def submit_product_by_asin(data, config = %Config{}, opts \\ [marketplace_id: "ATVPDKIKX0DER",
                                                             purge_and_replace: false]) do
    template_opts = [seller_id: config.seller_id,
                     purge_and_replace: opts[:purge_and_replace],
                     sku: data.sku, asin: data.asin]
    TemplateBuilder.submit_product_by_asin(template_opts)
    |> Feed.submit_product_feed(opts)
    |> request(config)
  end

  def submit_price_feed(data, config = %Config{}, opts \\ @default_opts) do
    xml = TemplateBuilder.submit_price_feed(data, config)
    Feed.submit_price_feed(xml, opts)
    |> request(config)
  end

  def submit_inventory_feed(data, config = %Config{}, opts \\ @default_opts) do
    xml = TemplateBuilder.submit_inventory_feed(data, config)
    Feed.submit_inventory_feed(xml, opts)
    |> request(config)
  end

  def get_feed_submission_result(feed_id, config = %Config{}, opts \\ @default_opts) do
    Feed.get_feed_submission_result(feed_id, opts)
    |> request(config)
  end

  ### FEEDS

  ### PRODUCTS

  def list_matching_products(query, config = %Config{}, opts \\@default_opts) do
    Products.list_matching_products(query, opts)
    |> request(config)
  end

  def get_product_by_asin(asin, config = %Config{}, opts \\ @default_opts) do
    Products.get_matching_product(asin, opts)
    |> request(config)
  end

  def get_product_categories_for_asin(asin, config = %Config{}, opts \\ @default_opts) do
    Products.get_product_categories_for_asin(asin, opts)
    |> request(config)
  end

  ### PRODUCTS

  ### SUBSCRIPTIONS
  def subscribe_to_sqs(url, config = %Config{}, opts \\ @default_opts) do
    Subscriptions.register_destination(url, opts)
    |> request(config)
  end
  ### SUBSCRIPTIONS

  ### ORDERS
  @default_prms [fulfillment_channel: [], payment_method: [],
                  order_status: [], buyer_email: nil, seller_order_id: nil]

  # `last_updated_after' is a string that should be formatted like: "%Y-%m-%dT%H:%M:%SZ"
  @dafeult_last_updated_after  Timex.beginning_of_month(DateTime.utc_now)
                               |> Timex.format("%Y-%m-%dT%H:%M:%SZ", :strftime)
                               |> elem(1)

  def list_orders(params \\ @default_prms,
                  last_updated_after \\ @dafeult_last_updated_after,
                  config = %Config{}, opts \\ [marketplace_id: ["ATVPDKIKX0DER"]]) do
    Orders.list_orders(params, last_updated_after, opts)
    |> request(config)
  end
  ### ORDERS

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
      {:error, err} -> raise MWSClient.RequestError, message: inspect(err)
    end
  end
end
