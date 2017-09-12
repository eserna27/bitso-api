module BitsoClient
  class TradesBooks
    attr_reader :success, :trades

    def initialize(trades)
      @success = trades["success"]
      @trades = trades["payload"].map{|trade| TradeBook.new(trade)}
    end

    private

    class TradeBook
      attr_reader :book, :created_at, :amount, :maker_side, :price, :tid

      def initialize(trade)
        @book = trade["book"]
        @created_at = trade["created_at"]
        @amount = trade["amount"]
        @maker_side = trade["maker_side"]
        @price = trade["price"]
        @tid = trade["tid"]
      end
    end
  end
end
