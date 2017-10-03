defmodule Poloniex.TradingTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest Poloniex.Trading

  setup_all do
    HTTPoison.start
    ExVCR.Config.cassette_library_dir("test/fixture/vcr_cassettes")
  end

  test "return_balances is a map of available balanaces" do
    use_cassette "return_balances" do
      {:ok, balances} = Poloniex.Trading.return_balances()
      assert balances["BTC"] == "0.00000000"
      assert balances["ETH"] == "0.00000000"
    end
  end

  test "return_complete_balances is a map of detailed balances for the exchange account" do
    use_cassette "return_complete_balances" do
      {:ok, complete_balances } = Poloniex.Trading.return_complete_balances()
      assert complete_balances["BTC"] == %{
        "available" => "0.00000000",
        "onOrders" => "0.00000000",
        "btcValue" => "0.00000000"
      }
      assert complete_balances["ETH"] == %{
        "available" => "0.00000000",
        "onOrders" => "0.00000000",
        "btcValue" => "0.00000000"
      }
    end
  end

  test "return_complete_balances can include balances from the margin and lending accounts" do
    use_cassette "return_complete_balances_all" do
      {:ok, complete_balances } = Poloniex.Trading.return_complete_balances(:all)
      assert complete_balances["BTC"] == %{
        "available" => "0.00000002",
        "onOrders" => "0.00000001",
        "btcValue" => "0.00000003"
      }
    end
  end

  test "return_deposit_addresses is not implemented" do
    assert Poloniex.Trading.return_deposit_addresses() == {:error, :not_implemented}
  end

  test "generate_new_address is not implemented" do
    assert Poloniex.Trading.generate_new_address() == {:error, :not_implemented}
  end

  test "return_deposits_withdrawals is not implemented" do
    assert Poloniex.Trading.return_deposits_withdrawals() == {:error, :not_implemented}
  end

  test "return_open_orders is not implemented" do
    assert Poloniex.Trading.return_open_orders() == {:error, :not_implemented}
  end

  test "return_trade_history is not implemented" do
    assert Poloniex.Trading.return_trade_history() == {:error, :not_implemented}
  end

  test "return_order_trades is not implemented" do
    assert Poloniex.Trading.return_order_trades() == {:error, :not_implemented}
  end

  test "buy is not implemented" do
    assert Poloniex.Trading.buy() == {:error, :not_implemented}
  end

  test "sell is not implemented" do
    assert Poloniex.Trading.sell() == {:error, :not_implemented}
  end

  test "cancel_order is not implemented" do
    assert Poloniex.Trading.cancel_order() == {:error, :not_implemented}
  end

  test "move_order is not implemented" do
    assert Poloniex.Trading.move_order() == {:error, :not_implemented}
  end

  test "withdraw is not implemented" do
    assert Poloniex.Trading.withdraw() == {:error, :not_implemented}
  end

  test "return_fee_info is not implemented" do
    assert Poloniex.Trading.return_fee_info() == {:error, :not_implemented}
  end

  test "return_available_account_balances is not implemented" do
    assert Poloniex.Trading.return_available_account_balances() == {:error, :not_implemented}
  end

  test "return_tradable_balances is not implemented" do
    assert Poloniex.Trading.return_tradable_balances() == {:error, :not_implemented}
  end

  test "transfer_balance is not implemented" do
    assert Poloniex.Trading.transfer_balance() == {:error, :not_implemented}
  end

  test "return_margin_account_summary is not implemented" do
    assert Poloniex.Trading.return_margin_account_summary() == {:error, :not_implemented}
  end

  test "margin_buy is not implemented" do
    assert Poloniex.Trading.margin_buy() == {:error, :not_implemented}
  end

  test "margin_sell is not implemented" do
    assert Poloniex.Trading.margin_sell() == {:error, :not_implemented}
  end

  test "get_margin_position is not implemented" do
    assert Poloniex.Trading.get_margin_position() == {:error, :not_implemented}
  end

  test "close_margin_position is not implemented" do
    assert Poloniex.Trading.close_margin_position() == {:error, :not_implemented}
  end

  test "create_loan_offer is not implemented" do
    assert Poloniex.Trading.create_loan_offer() == {:error, :not_implemented}
  end

  test "cancel_loan_offer is not implemented" do
    assert Poloniex.Trading.cancel_loan_offer() == {:error, :not_implemented}
  end

  test "return_open_loan_offers is not implemented" do
    assert Poloniex.Trading.return_open_loan_offers() == {:error, :not_implemented}
  end

  test "return_active_loans is not implemented" do
    assert Poloniex.Trading.return_active_loans() == {:error, :not_implemented}
  end

  test "return_lending_history is not implemented" do
    assert Poloniex.Trading.return_lending_history() == {:error, :not_implemented}
  end

  test "toggle_auto_renew is not implemented" do
    assert Poloniex.Trading.toggle_auto_renew() == {:error, :not_implemented}
  end
end
