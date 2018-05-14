defmodule ExPoloniex.Buy do
  @moduledoc false

  import ExPoloniex.Order
  alias ExPoloniex.Api

  def buy(pair, rate, amount, order_type) do
    params = build_params(pair, rate, amount, order_type)

    "buy"
    |> Api.trading(params)
    |> parse_response
  end
end
