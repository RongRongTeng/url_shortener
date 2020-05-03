# frozen_string_literal: true

class BaseController < ApplicationController
  private

  def set_flash_message(text = 'Process Completedly', type = :notice)
    flash[type] = text
  end
end
