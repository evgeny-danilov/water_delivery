# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Enumerable do
  describe '#by_count' do
    subject { array.count_by { |item| item[:email] } }

    let(:array) do
      [
        { id: 1, email: 'adam@mail.com' },
        { id: 2, email: 'ben@mail.com' },
        { id: 3, email: 'cris@mail.com' },
        { id: 4, email: 'cris@mail.com' }
      ]
    end

    it 'returns hash with counted items' do
      expect(subject).to eq({
                              'adam@mail.com' => 1,
                              'ben@mail.com' => 1,
                              'cris@mail.com' => 2
                            })
    end
  end
end
