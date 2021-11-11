module Operations
  class RequestCancellationShipping
    class << self
      def execute(order_id)
        # NOTE: 注文キャンセルは現状単にリクエストを受け付けるだけを想定仕様にしてる
        # そのためShippingのキャンセル注文受け付け相当のレコードだけ作成すればよい。
        # キャンセルに伴う在庫調整はcancellation_completeの処理時に行う
        order = Order.find(order_id)
        Shipping.create(
          order: order,
          status: Shipping.statuses[:cancellation_request]
        )        
      end
    end
  end
end
