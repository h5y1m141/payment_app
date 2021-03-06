class RequestCancellationShipping
  class << self
    def execute(order_id)
      # NOTE: 注文キャンセルは現状単にリクエストを受け付けるだけを想定仕様にしてる
      # そのためShippingのキャンセル注文受け付け相当のレコードだけ作成すればよい。
      # キャンセルに伴う在庫調整はcancellation_completeの処理時に行う
      shipping_state = ShippingState.find_by(
        order_id: order_id
      )
      if shipping_state.shipping_request?
        shipping_state.ship_cancel_request!
      else
        shipping_state.ship_decline_request!
      end
      shipping_state
    end
  end
end
