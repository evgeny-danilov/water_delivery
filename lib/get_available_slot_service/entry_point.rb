# frozen_string_literal: true

module GetAvailableSlotService
  class EntryPoint
    def initialize(params)
      @params = params
    end

    def call
      date, time_period = available_slot.keys.first.split('$')

      ValueObjects::SlotName.new(date: date, time_period: time_period)
    end

    private

    attr_reader :params

    def orders
      Order.all
    end

    def available_slot
      orders
        .select(&method(:by_user_request))
        .count_by(&method(:slot_name))
        .select(&method(:less_then_two_booked_slots))
    end

    def by_user_request(slot)
      params[:date] == slot[:date] &&
        params[:time_period] <= slot[:time_period]
    end

    def slot_name(slot)
      [slot[:date], slot[:time_period]].join('$')
    end

    def less_then_two_booked_slots(_, count)
      count < 2
    end
  end
end

# TODO: list
# 7. Add Value Object => ValueObjects::AvailableSlot(available_slots.keys.first)
# 8. Extract available slots logic into a separate class => AvailableSlots
# 9. Add Value Object => ValueObjects::UserRequest.new(date: date, time_period: time_period, address: address)
# 10. Add specs for AvailableSlots, using 'double' for UserRequest
# 11. Introduce working with zone dependency => slot[:zone] == Dependencies::GetZoneByAddress.call(address)
