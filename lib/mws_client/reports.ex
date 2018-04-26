defmodule MWSClient.Reports do
  @version "2009-01-01"
  @path "/"

  import MWSClient.Utils

  @doc """
  Takes a required report_type and keyword list of options
  report_request("_GET_FLAT_FILE_ORDERS_DATA_",[])
  options must be
  - start_date iso8601
  - end_date iso8601
  - report_options (a query_string fragment like "ShowSalesChannel=true")
  - marketplace_id_list is [] of ids
  marketplace_id_list
  """
  def request_report(report_type, opts) do
    white_list = [
      :start_date,
      :end_date,
      :report_options,
      :marketplace_id_list
    ]

    %{"Action" => "RequestReport",
      "ReportType" => report_type}
    |> add(opts, white_list)
    |> restructure("MarketplaceIdList", "Id")
    |> to_operation(@version, @path)
  end

  @doc """
   Lists report requests

  see http://docs.developer.amazonservices.com/en_US/reports/Reports_GetReportRequestList.html
  param [Hash] opts
  option opts [<String>, String] :report_request_id_list
  option opts [<String>, String] :report_type_list
  option opts [<String>, String] :report_processing_status_list
  option opts [Integer] :max_count
  option opts [String, #iso8601] :requested_from_date
  option opts [String, #iso8601] :requested_to_date
  """
  def get_report_request_list(opts) do
    white_list = [
      :report_request_id_list,
      :report_type_list,
      :report_processing_status_list,
      :max_count,
      :requested_from_date,
      :requested_to_date
    ]

    %{"Action" => "GetReportRequestList"}
    |> add(opts, white_list)
    |> restructure("ReportRequestIdList", "Id")
    |> restructure("ReportTypeList", "Type")
    |> restructure("ReportProcessingStatusList", "Status")
    |> to_operation(@version, @path)
  end


  @doc """
    Lists reports

    see http://docs.developer.amazonservices.com/en_US/reports/Reports_GetReportList.html
    param [Hash] opts
    option opts [Integer] :max_count
    option opts [<String>, String] :report_type_list
    option opts [Boolean] :acknowledged
    option opts [String, #iso8601] :available_from_date
    option opts [String, #iso8601] :available_to_date
    option opts [<String>, String] :report_request_id_list]
  """

  def get_report_list(opts \\ []) do
    white_list = [
      :max_couunt,
      :report_type_list,
      :acknowledged,
      :available_from_date,
      :available_to_date,
      :report_request_id_list
    ]

    %{"Action" => "GetReportList"}
    |> add(opts, white_list)
    |> restructure("ReportTypeList", "Type")
    |> restructure("ReportRequestIdList", "Id")
    |> to_operation(@version, @path)
  end

  @doc """
   Gets a report and its Content-MD5 header

    see http://docs.developer.amazonservices.com/en_US/reports/Reports_GetReport.html
    param [String] report_id
    return [Peddler::XMLParser] if report is in XML format
    return [Peddler::FlatFileParser] if report is a flat file
  """
  def get_report(report_id) do
    %{"Action" => "GetReport", "ReportId" => report_id}
    |> to_operation(@version, @path)
  end

end
