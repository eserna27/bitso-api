module BitsoClient
  class BooksResponse
    attr_reader :success, :payloads

    def initialize(availiable_books)
      @success = availiable_books["success"]
      @payloads = availiable_books["payload"].map { |book| BookResponse.new(book) }
    end

    private
    class BookResponse
      attr_reader :book, :minimum_amount, :maximum_amount, :minimum_price,
        :maximum_price, :minimum_value, :maximum_value

      def initialize(book)
        @book = book["book"]
        @minimum_amount = book["minimum_amount"]
        @maximum_amount = book["maximum_amount"]
        @minimum_price = book["minimum_price"]
        @maximum_price = book["maximum_price"]
        @minimum_value = book["minimum_value"]
        @maximum_value = book["maximum_value"]
      end
    end
  end
end
