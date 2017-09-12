require_relative "ticker_response"
module BitsoClient
  class TickersResponse
    attr_reader :success, :payloads

    def initialize(ticker)
      @success = ticker["success"]
      @payloads = ticker["payload"].map{|ticker| TickerResponse.new(ticker)}
    end
  end
end
