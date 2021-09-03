# frozen_string_literal: true

module GetAvailableSlotService
  class EntryPoint
    def initialize(params:)
      @params = params
    end

    def call
      ValueObjects::AvailableSlot.new(available_slots.keys.first || new_slot)
    end

    private

    attr_reader :params
    
    def new_slot
      slot_key(params)
    end

    def booked_slots
      Slot.all
    end

    def available_slots
      booked_slots
        .select(&method(:by_user_request))
        .count_by(&method(:slot_key))
        .select(&method(:less_than_two_booked_slots))
    end

    def by_user_request(slot)
      slot[:date] == params[:date] &&
        slot[:time_period] >= params[:time_period]
    end

    def slot_key(slot)
      [slot[:date], slot[:time_period]].join(Constants::SLOT_KEY_SPLITTER)
    end

    def less_than_two_booked_slots(_slot_key, count)
      count < 2
    end
  end
end
