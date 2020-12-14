# frozen_string_literal: true

module GetAvailableSlotService
  module ValueObjects
    class AvailableSlot
      def initialize(slot_key)
        @date, @time_period, @zone = slot_key.split('$')
      end

      attr_reader :date, :time_period, :zone
    end
  end
end
