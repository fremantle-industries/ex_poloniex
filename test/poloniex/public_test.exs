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

  test "return_24h_volume" do
    use_cassette "return_24h_volume" do
      HTTPoison.start
      {:ok, volume} = Poloniex.Public.return_24h_volume()

      assert volume["BTC_ETH"] == %{"BTC" => "3310.97290886", "ETH" => "48516.34110835"}
      assert volume["totalBTC"] == "16429.79923551"
      assert volume["totalETH"] == "5505.89292550"
      assert volume["totalUSDT"] == "32328513.94307584"
      assert volume["totalXMR"] == "549.96018989"
      assert volume["totalXUSD"] == "0.00000000"
    end
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
