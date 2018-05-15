defmodule ExPoloniex.DepositsAndWithdrawals do
  @enforce_keys [:deposits, :withdrawals]
  defstruct [:deposits, :withdrawals]
end
