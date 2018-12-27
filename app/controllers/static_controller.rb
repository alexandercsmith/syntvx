class StaticController < ApplicationController
  before_action :set_articles,   only: %i[index]
  before_action :set_languages,  only: %i[directory]
  before_action :set_categories, only: %i[directory]

  # /
  def index
    public_seo('Home', root_url)
  end

  # /directory
  def directory
    languages = params[:languages].presence ? Language.friendly.find(params[:languages]) : Language.all_approved
    categories = params[:categories].presence ? Category.friendly.find(params[:categories]) : Category.all_approved
    
    @tools = Tool.directory_search(params[:q], languages, categories)
    public_seo('Directory', directory_url)
  end

  private

    def set_articles
      @articles = Article.all_featured
    end

    def set_languages
      @languages = Language.all_approved
    end

    def set_categories
      @categories = Category.all_approved
    end

end
