defmodule ExPoloniex.HistoricalTrade do
  @enforce_keys [
    :amount,
    :category,
    :date,
    :fee,
    :global_trade_id,
    :order_number,
    :rate,
    :total,
    :trade_id,
    :type
  ]
  defstruct [
    :amount,
    :category,
    :date,
    :fee,
    :global_trade_id,
    :order_number,
    :rate,
    :total,
    :trade_id,
    :type
  ]
end
