class Admins::ArticlesController < Admins::AdminAppController
  before_action :set_article, only: %i[info edit]
  before_action :set_tags,    only: %i[new edit]

  # GET /admins/articles
  def index
    private_seo('Articles')
    @articles = Article.admin_search(params[:term], params[:filter], params[:page])
  end

  # GET /admins/articles/:id
  def info
    respond_to do |format|
      format.js
    end
  end

  # GET /admins/articles/new
  def new
    private_seo('New Article')
    @article = Article.new
  end

  # GET /admins/articles/:id/edit
  def edit
    private_seo('Edit Article')
  end

  private

  def set_article
    @article = Article.friendly.include_assoc.find(params[:id])
  end

  def set_tags
    @tags = Tag.all_approved
  end

  def admin_articles_responder(notice)
    respond_to do |format|
      format.html { redirect_to admins_articles_path }
      format.js
    end
  end

end
