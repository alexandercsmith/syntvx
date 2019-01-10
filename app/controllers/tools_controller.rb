class ToolsController < ApplicationController
  before_action :authenticate_admin!, except: %i[show]
  before_action :set_tool,            except: %i[create show]
  before_action :set_languages,       only: %i[create update destroy]
  before_action :set_categories,      only: %i[create update destroy]

  # GET /tools/:id
  def show
    @tool = Tool.slugged(params[:id])
    public_seo(@tool.name, tool_url(@tool))
  end

  # POST /tools
  def create
    @tool = Tool.new(tool_params)

    if @tool.save
      admins_tools_responder('created')
    else
      render template: 'admins/tools/new',
             layout: 'admin'
    end
  end

  # PATCH/PUT /tools/:id
  def update
    if @tool.update(tool_params)
      admins_tools_responder('updated')
    else
      render template: 'admins/tools/edit',
             layout: 'admin'
    end
  end

  # PATCH/PUT /tools/:id/publish
  def publish
    @tool.publish_toggle
    admins_tools_responder(@tool.published_check.capitalize)
  end

  # PATCH/PUT /tools/:id/feature
  def feature
    @tool.feature_toggle
    admins_tools_responder(@tool.featured_check.capitalize)
  end

  # PATCH/PUT /tools/:id/delete
  def delete
    @tool.delete_toggle
    admins_tools_responder(@tool.deletion_check.capitalize)
  end

  # DESTROY /tools/:id
  def destroy
    @tool.destroy
    admins_tools_responder('destroyed')
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
                                 :links, :website, :github,
                                 :style,
                                 :language_ids => [],
                                 :category_ids => [])
  end

  def admins_tools_responder(notice)
    respond_to do |format|
      format.html do
        redirect_to admins_tools_path,
        notice: "Tool #{notice}."
      end
      format.js
    end
  end

end
