defmodule ExPoloniex.Sell do
  @moduledoc false

  import ExPoloniex.Order
  alias ExPoloniex.Api

  def sell(pair, rate, amount, order_type) do
    params = build_params(pair, rate, amount, order_type)

    "sell"
    |> Api.trading(params)
    |> parse_response
  end
end
