# frozen_string_literal: true

module GetAvailableSlotService
  class EntryPoint
    def initialize(params)
      @params = params
    end

    def call
      return unless closest_available_slot_key

      ValueObjects::AvailableSlot.new(closest_available_slot_key)
    end

    private

    attr_reader :params

    def closest_available_slot_key
      @closest_available_slot_key ||= available_slots.keys.first
    end

    def booked_slots
      @booked_slots ||= Adapters::BookedSlots.new.call
    end

    def available_slots
      booked_slots
        .select(&method(:by_user_request))
        .count_by(&method(:slot_key))
        .select(&method(:less_than_two_booked_slots))
    end

    def by_user_request(slot)
      slot[:zone] == requested_zone(params[:address]) &&
        Date.parse(slot[:date]) == params[:date] &&
        slot[:time_period].to_i >= params[:time_period].to_i
    end

    def slot_key(slot)
      [slot[:date], slot[:time_period], slot[:zone]].join('$')
    end

    def less_than_two_booked_slots(_, count)
      count < 2
    end

    def requested_zone(address)
      Dependencies::GetZoneByAddress.call(address)
    end
  end
end
