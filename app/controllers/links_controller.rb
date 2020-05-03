# frozen_string_literal: true

class LinksController < BaseController
  class RedirectError < StandardError; end

  before_action :set_link, only: :show

  rescue_from RedirectError, with: :redirect_url_not_found

  def index
    @form = LinkForm.new
    return unless params[:commit]

    @form.attributes = link_params
    @form.save
  end

  def show
    @link.increment!(:click_count)
    redirect_to @link.original_url
  end

  private

  def link_params
    params.require(:link_form).permit(:original_url, :custom_path)
  end

  def redirect_url_not_found
    set_flash_message('Redirect url not found', :error)
    redirect_to root_path
  end

  def set_link
    [Link, LinkCustom].each do |klass|
      @link = klass.find_by(short_path: params[:short_path])

      return @link if @link
    end

    raise RedirectError if @link.nil?
  end
end
