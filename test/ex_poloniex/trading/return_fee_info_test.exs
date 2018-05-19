defmodule ExPoloniex.Trading.ReturnFeeInfoTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias ExPoloniex.{AuthenticationError, Trading}

  test "return_fee_info returns an ok, fee details map on success" do
    use_cassette "trading/return_fee_info_success" do
      assert Trading.return_fee_info() == {
               :ok,
               %{
                 "makerFee" => "0.00150000",
                 "nextTier" => "600.00000000",
                 "takerFee" => "0.00250000",
                 "thirtyDayVolume" => "0.00000000"
               }
             }
    end
  end

  test "return_fee_info is an error tuple when the api key is invalid" do
    use_cassette "trading/return_fee_info_invalid_api_key" do
      assert Trading.return_fee_info() == {
               :error,
               %AuthenticationError{message: "Invalid API key/secret pair."}
             }
    end
  end

  test "return_fee_info returns an error tuple when the request times out" do
    use_cassette "trading/return_fee_info_error_timeout" do
      assert Trading.return_fee_info() == {
               :error,
               %HTTPoison.Error{id: nil, reason: "timeout"}
             }
    end
  end
end
