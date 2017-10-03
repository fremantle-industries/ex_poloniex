defmodule Poloniex.HTTP do
  @base_url "https://poloniex.com"

  def get(path, command, params) do
    headers = []
    merged_params = Map.merge(%{command: command}, params)

    case HTTPoison.get(path |> url, headers, params: merged_params) do
      {:ok, %HTTPoison.Response{status_code: 200, body: response_body}} ->
        handle_ok(response_body)
      errors ->
        errors
    end
  end

  def post(path, command, params) do
    param_pairs = Enum.map params, fn {key, value} ->
      "#{key}=#{value}"
    end
    post_body = ["nonce=#{nonce()}", "command=#{command}" | param_pairs]
                |> Enum.join("&")
    headers = post_body |> sign_post_headers

    case HTTPoison.post(path |> url, post_body, headers) do
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
      {:ok, %{"error" => message}} ->
        {:error, message}
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

  defp sign_post_headers(body) do
    [
      {"Content-Type", "application/x-www-form-urlencoded"},
      {"Key", key() },
      { "Sign", sign(body) }
    ]
  end
end
