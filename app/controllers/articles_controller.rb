class ArticlesController < ApplicationController
  before_action :set_article, except: %i[index new create show]
  before_action :set_tags, only: %i[new edit create update destroy]
  before_action :authenticate_admin!, except: %i[index show]

  # GET /articles
  def index
    @articles = Article.all_published
  end

  # GET /articles/:id
  def show
    @article = Article.slugged(params[:id])
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/:id/edit
  def edit
  end

  # POST /articles
  def create
    @article = Article.new(article_params)
    if @article.save
      admins_article_responder('created')
    else
      render :new
    end
  end

  # PATCH/PUT /articles/:id
  def update
    if @article.update(article_params)
      admins_article_responder('updated')
    else
      render :edit
    end
  end

  # PATCH/PUT /articles/:id/publish
  def publish
    @article.publish_toggle
    admins_article_responder(@article.published_check.capitalize)
  end

  # PATCH/PUT /articles/:id/feature
  def feature
    @article.feature_toggle
    admins_article_responder(@article.featured_check.capitalize)
  end

  # PATCH/PUT /articles/:id/delete
  def delete
    @article.delete_toggle
    admins_article_responder(@article.deletion_check.capitalize)
  end

  # DESTROY /articles/:id
  def destroy
    @article.destroy
    admins_article_responder('destroyed')
  end

  private

    def set_article
      @article = Article.friendly.include_assoc.find(params[:id])
    end

    def set_tags
      @tags = Tag.all_approved
    end

    def article_params
      params.require(:article).permit(:name, :slug, :description, :body,
                                      :published, :published_at, :featured, :deleted,
                                      :style,
                                      :tag_ids => [])
    end

    def admins_article_responder(notice)
      respond_to do |format|
        format.html do
          redirect_to admins_articles_path,
          notice: "Article #{notice}."
        end
        format.js
      end
    end
end
