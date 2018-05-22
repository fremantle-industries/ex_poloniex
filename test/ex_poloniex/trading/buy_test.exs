defmodule ExPoloniex.Trading.BuyTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ExPoloniex.{
    AuthenticationError,
    FillOrKillError,
    NotEnoughError,
    OrderDurations,
    OrderResponse,
    PostOnlyError,
    Trade,
    Trading
  }

  setup_all do
    HTTPoison.start()
  end

  test "buy with defaults returns an ok tuple with an order response of matching trades" do
    use_cassette "trading/buy_success_with_trades" do
      assert Trading.buy("BTC_LTC", 0.001, 0.4) == {
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
                     rate: 0.001,
                     total: 0.0004,
                     trade_id: "15961135",
                     type: "buy"
                   }
                 ]
               }
             }
    end
  end

  test "buy with fill_or_kill returns an ok tuple with the executed trades" do
    use_cassette "trading/buy_success_with_fill_or_kill" do
      assert Trading.buy("BTC_LTC", 0.0165, 0.01, %OrderDurations.FillOrKill{}) == {
               :ok,
               %ExPoloniex.OrderResponse{
                 amount_unfilled: nil,
                 order_number: "174286166423",
                 resulting_trades: [
                   %ExPoloniex.Trade{
                     amount: 0.01,
                     date: %DateTime{
                       year: 2018,
                       month: 5,
                       day: 22,
                       hour: 4,
                       minute: 29,
                       second: 01,
                       utc_offset: 0,
                       zone_abbr: "UTC",
                       time_zone: "Etc/UTC",
                       std_offset: 0
                     },
                     rate: 0.01607,
                     total: 0.0001607,
                     trade_id: "16001202",
                     type: "buy"
                   }
                 ]
               }
             }
    end
  end

  test "buy with fill_or_kill returns an error tuple when it can't execute the full size" do
    use_cassette "trading/buy_error_with_fill_or_kill_unable_to_fill_completely" do
      assert Trading.buy("BTC_LTC", 0.001, 0.1, %OrderDurations.FillOrKill{}) == {
               :error,
               %FillOrKillError{message: "Unable to fill order completely."}
             }
    end
  end

  test "buy with immediate_or_cancel returns an ok tuple with the order response and the amount unfilled" do
    use_cassette "trading/buy_success_with_immediate_or_cancel" do
      assert {
               :ok,
               %OrderResponse{
                 order_number: _,
                 amount_unfilled: 0.0,
                 resulting_trades: [trade]
               }
             } = Trading.buy("BTC_LTC", 0.017, 0.01, %OrderDurations.ImmediateOrCancel{})

      assert Trading.return_open_orders("BTC_LTC") == {:ok, []}

      assert trade == %ExPoloniex.Trade{
               amount: 0.01,
               date: %DateTime{
                 year: 2018,
                 month: 5,
                 day: 18,
                 hour: 19,
                 minute: 16,
                 second: 19,
                 utc_offset: 0,
                 zone_abbr: "UTC",
                 time_zone: "Etc/UTC",
                 std_offset: 0
               },
               rate: 0.01662373,
               total: 0.00016623,
               trade_id: "15983832",
               type: "buy"
             }
    end
  end

  test "buy with post_only returns an ok tuple that contains an order response with no trades" do
    use_cassette "trading/buy_success_with_post_only" do
      assert {
               :ok,
               %OrderResponse{
                 order_number: _,
                 amount_unfilled: nil,
                 resulting_trades: []
               }
             } = Trading.buy("BTC_LTC", 0.001, 0.4, %OrderDurations.PostOnly{})
    end
  end

  test "buy with post_only returns an error tuple when the price would take liquidity" do
    use_cassette "trading/buy_error_post_only_takes_liquidity" do
      assert Trading.buy("BTC_LTC", 0.017, 0.1, %OrderDurations.PostOnly{}) == {
               :error,
               %PostOnlyError{message: "Unable to place post-only order at this price."}
             }
    end
  end

  test "buy returns an error tuple when the api key is invalid" do
    use_cassette "trading/buy_error_invalid_api_key" do
      assert Trading.buy("BTC_LTC", 0.001, 0.1) == {
               :error,
               %AuthenticationError{message: "Invalid API key/secret pair."}
             }
    end
  end

  test "buy returns an error tuple when there is not enough quote currency" do
    use_cassette "trading/buy_error_not_enough" do
      assert Trading.buy("BTC_LTC", 0.001, 100) == {
               :error,
               %NotEnoughError{message: "Not enough BTC."}
             }
    end
  end

  test "buy returns an error tuple when the request times out" do
    use_cassette "trading/buy_error_timeout" do
      assert Trading.buy("BTC_LTC", 0.001, 0.1) == {
               :error,
               %HTTPoison.Error{id: nil, reason: "timeout"}
             }
    end
  end
end
