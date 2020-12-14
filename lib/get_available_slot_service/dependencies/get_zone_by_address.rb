# frozen_string_literal: true

module GetAvailableSlotService
  module Dependencies
    class GetZoneByAddress
      def self.call(_address)
        raise NotImplemented
      end
    end
  end
end
