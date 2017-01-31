defmodule MWSClient.ParserTest do
  use ExUnit.Case

  test "submit_product_feed template" do
    lst = [seller_id: 12121, purge_and_replace: false,
           products: [[albums: [%{"images" => [%{"alt" => "https://s3-us-west-2.amazonaws.com/fc-firebird-public/images/product/Festival_Three_Quarter.jpg",
                                  "baseurl" => nil, "src" => "https://s3-us-west-2.amazonaws.com/fc-firebird-public/images/product/Festival_Three_Quarter.jpg",
                                  "title" => "https://s3-us-west-2.amazonaws.com/fc-firebird-public/images/product/Festival_Three_Quarter.jpg"}],
           "name" => "Shark"}], currency: "USD",
           description: "Sharks come with balanced framing.", id: 2,
           sale_price: "15300", skus: ["SKU-BRO"], slug: "shark", title: "Shark"]]]
    res = TemplateBuilder.template_for("submit_product_feed", lst)
    expect = "<?xml version=\"1.0\" ?>\n<AmazonEnvelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xsi:noNamespaceSchemaLocation=\"amzn- envelope.xsd\">\n<Header>\n  <DocumentVersion>1.01</DocumentVersion>\n  <MerchantIdentifier>12121</MerchantIdentifier>\n</Header>\n<MessageType>Product</MessageType>\n<PurgeAndReplace>false</PurgeAndReplace>\n<Message>\n  <MessageID>1</MessageID>\n  <OperationType>Update</OperationType>\n  \n    <Product>\n      <SKU>SKU-BRO</SKU>\n      <StandardProductID>\n        <Type>ASIN</Type>\n        <Value></Value>\n      </StandardProductID>\n      <ProductTaxCode></ProductTaxCode>\n      <LaunchDate></LaunchDate>\n      <DescriptionData>\n        <Title>Shark</Title>\n        <Description>Sharks come with balanced framing.</Description>\n        \n          <SearchTerms></SearchTerms>\n        \n        <MSRP currency=\"USD\">153.0</MSRP>\n<!--    <BulletPoint>made in Italy</BulletPoint>\n        <SearchTerms>eyeglasses</SearchTerms> TAGS\n        <BulletPoint>500 thread count</BulletPoint>\n        <BulletPoint>plain weave (percale)</BulletPoint>\n        <BulletPoint>100% Egyptian cotton</BulletPoint>\n        <Manufacturer>Peacock Alley</Manufacturer>\n        <ItemType>flat-sheets</ItemType>\n        <IsGiftWrapAvailable>false</IsGiftWrapAvailable>\n        <IsGiftMessageAvailable>false</IsGiftMessageAvailable> -->\n      </DescriptionData>\n      <ProductData>\n        <Home>\n          <Parentage>variation-parent</Parentage>\n          <VariationData>\n            <VariationTheme>Size-Color</VariationTheme>\n          </VariationData>\n          <Material>cotton</Material>\n          <ThreadCount>500</ThreadCount>\n        </Home>\n      </ProductData>\n    </Product>\n  \n</Message>\n</AmazonEnvelope>\n"
    assert res == expect
  end
end

