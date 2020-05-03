# frozen_string_literal: true

class LinkForm < BaseForm
  extend ActiveModel::Callbacks

  delegate :link_customs, to: :link

  define_model_callbacks :save, only: :after

  validates_presence_of :original_url
  validates_format_of   :custom_path,
                        with: /\A[A-Za-z]{2}[\w-]*\z/,
                        message: 'must start from 2 letters and accept letters, numbers, underscores and dashes only',
                        if: -> { custom_path.present? }

  with_options if: -> { original_url.present? } do
    validates_format_of :original_url, without: /\A#{ENV['DNS_HOST']}/,
                                       message: 'is already a short url'
    validate :valid_url?
    validate :validate_uniqueness_of_custom_path
  end

  attr_accessor :link, :original_url, :short_path, :custom_path, :link_custom

  after_save :set_short_path

  def attributes=(attrs)
    @original_url = attrs[:original_url]
    @custom_path  = attrs[:custom_path]

    @link = Link.find_or_initialize_by(original_url: @original_url)
    return if @link.short_path == @custom_path

    return unless @custom_path.present?

    @link_custom = link_customs.find_or_initialize_by(short_path: @custom_path)
  end

  def save
    run_callbacks :save do
      !changed? || (valid? && @link.save)
    end
  end

  private

  def valid_url?
    uri = URI.parse(original_url)
    return if uri.is_a?(URI::HTTP) && !uri.host.nil?

    errors.add(:original_url, 'is not a url')
  end

  def validate_uniqueness_of_custom_path
    return unless (Link.all.pluck(:short_path) + LinkCustom.all.pluck(:short_path)).include?(custom_path)

    errors.add(:custom_path, 'has already been taken')
  end

  def changed?
    @link.changed? || @link_custom&.changed?
  end

  def set_short_path
    @short_path = @custom_path.present? ? @custom_path : @link.short_path
  end
end
