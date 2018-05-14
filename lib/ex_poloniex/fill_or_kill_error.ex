defmodule ExPoloniex.FillOrKillError do
  @enforce_keys [:message]
  defstruct [:message]
end
