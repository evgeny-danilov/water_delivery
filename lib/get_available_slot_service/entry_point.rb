# frozen_string_literal: true

module GetAvailableSlotService
  class EntryPoint

    STRATEGIES = {
      minsk: GetZoneNameDependencied::MinskStrategy,
      berlin: GetZoneNameDependencied::BerlinStrategy,
    }.freeze

    def initialize(params)
      @user_request = ValueObjects::UserRequestForm.new(params)
    end

    def call
      date, time_period = available_slot.keys.first.split('$')

      ValueObjects::Slot.new(date: date, time_period: time_period)
    end

    private

    attr_reader :user_request

    def orders
      Order.all
    end

    def available_slot
      GetAvailableSlot.new(orders: orders, user_request: user_request).call
    end

    def time_zone_strategy
      if user_request.zone.start_with?('Minsk, ')
        STRATEGIES[:minsk]
      elsif user_request.zone.start_with?('Berlin, ')
        STRATEGIES[:berlin]
      else
        raise NotImplementedError
      end
    end

  end
end
