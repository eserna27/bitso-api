require 'spec_helper'
require_relative "../../app/application/bitso_client"
require 'json'

module BitsoClient
  RSpec.describe "availiable books" do
    attr_reader :books

    before do
      bitso_store = BitsoStoreFake.new
      @books = BitsoClient.availiable_books(bitso_store)
    end

    it "should recive success" do
      expect(books.success).to eq (true)
    end

    it "should recive books" do
      expect(books.payloads.map(&:book)).to eq (["btc_mxn", "eth_mxn"])
      expect(books.payloads.map(&:minimum_amount)).to eq ([".003", ".003"])
      expect(books.payloads.map(&:maximum_amount)).to eq (["1000.00", "1000.00"])
      expect(books.payloads.map(&:minimum_price)).to eq (["100.00", "100.0"])
      expect(books.payloads.map(&:maximum_price)).to eq (["1000000.00", "1000000.0"])
      expect(books.payloads.map(&:minimum_value)).to eq (["25.00", "25.0"])
      expect(books.payloads.map(&:maximum_value)).to eq (["1000000.00", "1000000.0"])
    end
  end

  RSpec.describe "ticker all info" do
    attr_reader :ticker

    before do
      bitso_store = BitsoStoreFake.new
      @ticker = BitsoClient.ticker_all(bitso_store)
    end

    it "should recive success" do
      expect(ticker.success).to eq (true)
    end

    it "should recive ticker" do
      expect(ticker.payloads.map(&:book)).to eq (["btc_mxn"])
      expect(ticker.payloads.map(&:volume)).to eq (["22.31349615"])
      expect(ticker.payloads.map(&:high)).to eq (["5750.00"])
      expect(ticker.payloads.map(&:last)).to eq (["5633.98"])
      expect(ticker.payloads.map(&:low)).to eq (["5450.00"])
      expect(ticker.payloads.map(&:vwap)).to eq (["5393.45"])
      expect(ticker.payloads.map(&:ask)).to eq (["5632.24"])
      expect(ticker.payloads.map(&:bid)).to eq (["5520.01"])
      expect(ticker.payloads.map(&:created_at)).to eq (["2016-04-08T17:52:31.000+00:00"])
    end
  end

  RSpec.describe "ticker info by book" do
    attr_reader :ticker

    before do
      bitso_store = BitsoStoreFake.new
      book = "btc_mxn"
      @ticker = BitsoClient.ticker_by_book(bitso_store, book)
    end

    it "should recive success" do
      expect(ticker.success).to eq (true)
    end

    it "should recive ticker" do
      expect(ticker.book).to eq ("btc_mxn")
      expect(ticker.volume).to eq ("638.41494631")
      expect(ticker.high).to eq ("5897.00")
      expect(ticker.last).to eq ("5750.50")
      expect(ticker.low).to eq ("5700.00")
      expect(ticker.vwap).to eq ("5762.57352541")
      expect(ticker.ask).to eq ("5830.21")
      expect(ticker.bid).to eq ("5750.50")
      expect(ticker.created_at).to eq ("2017-09-09T21:26:00+00:00")
    end
  end

  RSpec.describe "order all books" do
    attr_reader :order_books

    before do
      bitso_store = BitsoStoreFake.new
      book = "btc_mxn"
      @order_books = BitsoClient.orders_by_book(bitso_store, book)
    end

    it "should recive success" do
      expect(order_books.success).to eq (true)
    end

    it "should have list of order" do
      expect(order_books.updated_at).to eq "2016-04-08T17:52:31.000+00:00"
      expect(order_books.asks.map(&:book)).to eq ["btc_mxn", "btc_mxn", "btc_mxn"]
      expect(order_books.asks.map(&:price)).to eq ["5632.24", "5633.44", "5642.14"]
      expect(order_books.asks.map(&:amount)).to eq ["1.34491802", "0.4259", "1.21642"]
      expect(order_books.asks.map(&:oid)).to eq ["VN5lVpgXf02o6vJ6", "RP8lVpgXf04o6vJ6", "46efbiv72drbphig"]
      expect(order_books.bids.map(&:book)).to eq ["btc_mxn", "btc_mxn"]
      expect(order_books.bids.map(&:price)).to eq ["6123.55", "6121.55"]
      expect(order_books.bids.map(&:amount)).to eq ["1.12560000", "2.23976"]
      expect(order_books.bids.map(&:oid)).to eq ["11brtiv72drbphig", "1ywri0yg8miihs80"]
    end
  end

  RSpec.describe "trades by book" do
    attr_reader :trades_books

    before do
      bitso_store = BitsoStoreFake.new
      book = "btc_mxn"
      @trades_books = BitsoClient.trades_by_book(bitso_store, book)
    end

    it "should recive success" do
      expect(trades_books.success).to eq (true)
    end

    it "should have trades" do
      expect(trades_books.trades.map(&:book)).to eq ["btc_mxn", "btc_mxn"]
      expect(trades_books.trades.map(&:created_at)).to eq ["2016-04-08T17:52:31.000+00:00", "2016-04-08T17:52:31.000+00:00"]
      expect(trades_books.trades.map(&:amount)).to eq ["0.02000000", "0.33723939"]
      expect(trades_books.trades.map(&:maker_side)).to eq ["buy", "sell"]
      expect(trades_books.trades.map(&:price)).to eq ["5545.01", "5633.98"]
      expect(trades_books.trades.map(&:tid)).to eq [55845, 55844]
    end
  end

  class BitsoStoreFake
    def availiable_books
      '{
        "success": true,
        "payload": [{
            "book": "btc_mxn",
            "minimum_amount": ".003",
            "maximum_amount": "1000.00",
            "minimum_price": "100.00",
            "maximum_price": "1000000.00",
            "minimum_value": "25.00",
            "maximum_value": "1000000.00"
        }, {
            "book": "eth_mxn",
            "minimum_amount": ".003",
            "maximum_amount": "1000.00",
            "minimum_price": "100.0",
            "maximum_price": "1000000.0",
            "minimum_value": "25.0",
            "maximum_value": "1000000.0"
        }]
      }'
    end

    def ticker_all
      '{
        "success": true,
        "payload": [{
            "book": "btc_mxn",
            "volume": "22.31349615",
            "high": "5750.00",
            "last": "5633.98",
            "low": "5450.00",
            "vwap": "5393.45",
            "ask": "5632.24",
            "bid": "5520.01",
            "created_at": "2016-04-08T17:52:31.000+00:00"
        }]
      }'
    end

    def orders_by_book(book)
      '{
        "success": true,
        "payload": {
            "asks": [{
                "book": "'+book+'",
                "price": "5632.24",
                "amount": "1.34491802",
                "oid": "VN5lVpgXf02o6vJ6"
            },{
                "book": "'+book+'",
                "price": "5633.44",
                "amount": "0.4259",
                "oid": "RP8lVpgXf04o6vJ6"
            },{
                "book": "'+book+'",
                "price": "5642.14",
                "amount": "1.21642",
                "oid": "46efbiv72drbphig"
            }],
            "bids": [{
                "book": "'+book+'",
                "price": "6123.55",
                "amount": "1.12560000",
                "oid": "11brtiv72drbphig"
            },{
                "book": "'+book+'",
                "price": "6121.55",
                "amount": "2.23976",
                "oid": "1ywri0yg8miihs80"
            }],
            "updated_at": "2016-04-08T17:52:31.000+00:00",
            "sequence": "27214"
        }
      }'
    end

    def trades_by_book(book)
      '{
        "success": true,
        "payload": [{
            "book": "'+book+'",
            "created_at": "2016-04-08T17:52:31.000+00:00",
            "amount": "0.02000000",
            "maker_side": "buy",
            "price": "5545.01",
            "tid": 55845
        }, {
            "book": "'+book+'",
            "created_at": "2016-04-08T17:52:31.000+00:00",
            "amount": "0.33723939",
            "maker_side": "sell",
            "price": "5633.98",
            "tid": 55844
        }]
      }'
    end

    def ticker_by_book(book)
      '{
        "success": true,
        "payload": {
          "high": "5897.00",
          "last": "5750.50",
          "created_at": "2017-09-09T21:26:00+00:00",
          "book": "'+book+'",
          "volume": "638.41494631",
          "vwap": "5762.57352541",
          "low": "5700.00",
          "ask": "5830.21",
          "bid": "5750.50"
        }
      }'
    end
  end
end
