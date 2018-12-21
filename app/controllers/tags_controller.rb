class TagsController < ApplicationController
  before_action :set_tag, except: %i[index new create show]
  before_action :authenticate_admin!, except: %i[index show]

  # GET /tags
  def index
    @tags = Tag.all_approved
  end

  # GET /tags/:id
  def show
    @tag = Tag.slugged(params[:id])
  end

  # GET /tags/new
  def new
    @tag = Tag.new
  end

  # GET /tags/:id/edit
  def edit
  end

  # POST /tags
  def create
    @tag = Tag.new(tag_params)

    respond_to do |format|
      if @tag.save
        format.html { redirect_to @tag, notice: 'Tag was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /tags/:id
  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to @tag, notice: 'Tag was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # PATCH/PUT /tags/:id/approve
  def approve
    @tag.approval_toggle
    respond_to do |format|
      format.html { redirect_to admins_tags_path }
      format.js
    end
  end

  # PATCH/PUT /tags/:id/feature
  def feature
    @tag.feature_toggle
    respond_to do |format|
      format.html { redirect_to admins_tags_path }
      format.js
    end
  end

  # PATCH/PUT /tags/:id/delete
  def delete
    @tag.delete_toggle
    respond_to do |format|
      format.html { redirect_to admins_tags_path }
      format.js
    end
  end

  # DESTROY /tags/:id
  def destroy
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to tags_url, notice: 'Tag was successfully destroyed.' }
    end
  end

  private

    def set_tag
      @tag = Tag.find(params[:id])
    end

    def tag_params
      params.require(:tag).permit(:name, :slug, :description,
                                  :approved, :featured, :deleted,
                                  :style)
    end

    def admin_tags_responder(notice)
    end

end
