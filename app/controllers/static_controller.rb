class StaticController < ApplicationController
  before_action :set_articles,   only: %i[index]
  before_action :set_tools,      only: %i[index]
  before_action :set_query,      only: %i[directory]
  before_action :set_languages,  only: %i[directory]
  before_action :set_categories, only: %i[directory]

  # /
  def index
    public_seo('Home', root_url)
  end

  # /directory
  def directory
    @s_languages = Language.directory_filter(params[:languages])
    @s_categories = Category.directory_filter(params[:categories])
    @tools = Tool.directory_search(@query, params[:q], @s_languages, @s_categories, params[:page])
    public_seo('Directory', directory_url)
  end

  private

  def set_articles
    @articles = Article.all_featured
  end

  def set_tools
    @tools = Tool.all_recent
  end

  def set_query
    @query = if params[:q].presence || params[:languages].presence || params[:categories].presence
               true
             else
               false
             end
  end

  def set_languages
    @languages = Language.all_approved
  end

  def set_categories
    @categories = Category.all_approved
  end

end
