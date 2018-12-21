class Admins::ArticlesController < Admins::AdminAppController
  # before_action :set_article, only: %i[]

  # GET /admins/articles
  def index
    private_seo('Articles')
    @articles = Article.admin_search(params[:term], params[:page])
  end

  private

    def set_article
      @article = Article.friendly.find(params[:id])
    end

    def admin_articles_responder(notice)
      respond_to do |format|
        format.html { redirect_to admins_articles_path }
        format.js
      end
    end

end
