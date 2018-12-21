class StaticController < ApplicationController
  # /
  def index
    public_seo('Home', root_url)
  end
end
