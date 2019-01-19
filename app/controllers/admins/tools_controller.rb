class Admins::ToolsController < Admins::AdminAppController
  before_action :set_tool,       only: %i[info edit]
  before_action :set_languages,  only: %i[new edit]
  before_action :set_categories, only: %i[new edit]

  # GET /admins/tools
  def index
    private_seo('Tools')
    @all = Tool.all_active.count
    @published = Tool.all_published.count
    @drafts = Tool.all_drafts.count
    @featured = Tool.all_featured.count
    @tools = Tool.admin_search(params[:term], params[:filter], params[:page])
  end

  # GET /admins/tools/trash
  def trash
    private_seo('Tools Trash')
    @tools = Tool.all_inactive.paginate(per_page: 25, page: params[:page])
    render template: 'admins/tools/index'
  end

  # GET /admins/tool/:id
  def info
    private_seo('Tool')
  end

  # GET /admins/tools/new
  def new
    private_seo('New Tool')
    @tool = Tool.new
  end

  # GET /admins/tools/:id/edit
  def edit
    private_seo('Edit Tool')
  end

  private

  def set_tool
    @tool = Tool.friendly.include_assoc.find(params[:id])
  end

  def set_languages
    @languages = Language.all_approved
  end

  def set_categories
    @categories = Category.all_approved
  end

  def admin_tools_responder(notice)
    respond_to do |format|
      format.html { redirect_to admins_tools_path }
      format.js
    end
  end

end
