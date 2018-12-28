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
    p params[:languages]
    p params[:categories]

    @s_languages = Language.directory_filter(params[:languages])
    @s_categories = Category.directory_filter(params[:categories])
    @tools = Tool.directory_search(params[:q], @s_languages, @s_categories, params[:page])
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
