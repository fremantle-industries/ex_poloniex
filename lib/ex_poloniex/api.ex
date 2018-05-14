defmodule ExPoloniex.Api do
  def trading(command, params) do
    ExPoloniex.HTTP.post("tradingApi", command, params)
  end

  def trading(command) do
    trading(command, %{})
  end
end
