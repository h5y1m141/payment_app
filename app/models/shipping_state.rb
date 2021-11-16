class ShippingState < ApplicationRecord
  belongs_to :order

  include AASM
  enum aasm_state: {
    shipping_request: 1,
    shipping_in_ready: 2,
    cancellation_request: 3,
    cancellation_complete: 4,
    shipping_complete: 5
  }

  aasm enum: true do
    state :shipping_request, initial: true
    state :shipping_in_ready
    state :cancellation_request
    state :cancellation_complete
    state :shipping_complete

    after_all_transitions :insert_shipping_record

    event :ship_ready do
      transitions from: :shipping_request, to: :shipping_in_ready
    end

    event :ship_complete do
      transitions from: :shipping_in_ready, to: :shipping_complete
    end

    event :ship_cancel do
      transitions from: :shipping_request, to: :cancellation_complete
    end

    event :ship_decline do
      transitions from: :shipping_in_ready, to: :cancellation_complete
    end


    event :cancel_complete do
      transitions from: :cancellation_request, to: :cancellation_complete
    end
  end

  private

  def insert_shipping_record
    puts "changing from #{aasm.from_state} to #{aasm.to_state} (event: #{aasm.current_event})"
    Shipping.create(
      order_id: order_id,
      status: Shipping.statuses[aasm.from_state]
    )
  end
end
