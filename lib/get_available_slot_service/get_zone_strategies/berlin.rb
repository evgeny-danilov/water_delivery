# frozen_string_literal: true

module GetAvailableSlotService
  module GetZoneStrategies
    class Berlin

      def applicable?(address)
        address.start_with?('Minsk, ')
      end

      def zone_name
        'GMT+1'
      end

      # More methods here, due to business requests
    end
  end
end
