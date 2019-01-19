class Admins::TagsController < Admins::AdminAppController
  before_action :set_tag, only: %i[info edit]

  # GET /admins/tags
  def index
    private_seo('Tags')
    @all = Tag.all_active.count
    @approved = Tag.all_approved.count
    @drafts = Tag.all_drafts.count
    @featured = Tag.all_featured.count
    @tags = Tag.admin_search(params[:term], params[:filter], params[:page])
  end

  # GET /admins/tags/trash
  def trash
    private_seo('Tags Trash')
    @tags = Tag.all_inactive.paginate(per_page: 25, page: params[:page])
    render template: 'admins/tags/index'
  end

  # GET /admins/tag/:id
  def info
    private_seo('Tag')
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
