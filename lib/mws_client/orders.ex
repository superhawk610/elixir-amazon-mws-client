defmodule MWSClient.Orders do

  @moduledoc """
  Get orders from the Amazon MWS
  """

  alias MWSClient.Utils
  use Timex

  @version "2013-09-01"
  @path "/Orders/#{@version}"

  def list_orders(params, last_updated_after, opts) do

    %{"Action" => "ListOrders",
      "LastUpdatedAfter" => last_updated_after}
    |> Utils.add(params, [:fulfillment_channel, :payment_method, :order_status,
                          :last_updated_after, :buyer_email, :seller_order_id])
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
