module IoStore
  class ApplicationController < ActionController::Base
    layout IoStore.layout

    include IoStore::ApplicationHelper

    before_filter :pre_extend, :extract_cart

    def pre_extend
    end

  end
end
