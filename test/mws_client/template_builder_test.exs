defmodule MWSClient.TemplateBuilderTest do
  use ExUnit.Case

  test "should generate submit_product_feed template" do
    template_opts = %{seller_id: "ASD123", purge_and_replace: false}
    lst = [[albums: [%{"images" => [%{"alt" => "https://s3-us-west-2.amazonaws.com/fc-firebird-public/images/product/Festival_Three_Quarter.jpg",
                                  "baseurl" => nil, "src" => "https://s3-us-west-2.amazonaws.com/fc-firebird-public/images/product/Festival_Three_Quarter.jpg",
                                  "title" => "https://s3-us-west-2.amazonaws.com/fc-firebird-public/images/product/Festival_Three_Quarter.jpg"}],
          "name" => "Shark"}], currency: "USD",
          description: "Sharks come with balanced framing.", id: 2, tags: ["foo"],
          sale_price: "15300", skus: ["SKU-BRO"], slug: "shark", title: "Shark"]]
    res = TemplateBuilder.submit_product_feed(lst, template_opts)
    expect = "<?xml version=\"1.0\" ?>\n<AmazonEnvelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:noNamespaceSchemaLocation=\"amzn- envelope.xsd\">\n<Header>\n  <DocumentVersion>1.01</DocumentVersion>\n  <MerchantIdentifier>ASD123</MerchantIdentifier>\n</Header>\n<MessageType>Product</MessageType>\n<PurgeAndReplace>false</PurgeAndReplace>\n<Message>\n  <MessageID>1</MessageID>\n  <OperationType>Update</OperationType>\n  \n    <Product>\n      <SKU>SKU-BRO</SKU>\n      <StandardProductID>\n        <Type>ASIN</Type> <!-- We may have UPC or EAN or ISBN here -->\n        <Value></Value>\n      </StandardProductID>\n      <ProductTaxCode></ProductTaxCode>\n      <LaunchDate></LaunchDate>\n      <DescriptionData>\n        <Title>Shark</Title>\n        <Description>Sharks come with balanced framing.</Description>\n        \n          <SearchTerms>foo</SearchTerms>\n        \n        <MSRP currency=\"USD\">153.0</MSRP>\n<!--    <BulletPoint>made in Italy</BulletPoint>\n        <ItemType></ItemType>\n        <BulletPoint>500 thread count</BulletPoint>\n        <BulletPoint>plain weave (percale)</BulletPoint>\n        <BulletPoint>100% Egyptian cotton</BulletPoint>\n        <Manufacturer>Peacock Alley</Manufacturer>\n        <IsGiftWrapAvailable>false</IsGiftWrapAvailable>\n        <IsGiftMessageAvailable>false</IsGiftMessageAvailable> -->\n      </DescriptionData>\n      <ProductData>\n        <Home>\n          <Parentage>variation-parent</Parentage>\n          <VariationData>\n            <VariationTheme>Size-Color</VariationTheme>\n          </VariationData>\n          <Material>cotton</Material>\n          <ThreadCount>500</ThreadCount>\n        </Home>\n      </ProductData>\n    </Product>\n  \n</Message>\n</AmazonEnvelope>\n"
    assert res == expect
  end

  test "should generate submit_price_feed template" do
    template_opts = %{seller_id: "ASD123"}
    lst = [[skus: ["foo"], sale_price: 12.99, currency: "USD"]]
    res = TemplateBuilder.submit_price_feed(lst, template_opts)
    exp = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<AmazonEnvelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:noNamespaceSchemaLocation=\"amzn-envelope.xsd\">\n  <Header>\n    <DocumentVersion>1.01</DocumentVersion>\n    <MerchantIdentifier>ASD123</MerchantIdentifier>\n  </Header>\n  <MessageType>Price</MessageType>\n  <Message>\n    <MessageID>1</MessageID>\n    \n      <Price>\n        <SKU>foo</SKU>\n        <StandardPrice currency=\"USD\">12.99</StandardPrice>\n      </Price>\n    \n  </Message>\n</AmazonEnvelope>"
    assert res == exp
  end

  test "should generate submit_inventory_feed template" do
    template_opts = %{seller_id: "ASD123"}
    lst = [[skus: ["foo"], quantity: 12]]
    res = TemplateBuilder.submit_inventory_feed(lst, template_opts)
    exp = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<AmazonEnvelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:noNamespaceSchemaLocation=\"amzn-envelope.xsd\">\n  <Header>\n    <DocumentVersion>1.01</DocumentVersion>\n    <MerchantIdentifier>ASD123</MerchantIdentifier>\n  </Header>\n  <MessageType>Inventory</MessageType>\n  <Message>\n    <MessageID>1</MessageID>\n    <OperationType>Update</OperationType>\n    \n      <Inventory>\n        <SKU>foo</SKU>\n        <Quantity>12</Quantity>\n      </Inventory>\n    \n  </Message>\n</AmazonEnvelope>"
    assert res == exp
  end
end

