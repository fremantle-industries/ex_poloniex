defmodule ExPoloniex.Trading.SellTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ExPoloniex.{
    AuthenticationError,
    FillOrKillError,
    NotEnoughError,
    OrderLifetime,
    OrderResponse,
    PostOnlyError,
    Trade,
    Trading
  }

  setup_all do
    HTTPoison.start()
  end

  test "sell with defaults returns an ok tuple with an order response of matching trades" do
    use_cassette "trading/sell_success_with_trades" do
      assert Trading.sell("BTC_LTC", 0.16, 0.4) == {
               :ok,
               %OrderResponse{
                 order_number: "172724866286",
                 amount_unfilled: nil,
                 resulting_trades: [
                   %Trade{
                     amount: 0.4,
                     date: %DateTime{
                       year: 2018,
                       month: 5,
                       day: 15,
                       hour: 3,
                       minute: 12,
                       second: 28,
                       utc_offset: 0,
                       zone_abbr: "UTC",
                       time_zone: "Etc/UTC",
                       std_offset: 0
                     },
                     rate: 0.01675568,
                     total: 0.00670227,
                     trade_id: "15961135",
                     type: "sell"
                   }
                 ]
               }
             }
    end
  end

  test "sell with fill_or_kill returns an error tuple when it can't execute the full size" do
    use_cassette "trading/sell_success_with_fill_or_kill" do
      assert Trading.sell("BTC_LTC", 0.16, 0.1, %OrderLifetime.FillOrKill{}) == {
               :error,
               %FillOrKillError{message: "Unable to fill order completely."}
             }
    end
  end

  test "sell with immediate_or_cancel returns an ok tuple with the order response and the amount unfilled" do
    use_cassette "trading/sell_success_with_immediate_or_cancel" do
      assert {
               :ok,
               %OrderResponse{
                 order_number: _,
                 amount_unfilled: 0.0,
                 resulting_trades: [trade]
               }
             } = Trading.sell("BTC_LTC", 0.015, 0.01, %OrderLifetime.ImmediateOrCancel{})

      assert Trading.return_open_orders("BTC_LTC") == {:ok, []}

      assert trade == %ExPoloniex.Trade{
               amount: 0.01,
               date: %DateTime{
                 year: 2018,
                 month: 5,
                 day: 19,
                 hour: 00,
                 minute: 27,
                 second: 24,
                 utc_offset: 0,
                 zone_abbr: "UTC",
                 time_zone: "Etc/UTC",
                 std_offset: 0
               },
               rate: 0.01648501,
               total: 0.00016485,
               trade_id: "15985164",
               type: "sell"
             }
    end
  end

  test "sell with post_only returns an ok tuple that contains an order response with no trades" do
    use_cassette "trading/sell_success_with_post_only" do
      assert {
               :ok,
               %OrderResponse{
                 order_number: _,
                 amount_unfilled: nil,
                 resulting_trades: []
               }
             } = Trading.sell("BTC_LTC", 0.16, 0.1, %OrderLifetime.PostOnly{})
    end
  end

  test "sell with post_only returns an error tuple when the price would take liquidity" do
    use_cassette "trading/sell_error_post_only_takes_liquidity" do
      assert Trading.sell("BTC_LTC", 0.01, 0.1, %OrderLifetime.PostOnly{}) == {
               :error,
               %PostOnlyError{message: "Unable to place post-only order at this price."}
             }
    end
  end

  test "sell is an error tuple when there is not enough base currency" do
    use_cassette "trading/sell_error_not_enough" do
      assert Trading.sell("BTC_LTC", 0.1, 100) == {
               :error,
               %NotEnoughError{message: "Not enough LTC."}
             }
    end
  end

  test "sell is an error tuple when the api key is invalid" do
    use_cassette "trading/sell_error_invalid_api_key" do
      assert Trading.sell("BTC_LTC", 0.1, 0.4) == {
               :error,
               %AuthenticationError{message: "Invalid API key/secret pair."}
             }
    end
  end

  test "sell is an error tuple the request times out" do
    use_cassette "trading/sell_error_timeout" do
      assert Trading.sell("BTC_LTC", 0.1, 0.4) == {
               :error,
               %HTTPoison.Error{id: nil, reason: "timeout"}
             }
    end
  end
end
