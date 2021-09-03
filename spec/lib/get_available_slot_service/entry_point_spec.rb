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

  let(:slots) do
    [
      { date: '2020-12-07', time_period: '1', zone: 'A', address: 'street-10/7' },
      { date: '2020-12-07', time_period: '1', zone: 'A', address: 'street-23/3' },
      { date: '2020-12-07', time_period: '2', zone: 'A', address: 'street-1/6' },
      { date: '2020-12-07', time_period: '2', zone: 'A', address: 'street-1/57' },
      { date: '2020-12-07', time_period: '3', zone: 'A', address: 'street-5/7' }
    ]
  end

  before do
    expect(Slot).to receive(:all).and_return(slots)
  end

  it 'produces the result' do
    expect(subject).to have_attributes(date: '2020-12-07', time_period: '3')
  end

  context 'when there is no booked slots within the request parameters' do
    let(:params) { { date: '2020-12-08', time_period: '2', address: 'street-5/7' } }

    it 'returns the result' do
      expect(subject).to have_attributes(date: '2020-12-08', time_period: '2')
    end
  end
end
