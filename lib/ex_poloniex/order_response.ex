defmodule ExPoloniex.OrderResponse do
  @enforce_keys [:order_number, :resulting_trades]
  defstruct [:order_number, :resulting_trades, :amount_unfilled]
end
