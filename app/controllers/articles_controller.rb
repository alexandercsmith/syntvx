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

    respond_to do |format|
      if @article.save
        format.html { redirect_to admins_articles_path, notice: 'Article was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /articles/:id
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to admins_articles_path, notice: 'Article was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # PATCH/PUT /articles/:id/publish
  def publish
    @article.publish_toggle
    respond_to do |format|
      format.html do
        redirect_to admins_articles_path,
        notice: "Article #{@article.published_check.capitalize}"
      end
      format.js
    end
  end

  # PATCH/PUT /articles/:id/feature
  def feature
    @article.feature_toggle
    respond_to do |format|
      format.html do
        redirect_to admins_articles_path,
        notice: "Article #{@article.featured_check.capitalize}"
      end
      format.js
    end
  end

  # PATCH/PUT /articles/:id/delete
  def delete
    @article.delete_toggle
    respond_to do |format|
      format.html do
        redirect_to admins_articles_path,
        notice: "Article #{@article.deletion_check.capitalize}"
      end
      format.js
    end
  end

  # DESTROY /articles/:id
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
    end
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

end
