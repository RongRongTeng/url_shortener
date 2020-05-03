# frozen_string_literal: true

# == Schema Information
#
# Table name: link_customs
#
#  id          :bigint           not null, primary key
#  click_count :integer          default(0), not null
#  short_path  :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  link_id     :bigint           not null
#
# Indexes
#
#  index_link_customs_on_link_id     (link_id)
#  index_link_customs_on_short_path  (short_path) UNIQUE
#
FactoryBot.define do
  factory :link_custom do
    association :link, strategy: :build
    sequence(:short_path) { |n| "short_path_#{n}" }
  end
end
