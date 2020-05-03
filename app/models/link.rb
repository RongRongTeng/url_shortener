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
class Link < ApplicationRecord
  PREFIX_RANGE = Array('a'..'z')

  has_many :link_customs, dependent: :destroy

  before_create :generate_short_path

  private

  def generate_short_path
    self.short_path = random_short_path_algorithm
  end

  def random_short_path_algorithm
    short_path = SecureRandom.base58(24)
    return short_path if short_path.start_with?(/[a-zA-Z]{2}/)

    "#{PREFIX_RANGE.sample(2).join}#{short_path}"
  end
end
