defmodule MWSClient.Orders do
  @version "2013-09-01"
  @path "/Orders/#{@version}"

  @moduledoc """
  Get orders from the Amazon MWS
  """

  import MWSClient.Utils

  def list_orders(params, opts) do
    %{"Action" => "ListOrders"}
    |> add(params, [:created_after, :created_before, :last_updated_after, :last_updated_before,
                   :order_status, :fulfillment_channel, :payment_method, :buyer_email,
                   :seller_order_id, :max_results_per_page, :tfm_shipment_status])
    |> add(opts, [:marketplace_id])
    |> restructure("MarketplaceId", "Id")
    |> restructure("FulfillmentChannel", "Channel")
    |> restructure("PaymentMethod", "Method")
    |> restructure("OrderStatus", "Status")
    |> to_operation(@version, @path)
  end

  def list_order_items(order_id, opts) do
    %{"Action" => "ListOrderItems",
      "AmazonOrderId" => order_id}
    |> add(opts, [:marketplace_id])
    |> to_operation(@version, @path)
  end

  def get_order(order_id, opts) do
    %{"Action" => "GetOrder",
      "AmazonOrderId" => order_id}
    |> add(opts, [:marketplace_id])
    |> restructure("AmazonOrderId", "Id")
    |> to_operation(@version, @path)
  end
end
