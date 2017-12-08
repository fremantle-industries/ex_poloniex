defmodule ExPoloniex.Public do
  @moduledoc """
  Module for Poloniex Public API methods

  https://poloniex.com/support/api/
  """

  @adapter ExPoloniex.HTTP

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

  def return_trade_history(currencyPair, start_time, end_time) do
    params = %{
      currencyPair: currencyPair,
      start: start_time,
      end: end_time
    }

    case get("returnTradeHistory", params) do
      {:ok, trade_history} -> {:ok, trade_history}
      errors -> errors
    end
  end

  def return_chart_data(currencyPair, start_time, end_time, period) do
    params = %{
      currencyPair: currencyPair,
      start: start_time,
      end: end_time,
      period: period
    }

    case get("returnChartData", params) do
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
