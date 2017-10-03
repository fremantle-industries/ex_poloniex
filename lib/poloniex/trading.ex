defmodule Poloniex.Trading do
  @moduledoc """
  Module for Poloniex Trading API methods

  https://poloniex.com/support/api/
  """

  @adapter Poloniex.HTTP

  def return_balances do
    case post("returnBalances") do
      {:ok, balances} -> {:ok, balances}
      errors -> errors
    end
  end

  def return_complete_balances do
    case post("returnCompleteBalances") do
      {:ok, completeBalances} -> {:ok, completeBalances}
      errors -> errors
    end
  end

  def return_complete_balances(:all) do
    case post("returnCompleteBalances", account: :all) do
      {:ok, completeBalances} -> {:ok, completeBalances}
      errors -> errors
    end
  end

  def return_deposit_addresses do
    {:error, :not_implemented}
  end

  def generate_new_address do
    {:error, :not_implemented}
  end

  def return_deposits_withdrawals do
    {:error, :not_implemented}
  end

  def return_open_orders do
    {:error, :not_implemented}
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

  def return_fee_info do
    {:error, :not_implemented}
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

  defp post(command, params) do
    @adapter.post("tradingApi", command, params)
  end

  defp post(command) do
    post(command, %{})
  end
end
