defmodule MWSClient.ParserTest do

  use ExUnit.Case

  test "get report" do
    assert 17 == MWSClient.Parser.parse(get_report_response) |> Enum.count
  end

  def get_report_response do
    {:ok, %HTTPoison.Response{body: "sku\tfnsku\tasin\tproduct-name\tcondition\tyour-price\tmfn-listing-exists\tmfn-fulfillable-quantity\tafn-listing-exists\tafn-warehouse-quantity\tafn-fulfillable-quantity\tafn-unsellable-quantity\tafn-reserved-quantity\tafn-total-quantity\tper-unit-volume\tafn-inbound-working-quantity\tafn-inbound-shipped-quantity\tafn-inbound-receiving-quantity\r\nH11300-FU\tX000MUONEX\tB00M6KJK80\tTwist-and-fold Childrens Rain Hat, 13 in Diameter Brim (Fuchsia)\tNew\t11.99\tNo\t\tYes\t0\t0\t0\t0\t0\t0.02\t0\t0\t0\r\nH11300-GR\tX000MUONFR\tB00M6KJM2O\tTwist-and-Fold Childrens Rain Hat, 13 in diameter brim, Green\tNew\t13.99\tNo\t\tYes\t10\t10\t0\t0\t10\t0.02\t0\t0\t0\r\nH11300-RB\tX000MUONG1\tB00M6KJN8W\tTwist-and-Fold Childrens Rain Hat, 13 in diameter brim, Royal Blue\tNew\t13.99\tNo\t\tYes\t35\t35\t0\t0\t35\t0.02\t0\t0\t0\r\nH11300-RD\tX000MUONED\tB00M6KJP0I\tTwist-and-Fold Childrens Rain Hat, 13 in diameter brim, Red\tNew\t13.99\tNo\t\tYes\t0\t0\t0\t0\t0\t0.02\t0\t0\t0\r\nH11300-YE\tX000MUONGB\tB00M6KJQGQ\tTwist-and-Fold Childrens Rain Hat, 13 in diameter brim, Yellow\tNew\t9.99\tNo\t\tYes\t0\t0\t0\t0\t0\t0.02\t0\t0\t0\r\nH14000-WT\tX000MIFTC5\tB00KO1C94A\tTwist-and-Fold Hat Women's Foldable Cotton Sun Hat, 18 in diameter brim, White\tNew\t9.99\tYes\t100\tNo\t0\t0\t0\t0\t0\t0.02\t0\t0\t0\r\nH16000-PD-BK\tX0016PRDJP\tB01KKVWLH8\tTwist-and-Fold Hat Women's Foldable Cotton Sun Hat, (Black Polka Dot)\tNew\t6.99\tNo\t\tYes\t77\t76\t0\t1\t77\t0.25\t0\t0\t0\r\nH16000-PD-BL\tX0016QPOXL\tB01KKVWLJ6\tTwist-and-Fold Hat Women's Foldable Cotton Sun Hat, (Blue Polka Dot)\tNew\t6.99\tNo\t\tYes\t89\t89\t0\t0\t89\t0.25\t0\t0\t0\r\nH16000-PD-PK\tX0016PY9JH\tB01KKVWLI2\tTwist-and-Fold Hat Women's Foldable Cotton Sun Hat, (Pink Polka Dot)\tNew\t6.99\tNo\t\tYes\t88\t88\t0\t0\t88\t0.25\t0\t0\t0\r\nH17000-BK-FBA\tX000ZMLQ9N\tB00M6JFIIC\tTwist-and-Fold Hat Foldable Nylon Sun Hat, 18 in diameter brim, Black\tNew\t13.99\tNo\t\tYes\t0\t0\t0\t0\t0\t0.05\t0\t0\t0\r\nH17000-RD-FBA\tX000ZMVZPD\tB00M6JFGVG\tTwist-and-Fold Hat Foldable Nylon Sun Hat, 18 in diameter brim\tNew\t13.99\tNo\t\tYes\t33\t33\t0\t0\t33\t0.05\t0\t0\t0\r\nH18000-09\tX000MUONEN\tB00MDUKY8S\tTwist-and-Fold Hat Women's Foldable Cotton Sun Hat, 18 in diameter brim (Handpainted Grapes)\tNew\t13.99\tNo\t\tYes\t58\t56\t0\t2\t58\t0.25\t0\t0\t0\r\nH31300-BK\tX000MIFTCP\tB00K6SKBSM\tTwist-and-Fold Rain Hat, Unisex, 13 in diameter brim, Black\tNew\t9.99\tNo\t\tYes\t0\t0\t0\t0\t0\t0.02\t0\t0\t0\r\nH31300-CF\tX000MUONE3\tB00M6MQJ6Y\tTwist-and-Fold Rain Hat, Unisex, 13 in diameter brim, Camouflage\tNew\t13.99\tNo\t\tYes\t37\t32\t0\t5\t37\t0.02\t0\t0\t0\r\nH31500-PP\tX000MUONF7\tB00M6MQD42\tTwist-and-Fold Rain Hat, Unisex, 15 inch diameter brim, Purple\tNew\t13.99\tNo\t\tYes\t0\t0\t0\t0\t0\t0.02\t0\t0\t0\r\nH31500-RB-FBA\tX000ZN1ZLV\tB00M6MQE82\tTwist-and-Fold Rain Hat, (Royal Blue)\tNew\t9.99\tNo\t\tYes\t0\t0\t0\t0\t0\t0.01\t0\t0\t0\r\nH31500-YE\tX000MIFTCF\tB00K6SKA38\tTwist-and-Fold Rain Hat, Unisex, 15 inch diameter brim, Yellow\tNew\t13.99\tNo\t\tYes\t58\t55\t0\t3\t58\t0.03\t0\t0\t0", headers: [{"Server", "Server"}, {"Date", "Sat, 19 Nov 2016 06:14:32 GMT"}, {"Content-Type", "text/plain;charset=Cp1252"}, {"Content-Length", "2716"}, {"Connection", "keep-alive"}, {"x-mws-quota-max", "60.0"}, {"x-mws-quota-remaining", "60.0"}, {"x-mws-quota-resetsOn", "2016-11-19T06:18:00.000Z"}, {"Content-MD5", "PTGQpTQ8uf+zq1FO33Ildg=="}, {"x-mws-response-context", "dsgdi55GGgWOeBGmWbBQDvjM/YVyQ5Ix6l4OzqGRUFKWwbP/7W4TOzshDqPYqNCRUXpiDPm6UPQ="}, {"x-mws-response-context", "NkfnSCJ5r9+LklIgcaYyhzLzndVtGTZ2cXOPtXS6KDwTDMbjJAZYYLXz7p+0DmHxlKB8Thc0H4W5 oU6YF7XDYw=="}, {"x-amz-request-id", "411dfa5f-c4a2-495d-a070-8fa909dba9c3"}, {"x-mws-request-id", "411dfa5f-c4a2-495d-a070-8fa909dba9c3"}, {"x-mws-timestamp", "2016-11-19T06:14:32.098Z"}, {"Vary", "Accept-Encoding,User-Agent"}], status_code: 200}}
  end

 #  def get_report_request_list_response do
 #    {:ok, %HTTPoison.Response{body: "<?xml version=\"1.0\"?>\n<GetReportRequestListResponse xmlns=\"http://mws.amazonaws.com/doc/2009-01-01/\">\n  <GetReportRequestListResult>\n    <HasNext>false</HasNext>\n    <ReportRequestInfo>\n      <ReportType>_GET_FBA_MYI_UNSUPPRESSED_INVENTORY_DATA_</ReportType>\n      <ReportProcessingStatus>_DONE_</ReportProcessingStatus>\n      <EndDate>2016-11-17T20:55:49+00:00</EndDate>\n      <Scheduled>false</Scheduled>\n      <ReportRequestId>50912017122</ReportRequestId>\n      <StartedProcessingDate>2016-11-17T20:55:54+00:00</StartedProcessingDate>\n      <SubmittedDate>2016-11-17T20:55:49+00:00</SubmittedDate>\n      <StartDate>2016-11-17T20:55:49+00:00</StartDate>\n      <CompletedDate>2016-11-17T20:56:04+00:00</CompletedDate>\n      <GeneratedReportId>3399094295017122</GeneratedReportId>\n    </ReportRequestInfo>\n  </GetReportRequestListResult>\n  <ResponseMetadata>\n    <RequestId>90329786-18b4-4035-8c66-d7d045d7acd1</RequestId>\n  </ResponseMetadata>\n</GetReportRequestListResponse>\n",
 # headers: [{"Server", "Server"}, {"Date", "Sat, 19 Nov 2016 03:43:18 GMT"},
 #  {"Content-Type", "text/xml"}, {"Content-Length", "978"},
 #  {"Connection", "keep-alive"}, {"x-mws-quota-max", "80.0"},
 #  {"x-mws-quota-remaining", "80.0"},
 #  {"x-mws-quota-resetsOn", "2016-11-19T04:18:00.000Z"},
 #  {"X-Amz-Date", "Sat, 19 Nov 2016 03:43:18 GMT"},
 #  {"x-amzn-Authorization",
 #   "AAA SignedHeaders=X-Amz-Date, identity=com.amazon.aaa.FrpAndromedaReportsPlugin.AndromedaControlService.amzn1.aaa.id.qhz3ylg755gkejyk5sh44qm3wy.Default/1, Signed=true, Encrypted=false, Signature=r7KAy8qMuW6GrprwY1N3vdow2LclYNApeg6tGs/b38w=, Algorithm=HmacSHA256"},
 #  {"x-mws-request-id", "90329786-18b4-4035-8c66-d7d045d7acd1"},
 #  {"x-mws-timestamp", "2016-11-19T03:43:18.324Z"},
 #  {"x-mws-response-context",
 #   "R2xbpYPH4/gtNLL9GFNxcge0eHp9d0qfnojIyevanXtN5HFK8WNby28JTkO7wplXPBJeIPWSiQlh rrI9oK7G7w=="},
 #  {"Vary", "Accept-Encoding,User-Agent"}], status_code: 200}}
 #  end

  test "parses response" do
    m = response |> MWSClient.Parser.parse
    list = get_in m, ["GetReportRequestListResponse","GetReportRequestListResult","ReportRequestInfo"]
    assert length(list) == 10
  end

  def response do
    {:ok,
 %HTTPoison.Response{body: "<?xml version=\"1.0\"?>\n<GetReportRequestListResponse xmlns=\"http://mws.amazonaws.com/doc/2009-01-01/\">\n  <GetReportRequestListResult>\n    <HasNext>true</HasNext>\n    <ReportRequestInfo>\n      <ReportType>_GET_FBA_MYI_UNSUPPRESSED_INVENTORY_DATA_</ReportType>\n      <ReportProcessingStatus>_DONE_</ReportProcessingStatus>\n      <EndDate>2016-11-18T20:53:00+00:00</EndDate>\n      <Scheduled>false</Scheduled>\n      <ReportRequestId>50920017123</ReportRequestId>\n      <StartedProcessingDate>2016-11-18T20:53:07+00:00</StartedProcessingDate>\n      <SubmittedDate>2016-11-18T20:53:00+00:00</SubmittedDate>\n      <StartDate>2016-11-18T20:53:00+00:00</StartDate>\n      <CompletedDate>2016-11-18T20:53:14+00:00</CompletedDate>\n      <GeneratedReportId>3412841972017123</GeneratedReportId>\n    </ReportRequestInfo>\n    <ReportRequestInfo>\n      <ReportType>_GET_AFN_INVENTORY_DATA_BY_COUNTRY_</ReportType>\n      <ReportProcessingStatus>_DONE_</ReportProcessingStatus>\n      <EndDate>2016-11-18T20:51:44+00:00</EndDate>\n      <Scheduled>false</Scheduled>\n      <ReportRequestId>50919017123</ReportRequestId>\n      <StartedProcessingDate>2016-11-18T20:51:49+00:00</StartedProcessingDate>\n      <SubmittedDate>2016-11-18T20:51:44+00:00</SubmittedDate>\n      <StartDate>2016-11-18T20:51:44+00:00</StartDate>\n      <CompletedDate>2016-11-18T20:51:57+00:00</CompletedDate>\n      <GeneratedReportId>3414908503017123</GeneratedReportId>\n    </ReportRequestInfo>\n    <ReportRequestInfo>\n      <ReportType>_GET_FBA_MYI_UNSUPPRESSED_INVENTORY_DATA_</ReportType>\n      <ReportProcessingStatus>_DONE_</ReportProcessingStatus>\n      <EndDate>2016-11-18T14:54:10+00:00</EndDate>\n      <Scheduled>false</Scheduled>\n      <ReportRequestId>50918017123</ReportRequestId>\n      <StartedProcessingDate>2016-11-18T14:54:17+00:00</StartedProcessingDate>\n      <SubmittedDate>2016-11-18T14:54:10+00:00</SubmittedDate>\n      <StartDate>2016-11-18T14:54:10+00:00</StartDate>\n      <CompletedDate>2016-11-18T14:54:24+00:00</CompletedDate>\n      <GeneratedReportId>3410642176017123</GeneratedReportId>\n    </ReportRequestInfo>\n    <ReportRequestInfo>\n      <ReportType>_GET_AFN_INVENTORY_DATA_BY_COUNTRY_</ReportType>\n      <ReportProcessingStatus>_DONE_</ReportProcessingStatus>\n      <EndDate>2016-11-18T14:52:26+00:00</EndDate>\n      <Scheduled>false</Scheduled>\n      <ReportRequestId>50917017123</ReportRequestId>\n      <StartedProcessingDate>2016-11-18T14:52:32+00:00</StartedProcessingDate>\n      <SubmittedDate>2016-11-18T14:52:26+00:00</SubmittedDate>\n      <StartDate>2016-11-18T14:52:26+00:00</StartDate>\n      <CompletedDate>2016-11-18T14:52:37+00:00</CompletedDate>\n      <GeneratedReportId>3417419172017123</GeneratedReportId>\n    </ReportRequestInfo>\n    <ReportRequestInfo>\n      <ReportType>_GET_FBA_MYI_UNSUPPRESSED_INVENTORY_DATA_</ReportType>\n      <ReportProcessingStatus>_DONE_</ReportProcessingStatus>\n      <EndDate>2016-11-18T08:53:49+00:00</EndDate>\n      <Scheduled>false</Scheduled>\n      <ReportRequestId>50916017123</ReportRequestId>\n      <StartedProcessingDate>2016-11-18T08:53:54+00:00</StartedProcessingDate>\n      <SubmittedDate>2016-11-18T08:53:49+00:00</SubmittedDate>\n      <StartDate>2016-11-18T08:53:49+00:00</StartDate>\n      <CompletedDate>2016-11-18T08:54:01+00:00</CompletedDate>\n      <GeneratedReportId>3408643280017123</GeneratedReportId>\n    </ReportRequestInfo>\n    <ReportRequestInfo>\n      <ReportType>_GET_AFN_INVENTORY_DATA_BY_COUNTRY_</ReportType>\n      <ReportProcessingStatus>_DONE_</ReportProcessingStatus>\n      <EndDate>2016-11-18T08:51:43+00:00</EndDate>\n      <Scheduled>false</Scheduled>\n      <ReportRequestId>50915017123</ReportRequestId>\n      <StartedProcessingDate>2016-11-18T08:51:49+00:00</StartedProcessingDate>\n      <SubmittedDate>2016-11-18T08:51:43+00:00</SubmittedDate>\n      <StartDate>2016-11-18T08:51:43+00:00</StartDate>\n      <CompletedDate>2016-11-18T08:51:55+00:00</CompletedDate>\n      <GeneratedReportId>3410105984017123</GeneratedReportId>\n    </ReportRequestInfo>\n    <ReportRequestInfo>\n      <ReportType>_GET_FBA_MYI_UNSUPPRESSED_INVENTORY_DATA_</ReportType>\n      <ReportProcessingStatus>_DONE_</ReportProcessingStatus>\n      <EndDate>2016-11-18T02:57:34+00:00</EndDate>\n      <Scheduled>false</Scheduled>\n      <ReportRequestId>50914017123</ReportRequestId>\n      <StartedProcessingDate>2016-11-18T02:57:39+00:00</StartedProcessingDate>\n      <SubmittedDate>2016-11-18T02:57:34+00:00</SubmittedDate>\n      <StartDate>2016-11-18T02:57:34+00:00</StartDate>\n      <CompletedDate>2016-11-18T02:57:46+00:00</CompletedDate>\n      <GeneratedReportId>3408556063017123</GeneratedReportId>\n    </ReportRequestInfo>\n    <ReportRequestInfo>\n      <ReportType>_GET_AFN_INVENTORY_DATA_BY_COUNTRY_</ReportType>\n      <ReportProcessingStatus>_DONE_</ReportProcessingStatus>\n      <EndDate>2016-11-18T02:55:59+00:00</EndDate>\n      <Scheduled>false</Scheduled>\n      <ReportRequestId>50913017123</ReportRequestId>\n      <StartedProcessingDate>2016-11-18T02:56:05+00:00</StartedProcessingDate>\n      <SubmittedDate>2016-11-18T02:55:59+00:00</SubmittedDate>\n      <StartDate>2016-11-18T02:55:59+00:00</StartDate>\n      <CompletedDate>2016-11-18T02:56:12+00:00</CompletedDate>\n      <GeneratedReportId>3402759511017123</GeneratedReportId>\n    </ReportRequestInfo>\n    <ReportRequestInfo>\n      <ReportType>_GET_FBA_MYI_UNSUPPRESSED_INVENTORY_DATA_</ReportType>\n      <ReportProcessingStatus>_DONE_</ReportProcessingStatus>\n      <EndDate>2016-11-17T20:55:49+00:00</EndDate>\n      <Scheduled>false</Scheduled>\n      <ReportRequestId>50912017122</ReportRequestId>\n      <StartedProcessingDate>2016-11-17T20:55:54+00:00</StartedProcessingDate>\n      <SubmittedDate>2016-11-17T20:55:49+00:00</SubmittedDate>\n      <StartDate>2016-11-17T20:55:49+00:00</StartDate>\n      <CompletedDate>2016-11-17T20:56:04+00:00</CompletedDate>\n      <GeneratedReportId>3399094295017122</GeneratedReportId>\n    </ReportRequestInfo>\n    <ReportRequestInfo>\n      <ReportType>_GET_AFN_INVENTORY_DATA_BY_COUNTRY_</ReportType>\n      <ReportProcessingStatus>_DONE_</ReportProcessingStatus>\n      <EndDate>2016-11-17T20:54:33+00:00</EndDate>\n      <Scheduled>false</Scheduled>\n      <ReportRequestId>50911017122</ReportRequestId>\n      <StartedProcessingDate>2016-11-17T20:54:39+00:00</StartedProcessingDate>\n      <SubmittedDate>2016-11-17T20:54:33+00:00</SubmittedDate>\n      <StartDate>2016-11-17T20:54:33+00:00</StartDate>\n      <CompletedDate>2016-11-17T20:54:45+00:00</CompletedDate>\n      <GeneratedReportId>3405850523017122</GeneratedReportId>\n    </ReportRequestInfo>\n    <NextToken>bnKUjUwrpfD2jpZedg0wbVuY6vtoszFEs90MCUIyGQ/PkNXwVrATLSf6YzH8PQiWICyhlLgHd4gqVtOYt5i3YX/y5ZICxITwrMWltwHPross7S2LHmNKmcpVErfopfm7ZgI5YM+bbLFRPCnQrq7eGPqiUs2SoKaRPxuuVZAjoAG5Hd34Twm1igafEPREmauvQPEfQK/OReJ9wNJ/XIY3rAvjRfjTJJa5YKoSylcR8gttj983g7esDr0wZ3V0GwaZstMPcqxOnL//uIo+owquzirF36SWlaJ9J5zSS6le1iIsxqkIMXCWKNSOyeZZ1ics+UXSqjS0c15jmJnjJN2V5uMEDoXRsC9PFEVVZ6joTY2uGFVSjAf2NsFIcEAdr4xQz2Y051TPxxk=</NextToken>\n  </GetReportRequestListResult>\n  <ResponseMetadata>\n    <RequestId>7509cdb2-0b69-4ca0-89dc-c77f8a747834</RequestId>\n  </ResponseMetadata>\n</GetReportRequestListResponse>\n",
  headers: [{"Server", "Server"}, {"Date", "Sat, 19 Nov 2016 00:39:11 GMT"},
   {"Content-Type", "text/xml"}, {"Content-Length", "7176"},
   {"Connection", "keep-alive"}, {"x-mws-quota-max", "80.0"},
   {"x-mws-quota-remaining", "80.0"},
   {"x-mws-quota-resetsOn", "2016-11-19T01:18:00.000Z"},
   {"X-Amz-Date", "Sat, 19 Nov 2016 00:39:11 GMT"},
   {"Vary", "Accept-Encoding,User-Agent"},
   {"x-amzn-Authorization",
    "AAA SignedHeaders=X-Amz-Date, identity=com.amazon.aaa.FrpAndromedaReportsPlugin.AndromedaControlService.amzn1.aaa.id.qhz3ylg755gkejyk5sh44qm3wy.Default/1, Signed=true, Encrypted=false, Signature=rgfE8s5KGby892a9azVdV9Bo6ylzu9ij2HqLCNjkrRw=, Algorithm=HmacSHA256"},
   {"x-mws-request-id", "7509cdb2-0b69-4ca0-89dc-c77f8a747834"},
   {"x-mws-timestamp", "2016-11-19T00:39:11.437Z"},
   {"x-mws-response-context",
    "3gARkJrMCs1FfvMGaZ5dDY3II8ydxA8IYhH4HVvANDVk1B9M8EM7wTo35I+/z6EfLKsiYVo/GCpp JhpeWTTzQA=="}],
  status_code: 200}}
  end

end