defmodule Poloniex.Public do
  @adapter Application.get_env(:poloniex, :adapter)

  def return_ticker do
    case get("returnTicker") do
      {:ok, balances} -> {:ok, balances}
      errors -> errors
    end
  end

  def return24Volume do
    {:error, :not_implemented}
  end

  def returnOrderBook do
    {:error, :not_implemented}
  end

  def returnTradeHistory do
    {:error, :not_implemented}
  end

  def returnChartData do
    {:error, :not_implemented}
  end

  def returnCurrencies do
    {:error, :not_implemented}
  end

  def returnLoanOrders do
    {:error, :not_implemented}
  end

  defp get(command) do
    @adapter.get("public", command)
  end
end
