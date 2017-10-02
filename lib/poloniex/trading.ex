defmodule Poloniex.Trading do
  @adapter Poloniex.HTTP

  def returnBalances do
    case post("returnBalances") do
      {:ok, balances} -> {:ok, balances}
      errors -> errors
    end
  end

  def returnCompleteBalances do
    case post("returnCompleteBalances") do
      {:ok, completeBalances} -> {:ok, completeBalances}
      errors -> errors
    end
  end

  def returnDepositAddresses do
    {:error, :not_implemented}
  end

  def generateNewAddress do
    {:error, :not_implemented}
  end

  def returnDepositsWithdrawals do
    {:error, :not_implemented}
  end

  def returnOpenOrders do
    {:error, :not_implemented}
  end

  def returnTradeHistory do
    {:error, :not_implemented}
  end

  def returnOrderTrades do
    {:error, :not_implemented}
  end

  def buy do
    {:error, :not_implemented}
  end

  def sell do
    {:error, :not_implemented}
  end

  def cancelOrder do
    {:error, :not_implemented}
  end

  def moveOrder do
    {:error, :not_implemented}
  end

  def withdraw do
    {:error, :not_implemented}
  end

  def returnFeeInfo do
    {:error, :not_implemented}
  end

  def returnAvailableAccountBalances do
    {:error, :not_implemented}
  end

  def returnTradableBalances do
    {:error, :not_implemented}
  end

  def transferBalance do
    {:error, :not_implemented}
  end

  def returnMarginAccountSummary do
    {:error, :not_implemented}
  end

  def marginBuy do
    {:error, :not_implemented}
  end

  def marginSell do
    {:error, :not_implemented}
  end

  def getMarginPosition do
    {:error, :not_implemented}
  end

  def closeMarginPosition do
    {:error, :not_implemented}
  end

  def createLoanOffer do
    {:error, :not_implemented}
  end

  def cancelLoanOffer do
    {:error, :not_implemented}
  end

  def returnOpenLoanOffers do
    {:error, :not_implemented}
  end

  def returnActiveLoans do
    {:error, :not_implemented}
  end

  def returnLendingHistory do
    {:error, :not_implemented}
  end

  def toggleAutoRenew do
    {:error, :not_implemented}
  end

  defp post(command) do
    @adapter.post("tradingApi", command)
  end
end
