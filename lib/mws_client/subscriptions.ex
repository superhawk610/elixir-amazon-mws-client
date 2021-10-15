defmodule MWSClient.Subscriptions do
  @version "2013-07-01"
  @path "/Subscriptions/#{@version}"

  import MWSClient.Utils

  alias MWSClient.Operation

  @spec register_destination(url :: String.t(), opts :: list()) :: Operation.t()
  def register_destination(url, opts) do
    %{
      "Action" => "RegisterDestination",
      "Destination.AttributeList.member.1.Key" => "sqsQueueUrl",
      "Destination.AttributeList.member.1.Value" => url,
      "Destination.DeliveryChannel" => "SQS"
    }
    |> add(opts, [:marketplace_id])
    |> to_operation(@version, @path)
  end

  @spec deregister_destination(url :: String.t(), opts :: list()) :: Operation.t()
  def deregister_destination(url, opts) do
    %{
      "Action" => "DeregisterDestination",
      "Destination.AttributeList.member.1.Key" => "sqsQueueUrl",
      "Destination.AttributeList.member.1.Value" => url,
      "Destination.DeliveryChannel" => "SQS"
    }
    |> add(opts, [:marketplace_id])
    |> to_operation(@version, @path)
  end
end
