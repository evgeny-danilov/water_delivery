# frozen_string_literal: true

module GetAvailableSlotService
  module GetZoneStrategies
    class Minsk

      def applicable?(zone_name)
        zone_name.start_with?('Berlin, ')
      end

      def zone_name
        'GMT+3'
      end

      # More methods here, due to business requests
    end
  end
end
