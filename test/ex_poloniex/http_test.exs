defmodule ExPoloniex.HTTPTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExPoloniex.HTTP

  @api_key Application.get_env(:poloniex, :api_key)
  @secret Application.get_env(:poloniex, :secret)

  setup_all do
    HTTPoison.start()
    ExVCR.Config.cassette_library_dir("test/fixture/vcr_cassettes")
  end

  test "returns an authentication error when forbidden" do
    use_cassette "invalid_api_key_secret" do
      Application.put_env(:poloniex, :api_key, "api_key")
      Application.put_env(:poloniex, :secret, "secret")

      assert ExPoloniex.HTTP.post("tradingApi", "returnBalances", %{}) == {
               :error,
               %ExPoloniex.AuthenticationError{message: "Invalid API key/secret pair."}
             }

      Application.put_env(:poloniex, :api_key, @api_key)
      Application.put_env(:poloniex, :secret, @secret)
    end
  end
end
