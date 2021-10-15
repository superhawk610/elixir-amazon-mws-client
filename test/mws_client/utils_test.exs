defmodule MWSClient.UtilsTest do
  use ExUnit.Case

  alias MWSClient.Utils

  describe "percent_encode_query/1" do
    test "percent encodes query" do
      assert Utils.percent_encode_query(%{"term" => "foo bar"}) == "term=foo%20bar"
    end

    test "sorts params lexicographically" do
      params = %{"A10" => 1, "A1" => 2}
      assert "A1=2&A10=1" == Utils.percent_encode_query(params)
    end

    test "it encodes spaces with %20" do
      params = %{"Title" => "This is my title"}
      assert "Title=This%20is%20my%20title" == Utils.percent_encode_query(params)
    end

    test "it does not escape tilde" do
      params = %{"Title" => "~,"}
      assert "Title=~%2C" == Utils.percent_encode_query(params)
    end
  end

  describe "restructure/2" do
    test "structure replaces params with numbered params" do
      result = %{"List" => ["term1", "term2"]} |> Utils.restructure("List", "Id")
      assert result == %{"List.Id.1" => "term1", "List.Id.2" => "term2"}
    end

    test "structure works with one item" do
      result = %{"List" => ["term1"]} |> Utils.restructure("List", "Id")
      assert result == %{"List.Id.1" => "term1"}
    end

    test "structure does nothing with zero item" do
      result = %{"List" => nil} |> Utils.restructure("List", "Id")
      assert result == %{}
      result = %{"List" => []} |> Utils.restructure("List", "Id")
      assert result == %{}
    end
  end

  describe "add/2" do
    test "rejects some keys if given whitelist" do
      white_list = [:ok]
      result = %{} |> Utils.add([ok: "yes", not_ok: "no"], white_list)
      assert result == %{"Ok" => "yes"}
    end
  end
end
