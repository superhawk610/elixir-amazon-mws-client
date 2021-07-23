defmodule MWSClient.Request do

  @hosts %{
    # North America
    "A2EUQ1WTGCTBG2" => "mws.amazonservices.com",     # Canada
    "ATVPDKIKX0DER"  => "mws.amazonservices.com",     # US
    "A1AM78C64UM0Y8" => "mws.amazonservices.com",     # Mexico

    # Europe
    "A1RKKUPIHCS9HS" => "mws-eu.amazonservices.com",  # Spain
    "A1F83G8C2ARO7P" => "mws-eu.amazonservices.com",  # UK
    "A13V1IB3VIYZZH" => "mws-eu.amazonservices.com",  # France
    "A1PA6795UKMFR9" => "mws-eu.amazonservices.com",  # Germany
    "APJ6JRA9NG5V4"  => "mws-eu.amazonservices.com",  # Italy

    # Other
    "A2Q3Y263D00KWC" => "mws.amazonservices.com",     # Brazil
    "A21TJRUUN4KGV"  => "mws.amazonservices.in",      # India
    "AAHKV2X7AFYLW"  => "mws.amazonservices.com.cn",  # China
    "A1VC38T7YXB528" => "mws.amazonservices.jp",      # Japan
    "A39IBJ37TRP1C6" => "mws.amazonservices.com.au",  # Australia
  }

  alias MWSClient.Config
  alias MWSClient.Operation

  def to_uri(operation = %Operation{}, config = %Config{}) do
    query = config |> Config.to_params |> Map.merge(operation.params) |> percent_encode_query
    %URI{scheme: "https", host: Map.fetch!(@hosts, config.site_id), path: operation.path, query: query, port: 443}
    |> sign_url(config, operation.timestamp, operation.method)
  end

  # `URI.encode_query/1` explicitly does not percent-encode spaces, but Amazon requires `%20`
  # instead of `+` in the query, so we essentially have to rewrite `URI.encode_query/1` and
  # `URI.pair/1`.
  def percent_encode_query(query_map) do
    Enum.map_join(query_map, "&", &pair/1)
  end

  # See comment on `percent_encode_query/1`.
  defp pair({k, v}) do
    URI.encode(Kernel.to_string(k), &URI.char_unreserved?/1) <>
    "=" <> URI.encode(Kernel.to_string(v), &URI.char_unreserved?/1)
  end

  def sign_url(url_parts, config, timestamp, method) do
    url_parts
    |> add_timestamp(timestamp)
    |> append_signature(config.aws_secret_access_key, method)
  end

  defp add_timestamp(url_parts, timestamp) do
    time = timestamp || DateTime.to_iso8601(DateTime.utc_now)
    updated_query = url_parts.query
      |> URI.decode_query
      |> Map.put_new("Timestamp", time)
      |> percent_encode_query
    Map.put url_parts, :query, updated_query
  end

  defp append_signature(url_parts, aws_secret_access_key, method) do
    hmac = :crypto.mac(
        :hmac,
        :sha256,
        aws_secret_access_key,
        Enum.join([method, url_parts.host, url_parts.path, url_parts.query], "\n")
      )
    signature = Base.encode64(hmac)
    updated_query = url_parts.query <> "&" <> pair({"Signature", signature})
    Map.put url_parts, :query, updated_query
  end


end
