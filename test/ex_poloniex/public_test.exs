defmodule ExPoloniex.PublicTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  use Timex
  doctest ExPoloniex.Public

  setup_all do
    HTTPoison.start()
  end

  test "return_ticker" do
    use_cassette "return_ticker" do
      {:ok, ticker} = ExPoloniex.Public.return_ticker()

      btc_eth = ticker["BTC_ETH"]
      assert btc_eth["baseVolume"] == "2614.12332326"
      assert btc_eth["high24hr"] == "0.07006446"
      assert btc_eth["highestBid"] == "0.06815003"
      assert btc_eth["id"] == 148
      assert btc_eth["isFrozen"] == "0"
      assert btc_eth["last"] == "0.06815003"
      assert btc_eth["low24hr"] == "0.06771983"
      assert btc_eth["lowestAsk"] == "0.06819298"
    end
  end

  test "return_24h_volume" do
    use_cassette "return_24h_volume" do
      {:ok, volume} = ExPoloniex.Public.return_24h_volume()

      assert volume["BTC_ETH"] == %{"BTC" => "3310.97290886", "ETH" => "48516.34110835"}
      assert volume["totalBTC"] == "16429.79923551"
      assert volume["totalETH"] == "5505.89292550"
      assert volume["totalUSDT"] == "32328513.94307584"
      assert volume["totalXMR"] == "549.96018989"
      assert volume["totalXUSD"] == "0.00000000"
    end
  end

  test "return_order_book" do
    use_cassette "return_order_book" do
      {:ok, order_book} = ExPoloniex.Public.return_order_book("BTC_ETH")

      assert order_book["asks"] == [
               ["0.06716000", 1.03],
               ["0.06727275", 65.565],
               ["0.06727276", 6.29186772],
               ["0.06727279", 14.439],
               ["0.06727280", 2.35688552],
               ["0.06727281", 13.81370862],
               ["0.06727318", 0.00301699],
               ["0.06728068", 0.00361111],
               ["0.06729505", 0.00361111],
               ["0.06729517", 0.00361111],
               ["0.06730122", 12.2],
               ["0.06731202", 0.06148164],
               ["0.06731597", 0.00361111],
               ["0.06733768", 0.00361111],
               ["0.06734190", 54.87829645],
               ["0.06734191", 11],
               ["0.06734192", 23.14671495],
               ["0.06734193", 12.96],
               ["0.06735758", 0.00361111],
               ["0.06736055", 9.47135689],
               ["0.06736516", 0.0018704],
               ["0.06737552", 27.52166417],
               ["0.06737849", 14],
               ["0.06738890", 0.00403879],
               ["0.06740920", 0.02995956],
               ["0.06741517", 13.8],
               ["0.06742079", 0.00361111],
               ["0.06742611", 0.04929268],
               ["0.06743454", 0.25966002],
               ["0.06743563", 0.3411668],
               ["0.06744396", 11],
               ["0.06744400", 0.13],
               ["0.06744714", 0.14492026],
               ["0.06744984", 0.00361111],
               ["0.06746291", 0.00223126],
               ["0.06747328", 0.00190564],
               ["0.06748301", 91.71432141],
               ["0.06748308", 12.7],
               ["0.06748329", 35],
               ["0.06748560", 0.00404578],
               ["0.06748684", 0.0474077],
               ["0.06749001", 0.5],
               ["0.06749303", 0.06927824],
               ["0.06749963", 0.04564137],
               ["0.06750000", 4.57978942],
               ["0.06750110", 0.06154312],
               ["0.06750271", 4.75627742],
               ["0.06751523", 11],
               ["0.06751616", 0.05207674],
               ["0.06751757", 0.08119897]
             ]

      assert order_book["bids"] == [
               ["0.06709109", 19.05],
               ["0.06709098", 12.08860663],
               ["0.06708500", 1.46959979],
               ["0.06707640", 56.21009948],
               ["0.06707639", 26.29281892],
               ["0.06705248", 13.75],
               ["0.06701377", 0.11744422],
               ["0.06701373", 3.40747329],
               ["0.06700102", 3.2028075],
               ["0.06700101", 0.61705734],
               ["0.06700100", 100.299424],
               ["0.06700009", 0.01641818],
               ["0.06700006", 0.01492535],
               ["0.06700003", 240.50116996],
               ["0.06700002", 8.10683847],
               ["0.06700001", 308.09025413],
               ["0.06700000", 277.36641582],
               ["0.06699900", 0.29851191],
               ["0.06699862", 0.040503],
               ["0.06699794", 0.00361111],
               ["0.06699566", 0.08355945],
               ["0.06699559", 1.26511155],
               ["0.06699438", 0.05985783],
               ["0.06699341", 0.34331735],
               ["0.06699127", 0.02055626],
               ["0.06698884", 0.18408417],
               ["0.06698415", 11.52],
               ["0.06698288", 0.07923012],
               ["0.06697770", 0.005],
               ["0.06697761", 0.07968],
               ["0.06697257", 0.00361111],
               ["0.06697250", 0.00361111],
               ["0.06697242", 0.00361111],
               ["0.06696827", 0.00528132],
               ["0.06696076", 0.00297939],
               ["0.06695498", 0.08],
               ["0.06695349", 0.00361111],
               ["0.06695253", 0.00361111],
               ["0.06695247", 0.00361111],
               ["0.06694575", 12],
               ["0.06694283", 0.25545724],
               ["0.06693557", 0.07968],
               ["0.06693456", 0.07687],
               ["0.06693320", 0.00361111],
               ["0.06693086", 0.07470396],
               ["0.06692791", 0.29999664],
               ["0.06691853", 6.05],
               ["0.06691771", 12.09],
               ["0.06691438", 0.88968584],
               ["0.06691436", 0.07968]
             ]
    end
  end

  test "return_trade_history" do
    use_cassette "return_trade_history" do
      end_time = %DateTime{
        year: 2017,
        month: 9,
        day: 13,
        hour: 0,
        minute: 0,
        second: 0,
        time_zone: "Etc/UTC",
        zone_abbr: "UTC",
        utc_offset: 0,
        std_offset: 0
      }

      start_time = Timex.shift(end_time, minutes: -1)

      {:ok, trade_history} =
        ExPoloniex.Public.return_trade_history(
          "BTC_ETH",
          start_time |> Timex.to_unix(),
          end_time |> Timex.to_unix()
        )

      assert trade_history == [
               %{
                 "amount" => "0.00723166",
                 "date" => "2017-09-12 23:59:54",
                 "globalTradeID" => 229_967_282,
                 "rate" => "0.07069798",
                 "total" => "0.00051126",
                 "tradeID" => 34_131_329,
                 "type" => "sell"
               },
               %{
                 "amount" => "0.00723166",
                 "date" => "2017-09-12 23:59:53",
                 "globalTradeID" => 229_967_281,
                 "rate" => "0.07069798",
                 "total" => "0.00051126",
                 "tradeID" => 34_131_328,
                 "type" => "sell"
               },
               %{
                 "amount" => "0.04276834",
                 "date" => "2017-09-12 23:59:30",
                 "globalTradeID" => 229_967_231,
                 "rate" => "0.07070000",
                 "total" => "0.00302372",
                 "tradeID" => 34_131_327,
                 "type" => "sell"
               },
               %{
                 "amount" => "0.00723166",
                 "date" => "2017-09-12 23:59:26",
                 "globalTradeID" => 229_967_197,
                 "rate" => "0.07070000",
                 "total" => "0.00051127",
                 "tradeID" => 34_131_326,
                 "type" => "sell"
               },
               %{
                 "amount" => "0.37160827",
                 "date" => "2017-09-12 23:59:04",
                 "globalTradeID" => 229_967_135,
                 "rate" => "0.07069798",
                 "total" => "0.02627195",
                 "tradeID" => 34_131_325,
                 "type" => "sell"
               },
               %{
                 "amount" => "9.29112585",
                 "date" => "2017-09-12 23:59:03",
                 "globalTradeID" => 229_967_128,
                 "rate" => "0.07080000",
                 "total" => "0.65781171",
                 "tradeID" => 34_131_324,
                 "type" => "sell"
               },
               %{
                 "amount" => "0.07481250",
                 "date" => "2017-09-12 23:59:03",
                 "globalTradeID" => 229_967_127,
                 "rate" => "0.07080000",
                 "total" => "0.00529672",
                 "tradeID" => 34_131_323,
                 "type" => "sell"
               },
               %{
                 "amount" => "18.17192550",
                 "date" => "2017-09-12 23:59:03",
                 "globalTradeID" => 229_967_126,
                 "rate" => "0.07080000",
                 "total" => "1.28657232",
                 "tradeID" => 34_131_322,
                 "type" => "sell"
               },
               %{
                 "amount" => "0.08819070",
                 "date" => "2017-09-12 23:59:02",
                 "globalTradeID" => 229_967_124,
                 "rate" => "0.07080000",
                 "total" => "0.00624390",
                 "tradeID" => 34_131_321,
                 "type" => "sell"
               }
             ]
    end
  end

  test "return_chart_data" do
    use_cassette "return_chart_data" do
      end_time = %DateTime{
        year: 2017,
        month: 9,
        day: 13,
        hour: 0,
        minute: 0,
        second: 0,
        time_zone: "Etc/UTC",
        zone_abbr: "UTC",
        utc_offset: 0,
        std_offset: 0
      }

      start_time = Timex.shift(end_time, minutes: -1)
      period = 60 * 5

      {:ok, chart_data} =
        ExPoloniex.Public.return_chart_data(
          "BTC_ETH",
          start_time |> Timex.to_unix(),
          end_time |> Timex.to_unix(),
          period
        )

      assert chart_data == [
               %{
                 "date" => 1_505_260_800,
                 "close" => 0.07046265,
                 "high" => 0.07069999,
                 "low" => 0.07046023,
                 "open" => 0.07069999,
                 "quoteVolume" => 415.12451229,
                 "volume" => 29.26998702,
                 "weightedAverage" => 0.07050893
               }
             ]
    end
  end

  test "return_currencies" do
    use_cassette "return_currencies" do
      {:ok, currencies} = ExPoloniex.Public.return_currencies()

      assert currencies["BTC"] == %{
               "delisted" => 0,
               "depositAddress" => nil,
               "disabled" => 0,
               "frozen" => 0,
               "id" => 28,
               "minConf" => 1,
               "name" => "Bitcoin",
               "txFee" => "0.00010000"
             }
    end
  end

  test "return_loan_orders" do
    use_cassette "return_loan_orders" do
      {:ok, loan_orders} = ExPoloniex.Public.return_loan_orders("BTC")

      assert loan_orders["offers"] == [
               %{
                 "amount" => "0.06082129",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00009400"
               },
               %{
                 "amount" => "0.04624417",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00016900"
               },
               %{
                 "amount" => "0.01082583",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00018200"
               },
               %{
                 "amount" => "0.79881157",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00018298"
               },
               %{
                 "amount" => "0.21753644",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00018300"
               },
               %{
                 "amount" => "0.01234734",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00018311"
               },
               %{
                 "amount" => "26.98376291",
                 "rangeMax" => 5,
                 "rangeMin" => 2,
                 "rate" => "0.00018400"
               },
               %{
                 "amount" => "0.10000000",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00018411"
               },
               %{
                 "amount" => "0.14886679",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00018500"
               },
               %{
                 "amount" => "0.01017261",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00018535"
               },
               %{
                 "amount" => "0.09163315",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00018583"
               },
               %{
                 "amount" => "0.01017261",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00018670"
               },
               %{
                 "amount" => "0.31616918",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00018700"
               },
               %{
                 "amount" => "0.01360315",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00018766"
               },
               %{
                 "amount" => "0.07468414",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00018800"
               },
               %{
                 "amount" => "0.01017261",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00018805"
               },
               %{
                 "amount" => "0.14827176",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00018826"
               },
               %{
                 "amount" => "0.01315578",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00018850"
               },
               %{
                 "amount" => "0.09163315",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00018866"
               },
               %{
                 "amount" => "0.10278310",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00018900"
               },
               %{
                 "amount" => "0.01146844",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00018908"
               },
               %{
                 "amount" => "0.04376107",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00018926"
               },
               %{
                 "amount" => "0.01017261",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00018940"
               },
               %{
                 "amount" => "0.05801464",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00018950"
               },
               %{
                 "amount" => "5.99924596",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00019000"
               },
               %{
                 "amount" => "0.05082075",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00019026"
               },
               %{
                 "amount" => "0.29132729",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00019050"
               },
               %{
                 "amount" => "0.02488117",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00019075"
               },
               %{
                 "amount" => "0.10000000",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00019089"
               },
               %{
                 "amount" => "0.34850090",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00019100"
               },
               %{
                 "amount" => "0.06384558",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00019110"
               },
               %{
                 "amount" => "0.01189183",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00019133"
               },
               %{
                 "amount" => "0.09163315",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00019150"
               },
               %{
                 "amount" => "0.03050000",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00019191"
               },
               %{
                 "amount" => "4.86990098",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00019200"
               },
               %{
                 "amount" => "0.01017261",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00019210"
               },
               %{
                 "amount" => "0.13571300",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00019221"
               },
               %{
                 "amount" => "0.20836338",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00019226"
               },
               %{
                 "amount" => "0.03352386",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00019250"
               },
               %{
                 "amount" => "0.03160021",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00019271"
               },
               %{
                 "amount" => "0.00078130",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00019299"
               },
               %{
                 "amount" => "0.86627333",
                 "rangeMax" => 7,
                 "rangeMin" => 2,
                 "rate" => "0.00019300"
               },
               %{
                 "amount" => "0.01017261",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00019345"
               },
               %{
                 "amount" => "0.06384558",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00019363"
               },
               %{
                 "amount" => "0.53101233",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00019380"
               },
               %{
                 "amount" => "0.01135270",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00019400"
               },
               %{
                 "amount" => "0.01470856",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00019425"
               },
               %{
                 "amount" => "0.09163315",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00019433"
               },
               %{
                 "amount" => "0.01017261",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00019480"
               },
               %{
                 "amount" => "4.52832466",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00019500"
               }
             ]

      assert loan_orders["demands"] == [
               %{
                 "amount" => "0.02640978",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00006010"
               },
               %{
                 "amount" => "0.72449126",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00001000"
               },
               %{
                 "amount" => "0.90950000",
                 "rangeMax" => 2,
                 "rangeMin" => 2,
                 "rate" => "0.00000300"
               }
             ]
    end
  end
end
