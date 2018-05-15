defmodule ExPoloniex.Trading do
  @moduledoc """
  Module for Poloniex Trading API methods

  https://poloniex.com/support/api/
  """

  alias ExPoloniex.{DepositsAndWithdrawals, PostTrading}

  defdelegate post(command, params), to: PostTrading, as: :post
  defdelegate post(command), to: PostTrading, as: :post

  @doc """
  Returns all of your available balances
  """
  def return_balances do
    case post("returnBalances") do
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
    case post("returnCompleteBalances") do
      {:ok, complete_balances} -> {:ok, complete_balances}
      {:error, _} = error -> error
    end
  end

  @doc false
  def return_complete_balances(:all) do
    case post("returnCompleteBalances", account: :all) do
      {:ok, complete_balances} -> {:ok, complete_balances}
      {:error, _} = error -> error
    end
  end

  @doc """
  Returns all of your deposit addresses
  """
  def return_deposit_addresses do
    case post("returnDepositAddresses") do
      {:ok, deposit_addresses} -> {:ok, deposit_addresses}
      {:error, _} = error -> error
    end
  end

  @doc """
  Generates a new deposit address for the currency specified by the "currency" 
  POST parameter
  """
  def generate_new_address(currency) do
    case post("generateNewAddress", currency: currency) do
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

    case post("returnDepositsWithdrawals", start: start_unix, end: end_unix) do
      {:ok, %{"deposits" => deposits, "withdrawals" => withdrawals}} ->
        {:ok, %DepositsAndWithdrawals{deposits: deposits, withdrawals: withdrawals}}

      {:error, _} = error ->
        error
    end
  end

  @doc """
  Returns your open orders for a given market, specified by the "currencyPair" 
  POST parameter, e.g. "BTC_XCP". Set "currencyPair" to "all" to return open 
  orders for all markets
  """
  def return_open_orders(currency_pair) do
    case post("returnOpenOrders", currencyPair: currency_pair) do
      {:ok, open_orders} -> {:ok, open_orders}
      {:error, _} = error -> error
    end
  end

  def return_trade_history do
    {:error, :not_implemented}
  end

  def return_order_trades do
    {:error, :not_implemented}
  end

  def buy do
    {:error, :not_implemented}
  end

  def sell do
    {:error, :not_implemented}
  end

  def cancel_order do
    {:error, :not_implemented}
  end

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
  def return_fee_info do
    case post("returnFeeInfo") do
      {:ok, open_orders} -> {:ok, open_orders}
      {:error, _} = error -> error
    end
  end

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
