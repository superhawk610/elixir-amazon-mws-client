defmodule MWSClient.Orders do

  @moduledoc """
  Get orders from the Amazon MWS
  """

  alias MWSClient.Utils
  use Timex

  @version "2013-09-01"
  @path "/Orders/#{@version}"

  def list_orders(params, opts) do

    %{"Action" => "ListOrders"}
    |> Utils.add(params, [:created_after, :created_before, :last_updated_after, :last_updated_before,
                          :order_status, :fulfillment_channel, :payment_method, :buyer_email,
                          :seller_order_id, :max_results_per_page, :tfm_shipment_status])
    |> Utils.add(opts, [:marketplace_id])
    |> Utils.restructure("MarketplaceId", "Id")
    |> Utils.restructure("FulfillmentChannel", "Channel")
    |> Utils.restructure("PaymentMethod", "Method")
    |> Utils.restructure("OrderStatus", "Status")
    |> Utils.to_operation(@version, @path)
  end

  def list_order_items(order_id, opts) do
    %{"Action" => "ListOrderItems",
      "AmazonOrderId" => order_id}
    |> Utils.add(opts, [:marketplace_id])
    |> Utils.to_operation(@version, @path)
  end

  def get_order(order_id, opts) do
    %{"Action" => "GetOrder",
      "AmazonOrderId" => order_id}
    |> Utils.add(opts, [:marketplace_id])
    |> Utils.restructure("AmazonOrderId", "Id")
    |> Utils.to_operation(@version, @path)
  end
end
