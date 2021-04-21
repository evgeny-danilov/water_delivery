# frozen_string_literal: true

module GetAvailableSlotService
  class EntryPoint

    ZONE_STRATEGIES = [
      GetZoneStrategies::Minsk,
      GetZoneStrategies::Berlin,
    ].freeze

    def initialize(params)
      @user_request = ValueObjects::UserRequestForm.new(params)
    end

    def call
      date, time_period = available_slot.keys.first.split('$')

      ValueObjects::Slot.new(date: date, time_period: time_period, zone_name: zone_name)
    end

    private

    attr_reader :user_request

    def orders
      Order.all
    end

    def available_slot
      GetAvailableSlot.new(orders: orders, user_request: user_request).call
    end

    def zone_name
      get_zone_strategy&.zone_name || 'undefined'
    end

    def get_zone_strategy
      ZONE_STRATEGIES
        .map(&:new)
        .detect { _1.applicable?(user_request.address) }
    end

  end
end
