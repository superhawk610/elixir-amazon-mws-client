defmodule MWSClient.Feed do
  @version "2009-01-01"
  @path "/Feeds/#{@version}"

  alias MWSClient.Utils

  def submit_product_feed(data, opts) do
    %{"Action" => "SubmitFeed",
      "FeedType" => "_POST_PRODUCT_DATA_"}
      |> Utils.add(opts, [:marketplace_id, :purge_and_replace])
      |> Utils.to_operation(@version, @path, data, ["Content-MD5": Utils.content_md5(data)])
  end


  def get_feed_submission_result(feed_id, opts \\ [marketplace_id: "ATVPDKIKX0DER"]) do
    %{"Action" => "GetFeedSubmissionResult",
      "FeedSubmissionId" => feed_id}
      |> Utils.add(opts, [:marketplace_id])
      |> Utils.to_operation(@version, @path, nil, [])
  end
end

