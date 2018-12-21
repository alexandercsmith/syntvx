class LanguagesController < ApplicationController
  before_action :set_language, except: %i[index new create show]
  before_action :authenticate_admin!, except: %i[index show]

  # GET /languages
  def index
    @languages = Language.all_approved
  end

  # GET /languages/:id
  def show
    redirect_to languages_path unless @language.approved
    @language = Language.slugged(params[:id])
  end

  # GET /languages/new
  def new
    @language = Language.new
  end

  # GET /languages/:id/edit
  def edit
  end

  # POST /languages
  def create
    @language = Language.new(language_params)

    respond_to do |format|
      if @language.save
        format.html { redirect_to admins_languages_path, notice: 'Language was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /languages/:id
  def update
    respond_to do |format|
      if @language.update(language_params)
        format.html { redirect_to admins_languages_path, notice: 'Language was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # PATCH/PUT /languages/:id/approve
  def approve
    @language.approval_toggle
    respond_to do |format|
      format.html do
        redirect_to admins_languages_path,
        notice: "Language #{@language.approval_check.capitalize}"
      end
      format.js
    end
  end

  # PATCH/PUT /languages/:id/feature
  def feature
    @language.feature_toggle
    respond_to do |format|
      format.html do
        redirect_to admins_languages_path,
        notice: "Language #{@language.featured_check.capitalize}"
      end
      format.js
    end
  end

  # PATCH/PUT /languages/:id/delete
  def delete
    @langauge.delete_toggle
    respond_to do |format|
      format.html do
        redirect_to admins_languages_path,
        notice: "Language #{@language.deletion_check.capitalize}"
      end
      format.js
    end
  end

  # DESTROY /languages/:id
  def destroy
    @language.destroy
    respond_to do |format|
      format.html { redirect_to languages_url, notice: 'Language was successfully destroyed.' }
    end
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

    def admin_languages_responder(notice)
    end

end
