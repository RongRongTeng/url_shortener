# frozen_string_literal: true

module ApplicationHelper
  def to_short_url(path)
    "#{ENV['DNS_HOST']}#{path}"
  end
end
