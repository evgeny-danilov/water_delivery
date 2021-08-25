# frozen_string_literal: true

module GetAvailableSlotService
  class EntryPoint
    def initialize(params:)
      @params = params
    end

    def call
      byebug
    end

    private

    attr_reader :params
  end
end
