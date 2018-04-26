defmodule MWSClient.Feed do
  @version "2009-01-01"
  @path "/Feeds/#{@version}"

  import MWSClient.Utils

  def submit_product_feed(data, opts) do
    %{"Action" => "SubmitFeed",
      "FeedType" => "_POST_PRODUCT_DATA_"}
      |> add(opts, [:marketplace_id, :purge_and_replace])
      |> to_operation(@version, @path, data, ["Content-MD5": content_md5(data)])
  end

  def submit_variation_feed(data, opts) do
    %{"Action" => "SubmitFeed",
      "FeedType" => "_POST_PRODUCT_RELATIONSHIP_DATA_"}
      |> add(opts, [:marketplace_id])
      |> to_operation(@version, @path, data, ["Content-MD5": content_md5(data)])
  end

  def submit_price_feed(data, opts) do
    %{"Action" => "SubmitFeed",
      "FeedType" => "_POST_PRODUCT_PRICING_DATA_"}
      |> add(opts, [:marketplace_id])
      |> to_operation(@version, @path, data, ["Content-MD5": content_md5(data)])
  end

  def submit_inventory_feed(data, opts) do
    %{"Action" => "SubmitFeed",
      "FeedType" => "_POST_INVENTORY_AVAILABILITY_DATA_"}
      |> add(opts, [:marketplace_id])
      |> to_operation(@version, @path, data, ["Content-MD5": content_md5(data)])
  end

  def submit_images_feed(data, opts) do
    %{"Action" => "SubmitFeed",
      "FeedType" => "_POST_PRODUCT_IMAGE_DATA_"}
      |> add(opts, [:marketplace_id])
      |> to_operation(@version, @path, data, ["Content-MD5": content_md5(data)])
  end

  def get_feed_submission_result(feed_id, opts) do
    %{"Action" => "GetFeedSubmissionResult",
      "FeedSubmissionId" => feed_id}
      |> add(opts, [:marketplace_id])
      |> to_operation(@version, @path, nil, [])
  end
end
