class ArticlesController < ApplicationController
  before_action :authenticate_admin!, except: %i[index show]
  before_action :set_article,         except: %i[index tagged create show]
  before_action :set_tags,            except: %i[show publish feature delete]
  before_action :set_tag,             only: %i[tagged]

  # GET /blog
  def index
    @articles = Article.all_published
                       .paginate(per_page: 10,
                                 page: params[:page])
    public_seo('Blog', articles_url)
  end

  # GET /blog/tag/:id
  def tagged
    @articles = @tag.articles_published
                    .paginate(per_page: 10,
                              page: params[:page])
    public_seo('Blog', articles_url)
    render template: 'articles/index'
  end

  # GET /articles/:id
  def show
    @article = Article.slugged(params[:id])
    info_seo(@article.name.truncate(50), article_url(@article), @article.description)
  end

  # POST /articles
  def create
    @article = Article.new(article_params)
    if @article.save
      admins_article_responder('created')
    else
      render template: 'admins/articles/new', layout: 'admin'
    end
  end

  # PATCH/PUT /articles/:id
  def update
    if @article.update(article_params)
      admins_article_responder('updated')
    else
      render template: 'admins/articles/edit', layout: 'admin'
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

  def set_tag
    @tag = Tag.slugged(params[:id])
  end

  def set_tags
    @tags = Tag.all_approved
  end

  def article_params
    params.require(:article).permit(:name, :slug, :description, :body,
                                    :published, :published_at, :featured, :deleted,
                                    :style,
                                    :cover_image,
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
