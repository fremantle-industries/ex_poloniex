defmodule ExPoloniex.Trading.ReturnTradeHistoryTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ExPoloniex.{AuthenticationError, HistoricalTrade, Trading}

  test "return_trade_history returns an ok tuple with a list of historical trades" do
    use_cassette "trading/return_trade_history_success" do
      to = Timex.now()
      start = Timex.shift(to, days: -1)

      assert Trading.return_trade_history("BTC_LTC", start, to) == {
               :ok,
               [
                 %HistoricalTrade{
                   amount: 0.01,
                   category: "exchange",
                   date: %DateTime{
                     year: 2018,
                     month: 5,
                     day: 19,
                     hour: 0,
                     minute: 27,
                     second: 24,
                     utc_offset: 0,
                     zone_abbr: "UTC",
                     time_zone: "Etc/UTC",
                     std_offset: 0
                   },
                   fee: 0.002,
                   global_trade_id: 372_942_295,
                   order_number: "173622544709",
                   rate: 0.01648501,
                   total: 0.00016485,
                   trade_id: "15985164",
                   type: "sell"
                 }
               ]
             }
    end
  end

  test "return_fee_info is an error tuple when the api key is invalid" do
    use_cassette "trading/return_trade_history_error_invalid_api_key" do
      to = Timex.now()
      start = Timex.shift(to, days: -1)

      assert Trading.return_trade_history("BTC_LTC", start, to) == {
               :error,
               %AuthenticationError{message: "Invalid API key/secret pair."}
             }
    end
  end

  test "return_trade_history returns an error tuple when the request times out" do
    use_cassette "trading/return_trade_history_error_timeout" do
      to = Timex.now()
      start = Timex.shift(to, days: -1)

      assert Trading.return_trade_history("BTC_LTC", start, to) == {
               :error,
               %HTTPoison.Error{id: nil, reason: "timeout"}
             }
    end
  end
end
