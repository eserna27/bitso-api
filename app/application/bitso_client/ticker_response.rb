module BitsoClient
  class TickerResponse
    attr_reader :book, :volume, :high, :last, :low,
      :vwap, :ask, :bid, :created_at, :success
    def initialize(ticker)
      @book = ticker["book"]
      @volume = ticker["volume"]
      @high = ticker["high"]
      @last = ticker["last"]
      @low = ticker["low"]
      @vwap = ticker["vwap"]
      @ask = ticker["ask"]
      @bid = ticker["bid"]
      @created_at = ticker["created_at"]
      @success = ticker["success"]
    end

    def self.new_by_book(response)
      new(build_ticker(response))
    end

    private

    def self.build_ticker(response)
      {
        "success" => response["success"]
      }.merge(response["payload"])
    end
  end
end
