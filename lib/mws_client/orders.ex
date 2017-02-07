defmodule MWSClient.Orders do

  @moduledoc """
  Get orders from the Amazon MWS
  """

  alias MWSClient.Utils
  use Timex

  @version "2013-09-01"
  @path "/Orders/#{@version}"
  # default_market should be specified as List
  @default_market ["ATVPDKIKX0DER"]

  @prms [fulfillment_channel: [], payment_method: [],
         order_status: [], buyer_email: nil, seller_order_id: nil]

  # `last_updated_after' is a string that should be formatted like: "%Y-%m-%dT%H:%M:%SZ"
  @last_updated_after Timex.beginning_of_month(DateTime.utc_now)
                      |> Timex.format("%Y-%m-%dT%H:%M:%SZ", :strftime)
                      |> elem(1)

  def list_orders(params \\ @prms,
                  last_updated_after \\ @last_updated_after,
                  opts \\ [marketplace_id: @default_market]) do

    %{"Action" => "ListOrders",
      "LastUpdatedAfter" => last_updated_after}
    |> Utils.add(params, [:fulfillment_channel, :payment_method, :order_status,
                          :last_updated_after, :buyer_email, :order_status, :seller_order_id])
    |> Utils.add(opts, [:marketplace_id])
    |> Utils.restructure("MarketplaceId", "Id")
    |> Utils.restructure("FulfillmentChannel", "Channel")
    |> Utils.restructure("PaymentMethod", "Method")
    |> Utils.restructure("OrderStatus", "Status")
    |> Utils.to_operation(@version, @path)
  end

  def list_order_items(_order_id) do
    raise "Not implemented"
  end

  def get_order(_order_id) do
    raise "Not implemented"
  end
end
