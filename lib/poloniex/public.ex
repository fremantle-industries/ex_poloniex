defmodule Poloniex.Public do
  @adapter Poloniex.HTTP

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

  def return_order_book(symbol) do
    case get("returnOrderBook", %{currencyPair: symbol}) do
      {:ok, order_book} -> {:ok, order_book}
      errors -> errors
    end
  end

  def return_trade_history(symbol, start_time, end_time) do
    case get("returnTradeHistory", %{currencyPair: symbol, start: start_time, end: end_time}) do
      {:ok, trade_history} -> {:ok, trade_history}
      errors -> errors
    end
  end

  def return_chart_data(symbol, start_time, end_time, period) do
    case get("returnChartData", %{currencyPair: symbol, start: start_time, end: end_time, period: period}) do
      {:ok, chart_data} -> {:ok, chart_data}
      errors -> errors
    end
  end

  def return_currencies do
    case get("returnCurrencies") do
      {:ok, currencies} -> {:ok, currencies}
      errors -> errors
    end
  end

  def return_loan_orders(currency) do
    case get("returnLoanOrders", %{currency: currency}) do
      {:ok, loan_orders} -> {:ok, loan_orders}
      errors -> errors
    end
  end

  defp get(command) do
    get(command, %{})
  end

  defp get(command, params) do
    @adapter.get("public", command, params)
  end
end
