module Admin
  class BaseController < ApplicationController
    layout "admin"

    before_action :set_breadcrumbs

    private

    def set_breadcrumbs
      @breadcrumbs = []
    end

    def add_breadcrumb(name, path = nil)
      @breadcrumbs << { name: name, path: path }
    end
  end
end
