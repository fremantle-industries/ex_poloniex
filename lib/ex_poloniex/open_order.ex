defmodule ExPoloniex.OpenOrder do
  @enforce_keys [:amount, :date, :margin, :order_number, :rate, :starting_amount, :total, :type]
  defstruct [:amount, :date, :margin, :order_number, :rate, :starting_amount, :total, :type]
end
