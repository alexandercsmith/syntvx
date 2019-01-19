class StaticController < ApplicationController
  before_action :set_query,      only: %i[directory]
  before_action :set_defaults,  only: %i[directory]

  # /
  def index
    @articles = Article.all_featured
    @tools = Tool.all_recent
    public_seo('Home', root_url)
  end

  # /directory
  def directory
    @_languages = Language.directory_filter(params[:languages])
    @_categories = Category.directory_filter(params[:categories])
    @tools = Tool.directory_search(@query, params[:q], @_languages, @_categories, params[:page])
    public_seo('Directory', directory_url)
  end

  # /terms-and-conditions
  def terms
    public_seo('Terms & Conditions', terms_url)
  end

  # /privacy-policy
  def policy
    public_seo('Privacy Policy', policy_url)
  end

  private

  def set_query
    @query = if params[:q] || params[:languages] || params[:categories]
               true
             else
               false
             end
  end

  def set_defaults
    @languages = Language.all_approved
    @categories = Category.all_approved
  end

end
