defmodule MWSClient.TemplateBuilderTest do
  use ExUnit.Case

  test "should generate submit_product_feed template" do
    template_opts = %{seller_id: "ASD123", purge_and_replace: false}
    lst = [[asin: "9785970602331", author: "Okasaki Kris", category: "Books",
            description: "<p>Bolshinstvo knig po strukturam dannykh predpolagaiut</p>",
            id: 232, isbn: "9785970602331", lang: "Russian",
            launch_date: DateTime.utc_now, sku: "AMZ2331",
            tags: ["book", "programming", "haskell", "elixir", "scala"],
            tax_code: "foobar12", title: "Chisto funktsionalnye struktury dannyh",
            type: "Paperback", upc: ""]]

    _res = TemplateBuilder.submit_product_feed(lst, template_opts)
    _exp = "<?xml version=\"1.0\" ?>\n<AmazonEnvelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:noNamespaceSchemaLocation=\"amzn- envelope.xsd\">\n<Header>\n  <DocumentVersion>1.01</DocumentVersion>\n  <MerchantIdentifier>ASD123</MerchantIdentifier>\n</Header>\n<MessageType>Product</MessageType>\n<PurgeAndReplace>false</PurgeAndReplace>\n<Message>\n  <MessageID>1</MessageID>\n  <OperationType>Update</OperationType>\n  \n    <Product>\n      <SKU>AMZ2331</SKU>\n      <StandardProductID>\n        <Type>ISBN</Type> <!-- We may have UPC or EAN or ISBN here -->\n        <Value>9785970602331</Value>\n      </StandardProductID>\n      <ProductTaxCode>foobar12</ProductTaxCode>\n      <LaunchDate>2017-02-07T10:06:41+00:00</LaunchDate>\n      <DescriptionData>\n        <Title>Chisto funktsionalnye struktury dannyh</Title>\n        <Description>Bolshinstvo knig po strukturam dannykh predpolagaiut</Description>\n        \n          <SearchTerms>book</SearchTerms>\n        \n          <SearchTerms>programming</SearchTerms>\n        \n          <SearchTerms>haskell</SearchTerms>\n        \n          <SearchTerms>elixir</SearchTerms>\n        \n          <SearchTerms>scala</SearchTerms>\n        \n  <!--  <BulletPoint>made in Italy</BulletPoint>\n        <BulletPoint>500 thread count</BulletPoint>\n        <BulletPoint>plain weave (percale)</BulletPoint>\n        <BulletPoint>100% Egyptian cotton</BulletPoint>\n        <Manufacturer>Peacock Alley</Manufacturer>\n        <ItemType></ItemType>\n        <IsGiftWrapAvailable>false</IsGiftWrapAvailable>\n        <IsGiftMessageAvailable>false</IsGiftMessageAvailable> -->\n      </DescriptionData>\n      <ProductData>\n        \n          <Books>\n  <ProductType>\n    <BooksMisc>\n      <Author>Okasaki Kris</Author>\n      <Binding>Paperback</Binding>\n      <Language>Russian</Language>\n    </BooksMisc>\n  </ProductType>\n</Books>\n\n        \n      </ProductData>\n    </Product>\n  \n</Message>\n</AmazonEnvelope>\n"
    # assert res == expect
  end

  test "should generate submit_price_feed template" do
    template_opts = %{seller_id: "ASD123"}
    lst = [[price: %{"currency" => "USD", "value" => 2399}, sku: "AMZ2331"]]
    res = TemplateBuilder.submit_price_feed(lst, template_opts)
    exp = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<AmazonEnvelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:noNamespaceSchemaLocation=\"amzn-envelope.xsd\">\n  <Header>\n    <DocumentVersion>1.01</DocumentVersion>\n    <MerchantIdentifier>ASD123</MerchantIdentifier>\n  </Header>\n  <MessageType>Price</MessageType>\n  <Message>\n    <MessageID>1</MessageID>\n    \n      <Price>\n        <SKU>AMZ2331</SKU>\n        <StandardPrice currency=\"USD\">23.99</StandardPrice>\n      </Price>\n    \n  </Message>\n</AmazonEnvelope>\n"
    assert res == exp
  end

  test "should generate submit_inventory_feed template" do
    template_opts = %{seller_id: "ASD123"}
    lst = [[sku: "foo", quantity: 12]]
    res = TemplateBuilder.submit_inventory_feed(lst, template_opts)
    exp = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<AmazonEnvelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:noNamespaceSchemaLocation=\"amzn-envelope.xsd\">\n  <Header>\n    <DocumentVersion>1.01</DocumentVersion>\n    <MerchantIdentifier>ASD123</MerchantIdentifier>\n  </Header>\n  <MessageType>Inventory</MessageType>\n  <Message>\n    <MessageID>1</MessageID>\n    <OperationType>Update</OperationType>\n    \n      <Inventory>\n        <SKU>foo</SKU>\n        <Quantity>12</Quantity>\n      </Inventory>\n    \n  </Message>\n</AmazonEnvelope>\n"
    assert res == exp
  end

  test "shoudl generate submit_product_by_asin feed" do
    lst = [sku: "ASD", asin: "AS222", seller_id: "12121212", purge_and_replace: false ]
    res = TemplateBuilder.submit_product_by_asin(lst)
    exp = "<?xml version=\"1.0\" ?>\n<AmazonEnvelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:noNamespaceSchemaLocation=\"amzn- envelope.xsd\">\n<Header>\n  <DocumentVersion>1.01</DocumentVersion>\n  <MerchantIdentifier>12121212</MerchantIdentifier>\n</Header>\n<MessageType>Product</MessageType>\n<PurgeAndReplace>false</PurgeAndReplace>\n<Message>\n  <MessageID>1</MessageID>\n  <OperationType>Update</OperationType>\n    <Product>\n      <SKU>ASD</SKU>\n      <StandardProductID>\n        <Type>ASIN</Type>\n        <Value>AS222</Value>\n      </StandardProductID>\n    </Product>\n</Message>\n</AmazonEnvelope>  \n"
    assert res == exp
  end
end

