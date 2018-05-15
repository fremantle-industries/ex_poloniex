defmodule ExPoloniex.PostTrading do
  def post(command, params) do
    ExPoloniex.HTTP.post("tradingApi", command, params)
  end

  def post(command) do
    post(command, %{})
  end
end
