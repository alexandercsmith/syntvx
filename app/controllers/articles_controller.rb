class ArticlesController < ApplicationController
  before_action :set_language, except: %i[index new create show]
  before_action :authenticate_admin!, except: %i[index show]

  # GET /articles
  def index
    @articles = Article.all
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
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /articles/:id
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /articles/:id
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
    end
  end

  private

    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:name, :slug, :description, :body,
                                      :published, :published_at, :featured, :deleted,
                                      :style)
    end

end
