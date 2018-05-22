# ExPoloniex
[![Build Status](https://circleci.com/gh/fremantle-capital/ex_poloniex.svg?style=svg)](https://circleci.com/gh/fremantle-capital/ex_poloniex)

Elixir library for the Poloniex Public & Trade API

## Status

* Public API implemented
* Trading API in progress

- [x] returnBalances
- [x] returnCompleteBalances
- [x] returnDepositAddresses
- [x] generateNewAddress
- [x] returnDepositsWithdrawals
- [x] returnOpenOrders
- [x] returnFeeInfo
- [x] returnTradeHistory
- [x] returnOrderTrades
- [x] buy
- [x] sell
- [x] cancelOrder
- [ ] moveOrder
- [ ] withdraw
- [ ] returnAvailableAccountBalances
- [ ] returnTradableBalances
- [ ] transferBalance
- [ ] returnMarginAccountSummary
- [ ] marginBuy
- [ ] marginSell
- [ ] getMarginPosition
- [ ] closeMarginPosition
- [ ] closeLoanOffer
- [ ] createLoanOffer
- [ ] cancelLoanOffer
- [ ] returnOpenLoanOffers
- [ ] returnActiveLoans
- [ ] returnLendingHistory
- [ ] toggleAutoRenew

## Installation

Add `ex_poloniex` to your list of dependencies in mix.exs

```elixir
def deps do
  [
    {:ex_poloniex, "~> 0.0.4"}
  ]
end
```

## Configuration

Add the following configuration variables in your `config/config.exs` file:

```elixir
use Mix.Config

config :ex_poloniex,
  api_key: "YOUR_API_KEY",
  api_secret: "YOUR_API_SECRET"
```

## Additional Links

[Poloniex API Docs](https://poloniex.com/support/api/)

## License

`ex_poloniex` is released under the [MIT license](./LICENSE.md)
