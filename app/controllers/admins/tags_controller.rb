class Admins::TagsController < Admins::AdminAppController
  before_action :set_tag, only: %i[info edit]

  # GET /admins/tags
  def index
    private_seo('Tags')
    @tags = Tag.admin_search(params[:term], params[:filter], params[:page])
  end

  # GET /admins/tag/:id
  def info
  end

  # GET /admins/tags/new
  def new
    private_seo('New Tag')
    @tag = Tag.new
  end

  # GET /admins/tags/:id/edit
  def edit
    private_seo('Edit Tag')
  end

  private

  def set_tag
    @tag = Tag.friendly.include_assoc.find(params[:id])
  end

  def admin_tags_responder(notice)
    respond_to do |format|
      format.html { redirect_to admins_tags_path }
      format.js
    end
  end

end
