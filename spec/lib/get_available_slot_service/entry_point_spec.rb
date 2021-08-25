# frozen_string_literal: true

require 'spec_helper'

RSpec.describe GetAvailableSlotService::EntryPoint do
  subject { described_class.new(params: params).call }

  let(:params) do
    {
      date: '2020-12-07',
      address: 'street-10/7',
      time_period: '2'
    }
  end

  it 'produces the result' do
    subject
  end
end
