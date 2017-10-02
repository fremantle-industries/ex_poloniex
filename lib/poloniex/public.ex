defmodule Poloniex.Public do
  @adapter Application.get_env(:poloniex, :adapter)

  def return_ticker do
    case get("returnTicker") do
      {:ok, balances} -> {:ok, balances}
      errors -> errors
    end
  end

  def return_24h_volume do
    case get("return24hVolume") do
      {:ok, volume} -> {:ok, volume}
      errors -> errors
    end
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
