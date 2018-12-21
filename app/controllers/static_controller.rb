class StaticController < ApplicationController
  # /
  def index
    public_seo('Home', root_url)
  end

  # /directory
  def directory
    public_seo('Directory', directory_url)
  end
end
