# frozen_string_literal: true

module GetAvailableSlotService
  class EntryPoint
    def initialize(params)
      @params = params
    end

    def call
      ValueObjects::AvailableSlot.new(closest_available_slot_key)
    end

    private

    attr_reader :params

    def closest_available_slot_key
      available_slots.keys.first
    end

    def booked_slots
      @booked_slots ||= Adapters::BookedSlots.new.call
    end

    def available_slots
      booked_slots
        .count_by(&method(:slot_key))
        .select(&method(:less_than_two_booked_slots))
    end

    def slot_key(item)
      [item[:date], item[:time_period]].join('/')
    end

    def less_than_two_booked_slots(_, count)
      count < 2
    end
  end
end
