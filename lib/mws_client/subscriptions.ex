defmodule MWSClient.Subscriptions do
  alias MWSClient.Utils

  @version "2013-07-01"
  @path "/Subscriptions/#{@version}"
  @default_market "ATVPDKIKX0DER"


  def register_destination(url, opts \\ [marketplace_id: @default_market]) do
    %{"Action" => "RegisterDestination",
      "Destination.AttributeList.member.1.Key" => "sqsQueueUrl",
      "Destination.AttributeList.member.1.Value" => url,
      "Destination.DeliveryChannel" => "SQS"}
      |> Utils.add(opts, [:marketplace_id])
      |> Utils.to_operation(@version, @path)
  end
end