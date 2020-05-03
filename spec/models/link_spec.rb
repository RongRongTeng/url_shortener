# frozen_string_literal: true

# == Schema Information
#
# Table name: links
#
#  id           :bigint           not null, primary key
#  click_count  :integer          default(0), not null
#  original_url :text             not null
#  short_path   :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_links_on_original_url  (original_url) UNIQUE
#  index_links_on_short_path    (short_path) UNIQUE
#

RSpec.describe Link, type: :model do
  let(:link) { create :link }

  describe '#create' do
    subject { link }

    it 'creates link record in database' do
      expect { subject }.to change { Link.count }.from(0).to(1)
    end

    context 'before create callback' do
      before do
        allow(SecureRandom).to receive(:base58).and_return(random)
      end

      let(:random) { 'syb5JEq2YGwfi1nWkrRNogztCi' }

      it 'sets short_path' do
        subject
        expect(link.short_path).to eq 'syb5JEq2YGwfi1nWkrRNogztCi'
      end

      context 'short_path is not starts from 2 letters' do
        before do
          allow(Link::PREFIX_RANGE).to receive(:sample).and_return(%w[a b])
        end

        let(:random) { '11b5JEq2YGwfi1nWkrRNogztCi' }

        it 'append 2 lettes predix and sets short_path' do
          subject
          expect(link.short_path).to eq 'ab11b5JEq2YGwfi1nWkrRNogztCi'
        end
      end
    end
  end
end
