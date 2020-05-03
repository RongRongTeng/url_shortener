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
FactoryBot.define do
  factory :link do
    original_url { 'https://orginal_long_long_long_long_long_url.test' }
    click_count { 0 }
  end
end
