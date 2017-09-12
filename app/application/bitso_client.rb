require_relative 'bitso_client/books_response'
require_relative 'bitso_client/tickers_response'
require_relative 'bitso_client/orders_books'
require_relative 'bitso_client/trades_books'
require_relative 'bitso_client/ticker_response'
require 'rest-client'

module BitsoClient
  def self.availiable_books(bitso_store = BitsoStore)
    BooksResponse.new(build_response(bitso_store.availiable_books))
  end

  def self.ticker_all(bitso_store = BitsoStore)
    TickersResponse.new(build_response(bitso_store.ticker_all))
  end

  def self.orders_by_book(bitso_store = BitsoStore, book)
    OrdersBooks.new(build_response(bitso_store.orders_by_book(book)))
  end

  def self.trades_by_book(bitso_store = BitsoStore, book)
    TradesBooks.new(build_response(bitso_store.trades_by_book(book)))
  end

  def self.ticker_by_book(bitso_store = BitsoStore, book)
    TickerResponse.new_by_book(build_response(bitso_store.ticker_by_book(book)))
  end

  private

  def self.build_response(response)
    JSON.parse(response)
  end

  class BitsoStore
    def self.availiable_books
      response = RestClient.get "https://api.bitso.com/v3/available_books/"
      response.body
    end

    def self.ticker_all
      response = RestClient.get "https://api.bitso.com/v3/ticker/"
      response.body
    end

    def self.ticker_by_book(book)
      response = RestClient.get "https://api.bitso.com/v3/ticker/?book=#{book}"
      response.body
    end

    def self.orders_by_book(book)
      response = RestClient.get "https://api.bitso.com/v3/order_book/?book=#{book}"
      response.body
    end

    def self.trades_by_book(book)
      response = RestClient.get "https://api.bitso.com/v3/trades/?book=#{book}"
      response.body
    end
  end
end
