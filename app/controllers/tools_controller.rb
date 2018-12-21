class ToolsController < ApplicationController
  before_action :set_tool, except: %i[index new create show]
  before_action :set_languages, only: %i[new edit create update destroy]
  before_action :set_categories, only: %i[new edit create update destroy]
  before_action :authenticate_admin!, except: %i[index show]

  # GET /tools
  def index
    @tools = Tool.all
  end

  # GET /tools/:id
  def show
    @tool = Tool.slugged(params[:id])
  end

  # GET /tools/new
  def new
    @tool = Tool.new
  end

  # GET /tools/:id/edit
  def edit
  end

  # POST /tools
  def create
    @tool = Tool.new(tool_params)

    respond_to do |format|
      if @tool.save
        format.html { redirect_to @tool, notice: 'Tool was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /tools/:id
  def update
    respond_to do |format|
      if @tool.update(tool_params)
        format.html { redirect_to @tool, notice: 'Tool was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # PATCH/PUT /tools/:id/publish
  def publish
    @tool.publish_toggle
    respond_to do |format|
      format.html do
        redirect_to admins_tools_path,
        notice: "Tool #{@tool.published_check.capitalize}"
      end
      format.js
    end
  end

  # PATCH/PUT /tools/:id/feature
  def feature
    @tool.feature_toggle
    respond_to do |format|
      format.html do
        redirect_to admins_tools_path,
        notice: "Tool #{@tool.featured_check.capitalize}"
      end
      format.js
    end
  end

  # PATCH/PUT /tools/:id/delete
  def delete
    @tool.delete_toggle
    respond_to do |format|
      format.html do
        redirect_to admins_tools_path,
        notice: "Tool #{@tool.deletion_check.capitalize}"
      end
      format.js
    end
  end

  # DESTROY /tools/:id
  def destroy
    @tool.destroy
    respond_to do |format|
      format.html { redirect_to tools_url, notice: 'Tool was successfully destroyed.' }
    end
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

    def tool_params
      params.require(:tool).permit(:name, :slug, :description,
                                   :published, :published_at, :featured, :deleted,
                                   :links, :style,
                                   :language_ids => [],
                                   :category_ids => [])
    end

    def admin_tools_responder(notice)
    end

end
