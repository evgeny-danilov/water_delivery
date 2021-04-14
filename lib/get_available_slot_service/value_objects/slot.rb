# frozen_string_literal: true

module ValueObjects
  class Slot
    def initialize(date:, time_period:)
      @date = date
      @time_period = time_period
    end

    attr_reader :date, :time_period
  end
end
