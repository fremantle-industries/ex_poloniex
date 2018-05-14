defmodule ExPoloniex.PostOnlyError do
  @enforce_keys [:message]
  defstruct [:message]
end
