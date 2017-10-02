defmodule Poloniex.TradingTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest Poloniex.Trading

  setup_all do
    HTTPoison.start
    ExVCR.Config.cassette_library_dir("test/fixture/vcr_cassettes")
  end

  test "returnBalances is a map of available balanaces" do
    use_cassette "return_balances" do
      {:ok, balances} = Poloniex.Trading.returnBalances()
      assert balances["BTC"] == "0.00000000"
      assert balances["LTC"] == "0.00000000"
    end
  end

  test "returnCompleteBalances is a map of detailed balances" do
    use_cassette "return_complete_balances" do
      {:ok, completeBalances } = Poloniex.Trading.returnCompleteBalances()
      assert completeBalances["BTC"] == %{
        "available" => "0.00000000",
        "onOrders" => "0.00000000",
        "btcValue" => "0.00000000"
      }
      assert completeBalances["LTC"] == %{
        "available" => "0.00000000",
        "onOrders" => "0.00000000",
        "btcValue" => "0.00000000"
      }
    end
  end

  test "returnDepositAddresses is not implemented" do
    assert Poloniex.Trading.returnDepositAddresses() == {:error, :not_implemented}
  end

  test "generateNewAddress is not implemented" do
    assert Poloniex.Trading.generateNewAddress() == {:error, :not_implemented}
  end

  test "returnDepositsWithdrawals is not implemented" do
    assert Poloniex.Trading.returnDepositsWithdrawals() == {:error, :not_implemented}
  end

  test "returnOpenOrders is not implemented" do
    assert Poloniex.Trading.returnOpenOrders() == {:error, :not_implemented}
  end

  test "returnTradeHistory is not implemented" do
    assert Poloniex.Trading.returnTradeHistory() == {:error, :not_implemented}
  end

  test "returnOrderTrades is not implemented" do
    assert Poloniex.Trading.returnOrderTrades() == {:error, :not_implemented}
  end

  test "buy is not implemented" do
    assert Poloniex.Trading.buy() == {:error, :not_implemented}
  end

  test "sell is not implemented" do
    assert Poloniex.Trading.sell() == {:error, :not_implemented}
  end

  test "cancelOrder is not implemented" do
    assert Poloniex.Trading.cancelOrder() == {:error, :not_implemented}
  end

  test "moveOrder is not implemented" do
    assert Poloniex.Trading.moveOrder() == {:error, :not_implemented}
  end

  test "withdraw is not implemented" do
    assert Poloniex.Trading.withdraw() == {:error, :not_implemented}
  end

  test "returnFeeInfo is not implemented" do
    assert Poloniex.Trading.returnFeeInfo() == {:error, :not_implemented}
  end

  test "returnAvailableAccountBalances is not implemented" do
    assert Poloniex.Trading.returnAvailableAccountBalances() == {:error, :not_implemented}
  end

  test "returnTradableBalances is not implemented" do
    assert Poloniex.Trading.returnTradableBalances() == {:error, :not_implemented}
  end

  test "transferBalance is not implemented" do
    assert Poloniex.Trading.transferBalance() == {:error, :not_implemented}
  end

  test "returnMarginAccountSummary is not implemented" do
    assert Poloniex.Trading.returnMarginAccountSummary() == {:error, :not_implemented}
  end

  test "marginBuy is not implemented" do
    assert Poloniex.Trading.marginBuy() == {:error, :not_implemented}
  end

  test "marginSell is not implemented" do
    assert Poloniex.Trading.marginSell() == {:error, :not_implemented}
  end

  test "getMarginPosition is not implemented" do
    assert Poloniex.Trading.getMarginPosition() == {:error, :not_implemented}
  end

  test "closeMarginPosition is not implemented" do
    assert Poloniex.Trading.closeMarginPosition() == {:error, :not_implemented}
  end

  test "createLoanOffer is not implemented" do
    assert Poloniex.Trading.createLoanOffer() == {:error, :not_implemented}
  end

  test "cancelLoanOffer is not implemented" do
    assert Poloniex.Trading.cancelLoanOffer() == {:error, :not_implemented}
  end

  test "returnOpenLoanOffers is not implemented" do
    assert Poloniex.Trading.returnOpenLoanOffers() == {:error, :not_implemented}
  end

  test "returnActiveLoans is not implemented" do
    assert Poloniex.Trading.returnActiveLoans() == {:error, :not_implemented}
  end

  test "returnLendingHistory is not implemented" do
    assert Poloniex.Trading.returnLendingHistory() == {:error, :not_implemented}
  end

  test "toggleAutoRenew is not implemented" do
    assert Poloniex.Trading.toggleAutoRenew() == {:error, :not_implemented}
  end
end
