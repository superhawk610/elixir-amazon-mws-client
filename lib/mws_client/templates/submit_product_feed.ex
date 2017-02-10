defmodule Templates.SubmitProductFeed do
  use Timex
  def template_string do
    """
    <?xml version="1.0" ?>
    <AmazonEnvelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="amzn- envelope.xsd">
    <Header>
      <DocumentVersion>1.01</DocumentVersion>
      <MerchantIdentifier><%= seller_id %></MerchantIdentifier>
    </Header>
    <MessageType>Product</MessageType>
    <PurgeAndReplace><%= purge_and_replace %></PurgeAndReplace>
    <Message>
      <MessageID>1</MessageID>
      <OperationType>Update</OperationType>
      <%= for p <- products do %>
        <Product>
          <SKU><%= p[:code]%></SKU>
          <StandardProductID>
            <Type>ISBN</Type> <!-- We may have UPC or EAN or ISBN here -->
            <Value><%= p[:isbn]%></Value>
          </StandardProductID>
          <ProductTaxCode><%= p[:tax_code] %></ProductTaxCode>
          <LaunchDate><%= Templates.SubmitProductFeed.format_date_time(p[:activefrom]) %></LaunchDate>
          <DescriptionData>
            <Title><%= p[:title] %></Title>
            <Description><%= HtmlSanitizeEx.strip_tags(p[:description]) %></Description>
            <%= for t <- p[:tags] do %>
              <SearchTerms><%= t %></SearchTerms>
            <% end %>
      <!--  <BulletPoint>made in Italy</BulletPoint>
            <BulletPoint>500 thread count</BulletPoint>
            <BulletPoint>plain weave (percale)</BulletPoint>
            <BulletPoint>100% Egyptian cotton</BulletPoint>
            <Manufacturer>Peacock Alley</Manufacturer>
            <ItemType></ItemType>
            <IsGiftWrapAvailable>false</IsGiftWrapAvailable>
            <IsGiftMessageAvailable>false</IsGiftMessageAvailable> -->
          </DescriptionData>
          <ProductData>
            <%= if p[:category] == "Books" do %>
              <%= TemplateBuilder.books_category(p) %>
            <% else %>
              <%= TemplateBuilder.common_category(p) %>
            <% end %>
          </ProductData>
        </Product>
      <% end %>
    </Message>
    </AmazonEnvelope>
    """
  end

  def format_date_time(dt_str) do
    {:ok, dt} = Timex.Parse.DateTime.Parser.parse(dt_str, "{ISO:Extended:Z}")
    Timex.format(dt, "%Y-%m-%dT%H:%M:%S+00:00", :strftime) |> elem(1)
  end
end