# frozen_string_literal: true

module GetAvailableSlotService
  class EntryPoint
    def initialize(params:)
      @params = params
    end

    def call
      # byebug
      available_slot_params = available_slots.keys.first.split('$')

      { date: available_slot_params.first, time_period: available_slot_params.last }
    end

    private

    attr_reader :params

    def booked_slots
      Slot.all
    end

    def available_slots
      booked_slots
        .select { |slot| slot[:date] == params[:date] && slot[:time_period] >= params[:time_period] }
        .count_by { |slot| [slot[:date], slot[:time_period]].join('$') }
        .select { |_slot_key, count| count < 2 }
    end
  end
end
