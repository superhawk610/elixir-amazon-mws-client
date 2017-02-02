defmodule FeedTest do
  use ExUnit.Case

  alias MWSClient.Feed
  alias MWSClient.Operation

  test "should generate submit_product_feed" do
    res = Feed.submit_product_feed("foo", [marketplace_id: "bar"])
    exp = %MWSClient.Operation{body: "foo",
                               headers: ["Content-MD5": "rL0Y20zC+Fzt72VPzMSk2A=="],
                               method: "POST",
                               params: %{"Action" => "SubmitFeed",
                                 "FeedType" => "_POST_PRODUCT_DATA_", "MarketplaceId" => "bar",
                                 "Version" => "2009-01-01"}, path: "/Feeds/2009-01-01",
                               timestamp: nil}
    assert res == exp
  end

  test "should generate get_feed_submission_result" do
    res = Feed.get_feed_submission_result("baz", [marketplace_id: "bar"])
    exp = %MWSClient.Operation{body: nil, headers: [], method: "POST",
                               params: %{"Action" => "GetFeedSubmissionResult",
                                 "FeedSubmissionId" => "baz", "MarketplaceId" => "bar",
                                 "Version" => "2009-01-01"}, path: "/Feeds/2009-01-01",
                               timestamp: nil}
    assert res == exp
  end
end