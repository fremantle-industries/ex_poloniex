defmodule Poloniex.PublicTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest Poloniex.Public

  setup_all do
    ExVCR.Config.cassette_library_dir("test/fixture/vcr_cassettes")
  end

  test "return_ticker" do
    use_cassette "return_ticker" do
      HTTPoison.start
      {:ok, ticker} = Poloniex.Public.return_ticker()

      btc_eth = ticker["BTC_ETH"]
      assert btc_eth["baseVolume"] == "2614.12332326"
      assert btc_eth["high24hr"] == "0.07006446"
      assert btc_eth["highestBid"] == "0.06815003"
      assert btc_eth["id"] == 148
      assert btc_eth["isFrozen"] == "0"
      assert btc_eth["last"] == "0.06815003"
      assert btc_eth["low24hr"] == "0.06771983"
      assert btc_eth["lowestAsk"] == "0.06819298"
    end
  end

  test "return24Volume" do
    assert Poloniex.Public.return24Volume() == {:error, :not_implemented}
  end

  test "returnOrderBook" do
    assert Poloniex.Public.returnOrderBook() == {:error, :not_implemented}
  end

  test "returnTradeHistory" do
    assert Poloniex.Public.returnTradeHistory() == {:error, :not_implemented}
  end

  test "returnChartData" do
    assert Poloniex.Public.returnChartData() == {:error, :not_implemented}
  end

  test "returnCurrencies" do
    assert Poloniex.Public.returnCurrencies() == {:error, :not_implemented}
  end

  test "returnLoanOrders" do
    assert Poloniex.Public.returnLoanOrders() == {:error, :not_implemented}
  end
end
