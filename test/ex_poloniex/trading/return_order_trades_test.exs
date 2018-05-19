defmodule ExPoloniex.Trading.ReturnOrderTradesTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ExPoloniex.{AuthenticationError, InvalidOrderNumberError, Trading}

  test "return_order_trades" do
    use_cassette "trading/return_order_trades_success" do
      assert Trading.return_order_trades("173622544709") == {
               :ok,
               [
                 %{
                   "amount" => "0.01000000",
                   "currencyPair" => "BTC_LTC",
                   "date" => "2018-05-19 00:27:24",
                   "fee" => "0.00200000",
                   "globalTradeID" => 372_942_295,
                   "rate" => "0.01648501",
                   "total" => "0.00016485",
                   "tradeID" => 15_985_164,
                   "type" => "sell"
                 }
               ]
             }
    end
  end

  test "return_order_trades returns an error tuple when the order id is invalid" do
    use_cassette "trading/return_order_trades_error_invalid_order_number" do
      assert Trading.return_order_trades("abc123") == {
               :error,
               %InvalidOrderNumberError{message: "Invalid orderNumber parameter."}
             }
    end
  end

  test "return_order_trades returns an error tuple when the order number doesn't exist" do
    use_cassette "trading/return_order_trades_error_order_number_not_found" do
      assert Trading.return_order_trades("1") == {
               :error,
               %InvalidOrderNumberError{
                 message: "Order not found, or you are not the person who placed it."
               }
             }
    end
  end

  test "return_order_trades returns an error tuple when the api key is invalid" do
    use_cassette "trading/return_order_trades_error_invalid_api_key" do
      assert Trading.return_order_trades("173622544709") == {
               :error,
               %AuthenticationError{
                 message: "Invalid API key/secret pair."
               }
             }
    end
  end

  test "return_order_trades returns an error tuple when request times out" do
    use_cassette "trading/return_order_trades_error_timeout" do
      assert Trading.return_order_trades("173622544709") == {
               :error,
               %HTTPoison.Error{id: nil, reason: "timeout"}
             }
    end
  end
end
