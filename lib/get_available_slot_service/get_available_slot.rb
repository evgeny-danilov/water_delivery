# frozen_string_literal: true

module GetAvailableSlotService
  class GetAvailableSlot
    def initialize(orders:, user_request:)
      @user_request = user_request
      @orders = orders
    end

    def call
      orders
        .select(&method(:by_user_request))
        .count_by(&method(:slot_name))
        .select(&method(:less_then_two_booked_slots))
    end

    private

    attr_reader :user_request, :orders

    def by_user_request(slot)
      user_request.date == slot[:date] &&
        user_request.time_period <= slot[:time_period]
    end

    def slot_name(slot)
      [slot[:date], slot[:time_period]].join('$')
    end

    def less_then_two_booked_slots(_, count)
      count < 2
    end
  end
end
