# frozen_string_literal: true

require 'spec_helper'

RSpec.describe GetAvailableSlotService::EntryPoint do
  subject { described_class.new(params).call }

  let(:params) { { date: Date.parse('2020-12-07'), address: 'street-10/7', time_period: '2' } }
  let(:booked_slots_adapter) { GetAvailableSlotService::Adapters::BookedSlots }

  let(:booked_slots) do
    [
      { date: '2020-12-07', time_period: '1', zone: 'A', address: 'street-10/7' },
      { date: '2020-12-07', time_period: '1', zone: 'A', address: 'street-23/3' },
      { date: '2020-12-07', time_period: '2', zone: 'A', address: 'street-1/6' },
      { date: '2020-12-07', time_period: '2', zone: 'A', address: 'street-1/57' },
      { date: '2020-12-07', time_period: '3', zone: 'A', address: 'street-5/7' }
    ]
  end

  before do
    expect(booked_slots_adapter).to receive(:new).and_return(double(call: booked_slots))
  end

  it 'returns the result' do
    expect(subject).to have_attributes(
      date: '2020-12-07', 
      time_period: '3'
    )
  end
end
