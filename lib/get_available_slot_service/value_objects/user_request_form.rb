# frozen_string_literal: true

module GetAvailableSlotService
  module ValueObjects
    class UserRequestForm
      def initialize(params)
        @params = params
      end

      attr_reader :params

      def date
        params[:date]
      end

      def time_period
        params[:time_period]
      end

      def address
        params[:address]
      end
    end
  end
end
