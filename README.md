# MWSClient


**An Elixir client for accessing Amazon's Merchant Web Services**

## Usage

Create `%Config` struct.

```elixir
config = %MWSClient.Config{aws_access_key_id: "SomeKey", seller_id: "SellerId", aws_secret_access_key: "SecretKey"}
```

### Functions

#### submit\_product\_feed

```elixir
products = [[activefrom: "2017-02-03T05:31:52.066Z",
  description: "<p>Bolshinstvo knig po strukturam dannykh predpolagaiut ispolzovanie imperativnogo iazyka programmirovaniia, naprimer, S/S++ ili Java. Odnako realizatcii struktur dannykh na takikh iazykakh daleko ne vsegda khorosho perenosiatsia na funktcionalnye iazyki programmirovaniia, takie kak Standartnyi ML, Haskell ili Scheme. V etoi knige struktury dannykh opisyvaiutsia s tochki zreniia funktcionalnykh iazykov, v nei soderzhatsia primery i predlagaiutsia podkhody k proektirovaniiu, kotorye mogut ispolzovatsia razrabotchikami pri sozdanii ikh sobstvennykh struktur dannykh. Kniga vkliuchaet v sebia kak klassicheskie struktury dannykh, k primeru, krasno-chernye derevia i binomialnye ocheredi, tak i nekotorye novye struktury dannykh, sozdannye spetcialno dlia funktcionalnykh iazykov. Ves iskhodnyi kod privoditsia na Standartnom ML i Haskell, prichem bolshinstvo programm netrudno adaptirovat dlia drugikh funktcionalnykh iazykov programmirovaniia. eto izdanie predstavliaet soboi spravochnoe rukovodstvo dlia professionalnykh programmistov, rabotaiushchikh s funktcionalnymi iazykami, i mozhet takzhe ispolzovatsia v kachestve uchebnika dlia samostoiatelnogo izucheniia. Na saite izdatelstva DMK-Press vylozhen arkhiv s iskhodnymi tekstami realizatcii vsekh struktur dannykh na iazykakh Standartnyi ML i Haskell. Ikh mozhno ispolzovat v kachestve osnovy pri vypolnenii mnogochislennykh uprazhnenii.</p>",
  tags: ["book", "programming", "haskell", "elixir", "scala"],
  title: "Chisto funktsionalnye struktury dannyh", author: "Okasaki Kris",
  bindingtypes: "Paperback", language: "Russian",
  activefrom: "2017-02-03T05:31:52.066Z", category: "Books", channel: "amazon",
  code: "AMZ2331", isbn: "9785970602331"]]

MWSClient.submit_product_feed(products, cfg)

{:success,
 %{"SubmitFeedResponse" => %{"ResponseMetadata" => %{"RequestId" => "5605d1de-e678-487a-8609-6fd3cacfd7e7"},
     "SubmitFeedResult" => %{"FeedSubmissionInfo" => %{"FeedProcessingStatus" => "_SUBMITTED_",
         "FeedSubmissionId" => "50071017207",
         "FeedType" => "_POST_PRODUCT_DATA_",
         "SubmittedDate" => "2017-02-10T11:51:58+00:00"}}}}}
```

#### submin_proice_feed

```elixir

prices = [[code: "AMZ2331", retailprice: %{"currency" => "USD", "value" => 2399}]]

MWSClient.submit_price_feed(prices, cfg)
{:success,
 %{"SubmitFeedResponse" => %{"ResponseMetadata" => %{"RequestId" => "5ee65928-a443-4598-ab4f-d0bce0a8a23c"},
     "SubmitFeedResult" => %{"FeedSubmissionInfo" => %{"FeedProcessingStatus" => "_SUBMITTED_",
         "FeedSubmissionId" => "50072017207",
         "FeedType" => "_POST_PRODUCT_PRICING_DATA_",
         "SubmittedDate" => "2017-02-10T11:53:35+00:00"}}}}}
```

#### submit\_inventory\_feed

```elixir
inventory = [[sku: "AMZ2331", quantity: 10]]

MWSClient.submit_inventory_feed(inventory, cfg)
{:success,
 %{"SubmitFeedResponse" => %{"ResponseMetadata" => %{"RequestId" => "52aae66a-5117-48bf-9b61-7d7a24e3263f"},
     "SubmitFeedResult" => %{"FeedSubmissionInfo" => %{"FeedProcessingStatus" => "_SUBMITTED_",
         "FeedSubmissionId" => "50073017207",
         "FeedType" => "_POST_INVENTORY_AVAILABILITY_DATA_",
         "SubmittedDate" => "2017-02-10T11:57:50+00:00"}}}}}

```

#### get\_feed\_submission\_result

```elixir
iex(7)> MWSClient.get_feed_submission_result("50071017207", cfg)
{:success,
 %{"AmazonEnvelope" => %{"Header" => %{"DocumentVersion" => "1.02",
       "MerchantIdentifier" => "A2KK3Z7K1ON8YS"},
     "Message" => %{"MessageID" => "1",
       "ProcessingReport" => %{"DocumentTransactionID" => "50071017207",
         "ProcessingSummary" => %{"MessagesProcessed" => "1",
           "MessagesSuccessful" => "1", "MessagesWithError" => "0",
           "MessagesWithWarning" => "1"},
         "Result" => [%{"AdditionalInfo" => %{"SKU" => "AMZ2331"},
            "MessageID" => "1", "ResultCode" => "Warning",
            "ResultDescription" => "A value was not provided for \"brand_name\". Please provide a value for \"brand_name\". This information appears on the product detail page and helps customers evaluate products.",
            "ResultMessageCode" => "99041"},
          %{"AdditionalInfo" => %{"SKU" => "AMZ2331"}, "MessageID" => "1",
            "ResultCode" => "Warning",
            "ResultDescription" => "A value was not provided for \"bullet_point1\". Please provide a value for \"bullet_point1\". This information appears on the product detail page and helps customers evaluate products.",
            "ResultMessageCode" => "99041"}], "StatusCode" => "Complete"}},
     "MessageType" => "ProcessingReport",
     "{http://www.w3.org/2001/XMLSchema-instance}noNamespaceSchemaLocation" => "amzn-envelope.xsd"}}}
```

#### list\_matching\_products

```elixir
MWSClient.list_matching_products("Apple iphone 6S 256Gb", cfg)
{:success,
 %{"ListMatchingProductsResponse" => %{"ListMatchingProductsResult" => %{"Products" => %{"Product" => [%{"AttributeSets" => %{"ItemAttributes" => %{"Binding" => "Wireless Phone Accessory",
                "Brand" => "Apple", "Color" => "Black", "DisplaySize" => "5.50", ....
```     

#### get\_product\_by\_asin

```elixir
iex(10)> MWSClient.get_product_by_asin(["B01LYT95XR"], cfg)
{:success,
 %{"GetMatchingProductResponse" => %{"GetMatchingProductResult" => %{"ASIN" => "B01LYT95XR",
       "Product" => %{"AttributeSets" => %{"ItemAttributes" => %{"Binding" => "Wireless Phone Accessory", ...
```

#### get\_producst\_categories\_for\_asin

```elixir
MWSClient.get_product_categories_for_asin("B01LYT95XR", cfg)
{:success,
 %{"GetProductCategoriesForASINResponse" => %{"GetProductCategoriesForASINResult" => %{"Self" => %{"Parent" => %{"Parent" => %{"Parent" => %{"ProductCategoryId" => "2335752011",
               "ProductCategoryName" => "Cell Phones & Accessories"},
             "ProductCategoryId" => "2335753011",
             "ProductCategoryName" => "Categories"},
           "ProductCategoryId" => "7072561011",
           "ProductCategoryName" => "Cell Phones"},
         "ProductCategoryId" => "2407749011",
         "ProductCategoryName" => "Unlocked Cell Phones"}},
     "ResponseMetadata" => %{"RequestId" => "709429ea-c4c5-40ae-9149-bd96040bacfd"}}}}
```

#### subscribe\_to\_sqs

```elixir
 MWSClient.subscribe_to_sqs("aws_sqs_queue_url", cfg)
{:success,
 %{"RegisterDestinationResponse" => %{"RegisterDestinationResult" => %{},
     "ResponseMetadata" => %{"RequestId" => "76b2145c-6083-4157-8be2-6e330b923ca1"}}}}
```
#### unsubscribe\_from\_sqs

```elixir
MWSClient.unsubscribe_from_sqs("aws_sqs_queue_url", cfg)
{:success,
 %{"DeregisterDestinationResponse" => %{"DeregisterDestinationResult" => %{},
     "ResponseMetadata" => %{"RequestId" => "bb9e88ad-b3bb-4267-a42f-7d29400fbef0"}}}}
```

#### list_orders

For available params check this [file](https://github.com/FoxComm/elixir-amazon-mws-client/blob/master/lib/mws_client.ex)

```elixir
MWSClient.list_orders(cfg)
{:success,
 %{"ListOrdersResponse" => %{"ListOrdersResult" => %{"LastUpdatedBefore" => "2017-02-10T12:03:11Z",
       "Orders" => %{}},
     "ResponseMetadata" => %{"RequestId" => "1e7053ad-0b6b-4bbb-a475-c30778f915da"}}}}
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

