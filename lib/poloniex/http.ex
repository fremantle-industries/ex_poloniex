defmodule Poloniex.HTTP do
  @base_url "https://poloniex.com"

  def get(path, command) do
    headers = []
    case HTTPoison.get(path |> url, headers, params: %{command: command}) do
      {:ok, %HTTPoison.Response{status_code: 200, body: response_body}} ->
        handle_ok(response_body)
      errors ->
        errors
    end
  end

  def post(path, command) do
    post_body = create_post_body(command)

    case HTTPoison.post(path |> url, post_body, post_body |> headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: response_body}} ->
        handle_ok(response_body)
      {:ok, %HTTPoison.Response{status_code: 403, body: response_body}} ->
        handle_forbidden(response_body)
      errors ->
        errors
    end
  end

  defp handle_ok(response_body) do
    case response_body |> JSON.decode do
      {:ok, body} ->
        {:ok, body}
      errors ->
        errors
    end
  end

  defp handle_forbidden(response_body) do
    case response_body |> JSON.decode do
      {:ok, %{"error" => message}} ->
        {:error, %Poloniex.AuthenticationError{message: message}}
      errors ->
        errors
    end
  end

  defp url(path) do
    "#{@base_url}/#{path}"
  end

  defp nonce do
    :os.system_time
  end

  defp sign(text) do
    :crypto.hmac(:sha512, secret(), text) |> Base.encode16
  end

  defp key do
    Application.get_env(:poloniex, :api_key)
  end

  defp secret() do
    Application.get_env(:poloniex, :secret)
  end

  defp create_post_body(command) do
    "nonce=#{nonce()}&command=#{command}"
  end

  defp headers(body) do
    [
      {"Content-Type", "application/x-www-form-urlencoded"},
      {"Key", key() },
      { "Sign", sign(body) }
    ]
  end
end
