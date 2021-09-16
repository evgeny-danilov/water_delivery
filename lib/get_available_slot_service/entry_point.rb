# frozen_string_literal: true

module GetAvailableSlotService
  class EntryPoint
    def initialize(user_request:)
      @user_request = Forms::UserRequest.new(user_request)
    end

    def call
      ValueObjects::AvailableSlot.new(closest_available_slot_key || new_slot)
    end

    private

    attr_reader :user_request

    def closest_available_slot_key
      available_slots.keys.first
    end

    def new_slot
      slot_key(user_request)
    end
    
    def available_slots
      Slot.all
        .select(&method(:by_user_request))
        .count_by(&method(:slot_key))
        .select(&method(:less_than_two_booked_slots))
    end

    def by_user_request(slot)
      slot.date == user_request.date &&
        slot.time_period >= user_request.time_period
    end

    def slot_key(slot)
      [slot.date, slot.time_period].join(Constants::SLOT_KEY_SPLITTER)
    end

    def less_than_two_booked_slots(_slot_key, count)
      count < 2
    end
  end
end
