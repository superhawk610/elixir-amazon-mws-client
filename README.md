# MWSClient


**An Elixir client for accessing Amazon's Merchant Web Services**

Inspired by ruby [peddler](https://github.com/hakanensari/peddler) gem and
elixir [elixir-amazon-product-advertising-client](https://github.com/zachgarwood/elixir-amazon-product-advertising-client) for signature signing.


## Usage:

Firstly, you need to fill `%Config` struct.

```elixir
config = %MWSClient.Config{aws_access_key_id: "SomeKey", seller_id: "SellerId", aws_secret_access_key: "SecretKey"}
```

Then just call needed endpoint

**Request:**

Example XML

```elixir
x = """
<?xml version="1.0" encoding="utf-8"?>
<AmazonEnvelope>
  <Header>
    <DocumentVersion>1.01</DocumentVersion>
    <MerchantIdentifier>M_EXAMPLE_123456</MerchantIdentifier>
  </Header>
  <MessageType>Product</MessageType>
  <PurgeAndReplace>false</PurgeAndReplace>
  <Message>
    <MessageID>1</MessageID>
    <OperationType>Update</OperationType>
    <Product>
      <SKU>56789</SKU>
      <StandardProductID>
        <Type>ASIN</Type>
        <Value>B0EXAMPLEG</Value>
      </StandardProductID>
      <ProductTaxCode>A_GEN_NOTAX</ProductTaxCode>
      <DescriptionData>
        <Title>Example Product Title</Title>
        <Brand>Example Product Brand</Brand>
        <Description>This is an example product description.</Description>
        <BulletPoint>Example Bullet Point 1</BulletPoint>
        <BulletPoint>Example Bullet Point 2</BulletPoint>
        <MSRP currency="USD">25.19</MSRP>
        <Manufacturer>Example Product Manufacturer</Manufacturer>
        <ItemType>example-item-type</ItemType>
      </DescriptionData>
      <ProductData>
        <Health>
          <ProductType>
            <HealthMisc>
              <Ingredients>Example Ingredients</Ingredients>
              <Directions>Example Directions</Directions>
            </HealthMisc>
          </ProductType>
        </Health>
      </ProductData>
    </Product>
  </Message>
</AmazonEnvelope>
"""

MWSClient.submit_product_feed(x, config)

```

**Response:**

```elixir
	{:success,
	 %{"SubmitFeedResponse" => %{"ResponseMetadata" => %{"RequestId" => "228b6ebb-5c4f-4cc4-bad1-53ce4635261a"},
	     "SubmitFeedResult" => %{"FeedSubmissionInfo" => %{"FeedProcessingStatus" => "_SUBMITTED_",
	         "FeedSubmissionId" => "50012017196",
	         "FeedType" => "_POST_PRODUCT_DATA_",
	         "SubmittedDate" => "2017-01-30T10:38:17+00:00"}}}}}
```


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `mws_client` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:mws_client, "~> 0.0.1"}]
    end
    ```

  2. Ensure `mws_client` is started before your application:

    ```elixir
    def application do
      [applications: [:mws_client]]
    end
    ```

## Useful info

1. [Amazon sandbox app](https://mws.amazonservices.com/scratchpad/index.html)
2. [Amazon developer documentation](https://developer.amazonservices.com/index.html/163-0965275-1355800)

