module Transaction
  module PaidBy
    class Base
      attr_reader :order

      def initialize
        @order = order
      end

      def start
        raise NotImplementedError
      end
    end
  end
end
