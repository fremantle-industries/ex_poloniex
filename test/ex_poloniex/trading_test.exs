defmodule ExPoloniex.TradingTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExPoloniex.Trading

  setup_all do
    HTTPoison.start()
  end

  test "return_balances is a map of available balanaces" do
    use_cassette "trading/return_balances" do
      {:ok, balances} = ExPoloniex.Trading.return_balances()
      assert balances["BTC"] == "0.00000000"
      assert balances["ETH"] == "0.00000000"
    end
  end

  test "return_complete_balances is a map of detailed balances for the exchange account" do
    use_cassette "trading/return_complete_balances" do
      {:ok, complete_balances} = ExPoloniex.Trading.return_complete_balances()

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
    use_cassette "trading/return_complete_balances_all" do
      {:ok, complete_balances} = ExPoloniex.Trading.return_complete_balances(:all)

      assert complete_balances["BTC"] == %{
               "available" => "0.00000002",
               "onOrders" => "0.00000001",
               "btcValue" => "0.00000003"
             }
    end
  end

  test "return_deposit_addresses is a map of currencies and their addresses" do
    use_cassette "trading/return_deposit_addresses" do
      {:ok, deposit_addresses} = ExPoloniex.Trading.return_deposit_addresses()

      assert deposit_addresses == %{
               "BTC" => "12cAHRr3hTA7irqN3qoSVK18YPdabHnKRY",
               "ETH" => "0x0bcfc6e600e09f697b60060ea630ed552069a367",
               "LTC" => "LdDrX4dFYV86Y4XpdVXnaV46DVas1yM5xJ"
             }
    end
  end

  test "generate_new_address returns an ok, address tuple" do
    use_cassette "trading/generate_new_address_success" do
      assert ExPoloniex.Trading.generate_new_address("USDT") == {
               :ok,
               "1JzN2JMR4epnx1iv7LVFuqfZhHQ7wCVJsN"
             }
    end
  end

  test "generate_new_address returns an error tuple when it tries to generate multiple addresses on the same day" do
    use_cassette "trading/generate_new_address_error_same_day" do
      assert ExPoloniex.Trading.generate_new_address("USDT") == {
               :error,
               "You may only generate one deposit address per currency per day."
             }
    end
  end

  test "generate_new_address returns an error tuple when the api key is invalid" do
    use_cassette "trading/generate_new_address_error_invalid_api_key" do
      assert ExPoloniex.Trading.generate_new_address("USDT") == {
               :error,
               %ExPoloniex.AuthenticationError{message: "Invalid API key/secret pair."}
             }
    end
  end

  test "return_deposits_withdrawals is an ok, map tuple of deposits and withdrawals" do
    use_cassette "trading/return_deposits_withdrawals_success" do
      to = Timex.now()
      start = Timex.shift(to, days: -1)

      assert ExPoloniex.Trading.return_deposits_withdrawals(start, to) == {
               :ok,
               %ExPoloniex.DepositsAndWithdrawals{
                 deposits: [
                   %{
                     "address" => "LdDrX4dFYV86Y4XpdVXnaV46DVas1yM5xJ",
                     "amount" => "1.00067800",
                     "confirmations" => 3,
                     "currency" => "LTC",
                     "status" => "COMPLETE",
                     "timestamp" => 1_526_259_357,
                     "txid" => "800dd8913e89cb71ecf01dbaf83b2c88a6c3da559f842df815060e6918a8d6e9"
                   }
                 ],
                 withdrawals: []
               }
             }
    end
  end

  test "return_deposits_withdrawals is an error tuple when the api key is invalid" do
    use_cassette "trading/return_deposits_withdrawals_error_invalid_api_key" do
      to = Timex.now()
      start = Timex.shift(to, years: -100)

      assert ExPoloniex.Trading.return_deposits_withdrawals(start, to) == {
               :error,
               %ExPoloniex.AuthenticationError{message: "Invalid API key/secret pair."}
             }
    end
  end

  test "move_order is not implemented" do
    assert ExPoloniex.Trading.move_order() == {:error, :not_implemented}
  end

  test "withdraw is not implemented" do
    assert ExPoloniex.Trading.withdraw() == {:error, :not_implemented}
  end

  test "return_available_account_balances is not implemented" do
    assert ExPoloniex.Trading.return_available_account_balances() == {:error, :not_implemented}
  end

  test "return_tradable_balances is not implemented" do
    assert ExPoloniex.Trading.return_tradable_balances() == {:error, :not_implemented}
  end

  test "transfer_balance is not implemented" do
    assert ExPoloniex.Trading.transfer_balance() == {:error, :not_implemented}
  end

  test "return_margin_account_summary is not implemented" do
    assert ExPoloniex.Trading.return_margin_account_summary() == {:error, :not_implemented}
  end

  test "margin_buy is not implemented" do
    assert ExPoloniex.Trading.margin_buy() == {:error, :not_implemented}
  end

  test "margin_sell is not implemented" do
    assert ExPoloniex.Trading.margin_sell() == {:error, :not_implemented}
  end

  test "get_margin_position is not implemented" do
    assert ExPoloniex.Trading.get_margin_position() == {:error, :not_implemented}
  end

  test "close_margin_position is not implemented" do
    assert ExPoloniex.Trading.close_margin_position() == {:error, :not_implemented}
  end

  test "create_loan_offer is not implemented" do
    assert ExPoloniex.Trading.create_loan_offer() == {:error, :not_implemented}
  end

  test "cancel_loan_offer is not implemented" do
    assert ExPoloniex.Trading.cancel_loan_offer() == {:error, :not_implemented}
  end

  test "return_open_loan_offers is not implemented" do
    assert ExPoloniex.Trading.return_open_loan_offers() == {:error, :not_implemented}
  end

  test "return_active_loans is not implemented" do
    assert ExPoloniex.Trading.return_active_loans() == {:error, :not_implemented}
  end

  test "return_lending_history is not implemented" do
    assert ExPoloniex.Trading.return_lending_history() == {:error, :not_implemented}
  end

  test "toggle_auto_renew is not implemented" do
    assert ExPoloniex.Trading.toggle_auto_renew() == {:error, :not_implemented}
  end
end
