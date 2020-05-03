# frozen_string_literal: true

require './containing_sevens'

describe 'g' do
  subject { g(num) }

  context 'when input is 1' do
    let(:num) { 1 }

    it 'returns count of numbers that contain a 7' do
      is_expected.to eq 0
    end
  end

  context 'when input is 20' do
    let(:num) { 20 }

    it 'returns count of numbers that contain a 7: [7, 17]' do
      is_expected.to eq 2
    end
  end

  context 'when input is 70' do
    let(:num) { 70 }

    it 'returns count of numbers that contain a 7: [7, 17, 27, 37, 47, 57, 67, 70]' do
      is_expected.to eq 8
    end
  end

  context 'when input is 100' do
    let(:num) { 100 }

    it 'returns count of numbers that contain a 7: [7, 17, 27, 37, 47, 57, 67, 70, 71-79, 87, 97]' do
      is_expected.to eq 19
    end
  end

  context 'when input is not integer' do
    let(:num) { 'string' }

    it 'raises error' do
      expect { subject }.to raise_error(ArgumentError, 'Input is not a integer')
    end
  end
end
