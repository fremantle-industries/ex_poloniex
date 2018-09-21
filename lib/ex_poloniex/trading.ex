defmodule ExPoloniex.Trading do
  @moduledoc """
  Module for Poloniex Trading API methods

  https://poloniex.com/support/api/
  """

  alias ExPoloniex.{DepositsAndWithdrawals, Api}

  @doc """
  Returns all of your available balances
  """
  def return_balances do
    case Api.trading("returnBalances") do
      {:ok, balances} -> {:ok, balances}
      {:error, _} = error -> error
    end
  end

  @doc """
  Returns all of your balances, including available balance, balance on orders, 
  and the estimated BTC value of your balance. By default, this call is limited 
  to your exchange account; set the "account" POST parameter to "all" to include 
  your margin and lending accounts
  """
  def return_complete_balances do
    case Api.trading("returnCompleteBalances") do
      {:ok, complete_balances} -> {:ok, complete_balances}
      {:error, _} = error -> error
    end
  end

  @doc false
  def return_complete_balances(:all) do
    case Api.trading("returnCompleteBalances", account: :all) do
      {:ok, complete_balances} -> {:ok, complete_balances}
      {:error, _} = error -> error
    end
  end

  @doc """
  Returns all of your deposit addresses
  """
  def return_deposit_addresses do
    case Api.trading("returnDepositAddresses") do
      {:ok, deposit_addresses} -> {:ok, deposit_addresses}
      {:error, _} = error -> error
    end
  end

  @doc """
  Generates a new deposit address for the currency specified by the "currency" 
  POST parameter
  """
  def generate_new_address(currency) do
    case Api.trading("generateNewAddress", currency: currency) do
      {:ok, %{"response" => new_address, "success" => 1}} -> {:ok, new_address}
      {:ok, %{"response" => response, "success" => 0}} -> {:error, response}
      {:error, _} = error -> error
    end
  end

  @doc """
  Returns your deposit and withdrawal history within a range, specified by the 
  "start" and "end" POST parameters, both of which should be given as UNIX timestamps
  """
  def return_deposits_withdrawals(%DateTime{} = start, %DateTime{} = to) do
    start_unix = DateTime.to_unix(start)
    end_unix = DateTime.to_unix(to)

    case Api.trading("returnDepositsWithdrawals", start: start_unix, end: end_unix) do
      {:ok, %{"deposits" => deposits, "withdrawals" => withdrawals}} ->
        {:ok, %DepositsAndWithdrawals{deposits: deposits, withdrawals: withdrawals}}

      {:error, _} = error ->
        error
    end
  end

  def return_market_rules do
    case Api.trading("returnMarketRules") do
      {:ok, rules} -> {:ok, rules}
      {:error, _} = error -> error
    end
  end

  @doc """
  Returns your open orders for a given market, specified by the "currencyPair" 
  POST parameter, e.g. "BTC_XCP". Set "currencyPair" to "all" to return open 
  orders for all markets
  """
  defdelegate return_open_orders(currency_pair),
    to: ExPoloniex.ReturnOpenOrders,
    as: :return_open_orders

  @doc """
  Returns the past 200 trades for a given market, or up to 50,000 trades between 
  a range specified in UNIX timestamps by the "start" and "end" GET parameters.
  """
  defdelegate return_trade_history(currency_pair, start, to),
    to: ExPoloniex.ReturnTradeHistory,
    as: :return_trade_history

  @doc """
  Returns all trades involving a given order, specified by the "orderNumber" 
  POST parameter. If no trades for the order have occurred or you specify an 
  order that does not belong to you, you will receive an error
  """
  defdelegate return_order_trades(order_number),
    to: ExPoloniex.ReturnOrderTrades,
    as: :return_order_trades

  @doc """
  Places a limit buy order in a given market. Required POST parameters are 
  "currencyPair", "rate", and "amount". If successful, the method will return 
  the order number.

  You may optionally set "fillOrKill", "immediateOrCancel", "postOnly" to 1. 
  A fill-or-kill order will either fill in its entirety or be completely aborted. 
  An immediate-or-cancel order can be partially or completely filled, but any 
  portion of the order that cannot be filled immediately will be canceled rather 
  than left on the order book. A post-only order will only be placed if no 
  portion of it fills immediately; this guarantees you will never pay the taker 
  fee on any part of the order that fills.
  """
  defdelegate buy(
                currency_pair,
                rate,
                amount,
                order_type \\ nil
              ),
              to: ExPoloniex.Buy,
              as: :buy

  @doc """
  Places a sell order in a given market. Parameters and output are the same as 
  for the buy method.
  """
  defdelegate sell(
                currency_pair,
                rate,
                amount,
                order_type \\ nil
              ),
              to: ExPoloniex.Sell,
              as: :sell

  @doc """
  Cancels an order you have placed in a given market. Required POST parameter is "orderNumber"
  """
  defdelegate cancel_order(order_number), to: ExPoloniex.CancelOrder, as: :cancel_order

  def move_order do
    {:error, :not_implemented}
  end

  def withdraw do
    {:error, :not_implemented}
  end

  @doc """
  If you are enrolled in the maker-taker fee schedule, returns your current 
  trading fees and trailing 30-day volume in BTC. This information is updated 
  once every 24 hours
  """
  defdelegate return_fee_info(), to: ExPoloniex.ReturnFeeInfo, as: :return_fee_info

  def return_available_account_balances do
    {:error, :not_implemented}
  end

  def return_tradable_balances do
    {:error, :not_implemented}
  end

  def transfer_balance do
    {:error, :not_implemented}
  end

  def return_margin_account_summary do
    {:error, :not_implemented}
  end

  def margin_buy do
    {:error, :not_implemented}
  end

  def margin_sell do
    {:error, :not_implemented}
  end

  def get_margin_position do
    {:error, :not_implemented}
  end

  def close_margin_position do
    {:error, :not_implemented}
  end

  def create_loan_offer do
    {:error, :not_implemented}
  end

  def cancel_loan_offer do
    {:error, :not_implemented}
  end

  def return_open_loan_offers do
    {:error, :not_implemented}
  end

  def return_active_loans do
    {:error, :not_implemented}
  end

  def return_lending_history do
    {:error, :not_implemented}
  end

  def toggle_auto_renew do
    {:error, :not_implemented}
  end
end
