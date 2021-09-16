# frozen_string_literal: true

module GetAvailableSlotService
  module Forms
    class UserRequest
      def initialize(params)
        @params = params
      end
      
      def date
        params[:date]
      end

      def time_period
        params[:time_period]
      end

      def address
        params[:address]
      end
      
      private

      attr_reader :params
    end
  end
end
