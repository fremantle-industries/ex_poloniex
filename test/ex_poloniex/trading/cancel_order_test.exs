defmodule ExPoloniex.Trading.CancelOrderTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ExPoloniex.{AuthenticationError, InvalidOrderNumberError, Trading}

  setup_all do
    HTTPoison.start()
  end

  test "cancel_order returns an ok tuple with the amount that was cancelled" do
    use_cassette "trading/cancel_order_success" do
      assert Trading.cancel_order("172539290048") == {
               :ok,
               0.4
             }
    end
  end

  test "cancel_order returns an error tuple when the order number doesn't exist" do
    use_cassette "trading/cancel_order_invalid_order_number" do
      assert Trading.cancel_order("172535796545") == {
               :error,
               %InvalidOrderNumberError{
                 message: "Invalid order number, or you are not the person who placed the order."
               }
             }
    end
  end

  test "cancel_order returns an error tuple when the order number is an invalid format" do
    use_cassette "trading/cancel_order_invalid_order_number_format" do
      assert Trading.cancel_order("abc123") == {
               :error,
               %InvalidOrderNumberError{
                 message: "Invalid orderNumber parameter."
               }
             }
    end
  end

  test "cancel_order returns an error tuple when the api key is invalid" do
    use_cassette "trading/cancel_order_invalid_api_key" do
      assert Trading.cancel_order("172535796545") == {
               :error,
               %AuthenticationError{message: "Invalid API key/secret pair."}
             }
    end
  end

  test "cancel_order returns an error tuple when the request times out" do
    use_cassette "trading/cancel_order_error_timeout" do
      assert Trading.cancel_order("172535796545") == {
               :error,
               %HTTPoison.Error{id: nil, reason: "timeout"}
             }
    end
  end
end
