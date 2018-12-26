class LanguagesController < ApplicationController
  before_action :set_language, except: %i[new create]
  before_action :authenticate_admin!

  # GET /languages/new
  def new
    @language = Language.new
    private_seo('New Language')
  end

  # GET /languages/:id/edit
  def edit
    private_seo('Edit Language')
  end

  # POST /languages
  def create
    @language = Language.new(language_params)

    if @language.save
      admins_languages_responder('created')
    else
      render :new
    end
  end

  # PATCH/PUT /languages/:id
  def update
    if @language.update(language_params)
      admins_languages_responder('updated')
    else
      render :edit
    end
  end

  # PATCH/PUT /languages/:id/approve
  def approve
    @language.approval_toggle
    admins_languages_responder(@language.approval_check.capitalize)
  end

  # PATCH/PUT /languages/:id/feature
  def feature
    @language.feature_toggle
    admins_languages_responder(@language.featured_check.capitalize)
  end

  # PATCH/PUT /languages/:id/delete
  def delete
    @langauge.delete_toggle
    admins_languages_responder(@language.deletion_check.capitalize)
  end

  # DESTROY /languages/:id
  def destroy
    @language.destroy
    admins_languages_responder('destroyed')
  end

  private

    def set_language
      @language = Language.friendly.include_assoc.find(params[:id])
    end

    def language_params
      params.require(:language).permit(:name, :slug, :description,
                                       :approved, :featured, :deleted,
                                       :style)
    end

    def admins_languages_responder(notice)
      respond_to do |format|
        format.html do
          redirect_to admins_languages_path,
          notice: "Language #{notice}."
        end
        format.js
      end
    end

end
