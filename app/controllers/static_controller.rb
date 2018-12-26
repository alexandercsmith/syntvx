class StaticController < ApplicationController
  # /
  def index
    public_seo('Home', root_url)
  end

  # /directory
  def directory
    public_seo('Directory', directory_url)
  end

  private

    def set_articles
      @articles = Article.all_featured
    end

    def set_tools
      @tools = Tool.all_featured
    end
    
end
