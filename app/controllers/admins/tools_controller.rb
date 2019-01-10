class Admins::ToolsController < Admins::AdminAppController
  before_action :set_tool,       only: %i[info edit]
  before_action :set_languages,  only: %i[new edit]
  before_action :set_categories, only: %i[new edit]

  # GET /admins/tools
  def index
    private_seo('Tools')
    @tools = Tool.admin_search(params[:term], params[:filter], params[:page])
  end

  # GET /admins/tools/:id
  def info
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
