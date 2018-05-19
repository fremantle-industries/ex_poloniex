defmodule ExPoloniex.ReturnFeeInfo do
  alias ExPoloniex.Api

  def return_fee_info do
    case Api.trading("returnFeeInfo") do
      {:ok, open_orders} -> {:ok, open_orders}
      {:error, _} = error -> error
    end
  end
end
