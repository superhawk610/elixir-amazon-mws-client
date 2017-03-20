defmodule MWSClient.OrdersTest do
  use ExUnit.Case
  alias MWSClient.Orders

  test "list_orders w/o parameters should return a struct" do
    res = Orders.list_orders([last_updated_after: "2017-01-01T00:00:00Z", seller_order_id: "123"], [marketplace_id: ["ATVPDKIKX0DER"]])
    exp = %MWSClient.Operation{body: nil, headers: [], method: "POST",
          params: %{"Action" => "ListOrders",
                    "LastUpdatedAfter" => "2017-01-01T00:00:00Z",
                    "MarketplaceId.Id.1" => "ATVPDKIKX0DER",
                    "SellerOrderId" => "123", "Version" => "2013-09-01"},
          path: "/Orders/2013-09-01", timestamp: nil}
    assert res == exp
  end

  test "list_orders with all params should return a struct" do
    res = Orders.list_orders([fulfillment_channel: ["MFN", "AFN"], payment_method: ["COD"],
                              order_status: ["foo", "bar"], buyer_email: "foo@bar.baz", seller_order_id: "ASD123",
                              last_updated_after: "2017-01-01T00:00:00Z"],
                              [marketplace_id: ["ATVPDKIKX0DER"]])
    exp =  %MWSClient.Operation{body: nil, headers: [], method: "POST", path: "/Orders/2013-09-01", timestamp: nil, params: %{"Action" => "ListOrders", "BuyerEmail" => "foo@bar.baz", "FulfillmentChannel.Channel.1" => "MFN", "FulfillmentChannel.Channel.2" => "AFN", "MarketplaceId.Id.1" => "ATVPDKIKX0DER", "OrderStatus.Status.1" => "foo", "OrderStatus.Status.2" => "bar", "PaymentMethod.Method.1" => "COD", "SellerOrderId" => "ASD123", "Version" => "2013-09-01", "LastUpdatedAfter" => "2017-01-01T00:00:00Z"}}

    assert res == exp
  end

  test "list_order_items should return a struct" do
    res = Orders.list_order_items("123", [marketplace_id: ["ATVPDKIKX0DER"]])
    exp = %MWSClient.Operation{body: nil, headers: [], method: "POST",
          params: %{"Action" => "ListOrderItems", "AmazonOrderId" => "123",
                    "MarketplaceId" => ["ATVPDKIKX0DER"], "Version" => "2013-09-01"},
          path: "/Orders/2013-09-01", timestamp: nil}
    assert res == exp
  end

  test "get_order should return a struct" do
    res = Orders.get_order(["123"], [marketplace_id: ["ATVPDKIKX0DER"]])
    exp = %MWSClient.Operation{body: nil, headers: [], method: "POST",
          params: %{"Action" => "GetOrder", "AmazonOrderId.Id.1" => "123",
                    "MarketplaceId" => ["ATVPDKIKX0DER"], "Version" => "2013-09-01"},
          path: "/Orders/2013-09-01", timestamp: nil}
    assert res == exp
  end
end