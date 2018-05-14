defmodule ExPoloniex.Trading.ReturnOpenOrdersTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ExPoloniex.{
    AuthenticationError,
    OpenOrder,
    Trading
  }

  setup_all do
    HTTPoison.start()
  end

  test "return_open_orders with all pairs is an ok tuple with a map of open orders by" do
    use_cassette "return_open_orders_success_all" do
      assert {:ok, %{} = open_orders} = Trading.return_open_orders("all")
      assert open_orders["BTC_VRC"] == []

      assert open_orders["BTC_LTC"] == [
               %OpenOrder{
                 amount: 1.00067800,
                 date: %DateTime{
                   year: 2018,
                   month: 5,
                   day: 14,
                   hour: 2,
                   minute: 35,
                   second: 58,
                   utc_offset: 0,
                   zone_abbr: "UTC",
                   time_zone: "Etc/UTC",
                   std_offset: 0
                 },
                 margin: 0,
                 order_number: "172521081275",
                 rate: 0.02690000,
                 starting_amount: 1.00067800,
                 total: 0.02691823,
                 type: "sell"
               }
             ]
    end
  end

  test "return_open_orders for a pair is an ok tuple with a list of open orders" do
    use_cassette "return_open_orders_success_currency_pair" do
      assert Trading.return_open_orders("BTC_LTC") == {
               :ok,
               [
                 %OpenOrder{
                   amount: 1.0,
                   date: %DateTime{
                     year: 2018,
                     month: 5,
                     day: 18,
                     hour: 18,
                     minute: 45,
                     second: 46,
                     utc_offset: 0,
                     zone_abbr: "UTC",
                     time_zone: "Etc/UTC",
                     std_offset: 0
                   },
                   margin: 0,
                   order_number: "173571989315",
                   rate: 0.0001,
                   starting_amount: 1.0,
                   total: 0.0001,
                   type: "buy"
                 },
                 %OpenOrder{
                   amount: 1.0,
                   date: %DateTime{
                     year: 2018,
                     month: 5,
                     day: 18,
                     hour: 18,
                     minute: 42,
                     second: 06,
                     utc_offset: 0,
                     zone_abbr: "UTC",
                     time_zone: "Etc/UTC",
                     std_offset: 0
                   },
                   margin: 0,
                   order_number: "173571435869",
                   rate: 0.001,
                   starting_amount: 1.0,
                   total: 0.001,
                   type: "buy"
                 }
               ]
             }
    end
  end

  test "return_open_orders is an error tuple when the api key is invalid" do
    use_cassette "return_open_orders_invalid_api_key" do
      assert Trading.return_open_orders("all") == {
               :error,
               %AuthenticationError{message: "Invalid API key/secret pair."}
             }
    end
  end

  test "return_open_orders returns an error tuple when the request times out" do
    use_cassette "return_open_orders_error_timeout" do
      assert Trading.return_open_orders("all") == {
               :error,
               %HTTPoison.Error{id: nil, reason: "timeout"}
             }
    end
  end
end
