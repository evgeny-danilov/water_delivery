# frozen_string_literal: true

module GetAvailableSlotService
  module ValueObjects
    class Slot
      def initialize(date:, time_period:, zone_name:)
        @date = date
        @time_period = time_period
        @zone_name = zone_name
      end

      attr_reader :date, :time_period, :zone_name
    end
  end
end
