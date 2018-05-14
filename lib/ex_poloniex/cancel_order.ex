defmodule ExPoloniex.CancelOrder do
  alias ExPoloniex.{Api, InvalidOrderNumberError}

  def cancel_order(order_number) do
    case Api.trading("cancelOrder", orderNumber: order_number) do
      {:ok, %{"success" => 1, "amount" => amount_str}} ->
        {amount, ""} = Float.parse(amount_str)
        {:ok, amount}

      {:error, "Invalid order number" <> _ = reason} ->
        {:error, %InvalidOrderNumberError{message: reason}}

      {:error, "Invalid orderNumber parameter" <> _ = reason} ->
        {:error, %InvalidOrderNumberError{message: reason}}

      {:error, _} = error ->
        error
    end
  end
end
