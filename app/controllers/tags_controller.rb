class TagsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_tag, except: %i[create]

  # POST /tags
  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      admins_tags_responder('created')
    else
      render template: 'admins/tags/new', layout: 'admin'
    end
  end

  # PATCH/PUT /tags/:id
  def update
    if @tag.update(tag_params)
      admins_tags_responder('updated')
    else
      render template: 'admins/tags/edit', layout: 'admin'
    end
  end

  # PATCH/PUT /tags/:id/approve
  def approve
    @tag.approval_toggle
    admins_tags_responder(@tag.approval_check.capitalize)
  end

  # PATCH/PUT /tags/:id/feature
  def feature
    @tag.feature_toggle
    admins_tags_responder(@tag.featured_check.capitalize)
  end

  # PATCH/PUT /tags/:id/delete
  def delete
    @tag.delete_toggle
    admins_tags_responder(@tag.deletion_check.capitalize)
  end

  # DESTROY /tags/:id
  def destroy
    @tag.destroy
    admins_tags_responder('destroyed')
  end

  private

  def set_tag
    @tag = Tag.friendly.include_assoc.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name, :slug, :description,
                                :approved, :featured, :deleted,
                                :style)
  end

  def admins_tags_responder(notice)
    respond_to do |format|
      format.html do
        redirect_to admins_tags_path,
        notice: "Tag #{notice}."
      end
      format.js
    end
  end

end
