defmodule Poloniex.AuthenticationError do
  @enforce_keys [:message]
  defstruct [:message]
end
