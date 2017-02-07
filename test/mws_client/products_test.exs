defmodule MWSClient.ProductsTest do
  use ExUnit.Case

  alias MWSClient.Products
  alias MWSClient.Operation

  test "get_matching_product" do
    result = Products.get_matching_product(["B00KO1C94A"])
    expectation = %Operation{params: %{"ASINList.ASIN.1" => "B00KO1C94A", "Action" => "GetMatchingProduct", "MarketplaceId" => "ATVPDKIKX0DER", "Version" => "2011-10-01"}, path: "/Products/2011-10-01"}
    assert result == expectation
  end

  test "get_matching_product returns a uri" do
    result = Products.get_matching_product_for_id("ASIN", ["B00KO1C94A"])
    assert result == %Operation{method: "POST",
                                params: %{"Action" => "GetMatchingProductForId",
                                         "IdList.Id.1" => "B00KO1C94A",
                                         "IdType" => "ASIN",
                                         "MarketplaceId" => "ATVPDKIKX0DER",
                                         "Version" => "2011-10-01"},
                                path: "/Products/2011-10-01",
                                timestamp: nil}
  end

  test "List matching products returan a struct" do
    res = Products.list_matching_products("QRY")
    expect = %MWSClient.Operation{body: nil, headers: [], method: "POST",
                                  params: %{"Action" => "ListMatchingProducts",
                                            "MarketplaceId" => "ATVPDKIKX0DER", "Query" => "QRY",
                                            "Version" => "2011-10-01"},
                                  path: "/Products/2011-10-01",
                                  timestamp: nil}
    assert res == expect
  end

  test "get_product_categories_for_asin returns a struct" do
    res = Products.get_product_categories_for_asin("ASIN")
    exp = %MWSClient.Operation{body: nil, headers: [], method: "POST",
                               params: %{"ASIN" => "ASIN",
                                 "Action" => "GetProductCategoriesForASIN",
                                 "MarketplaceId" => "ATVPDKIKX0DER", "Version" => "2011-10-01"},
                               path: "/Products/2011-10-01", timestamp: nil}
    assert res == exp
  end

end