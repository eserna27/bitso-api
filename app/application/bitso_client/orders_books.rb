module BitsoClient
  class OrdersBooks
    attr_reader :success, :asks, :updated_at, :bids

    def initialize(order_books)
      @success = order_books["success"]
      @asks = order_books["payload"]["asks"].map{|ask| AskResponse.new(ask)}
      @updated_at = order_books["payload"]["updated_at"]
      @bids = order_books["payload"]["bids"].map{|bid| BidResponse.new(bid)}
    end

    private

    class AskResponse
      attr_reader :book, :price, :amount, :oid
      def initialize(ask)
        @book = ask["book"]
        @price = ask["price"]
        @amount = ask["amount"]
        @oid = ask["oid"]
      end
    end

    class BidResponse
      attr_reader :book, :price, :amount, :oid
      def initialize(bid)
        @book = bid["book"]
        @price = bid["price"]
        @amount = bid["amount"]
        @oid = bid["oid"]
      end
    end
  end
end
