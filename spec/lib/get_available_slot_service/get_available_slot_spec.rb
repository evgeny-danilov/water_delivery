# frozen_string_literal: true

require 'spec_helper'

RSpec.describe GetAvailableSlotService::GetAvailableSlot do
  subject { described_class.new(orders: orders, user_request: user_request) }

  let(:orders) do
    [
      { date: '2020-12-07', time_period: '1', zone: 'A', address: 'street-10/7' },
      { date: '2020-12-07', time_period: '1', zone: 'A', address: 'street-23/3' },
      { date: '2020-12-07', time_period: '2', zone: 'A', address: 'street-1/6' },
      { date: '2020-12-07', time_period: '2', zone: 'A', address: 'street-1/57' },
      { date: '2020-12-07', time_period: '3', zone: 'A', address: 'street-5/7' }
    ]
  end

  let(:user_request) do
    double(date: Date.today, time_period: time_period)
  end

  it 'returns available slot' do
    expect(subject).to eq()
  end
end