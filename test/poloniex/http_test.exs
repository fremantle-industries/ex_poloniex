defmodule Poloniex.HTTPTest do
  use ExUnit.Case
  doctest Poloniex.HTTP

  @api_key Application.get_env(:poloniex, :api_key)
  @secret Application.get_env(:poloniex, :secret)

  setup do
    on_exit fn ->
      Application.put_env(:poloniex, :api_key, @api_key)
      Application.put_env(:poloniex, :secret, @secret)
    end
  end

  test "returns an authentication error when forbidden" do
    Application.put_env(:poloniex, :api_key, "api_key")
    Application.put_env(:poloniex, :secret, "secret")

    assert Poloniex.HTTP.post("tradingApi", "returnBalances") == {
      :error,
      %Poloniex.AuthenticationError{message: "Invalid API key/secret pair."}
    }
  end
end
