# frozen_string_literal: true

require 'spec_helper'

RSpec.describe GetAvailableSlotService::Forms::UserRequest do
  subject { described_class.new(params) }

  let(:params) do
    {
      date: '2020-12-07',
      address: 'street-10/7',
      time_period: '2'
    }
    end

  it 'generates a form object with a proper values', :aggregate_failures do
    expect(subject.date).to eq('2020-12-07')
    expect(subject.address).to eq('street-10/7')
    expect(subject.time_period).to eq('2')
  end
end
